Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DA2C433EF
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 16:51:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA7561261
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 16:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ADA7561261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7244E4063E;
	Thu, 30 Sep 2021 16:51:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EKpXK2BtuIFw; Thu, 30 Sep 2021 16:51:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3F8D7425A1;
	Thu, 30 Sep 2021 16:51:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A8C4C000F;
	Thu, 30 Sep 2021 16:51:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A2D9C000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 16:51:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 473E640565
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 16:51:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QGVr-g8qgN_B for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 16:51:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D96940217
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 16:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=DY98l6f/p37o1n6z2SAmaZFkiMoprnW0+Juc+mDOhCo=; b=pTfd2cTcyBzH2LpKD5iE+L5qG5
 1YxVv6haFuR4tVxbCWzg77WlnQgwPvUMZwmaeKZ/dooUcIP5nxEHrl6iUZij4mssaKTc1px7tpQdx
 UMyTxmWTfEjMtRe2GIkYjVgqlDS1F3IkTZYJ19rOxetGBvpeebtdTkcvo2LLMm8BaIdwZQW6M+yDA
 xwkZTQaVYuM6i+YEvgQv3b/vT6jMo3j0z9ni8dqNTUIbj+9inuXDYYSM/W4MlssDZdeD33aXoOrpZ
 tIrW+L7X4llhAn1S/KznAKSdwTbT4O7Y3kK3KgNwTuziND3TP1yUKnxXkkTO5ob60fRu9UHxzZrhf
 5AMobH0g==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1mVzHI-0004dm-2w; Thu, 30 Sep 2021 10:51:25 -0600
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-10-logang@deltatee.com>
 <c04215bd-442a-6520-4fc7-5035c1310662@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <acaa91df-f932-7449-3623-4209c41634d9@deltatee.com>
Date: Thu, 30 Sep 2021 10:51:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c04215bd-442a-6520-4fc7-5035c1310662@nvidia.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com,
 robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org,
 jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net,
 dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch,
 willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com,
 christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 chaitanyak@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 09/20] nvme-pci: check DMA ops when indicating support
 for PCI P2PDMA
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Ira Weiny <ira.weiny@intel.com>, John Hubbard <jhubbard@nvidia.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthew Wilcox <willy@infradead.org>,
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



On 2021-09-29 11:06 p.m., Chaitanya Kulkarni wrote:
> Logan,
> 
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 7efb31b87f37..916750a54f60 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3771,7 +3771,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>>                  blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, ns->queue);
>>
>>          blk_queue_flag_set(QUEUE_FLAG_NONROT, ns->queue);
>> -       if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
>> +       if (ctrl->ops->supports_pci_p2pdma &&
>> +           ctrl->ops->supports_pci_p2pdma(ctrl))
>>                  blk_queue_flag_set(QUEUE_FLAG_PCI_P2PDMA, ns->queue);
>>
>>          ns->ctrl = ctrl;
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 9871c0c9374c..fb9bfc52a6d7 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -477,7 +477,6 @@ struct nvme_ctrl_ops {
>>          unsigned int flags;
>>   #define NVME_F_FABRICS                 (1 << 0)
>>   #define NVME_F_METADATA_SUPPORTED      (1 << 1)
>> -#define NVME_F_PCI_P2PDMA              (1 << 2)
>>          int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
>>          int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
>>          int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
>> @@ -485,6 +484,7 @@ struct nvme_ctrl_ops {
>>          void (*submit_async_event)(struct nvme_ctrl *ctrl);
>>          void (*delete_ctrl)(struct nvme_ctrl *ctrl);
>>          int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
>> +       bool (*supports_pci_p2pdma)(struct nvme_ctrl *ctrl);
>>   };
>>
> 
> Is this new ops only needed for the PCIe transport ? or do you have 
> following patches to use this op for the other transports ?

No, I don't think this will make sense for transports that are not based
on PCI devices.

> If it is only needed for the PCIe then we need to find a way to
> not add this somehow...

I don't see how we can do that. The core code needs to know whether the
transport supports this and must have an operation to query it.

Logan

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
