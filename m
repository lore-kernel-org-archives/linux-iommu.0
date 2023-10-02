Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8B31A5BD
	for <iommu@lists.linux.dev>; Mon,  2 Oct 2023 14:32:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43F0CC15;
	Mon,  2 Oct 2023 07:32:54 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FCAA3F762;
	Mon,  2 Oct 2023 07:32:14 -0700 (PDT)
Message-ID: <ec116189-c087-0b2c-180b-d6a369f21a60@arm.com>
Date: Mon, 2 Oct 2023 15:32:10 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 2/7] iommu: Decouple iommu_present() from bus ops
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
References: <cover.1696253096.git.robin.murphy@arm.com>
 <c734557f46fa5ea79b766ce847b003e31096d0bb.1696253096.git.robin.murphy@arm.com>
 <20231002141704.GG339126@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231002141704.GG339126@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/10/2023 3:17 pm, Jason Gunthorpe wrote:
> On Mon, Oct 02, 2023 at 02:49:10PM +0100, Robin Murphy wrote:
>> Much as I'd like to remove iommu_present(), the final remaining users
>> are proving stubbornly difficult to clean up, so kick that can down the
>> road and just rework it to preserve the current behaviour without
>> depending on bus ops. Since commit 57365a04c921 ("iommu: Move bus setup
>> to IOMMU device registration"), any registered IOMMU instance is already
>> considered "present" for every entry in iommu_buses, so it's simply a
>> case of validating the bus and checking we have at least once IOMMU.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>
>> ---
>>
>> v3: Tweak to use the ops-based check rather than group-based, to
>>      properly match the existing behaviour
>> v4: Just look for IOMMU instances instead of managed devices
>> ---
>>   drivers/iommu/iommu.c | 21 ++++++++++++++++++++-
>>   1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index f7793d1b5c3e..ef7feb0acc34 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1988,9 +1988,28 @@ int bus_iommu_probe(const struct bus_type *bus)
>>   	return 0;
>>   }
>>   
>> +/**
>> + * iommu_present() - make platform-specific assumptions about an IOMMU
>> + * @bus: bus to check
>> + *
>> + * Do not use this function. You want device_iommu_mapped() instead.
>> + *
>> + * Return: true if some IOMMU is present and aware of devices on the given bus;
>> + * in general it may not be the only IOMMU, and it may not have anything to do
>> + * with whatever device you are ultimately interested in.
>> + */
>>   bool iommu_present(const struct bus_type *bus)
>>   {
>> -	return bus->iommu_ops != NULL;
>> +	bool ret = false;
>> +
>> +	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
>> +		if (iommu_buses[i] == bus) {
>> +			spin_lock(&iommu_device_lock);
>> +			ret = !list_empty(&iommu_device_list);
>> +			spin_unlock(&iommu_device_lock);
>> +		}
> 
> Add here:
> 
> return ret;
> 
>> +	}
>> +	return ret;
> 
> And this becomes
> 
> return false
> 
> ?

My aim here was for the smallest, simplest code, given that what we 
still really want is no code, and this is basically only being retained 
to serve that one tricky Tegra callsite. I guess I could have also added 
"&& !ret" to the loop condition, but either way since this should never 
be on a hot path I figured it's not worth the bother just to save a 
handful of extra comparisons.

> Regardless
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks!

Robin.
