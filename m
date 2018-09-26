From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH v2 08/10] vfio/type1: Add domain at(de)taching group
 helpers
Date: Wed, 26 Sep 2018 10:11:03 +0800
Message-ID: <1b4c12c3-1dc2-d9ba-9ba4-5220db3e2302@linux.intel.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
 <20180830040922.30426-9-baolu.lu@linux.intel.com>
 <c5124ac1-65fe-7f89-265c-bef229bc5ce9@arm.com>
 <a97c8f75-ff49-5b87-198f-d3c8950d4e90@linux.intel.com>
 <04f5dc9d-71b1-37ec-402b-fae5f9e08664@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191300D35@SHSMSX101.ccr.corp.intel.com>
 <c285871d-2ea0-5878-c7ac-ffa4ba8256ee@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191305A74@SHSMSX101.ccr.corp.intel.com>
 <f46bcf5f-002b-4269-a750-c4254c9fc89f@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19130EAD7@SHSMSX101.ccr.corp.intel.com>
 <75517c87-6ffd-2023-a541-3c69ae52ef4b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <75517c87-6ffd-2023-a541-3c69ae52ef4b@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>, "Bie, Tiwei" <tiwei.bie@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 09/26/2018 01:55 AM, Jean-Philippe Brucker wrote:
> On 19/09/2018 00:26, Tian, Kevin wrote:
>>> If the core actually calls it, we can implement detach_dev :) The
>>> problem is that the core never calls detach_dev when default_domain is
>>> present (affects any IOMMU driver that relies on default_domain,
>>> including AMD), and even in case 4) the default_domain is present for
>>> the parent device
>>
>> Then can we change that core logic so detach_dev is invoked in all
>> cases? yes there will be some changes in vendor drivers, but I expect
>> this change trivial (especially considering the gain in IOMMU API
>> simplicity side as described below).
> 
> Thinking more about this, there might be a way that doesn't require too
> much rewriting of IOMMU drivers. When VFIO calls iommu_detach_group to
> detach a vfio-pci device from its domain, it could do detach_dev(dev,
> old_domain) followed by attach_dev(dev, default_domain) instead of only
> attach_dev(dev, default_domain), so:
> 
> __iommu_attach_group(grp, unmanaged_domain)
>    ops->attach_dev(dev, unmanaged_domain)
>      -> IOMMU driver detaches from default_domain only if the dev isn't
>         in auxiliary mode
> 
> __iommu_detach_group(grp, unmanaged_domain)
>    if (ops->detach_dev)
>        ops->detach_dev(dev, unmanaged_domain)
>    ops->attach_dev(dev, default_domain)
>      -> IOMMU driver ignores this if still attached to default_domain
> 

This looks good to me.

Just a minor change to make it more readable.

__iommu_detach_group(grp, unmanaged_domain)
     if (ops->detach_dev)
         ops->detach_dev(dev, unmanaged_domain)
     if (default_domain)
         ops->attach_dev(dev, default_domain)

Best regards,
Lu Baolu

> It's not trivial: since half the IOMMU drivers seem to be using default
> domain now, their detach_dev callback might have been dead code for a
> while (I can't find a path where it still gets called), so re-enabling
> it requires some attention. However, since most of them won't care about
> aux domains, maybe we could just remove their detach_dev pointer.
> 
> The resulting logic of attach/detach_dev in IOMMU drivers that do use
> aux domains still seems unnecessarily convoluted. It could as well be
> done with separate attach_aux/detach_aux functions. If you want to keep
> it that way though, I think the above could work for us and I'll try to
> write an RFC.
> 
> Thanks,
> Jean
> 
