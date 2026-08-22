Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D75385D72
	for <iommu@lists.linux.dev>; Sat, 22 Aug 2026 22:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787437239; cv=pass; b=PVHOWyzmWc/nq7mFs8YKFNr3VPwaMQWZ7ocW4A3EnnuGDnSQi7kYSA4cbj3y9q/6FjeI93L/XXM8P2joZSHSHnaio5QXGApk/icoTZLBfGvqXYBPQ9KNsu59RKD7FfjrGrVA67fXk8Ky6nOuckw1isPFNgIjYZv7QS9aVMAkW5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787437239; c=relaxed/simple;
	bh=djx3yY9VLK8P+eqxE4Oim0OXF+QpcDT7qM5MUVHVsiY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JkspQR6hnRgMtZsbpaRHI6zifXYAX8kUpqBQQkUjtWL2sryZHUn8XmZoVSRCyhuxAZCZXHFAguDaK6HxUjfFY2MPHvBqDWeUIzDZVL5/sJNpSG0fKfP1+tlGds5ljBnFgh8Sd80E0go3iuYLOtNNH47uQTVas+9MjNbtuClSOkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=ign52PPW; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="ign52PPW"
ARC-Seal: i=1; a=rsa-sha256; t=1787437231; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NO+fJULUWRuwSeDHRf9psVjCYVQfwrojX79LqeHRXyyxjb6cpT1gtg4NR4A4q/feJ5EvmR2ipKqhe7MjpHfvjoOwNSQb9nC0fP39qNB5fTFH7DVgBGICMvqQeF01Uyw8CQ0/WmyZM+NhMms+tZ3ki3J87VMDhW+Mw/u3sCjOVlo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787437231; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zqgl3nENZQDyzukcAjbOCTRDWG63qJLLQTrm8opxoqo=; 
	b=iEiR+/7ayWttEAZ9jsfFyhfLSq2bpVx6elFcaAMj0Rx17aiyI/3IorSw4VSNHkL0PUiE6C+Qxh2KUtyNvPdDWf6+aZKkZHt+0rS8Acci8pKz6TFgJ6VW1sGCMr0LaaF/PXcDIpOSf49zLkc2mntIUR7MKNA6WPiOnbz5SR/qvjw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787437231;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=zqgl3nENZQDyzukcAjbOCTRDWG63qJLLQTrm8opxoqo=;
	b=ign52PPWp9X08RMYMdMAsOdowxa4q0VQPtEcLd3LwVbdzdmHOLabiBYikGWkiB05
	pqRkGR+PbDEftdd9wNnl5QGeXCh2DZadBHYpY1zG0aD8Ei+Z+V+ev5Hh8g8I914gOM3
	jKLjGcyGb/QpCbcC4BUXJqeUBLNgtobIjTdtVztvyE5qEGo0+QWBeAkx78yY0Ll0bx9
	I3M6nOx5W6vUAtGWG8T9tVFI/jC0dkCpzWAgwfNO6U72PD4/rF9vf42qWcWpjHeNOw0
	TTXSYDxCrhCSdIV7zEyAEBPHFUn/ZJ3ZtFQvmIpE0mV8dyJpZw2UUj/isEMn9mZcIFf
	RGOLrwL4qg==
Received: by mx.zohomail.com with SMTPS id 1787437228582502.92185852103034;
	Sat, 22 Aug 2026 15:20:28 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Subject: [PATCH v3 0/3] iommu/amd: Do not request ACS when IOMMU is not
 going to be initialized
Date: Sun, 23 Aug 2026 06:20:14 +0800
Message-Id: <20260823-amd-iommu-fix-acs-v3-0-dd768e09d771@rong.moe>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NQQ6DIBAF0KsY1p0GBrS0q96j6QIFlSZKA0raG
 O9esBsXLn/m/zcLCcZbE8itWIg30QbrxhT4qSBNr8bOgNUpE11KTVvOQA0arBuGGVr7AdUEkC3
 XQtVKMslJ2r29SafNfDz/Ocz1yzRThnKjt2Fy/rs9jSz3CFKsqGRHfmRAQVfCILugoFLfvRu78
 +AMyXzEHYCHACbgKlGkeYkVlztgXdcf4yh6uQQBAAA=
X-Change-ID: d58d0f31-amd-iommu-fix-acs-8f3d4aba8183
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Huang Rui <ray.huang@amd.com>
Cc: Ankit Soni <Ankit.Soni@amd.com>, Sairaj Kodilkar <sarunkod@amd.com>, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
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

PATCH 1 cleans up the initialization routines by moving the bailing-out
paths and [1] to the right place in the state machine (i.e., before
[0]), and always requesting IVRS_DETECTED in amd_iommu_detect() to
initialize the state machine early and properly.

PATCH 2 disallows implicit START_STATE => IVRS_DETECTED transition, so
that amd_iommu_prepare() and other paths no longer progress the state
machine accidentally. This should also help prevent potential bugs if
more housekeeping work is added to amd_iommu_detect() in the future.

PATCH 3 removes all redundant ad-hoc checks, as they are now covered by
the state machine itself.

Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v3:
- Drop the dead condition (iommu_detected && !gart_iommu_aperture) as
  now we always have iommu_detected == gart_iommu_aperture (thanks
  Sairaj Kodilkar)
- Link to v2: https://patch.msgid.link/20260821-amd-iommu-fix-acs-v2-0-982472452638@rong.moe

Changes in v2:
- New patch in the series
  - PATCH 2 ("iommu/amd: Disallow implicit START_STATE => IVRS_DETECTED
    transition")
  - Prevent PATCH 3 from accidentally allowing AMD IOMMU to probe in Xen
    PV (thanks Ankit Soni)
- Drop Fixes: and Cc: stable (ditto)
- Rebase on top of the lastest changes
- Link to v1: https://patch.msgid.link/20260811-amd-iommu-fix-acs-v1-0-d64e2172408d@rong.moe

---
Rong Zhang (3):
      iommu/amd: Do not request ACS when IOMMU is not going to be initialized
      iommu/amd: Disallow implicit START_STATE => IVRS_DETECTED transition
      iommu/amd: Remove ad-hoc checks that are never true

 drivers/iommu/amd/init.c | 52 ++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)
---
base-commit: 26260251022fbc2f248a3d747a9b2b961b18d2d8
change-id: d58d0f31-amd-iommu-fix-acs-8f3d4aba8183

Thanks,
Rong

