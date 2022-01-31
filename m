Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0373CC433EF
	for <iommu@archiver.kernel.org>; Mon, 31 Jan 2022 19:00:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 791C260EF9;
	Mon, 31 Jan 2022 19:00:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A1zqJpAsVspD; Mon, 31 Jan 2022 19:00:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B393D60B50;
	Mon, 31 Jan 2022 19:00:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F7DCC0011;
	Mon, 31 Jan 2022 19:00:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FC34C000B
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 19:00:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5D86C408BA
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 19:00:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iTgtm0kufXey for <iommu@lists.linux-foundation.org>;
 Mon, 31 Jan 2022 19:00:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 828E3404CF
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 19:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=JfiBWAhkX1yHT92Ca969hKJaoVoe9ZEugeTA+o2gzlk=; b=l8gfX2giRWGgLu5RJY5tnXex3G
 naOg0DFHyGRH+WLiZNH6sHyFr4bWsG1rAvdlZ1fmScq1SMfZDFIEnUYH8VczuVNJAw9nbR2ZHg/oq
 yJTHQQQl/ejTUOl5M+8lgqwY+8MnixFCjR2Spi6TJ1qAU3tOAr6Zvchw6CRPXgL437qt1wS6Z172Y
 dkvB2bUHt9IHazdxNJlQRzlYq1Zun08wMxYQTlew19LVw6U3nB3ecjgtyBQp29pl1CavUC8RSaymJ
 GqmzMSm6w+nK1bSbSduZGxfQ/6O6c76ZYO2FoIihh1jEypL8oHnl8n01OJnsZT5sASWHH3nFELW0W
 Q3IdSFGw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <logang@deltatee.com>)
 id 1nEbuV-008jbJ-R5; Mon, 31 Jan 2022 12:00:20 -0700
To: Jonathan Derrick <jonathan.derrick@linux.dev>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20220128002614.6136-1-logang@deltatee.com>
 <c725798d-48da-2993-cc48-0ec0b314455f@linux.dev>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <08564685-e027-30b2-2c6e-9faf1d95dc7a@deltatee.com>
Date: Mon, 31 Jan 2022 12:00:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c725798d-48da-2993-cc48-0ec0b314455f@linux.dev>
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
Subject: Re: [PATCH v5 00/24] Userspace P2PDMA with O_DIRECT NVMe devices
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



On 2022-01-31 11:56 a.m., Jonathan Derrick wrote:
>> This is relatively straightforward, however the one significant
>> problem is that, presently, pci_p2pdma_map_sg() requires a homogeneous
>> SGL with all P2PDMA pages or all regular pages. Enhancing GUP to
>> support enforcing this rule would require a huge hack that I don't
>> expect would be all that pallatable. So patches 3 to 16 add
>> support for P2PDMA pages to dma_map_sg[table]() to the dma-direct
>> and dma-iommu implementations. Thus systems without an IOMMU plus
>> Intel and AMD IOMMUs are supported. (Other IOMMU implementations would
>> then be unsupported, notably ARM and PowerPC but support would be added
>> when they convert to dma-iommu).
> Am I understanding that an IO may use a mix of p2pdma and system pages?
> Would that cause inconsistent latencies?

Yes, that certainly would be a possibility. People developing
applications that do such mixing would have to weight that issue if
latency is something they care about.

But it's counter productive and causes other difficulties for the kernel
to enforce only homogenous IO.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
