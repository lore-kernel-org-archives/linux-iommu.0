Return-Path: <SRS0=3mOG=IN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF3CC433E0
	for <iommu@archiver.kernel.org>; Mon, 15 Mar 2021 16:33:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52EAE64F2F
	for <iommu@archiver.kernel.org>; Mon, 15 Mar 2021 16:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EAE64F2F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19876831A5;
	Mon, 15 Mar 2021 16:33:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r8HgKHDACWnM; Mon, 15 Mar 2021 16:33:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id D873783183;
	Mon, 15 Mar 2021 16:33:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF6E0C000B;
	Mon, 15 Mar 2021 16:33:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44C69C0001
 for <iommu@lists.linux-foundation.org>; Mon, 15 Mar 2021 16:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2DE936F4E9
 for <iommu@lists.linux-foundation.org>; Mon, 15 Mar 2021 16:33:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RJyk7Gqwnf2r for <iommu@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 16:33:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 996B66F4FD
 for <iommu@lists.linux-foundation.org>; Mon, 15 Mar 2021 16:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=25tvzr6LDKuaRWZ7Kq1InXgjrQLBkOCY64hHowQXZig=; b=jd/7txTKwBaK4XM4L4pEdPfaXK
 j77z2FSuQPygPyzOaNtQeB/WuPI0mEHeLQ5XoVaOvM0peJGMT0rSFK7QLdYPovQdiR6d9crYwP30V
 U3qzhU7lI4cnhPY5eLbFwsQgHc3dgrwJ+5RCrXGFRhWPpVYBx20B8JOfELVsToLgjg+JhMv9AAQoV
 QXi+qBm+8NQLJ8YR2We0YcMp4QAshPbXnXH9nMM7W7FgIHCSgDMML5rQNraVpwyWQFm6LURTNIcjG
 M4ZrRp9VjFELAy3KrIPg5y1v+lSFYwe8hnogW0iDZtEp5btt8nr/QzFZs11lfwZQdVaCWefOipyWS
 LCYU1tFQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lLq9a-0000OV-Kj; Mon, 15 Mar 2021 10:33:15 -0600
To: Ira Weiny <ira.weiny@intel.com>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-8-logang@deltatee.com>
 <20210313023657.GC3402637@iweiny-DESK2.sc.intel.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e9a6689a-3cb7-aa30-33e7-b27015754b73@deltatee.com>
Date: Mon, 15 Mar 2021 10:33:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210313023657.GC3402637@iweiny-DESK2.sc.intel.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, iweiny@intel.com, christian.koenig@amd.com, jgg@ziepe.ca,
 dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 ira.weiny@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH v2 07/11] dma-mapping: Add flags to dma_map_ops to
 indicate PCI P2PDMA support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ira Weiny <iweiny@intel.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Stephen Bates <sbates@raithlin.com>, linux-block@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Ekstrand <jason@jlekstrand.net>, John Hubbard <jhubbard@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>,
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



On 2021-03-12 7:36 p.m., Ira Weiny wrote:
> On Thu, Mar 11, 2021 at 04:31:37PM -0700, Logan Gunthorpe wrote:
>  
>> +int dma_pci_p2pdma_supported(struct device *dev)
>    ^^^
>   bool?

Sure.

> 
>> +{
>> +	const struct dma_map_ops *ops = get_dma_ops(dev);
>> +
>> +	return !ops || ops->flags & DMA_F_PCI_P2PDMA_SUPPORTED;
> 
> Is this logic correct?  I would have expected.
> 
> 	return (ops && ops->flags & DMA_F_PCI_P2PDMA_SUPPORTED);


If ops is NULL then the operations in kernel/dma/direct.c are used and
support is added to those in patch 6. So it is correct as written.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
