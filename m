Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38FAC433EF
	for <iommu@archiver.kernel.org>; Tue,  1 Feb 2022 20:57:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F7CF830E2;
	Tue,  1 Feb 2022 20:57:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zIyKX_xHPPzZ; Tue,  1 Feb 2022 20:57:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1F3498308D;
	Tue,  1 Feb 2022 20:57:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDD30C0011;
	Tue,  1 Feb 2022 20:57:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1EB5C000B
 for <iommu@lists.linux-foundation.org>; Tue,  1 Feb 2022 20:57:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DE4B583131
 for <iommu@lists.linux-foundation.org>; Tue,  1 Feb 2022 20:57:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YYrHyo5YxQ-e for <iommu@lists.linux-foundation.org>;
 Tue,  1 Feb 2022 20:57:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C7392830E2
 for <iommu@lists.linux-foundation.org>; Tue,  1 Feb 2022 20:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=cJSKxOJIzFWJNB/4kEdPj9SAYSFCsRpghMAEka+ai04=; b=inRrrLF05DauLsozmFhswOyT+U
 WPSDQkzNTcNkRZ8czrnUNGLopNg88HLX9pdCK4UlXF1bzYf1BKgtsKpvGypPta7CHlcUOku9K9vge
 +NAO35wcF3CTICM/mBTLmVIVzczzqTvX+VVkIJTevRDS2LfYWgy1a6+2EUp3AAiQR5ChqflV0MWso
 oxckJk6HwJ98oVn/PvRLw3x09cOhCMFDyStF8NnTcjdXZ77YjfG+lzhwmhLo1H71ALY2CJFwigpj+
 UdeGbDqFGDIIDyWwb0VsLflcq8qGQM/ErCZ1YgjT6Xi6D86QbJbPGca8MIAn8BpFKQVINH97Ks3w6
 NHJute4A==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <logang@deltatee.com>)
 id 1nF0D7-009dre-2I; Tue, 01 Feb 2022 13:57:10 -0700
To: Jonathan Derrick <jonathan.derrick@linux.dev>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20220128002614.6136-1-logang@deltatee.com>
 <20220128002614.6136-9-logang@deltatee.com>
 <6c939012-8d68-fbb5-50c6-3fe757a31b48@linux.dev>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <bd83b26d-2f35-cd0a-bb20-a4626d8d48a7@deltatee.com>
Date: Tue, 1 Feb 2022 13:57:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6c939012-8d68-fbb5-50c6-3fe757a31b48@linux.dev>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: rcampbell@nvidia.com, ckulkarnilinux@gmail.com,
 martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca,
 dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jonathan.derrick@linux.dev
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v5 08/24] dma-direct: support PCI P2PDMA pages in
 dma-direct map_sg
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Ira Weiny <ira.weiny@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
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



On 2022-02-01 1:53 p.m., Jonathan Derrick wrote:
> 
> 
> On 1/27/2022 5:25 PM, Logan Gunthorpe wrote:
>> Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
>> PCI P2PDMA pages directly without a hack in the callers. This allows
>> for heterogeneous SGLs that contain both P2PDMA and regular pages.
>>
>> A P2PDMA page may have three possible outcomes when being mapped:
>>    1) If the data path between the two devices doesn't go through the
>>       root port, then it should be mapped with a PCI bus address
>>    2) If the data path goes through the host bridge, it should be mapped
>>       normally, as though it were a CPU physical address
>>    3) It is not possible for the two devices to communicate and thus
>>       the mapping operation should fail (and it will return -EREMOTEIO).
>>
>> SGL segments that contain PCI bus addresses are marked with
>> sg_dma_mark_pci_p2pdma() and are ignored when unmapped.
>>
>> P2PDMA mappings are also failed if swiotlb needs to be used on the
>> mapping.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>   kernel/dma/direct.c | 43 +++++++++++++++++++++++++++++++++++++------
>>   kernel/dma/direct.h |  7 ++++++-
>>   2 files changed, 43 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index 50f48e9e4598..975df5f3aaf9 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -461,29 +461,60 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
>>   		arch_sync_dma_for_cpu_all();
>>   }
>>   
>> +/*
>> + * Unmaps segments, except for ones marked as pci_p2pdma which do not
>> + * require any further action as they contain a bus address.
>> + */
>>   void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>>   		int nents, enum dma_data_direction dir, unsigned long attrs)
>>   {
>>   	struct scatterlist *sg;
>>   	int i;
>>   
>> -	for_each_sg(sgl, sg, nents, i)
>> -		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
>> -			     attrs);
>> +	for_each_sg(sgl,  sg, nents, i) {
>> +		if (sg_is_dma_bus_address(sg))
>> +			sg_dma_unmark_bus_address(sg);
>> +		else
>> +			dma_direct_unmap_page(dev, sg->dma_address,
>> +					      sg_dma_len(sg), dir, attrs);
>> +	}
>>   }
>>   #endif
>>   
>>   int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>>   		enum dma_data_direction dir, unsigned long attrs)
>>   {
>> -	int i;
>> +	struct pci_p2pdma_map_state p2pdma_state = {};
>> +	enum pci_p2pdma_map_type map;
>>   	struct scatterlist *sg;
>> +	int i, ret;
>>   
>>   	for_each_sg(sgl, sg, nents, i) {
>> +		if (is_pci_p2pdma_page(sg_page(sg))) {
>> +			map = pci_p2pdma_map_segment(&p2pdma_state, dev, sg);
>> +			switch (map) {
>> +			case PCI_P2PDMA_MAP_BUS_ADDR:
>> +				continue;
>> +			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>> +				/*
>> +				 * Any P2P mapping that traverses the PCI
>> +				 * host bridge must be mapped with CPU physical
>> +				 * address and not PCI bus addresses. This is
>> +				 * done with dma_direct_map_page() below.
>> +				 */
>> +				break;
>> +			default:
>> +				ret = -EREMOTEIO;
>> +				goto out_unmap;
>> +			}
>> +		}
> I'm a little confused about this code. Would there be a case where the mapping needs
> to be checked for each sg in the list? And if some sg in the sgl can be mapped
> differently, would we want to continue checking the rest of the sg in the sgl instead
> of breaking out of the loop completely?

Yes, the code supports heterogeneous SGLs with P2PDMA and regular
memory; it's also theoretically possible to mix P2PDMA memory for
different devices. So yes, the mapping must be checked for every SG in
the list. It can't just see one SG that points to P2PDMA memory and
assume the rest are all good.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
