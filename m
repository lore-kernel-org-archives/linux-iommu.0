Return-Path: <SRS0=11OQ=YX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B91CA9EC5
	for <iommu@archiver.kernel.org>; Wed, 30 Oct 2019 14:52:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B653F2054F
	for <iommu@archiver.kernel.org>; Wed, 30 Oct 2019 14:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbqeDhkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B653F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 794A4CB5;
	Wed, 30 Oct 2019 14:51:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6938DCAA
	for <iommu@lists.linux-foundation.org>;
	Wed, 30 Oct 2019 14:51:24 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 32E6542D
	for <iommu@lists.linux-foundation.org>;
	Wed, 30 Oct 2019 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
	[217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id AB7ED2087F;
	Wed, 30 Oct 2019 14:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572447084;
	bh=uJ+ONkF7na6HukF09Y5O+tCeYJzoiaeeldARCnkP778=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pbqeDhkOGkfRqL2AQ/1gpM9OKF9XhJuB/UP3bVnhIXyJzPuVTe/XN2YZT7US7Fbil
	rN3L5Ph3uQTJZTjcxaDLfi/dGi/RjWjVaSPjZbGwfHMXTx+/MUKng67OPVZC43gtUk
	ZyMaCBWuEQrtZrmNMqbUsF60JHTEkxJuQJefDrDU=
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] PCI: Export pci_ats_disabled() as a GPL symbol to modules
Date: Wed, 30 Oct 2019 14:51:08 +0000
Message-Id: <20191030145112.19738-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030145112.19738-1-will@kernel.org>
References: <20191030145112.19738-1-will@kernel.org>
MIME-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
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

Building drivers for ATS-aware IOMMUs as modules requires access to
pci_ats_disabled(). Export it as a GPL symbol to get things working.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/pci/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a97e2571a527..4fbe5b576dd8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -123,6 +123,7 @@ bool pci_ats_disabled(void)
 {
 	return pcie_ats_disabled;
 }
+EXPORT_SYMBOL_GPL(pci_ats_disabled);
 
 /* Disable bridge_d3 for all PCIe ports */
 static bool pci_bridge_d3_disable;
-- 
2.24.0.rc0.303.g954a862665-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
