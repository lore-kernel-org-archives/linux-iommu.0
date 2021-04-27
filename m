Return-Path: <SRS0=GIAn=JY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FE0C433B4
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 22:56:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4EFB613D9
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 22:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4EFB613D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A458F404DB;
	Tue, 27 Apr 2021 22:56:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DgmAFm-O7d7T; Tue, 27 Apr 2021 22:56:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8C16E403EA;
	Tue, 27 Apr 2021 22:56:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57E98C001C;
	Tue, 27 Apr 2021 22:56:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CC93C0001
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 22:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE872403FB
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 22:56:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r4p1iVIdyiwM for <iommu@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 22:56:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 75686403EA
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 22:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=9cMqKeVqpV09cXzdKEdeF1wGWj3NSvz6cLLXzNXUCD8=; b=bZ0qGVskfkWJrx7xQzfuMkoJWn
 uXsbXCfWUy5H+XPJj218MIPSekFTaV56i4dZC9FFheUYyXLbwiAPhK3Bq+k3tBDvz0B7hbOVfR/Pw
 rU0TsIsdHTeMVZuRSJHe4unPK2tJx/470PpEKYmwqqNM5SMKswk4DlpwIILF3MrN0C47OMfdXi5S2
 BmumlWMKxYppg3kVyzDdH2wUlAdUddF9ynHCOu6+qhXaeoKWzLwiJNa8Oc5YWsvB9LSQXNNpokW3c
 /UfXKIphBb3KBrtAfzVBu1rR4lQSws2cuqBfu3uWRWvY4NniZl2lxAPi8Nr5LTxNRFv7wpixJqrf/
 2mQpmzmw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lbWcM-0002ln-Cs; Tue, 27 Apr 2021 16:55:47 -0600
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-6-logang@deltatee.com>
 <20210427193157.GQ2047089@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3c9ba6df-750a-3847-f1fc-8e41f533d1a2@deltatee.com>
Date: Tue, 27 Apr 2021 16:55:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210427193157.GQ2047089@ziepe.ca>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, christian.koenig@amd.com, dan.j.williams@intel.com,
 hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, John Hubbard <jhubbard@nvidia.com>,
 linux-block@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
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



On 2021-04-27 1:31 p.m., Jason Gunthorpe wrote:
> On Thu, Apr 08, 2021 at 11:01:12AM -0600, Logan Gunthorpe wrote:
>> +/*
>> + * dma_maps_sg_attrs returns 0 on error and > 0 on success.
>> + * It should never return a value < 0.
>> + */
> 
> Also it is weird a function that can't return 0 is returning an int type

Yes, Christoph mentioned in the last series that this should probably
change to an unsigned but I wasn't really sure if that change should be
a part of the P2PDMA series.

>> +int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>> +		enum dma_data_direction dir, unsigned long attrs)
>> +{
>> +	int ents;
>> +
>> +	ents = __dma_map_sg_attrs(dev, sg, nents, dir, attrs);
>>  	BUG_ON(ents < 0);
> 
> if (WARN_ON(ents < 0))
>      return 0;
> 
> instead of bug on?

It was BUG_ON in the original code. So I felt I should leave it.

> Also, I see only 8 users of this function. How about just fix them all
> to support negative returns and use this as the p2p API instead of
> adding new API?

Well there might be 8 users of dma_map_sg_attrs() but there are a very
large number of dma_map_sg(). Seems odd to me to single out the first as
requiring these changes, but leave the latter.

> Add the opposite logic flag, 'DMA_ATTRS_NO_ERROR' and pass it through
> the other api entry callers that can't handle it?

I'm not that opposed to this. But it will make this series a fair bit
longer to change the 8 map_sg_attrs() usages.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
