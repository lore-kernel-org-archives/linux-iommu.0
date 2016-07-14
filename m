From: nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Subject: Re: [PATCH] iommu/iova: validate iova_domain input to put_iova_domain
Date: Thu, 14 Jul 2016 13:55:32 -0400
Message-ID: <333f4b4f52168db68250a447ef5db3f3@codeaurora.org>
References: <1468435772-27905-1-git-send-email-nwatters@codeaurora.org>
	<20160714083420.GR12639@8bytes.org> <57876B45.6010206@arm.com>
	<77bca715-36e1-eb11-a49b-5d389b6cc0e8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <77bca715-36e1-eb11-a49b-5d389b6cc0e8-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2016-07-14 07:21, Auger Eric wrote:
> Hi Robin, Nate,
> On 14/07/2016 12:36, Robin Murphy wrote:
>> On 14/07/16 09:34, Joerg Roedel wrote:
>>> On Wed, Jul 13, 2016 at 02:49:32PM -0400, Nate Watterson wrote:
>>>> Passing a NULL or uninitialized iova_domain into put_iova_domain
>>>> will currently crash the kernel when the unconfigured iova_domain
>>>> data members are accessed. To prevent this from occurring, this 
>>>> patch
>>>> adds a check to make sure that the domain is non-NULL and that the
>>>> domain granule is non-zero. The granule can be used to check if the
>>>> domain was properly initialized because calling init_iova_domain
>>>> with a granule of zero would have already triggered a BUG statement
>>>> crashing the kernel.
>>> 
>>> Have you seen real crashes happening because of this?

In my case, it was calling iommu_request_dm_for_dev() which triggered 
the
"iommu_[get/put]_dma_cookie() without iommu_dma_init_domain()" issue 
that
has Robin documented below.

> 
> I also saw the crash happening with my PCIe passthrough series (not
> upstreamed)
> [PATCH v10 0/8] [PATCH v10 0/8] KVM PCIe/MSI passthrough on ARM/ARM64:
> kernel part 1/3: iommu changes  https://lkml.org/lkml/2016/6/7/676
> 
> patch [PATCH v10 8/8] iommu/arm-smmu: get/put the msi cookie
> also uses iommu_put_dma_cookie
> 
> 
> and the uninitialised lock crash happens if the group gets destroyed
> before the iommu_dma_init_domain is called, which can also happen for 
> me.
> 
>> 
>> It _can_ happen via the iommu-dma code if something goes wrong
>> initialising a group - the IOVA domain gets allocated at the same time
>> as the default IOMMU domain, but isn't initialised until later once 
>> the
>> device in question gets ity dma ops set up. If adding the device to 
>> the
>> group fails, everything gets torn down again and 
>> iommu_put_dma_cookie()
>> ends up trying to take an uninitialised lock .
> Cant' we allow the granule check also with UNMANAGED type?
> 
> Thanks
> 
> Eric
> 
>> 
>> However, I think the appropriate fix for that particular situation 
>> would
>> be more like this:
>> 
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index ea5a9ebf0f78..d00d22930a6b 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -65,10 +65,11 @@ void iommu_put_dma_cookie(struct iommu_domain 
>> *domain)
>>  {
>>         struct iova_domain *iovad = domain->iova_cookie;
>> 
>> -       if (!iovad)
>> +       if (domain->type != IOMMU_DOMAIN_DMA || !iovad)
>>                 return;
>> 
>> -       put_iova_domain(iovad);
>> +       if (iovad->granule)
>> +               put_iova_domain(iovad);
>>         kfree(iovad);
>>         domain->iova_cookie = NULL;
>>  }
>> 
>> (It probably should have been that way from the start; mea culpa)

I originally put together a similar patch, but then thought that people 
would
complain it didn't fix the root of the problem. Yet another instance 
where
thinking was best avoided I guess.

>> 
>> Robin.
>> _______________________________________________
>> iommu mailing list
>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>> 

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
