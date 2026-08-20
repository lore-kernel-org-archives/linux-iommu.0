Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC16392C3D
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250365; cv=pass; b=M2j4lnAXDVbTOOp5FRWIjMXRR2tts3MUQe+hMGZvR3ZJ8fR9aIl1CmrK7U6MO9jVHPbT2X/nMTFCtUykymPk9hkcdabwI41ufCw8Ho3FGEeCGr7sfELN6xyXa3s0QLB369pZ5z1ee1C3tnv1nPuJuwApmg4UcS9oHuf82i24O7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250365; c=relaxed/simple;
	bh=XgDBwWGUAwxq3dWaU9WvTRg38He/QD/kOOSH2o2ZhaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=paWpPN1SdabpRKH91tTIYXAEKIKh4rSCKvIMwUOMI97kwCT9cnnV2L7S9Ih/k/M+Yyagzp/QkTBfR3XB9p69i8GFZ3p7XhNayEcG9rm3uFtmyhhY+vMvCRMDoF0I3qfq4UEdiZiid80atzh5REpyh1fLT17S1q6GvPrBEjOINa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=P2qnsIvW; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="P2qnsIvW"
ARC-Seal: i=1; a=rsa-sha256; t=1787250334; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=INIpmSBgXU6oLflC8g4zmLKRsefcsQI1hkJ7S18wmID1hdxCkSV9VWJiyRiRMC0M74CzhsLnAMBBDmlwtunHIM4et5Ku/nFS8VHb/+/aXD3syNJqFQm5nUeYvbqqbhbRcDIkYPp0T+0Ib12dUfJs51XsgNJsCdYMW4/y19Zxyrk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787250334; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7p2APwaZh7GhXlMhTsEtIq0cQMt4mvH7biiPSclgrjQ=; 
	b=CmrH9xj+AXLY9dsAJ7HKxbn8Z3DAkFkPPi53jDY8aQR3ZGi63XSbYUpIq7suiL3t9OBz2L2tP7YocjD8T/ylXRQWMEYa7TqNHNW30hIhiRmfasTX0uMQSGyNWFTCvHjWxASmc/1mD76Sd/daA/j2TYuJ5DRFCTMvhXUG7862PxI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787250334;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=7p2APwaZh7GhXlMhTsEtIq0cQMt4mvH7biiPSclgrjQ=;
	b=P2qnsIvWcABeJ3hSN9gDhC+wybNft2wHcyQhGtn/VMAeHSnMdEU2kK3V6QKoLJjl
	F+Jiofso5uEaLF1WQtvUFU8d0T30R+hThj3TNACqW/2cQY6p/zRrBBW+1Spp27rIBh8
	xIGsLTolGmRvU01l9mK+/deASaomO3CCgYby8a6lVSiSzgNusCNpUKBo8NqAdGpjbvF
	PyrLYKbV4YpjNqdMoGNBV9le/uX9aV298m1KvYl5EzP1ozY8XugLyH08L1uVEaQEFn1
	yiupc8HQkSUACgGltyZ/5m5sbhc+CYLiY/v25Ym91vyDqXyTAKmq+13m5e9OjUxDjGM
	6wp9qzM2nQ==
Received: by mx.zohomail.com with SMTPS id 1787250332228810.7858274671178;
	Thu, 20 Aug 2026 11:25:32 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Fri, 21 Aug 2026 02:25:07 +0800
Subject: [PATCH v2 1/3] iommu/amd: Do not request ACS when IOMMU is not
 going to be initialized
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-amd-iommu-fix-acs-v2-1-982472452638@rong.moe>
References: <20260821-amd-iommu-fix-acs-v2-0-982472452638@rong.moe>
In-Reply-To: <20260821-amd-iommu-fix-acs-v2-0-982472452638@rong.moe>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, 
 Huang Rui <ray.huang@amd.com>
Cc: Ankit Soni <Ankit.Soni@amd.com>, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-1f2f7
X-ZohoMailClient: External

