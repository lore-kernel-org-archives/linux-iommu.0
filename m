From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 0/7] vfio/type1: Add support for valid iova list
	management
Date: Thu, 24 May 2018 12:20:32 -0600
Message-ID: <20180524122032.724676b9@w520.home>
References: <20180418114045.7968-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180418114045.7968-1-shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shameer Kolothum <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pmorel-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

[Cc +Joerg: AMD-Vi observation towards the end]

On Wed, 18 Apr 2018 12:40:38 +0100
Shameer Kolothum <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org> wrote:

> This series introduces an iova list associated with a vfio 
> iommu. The list is kept updated taking care of iommu apertures,
> and reserved regions. Also this series adds checks for any conflict
> with existing dma mappings whenever a new device group is attached to
> the domain.
> 
> User-space can retrieve valid iova ranges using VFIO_IOMMU_GET_INFO
> ioctl capability chains. Any dma map request outside the valid iova
> range will be rejected.

Hi Shameer,

I ran into two minor issues in testing this series, both related to
mdev usage of type1.  First, in patch 5/7 when we try to validate a dma
map request:

> +static bool vfio_iommu_iova_dma_valid(struct vfio_iommu *iommu,
> +				dma_addr_t start, dma_addr_t end)
> +{
> +	struct list_head *iova = &iommu->iova_list;
> +	struct vfio_iova *node;
> +
> +	list_for_each_entry(node, iova, list) {
> +		if ((start >= node->start) && (end <= node->end))
> +			return true;
> +	}
> +
> +	return false;
> +}

A container with only an mdev device will have an empty list because it
has not backing iommu to set ranges or reserved regions, so any dma map
will fail.  I think this is resolved as follows:

--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1100,7 +1100,7 @@ static bool vfio_iommu_iova_dma_valid(struct vfio_iommu *iommu,
                        return true;
        }
 
-       return false;
+       return list_empty(&iommu->iova_list);
 }
 
ie. return false only if there was anything to test against.

The second issue is similar, patch 6/7 adds to VFIO_IOMMU_GET_INFO:

+		ret = vfio_iommu_iova_build_caps(iommu, &caps);
+		if (ret)
+			return ret;

And build_caps has:

+	list_for_each_entry(iova, &iommu->iova_list, list)
+		iovas++;
+
+	if (!iovas) {
+		ret = -EINVAL;

Therefore if the iova list is empty, as for mdevs, the use can no
longer even call VFIO_IOMMU_GET_INFO on the container, which is a
regression.  Again, I think the fix is simple:

@@ -2090,7 +2090,7 @@ static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
                iovas++;
 
        if (!iovas) {
-               ret = -EINVAL;
+               ret = 0;
                goto out_unlock;
        }
 
ie. build_caps needs to handle lack of an iova_list as a non-error.

Also, I wrote a small unit test to validate the iova list for my
systems[1].  With the above changes, my Intel test system gives expected
results:

# ./vfio-type1-iova-list /sys/bus/mdev/devices/c08db5ed-05d3-4b39-b150-438a18bc698f /sys/bus/pci/devices/0000:00:1b.0
---- Adding device: c08db5ed-05d3-4b39-b150-438a18bc698f ----
Initial info struct size: 0x18
No caps
---- Adding device: 0000:00:1b.0 ----
Initial info struct size: 0x18
Requested info struct size: 0x48
New info struct size: 0x48
argsz: 0x48, flags: 0x3, cap_offset: 0x18
	00: 4800 0000 0300 0000 00f0 ffff ffff ffff
	10: 1800 0000 0000 0000 0100 0100 0000 0000
	20: 0200 0000 0000 0000 0000 0000 0000 0000
	30: ffff dffe 0000 0000 0000 f0fe 0000 0000
	40: ffff ffff ffff ff01 
[cap id: 1, version: 1, next: 0x0]
Found type1 iova range version: 1
	00: 0000000000000000 - 00000000fedfffff
	01: 00000000fef00000 - 01ffffffffffffff

Adding an mdev device to the container results in no iova list, adding
the physical device updates to the expected set with the MSI range
excluded.

I was a little surprised by an AMD system:

# ./vfio-type1-iova-list /sys/bus/pci/devices/0000:01:00.0
---- Adding device: 0000:01:00.0 ----
Initial info struct size: 0x18
Requested info struct size: 0x58
New info struct size: 0x58
argsz: 0x58, flags: 0x3, cap_offset: 0x18
	00: 5800 0000 0300 0000 00f0 ffff 7fff ffff
	10: 1800 0000 0000 0000 0100 0100 0000 0000
	20: 0300 0000 0000 0000 0000 0000 0000 0000
	30: ffff dffe 0000 0000 0000 f0fe 0000 0000
	40: ffff ffff fc00 0000 0000 0000 0001 0000
	50: ffff ffff ffff ffff 
[cap id: 1, version: 1, next: 0x0]
Found type1 iova range version: 1
	00: 0000000000000000 - 00000000fedfffff
	01: 00000000fef00000 - 000000fcffffffff
	02: 0000010000000000 - ffffffffffffffff

The additional excluded range is the HyperTransport area (which for
99.9+% of use cases isn't going to be a problem) is a rather surprising
limit for the size of a VM we can use on AMD, just under 1TB.  I fully
expect we'll see a bug report from that and we should be thinking about
how to address it.  Otherwise, if the changes above look good to you
I'll incorporate them into their respective patches and push to my next
branch.  Thanks,

Alex

[1] https://gist.github.com/awilliam/25e39252ab28101a2d89ace1ff765fdd
