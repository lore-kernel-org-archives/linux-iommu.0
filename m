From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [RFC v2 4/8] iommu: Add a list of iommu_reserved_region in
 iommu_domain
Date: Thu, 10 Nov 2016 16:42:09 +0100
Message-ID: <a3b2dabc-efaf-6936-7fc4-19c779c9a9fc@redhat.com>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
 <1478258646-3117-5-git-send-email-eric.auger@redhat.com>
 <20161110153724.GG2078@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161110153724.GG2078@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: eric.auger.pro@gmail.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, drjones@redhat.com, linux-kernel@vger.kernel.org, pranav.sawargaonkar@gmail.com, iommu@lists.linux-foundation.org, punit.agrawal@arm.com, diana.craciun@nxp.com
List-Id: iommu@lists.linux-foundation.org

Hi Joerg, Robin,

On 10/11/2016 16:37, Joerg Roedel wrote:
> On Fri, Nov 04, 2016 at 11:24:02AM +0000, Eric Auger wrote:
>> Introduce a new iommu_reserved_region struct. This embodies
>> an IOVA reserved region that cannot be used along with the IOMMU
>> API. The list is protected by a dedicated mutex.
>>
>> An iommu domain now owns a list of those.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> ---
>>  drivers/iommu/iommu.c |  2 ++
>>  include/linux/iommu.h | 17 +++++++++++++++++
>>  2 files changed, 19 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 9a2f196..0af07492 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1061,6 +1061,8 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>>  
>>  	domain->ops  = bus->iommu_ops;
>>  	domain->type = type;
>> +	INIT_LIST_HEAD(&domain->reserved_regions);
>> +	mutex_init(&domain->resv_mutex);
> 
> These regions are a property of the iommu-group, they are specific to a
> device or a group of devices, not to a particular domain where devics
> (iommu-groups) can come and go.
> 
> Further I agree with Robin that this is similar to the
> get_dm_regions/set_dm_regions approach, which should be changed/extended
> for this instead of adding something new.
OK I am currently respinning, taking this into account. I will put the
reserved region file attribute in the iommu-group sysfs dir.

Thanks

Eric
> 
> 
> 	Joerg
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
