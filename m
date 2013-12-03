From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/6] Crashdump Accepting Active IOMMU
Date: Tue, 03 Dec 2013 13:00:43 -0700
Message-ID: <1386100843.25738.284.camel@ul30vt.home>
References: <Crashdump-Accepting-Active-IOMMU>
	<1386099694-4190-1-git-send-email-bill.sumner@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1386099694-4190-1-git-send-email-bill.sumner-VXdhtT5mjnY@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bill Sumner <bill.sumner-VXdhtT5mjnY@public.gmane.org>
Cc: bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 2013-12-03 at 12:41 -0700, Bill Sumner wrote:
> The following series implements a fix for:
> A kdump problem about DMA that has been discussed for a long time. That is,
> when a kernel panics and boots into the kdump kernel, DMA started by the 
> panicked kernel is not stopped before the kdump kernel is booted and the 
> kdump kernel disables the IOMMU while this DMA continues.  This causes the
> IOMMU to stop translating the DMA addresses as IOVAs and begin to treat them 
> as physical memory addresses -- which causes the DMA to either:
> (1) generate DMAR errors or (2) generate PCI SERR errors or (3) transfer  
> data to or from incorrect areas of memory. Often this causes the dump to fail.

I didn't review the content, but please add commit logs per patch.  You
have a very thorough description here in the cover letter, but the cover
letter doesn't get stored in the code base.  Thanks,

Alex

> 
> This patch set modifies the behavior of the iommu in the (new) crashdump kernel: 
> 1. to accept the iommu hardware in an active state, 
> 2. to leave the current translations in-place so that legacy DMA will continue
>    using its current buffers until the device drivers in the crashdump kernel
>    initialize and initialize their devices,
> 3. to use different portions of the iova address ranges for the device drivers
>    in the crashdump kernel than the iova ranges that were in-use at the time
>    of the panic.  
> 
> Advantages of this approach:
> 1. All manipulation of the IO-device is done by the Linux device-driver
>    for that device.
> 2. This approach behaves in a manner very similar to operation without an
>    active iommu.
> 3. Any activity between the IO-device and its RMRR areas is handled by the
>    device-driver in the same manner as during a non-kdump boot.
> 4. If an IO-device has no driver in the kdump kernel, it is simply left alone.
>    This supports the practice of creating a special kdump kernel without
>    drivers for any devices that are not required for taking a crashdump. 
> 
> Changes since the RFC version of this patch:
> 1. Consolidated all of the operational code into the "copy..." functions.
>    The "process..." functions were primarily used for diagnostics and
>    exploration; however, there was a small amount of operational code that
>    used the "process..." functions.
>    This operational code has been moved into the "copy..." functions.
> 
> 2. Removed the "Process ..." functions and the diagnostic code that ran
>    on that function set.  This removed about 1/4 of the code -- which this
>    operational patch set no longer needs.  These portions of the RFC patch
>    could be formatted as a separate patch and submitted independently
>    at a later date. 
> 
> 3. Re-formatted the code to the Linux Coding Standards.
>    The checkpatch script still finds some lines to complain about;
>    however most of these lines are either (1) lines that I did not change,
>    or (2) lines that only changed by adding a level of indent which pushed
>    them over 80-characters, or (3) new lines whose intent is far clearer when
>    longer than 80-characters.
> 
> 4. Updated the remaining debug print to be significantly more flexible.
>    This allows control over the amount of debug print to the console --
>    which can vary widely.
> 
> 5. Fixed a couple of minor bugs found by testing on a machine with a
>    very large IO configuration.
> 
> At a high level, this code operates primarily during iommu initialization
> and device-driver initialization
> 
> During intel-iommu hardware initialization:
> In intel_iommu_init(void)
> * If (This is the crash kernel)
>   .  Set flag: crashdump_accepting_active_iommu (all changes below check this)
>   .  Skip disabling the iommu hardware translations
> 
> In init_dmars()
> * Duplicate the intel iommu translation tables from the old kernel
>   in the new kernel
>   . The root-entry table, all context-entry tables,
>     and all page-translation-entry tables
>   . The duplicate tables contain updated physical addresses to link them together.
>   . The duplicate tables are mapped into kernel virtual addresses
>     in the new kernel which allows most of the existing iommu code
>     to operate without change.
>   . Do some minimal sanity-checks during the copy
>   . Place the address of the new root-entry structure into "struct intel_iommu"
> 
> * Skip setting-up new domains for 'si', 'rmrr', 'isa' 
>   . Translations for 'rmrr' and 'isa' ranges have been copied from the old kernel
>   . This patch has not yet been tested with iommu pass-through enabled
> 
> * Existing (unchanged) code near the end of dmar_init:
>   . Loads the address of the (now new) root-entry structure from
>     "struct intel_iommu" into the iommu hardware and does the hardware flushes.
>     This changes the active translation tables from the ones in the old kernel
>     to the copies in the new kernel.
>   . This is legal because the translations in the two sets of tables are
>     currently identical:
>       Virtualization Technology for Directed I/O. Architecture Specification,
>       February 2011, Rev. 1.3  (section 11.2, paragraph 2) 
> 
> In iommu_init_domains()
> * Mark as in-use all domain-id's from the old kernel
>   . In case the new kernel contains a device that was not in the old kernel
>     and a new, unused domain-id is actually needed, the bitmap will give us one.
> 
> When a new domain is created for a device:
> * If (this device has a context in the old kernel)
>   . Get domain-id, address-width, and IOVA ranges from the old kernel context;
>   . Get address(page-entry-tables) from the copy in the new kernel;
>   . And apply all of the above values to the new domain structure.
> * Else
>   . Create a new domain as normal
> 
> --- 
> Signed-off-by: Bill Sumner <bill.sumner-VXdhtT5mjnY@public.gmane.org>
> 
> Bill Sumner (6):
>   Crashdump-Accepting-Active-IOMMU-Flags-and-Prototypes
>   Crashdump-Accepting-Active-IOMMU-Utility-functions
>   Crashdump-Accepting-Active-IOMMU-Domain-Interfaces
>   Crashdump-Accepting-Active-IOMMU-Copy-Translations
>   Crashdump-Accepting-Active-IOMMU-Debug-Print-IOMMU
>   Crashdump-Accepting-Active-IOMMU-Call-From-Mainline
> 
>  drivers/iommu/intel-iommu.c | 1292 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 1224 insertions(+), 68 deletions(-)
> 
