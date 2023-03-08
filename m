Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9C07C
	for <iommu@lists.linux.dev>; Wed,  8 Mar 2023 02:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678241344; x=1709777344;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=woVR2ZD8eombgINcedIWUBQofWyG0b8s7gkpgdn6/0E=;
  b=AhOwQrBhXluBYqWIGYf44LWcvd2nJnWlPM8F114sJkpd7bBpJvg/H0XO
   GkQAGppvWNq/iGLZxiPlIGD2PlzzZ/3EKXnPovHz+bamYhNJCHFqmTbL0
   7SjUzQPzxJmWCrGhnnO13hqUvJ9+ZwCvFYCrZSBoa4gVLm2nGCU69IG+I
   LmQTAqfZdT8U/KSZXnTih1uEcAschBiuC7i9bXc0RC1ZDdqH6qWsmBXUB
   7AGCT1OTD14zaFQP78oiTER/iJn7iCbxdB9ZIJFlREdbYcNDdQba7vZp9
   DM8UhmsjMCBU8o4mbvQLGa61kphShAkDOJJhbbOSClzkHVB0KFeRf2fNP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="324344067"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="324344067"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 18:09:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="740941933"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="740941933"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 07 Mar 2023 18:09:02 -0800
Message-ID: <d441b9bb-e9b2-190d-981b-1fdc288b0a07@linux.intel.com>
Date: Wed, 8 Mar 2023 10:08:04 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 00/14] Add iommufd physical device operations for replace
 and alloc hwpt
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB52764E0C994D6B2519BD6F9B8CB79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZAcyEzN4102gPsWC@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZAcyEzN4102gPsWC@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/7/23 8:46 PM, Jason Gunthorpe wrote:
> On Tue, Mar 07, 2023 at 08:42:06AM +0000, Tian, Kevin wrote:
>>> From: Jason Gunthorpe<jgg@nvidia.com>
>>> Sent: Saturday, February 25, 2023 8:28 AM
>>>
>> [...]
>>> The implementation is complicated because we have to introduce some
>>> per-iommu_group memory in iommufd and redo how we think about multi-
>>> device
>>> groups to be more explicit. This solves all the locking problems in the
>>> prior attempts.
>>>
>> Now think about the pasid case.
>>
>> pasid attach is managed as a device operation today:
>> 	iommu_attach_device_pasid()
>>
>> Following it naturally we'll have a pasid array per iommufd_device to
>> track attached HWPT per pasid.
>>
>> But internally there is only one pasid table per iommu group. i.e. same
>> story as RID attach that once dev1 replaces hwpt on pasid1 then it takes
>> effect on all other devices in the same group.
> IMHO I can't belive that any actual systems that support PASID have a
> RID aliasing problem too.
> 
> I think we should fix the iommu core to make PASID per-device and
> require systems that have a RID aliasing problem to block PASID.
> 
> This is a bigger picture, if drivers have to optionally share their
> PASID tables with other drivers then we can't have per-driver PASID
> allocators at all either.

This is actually required in PCI and IOMMU core. pci_enable_pasid()
requires full ACS support on device's upstream path:

        if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
                 return -EINVAL;

and, for such PCI topology, iommu core always allocates an exclusive
iommu group.

The only place where seems to be a little messy is,

static int __iommu_set_group_pasid(struct iommu_domain *domain,
                                    struct iommu_group *group, ioasid_t 
pasid)
{
         struct group_device *device;
         int ret = 0;

         list_for_each_entry(device, &group->devices, list) {
                 ret = domain->ops->set_dev_pasid(domain, device->dev, 
pasid);
                 if (ret)
                         break;
         }

         return ret;
}

Perhaps we need a check on singleton group?

Best regards,
baolu
