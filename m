Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1092C54E8E
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 13:00:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A75C4206CC
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 13:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XA062SCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75C4206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6779888178;
	Tue, 12 May 2020 13:00:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qw7eBraDh6k0; Tue, 12 May 2020 13:00:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3CC2686C12;
	Tue, 12 May 2020 13:00:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 211F7C0178;
	Tue, 12 May 2020 13:00:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EB8AC016F
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 13:00:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1BFD62632A
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 13:00:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ihfPqdc2svgl for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 13:00:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by silver.osuosl.org (Postfix) with ESMTPS id B283320017
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 13:00:35 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200512130033euoutp024271a1b5e4172b3489fd005e38a70cc6~OSWjamshp2911929119euoutp02b
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 13:00:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200512130033euoutp024271a1b5e4172b3489fd005e38a70cc6~OSWjamshp2911929119euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589288433;
 bh=1uzzQOyNb7Mv/r9ipa91ltDY7wY8vT4HL7FRN1tYdZM=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=XA062SCu4VBCXYmsYEUM2iZVfXIfYdH1ggs1x/ZCZ2W/rZExETBsDtzWrMojhjiwQ
 U6O3uXvVPK/NtdyDKEBR+Saeza67YUvU2S0OYPMN14Vmsg3IT7ivMONGuxSHU7rpug
 Hp320L5KJwVKkpUAVLJtYbVt0jXPDmecTJZ+Ur94=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200512130032eucas1p1f73e728ec6203501ba81ebfeef9eef6e~OSWjHUrIM0405704057eucas1p1q;
 Tue, 12 May 2020 13:00:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 7F.F8.60679.0FD9ABE5; Tue, 12
 May 2020 14:00:32 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200512130032eucas1p1b4a35fc40a37196f67477d042455479c~OSWisXm8w0405804058eucas1p1h;
 Tue, 12 May 2020 13:00:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200512130032eusmtrp19afb98684ac9523b752ffa9d028963e1~OSWirtUcz3237932379eusmtrp1B;
 Tue, 12 May 2020 13:00:32 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-30-5eba9df0e0af
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 1F.F7.07950.0FD9ABE5; Tue, 12
 May 2020 14:00:32 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200512130031eusmtip16fed83b076c2cc5d92d4b400faec47e2~OSWiFPXJW0680906809eusmtip1F;
 Tue, 12 May 2020 13:00:31 +0000 (GMT)
Subject: Re: [PATCH v4 01/38] dma-mapping: add generic helpers for mapping
 sgtable objects
To: Christoph Hellwig <hch@lst.de>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <1a80255d-81de-2c5d-6d06-ea126fd7f994@samsung.com>
Date: Tue, 12 May 2020 15:00:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200512121808.GA20393@lst.de>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRj1t/vY3ejKdRp+qBSsBxSl9oBuJFEQcQshCSIqZ628mKjTdjNT
 qMzsNTU1rWyVrgzMR9o2U7tlpWBrWSt0lanQQyV7jCyXpYXldnv43znnO9/vnA9+FKbqJIKo
 eN1uXq/TJqpJJd5wb/Tx/KELYkx4c344m+ewy1hzSR3B/mooxFjn108kW1ndJmNNd5axbudr
 GWvpe0awneJ5km0Z6idWKLma0hrENY+YcK5x5BXBvcyxyTjr5QNcz3gfxhV1VSDu5otMkjtR
 X4W4Ycu0KOVmZUQsnxi/h9eHLd+m3Jl3sBildMHeyuomlIm++xuQggJmMRSPHSUNSEmpmCsI
 HrkLkUTcCAa/vSIkMoygtO80/nelcjAHkwYVCD435sgl8mmCuLK9Ln8mGh7euoZ5cACjhoH3
 j7zvYoxDBsb8Dq+JZBaAwWUgPZhmloN53I48GGdmgbngIuHBUxkNtJdbkeTxA/vZfu+ugpkH
 d26KXh1jpkOj6zwm4UDo7i+TecKAccnhS9mwXOq9Csp//cAk7A/vbfV/9BBoL8rFpYVDCF47
 rsolkougM6sESa5l0OsYm6hKTUTMgToxTJJXgmjrl3tkYHyhy+UnlfCFkw1nMEmm4dgRleSe
 DUZb7b/YlicdWAFSGyedZpx0jnHSOcb/uSaEV6FAPlVIiuOFhTo+LVTQJgmpurjQHclJFjTx
 1drHbe4mJP7c3ooYCqmn0D77xBgVod0jpCe1IqAwdQCdHX8jRkXHatMzeH3yVn1qIi+0omAK
 VwfSiy6906iYOO1uPoHnU3j936mMUgRlotrYiLWKMeco2bZWkfF0ce9da+Q5s29hcv3tkfy3
 fpsGdB9r3eutWcFrAmhziebchsrpj+0hkQ+eB7QcWN24Mfx+TPZozwy9Mm1VBG0aJeindQMo
 ryyN7PBZvd9q2XgKPjjfJLxbF7aLP349eObSdM3hbmzNpi1R0eklYvUS07QsNS7s1C6Yi+kF
 7W/ftLrNZgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xu7of5u6KM/g9Tdyi99xJJouNM9az
 WvzfNpHZ4srX92wWK1cfZbJYsN/a4suVh0wWmx5fY7W4vGsOm8XBD09YHbg81sxbw+ix99sC
 Fo/t3x6wetzvPs7ksXlJvcftf4+ZPSbfWM7osftmA5tH35ZVjB6fN8kFcEXp2RTll5akKmTk
 F5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZfQ2TmEsuCFRsXL1DsYG
 xh/CXYycHBICJhIrX3QzdzFycQgJLGWUuPSwnR0iISNxcloDK4QtLPHnWhcbRNFbRon/K9aD
 FQkLxEic2bOBGcQWEVCSePrqLCNIEbPABSaJGzuPgiWEBJ4zSrycAWazCRhKdL0FmcTJwStg
 J7Hx30lGEJtFQFVi44SFYNtEBWIlVl9rZYSoEZQ4OfMJC4jNKaAjsX/3LrA4s4CZxLzND5kh
 bHmJ7W/nQNniEreezGeawCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGRXnFibnFpXrpe
 cn7uJkZgDG879nPLDsaud8GHGAU4GJV4eCPqd8UJsSaWFVfmHmKU4GBWEuFtydwZJ8SbklhZ
 lVqUH19UmpNafIjRFOi5icxSosn5wPSSVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7
 NbUgtQimj4mDU6qBMfaQU9YMIfHlF58VKPmu+HnUXS9CWHu2wYktvz+YRv3Yz+U8z3E1V4Cz
 dOChvNkcsx00RLTMZFfcz59rdywsLuufEvOVS5tnhNxS83Oq4+aJ6PnouK0kKXuKTUhwXAnr
 lEJJd49P3IdVgu4IsR2Wu3pvzZQqlgtz+75euzT14OlVX56XOiqtVWIpzkg01GIuKk4EAJQJ
 QYT3AgAA
