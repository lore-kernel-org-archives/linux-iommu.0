From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH v2 08/10] vfio/type1: Add domain at(de)taching group
 helpers
Date: Wed, 12 Sep 2018 13:02:00 +0800
Message-ID: <a97c8f75-ff49-5b87-198f-d3c8950d4e90@linux.intel.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
 <20180830040922.30426-9-baolu.lu@linux.intel.com>
 <c5124ac1-65fe-7f89-265c-bef229bc5ce9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c5124ac1-65fe-7f89-265c-bef229bc5ce9@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: baolu.lu@linux.intel.com, kevin.tian@intel.com, ashok.raj@intel.com, tiwei.bie@intel.com, sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, yi.y.sun@intel.com, jacob.jun.pan@intel.com, kvm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 09/11/2018 12:23 AM, Jean-Philippe Brucker wrote:
> On 30/08/2018 05:09, Lu Baolu wrote:
>> +static int vfio_detach_aux_domain(struct device *dev, void *data)
>> +{
>> +	struct iommu_domain *domain = data;
>> +
>> +	vfio_mdev_set_aux_domain(dev, NULL);
>> +	iommu_detach_device(domain, dev->parent);
> 
> I think that's only going to work for vt-d, which doesn't use a
> default_domain. For other drivers, iommu.c ends up calling
> domain->ops->attach_dev(default_domain, dev) here, which isn't what we want.

This doesn't break any functionality. It takes effect only if iommu
hardware supports finer granular translation and advertises it through
the API.

> 
> That was my concern with reusing attach/detach_dev callbacks for PASID
> management. The attach_dev code of IOMMU drivers already has to deal
> with toggling between default and unmanaged domain. Dealing with more
> state transitions in the same path is going to be difficult.

Let's consider it from the API point of view.

We have iommu_a(de)ttach_device() APIs to attach or detach a domain
to/from a device. We should avoid applying a limitation of "these are
only for single domain case, for multiple domains, use another API".

Best regards,
Lu Baolu
