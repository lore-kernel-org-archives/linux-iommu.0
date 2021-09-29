Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033BBC43219
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 21:31:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D12613CD
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 21:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 87D12613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4499E60762;
	Wed, 29 Sep 2021 21:31:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wAW29XC29Z9z; Wed, 29 Sep 2021 21:31:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 18A4A6076A;
	Wed, 29 Sep 2021 21:31:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF805C0011;
	Wed, 29 Sep 2021 21:31:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FA10C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 21:31:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2AB5F40210
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 21:31:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g0mYzgm-4_jm for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 21:31:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4EDCF400DA
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 21:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=6tw6VIf8QZ1mlsWGh+KwACIkxOMm5AZtflXeMzWKDvQ=; b=G14JPhTMh4902E+4gQOpPCi3NE
 bFxLHYjwVMdykIibHNGwwk/pfJGXatmfFScbRKqP5T+6cgkMlic66K1TnPj/+BC8j/maeAvLYRotG
 ORzZWzrzAW3Hz0kwwzy5NnyxHGwS6X410iNmK/7XOdakgXOPRmnlXQX4li117R5c5NTEe5AyXJctp
 I447GFVyTPVitNyLXfV4nNhxBdpafdYHIClVsnA/j/MQ6D+TDBXc8NapePSVE7WVhVJYba8tP0aDK
 j2NQQUrSiYHc+pbO0I+HvFF472sYp9bNn/BqdE6Soub7pluqmdrMQykwOElaEYZym+pT6Ga9TEQYr
 5xy7m3uQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1mVhAB-0006Lf-1O; Wed, 29 Sep 2021 15:30:51 -0600
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-5-logang@deltatee.com>
 <20210928220502.GA1738588@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <91469404-fd20-effa-2e01-aa79d9d4b9b5@deltatee.com>
Date: Wed, 29 Sep 2021 15:30:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928220502.GA1738588@nvidia.com>
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
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 4/20] PCI/P2PDMA: introduce helpers for dma_map_sg
 implementations
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




On 2021-09-28 4:05 p.m., Jason Gunthorpe wrote:
> On Thu, Sep 16, 2021 at 05:40:44PM -0600, Logan Gunthorpe wrote:
> 
>> +enum pci_p2pdma_map_type
>> +pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
>> +		       struct scatterlist *sg)
>> +{
>> +	if (state->pgmap != sg_page(sg)->pgmap) {
>> +		state->pgmap = sg_page(sg)->pgmap;
> 
> This has built into it an assumption that every page in the sg element
> has the same pgmap, but AFAIK nothing enforces this rule? There is no
> requirement that the HW has pfn gaps between the pgmaps linux decides
> to create over it.

No, that's not a correct reading of the code. Every time there is a new
pagemap, this code calculates the mapping type and bus offset. If a page
comes along with a different page map,f it recalculates. This just
reduces the overhead so that the calculation is done only every time a
page with a different pgmap comes along and not doing it for every
single page.

> At least sg_alloc_append_table_from_pages() and probably something in
> the block world should be updated to not combine struct pages with
> different pgmaps, and this should be documented in scatterlist.*
> someplace.

There's no sane place to do this check. The code is designed to support
mappings with different pgmaps.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
