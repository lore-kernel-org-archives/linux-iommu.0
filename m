Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03B8C433F5
	for <iommu@archiver.kernel.org>; Mon, 13 Dec 2021 22:29:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2F4674047C;
	Mon, 13 Dec 2021 22:29:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id muwvZGyR9TQx; Mon, 13 Dec 2021 22:29:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B4DB74019D;
	Mon, 13 Dec 2021 22:29:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87535C002F;
	Mon, 13 Dec 2021 22:29:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B832C0012
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 22:29:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F85360B5F
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 22:29:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LJPcmgcySdIr for <iommu@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 22:29:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 509B760B4E
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 22:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=7iaOSPYC++rVBoYT3QRUQDaMarUdPJ3RFeXKP6p9rM4=; b=b3dBhIgajJAvUk635a5T6J+46S
 lWGtZao8HbOE8FQzCpvd1HGkyAd8ZKQCD7KmVuvwCjqFnOdp1/6fBQqIqviPbBW3OAlA7rK5mYuJp
 ISX4VUGcdu+eaAVoI4XiQfUSuYbsqkyzs9pinzLkr8frDEOIvCPGPHWNLRXiDfjEtx6iopkOFseh7
 3nVLEpOS4Euq+Xe2yxnR8Oqycsa1pui0qvcMZaJQZ7Y60d7xioQ6c13dSL4wCD4OmLA/3MOcr2wjy
 ErkKSypS9r+JtZqxUMXBuukP7mxIR+F+TYmxzDEHKJktVg54mBubaL0dovEnkeXllV049o5n8uat3
 N8KqHCbA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <logang@deltatee.com>)
 id 1mwtoY-0042Rf-6n; Mon, 13 Dec 2021 15:28:59 -0700
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20211117215410.3695-1-logang@deltatee.com>
 <20211117215410.3695-12-logang@deltatee.com>
 <e4fda995-6b50-0f74-0af7-4d790ab66ba9@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <af6cda4f-9996-0aad-9278-1d41f824a070@deltatee.com>
Date: Mon, 13 Dec 2021 15:28:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e4fda995-6b50-0f74-0af7-4d790ab66ba9@nvidia.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: mgurtovoy@nvidia.com, ckulkarnilinux@gmail.com,
 martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca,
 dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 chaitanyak@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 11/23] nvme-pci: convert to using dma_map_sgtable()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Ira Weiny <ira.weiny@intel.com>, John Hubbard <jhubbard@nvidia.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Jason Ekstrand <jason@jlekstrand.net>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Bjorn Helgaas <helgaas@kernel.org>,
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


On 2021-12-13 3:21 p.m., Chaitanya Kulkarni wrote:
> 
>>   static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
>> -		struct request *req, struct nvme_rw_command *cmd, int entries)
>> +		struct request *req, struct nvme_rw_command *cmd)
>>   {
>>   	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>>   	struct dma_pool *pool;
>>   	struct nvme_sgl_desc *sg_list;
>> -	struct scatterlist *sg = iod->sg;
>> +	struct scatterlist *sg = iod->sgt.sgl;
>> +	int entries = iod->sgt.nents;
> 
> I don't see use of newly added entries variable anywhere in
> nvme_pci_setup_sgls(), what am I missing ?

'entries' is being moved out from the argument list of
nvme_pci_setup_sgls(), so there are already uses in the function that
don't show in the diff.

> Also, type of entries variable should be unsigned int to match
> the iod->sgt.nents.

Sure, I will fix that in the next version.

Thanks for the reviews!

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
