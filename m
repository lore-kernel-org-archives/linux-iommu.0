Return-Path: <SRS0=N1FY=J6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E1BC433B4
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 17:18:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C6061155
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 17:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C6061155
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7AFDA60692;
	Mon,  3 May 2021 17:18:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AZUghvZD8SqM; Mon,  3 May 2021 17:18:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id A992F60693;
	Mon,  3 May 2021 17:18:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E3FFC000E;
	Mon,  3 May 2021 17:18:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DBB4C0001
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 17:18:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4695C40EB0
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 17:18:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BS6pLOs8emst for <iommu@lists.linux-foundation.org>;
 Mon,  3 May 2021 17:18:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0230E40EA4
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 17:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=SAQ4S+jSIpU03o924OYwfD9SEbxJ72ZyqTFfTksfdhA=; b=aHvkXNhJC0Th2xBJKUmBj+YFHL
 UzUUk1ISTbtYsp83553YSXXGRA++kbSiJtSN05jEXVqt9VEX+wniOJS1RplCEqtuDD5dEX6odZ4Kq
 cu222eZYaQudBjSH8A2rSJDXWW+51r3qeRWafwKoGAm6AVx0/RQ21Pp4Domc5hgQYrYZGJC3acctI
 oDyhQ6cbTWTz+4TBfHuPIS5Ncok4vJKWmc5qIIjxy5BONLC07sANEe9vDy3pqahAl0m4DRp8PkoaL
 1+iVIZ7RcwI7jzxYjW8Dkp9JZw0qq1u+WTSwK8ErzNEhrqQw5/H+bDo+O6nCitRx5LdA8d9D7PVCk
 nOiYSZ1A==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1ldcCd-0005A2-F7; Mon, 03 May 2021 11:17:52 -0600
To: John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-13-logang@deltatee.com>
 <f8bdf85c-2302-890e-7f77-e11fe6f29d6e@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f33a9cff-82d0-7a05-070a-8c6018fbaba9@deltatee.com>
Date: Mon, 3 May 2021 11:17:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <f8bdf85c-2302-890e-7f77-e11fe6f29d6e@nvidia.com>
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
Subject: Re: [PATCH 12/16] nvme-pci: Check DMA ops when indicating support for
 PCI P2PDMA
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



On 2021-05-02 7:29 p.m., John Hubbard wrote:
> On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
>> Introduce a supports_pci_p2pdma() operation in nvme_ctrl_ops to
>> replace the fixed NVME_F_PCI_P2PDMA flag such that the dma_map_ops
>> flags can be checked for PCI P2PDMA support.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>   drivers/nvme/host/core.c |  3 ++-
>>   drivers/nvme/host/nvme.h |  2 +-
>>   drivers/nvme/host/pci.c  | 11 +++++++++--
>>   3 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 0896e21642be..223419454516 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3907,7 +3907,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>>   		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, ns->queue);
>>   
>>   	blk_queue_flag_set(QUEUE_FLAG_NONROT, ns->queue);
>> -	if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
>> +	if (ctrl->ops->supports_pci_p2pdma &&
>> +	    ctrl->ops->supports_pci_p2pdma(ctrl))
> 
> This is a little excessive, as I suspected. How about providing a
> default .supports_pci_p2pdma routine that returns false, so that
> the op is always available (non-null)? By "default", maybe that
> means either requiring an init_the_ops_struct() routine to be
> used, and/or checking all the users of struct nvme_ctrl_ops.

Honestly that sounds much more messy to me than simply checking if it's
NULL before using it (which is a common, accepted pattern for ops).

> Another idea: maybe you don't really need a bool .supports_pci_p2pdma()
> routine at all, because the existing .flags really is about right.
> You just need the flags to be filled in dynamically. So, do that
> during nvme_pci setup/init time: that's when this module would call
> dma_pci_p2pdma_supported().

If the flag is filled in dynamically, then the ops struct would have to
be non-constant. Ops structs should be constant for security reasons.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
