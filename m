From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH v2 08/10] vfio/type1: Add domain at(de)taching group
 helpers
Date: Tue, 18 Sep 2018 16:52:19 +0100
Message-ID: <f46bcf5f-002b-4269-a750-c4254c9fc89f@arm.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
 <20180830040922.30426-9-baolu.lu@linux.intel.com>
 <c5124ac1-65fe-7f89-265c-bef229bc5ce9@arm.com>
 <a97c8f75-ff49-5b87-198f-d3c8950d4e90@linux.intel.com>
 <04f5dc9d-71b1-37ec-402b-fae5f9e08664@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191300D35@SHSMSX101.ccr.corp.intel.com>
 <c285871d-2ea0-5878-c7ac-ffa4ba8256ee@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191305A74@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D191305A74@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Tian, Kevin" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, "Bie, Tiwei" <tiwei.bie@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 15/09/2018 03:36, Tian, Kevin wrote:
>> 4) Userspace opens another mdev.
>> -> iommu.c calls domain->ops->attach_dev(domain2, dev)
> 
> another mdev in same VFIO container or different? I assume the
> latter since you mentioned a new domain2.

I was thinking a different VFIO container actually. I used domain2 to
try to make the example clearer

>> 1)? When the container is closed, VFIO calls
>> iommu_detach_device(domain2, parent_dev)
>> -> iommu.c calls default_domain->ops->attach_dev(default_domain, dev)
>> Given that auxiliary domains are attached, the IOMMU driver could deduce
>> that this actually means "detach an auxiliary domain". But which one?
> 
> I didn't get this one. There is no need to stick to 1) behavior for
> 4), i.e. below is expected:
>         domain2->ops->detach_dev(domain2, dev)

But in order to get that, the IOMMU core needs to know that domain2 is
auxiliary. Otherwise, detach_dev is never called when a default_domain
is present for the parent dev.

I guess one solution is to add an "auxiliary" attribute to iommu_domain,
so __iommu_detach_group would do something like:

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7113fe398b70..2b3e9b91aee7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1786,10 +1786,11 @@ static void __iommu_detach_group(struct
iommu_domain *domain,
 {
 	int ret;

-	if (!group->default_domain) {
+	if (!group->default_domain || domain->auxiliary) {
 		__iommu_group_for_each_dev(group, domain,
 					   iommu_group_do_detach_device);
-		group->domain = NULL;
+		if (!domain->auxiliary)
+			group->domain = NULL;
 		return;
 	}

Not sure who would set this "auxiliary" attribute... Maybe the IOMMU
driver, when attaching the domain to a device that has auxiliary mode
enabled?

> why cannot ARM implement a detach_dev for aux_domain too? My
> feeling is that default domain twist is only for switch between 1/2/3
> in concept.

If the core actually calls it, we can implement detach_dev :) The
problem is that the core never calls detach_dev when default_domain is
present (affects any IOMMU driver that relies on default_domain,
including AMD), and even in case 4) the default_domain is present for
the parent device

>> So the proposed interface doesn't seem to work as is. If we want to use
>> iommu_attach/detach_device for auxiliary domains, the existing behavior
>> of iommu.c, and IOMMU drivers that rely on it, have to change. Any
>> change I can think of right now seems more daunting than introducing a
>> different path for auxiliary domains, like iommu_attach_aux_domain for
>> example.
>> 
> 
> introducing *aux* specific API will cause different VFIO code path to
> handle RID-based and PASID-based mdev, since RID-based still needs
> to use normal attach_domain that way.

The PASID-based mdev still requires a special case to retrieve the
allocated PASID and program it in the parent device, so VFIO will need
to know the difference between the two

Thanks,
Jean

> well, this argument is not very strong
> in itself, if indeed proposed way doesn't work for ARM. But let's see
> whether it is the case with more understanding of your actual concern.
> 
> Thanks
> Kevin
