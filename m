From: Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 0/2] iommu/s390: Fix iommu-groups and add sysfs support
Date: Fri, 28 Apr 2017 20:06:12 +0200
Message-ID: <20170428200612.42b4f3d2@thinkpad>
References: <1493306905-32334-1-git-send-email-joro@8bytes.org>
	<20170427201018.70c8be5a@thinkpad>
	<20170427210325.GE1332@8bytes.org>
	<20170428144634.7950c8cf@thinkpad>
	<20170428145513.GH1332@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170428145513.GH1332-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 28 Apr 2017 16:55:13 +0200
Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> > I am however a bit confused now, about how we would have allowed group
> > sharing with the current s390 IOMMU code, or IOW in which scenario would
> > iommu_group_get() in the add_device callback find a shareable iommu-group?  
> 
> The usual way to do this is to use the iommu_group_get_for_dev()
> function, which invokes the iommu_ops->device_group call-back of the
> driver to find a matching group or allocating a new one.
> 
> There are ready-to-use functions for this call-back already:
> 
> 	1) generic_device_group() - which just allocates a new group for
> 	   the device. This is usually used outside of PCI
> 
> 	2) pci_device_group() - Which walks the PCI hierarchy to find
> 	   devices that are not isolated and uses the matching group for
> 	   its isolation domain.
> 
> A few drivers have their own versions of this call-back, but those are
> IOMMU drivers supporting multiple bus-types and need to find the right
> way to determine the group first.
> 
> > So, I guess we may have an issue with not sharing iommu-groups when
> > it could make sense to do so. But your patch would not fix this, as
> > we still would allocate separate iommu-groups for all functions.  
> 
> Yes, but the above approach won't help when each function ends up on a
> seperate bus because the code looks for different functions that are
> enumerated as such. Anyway, some more insight into how this enumeration
> works on s390 would be great :)

Since Sebastian confirmed this, it looks like we do not really have any
enumeration when there is a separate bus for each function.

Also, IIRC, add_device will get called before attach_dev. Currently we
allow to attach more than one device (apparently from different buses) to
one domain (one shared DMA table) in attach_dev. But then it would be too
late to also add all devices to the same iommu-group. That would have had
to be done earlier in add_device, but there we don't know yet if a shared
DMA table would be set up later in attach_dev.

So, it looks to me that we cannot provide correct iommu-group sharing
on s390, even though we allow iommu-domain sharing, which sounds odd. Since
this "shared domain / DMA table" option in attach_dev was only added
because at that time I thought that was a hard requirement for any arch-
specific IOMMU API implementation, maybe there was some misunderstanding.

It would make the code easier (and more consistent with the s390 hardware)
if I would just remove that option from attach_dev, and allow only one
device/function per iommu-domain. What do you think, could this be removed
for s390, or is there any common code requirement for providing that option
(and is it OK that we have separate iommu-groups in this case)?

Regards,
Gerald
