Return-Path: <SRS0=N1FY=J6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC9CC43460
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 18:31:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 526E261283
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 18:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526E261283
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E334940EE3;
	Mon,  3 May 2021 18:31:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WocMvgaiIIH6; Mon,  3 May 2021 18:31:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id C904740EE7;
	Mon,  3 May 2021 18:31:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E5E9C000D;
	Mon,  3 May 2021 18:31:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B83BC0001
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 18:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7958B404C9
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 18:31:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aNLN4jmU8_PJ for <iommu@lists.linux-foundation.org>;
 Mon,  3 May 2021 18:31:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E1FC7404C6
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 18:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=4PPTHdFwsG/FNijX7QmJQU5iOiwqKMFkAEJmwyjdEcs=; b=pWmTqC5UhoOtIRbROwzaB+ZWE1
 wHkLmyIDKJxZsZDLxgnD6Z1lbkZNPwtAHMVRKSMIIb9/0maQTAXw7MDfHeL1hFkcrZtGYsLBetLNw
 j+7qzrbqYPpPmJ23hX6P0ls4TPaV0WkGh5DsW1oxoRADWAdB3nzhINiIOs20KiGt0t0Ss/9SfTKjF
 xUcrvgRWw6/OrYVY9rAMPwOmac3o7/upKHt34JkI38fv0Z+DSNGGCnloayK7gr2BXlP4k3imBeIB9
 +aWQrrtNiOEqAn3BuRX+uctRRjVm2wQnywiNbH3clIsf9tjw46NnASc/POq5RagQrKSkmCqLwk8Y4
 wNygqJ9g==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lddLV-0000jc-25; Mon, 03 May 2021 12:31:05 -0600
To: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-6-logang@deltatee.com>
 <20210427193157.GQ2047089@ziepe.ca>
 <3c9ba6df-750a-3847-f1fc-8e41f533d1a2@deltatee.com>
 <20210427230113.GV2047089@ziepe.ca> <20210503182811.GC17174@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e3d55333-1e24-8dad-4a94-727bce8f776c@deltatee.com>
Date: Mon, 3 May 2021 12:31:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210503182811.GC17174@lst.de>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, christian.koenig@amd.com, dan.j.williams@intel.com,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
 hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
 Jason Ekstrand <jason@jlekstrand.net>, John Hubbard <jhubbard@nvidia.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Robin Murphy <robin.murphy@arm.com>
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



On 2021-05-03 12:28 p.m., Christoph Hellwig wrote:
> On Tue, Apr 27, 2021 at 08:01:13PM -0300, Jason Gunthorpe wrote:
>> At a high level I'm OK with it. dma_map_sg_attrs() is the extra
>> extended version of dma_map_sg(), it already has a different
>> signature, a different return code is not out of the question.
>>
>> dma_map_sg() is just the simple easy to use interface that can't do
>> advanced stuff.
>>
>>> I'm not that opposed to this. But it will make this series a fair bit
>>> longer to change the 8 map_sg_attrs() usages.
>>
>> Yes, but the result seems much nicer to not grow the DMA API further.
> 
> We already have a mapping function that can return errors:
> dma_map_sgtable.
> 
> I think it might make more sense to piggy back on that, as the sg_table
> abstraction is pretty useful basically everywhere that we deal with
> scatterlists anyway.

Oh, I didn't even realize that existed. I'll use dma_map_sgtable() for v2.

Thanks,

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
