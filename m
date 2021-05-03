Return-Path: <SRS0=N1FY=J6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DE9C433ED
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 17:09:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D36036112F
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 17:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36036112F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CA8D842DD;
	Mon,  3 May 2021 17:09:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mfF5hSnXVw7k; Mon,  3 May 2021 17:09:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55CB1842B4;
	Mon,  3 May 2021 17:09:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 387D0C000E;
	Mon,  3 May 2021 17:09:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE2CBC0001
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 17:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E4823404B6
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 17:09:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C_G7ACMtx9Pp for <iommu@lists.linux-foundation.org>;
 Mon,  3 May 2021 17:09:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 54F0C400C8
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 17:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=sF55GqEiR/vAGKsTB6GxRt38Im6+dLa7cFcSyRRCVPY=; b=PPAJStAbdbFioncG1dF75qCU+v
 JphXQ3TasGekmkY28Y2MzFXdxG5QkT47dRXuoZAjv1XmtflJyc0xQSN1SJ0IH/IfpTxhtbEZvkpES
 XoLa55YoDqbSCc+7C3/zJowfmfhUSJPDLBddaVhPplT0a/o7g+Q0UWanpD5P9oDwYAoPlnURNJT/U
 pOznyVDGTomzGZXWTLIwqMDc/sde4eiJclT7mEfqE3z/9d0Wq6vJVrdw1xb+C67SQRgtI12z9UtIW
 x/eaYbEH8LFDHop0JKG/ustGY/6sHhLh307UM0U09MQ5UyR30dmPw58gEAMDgsZK/WY7OTyhZKJv+
 fKlTUBWg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1ldc4e-0004xo-VK; Mon, 03 May 2021 11:09:38 -0600
To: John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-11-logang@deltatee.com>
 <85bd104b-2816-f803-44d4-d5623d4f81af@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f522351e-e8cf-58e9-620d-f17dcdfbf151@deltatee.com>
Date: Mon, 3 May 2021 11:09:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <85bd104b-2816-f803-44d4-d5623d4f81af@nvidia.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jhubbard@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 10/16] dma-mapping: Add flags to dma_map_ops to indicate
 PCI P2PDMA support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jason Ekstrand <jason@jlekstrand.net>,
 Bjorn Helgaas <helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Stephen Bates <sbates@raithlin.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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



On 2021-05-02 6:32 p.m., John Hubbard wrote:
> On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
>> Add a flags member to the dma_map_ops structure with one flag to
>> indicate support for PCI P2PDMA.
>>
>> Also, add a helper to check if a device supports PCI P2PDMA.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>   include/linux/dma-map-ops.h |  3 +++
>>   include/linux/dma-mapping.h |  5 +++++
>>   kernel/dma/mapping.c        | 18 ++++++++++++++++++
>>   3 files changed, 26 insertions(+)
>>
>> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
>> index 51872e736e7b..481892822104 100644
>> --- a/include/linux/dma-map-ops.h
>> +++ b/include/linux/dma-map-ops.h
>> @@ -12,6 +12,9 @@
>>   struct cma;
>>   
>>   struct dma_map_ops {
>> +	unsigned int flags;
>> +#define DMA_F_PCI_P2PDMA_SUPPORTED     (1 << 0)
>> +
> 
> Can we move this up and out of the struct member area, so that it looks
> more like this:
> 
> /*
>   * Values for struct dma_map_ops.flags:
>   *
>   * DMA_F_PCI_P2PDMA_SUPPORTED: <documentation here...this is a good place to
>   * explain exactly what this flag is for.>
>   */
> #define DMA_F_PCI_P2PDMA_SUPPORTED     (1 << 0)
> 
> struct dma_map_ops {
> 	unsigned int flags;
> 

Sure, I don't care that much. I was just following the style in nvme.h.

>>   	void *(*alloc)(struct device *dev, size_t size,
>>   			dma_addr_t *dma_handle, gfp_t gfp,
>>   			unsigned long attrs);
>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>> index 50b8f586cf59..c31980ecca62 100644
>> --- a/include/linux/dma-mapping.h
>> +++ b/include/linux/dma-mapping.h
>> @@ -146,6 +146,7 @@ int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
>>   		unsigned long attrs);
>>   bool dma_can_mmap(struct device *dev);
>>   int dma_supported(struct device *dev, u64 mask);
>> +bool dma_pci_p2pdma_supported(struct device *dev);
>>   int dma_set_mask(struct device *dev, u64 mask);
>>   int dma_set_coherent_mask(struct device *dev, u64 mask);
>>   u64 dma_get_required_mask(struct device *dev);
>> @@ -247,6 +248,10 @@ static inline int dma_supported(struct device *dev, u64 mask)
>>   {
>>   	return 0;
>>   }
>> +static inline bool dma_pci_p2pdma_supported(struct device *dev)
>> +{
>> +	return 0;
> 
> Should be:
> 	
> 	return false;

Yup, will fix.

>> +}
>>   static inline int dma_set_mask(struct device *dev, u64 mask)
>>   {
>>   	return -EIO;
>> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
>> index 923089c4267b..ce44a0fcc4e5 100644
>> --- a/kernel/dma/mapping.c
>> +++ b/kernel/dma/mapping.c
>> @@ -573,6 +573,24 @@ int dma_supported(struct device *dev, u64 mask)
>>   }
>>   EXPORT_SYMBOL(dma_supported);
>>   
>> +bool dma_pci_p2pdma_supported(struct device *dev)
>> +{
>> +	const struct dma_map_ops *ops = get_dma_ops(dev);
>> +
>> +	/* if ops is not set, dma direct will be used which supports P2PDMA */
>> +	if (!ops)
>> +		return true;
>> +
>> +	/*
>> +	 * Note: dma_ops_bypass is not checked here because P2PDMA should
>> +	 * not be used with dma mapping ops that do not have support even
>> +	 * if the specific device is bypassing them.
>> +	 */
>> +
>> +	return ops->flags & DMA_F_PCI_P2PDMA_SUPPORTED;
> 
> Wow, rather unusual combination of things in order decide this. It feels
> a bit over-complicated to have flags and ops and a bool function all
> dealing with the same 1-bit answer, but there is no caller shown here,
> so I'll have to come back to this after reviewing subsequent patches.

Yeah, I originally had it much simpler, but it confused Ira and it was
clear it had to be written more explicitly and commented better.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
