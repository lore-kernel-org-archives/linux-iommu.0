Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB315C433EF
	for <iommu@archiver.kernel.org>; Tue, 26 Apr 2022 16:43:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6CFF940538;
	Tue, 26 Apr 2022 16:43:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xGFgVBjLV22w; Tue, 26 Apr 2022 16:43:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A7E4640B48;
	Tue, 26 Apr 2022 16:43:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7475DC0032;
	Tue, 26 Apr 2022 16:43:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37A9EC002D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 16:43:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 155984188D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 16:43:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E5pJLAQ3WviP for <iommu@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 16:43:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F26DB4182E
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 16:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650991383; x=1682527383;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=74prdzNGj3JnjJUS0sO17DGbGa0TVADKS42cC0+9fsE=;
 b=GcRmGAfMiMVgTEnF0GT6e4HWFnl03babUSDGe2VMDEhjjzCLn74fWwuF
 xolO4XeThy4fEugr0n3oyRdqEBiZYZdRmgHRPQe6Pds9gCKDD7QqRt8KI
 Lg/3xBKyJBuHbe1rsZu4BqKpN6A8zfxTsmj2nhou9p0FsMAath0pr0sha
 JkB6EpLfZ0WwpVmA7g7iORANjVJqq2TtnTWFTF2WMr7bxpiDStqEXPBW/
 GcPQg5YJDVR2qcATEIbnLS60elI3tfeFfqpaE9PMGF8gxlSttyGkpwZYA
 9didJ5ikYTKtL2/EGj+p4RA4xnKDUNZ83Q5LduAxvGp5vKU4DWTGWuqgB w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="328588981"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; d="scan'208";a="328588981"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2022 09:40:54 -0700
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; d="scan'208";a="513243859"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2022 09:40:54 -0700
Date: Tue, 26 Apr 2022 09:44:32 -0700
From: Jacob Pan <jacob.jun.pan@intel.com>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] Documentation: x86: rework IOMMU documentation
Message-ID: <20220426094432.2970966f@jacob-builder>
In-Reply-To: <20220422200607.627754-1-alexander.deucher@amd.com>
References: <20220422200607.627754-1-alexander.deucher@amd.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: dave.hansen@linux.intel.com, "Lu, Baolu" <baolu.lu@intel.com>,
 corbet@lwn.net, robin.murphy@arm.com, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Vasant.Hegde@amd.com,
 iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
 jacob.jun.pan@intel.com, hpa@zytor.com, tglx@linutronix.de, will@kernel.org
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

Hi Alex,

Thanks for doing this, really helps to catch up the current state. Please
see my comments inline.

On Fri, 22 Apr 2022 16:06:07 -0400, Alex Deucher
<alexander.deucher@amd.com> wrote:

> Add preliminary documentation for AMD IOMMU and combine
> with the existing Intel IOMMU documentation and clean
> up and modernize some of the existing documentation to
> align with the current state of the kernel.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
> 
> V2: Incorporate feedback from Robin to clarify IOMMU vs DMA engine (e.g.,
>     a device) and document proper DMA API.  Also correct the fact that
>     the AMD IOMMU is not limited to managing PCI devices.
> v3: Fix spelling and rework text as suggested by Vasant
> v4: Combine Intel and AMD documents into a single document as suggested
>     by Dave Hansen
> v5: Clarify that keywords are related to ACPI, grammatical fixes
> v6: Make more stuff common based on feedback from Robin
> 
>  Documentation/x86/index.rst       |   2 +-
>  Documentation/x86/intel-iommu.rst | 115 ------------------------
>  Documentation/x86/iommu.rst       | 143 ++++++++++++++++++++++++++++++
>  3 files changed, 144 insertions(+), 116 deletions(-)
>  delete mode 100644 Documentation/x86/intel-iommu.rst
>  create mode 100644 Documentation/x86/iommu.rst
> 
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index f498f1d36cd3..6f8409fe0674 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -21,7 +21,7 @@ x86-specific Documentation
>     tlb
>     mtrr
>     pat
> -   intel-iommu
> +   iommu
>     intel_txt
>     amd-memory-encryption
>     pti
> diff --git a/Documentation/x86/intel-iommu.rst
> b/Documentation/x86/intel-iommu.rst deleted file mode 100644
> index 099f13d51d5f..000000000000
> --- a/Documentation/x86/intel-iommu.rst
> +++ /dev/null
> @@ -1,115 +0,0 @@
> -===================
> -Linux IOMMU Support
> -===================
> -
> -The architecture spec can be obtained from the below location.
> -
> -http://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/vt-directed-io-spec.pdf
> -
> -This guide gives a quick cheat sheet for some basic understanding.
> -
> -Some Keywords
> -
> -- DMAR - DMA remapping
> -- DRHD - DMA Remapping Hardware Unit Definition
> -- RMRR - Reserved memory Region Reporting Structure
> -- ZLR  - Zero length reads from PCI devices
> -- IOVA - IO Virtual address.
> -
I feel this combined document only focus on IOVA and DMA APIs, it is
considered as legacy DMA after scalable mode is introduced by Intel to
support DMA with PASID, shared virtual addressing (SVA).
Perhaps, we can also combine ./Documentation/x86/sva.rst

