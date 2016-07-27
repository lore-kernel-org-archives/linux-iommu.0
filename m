From: nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Subject: Re: [PATCH] iommu/dma: Don't put uninitialised IOVA domains
Date: Wed, 27 Jul 2016 13:42:16 -0400
Message-ID: <afc96620e9a571be46bc7b718d063541@codeaurora.org>
References: <d88eb3dc42377b8aa7947d2b0141f28589ae645f.1469634042.git.robin.murphy@arm.com>
	<1990f273-4bdb-1a33-70ae-7811d5ae1ea5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1990f273-4bdb-1a33-70ae-7811d5ae1ea5-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2016-07-27 12:00, Auger Eric wrote:
> Hi,
> On 27/07/2016 17:46, Robin Murphy wrote:
>> Due to the limitations of having to wait until we see a device's DMA
>> restrictions before we know how we want an IOVA domain initialised,
>> there is a window for error if a DMA ops domain is allocated but later
>> freed without ever being used. In that case, init_iova_domain() was
>> never called, so calling put_iova_domain() from iommu_put_dma_cookie()
>> ends up trying to take an uninitialised lock and crashing.
>> 
>> Make things robust by skipping the call unless the IOVA domain 
>> actually
>> has been initialised, as we probably should have done from the start.
>> 
>> Reported-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>> 
>> I'm not sure this warrants a cc stable, as with the code currently in
>> mainline it's only at all likely if other things have already failed
>> elsewhere in a manner they should not be expected to.
>> 
>>  drivers/iommu/dma-iommu.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index ea5a9ebf0f78..97a23082e18a 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -68,7 +68,8 @@ void iommu_put_dma_cookie(struct iommu_domain 
>> *domain)
>>  	if (!iovad)
>>  		return;
>> 
>> -	put_iova_domain(iovad);
>> +	if (iovad->granule)
>> +		put_iova_domain(iovad);
>>  	kfree(iovad);
>>  	domain->iova_cookie = NULL;
>>  }
>> 
> Reviewed-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Tested-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> Thanks
> 
> Eric
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

Reviewed-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Tested-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