X-CMS-MailID: 20200512130032eucas1p1b4a35fc40a37196f67477d042455479c
X-Msg-Generator: CA
X-RootMTR: 20200512090107eucas1p13a38ce5ce4c15cd0033acaea7b26c9b0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200512090107eucas1p13a38ce5ce4c15cd0033acaea7b26c9b0
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
 <CGME20200512090107eucas1p13a38ce5ce4c15cd0033acaea7b26c9b0@eucas1p1.samsung.com>
 <20200512090058.14910-1-m.szyprowski@samsung.com>
 <20200512121808.GA20393@lst.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Christoph,

On 12.05.2020 14:18, Christoph Hellwig wrote:
> On Tue, May 12, 2020 at 11:00:21AM +0200, Marek Szyprowski wrote:
>> struct sg_table is a common structure used for describing a memory
>> buffer. It consists of a scatterlist with memory pages and DMA addresses
>> (sgl entry), as well as the number of scatterlist entries: CPU pages
>> (orig_nents entry) and DMA mapped pages (nents entry).
>>
>> It turned out that it was a common mistake to misuse nents and orig_nents
>> entries, calling DMA-mapping functions with a wrong number of entries or
>> ignoring the number of mapped entries returned by the dma_map_sg
>> function.
>>
>> To avoid such issues, lets introduce a common wrappers operating directly
>> on the struct sg_table objects, which take care of the proper use of
>> the nents and orig_nents entries.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>> For more information, see '[PATCH v4 00/38] DRM: fix struct sg_table nents
>> vs. orig_nents misuse' thread:
>> https://lore.kernel.org/dri-devel/20200512085710.14688-1-m.szyprowski@samsung.com/T/
>> ---
>>   include/linux/dma-mapping.h | 79 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 79 insertions(+)
>>
>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>> index b43116a..88f01cc 100644
>> --- a/include/linux/dma-mapping.h
>> +++ b/include/linux/dma-mapping.h
>> @@ -609,6 +609,85 @@ static inline void dma_sync_single_range_for_device(struct device *dev,
>>   	return dma_sync_single_for_device(dev, addr + offset, size, dir);
>>   }
>>   
>> +/**
>> + * dma_map_sgtable - Map the given buffer for the DMA operations
>> + * @dev:	The device to perform a DMA operation
>> + * @sgt:	The sg_table object describing the buffer
>> + * @dir:	DMA direction
>> + * @attrs:	Optional DMA attributes for the map operation
>> + *
>> + * Maps a buffer described by a scatterlist stored in the given sg_table
>> + * object for the @dir DMA operation by the @dev device. After success
>> + * the ownership for the buffer is transferred to the DMA domain. One has
>> + * to call dma_sync_sgtable_for_cpu() or dma_unmap_sgtable() to move the
>> + * ownership of the buffer back to the CPU domain before touching the
>> + * buffer by the CPU.
>> + * Returns 0 on success or -EINVAL on error during mapping the buffer.
>> + */
>> +static inline int dma_map_sgtable(struct device *dev, struct sg_table *sgt,
>> +		enum dma_data_direction dir, unsigned long attrs)
>> +{
>> +	int n = dma_map_sg_attrs(dev, sgt->sgl, sgt->orig_nents, dir, attrs);
>> +
>> +	if (n > 0) {
>> +		sgt->nents = n;
>> +		return 0;
>> +	}
>> +	return -EINVAL;
> Nit:  code tend to be a tad easier to read if the the exceptional
> condition is inside the branch block, so:
>
> 	if (n <= 0)
> 		return -EINVAL;
> 	sgt->nents = n;
> 	return 0;
>
Indeed this version looks much better. I will resend it in a few minutes.
> Otherwise this looks good to me:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
