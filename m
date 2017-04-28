From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/2] iommu/s390: Fix iommu-groups and add sysfs support
Date: Fri, 28 Apr 2017 16:55:13 +0200
Message-ID: <20170428145513.GH1332@8bytes.org>
References: <1493306905-32334-1-git-send-email-joro@8bytes.org>
	<20170427201018.70c8be5a@thinkpad>
	<20170427210325.GE1332@8bytes.org>
	<20170428144634.7950c8cf@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170428144634.7950c8cf@thinkpad>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Gerald,

On Fri, Apr 28, 2017 at 02:46:34PM +0200, Gerald Schaefer wrote:
> On Thu, 27 Apr 2017 23:03:25 +0200
> Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> 
> > > Well, there is a separate zpci_dev for each pci_dev on s390,
> > > and each of those has its own separate dma-table (thus not shared).  
> > 
> > Is that true for all functions of a PCIe card, so does every function of
> > a device has its own zpci_dev structure and thus its own DMA-table?
> 
> Yes, clp_add_pci_device() is called for every function, which in turn calls
> zpci_create_device() with a freshly allocated zdev. zpci_enable_device()
> then sets up a new DMA address space for each function.

That sounds special :) So will every function of a single device end up
as a seperate device on a seperate root-bus?

> > My assumption came from the fact that the zpci_dev is read from
> > pci_dev->sysdata, which is propagated there from the pci_bridge
> > through the pci_root_bus structures.
> 
> The zdev gets there via zpci_create_device() -> zpci_scan_bus() ->
> pci_scan_root_bus(), which is done for every single function.
> 
> Not sure if I understand this right, but it looks like we set up a new PCI
> bus for each function.

Yeah, it sounds like this. Maybe Sebastian can confirm that?

> I am however a bit confused now, about how we would have allowed group
> sharing with the current s390 IOMMU code, or IOW in which scenario would
> iommu_group_get() in the add_device callback find a shareable iommu-group?

The usual way to do this is to use the iommu_group_get_for_dev()
function, which invokes the iommu_ops->device_group call-back of the
driver to find a matching group or allocating a new one.

There are ready-to-use functions for this call-back already:

	1) generic_device_group() - which just allocates a new group for
	   the device. This is usually used outside of PCI

	2) pci_device_group() - Which walks the PCI hierarchy to find
	   devices that are not isolated and uses the matching group for
	   its isolation domain.

A few drivers have their own versions of this call-back, but those are
IOMMU drivers supporting multiple bus-types and need to find the right
way to determine the group first.

> So, I guess we may have an issue with not sharing iommu-groups when
> it could make sense to do so. But your patch would not fix this, as
> we still would allocate separate iommu-groups for all functions.

Yes, but the above approach won't help when each function ends up on a
seperate bus because the code looks for different functions that are
enumerated as such. Anyway, some more insight into how this enumeration
works on s390 would be great :)


Regards,

	Joerg
