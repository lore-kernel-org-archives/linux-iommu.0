From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/4] numa, iommu/smmu: IOMMU/SMMU driver optimization for
	NUMA systems
Date: Wed, 22 Aug 2018 17:07:55 +0100
Message-ID: <ec57224a-7673-97d8-bb0c-c612080625bc@huawei.com>
References: <20170921085922.11659-1-ganapatrao.kulkarni@cavium.com>
	<452f1665-eb3a-5e8c-f671-099ef4a15d84@huawei.com>
	<a7fc1e43-3652-562a-1e59-499be80b567c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <a7fc1e43-3652-562a-1e59-499be80b567c-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Ganapatrao Kulkarni <ganapatrao.kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Cc: "mhocko-IBi9RG/b67k@public.gmane.org" <mhocko-IBi9RG/b67k@public.gmane.org>, "Tomasz.Nowicki-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <Tomasz.Nowicki-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "Robert.Richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <Robert.Richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "Will.Deacon-5wv7dgnIgG8@public.gmane.org" <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "gklkml16-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <gklkml16-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "vbabka-AlSwsSmVLrQ@public.gmane.org" <vbabka-AlSwsSmVLrQ@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "jnair-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <jnair-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 22/08/2018 15:56, Robin Murphy wrote:
> Hi John,
>
> On 22/08/18 14:44, John Garry wrote:
>> On 21/09/2017 09:59, Ganapatrao Kulkarni wrote:
>>> Adding numa aware memory allocations used for iommu dma allocation and
>>> memory allocated for SMMU stream tables, page walk tables and command
>>> queues.
>>>
>>> With this patch, iperf testing on ThunderX2, with 40G NIC card on
>>> NODE 1 PCI shown same performance(around 30% improvement) as NODE 0.
>>>
>>> Ganapatrao Kulkarni (4):
>>>   mm: move function alloc_pages_exact_nid out of __meminit
>>>   numa, iommu/io-pgtable-arm: Use NUMA aware memory allocation for smmu
>>>     translation tables
>>>   iommu/arm-smmu-v3: Use NUMA memory allocations for stream tables and
>>>     comamnd queues
>>>   iommu/dma, numa: Use NUMA aware memory allocations in
>>>     __iommu_dma_alloc_pages
>>>
>>>  drivers/iommu/arm-smmu-v3.c    | 57
>>> +++++++++++++++++++++++++++++++++++++-----
>>>  drivers/iommu/dma-iommu.c      | 17 +++++++------
>>>  drivers/iommu/io-pgtable-arm.c |  4 ++-
>>>  include/linux/gfp.h            |  2 +-
>>>  mm/page_alloc.c                |  3 ++-
>>>  5 files changed, 67 insertions(+), 16 deletions(-)
>>>
>>
>> Hi Ganapatrao,
>>
>> Have you any plans for further work on this patchset? I have not seen
>> anything since this v1 was posted+discussed.
>

Hi Robin,

Thanks for the info. I thought I remembered 4b12 but couldn't put my 
finger on it.

> Looks like I ended up doing the version of the io-pgtable change that I
> suggested here, which was merged recently (4b123757eeaa). Patch #3
> should also be effectively obsolete now since the SWIOTLB/dma-direct
> rework (21f237e4d085). Apparently I also started reworking patch #4 in
> my tree at some point but sidelined it - I think that was at least
> partly due to another thread[1] which made it seem less clear-cut
> whether this is always the right thing to do.

Right, so #4 seems less straightforward and not directly related to 
IOMMU driver anyway.

Cheers,
John

>
> Robin.
>
> [1]
> https://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg1693026.html
>
> .
>
