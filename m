Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CE7C2D0A3
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 17:43:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 416D8217A0
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 17:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="BMhMQO2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416D8217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8E50686C6F;
	Fri,  6 Nov 2020 17:43:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P3tnRjcD-XsE; Fri,  6 Nov 2020 17:43:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A301286C12;
	Fri,  6 Nov 2020 17:43:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A9F0C088B;
	Fri,  6 Nov 2020 17:43:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44801C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:43:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2C261872EE
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:43:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N7LlJ5f7HS7v for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 17:43:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8ABE287174
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+aVF8hXlDJ8MzPtxX+XTVoXEhgBr/LXYLuXvlOqZpGU=; b=BMhMQO2caJsqnlb1LxCr7nBMdq
 1Z2QCchiWLzUurwt3unaRF8yXphVx9GmAgyCNN72Z8goljgcSPoUwJVAZ1mDzXLyUGcszQIG0YL6V
 Xh3RTrZLilCq+i/q7PRDd0P4JcITPVliaZMPbMnmuO/M8ewMGtTo8uMTblJXHulgQKx9mbUFNcvt2
 5WwjAZfAP0p7IcvHkxV86Nh7/8FKbB35igvhByuo72QPVLb6cKG8TSef4tW5v/Br/8Hnj1dWC+CUd
 xWx2R4ulYSIMFvjaEWxIIrphSNBNS/KyMiSZvesXCRZGPs/wP5ZtVbHSsHSTvIGKOYH2FRcoJ0bNW
 pfRf3Ijw==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1kb5lh-0003H9-4R; Fri, 06 Nov 2020 10:43:22 -0700
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-16-logang@deltatee.com>
 <20201106173932.GT36674@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <da53aaa5-94fd-c150-c5a4-8fec042eb196@deltatee.com>
Date: Fri, 6 Nov 2020 10:43:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106173932.GT36674@ziepe.ca>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: daniel.vetter@ffwll.ch, willy@infradead.org,
 ddutile@redhat.com, jhubbard@nvidia.com, iweiny@intel.com,
 christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 15/15] nvme-pci: Allow mmaping the CMB in userspace
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ira Weiny <iweiny@intel.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
 John Hubbard <jhubbard@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
 Christoph Hellwig <hch@lst.de>
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




On 2020-11-06 10:39 a.m., Jason Gunthorpe wrote:
> On Fri, Nov 06, 2020 at 10:00:36AM -0700, Logan Gunthorpe wrote:
>> Allow userspace to obtain CMB memory by mmaping the controller's
>> char device. The mmap call allocates and returns a hunk of CMB memory,
>> (the offset is ignored) so userspace does not have control over the
>> address within the CMB.
>>
>> A VMA allocated in this way will only be usable by drivers that set
>> FOLL_PCI_P2PDMA when calling GUP. And inter-device support will be
>> checked the first time the pages are mapped for DMA.
>>
>> Currently this is only supported by O_DIRECT to an PCI NVMe device
>> or through the NVMe passthrough IOCTL.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>  drivers/nvme/host/core.c | 11 +++++++++++
>>  drivers/nvme/host/nvme.h |  1 +
>>  drivers/nvme/host/pci.c  |  9 +++++++++
>>  3 files changed, 21 insertions(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index f14316c9b34a..fc642aba671d 100644
>> +++ b/drivers/nvme/host/core.c
>> @@ -3240,12 +3240,23 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
>>  	}
>>  }
>>  
>> +static int nvme_dev_mmap(struct file *file, struct vm_area_struct *vma)
>> +{
>> +	struct nvme_ctrl *ctrl = file->private_data;
>> +
>> +	if (!ctrl->ops->mmap_cmb)
>> +		return -ENODEV;
>> +
>> +	return ctrl->ops->mmap_cmb(ctrl, vma);
>> +}
> 
> This needs to ensure that the VMA created is destroyed before the
> driver is unprobed - ie the struct pages backing the BAR memory is
> destroyed.
> 
> I don't see anything that synchronizes this in the nvme_dev_release()?

Yup, looks like something that needs to be fixed. Though I'd probably do
it in the pci_p2pdma helper code instead.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
