From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] MAINTAINERS: use the iommu list for the dma-mapping
	subsystem
Date: Fri, 1 Sep 2017 10:48:50 +0100
Message-ID: <5b7d88b3-001e-7413-7bf3-789c234f7fdd@arm.com>
References: <20170826092734.12859-1-hch@lst.de>
	<CGME20170901075028epcas5p3485e17a0d67207bb42dd3f4d6d33aff2@epcas5p3.samsung.com>
	<20170901075018.GA23035@lst.de>
	<d7006533-4925-b869-c901-d619da5166d4@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <d7006533-4925-b869-c901-d619da5166d4-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 01/09/17 08:56, Marek Szyprowski wrote:
> Hi Christoph,
> 
> On 2017-09-01 09:50, Christoph Hellwig wrote:
>> Any comments?  I'd like to add this to the 4.14 pull request.
>>
>> On Sat, Aug 26, 2017 at 11:27:34AM +0200, Christoph Hellwig wrote:
>>> Maintaining a subsystem with linux-kernel as the main list is painful
>>> as it has way to much traffic.  On the other hand the dma-mapping
>>> subsystem is small enough that a list on its own would be silly.
>>> So use the list for the closes subsystem instead instead.
>>>
>>> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> 
> Like I already said, its fine for me.
> Acked-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Fine by me too.

Joerg, Alex, are you OK with the odd bit of extra ML traffic?

Thanks,
Robin.

>>> ---
>>>   MAINTAINERS | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 6f7721d1634c..1df11ed346a7 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -4175,7 +4175,7 @@ DMA MAPPING HELPERS
>>>   M:    Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
>>>   M:    Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>>   R:    Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>>> -L:    linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> +L:    iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
>>>   T:    git git://git.infradead.org/users/hch/dma-mapping.git
>>>   W:    http://git.infradead.org/users/hch/dma-mapping.git
>>>   S:    Supported
>>> -- 
>>> 2.11.0
> 
> Best regards
