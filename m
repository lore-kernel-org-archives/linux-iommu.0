Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A8722A817;
	Mon, 20 Apr 2026 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699210; cv=none; b=f7RBGTjYW9BG6e7jKndcrgnyAgcL65hlmSFtozCExge+0IOnjno/GwEPBwOUxJnHXvYxeFXqPFERWd3g8G5D3P68wUPJlKvmRlKNmCT9fRBBLrheRU8fgcsPoLNPN0NTO/GyptGF0Ulzv4zHtuFh/cLllXq5lAOp29TuXkvU6eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699210; c=relaxed/simple;
	bh=eGMc1rs/1/ziinbDzgmWoXbR43j4Ci341oQZ1gdxlKg=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=tooAFoJ/AGCEdFmAVRq8XuUeszO9f2wcjHRyTAELmr21SSCJUU14OlElblhARCxmH3C6iGUh2D/sHiqOklJDDtV/oF5HR8Al088y0+SBEtwyZX2vXqnYmW9wYswO/RIttK7O1D5aAsTver9sxhRPqxqUHUxzDmx04D6R0KDmzNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d3Z1FLVW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d3Z1FLVW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4367C19425;
	Mon, 20 Apr 2026 15:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776699210;
	bh=eGMc1rs/1/ziinbDzgmWoXbR43j4Ci341oQZ1gdxlKg=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=d3Z1FLVWdHC5Moqp3veZMmQ69/LnVeJjSm42XwnKz/5ncGeiGzHBv2wAC4CUI/vM8
	 8oLtJmIlx29kt3UK7C/rOzpso7BJS9+ZBr5J0yo3HoHmT+6uE4E+Das9OhdUvbKDxC
	 xPAieHi8KDllSnj54v1rdyT8GYKyV0LFo/02lw0Y=
Subject: Patch "PCI: Revert "Enable ACS after configuring IOMMU for OF platforms"" has been added to the 6.12-stable tree
To: bhelgaas@google.com,gregkh@linuxfoundation.org,iommu@lists.linux.dev,john@kernel.doghat.io,joro@8bytes.org,manivannan.sadhasivam@oss.qualcomm.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Apr 2026 17:33:27 +0200
In-Reply-To: <20260320172335.29778-1-john@kernel.doghat.io>
Message-ID: <2026042027-radio-fencing-1f19@gregkh>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    PCI: Revert "Enable ACS after configuring IOMMU for OF platforms"

to the 6.12-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     pci-revert-enable-acs-after-configuring-iommu-for-of-platforms.patch
and it can be found in the queue-6.12 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-227585-greg=kroah.com@vger.kernel.org Fri Mar 20 18:29:23 2026
From: John Hancock <john@kernel.doghat.io>
Date: Fri, 20 Mar 2026 13:23:35 -0400
Subject: PCI: Revert "Enable ACS after configuring IOMMU for OF platforms"
To: stable@vger.kernel.org
Cc: bhelgaas@google.com, manivannan.sadhasivam@oss.qualcomm.com, joro@8bytes.org, linux-pci@vger.kernel.org, iommu@lists.linux.dev, John Hancock <john@kernel.doghat.io>
Message-ID: <20260320172335.29778-1-john@kernel.doghat.io>

From: John Hancock <john@kernel.doghat.io>

This reverts 7a126c1b6cfa2c4b5a7013164451ecddd210110d which is
commit c41e2fb67e26b04d919257875fa954aa5f6e392e upstream.

