From: "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 0/8] io-pgtable lock removal
Date: Mon, 26 Jun 2017 21:19:40 +0800
Message-ID: <595109EC.5000201@huawei.com>
References: <cover.1498145008.git.robin.murphy@arm.com>
	<61b7b953-5bf4-eb45-c3e8-b4491e8fdca7@huawei.com>
	<f694a247-9006-3a3c-8a77-209b158eabf3@arm.com>
	<9bbf18c7-34ba-6e94-53bd-3f75059c1bb2@huawei.com>
	<a75e4c19-e393-f030-6927-debae27957eb@arm.com>
	<15e7ce0a-bf4b-cc77-3600-c37ed865a4d7@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <15e7ce0a-bf4b-cc77-3600-c37ed865a4d7-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: sunil.goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 2017/6/26 21:12, John Garry wrote:
> 
>>>
>>> I saw Will has already sent the pull request. But, FWIW, we are seeing
>>> roughly the same performance as v1 patchset. For PCI NIC, Zhou again
>>> found performance drop goes from ~15->8% with SMMU enabled, and for
>>> integrated storage controller [platform device], we still see a drop of
>>> about 50%, depending on datarates (Leizhen has been working on fixing
>>> this).
>>
>> Thanks for confirming. Following Joerg's suggestion that the storage
>> workloads may still depend on rbtree performance - it had slipped my
>> mind that even with small block sizes those could well be grouped into
>> scatterlists large enough to trigger a >64-page IOVA allocation - I've
>> taken the liberty of cooking up a simplified version of Leizhen's rbtree
>> optimisation series in the iommu/iova branch of my tree. I'll follow up
>> on that after the merge window, but if anyone wants to play with it in
>> the meantime feel free.
The main problem is lock confliction of cmd queue. I have prepared my patchset,
I will send it later.

> 
> Just a reminder that we did also see poor performance with our integrated NIC on your v1 patchset also (I can push for v2 patchset testing, but expect the same).
> 
> We might be able to now include a LSI 3108 PCI SAS card in our testing also to give a broader set of results.
> 
> John
> 
>>
>> Robin.
>>
>> .
>>
> 
> 
> 
> .
> 

-- 
Thanks!
BestRegards
