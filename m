Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6432CC433EF
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 21:50:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB2854169E;
	Thu, 30 Jun 2022 21:50:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CB2854169E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=Jj488gdv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WrhDQSjSSZMT; Thu, 30 Jun 2022 21:50:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2974841504;
	Thu, 30 Jun 2022 21:50:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2974841504
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3DA9C002D;
	Thu, 30 Jun 2022 21:50:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4D76C0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 21:50:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AB69583F04
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 21:50:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB69583F04
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com
 header.a=rsa-sha256 header.s=20200525 header.b=Jj488gdv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2EW5DiQ9rc2O for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 21:50:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0D1AF83E17
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D1AF83E17
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 21:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:References:Cc:To:From:
 MIME-Version:Date:Message-ID:content-disposition;
 bh=L+x+wtKtqznZ9UO5BN1Gnb22+HteJcnx5QZHLC44n98=; b=Jj488gdvqsV18JMGTmwXJUFoGQ
 CblCro8U0WuAdM8gOpccLKuBiaeJ+nN3Lo/S6X8BXqAFs0cP2r6w1NZevOKPMvgfWS5XPLy+wMGUa
 X+zYUPFryGdBKNeIbU7ImfRISf0kJRkC7KKZTRuIGAssdELHIn3StAJwRXKVpZqhrr2GbIC0v4cSj
 m81Syv7Im4YpQ+9FQT+W6OVo5d0Z4DfA6ixTpruYVv3snPN7jhpB8k0zKK/DECdMRa2sWCkzfd3C8
 phncKnrZB1O0Z7N6doBtnPrjc0e183a4KnhG+K3aYuR1g+umuSg/LOlHXUq4o8YhKeZqbn2ugJtQb
 dzbYLYsA==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10]) by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <logang@deltatee.com>)
 id 1o723B-003P1h-K8; Thu, 30 Jun 2022 15:50:14 -0600
Message-ID: <39bf0071-0acf-12fd-3d3e-06dfd87bb409@deltatee.com>
Date: Thu, 30 Jun 2022 15:50:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
To: Christoph Hellwig <hch@lst.de>
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-17-logang@deltatee.com> <20220629064629.GC17576@lst.de>
 <7da06e08-7dd1-f37c-4382-bc59a1b1e819@deltatee.com>
In-Reply-To: <7da06e08-7dd1-f37c-4382-bc59a1b1e819@deltatee.com>
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: hch@lst.de, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com,
 dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com,
 jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org,
 daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net,
 dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org,
 ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com,
 ckulkarnilinux@gmail.com, rcampbell@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v7 16/21] block: add check when merging zone device pages
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-block@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
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




On 2022-06-29 10:06, Logan Gunthorpe wrote:
> 
> 
> 
> On 2022-06-29 00:46, Christoph Hellwig wrote:
>> On Wed, Jun 15, 2022 at 10:12:28AM -0600, Logan Gunthorpe wrote:
>>> Consecutive zone device pages should not be merged into the same sgl
>>> or bvec segment with other types of pages or if they belong to different
>>> pgmaps. Otherwise getting the pgmap of a given segment is not possible
>>> without scanning the entire segment. This helper returns true either if
>>> both pages are not zone device pages or both pages are zone device
>>> pages with the same pgmap.
>>>
>>> Add a helper to determine if zone device pages are mergeable and use
>>> this helper in page_is_mergeable().
>>
>> Any reason not to simply set REQ_NOMERGE for these requests?  We
>> can't merge for passthrough requests anyway, and genrally don't merge
>> for direct I/O either, so adding all this overhead seems a bit pointless.
> 
> Hmm, I suppose we could also ensure that REQ_NOMERGE is set in a bio
> before setting FOLL_PCI_P2PDMA in bio_map_user_iov() and
> __bio_iov_iter_get_pages(). Assuming it's always set for any direct I/O.
> 

Oh, it turns out this code has nothing to do with REQ_NOMERGE. It's used
indirectly in bio_map_user_iov() and __bio_iov_iter_get_pages() when
adding pages to the bio via page_is_mergeable(). So it's not about
requests being merged it's about pages being merged.

So I'm not sure how we can avoid this, but it only happens when two
adjacent pages are added to the same bio in a row, so I don't think it's
that common, but the check can probably be moved down so it happens
after the same_page check to make it a little less common.

Logan

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
