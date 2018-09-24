From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 0/7] Add non-strict mode support for iommu-dma
Date: Mon, 24 Sep 2018 15:35:20 +0100
Message-ID: <796e20eb-a0bd-f559-6cf2-f97fddf0114e@huawei.com>
References: <cover.1537458163.git.robin.murphy@arm.com>
	<fdfc05a4-283f-3ae2-7928-59e625c8f3b8@huawei.com>
	<50330f32-b051-bdf6-af26-3e24ed133480@arm.com>
	<61fb0f8f-a353-8ab6-f03d-b261da435c94@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <61fb0f8f-a353-8ab6-f03d-b261da435c94-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: chenxiang <chenxiang66-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, huawei.libin-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 21/09/2018 12:03, Robin Murphy wrote:
> On 21/09/18 10:29, Robin Murphy wrote:
>> Hi John,
>>
>> On 2018-09-21 10:20 AM, John Garry wrote:
>>> On 20/09/2018 17:10, Robin Murphy wrote:
>>>> Hi all,
>>>>
>>>> Hopefully this is the last spin of the series - I've now dropped my
>>>> light
>>>> touch and fixed up all the various prose text, plus implemented the
>>>> proper
>>>> quirk support for short-descriptor because it's actually just a trivial
>>>> cut-and-paste job.
>>>>
>>>> Robin.
>>>>
>>>
>>> Hi Robin,
>>>
>>> JFYI, I'm trying to test this patchset to get some figures and
>>> provide a tested-by tag, but 4/8 seems to rely on
>>> "iommu/io-pgtable-arm: Fix race handling in split_blk_unmap()" - more
>>> specifically, it seems to rely on the version which Will rewrote in
>>> your patch review, and I am not sure on what branch it exists on, if
>>> any.
>>
>> Sorry, I should have said this is based on Will's iommu/devel branch:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=iommu/devel
>
>
> FWIW I've now pushed out a complete branch here:
>
>   git://linux-arm.org/linux-rm iommu/non-strict
>

Cheers

So for my network test scenario I was getting a boost @ 250K vs 160K 
packet(s)/second with strict off/on

For NVMe single disk performance, I was getting a boost @ 582K vs 370K 
IOPS with strict off/on.

I wasn't seeing such a boost for other storage controller scenario 
(that's with 6 SSDs), with 776K vs 740K IOPS for strict off/on, but SMMU 
off was ~800K IOPS.

FWIW:
Tested-by: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>

Thanks,
John

>
> Robin.
>
> .
>
