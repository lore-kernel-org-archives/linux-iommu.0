From: Linu Cherian <linuc.decode-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] virtio-iommu version 0.5
Date: Tue, 24 Oct 2017 11:57:04 +0530
Message-ID: <20171024062704.GA23141@virtx40>
References: <20171023093241.20113-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171023093241.20113-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: virtio-dev-sDuHXQ4OtrM4h7I2RyI4rWD2FQJk+8+b@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Jayachandran.Nair-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sunil.goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Jean,

On Mon Oct 23, 2017 at 10:32:41AM +0100, Jean-Philippe Brucker wrote:
> This is version 0.5 of the virtio-iommu specification, the paravirtualized
> IOMMU. This version addresses feedback from v0.4 and adds an event virtqueue.
> Please find the specification, LaTeX sources and pdf, at:
> git://linux-arm.org/virtio-iommu.git viommu/v0.5
> http://linux-arm.org/git?p=virtio-iommu.git;a=blob;f=dist/v0.5/virtio-iommu-v0.5.pdf
> 
> A detailed changelog since v0.4 follows. You can find the pdf diff at:
> http://linux-arm.org/git?p=virtio-iommu.git;a=blob;f=dist/diffs/virtio-iommu-pdf-diff-v0.4-v0.5.pdf
> 
> * Add an event virtqueue for the device to report translation faults to
>   the driver. For the moment only unrecoverable faults are available but
>   future versions will extend it.
> * Simplify PROBE request by removing the ack part, and flattening RESV
>   properties.
> * Rename "address space" to "domain". The change might seem futile but
>   allows to introduce PASIDs and other features cleanly in the next
>   versions. In the same vein, the few remaining "device" occurrences were
>   replaced by "endpoint", to avoid any confusion with "the device"
>   referring to the virtio device across the document.
> * Add implementation notes for RESV_MEM properties.
> * Update ACPI table definition.
> * Fix typos and clarify a few things.
> 
> I will publish the Linux driver for v0.5 shortly. Then for next versions
> I'll focus on optimizations and adding support for hardware acceleration.
> 
> Existing implementations are simple and can certainly be optimized, even
> without architectural changes. But the architecture itself can also be
> improved in a number of ways. Currently it is designed to work well with
> VFIO. However, having explicit MAP requests is less efficient* than page
> tables for emulated and PV endpoints, and the current architecture doesn't
> address this. Binding page tables is an obvious way to improve throughput
> in that case, but we can explore cleverer (and possibly simpler) ways to
> do it.
> 
> So first we'll work on getting the base device and driver merged, then
> we'll analyze and compare several ideas for improving performance.
> 
> Thanks,
> Jean
> 
> * I have yet to study this behaviour, and would be interested in any
> prior art on the subject of analyzing devices DMA patterns (virtio and
> others)


>From the spec,
Under future extensions.

"Page Table Handover, to allow guests to manage their own page tables and share them with the MMU"

Had few questions on this.

1. Did you mean SVM support for vfio-pci devices attached to guest processes here.

2. Can you give some hints on how this is going to work , since virtio-iommu guest kernel 
   driver need to create stage 1 page table as required by hardware which is not the case now. 
   CMIIW. 


-- 
Linu cherian
