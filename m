From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC PATCH 2/6] drivers core: Add I/O ASID allocator
Date: Thu, 22 Nov 2018 06:59:03 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19BE5A636@SHSMSX101.ccr.corp.intel.com>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
	<20181019181158.2395-3-jean-philippe.brucker@arm.com>
	<20181112144039.GA25808@8bytes.org>
	<8f17757a-c657-aab9-a6a0-fb0cc9c610a8@arm.com>
	<62f05552-df46-6e12-10ed-820429dfda59@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <62f05552-df46-6e12-10ed-820429dfda59-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Koenig, Christian
> Sent: Thursday, November 22, 2018 3:10 AM
> 
> Am 21.11.18 um 12:16 schrieb Jean-Philippe Brucker:
> > On 12/11/2018 14:40, Joerg Roedel wrote:
> >> Hi Jean-Philippe,
> >>
> >> On Fri, Oct 19, 2018 at 07:11:54PM +0100, Jean-Philippe Brucker wrote:
> >>> The allocator doesn't really belong in drivers/iommu because some
> >>> drivers would like to allocate PASIDs for devices that aren't managed by
> >>> an IOMMU, using the same ID space as IOMMU. It doesn't really
> belong in
> >>> drivers/pci either since platform device also support PASID. Add the
> >>> allocator in drivers/base.
> >> I don't really buy this argument, in the end it is the IOMMU that
> >> enforces the PASID mappings for a device. Why should a device not
> behind
> >> an IOMMU need to allocate a pasid? Do you have examples of such
> devices
> >> which also don't have their own iommu built-in?
> > I misunderstood that requirement. Reading through the thread again
> > (https://www.mail-archive.com/iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> foundation.org/msg25640.html)
> > it's more about a device using PASIDs as context IDs. Some contexts are
> > not bound to processes but they still need their ID in the same PASID
> > space as the contexts that are bound to process address spaces. So we
> > can keep that code in drivers/iommu
> 
> The problem with that approach is that we also need this allocator when
> IOMMU is completely disabled.
> 
> In other words PASIDs are used as contexts IDs by the hardware for
> things like signaling which application has caused an interrupt/event
> even when they are not used by IOMMU later on.
> 
> Additional to that we have some MMUs which are internal to the devices
> (GPUVM on AMD GPUs for example, similar exists for NVidia) which uses
> PASIDs for address translation internally in the device.
> 
> All of that is completely unrelated to IOMMU, but when IOMMU is enabled
> you need to use the same allocator because all use cases use the same ID
> space.
> 

imo context ID is a resource used by device internal while PASID is sth.
informational to external world (as defined in PCI bus package). ideally two 
things are separate in hardware but can be associated (e.g. PASID as an 
optional parameter per context). That is what I know for Intel GPUs.

For your device, is "PASIDs are used as contexts IDs" a software 
implementation policy or actual hardware requirement (i.e. no dedicated
PASID recording)?

Thanks
Kevin