With scalable mode, it affects boot messages, fault reporting, etc. I am
not saying no to this document, just suggesting. I don't know where AMD is
at in terms of PASID support but there are lots of things in common between
VT-d and ARM's SMMU in terms of PASID/SVA. Should we broaden the purpose of
this document even further?

> -Basic stuff
> ------------
> -
> -ACPI enumerates and lists the different DMA engines in the platform, and
> -device scope relationships between PCI devices and which DMA engine
> controls -them.
> -
> -What is RMRR?
> --------------
> -
> -There are some devices the BIOS controls, for e.g USB devices to perform
> -PS2 emulation. The regions of memory used for these devices are marked
> -reserved in the e820 map. When we turn on DMA translation, DMA to those
> -regions will fail. Hence BIOS uses RMRR to specify these regions along
> with -devices that need to access these regions. OS is expected to setup
> -unity mappings for these regions for these devices to access these
> regions. -
> -How is IOVA generated?
> -----------------------
> -
> -Well behaved drivers call pci_map_*() calls before sending command to
> device -that needs to perform DMA. Once DMA is completed and mapping is
> no longer -required, device performs a pci_unmap_*() calls to unmap the
> region. -
> -The Intel IOMMU driver allocates a virtual address per domain. Each PCIE
> -device has its own domain (hence protection). Devices under p2p bridges
> -share the virtual address with all devices under the p2p bridge due to
> -transaction id aliasing for p2p bridges.
> -
> -IOVA generation is pretty generic. We used the same technique as
> vmalloc() -but these are not global address spaces, but separate for each
> domain. -Different DMA engines may support different number of domains.
> -
> -We also allocate guard pages with each mapping, so we can attempt to
> catch -any overflow that might happen.
> -
> -
> -Graphics Problems?
> -------------------
> -If you encounter issues with graphics devices, you can try adding
> -option intel_iommu=igfx_off to turn off the integrated graphics engine.
> -If this fixes anything, please ensure you file a bug reporting the
> problem. -
> -Some exceptions to IOVA
> ------------------------
> -Interrupt ranges are not address translated, (0xfee00000 - 0xfeefffff).
> -The same is true for peer to peer transactions. Hence we reserve the
> -address from PCI MMIO ranges so they are not allocated for IOVA
> addresses. -
> -
> -Fault reporting
> ----------------
> -When errors are reported, the DMA engine signals via an interrupt. The
> fault -reason and device that caused it with fault reason is printed on
> console. -
> -See below for sample.
> -
> -
> -Boot Message Sample
> --------------------
> -
> -Something like this gets printed indicating presence of DMAR tables
> -in ACPI.
> -
> -ACPI: DMAR (v001 A M I  OEMDMAR  0x00000001 MSFT 0x00000097) @
> 0x000000007f5b5ef0 -
> -When DMAR is being processed and initialized by ACPI, prints DMAR
> locations -and any RMRR's processed::
> -
> -	ACPI DMAR:Host address width 36
> -	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed90000
> -	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed91000
> -	ACPI DMAR:DRHD (flags: 0x00000001)base: 0x00000000fed93000
> -	ACPI DMAR:RMRR base: 0x00000000000ed000 end: 0x00000000000effff
> -	ACPI DMAR:RMRR base: 0x000000007f600000 end: 0x000000007fffffff
> -
> -When DMAR is enabled for use, you will notice..
> -
> -PCI-DMA: Using DMAR IOMMU
> --------------------------
> -
> -Fault reporting
> -^^^^^^^^^^^^^^^
> -
> -::
> -
> -	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
> -	DMAR:[fault reason 05] PTE Write access is not set
> -	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
> -	DMAR:[fault reason 05] PTE Write access is not set
> -
> -TBD
> -----
> -
> -- For compatibility testing, could use unity map domain for all devices,
> just
> -  provide a 1-1 for all useful memory under a single domain for all
> devices. -- API for paravirt ops for abstracting functionality for VMM
> folks. diff --git a/Documentation/x86/iommu.rst
> b/Documentation/x86/iommu.rst new file mode 100644
> index 000000000000..ed87d76a38d5
> --- /dev/null
> +++ b/Documentation/x86/iommu.rst
> @@ -0,0 +1,143 @@
> +=================
> +x86 IOMMU Support
> +=================
> +
> +The architecture specs can be obtained from the below locations.
> +
> +- Intel:
> http://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/vt-directed-io-spec.pdf
> +- AMD: https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf +
> +This guide gives a quick cheat sheet for some basic understanding.
> +
> +Basic stuff
> +-----------
> +
> +ACPI enumerates and lists the different IOMMUs on the platform, and
> +device scope relationships between devices and which IOMMU controls
> +them.
> +
> +Some ACPI Keywords:
> +
> +- DMAR - Intel DMA Remapping table
> +- DRHD - Intel DMA Remapping Hardware Unit Definition
> +- RMRR - Intel Reserved Memory Region Reporting Structure
> +- IVRS - AMD I/O Virtualization Reporting Structure
> +- IVDB - AMD I/O Virtualization Definition Block
> +- IVHD - AMD I/O Virtualization Hardware Definition
> +
> +What is Intel RMRR?
> +^^^^^^^^^^^^^^^^^^^
> +
> +There are some devices the BIOS controls, for e.g USB devices to perform
> +PS2 emulation. The regions of memory used for these devices are marked
> +reserved in the e820 map. When we turn on DMA translation, DMA to those
> +regions will fail. Hence BIOS uses RMRR to specify these regions along
> with +devices that need to access these regions. OS is expected to setup
> +unity mappings for these regions for these devices to access these
> regions. +
> +What is AMD IVRS?
> +^^^^^^^^^^^^^^^^^
> +
> +The architecture defines an ACPI-compatible data structure called an I/O
> +Virtualization Reporting Structure (IVRS) that is used to convey
> information +related to I/O virtualization to system software.  The IVRS
> describes the +configuration and capabilities of the IOMMUs contained in
> the platform as +well as information about the devices that each IOMMU
> virtualizes. +
> +The IVRS provides information about the following:
> +
> +- IOMMUs present in the platform including their capabilities and proper
> configuration +- System I/O topology relevant to each IOMMU
> +- Peripheral devices that cannot be otherwise enumerated
> +- Memory regions used by SMI/SMM, platform firmware, and platform
> hardware. These are generally exclusion ranges to be configured by system
> software. + +How is an I/O Virtual Address (IOVA) generated?
> +-----------------------------------------------
> +
> +Well behaved drivers call dma_map_*() calls before sending command to
> device +that needs to perform DMA. Once DMA is completed and mapping is
> no longer +required, driver performs dma_unmap_*() calls to unmap the
> region. +
> +Some exceptions to IOVAs
> +------------------------
> +
> +Interrupt ranges are not address translated, (0xfee00000 - 0xfeefffff).
> +The same is true for peer to peer transactions. Hence we reserve the
> +address from PCI MMIO ranges so they are not allocated for IOVA
> addresses. +
> +Graphics Problems?
> +------------------
> +
> +If you encounter issues with integrated graphics devices, you can try
> +adding the option "iommu.passthrough=1", or the equivalent "iommu=pt",
> +to the kernel command line to use a 1:1 mapping for the IOMMU in
> +general.  On Intel you can also try "intel_iommu=igfx_off" to turn off
> +translation specifically for the integrated graphics engine only.  If
> +this fixes anything, please ensure you file a bug reporting the problem.
> +
> +Fault reporting
> +---------------
> +When errors are reported, the IOMMU signals via an interrupt. The fault
> +reason and device that caused it is printed on the console.
> +
> +
> +Kernel Log Samples
> +------------------
> +
> +Intel Boot Messages
> +^^^^^^^^^^^^^^^^^^^
> +
> +Something like this gets printed indicating presence of DMAR tables
> +in ACPI:
> +
> +::
> +
> +	ACPI: DMAR (v001 A M I  OEMDMAR  0x00000001 MSFT 0x00000097) @
> 0x000000007f5b5ef0 +
> +When DMAR is being processed and initialized by ACPI, prints DMAR
> locations +and any RMRR's processed:
> +
> +::
> +
> +	ACPI DMAR:Host address width 36
> +	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed90000
> +	ACPI DMAR:DRHD (flags: 0x00000000)base: 0x00000000fed91000
> +	ACPI DMAR:DRHD (flags: 0x00000001)base: 0x00000000fed93000
> +	ACPI DMAR:RMRR base: 0x00000000000ed000 end: 0x00000000000effff
> +	ACPI DMAR:RMRR base: 0x000000007f600000 end: 0x000000007fffffff
> +
> +When DMAR is enabled for use, you will notice:
> +
> +::
> +
> +	PCI-DMA: Using DMAR IOMMU
> +
> +Intel Fault reporting
> +^^^^^^^^^^^^^^^^^^^^^
> +
> +::
> +
> +	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
> +	DMAR:[fault reason 05] PTE Write access is not set
> +	DMAR:[DMA Write] Request device [00:02.0] fault addr 6df084000
> +	DMAR:[fault reason 05] PTE Write access is not set
> +
> +AMD Boot Messages
> +^^^^^^^^^^^^^^^^^
> +
> +Something like this gets printed indicating presence of the IOMMU:
> +
> +::
> +
> +	AMD-Vi: Found IOMMU cap 0x40
> +	AMD-Vi: Extended features (0x4f77ef22294ada): PPR NX GT IA GA PC
> GA_vAPIC
> +	AMD-Vi: Interrupt remapping enabled
> +	AMD-Vi: Virtual APIC enabled
> +
> +AMD Fault reporting
> +^^^^^^^^^^^^^^^^^^^
> +
> +::
> +
> +	AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0007
> address=0xffffc02000 flags=0x0000]
> +	AMD-Vi: Event logged [IO_PAGE_FAULT device=07:00.0 domain=0x0007
> address=0xffffc02000 flags=0x0000]


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
