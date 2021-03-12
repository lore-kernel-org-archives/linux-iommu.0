Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE95DC433E0
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 02:18:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3858464F87
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 02:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3858464F87
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5E5A4ED1C;
	Fri, 12 Mar 2021 02:18:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M_K3nflNZ2Js; Fri, 12 Mar 2021 02:18:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B78747179;
	Fri, 12 Mar 2021 02:18:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56ED8C000A;
	Fri, 12 Mar 2021 02:18:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50803C0001
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 02:18:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 30E174ECC4
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 02:18:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mAS2tUgc3Bcq for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 02:18:30 +0000 (UTC)
X-Greylist: delayed 00:41:09 by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 422AB47179
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 02:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=TthgKQQeKaY8Nk8kByxBsMn1+rajpO9j2vCO0oMycYg=; b=k5/TOv/t9MI8U4lhl5xd0eVHRI
 DEKyTXEcuq5sX7Xy2TXIwqOAOZ73ZqhrLuTntYIMTvCOCq8PRu9o7rWRFdwy4LEmwJcHwyWL9BvxE
 E3psi+/9MRziL+BVzgCEmcxCM77bWwNBiF0H8QBoLUfFeTtCEH58WSnu/bBSwfWEc0X1HLYx+UY6W
 Ig6tahtLX1Cp8ddWB4Vw3kJiR4S7bXzhUgT4PrlGFGZiBmn37haj35vV85OvDcD2h9GakgTEPhmP8
 5ULZeqF8e05hdIS9qe+Vati5jKVwahKR4z2FkN46o43eFB9sPRT5TVTR6byB7fKBkdA6vj9c1GMvK
 qXUpe9FA==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1lKWjj-0005aG-5w; Thu, 11 Mar 2021 18:37:08 -0700
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-12-logang@deltatee.com>
 <20210311235943.GB2710221@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c6cc9e07-b7cf-6d3d-b0bf-25428b197731@deltatee.com>
Date: Thu, 11 Mar 2021 18:37:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210311235943.GB2710221@ziepe.ca>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, iweiny@intel.com, christian.koenig@amd.com,
 dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH v2 11/11] nvme-pci: Convert to using dma_map_sg for
 p2pdma pages
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ira Weiny <iweiny@intel.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Stephen Bates <sbates@raithlin.com>, linux-block@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>, Jason Ekstrand <jason@jlekstrand.net>,
 John Hubbard <jhubbard@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
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



On 2021-03-11 4:59 p.m., Jason Gunthorpe wrote:
> On Thu, Mar 11, 2021 at 04:31:41PM -0700, Logan Gunthorpe wrote:
>> Convert to using dma_[un]map_sg() for PCI p2pdma pages.
>>
>> This should be equivalent, though support will be somewhat less
>> (only dma-direct and dma-iommu are currently supported).
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>  drivers/nvme/host/pci.c | 27 +++++++--------------------
>>  1 file changed, 7 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 7d40c6a9e58e..89ca5acf7a62 100644
>> +++ b/drivers/nvme/host/pci.c
>> @@ -577,17 +577,6 @@ static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
>>  
>>  }
>>  
>> -static void nvme_unmap_sg(struct nvme_dev *dev, struct request *req)
>> -{
>> -	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>> -
>> -	if (is_pci_p2pdma_page(sg_page(iod->sg)))
>> -		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
>> -				    rq_dma_dir(req));
>> -	else
>> -		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
>> -}
> 
> Can the two other places with this code pattern be changed too?

Yes, if this goes forward, I imagine completely dropping
pci_p2pdma_unmap_sg().

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
