Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E12C433EF
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 00:36:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D50DF61390
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 00:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D50DF61390
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99F7884071;
	Thu, 30 Sep 2021 00:36:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D2V3LQzyBwXR; Thu, 30 Sep 2021 00:36:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6BA598406D;
	Thu, 30 Sep 2021 00:36:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 452F6C000F;
	Thu, 30 Sep 2021 00:36:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83EF5C000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 00:36:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F71684070
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 00:36:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gTW80gYfsPco for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 00:36:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8AD4A8406D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 00:36:54 +0000 (UTC)
Received: by mail-qt1-x836.google.com with SMTP id x9so4188506qtv.0
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 17:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BwrEOqITMVHTWeCijhMHSDgtGtdliHDBULe1zYCMads=;
 b=cnipXcpqu4R5bM9dgEXfQv8BOGJdXA84Z/vct47TAZsrhe6w/r9oUXvVRUGjrFVc9o
 1pqzLcPWuKWB7IKDJ67GQ2rJ0XJHZa9rDepLeYkUUjlUxrxSVALpK00Eq0gEhv5XCimW
 sHs4w+N9g0alec3otIgld2+AWdRLOeWRpLw+d3vtzb9Y7LM/WjCoP1OCGXbI5oFH2wcA
 Od4IxfZeZh+ym8BbKDSyGmZFnDZ/c6eOX1Sg9JX8M/BMCZdpEJadR2DfQiZA22RjHFQD
 9rTLu0GC5IGCqxQldXIJQ2vZ9a0iJRa0h0Mj+ZaME/saY1/RCbRN+q8xTUUHVWNi7uTT
 2+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BwrEOqITMVHTWeCijhMHSDgtGtdliHDBULe1zYCMads=;
 b=a3nxACand7k0B3a3JEn+Kxp7S9JByKWDbHyMWeUia5XUDs+4cYtENDN0csICBa/lmI
 eIXy+UixriS1rkG0nkXwuoVS4rfiQWOYhzlaLW+QzyF9h+/2pMrqXaEbEnV2+WjDhN7k
 U+yfzs4gBeMUu2b2gfIkYA+4w3tOcPa+4Z/sUXyP8lSSA22J++i9BED25oEgk7qtiaGU
 qGjoOyC6fIVlIc7Z2zLmW5hHdPzysnlzZSu7zEivo9j2ZqE/TMIOacDEH+CLKgFFXmFF
 KIwnoV9YH38ihyNeacOILEvkTqxJDjf7ThThaQFRcikhC3CopFqHQPVZltKxT7Zauvcf
 oRug==
X-Gm-Message-State: AOAM531WdNZIxgasJAvlSkrXpsyfzBku+iSk6inpf9k08GlNAyQ1uTf8
 gvwnRl0h+M9m0Hpazof+rP/APg==
X-Google-Smtp-Source: ABdhPJyC31MajIpVcurSSZ3nYCkO27psWnTuDsfNku/zaFdrDm/CS7iSRUZR5Bb8yV4im907u+gPsg==
X-Received: by 2002:ac8:5ad5:: with SMTP id d21mr3421614qtd.345.1632962213405; 
 Wed, 29 Sep 2021 17:36:53 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id h4sm815147qtb.67.2021.09.29.17.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Sep 2021 17:36:52 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVk4C-007upE-BZ; Wed, 29 Sep 2021 21:36:52 -0300
Date: Wed, 29 Sep 2021 21:36:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20210930003652.GH3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
 <20210928195518.GV3544071@ziepe.ca>
 <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
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

On Wed, Sep 29, 2021 at 05:49:36PM -0600, Logan Gunthorpe wrote:

> Some of this seems out of date. Pretty sure the pages are not refcounted
> with vmf_insert_mixed() and vmf_insert_mixed() is currently the only way
> to use VM_MIXEDMAP mappings.

Hum.

vmf_insert_mixed() boils down to insert_pfn() which always sets the
special bit, so vm_normal_page() returns NULL and thus the pages are
not freed during zap.

So, if the pages are always special and not refcounted all the docs
seem really out of date - or rather they describe the situation
without the special bit, I think.

Why would DAX want to do this in the first place?? This means the
address space zap is much more important that just speeding up
destruction, it is essential for correctness since the PTEs are not
holding refcounts naturally...

Sigh.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
