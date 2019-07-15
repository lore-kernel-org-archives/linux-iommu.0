Return-Path: <SRS0=ehRZ=VM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEBDC7618F
	for <iommu@archiver.kernel.org>; Mon, 15 Jul 2019 14:01:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C311721530
	for <iommu@archiver.kernel.org>; Mon, 15 Jul 2019 14:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJAGaYfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C311721530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8B986E7F;
	Mon, 15 Jul 2019 14:01:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 91392E7E
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Jul 2019 14:01:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 42DB571C
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Jul 2019 14:01:34 +0000 (UTC)
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 2F91B217D9;
	Mon, 15 Jul 2019 14:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199294;
	bh=CSB78d8VQ4feoU4JwRr3dlatwl1DWkW0ll3nurdJ/58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BJAGaYfzshm4StsO40w4aXppPw0rhrNCrm58Xz6qA5IKuNlrrmv1oa5JD2mIRRzLz
	7hb+v/0TPoUqU/wjCZvTGkS8NmcaDTSlg8xsbXdVOeS7KqIwmFFzbhYiaQslNyoh3r
	RasA6UuFSMxmqUNrJedHm9DbtpFarGXjNR1orFZc=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 229/249] iommu/arm-smmu-v3: Invalidate ATC when
	detaching a device
Date: Mon, 15 Jul 2019 09:46:34 -0400
Message-Id: <20190715134655.4076-229-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, Joerg Roedel <jroedel@suse.de>,
	Manoj Kumar <Manoj.Kumar3@arm.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Robin Murphy <Robin.Murphy@arm.com>,
	iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

[ Upstream commit 8dd8f005bdd45823fc153ef490239558caf6ff20 ]

We make the invalid assumption in arm_smmu_detach_dev() that the ATC is
clear after calling pci_disable_ats(). For one thing, only enabling the
PCIe ATS capability constitutes an implicit invalidation event, so the
comment was wrong. More importantly, the ATS capability isn't necessarily
disabled by pci_disable_ats() in a PF, if the associated VFs have ATS
enabled. Explicitly invalidate all ATC entries in arm_smmu_detach_dev().
The endpoint cannot form new ATC entries because STE.EATS is clear.

Fixes: 9ce27afc0830 ("iommu/arm-smmu-v3: Add support for PCI ATS")
Reported-by: Manoj Kumar <Manoj.Kumar3@arm.com>
Reported-by: Robin Murphy <Robin.Murphy@arm.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4d5a694f02c2..0fee8f7957ec 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1884,9 +1884,13 @@ static int arm_smmu_enable_ats(struct arm_smmu_master *master)
 
 static void arm_smmu_disable_ats(struct arm_smmu_master *master)
 {
+	struct arm_smmu_cmdq_ent cmd;
+
 	if (!master->ats_enabled || !dev_is_pci(master->dev))
 		return;
 
+	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
+	arm_smmu_atc_inv_master(master, &cmd);
 	pci_disable_ats(to_pci_dev(master->dev));
 	master->ats_enabled = false;
 }
@@ -1906,7 +1910,6 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 	master->domain = NULL;
 	arm_smmu_install_ste_for_dev(master);
 
-	/* Disabling ATS invalidates all ATC entries */
 	arm_smmu_disable_ats(master);
 }
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
