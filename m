Return-Path: <SRS0=jcR/=E5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38F8C388F9
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 13:44:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3212A206F1
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 13:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cmr9EANz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3212A206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C3B0584AA7;
	Mon, 23 Nov 2020 13:44:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q5dcUNbkc7Wk; Mon, 23 Nov 2020 13:44:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 43DB1849D2;
	Mon, 23 Nov 2020 13:44:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D67DC0891;
	Mon, 23 Nov 2020 13:44:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EC0CC0052
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 13:44:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 317052035E
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 13:44:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rkHKDM-Cd031 for <iommu@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 13:44:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 6C4A61FD16
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 13:44:16 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 813D7206F1;
 Mon, 23 Nov 2020 13:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606139056;
 bh=DB3QEZuy+Fe1QR9eYhfJo9ZD6woPmMFGSzD2JXS+9+Q=;
 h=From:To:Cc:Subject:Date:From;
 b=Cmr9EANzmv4bIP3wlI7Dhllj0uIjXveZ90qem2GkU4WVQzSmKOzQa17Jtu/YyEH21
 6rY+XVs4S0KSTvniAUG26veNWwMmaTW6qg/+TwvFiVqkb1o2hn2yDfVJWQINFzb3AW
 Oeqsv8YlMpF+tsbFbkDG9c2VnTzlXdI7XCvO/z6U=
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
Date: Mon, 23 Nov 2020 13:44:10 +0000
Message-Id: <20201123134410.10648-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Edgar Merger <Edgar.Merger@emerson.com>, Joerg Roedel <jroedel@suse.de>,
 linux-pci@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Will Deacon <will@kernel.org>
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

Edgar Merger reports that the AMD Raven GPU does not work reliably on
his system when the IOMMU is enabled:

  | [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout, signaled seq=1, emitted seq=3
  | [...]
  | amdgpu 0000:0b:00.0: GPU reset begin!
  | AMD-Vi: Completion-Wait loop timed out
  | iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT device=0b:00.0 address=0x38edc0970]

This is indicative of a hardware/platform configuration issue so, since
disabling ATS has been shown to resolve the problem, add a quirk to
match this particular device while Edgar follows-up with AMD for more
information.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reported-by: Edgar Merger <Edgar.Merger@emerson.com>
Suggested-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/linux-iommu/MWHPR10MB1310F042A30661D4158520B589FC0@MWHPR10MB1310.namprd10.prod.outlook.com
Signed-off-by: Will Deacon <will@kernel.org>
---

Hi all,

Since Joerg is away at the moment, I'm posting this to try to make some
progress with the thread in the Link: tag.

Cheers,

Will

 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f70692ac79c5..3911b0ec57ba 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5176,6 +5176,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312, quirk_amd_harvest_no_ats);
 /* AMD Navi14 dGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
+/* AMD Raven platform iGPU */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_ats);
 #endif /* CONFIG_PCI_ATS */
 
 /* Freescale PCIe doesn't support MSI in RC mode */
-- 
2.29.2.454.gaff20da3a2-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
