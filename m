Return-Path: <SRS0=wlUX=KJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565C4C43461
	for <iommu@archiver.kernel.org>; Fri, 14 May 2021 16:18:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E395361476
	for <iommu@archiver.kernel.org>; Fri, 14 May 2021 16:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E395361476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F30660612;
	Fri, 14 May 2021 16:17:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bw3W_ch9YBcM; Fri, 14 May 2021 16:17:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D8F5605E4;
	Fri, 14 May 2021 16:17:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BF91C000E;
	Fri, 14 May 2021 16:17:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7204BC0001
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 16:17:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 52FB260600
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 16:17:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cfWuAmrjIvYv for <iommu@lists.linux-foundation.org>;
 Fri, 14 May 2021 16:17:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C863B605E4
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 16:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=UIw7EfWmD3A5GJzYN/3QOUOCIyHuFu16FWOPf7ANc9Y=; b=ifFUHGd+/63UwWC7Lc9/oor7EB
 2xjO0Kj1AlFEpeDAwbOKeW8D81UORdDKkPxs7CF9lZHYha50YtQkAW8SwcBLPjO/SrcXyl30YTRho
 MbfBoG89yDCZm/Gp8aa++DAJcvdvSRYMC7EbFLh8FinG05Ku9EKpgWTM/v4BVl4jTXyWC3/LqjVgu
 bdtOV6sJX1hy0+oEpb6EvH7KJiIfkE8Gl1VaVjCNeplN1uBeqW+034RUscz+xQLCn+ISPdE0nf+rC
 ggxbKXYoIRATTWu1GzOpzi2ZHRBR0QVMYKgJfXEoeRUmTpW6t1lgOr2s3tTG29i7Rquf1zkW1OwXB
 T6ym8TIw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lhaVY-000693-Pi; Fri, 14 May 2021 10:17:49 -0600
To: Christoph Hellwig <hch@lst.de>
References: <20210513223203.5542-1-logang@deltatee.com>
 <20210513223203.5542-16-logang@deltatee.com> <20210514135712.GD4715@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6615c351-9c28-3a74-8c43-4aeb7993fb98@deltatee.com>
Date: Fri, 14 May 2021 10:17:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210514135712.GD4715@lst.de>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca,
 dan.j.williams@intel.com, sbates@raithlin.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 15/22] dma-direct: Support PCI P2PDMA pages in
 dma-direct map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Minturn Dave B <dave.b.minturn@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
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



On 2021-05-14 7:57 a.m., Christoph Hellwig wrote:
>> +	for_each_sg(sgl, sg, nents, i) {
>> +		if (sg_is_dma_pci_p2pdma(sg)) {
>> +			sg_dma_unmark_pci_p2pdma(sg);
>> +		} else  {
> 
> Double space here.  We also don't really need the curly braces to start
> with.
> 
>> +	struct pci_p2pdma_map_state p2pdma_state = {};
>> +	enum pci_p2pdma_map_type map;
>>  	struct scatterlist *sg;
>> +	int i, ret;
>>  
>>  	for_each_sg(sgl, sg, nents, i) {
>> +		if (is_pci_p2pdma_page(sg_page(sg))) {
>> +			map = pci_p2pdma_map_segment(&p2pdma_state, dev, sg);
>> +			switch (map) {
> 
> Why not just:
> 
> 			switch (pci_p2pdma_map_segment(&p2pdma_state, dev,
> 					sg)) {
> 
> (even better with a shorter name for p2pdma_state so that it all fits on
> a single line)?
> 
>> +			case PCI_P2PDMA_MAP_BUS_ADDR:
>> +				continue;
>> +			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>> +				/*
>> +				 * Mapping through host bridge should be
>> +				 * mapped normally, thus we do nothing
>> +				 * and continue below.
>> +				 */
> 
> I have a bit of a hard time parsing this comment.
> 
>> +		if (sg->dma_address == DMA_MAPPING_ERROR) {
>> +			ret = -EINVAL;
>>  			goto out_unmap;
>> +		}
>>  		sg_dma_len(sg) = sg->length;
>>  	}
>>  
>> @@ -411,7 +443,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>>  
>>  out_unmap:
>>  	dma_direct_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
>> -	return -EINVAL;
>> +	return ret;
> 
> Maybe just initialize ret to -EINVAL at declaration time to simplify this
> a bit?
>

All fair points, will fix in v3.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
