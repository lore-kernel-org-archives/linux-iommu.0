Return-Path: <SRS0=RnLw=MA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7CCC07E9B
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 01:01:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD6E561C4E
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 01:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6E561C4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87C604058F;
	Thu,  8 Jul 2021 01:01:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Fev4moy2Uee; Thu,  8 Jul 2021 01:01:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1073C40586;
	Thu,  8 Jul 2021 01:01:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD76FC0010;
	Thu,  8 Jul 2021 01:01:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 124E1C000E
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 01:00:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC8A44058F
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 01:00:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Agv5to-ai3IA for <iommu@lists.linux-foundation.org>;
 Thu,  8 Jul 2021 01:00:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 77D6A40586
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 01:00:04 +0000 (UTC)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20210708010001epoutp015ce85887b1a0739c63cabb1e6bd24cbd~Pqv7DvSsK2883528835epoutp01Z
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 01:00:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20210708010001epoutp015ce85887b1a0739c63cabb1e6bd24cbd~Pqv7DvSsK2883528835epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1625706001;
 bh=Qxs8LooR3HdG8k27xFBwkoR42vql37mR7brXE3bZ/Wc=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=ZC2f1LC4k4I57aLduoZZCMcOhAH+P1LlNwgbunM48u+KFBjz4iakrSzMG2YPLsQC+
 20eGw9v8+/20rbSnAjv2BiRruR2u965YBcraX13rLTel5XyD9ACrcFYVQ3njWtgwqm
 +5gR6SBQdTnxuieAVZunHrK/ALDKa5oNYwsV8wlI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20210708010001epcas2p49ecb517825175c20bc499cef5f5b7bec~Pqv6mS1kj0535305353epcas2p4a;
 Thu,  8 Jul 2021 01:00:01 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.186]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4GKycv13LKz4x9QL; Thu,  8 Jul
 2021 00:59:59 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 58.16.09571.D0E46E06; Thu,  8 Jul 2021 09:59:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20210708005957epcas2p130f8719491ffe109233df4e495132278~Pqv3VcYMl1626516265epcas2p1D;
 Thu,  8 Jul 2021 00:59:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210708005957epsmtrp1a3b519475a16268105f6373df7433402~Pqv3YCGby1587515875epsmtrp1Z;
 Thu,  8 Jul 2021 00:59:57 +0000 (GMT)
