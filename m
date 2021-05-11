Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39F1C43461
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:17:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29AAD6186A
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29AAD6186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B877A40574;
	Tue, 11 May 2021 16:17:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WDM7vk4zfHUZ; Tue, 11 May 2021 16:17:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9498B40577;
	Tue, 11 May 2021 16:17:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E7F8C000E;
	Tue, 11 May 2021 16:17:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20536C0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:17:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F414840577
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:17:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NiMpLTgQSupA for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 16:17:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 39DAE40574
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=+qL+bCKGfStmpkzBXZL07cewsYGgdGWBxgnS26p7gJ4=; b=OjW/leyhr6eiCrabsG0jwX48QG
 qf9FfnRMB8lOpcLl7xkYVCN+H9DG/ow0oFBY5DkbsdrKG4BeIL/95qHzr5Q34oml6P0Ia+gj006QY
 T7tfNb/72phF7xxLw2cHcasrwLMhlmUq8D4r4ua8yXgfhO46WSwr8NalxGd8AKW8D7Uph/BeD0c6v
 EXvXF+qClEvUf1Cs6Tw4byRJhAqcs+WTb4+Ii6rhyanbNHBLODUr7O8ZW25N6FFgMl243kSFQXexr
 6BMwajaa6dpHKjgCljgKN/d8mwu2rcxO8/ASPfckMdnWBkJYMQw+zF2Aa4G7MR3LtsG2RGxXG35o2
 4DdZW0ng==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lgV4L-0006fB-19; Tue, 11 May 2021 10:17:14 -0600
To: Don Dutile <ddutile@redhat.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-8-logang@deltatee.com>
 <a2da7566-7e0d-6a3a-055d-4d324deba4af@redhat.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a90197a9-460f-c709-d852-725352a0ef20@deltatee.com>
Date: Tue, 11 May 2021 10:17:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <a2da7566-7e0d-6a3a-055d-4d324deba4af@redhat.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, jhubbard@nvidia.com,
 christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 ddutile@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 07/16] PCI/P2PDMA: Make pci_p2pdma_map_type() non-static
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <helgaas@kernel.org>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates <sbates@raithlin.com>,
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



On 2021-05-11 10:06 a.m., Don Dutile wrote:
> On 4/8/21 1:01 PM, Logan Gunthorpe wrote:
>> pci_p2pdma_map_type() will be needed by the dma-iommu map_sg
>> implementation because it will need to determine the mapping type
>> ahead of actually doing the mapping to create the actual iommu mapping.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>   drivers/pci/p2pdma.c       | 34 +++++++++++++++++++++++-----------
>>   include/linux/pci-p2pdma.h | 15 +++++++++++++++
>>   2 files changed, 38 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index bcb1a6d6119d..38c93f57a941 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -20,13 +20,6 @@
>>   #include <linux/seq_buf.h>
>>   #include <linux/xarray.h>
>>   
>> -enum pci_p2pdma_map_type {
>> -	PCI_P2PDMA_MAP_UNKNOWN = 0,
>> -	PCI_P2PDMA_MAP_NOT_SUPPORTED,
>> -	PCI_P2PDMA_MAP_BUS_ADDR,
>> -	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
>> -};
>> -
>>   struct pci_p2pdma {
>>   	struct gen_pool *pool;
>>   	bool p2pmem_published;
>> @@ -822,13 +815,30 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
>>   }
>>   EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
>>   
>> -static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
>> -						    struct device *dev)
>> +/**
>> + * pci_p2pdma_map_type - return the type of mapping that should be used for
>> + *	a given device and pgmap
>> + * @pgmap: the pagemap of a page to determine the mapping type for
>> + * @dev: device that is mapping the page
>> + * @dma_attrs: the attributes passed to the dma_map operation --
>> + *	this is so they can be checked to ensure P2PDMA pages were not
>> + *	introduced into an incorrect interface (like dma_map_sg). *
>> + *
>> + * Returns one of:
>> + *	PCI_P2PDMA_MAP_NOT_SUPPORTED - The mapping should not be done
>> + *	PCI_P2PDMA_MAP_BUS_ADDR - The mapping should use the PCI bus address
>> + *	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE - The mapping should be done directly
>> + */
> I'd recommend putting these descriptions in the enum's in pci-p2pdma.h .
> Also, can you use a better description for THRU_HOST_BRIDGE -- it leaves the reader wondering what 'done directly' means.

Will do.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
