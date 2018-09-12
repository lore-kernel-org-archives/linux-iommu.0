From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v2 08/10] vfio/type1: Add domain at(de)taching group
	helpers
Date: Wed, 12 Sep 2018 18:54:26 +0100
Message-ID: <04f5dc9d-71b1-37ec-402b-fae5f9e08664@arm.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
	<20180830040922.30426-9-baolu.lu@linux.intel.com>
	<c5124ac1-65fe-7f89-265c-bef229bc5ce9@arm.com>
	<a97c8f75-ff49-5b87-198f-d3c8950d4e90@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <a97c8f75-ff49-5b87-198f-d3c8950d4e90-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 12/09/2018 06:02, Lu Baolu wrote:
> Hi,
> 
> On 09/11/2018 12:23 AM, Jean-Philippe Brucker wrote:
>> On 30/08/2018 05:09, Lu Baolu wrote:
>>> +static int vfio_detach_aux_domain(struct device *dev, void *data)
>>> +{
>>> +	struct iommu_domain *domain = data;
>>> +
>>> +	vfio_mdev_set_aux_domain(dev, NULL);
>>> +	iommu_detach_device(domain, dev->parent);
>>
>> I think that's only going to work for vt-d, which doesn't use a
>> default_domain. For other drivers, iommu.c ends up calling
>> domain->ops->attach_dev(default_domain, dev) here, which isn't what we want.
> 
> This doesn't break any functionality. It takes effect only if iommu
> hardware supports finer granular translation and advertises it through
> the API.>
>> That was my concern with reusing attach/detach_dev callbacks for PASID
>> management. The attach_dev code of IOMMU drivers already has to deal
>> with toggling between default and unmanaged domain. Dealing with more
>> state transitions in the same path is going to be difficult.
> 
> Let's consider it from the API point of view.
> 
> We have iommu_a(de)ttach_device() APIs to attach or detach a domain
> to/from a device. We should avoid applying a limitation of "these are
> only for single domain case, for multiple domains, use another API".

That's an idealized view of the API, the actual semantics aren't as
simple. For IOMMU drivers that implement IOMMU_DOMAIN_DMA in their
domain_alloc operation (Arm SMMU, AMD IOMMU, ...), attach_dev attaches
an unmanaged domain, detach_dev reattaches the default DMA domain, and
the detach_dev IOMMU op is not called. We can't change that now, so it's
difficult to add more functionality to attach_dev and detach_dev.

Thanks,
Jean
