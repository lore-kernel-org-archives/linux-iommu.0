From: Wan Zongshun <vw@iommu.org>
Subject: Re: [PATCH 5/6] iommu/amd: Add support for non-pci devices
Date: Sat, 9 Jan 2016 17:47:15 +0800
Message-ID: <5690D723.7020003@iommu.org>
References: <1451988444-4694-1-git-send-email-vincent.wan@amd.com>
 <1451988444-4694-6-git-send-email-vincent.wan@amd.com>
 <20160107120422.GB19149@8bytes.org>
 <CAKT61h9retMxx8JiWEHYRVkX7ROXVvsYDJ3WZDoL17YhdjJdBA@mail.gmail.com>
 <20160108121855.GU18805@8bytes.org> <568FCD4B.4000807@iommu.org>
 <20160108170145.GW18805@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160108170145.GW18805@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Wan Zongshun <vincent.wan@amd.com>, linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, Ray Huang <ray.huang@amd.com>, Borislav Petkov <bp@suse.de>, ken.xue@amd.com
List-Id: iommu@lists.linux-foundation.org



-------- Original Message --------
> On Fri, Jan 08, 2016 at 10:52:59PM +0800, Wan Zongshun wrote:
>> Actually I am supposing the '.add_device' will be the first called
>> in iommu initializing stage, so I think as long as having no error
>> of check device here, any call-sites of get_device_id() will be
>> fine, because adding device successfully should be the pre-condition
>> of any iommu function can be performed, please correct me.
>>
>> static int amd_iommu_add_device(struct device *dev)
>> {
>> 	struct iommu_dev_data *dev_data;
>> 	struct iommu_domain *domain;
>> 	struct amd_iommu *iommu;
>> 	u16 devid;
>> 	int ret;
>>
>> 	if (!check_device(dev) || get_dev_data(dev))
>> 		return 0;
>>
>> 	devid = get_device_id(dev);
>> 	iommu = amd_iommu_rlookup_table[devid];
>
> There are places in the interrupt remapping code that call get_device_id
> without calling check_device first. See get_irq_domain and get_devid.
>

Okay, I will change this get_device_id return to int, and judge this 
return value in caller of this function like get_devid style.

If so we will modify some existing amd iommu driver codes, and Can I 
merge those into this patch 5/6? or I will create another dedicated 
patch to take this action?

Vincent.

>
> 	Joerg
>
>
