Return-Path: <SRS0=GIAn=JY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324CCC43461
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 23:00:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7CAA6105A
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 23:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CAA6105A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A564F83BD0;
	Tue, 27 Apr 2021 23:00:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HQ-HPjjH5FkI; Tue, 27 Apr 2021 23:00:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92895836F0;
	Tue, 27 Apr 2021 23:00:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E2D4C001C;
	Tue, 27 Apr 2021 23:00:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCA9FC0001
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 23:00:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD525402FC
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 23:00:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LGdZOoLFaP7z for <iommu@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 23:00:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 12C72402E2
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 23:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=RGdRC5FBlsTWfpWtOgCpYwh/6l+bY/lLU227Fr0Oa7w=; b=e1cQkHUii+OnXHxuzyVnv2FOWU
 yRhslccFTPCSUZBHv6r9i2BtLYMYFFuNX+vj1xNOq/lXobsZ3eYFuedGTORJxwDIMCEh7Qthqs1Q7
 RVxgzfvWzK3UWw1HMRbfVYTe3vQzXRIV/ILbih4akY/evNrEaGCAlfgG+L3AXOME+jur1eJqyKhD1
 TMGSqOXU7r9XcMpgA/2JBpdbNNP7X3lLSbdPwHl2H10OkRWO75ot4KGzAuXd2ZJB/tmfOyTGaMv6M
 ae+aEYfgGtkGVcUSMzK45Ps6AhzhkNnGarVg7/1Ky1Fn+SEciywNHOIOcE/kvvy4C616xFskQ500w
 hxifV8fg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lbWgQ-0002oO-8N; Tue, 27 Apr 2021 16:59:59 -0600
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-15-logang@deltatee.com>
 <20210427194753.GU2047089@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6e78cdc8-8189-b778-20b4-7a108e28e557@deltatee.com>
Date: Tue, 27 Apr 2021 16:59:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210427194753.GU2047089@ziepe.ca>
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
Subject: Re: [PATCH 14/16] nvme-rdma: Ensure dma support when using p2pdma
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



On 2021-04-27 1:47 p.m., Jason Gunthorpe wrote:
> On Thu, Apr 08, 2021 at 11:01:21AM -0600, Logan Gunthorpe wrote:
>> Ensure the dma operations support p2pdma before using the RDMA
>> device for P2PDMA. This allows switching the RDMA driver from
>> pci_p2pdma_map_sg() to dma_map_sg_p2pdma().
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>  drivers/nvme/target/rdma.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>> index 6c1f3ab7649c..3ec7e77e5416 100644
>> +++ b/drivers/nvme/target/rdma.c
>> @@ -414,7 +414,8 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
>>  	if (ib_dma_mapping_error(ndev->device, r->send_sge.addr))
>>  		goto out_free_rsp;
>>  
>> -	if (!ib_uses_virt_dma(ndev->device))
>> +	if (!ib_uses_virt_dma(ndev->device) &&
>> +	    dma_pci_p2pdma_supported(&ndev->device->dev))
> 
> ib_uses_virt_dma() should not be called by nvme and this is using the
> wrong device pointer to query for DMA related properties.
> 
> I suspect this wants a ib_dma_pci_p2p_dma_supported() wrapper like
> everything else.

Makes sense. Will add for v2.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