X-AuditID: b6c32a48-1dfff70000002563-81-60e64e0de51c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 88.F9.08394.D0E46E06; Thu,  8 Jul 2021 09:59:57 +0900 (KST)
Received: from KORDO031667 (unknown [10.229.8.53]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20210708005957epsmtip2f294db7a9fd472f7f9958c061b2102cf~Pqv3L-ulk3165931659epsmtip2_;
 Thu,  8 Jul 2021 00:59:57 +0000 (GMT)
From: =?ks_c_5601-1987?B?wMy5/L/r?= <bumyong.lee@samsung.com>
To: "'Dominique Martinet'" <dominique.martinet@atmark-techno.com>, "'Konrad
 Rzeszutek Wilk'" <konrad.wilk@oracle.com>
In-Reply-To: <20210707051254.2121603-1-dominique.martinet@atmark-techno.com>
Subject: RE: [PATCH] swiotlb: add overflow checks to swiotlb_bounce
Date: Thu, 8 Jul 2021 09:59:56 +0900
Message-ID: <000501d77394$91c686e0$b55394a0$@samsung.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQCb7e4cOzAJxPpfAB/aGbFVH9DsCgH3GiAprZ+TsbA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmmS6v37MEg5atyhaX92tbrD7gZLFy
 9VEmiwX7rS2WLX7KaHF51xw2i7VH7rJbHPzwhNWBw2PNvDWMHp3Ni5k8Jt9Yzuix+2YDm8fH
 p7dYPPq2rGL0+LxJLoA9KscmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE3
 1VbJxSdA1y0zB+gkJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BoWGBXnFibnFp
 Xrpecn6ulaGBgZEpUGVCTsabk2sZC2ZIVSzafJ+1gXG1SBcjJ4eEgInEju5+pi5GLg4hgR2M
 EvNnb2WDcD4xSkx4dgMq841R4uSv7yxdjBxgLQ9PV0DE9zJKnN3wEarjOaPEzenX2EHmsgnY
 Smw8vJsZxBYRKJe49ng/K0gRs8B3RokHL5tYQBKcAj4SP5vuM4HYwgLOEhN3/wSzWQRUJNZs
 3wZWwytgKTGt9SgThC0ocXLmE7A4s4CRxJLV85kgbHmJ7W/nMEM8pCDx8+kyVpBLRQSsJGaf
 MYEoEZGY3dnGDHKDhMBSDon2bTNYIepdJNo7WxghbGGJV8e3sEPYUhIv+9vYIRraGSU+X2+D
 WjAF6IOZaRC2vcSv6VtYIcGiLHHkFtRtfBIdh/+yQ4R5JTrahCBMVYmmm/UQjdISy87MYJ3A
 qDQLyWOzkDw2C8ljs5B8sICRZRWjWGpBcW56arFRgQlybG9iBKdXLY8djLPfftA7xMjEwXiI
 UYKDWUmEl9HhaYIQb0piZVVqUX58UWlOavEhRlNgWE9klhJNzgcm+LySeENTIzMzA0tTC1Mz
 IwslcV4O9kMJQgLpiSWp2ampBalFMH1MHJxSDUy5cxUrlr/mtjKc6vDFx0pYua2zvis9tpwn
 /J7k3eLjxlOLpij1XJzFISKRacNTElI327Hnmwhz8opmNd/vxWYB5zedSn+5ZKV58W3v9Yk7
 rL4uMM5dtC5S9/V7Y85eQf7Sgnv8Ym0Jy7a8rEr6X3qCReRp0Ec1Xr1EI28Ry1nM/WfY0h9n
 lduF6p2aF7gp39sy+/2UNDtTBxXRu1vveTJXxU7wy3E/ZRDh8MNubkvzya9Vt2X6Zk+4zLaj
 q7j7Gs+/Uy+vuR5w9POd8eCa3g2TOL6rqavN9t9RN1o/MzX0Rxdz3eNatidrK+IVGbxeJk07
 U5p4fuKqNxOCLEyZbbu6tB+dnuaoYqj4PMdZiaU4I9FQi7moOBEAv2ivbzgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJXpfX71mCwaHNghaX92tbrD7gZLFy
 9VEmiwX7rS2WLX7KaHF51xw2i7VH7rJbHPzwhNWBw2PNvDWMHp3Ni5k8Jt9Yzuix+2YDm8fH
 p7dYPPq2rGL0+LxJLoA9issmJTUnsyy1SN8ugSvjzcm1jAUzpCoWbb7P2sC4WqSLkYNDQsBE
 4uHpii5GLg4hgd2MEie/z2PvYuQEiktLvGj9xgphC0vcbznCClH0lFHi2JnrLCAJNgFbiY2H
 dzOD2CIC5RJ9U/oZQYqYBX4zSnQs/cgM0TGXUeLgjZ9gHZwCPhI/m+4zgdjCAs4SE3f/BLNZ
 BFQk1mzfBlbDK2ApMa31KBOELShxcuYTsDgz0KmNh7uhbHmJ7W/nMEOcpyDx8+kyVpB3RASs
 JGafMYEoEZGY3dnGPIFReBaSSbOQTJqFZNIsJC0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX
 5qXrJefnbmIEx5mW5g7G7as+6B1iZOJgPMQowcGsJMLL6PA0QYg3JbGyKrUoP76oNCe1+BCj
 NAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamNtNNB0OXy/BdWu7D0n9NpNJBylvNTeuV
 +IVmh9Atp+0/rL18lEmIhfNrR+n02kfimTdfrDc+xvtTtTLU9xx7weOW/z2+vz9qOyZLdbpa
 SN+WL54VIyLK8aV9pUX79HKXRa1pxV7X3DbKFCta77FJkao5fzPyIBefAMuKS3bLdk2tKnIO
 ZfCa6ZGfelKrXphF2SNEtsA6u9jtreaGif5KswoZtdb8a2246a3cr1x5u2nXR1ZNPt66svdu
 BfbLDx46NL0/1KZX/Zen8GZOW04On512a470/j2Rc8XbXf7OfZ2V/DoHtfj3ptvs2pXaJs49
 x+zmhFPHnVglJu1jejxhsx6L6pmEc132d//yK7EUZyQaajEXFScCACG84PEiAwAA
X-CMS-MailID: 20210708005957epcas2p130f8719491ffe109233df4e495132278
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210707051319epcas2p17d3e2198cd50a5511447283273feb6d3
References: <CGME20210707051319epcas2p17d3e2198cd50a5511447283273feb6d3@epcas2p1.samsung.com>
 <20210707051254.2121603-1-dominique.martinet@atmark-techno.com>
X-Mailman-Approved-At: Thu, 08 Jul 2021 01:01:46 +0000
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 'Chanho Park' <chanho61.park@samsung.com>,
 'Robin Murphy' <robin.murphy@arm.com>, 'Christoph Hellwig' <hch@lst.de>
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

> This is a follow-up on 5f89468e2f06 ("swiotlb: manipulate orig_addr when
> tlb_addr has offset") which fixed unaligned dma mappings, making sure the
> following overflows are caught:
> 
> - offset of the start of the slot within the device bigger than requested
> address' offset, in other words if the base address given in
> swiotlb_tbl_map_single to create the mapping (orig_addr) was after the
> requested address for the sync (tlb_offset) in the same block:
> 
>  |------------------------------------------| block
>               <----------------------------> mapped part of the block
>               ^
>               orig_addr
>        ^
>        invalid tlb_addr for sync
> 
> - if the resulting offset was bigger than the allocation size this one
> could happen if the mapping was not until the end. e.g.
> 
>  |------------------------------------------| block
>       <---------------------> mapped part of the block
>       ^                               ^
>       orig_addr                       invalid tlb_addr
> 
> Both should never happen so print a warning and bail out without trying to
> adjust the sizes/offsets: the first one could try to sync from orig_addr
> to whatever is left of the requested size, but the later really has
> nothing to sync there...
> 
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Bumyong Lee <bumyong.lee@samsung.com>

Reviewed-by: Bumyong Lee <bumyong.lee@samsung.com

> Cc: Chanho Park <chanho61.park@samsung.com>
> Cc: Christoph Hellwig <hch@lst.de>
> ---
> 
> Hi Konrad,
> 
> here's the follow up for the swiotlb/caamjr regression I had promissed.
> It doesn't really change anything, and I confirmed I don't hit either of
> the warnings on our board, but it's probably best to have as either could
> really happen.
> 
> 
>  kernel/dma/swiotlb.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c index
> e50df8d8f87e..23f8d0b168c5 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -354,13 +354,27 @@ static void swiotlb_bounce(struct device *dev,
> phys_addr_t tlb_addr, size_t size
>  	size_t alloc_size = mem->slots[index].alloc_size;
>  	unsigned long pfn = PFN_DOWN(orig_addr);
>  	unsigned char *vaddr = phys_to_virt(tlb_addr);
> -	unsigned int tlb_offset;
> +	unsigned int tlb_offset, orig_addr_offset;
> 
>  	if (orig_addr == INVALID_PHYS_ADDR)
>  		return;
> 
> -	tlb_offset = (tlb_addr & (IO_TLB_SIZE - 1)) -
> -		     swiotlb_align_offset(dev, orig_addr);
> +	tlb_offset = tlb_addr & (IO_TLB_SIZE - 1);
> +	orig_addr_offset = swiotlb_align_offset(dev, orig_addr);
> +	if (tlb_offset < orig_addr_offset) {
> +		dev_WARN_ONCE(dev, 1,
> +			"Access before mapping start detected. orig offset
%u,
> requested offset %u.\n",
> +			orig_addr_offset, tlb_offset);
> +		return;
> +	}
> +
> +	tlb_offset -= orig_addr_offset;
> +	if (tlb_offset > alloc_size) {
> +		dev_WARN_ONCE(dev, 1,
> +			"Buffer overflow detected. Allocation size: %zu.
> Mapping size: %zu+%u.\n",
> +			alloc_size, size, tlb_offset);
> +		return;
> +	}
> 
>  	orig_addr += tlb_offset;
>  	alloc_size -= tlb_offset;
> --
> 2.30.2


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