Commit 7a126c1b6cfa ("PCI: Enable ACS after configuring IOMMU for OF
platforms") introduced a regression affecting AMD IOMMU group isolation
on x86 systems, making PCIe passthrough non-functional.

While the commit addresses a legitimate ordering issue on OF/Device Tree
platforms, the fix modifies pci_dma_configure(), which executes on all
platforms regardless of firmware interface. On AMD systems with IOMMU,
moving pci_enable_acs() from pci_acs_init() to pci_dma_configure() alters
the point at which ACS is evaluated relative to IOMMU group assignment.
The result is that devices which previously occupied individual, exclusive
IOMMU groups are merged into a single group containing both passthrough
and non-passthrough members, violating IOMMU isolation requirements.

The commit author notes that pci_enable_acs() is now called twice per
device and that this is "presumably not an issue." On AMD IOMMU hardware
this assumption does not hold -- the change in call ordering has
observable and breaking consequences for group topology.

It is worth noting that this is a stable/LTS series (6.12.y), where
changes to fundamental PCI initialization ordering carry significant
risk for production and specialized workloads that depend on stable
IOMMU behavior across kernel updates. A regression of this nature --
silently breaking PCIe passthrough without any configuration change on
the part of the user -- is particularly disruptive in a series that
users reasonably expect to be conservative.

This revert restores pci_enable_acs() to pci_acs_init() and marks it
static again, fully restoring correct IOMMU group topology on affected
hardware.

Regression introduced in: 6.12.75
Tested on: 6.12.77 with this revert applied

Hardware:
  CPU:   AMD Ryzen Threadripper 2990WX (family 23h, Zen+)
  IOMMU: AMD-Vi

Bisect:
  6.12.74: GOOD -- IOMMU groups correct, passthrough functional
  6.12.75: BAD  -- IOMMU groups collapsed, passthrough broken
  6.12.76: BAD  -- still broken
  6.12.77: BAD  -- still broken

Fixes: 7a126c1b6cfa ("PCI: Enable ACS after configuring IOMMU for OF platforms")
Signed-off-by: John Hancock <john@kernel.doghat.io>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pci-driver.c |    8 --------
 drivers/pci/pci.c        |   10 +++++++++-
 drivers/pci/pci.h        |    1 -
 3 files changed, 9 insertions(+), 10 deletions(-)

--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1656,14 +1656,6 @@ static int pci_dma_configure(struct devi
 		ret = acpi_dma_configure(dev, acpi_get_dma_attr(adev));
 	}
 
-	/*
-	 * Attempt to enable ACS regardless of capability because some Root
-	 * Ports (e.g. those quirked with *_intel_pch_acs_*) do not have
-	 * the standard ACS capability but still support ACS via those
-	 * quirks.
-	 */
-	pci_enable_acs(to_pci_dev(dev));
-
 	pci_put_host_bridge_device(bridge);
 
 	if (!ret && !driver->driver_managed_dma) {
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1072,7 +1072,7 @@ static void pci_std_enable_acs(struct pc
  * pci_enable_acs - enable ACS if hardware support it
  * @dev: the PCI device
  */
-void pci_enable_acs(struct pci_dev *dev)
+static void pci_enable_acs(struct pci_dev *dev)
 {
 	struct pci_acs caps;
 	bool enable_acs = false;
@@ -3718,6 +3718,14 @@ bool pci_acs_path_enabled(struct pci_dev
 void pci_acs_init(struct pci_dev *dev)
 {
 	dev->acs_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+
+	/*
+	 * Attempt to enable ACS regardless of capability because some Root
+	 * Ports (e.g. those quirked with *_intel_pch_acs_*) do not have
+	 * the standard ACS capability but still support ACS via those
+	 * quirks.
+	 */
+	pci_enable_acs(dev);
 }
 
 /**
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -653,7 +653,6 @@ static inline resource_size_t pci_resour
 }
 
 void pci_acs_init(struct pci_dev *dev);
-void pci_enable_acs(struct pci_dev *dev);
 #ifdef CONFIG_PCI_QUIRKS
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 int pci_dev_specific_enable_acs(struct pci_dev *dev);


Patches currently in stable-queue which might be from john@kernel.doghat.io are

queue-6.12/pci-revert-enable-acs-after-configuring-iommu-for-of-platforms.patch
