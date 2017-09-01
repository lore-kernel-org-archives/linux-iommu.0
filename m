From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] MAINTAINERS: use the iommu list for the dma-mapping
 subsystem
Date: Fri, 01 Sep 2017 09:56:04 +0200
Message-ID: <d7006533-4925-b869-c901-d619da5166d4@samsung.com>
References: <20170826092734.12859-1-hch@lst.de>
        <CGME20170901075028epcas5p3485e17a0d67207bb42dd3f4d6d33aff2@epcas5p3.samsung.com>
        <20170901075018.GA23035@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20170901075018.GA23035@lst.de>
Content-language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On 2017-09-01 09:50, Christoph Hellwig wrote:
> Any comments?  I'd like to add this to the 4.14 pull request.
>
> On Sat, Aug 26, 2017 at 11:27:34AM +0200, Christoph Hellwig wrote:
>> Maintaining a subsystem with linux-kernel as the main list is painful
>> as it has way to much traffic.  On the other hand the dma-mapping
>> subsystem is small enough that a list on its own would be silly.
>> So use the list for the closes subsystem instead instead.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>

Like I already said, its fine for me.
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

>> ---
>>   MAINTAINERS | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6f7721d1634c..1df11ed346a7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4175,7 +4175,7 @@ DMA MAPPING HELPERS
>>   M:	Christoph Hellwig <hch@lst.de>
>>   M:	Marek Szyprowski <m.szyprowski@samsung.com>
>>   R:	Robin Murphy <robin.murphy@arm.com>
>> -L:	linux-kernel@vger.kernel.org
>> +L:	iommu@lists.linux-foundation.org
>>   T:	git git://git.infradead.org/users/hch/dma-mapping.git
>>   W:	http://git.infradead.org/users/hch/dma-mapping.git
>>   S:	Supported
>> -- 
>> 2.11.0

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
