Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BAEC433E0
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 20:54:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE9D64F5E
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 20:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE9D64F5E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E42E643087;
	Fri, 12 Mar 2021 20:54:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OW2GCvEg7pCo; Fri, 12 Mar 2021 20:54:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id D165B414D8;
	Fri, 12 Mar 2021 20:53:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADBEBC000A;
	Fri, 12 Mar 2021 20:53:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02C76C0001
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 20:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DCF1143083
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 20:53:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZGT4OdFuHxm9 for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 20:53:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 61AA6414D8
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 20:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=CGrXx6tnunS4rU4vJV260ajUW0JSem+Dld3wlshcr6w=; b=BDbN0bC7mvuP4MZ4/ukk0LJPNY
 DPviP0ZYyTMeFAwbu8j5dMB7b2KzG2FZ7qIkKt0NUgGiAf1lt0M1PYF+gfW9IiRlBWt46STFG4T8J
 cZYMNg2vCeXa+Q8UWw2v2fJVgGu+2rbQWfbc9Xj5/D0yUfdNA2Z63WK6JaJHzMzVN8MTGlNX/GGyd
 Q6TBybdzp+x5Va6pP4OJcp8RqQl1vJGjI19FBAYa1GlCi7QLe7TtG8cifa5LNRoBCRtHYgdC61UIV
 8pOHhROLuEdapKBxAr35W/geKRPGeu8OGDWP2al0JqcX1wjdqdeNjhR6T4IFhrJ7RbKjOU1kMSY/G
 DjXl5YXA==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1lKon3-0002ZN-Ku; Fri, 12 Mar 2021 13:53:46 -0700
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20210312203936.GA2286981@bjorn-Precision-5520>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b7b61f6d-3a94-3539-f7f5-425fbb1a9dfa@deltatee.com>
Date: Fri, 12 Mar 2021 13:53:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210312203936.GA2286981@bjorn-Precision-5520>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, iweiny@intel.com, christian.koenig@amd.com, jgg@ziepe.ca,
 dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH v2 01/11] PCI/P2PDMA: Pass gfp_mask flags to
 upstream_bridge_distance_warn()
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 2021-03-12 1:39 p.m., Bjorn Helgaas wrote:
> On Thu, Mar 11, 2021 at 04:31:31PM -0700, Logan Gunthorpe wrote:
>> In order to call this function from a dma_map function, it must not sleep.
>> The only reason it does sleep so to allocate the seqbuf to print
>> which devices are within the ACS path.
> 
> s/this function/upstream_bridge_distance_warn()/ ?
> s/so to/is to/
> 
> Maybe the subject could say something about the purpose, e.g., allow
> calling from atomic context or something?  "Pass gfp_mask flags" sort
> of restates what we can read from the patch, but without the
> motivation of why this is useful.
> 
>> Switch the kmalloc call to use a passed in gfp_mask  and don't print that
>> message if the buffer fails to be allocated.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks! I'll apply these changes for any future postings.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
