Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B98C433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 22:56:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91B361159
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 22:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C91B361159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B76C42527;
	Wed, 29 Sep 2021 22:56:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P9Z01DCtGwA4; Wed, 29 Sep 2021 22:56:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 754BF40240;
	Wed, 29 Sep 2021 22:56:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4838BC000F;
	Wed, 29 Sep 2021 22:56:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5D6DC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 22:56:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8237A42527
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 22:56:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FvU9IhJKxu0A for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 22:56:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1157240240
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 22:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=gyI1iWTgaQxXLC0uh18K74XDfJOQ35Yd/0UtBH7oL2Y=; b=VyEMo1To4bpq3hE/xr6uacN63S
 sFo8JLN2lg3Nt7NjJD/RyCHJ3xIMnFvvWyJQJDzNwEv5i2F31KL273mFPxjWpXsi8VJB7W8aU8iuX
 UhU9U05GQuc4pdzxedOdf9TAaZLqlqelpLTq2C+UtXnoObaPYB2yfaH1YLeAfoLoxcX8gTb/p0aCT
 164B3Y/N5rl7w8PhlikTl4aQ4jNqsb1jJoT2BUjjfIZtVih+GwnXuoh5B3mbUqiLvXqgCmdNOOLxt
 Cw4AtoX4dmjtYkv8q48FbqX8M5k1KxfxuoejCgFSCUcvy99IFnZpCWPQA7rx4nIKKrpUNT13PyREe
 /6e6C7DQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1mViV2-0007a2-MS; Wed, 29 Sep 2021 16:56:29 -0600
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-13-logang@deltatee.com>
 <20210928194325.GS3544071@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e7bbe021-9a0c-1999-0a2a-ba249578c9c7@deltatee.com>
Date: Wed, 29 Sep 2021 16:56:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928194325.GS3544071@ziepe.ca>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com,
 robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org,
 jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net,
 dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch,
 willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com,
 christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 12/20] RDMA/rw: use dma_map_sgtable()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
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




On 2021-09-28 1:43 p.m., Jason Gunthorpe wrote:
> On Thu, Sep 16, 2021 at 05:40:52PM -0600, Logan Gunthorpe wrote:
>> dma_map_sg() now supports the use of P2PDMA pages so pci_p2pdma_map_sg()
>> is no longer necessary and may be dropped.
>>
>> Switch to the dma_map_sgtable() interface which will allow for better
>> error reporting if the P2PDMA pages are unsupported.
>>
>> The change to sgtable also appears to fix a couple subtle error path
>> bugs:
>>
>>   - In rdma_rw_ctx_init(), dma_unmap would be called with an sg
>>     that could have been incremented from the original call, as
>>     well as an nents that was not the original number of nents
>>     called when mapped.
>>   - Similarly in rdma_rw_ctx_signature_init, both sg and prot_sg
>>     were unmapped with the incorrect number of nents.
> 
> Those bugs should definately get fixed.. I might extract the sgtable
> conversion into a stand alone patch to do it.

Yes. I can try to split it off myself and send a patch later this week.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
