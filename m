Return-Path: <SRS0=vA4F=2R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBD7C2D0C0
	for <iommu@archiver.kernel.org>; Fri, 27 Dec 2019 02:34:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49EA72053B
	for <iommu@archiver.kernel.org>; Fri, 27 Dec 2019 02:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hQ6P8OMc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YndNdMAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49EA72053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E7A1384CE1;
	Fri, 27 Dec 2019 02:34:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9riGGw+sAtWj; Fri, 27 Dec 2019 02:34:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9AF8584C3C;
	Fri, 27 Dec 2019 02:34:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FE7BC18DD;
	Fri, 27 Dec 2019 02:34:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6DDBC0881
 for <iommu@lists.linux-foundation.org>; Fri, 27 Dec 2019 00:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E2E4120441
 for <iommu@lists.linux-foundation.org>; Fri, 27 Dec 2019 00:01:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C8uZsjgrQRhv for <iommu@lists.linux-foundation.org>;
 Fri, 27 Dec 2019 00:01:17 +0000 (UTC)
X-Greylist: delayed 00:05:17 by SQLgrey-1.7.6
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 by silver.osuosl.org (Postfix) with ESMTPS id A0C6020357
 for <iommu@lists.linux-foundation.org>; Fri, 27 Dec 2019 00:01:17 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 88F448DB;
 Thu, 26 Dec 2019 18:55:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Thu, 26 Dec 2019 18:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm2; bh=uRJWrdJTHPk/y16NQ6DIwF/KZA
 xVopaDanxI3UaG1XA=; b=hQ6P8OMc8GbYpRKcGzXtn2y9jJ1SBKwUSIDFHmY9T9
 EZaVcSMjWskaYGY150RTcudw01ohAwoot0fBjc3yLeLwhSC3bXMyInrmMyFG2mJV
 jO9u28YRUijHB0aB+e19i31NaqXiwUA7ZFsU4qz/+nAxNCC41n5FDORNFd+cK9wf
 XYpWGHpCKH/K+cv5pMfzp0uig4EXGIY+8o/JEOsSe332j5PCqTOHjg/xc6rS3yMx
 31Qiz77+OmSq9fWUfP1ZQ94TLkEp/0Xl1jokOebBLKpFOE0X/VlEZpcEkaz5yMtX
 4CtFkV3v5sidVwah8mgy1ViXc4EIKGOwvje1CpGV/1Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=uRJWrdJTHPk/y16NQ
 6DIwF/KZAxVopaDanxI3UaG1XA=; b=YndNdMADJyCLJ0Fcr4Jd2eTjVXNZlmbyk
 Ol6F3klvDRSXqcNKeTlcSyuBeCp4BG+0uMFE2K0ZfdyWJYuq7hdCEU6jeq/MYb8v
 pUUXiUVOI44IEGQ6c6GYoVwjHqiTUUEMS5+gDqji6ajlGqLweEt0LaGP9hjlqSNS
 1jCIqhSozR69vYwiOMoxmFacPs0DeGkb50o97lT3SPrsJ0WjJanR9TcVOlFL5KDB
 yb/BTLvP5GHJI2D/R0x3XBrABVV8fmH3hJBPfd1qxRQ18Fo0L6L7Fwoxheqb90Ub
 FjIfYc5xjOUBCAV3OTBYRzkvnw7HN96gjXOBFBWwaOJStXVclODkw==
X-ME-Sender: <xms:jEgFXsnoE8DQFQ6LgnzVGhbQaJd_rGpg6mSJIpa8ffP0y4PPOQEFEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddvjedgudehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefrrghtrhhitghk
 ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepkeelrdduvddrud
 eigedrudejgeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhenucev
 lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:jEgFXqnRzBvIrzvaPdAFDbjy_QBdrmBY7bKcM-hLLsCB6qD9vF_6lg>
 <xmx:jEgFXqOjvLXvXwd9I_IyjsyTTTn6xjzSmropyINK2alOMLjb3jXd5w>
 <xmx:jEgFXi5k0bGlmrsYez-4-zi-LYXSeNFHe1Fx4gmQvpwIEkb520D6gA>
 <xmx:jkgFXsFH5hrg0tj9uVf72JNYgcl6mkDkllb464vn-IO2dJK6TwHOWA>
Received: from vm-mail (x590ca4ae.dyn.telefonica.de [89.12.164.174])
 by mail.messagingengine.com (Postfix) with ESMTPA id 59F393060962;
 Thu, 26 Dec 2019 18:55:56 -0500 (EST)