The AMD IOMMU Initialization State Machine has the following state
transition diagram (only the very first states are showed, and the
`IOMMU_' prefix is omitted):

   START_STATE
        |
        v
[0] detect_ivrs() --> NOT_FOUND
        | ok
        v
  IVRS_DETECTED
        |
        v
[1] amd_iommu_disabled? (amd_iommu=off) --> IOMMU_CMDLINE_DISABLED
        | no
        v
[2] early_amd_iommu_init()
        |
        +-- [3] amd_iommu_detected? (!iommu=off && ...) -+
        | yes                                            |
        +-- ... --> IOMMU_INIT_ERROR <-------------------+
        | ok
        v
IOMMU_ACPI_FINISHED
        |
        v
       ...

[0] always calls pci_request_acs() as long as there's a valid IVRS table
and no Stoney Ridge graphics. This is not optimal as ACS is not required
in an [amd_]iommu=off boot.

In a normal boot, ACS is requested due to amd_iommu_detect() requesting
IVRS_DETECTED.

    pci_request_acs+0x9/0x18
    iommu_go_to_state+0x106/0x1a20
    amd_iommu_detect+0x1c/0x50
    pci_iommu_alloc+0x26/0x40
    mm_core_init+0xa/0x120
    start_kernel+0x527/0x7a0
    x86_64_start_reservations+0x24/0x30
    x86_64_start_kernel+0xd1/0xe0
    common_startup_64+0x13e/0x158

This is intended to ensure ACS is requested before the PCI core
initialization, or else a !CONFIG_IRQ_REMAP, nointremap or intremap=off
boot would be broken.

However, in an amd_iommu=off boot, the state machine still requests ACS
at the exact same time, as amd_iommu_detect() has nothing to do with
amd_iommu_disabled.

Even worse, in an iommu=off boot, though amd_iommu_detect() bails out
early, ACS is still requested due to amd_iommu_prepare() requesting
IOMMU_ACPI_FINISHED, which is called by irq_remapping_prepare() thanks
to CONFIG_X86_LOCAL_APIC (always set on X86_64) and CONFIG_IRQ_REMAP
(enabled by defconfig), unless nointremap or intremap=off is also passed
to cmdline.

    pci_request_acs+0x9/0x18
    iommu_go_to_state+0x106/0x1a20
    amd_iommu_prepare+0x15/0x40
    irq_remapping_prepare+0x43/0x60
    enable_IR_x2apic+0x22/0x190
    x86_64_probe_apic+0xa/0x50
    apic_intr_mode_init+0x70/0xd0
    x86_late_time_init+0x28/0x40
    start_kernel+0x6f9/0x7a0
    ...

In both cases, [2] is still gated due to the [1] or [3] check, so that
IOMMU can be disabled per cmdline.

Technically, it makes no sense to detect IVRS at all in an
[amd_]iommu=off boot or if IOMMU is not supported due to platform
settings. This is probably why amd_iommu_detect() bails out before
requesting IVRS_DETECTED. Apparently only bailing out there is not
sufficient, and the bailing-out paths should really have been parts of
the state machine.

Clean up the initialization routines by moving the bailing-out paths and
[1] to the right place in the state machine (i.e., before [0]), and
always requesting IVRS_DETECTED in amd_iommu_detect() to initialize the
state machine early and properly.

Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/iommu/amd/init.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 40726dfef273..a720796cca3b 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3470,6 +3470,8 @@ static void amd_iommu_apply_erratum_snp(void)
 #endif
 }
 
+static bool amd_iommu_sme_check(void);
+
 /****************************************************************************
  *
  * AMD IOMMU Initialization State Machine
@@ -3482,7 +3484,13 @@ static int __init state_next(void)
 
 	switch (init_state) {
 	case IOMMU_START_STATE:
-		if (!detect_ivrs()) {
+		if (no_iommu || amd_iommu_disabled) {
+			init_state	= IOMMU_CMDLINE_DISABLED;
+			ret		= -EINVAL;
+		} else if ((iommu_detected && !gart_iommu_aperture) || !amd_iommu_sme_check()) {
+			init_state	= IOMMU_INIT_ERROR;
+			ret		= -EINVAL;
+		} else if (!detect_ivrs()) {
 			init_state	= IOMMU_NOT_FOUND;
 			ret		= -ENODEV;
 		} else {
@@ -3490,13 +3498,8 @@ static int __init state_next(void)
 		}
 		break;
 	case IOMMU_IVRS_DETECTED:
-		if (amd_iommu_disabled) {
-			init_state = IOMMU_CMDLINE_DISABLED;
-			ret = -EINVAL;
-		} else {
-			ret = early_amd_iommu_init();
-			init_state = ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
-		}
+		ret = early_amd_iommu_init();
+		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
 		break;
 	case IOMMU_ACPI_FINISHED:
 		early_enable_iommus();
@@ -3695,12 +3698,6 @@ void __init amd_iommu_detect(void)
 {
 	int ret;
 
-	if (no_iommu || (iommu_detected && !gart_iommu_aperture))
-		goto disable_snp;
-
-	if (!amd_iommu_sme_check())
-		goto disable_snp;
-
 	ret = iommu_go_to_state(IOMMU_IVRS_DETECTED);
 	if (ret)
 		goto disable_snp;

-- 
2.55.0

