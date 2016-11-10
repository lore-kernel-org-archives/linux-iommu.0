From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [RFC v2 2/8] iommu/iova: fix __alloc_and_insert_iova_range
Date: Thu, 10 Nov 2016 16:41:59 +0100
Message-ID: <e2e328c3-ac1f-cef6-2137-660ccefda8c9@redhat.com>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
 <1478258646-3117-3-git-send-email-eric.auger@redhat.com>
 <20161110152241.GF2078@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161110152241.GF2078@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: drjones@redhat.com, jason@lakedaemon.net, kvm@vger.kernel.org, marc.zyngier@arm.com, punit.agrawal@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, diana.craciun@nxp.com, alex.williamson@redhat.com, pranav.sawargaonkar@gmail.com, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, robin.murphy@arm.com, christoffer.dall@linaro.org, eric.auger.pro@gmail.com
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 10/11/2016 16:22, Joerg Roedel wrote:
> On Fri, Nov 04, 2016 at 11:24:00AM +0000, Eric Auger wrote:
>> Fix the size check within start_pfn and limit_pfn.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> the issue was observed when playing with 1 page iova domain with
>> higher iova reserved.
>> ---
>>  drivers/iommu/iova.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index e23001b..ee29dbf 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -147,7 +147,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>>  	if (!curr) {
>>  		if (size_aligned)
>>  			pad_size = iova_get_pad_size(size, limit_pfn);
>> -		if ((iovad->start_pfn + size + pad_size) > limit_pfn) {
>> +		if ((iovad->start_pfn + size + pad_size - 1) > limit_pfn) {
> 
> A >= check is more readable here.

Sure

Thanks

Eric
> 
> 
> 	Joerg
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