Received: from localhost (<unknown> [10.192.0.12])
 by vm-mail (OpenSMTPD) with ESMTPSA id 9b84b259
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 26 Dec 2019 23:55:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/vt-d fix adding non-PCI devices to Intel IOMMU
Date: Fri, 27 Dec 2019 00:56:18 +0100
Message-Id: <b47f83548d855ac920ad06b0ff78b877fa4f5189.1577404477.git.ps@pks.im>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 27 Dec 2019 02:34:38 +0000
Cc: Patrick Steinhardt <ps@pks.im>, David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Starting with commit fa212a97f3a3 ("iommu/vt-d: Probe DMA-capable ACPI
name space devices"), we now probe DMA-capable ACPI name
space devices. On Dell XPS 13 9343, which has an Intel LPSS platform
device INTL9C60 enumerated via ACPI, this change leads to the following
warning:

    ------------[ cut here ]------------
    WARNING: CPU: 1 PID: 1 at pci_device_group+0x11a/0x130
    CPU: 1 PID: 1 Comm: swapper/0 Tainted: G                T 5.5.0-rc3+ #22
    Hardware name: Dell Inc. XPS 13 9343/0310JH, BIOS A20 06/06/2019
    RIP: 0010:pci_device_group+0x11a/0x130
    Code: f0 ff ff 48 85 c0 49 89 c4 75 c4 48 8d 74 24 10 48 89 ef e8 48 ef ff ff 48 85 c0 49 89 c4 75 af e8 db f7 ff ff 49 89 c4 eb a5 <0f> 0b 49 c7 c4 ea ff ff ff eb 9a e8 96 1e c7 ff 66 0f 1f 44 00 00
    RSP: 0000:ffffc0d6c0043cb0 EFLAGS: 00010202
    RAX: 0000000000000000 RBX: ffffa3d1d43dd810 RCX: 0000000000000000
    RDX: ffffa3d1d4fecf80 RSI: ffffa3d12943dcc0 RDI: ffffa3d1d43dd810
    RBP: ffffa3d1d43dd810 R08: 0000000000000000 R09: ffffa3d1d4c04a80
    R10: ffffa3d1d4c00880 R11: ffffa3d1d44ba000 R12: 0000000000000000
    R13: ffffa3d1d4383b80 R14: ffffa3d1d4c090d0 R15: ffffa3d1d4324530
    FS:  0000000000000000(0000) GS:ffffa3d1d6700000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 0000000000000000 CR3: 000000000460a001 CR4: 00000000003606e0
    Call Trace:
     ? iommu_group_get_for_dev+0x81/0x1f0
     ? intel_iommu_add_device+0x61/0x170
     ? iommu_probe_device+0x43/0xd0
     ? intel_iommu_init+0x1fa2/0x2235
     ? pci_iommu_init+0x52/0xe7
     ? e820__memblock_setup+0x15c/0x15c
     ? do_one_initcall+0xcc/0x27e
     ? kernel_init_freeable+0x169/0x259
     ? rest_init+0x95/0x95
     ? kernel_init+0x5/0xeb
     ? ret_from_fork+0x35/0x40
    ---[ end trace 28473e7abc25b92c ]---
    DMAR: ACPI name space devices didn't probe correctly

The bug results from the fact that while we now enumerate ACPI devices,
we aren't able to handle any non-PCI device when generating the device
group. Fix the issue by implementing an Intel-specific callback that
returns `pci_device_group` only if the device is a PCI device.
Otherwise, it will return a generic device group.

Fixes: fa212a97f3a3 ("iommu/vt-d: Probe DMA-capable ACPI name space devices")
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

I've recently spotted above warning in v5.5-rc3. The attached fix
is rather intended as a discussion starter -- it's quite likely
to be wrong as I ain't got much of a clue about the IOMMU
subsystem.

 drivers/iommu/intel-iommu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 42966611a192..e3696a754fd1 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5972,6 +5972,13 @@ static bool intel_iommu_is_attach_deferred(struct iommu_domain *domain,
 	return dev->archdata.iommu == DEFER_DEVICE_DOMAIN_INFO;
 }
 
+static struct iommu_group *intel_iommu_device_group(struct device *dev)
+{
+	if (dev_is_pci(dev))
+		return pci_device_group(dev);
+	return generic_device_group(dev);
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -5989,7 +5996,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.put_resv_regions	= intel_iommu_put_resv_regions,
 	.apply_resv_region	= intel_iommu_apply_resv_region,
-	.device_group		= pci_device_group,
+	.device_group		= intel_iommu_device_group,
 	.dev_has_feat		= intel_iommu_dev_has_feat,
 	.dev_feat_enabled	= intel_iommu_dev_feat_enabled,
 	.dev_enable_feat	= intel_iommu_dev_enable_feat,
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
