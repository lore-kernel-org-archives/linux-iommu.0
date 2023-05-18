Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807167E
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 07:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684393562; x=1715929562;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9agQxg5bvZCEiPO3PP4r8dyZAobzZ5RKZtw1oa41Muo=;
  b=MIVC6LJ1dmav6Pt5m7tvQML+cmaHXtEXqIzovdH+Ui7MiNg0B8U+nxRv
   JNRgz+OqcLLxTpmFqQCLcO6w8vstT5ELSh9mgFLSsu72VwABM/d86tDe0
   7XtJx+iu79vzSU8yrRGyC0h93GvNjgfqYDximk6OGcp3LqEkQHhtCT0C+
   ElMWssbCiagjoYWKYiBzVqziWuFtQxKGKQvIAFMb7xcDRiz+SbLTfSEIJ
   wunAbtKDlsHytiSpcIB2VkXqaJYm2c3lz2+1HzHMOlLEVVHCkzGYMldjz
   gzyK46mpIPImyklU/aTZMFtZcz6o5HzWOD/lmwpHuW8N18ghHbytdr8Ph
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="380196152"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="380196152"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 00:06:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="767079155"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="767079155"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.30.48]) ([10.255.30.48])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 00:05:25 -0700
Message-ID: <5cdc1a83-f29b-6862-d513-dbfd5c500807@linux.intel.com>
Date: Thu, 18 May 2023 15:05:23 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Lixiao Yang <lixiao.yang@intel.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 03/19] iommufd: Replace the hwpt->devices list with
 iommufd_group
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
References: <3-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
 <569b959e-a702-fc19-3d67-0dde4e77251a@linux.intel.com>
 <ZGN2yvhpIvrvu74r@nvidia.com>
 <852e85b3-9fd2-bfc2-6080-82cea7ab6abd@linux.intel.com>
 <BN9PR11MB5276DE1BC30E90B1032C0E468C7E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGTMCSJKvgpyYxG/@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZGTMCSJKvgpyYxG/@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/5/17 20:43, Jason Gunthorpe wrote:
> On Wed, May 17, 2023 at 06:33:30AM +0000, Tian, Kevin wrote:
>>> From: Baolu Lu <baolu.lu@linux.intel.com>
>>> Sent: Wednesday, May 17, 2023 12:15 PM
>>>
>>> On 5/16/23 8:27 PM, Jason Gunthorpe wrote:
>>>> On Tue, May 16, 2023 at 11:00:16AM +0800, Baolu Lu wrote:
>>>>> On 5/15/23 10:00 PM, Jason Gunthorpe wrote:
>>>>>> The devices list was used as a simple way to avoid having per-group
>>>>>> information. Now that this seems to be unavoidable, just commit to
>>>>>> per-group information fully and remove the devices list from the HWPT.
>>>>>>
>>>>>> The iommufd_group stores the currently assigned HWPT for the entire
>>> group
>>>>>> and we can manage the per-device attach/detach with a list in the
>>>>>> iommufd_group.
>>>>>
>>>>> I am preparing the patches to route I/O page faults to user space
>>>>> through iommufd. The iommufd page fault handler knows the hwpt and
>>> the
>>>>> device pointer, but it needs to convert the device pointer into its
>>>>> iommufd object id and pass the id to user space.
>>>>>
>>>>> It's fine that we remove the hwpt->devices here, but perhaps I need to
>>>>> add the context pointer in ioas later,
>>>>>
>>>>> struct iommufd_ioas {
>>>>>           struct io_pagetable iopt;
>>>>>           struct mutex mutex;
>>>>>           struct list_head hwpt_list;
>>>>> +       struct iommufd_ctx *ictx;
>>>>>    };
>>>>>
>>>>> and, use below helper to look up the device id.
>>>>>
>>>>> +u32 iommufd_get_device_id(struct iommufd_ctx *ictx, struct device *dev)
>>>>> +{
>>>>> +       struct iommu_group *group = iommu_group_get(dev);
>>>>> +       u32 dev_id = IOMMUFD_INVALID_OBJ_ID;
>>>>> +       struct iommufd_group *igroup;
>>>>> +       struct iommufd_device *cur;
>>>>> +       unsigned int id;
>>>>> +
>>>>> +       if (!group)
>>>>> +               return IOMMUFD_INVALID_OBJ_ID;
>>>>> +
>>>>> +       id = iommu_group_id(group);
>>>>> +       xa_lock(&ictx->groups);
>>>>> +       igroup = xa_load(&ictx->groups, id);
>>>>> +       if (!iommufd_group_try_get(igroup, group)) {
>>>>> +               xa_unlock(&ictx->groups);
>>>>> +               iommu_group_put(group);
>>>>> +               return IOMMUFD_INVALID_OBJ_ID;
>>>>> +        }
>>>>> +        xa_unlock(&ictx->groups);
>>>>> +
>>>>> +       mutex_lock(&igroup->lock);
>>>>> +       list_for_each_entry(cur, &igroup->device_list, group_item) {
>>>>> +               if (cur->dev == dev) {
>>>>> +                       dev_id = cur->obj.id;
>>>>> +                       break;
>>>>> +               }
>>>>> +       }
>>>>
>>>> I dislike how slow this is on something resembling a fastish path :\
>>>
>>> Yes, agreed.
>>>
>>>> Maybe we should stash something in the dev_iommu instead?
>>>>
>>>> Or can the PRI stuff provide a cookie per-device?
>>>
>>> We already have a per-device fault cookie:
>>>
>>> /**
>>>    * struct iommu_fault_param - per-device IOMMU fault data
>>>    * @handler: Callback function to handle IOMMU faults at device level
>>>    * @data: handler private data
>>>    * @faults: holds the pending faults which needs response
>>>    * @lock: protect pending faults list
>>>    */
>>> struct iommu_fault_param {
>>>           iommu_dev_fault_handler_t handler;
>>>           void *data;
>>>           struct list_head faults;
>>>           struct mutex lock;
>>> };
>>>
>>> Perhaps we can add a @dev_id memory here?
>>>
>>
>> what about SIOV? There is only one cookie per parent device.
> 
> It doesn't make any sense to store a struct like that in dev_iommu.
> 
> The fault handler should come from the domain and we should be able to
> have a unique 'void *data' cookie linked to the (dev,PASID) to go
> along with the fault handler.

If I get your point correctly, the iommu core should provide some places
for the iommufd to put a cookie for each pair of {device, pasid}, and
provide interfaces to manage it. For example,

void iommu_set_device_fault_cookie(struct device *dev,
				   ioasit_t pasid,
				   void *fault_cookie);

void *iommu_get_device_fault_cookie(struct device *dev,
				    ioasit_t pasid)

If so, perhaps we need some special treatment for ARM as a user hwpt
actually presents the PASID table of the device and the guest setting
pasid table entry will not be propagated to host. Then, the @pasid in
above interfaces is meaningless.

> This is all going to need some revising before we can expose it to
> iommufd

Yes, agreed. i will post a preparation series to do this. Besides the
fault cookie, at least, I want to do the following preparation.

1) Move iommu faults uapi from uapi/linux/iommu.h to uapi/linux
   /iommufd.h and remove the former.

2) Add a device id in the iommu_fault structure.
  struct iommu_fault {
         __u32   type;
-       __u32   padding;
+       __u32   dev_id;
         union {
                 struct iommu_fault_unrecoverable event;
                 struct iommu_fault_page_request prm;

3) Add the device pointer to the parameters of domain fault handler.

4) Decouple I/O page fault handling from IOMMU_SVA in the iommu core and
    the drivers.

Best regards,
baolu
