Return-Path: <SRS0=N1FY=J6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E961DC433B4
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 18:46:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9305F61283
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 18:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9305F61283
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54BC740E5C;
	Mon,  3 May 2021 18:46:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VFOoZrBa1BbQ; Mon,  3 May 2021 18:46:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18EC840E4D;
	Mon,  3 May 2021 18:46:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2B0EC000D;
	Mon,  3 May 2021 18:46:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38841C0001
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 18:46:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1D61D400D8
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 18:46:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id epljhtFfH5wE for <iommu@lists.linux-foundation.org>;
 Mon,  3 May 2021 18:46:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F026400B8
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 18:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=FQlZSc22rDFnyD/b3PGREqWaL5WzGsfMM4i2vFu2da4=; b=IjY1prSgciJlO7qETHoHcDfvVo
 474Xui/7jwzyvAcWaBDmxoOFd8uUVi4aWV7PQwD6cV/vy5cZzNo0VGRA9oBXLxQpeKYJmpYH4jFyb
 4wFa1eShvwuPp+3pmYC4qq4DvJ9Z2+ZznJ5szAfZyCxaIRohe3bxb+xs950S+H/+mvsScLGbX8B45
 NzXRP57YewUyLmWEB0dkwAeAOpDzXaLnaMXhIujZcHeNydo4HTpR+9b6Qg4uIif2wRfBJ8qvAgoiG
 zwo0WfN8QxtRRhA24zXz3sRBsHqPStF4rnlp5K7yiV9Rf9KQdWrbwuBKRWO+YajAWnmHIvq365iJz
 t2H/5Otg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1ldda9-000141-N8; Mon, 03 May 2021 12:46:14 -0600
To: Christoph Hellwig <hch@lst.de>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-4-logang@deltatee.com>
 <3834be62-3d1b-fc98-d793-e7dcb0a74624@nvidia.com>
 <a1b6ffa9-7a9c-753f-6350-5ea26506cdc3@deltatee.com>
 <20210503183509.GA17971@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d563acfa-f7d5-2f11-4c1b-b5e2f341a2cb@deltatee.com>
Date: Mon, 3 May 2021 12:46:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210503183509.GA17971@lst.de>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jhubbard@nvidia.com, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 03/16] PCI/P2PDMA: Attempt to set map_type if it has not
 been set
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-nvme@lists.infradead.org,
 Stephen Bates <sbates@raithlin.com>, linux-mm@kvack.org,
 Jason Ekstrand <jason@jlekstrand.net>, Ira Weiny <ira.weiny@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
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



On 2021-05-03 12:35 p.m., Christoph Hellwig wrote:
> On Mon, May 03, 2021 at 10:17:59AM -0600, Logan Gunthorpe wrote:
>> I agree that some of this has evolved in a way that some of the names
>> are a bit odd now. Could definitely use a cleanup, but that's not really
>> part of this series. When I have some time I can look at doing a cleanup
>> series to help with some of this.
> 
> I think adding it to the series would be very helpful.

Ok, I'll prepend a handful of cleanup patches.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
