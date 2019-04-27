Return-Path: <SRS0=j+PZ=S5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE116C43219
	for <iommu@archiver.kernel.org>; Sat, 27 Apr 2019 01:45:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D41208CB
	for <iommu@archiver.kernel.org>; Sat, 27 Apr 2019 01:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnp4kITl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D41208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C08821958;
	Sat, 27 Apr 2019 01:44:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DDDE112DE
	for <iommu@lists.linux-foundation.org>;
	Sat, 27 Apr 2019 01:43:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9EBED3D0
	for <iommu@lists.linux-foundation.org>;
	Sat, 27 Apr 2019 01:43:18 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
	[73.47.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id D90912168B;
	Sat, 27 Apr 2019 01:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329398;
	bh=PK+mpmAm7MUkBeFcoMfzY206FIHmnQKT5jAUS2yrLkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cnp4kITlg75W5ifoCgKzSY4YjP4ampfIGxKYeC7MB7arWFtqE0LxOl6mFOluDnilg
	IUxBo3Z8cg+S9/NvbK1u1lHt/ln3uFVWlGYRNqnYrAeRnEE1FpBcMlkwM0IJr4FSgb
	bo6WLW3a6RFPfQ3vZAWoCOwbuXbBXawxE+Dm3b3Y=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 30/32] iommu/amd: Set exclusion range correctly
Date: Fri, 26 Apr 2019 21:42:21 -0400
Message-Id: <20190427014224.8274-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014224.8274-1-sashal@kernel.org>
References: <20190427014224.8274-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, iommu@lists.linux-foundation.org,
	Joerg Roedel <jroedel@suse.de>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190427014221.NvcJP_2jKyB5ykkeBadAIyuWUvNTwAD2d8IMh0J3gko@z>

From: Joerg Roedel <jroedel@suse.de>

[ Upstream commit 3c677d206210f53a4be972211066c0f1cd47fe12 ]

The exlcusion range limit register needs to contain the
base-address of the last page that is part of the range, as
bits 0-11 of this register are treated as 0xfff by the
hardware for comparisons.

So correctly set the exclusion range in the hardware to the
last page which is _in_ the range.

Fixes: b2026aa2dce44 ('x86, AMD IOMMU: add functions for programming IOMMU MMIO space')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index b97984a5ddad..9b3d8fd5f7c1 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -355,7 +355,7 @@ static void iommu_write_l2(struct amd_iommu *iommu, u8 address, u32 val)
 static void iommu_set_exclusion_range(struct amd_iommu *iommu)
 {
 	u64 start = iommu->exclusion_start & PAGE_MASK;
-	u64 limit = (start + iommu->exclusion_length) & PAGE_MASK;
+	u64 limit = (start + iommu->exclusion_length - 1) & PAGE_MASK;
 	u64 entry;
 
 	if (!iommu->exclusion_start)
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
