Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF00C43334
	for <iommu@archiver.kernel.org>; Tue,  5 Jul 2022 16:30:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB66F81B84;
	Tue,  5 Jul 2022 16:30:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB66F81B84
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ARfWpr8p
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7JA01Syr06Xj; Tue,  5 Jul 2022 16:30:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 49C9281B48;
	Tue,  5 Jul 2022 16:30:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49C9281B48
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13368C0032;
	Tue,  5 Jul 2022 16:30:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD24BC002D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 16:30:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 77D0D40178
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 16:30:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 77D0D40178
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca
 header.a=rsa-sha256 header.s=google header.b=ARfWpr8p
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CBQdNOpgZEfF for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 16:30:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 89DF3400A8
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 89DF3400A8
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 16:30:01 +0000 (UTC)
Received: by mail-qt1-x829.google.com with SMTP id z13so14425685qts.12
 for <iommu@lists.linux-foundation.org>; Tue, 05 Jul 2022 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=sChclduKae/84cDz0BrZ+MP0tp+PTlAr9CZeDjfj13Q=;
 b=ARfWpr8plwJhNlfMsfgbkLKFpSjayQPH+TVLj9njVh+9ZVwwYS0Q5lpx3QESUlwiJ0
 Xau0D8DTEtlBLA2TKJjGb0eWyuHzYJSySzH16w8i60Ucpq6lkPkx/9MUbSA7H8PkF9mf
 vy2eLsJPe5CP1cJVF8B6Y7AsRY7nQqxYHkWBv4hIekpX2n63jyIHOZts2vGssV+p6X7i
 o5tnF3lXu1HBK0CIU9B+BuQxS3B79T/BqxNUUNBMTSi7dFTn3cejUhBmCkHwZYPAldDy
 CzT6wuFA6Z8An5ETNanvoj5+zinJwVg3guVjtkzMtWjvDNeS+j8gPF7lh16xjKsVoTSd
 rVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sChclduKae/84cDz0BrZ+MP0tp+PTlAr9CZeDjfj13Q=;
 b=w8Ti+7656IrFLa6mT1jiOPkCbrGCrTnjikyJWGL1WmGnaypEptDwjv0rtwCybS/v53
 oESoUvredeyvG42faOQ+zWHIpzSPPS27vEanpvOzZ6C6lzDp9nWsH+h7xPuvwU/zsrq0
 2f/y5piaY80yc/JrzFwsadz1bqwK5EzntPSPI8r2EvpOxoZd/EFyapZ0bin0fhpYhgBX
 r6pFcl/KEe7Zhbvf9vtPG8v1CmKfBB8rl+s7wAchIvaAOj7RDrda+vxcl1OtG0jJyuQb
 UgJcmGQD19sh87M+uTJlqla779hz9H6ZUGSp1FiaZJjkAworrGeil1vE4+o5v9MJgGOX
 hvHA==
X-Gm-Message-State: AJIora+vtdOWZ/9v+T8K499aqd/bhhVE7svWijU84icunPqlSmDP4xUt
 dx6CVY9ik0R9lt5glIFPzR4M+g==
X-Google-Smtp-Source: AGRyM1tPLgF/oa5jp6ch7h66vURUmccxqkvEu70fGN2pQIZRW9uE0+BIJoib0UJtgkigroai62+FZA==
X-Received: by 2002:a05:6214:27cc:b0:470:9aaa:94b5 with SMTP id
 ge12-20020a05621427cc00b004709aaa94b5mr32033702qvb.129.1657038600343; 
 Tue, 05 Jul 2022 09:30:00 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129]) by smtp.gmail.com with ESMTPSA id
 k11-20020a05620a0b8b00b006b25570d1c2sm11328498qkh.12.2022.07.05.09.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jul 2022 09:29:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1o8lR1-006YYv-9I; Tue, 05 Jul 2022 13:29:59 -0300
Date: Tue, 5 Jul 2022 13:29:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20220705162959.GH23621@ziepe.ca>
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-21-logang@deltatee.com>
 <20220629064854.GD17576@lst.de>
 <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com>
 <20220629175906.GU23621@ziepe.ca> <20220705075108.GB17451@lst.de>
 <20220705135102.GE23621@ziepe.ca> <20220705161240.GB13721@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220705161240.GB13721@lst.de>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-block@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Logan Gunthorpe <logang@deltatee.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
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

On Tue, Jul 05, 2022 at 06:12:40PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 05, 2022 at 10:51:02AM -0300, Jason Gunthorpe wrote:
> > > In fact I'm not even sure this should be a character device, it seems
> > > to fit it way better with the PCI sysfs hierchacy, just like how we
> > > map MMIO resources, which these are anyway.  And once it is on sysfs
> > > we do have a uniqueue inode and need none of the pseudofs stuff, and
> > > don't need all the glue code in nvme either.
> > 
> > Shouldn't there be an allocator here? It feels a bit weird that the
> > entire CMB is given to a single process, it is a sharable resource,
> > isn't it?
> 
> Making the entire area given by the device to the p2p allocator available
> to user space seems sensible to me.  That is what the current series does,
> and what a sysfs interface would do as well.

That makes openning the mmap exclusive with the in-kernel allocator -
so it means opening the mmap fails if something else is using a P2P
page and once the mmap is open all kernel side P2P allocations will
fail?

Which seems inelegant, I would expect the the mmap operation to
request some pages from the P2P allocator and provide them to
userspace so user and kernel workflows can co-exist using the same
CMB.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
