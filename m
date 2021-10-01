Return-Path: <SRS0=Y/Kh=OV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D7AC433EF
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 22:46:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A86561AFB
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 22:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A86561AFB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4776A403A1;
	Fri,  1 Oct 2021 22:46:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0C9Avg4FfwZF; Fri,  1 Oct 2021 22:46:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E77D9402D9;
	Fri,  1 Oct 2021 22:46:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA5EAC0011;
	Fri,  1 Oct 2021 22:46:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21CC4C000D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 22:46:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0387A84587
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 22:46:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BO0SLtWS7xkN for <iommu@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 22:46:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3BDCF8457D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 22:46:08 +0000 (UTC)
Received: by mail-qt1-x82d.google.com with SMTP id e16so273083qte.13
 for <iommu@lists.linux-foundation.org>; Fri, 01 Oct 2021 15:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=tnXGytG/2aEvcazdaoXj71bXQnwjyukOXIDiPveIZXA=;
 b=pOTSnHYVXRz06VuaU1BDucThq3XLijVNOmqw8gUYgVjcX4bjaU1DPW80GPFpz1Bry3
 5Izso0qtrLy+uxnjkbarKVIHYAhUgvRAYbABr2JkvP9GCyg+7YRvw6KqUUc7seGsa9fH
 KzDaVUI4r8DRENRxq0vwC8QCWDmKp8VauDJh3yS5lxyhzeb0C6mReZGMghzJA7mUDjLv
 3H6R6bTZK2L5cSKTP/HRhXJP2RtP51MG45N0gotai5Ttri7QJaEBuKZ8DLCGMwehfYns
 QMf6evJgsJzNYeGrSyM/G3W4DM7LKIUGIRGLmulP3Gv60VEJqAsqbGSn5orZIQ0iTuZ9
 WZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tnXGytG/2aEvcazdaoXj71bXQnwjyukOXIDiPveIZXA=;
 b=j/73Xk1dyO8UlMIIeEmd+kBNe4qXXlyf8kmIiC+k1icyWCqU+FHcnkdCiocami+1mi
 dFhZW6//pi3u5QxjxCnavW8X18/nSxOvPIAHCT3+yGOD6q8mKHXQ1XMqdh6IUUJGAO0g
 Y5qlE+cMfB0tRlgNe1QiPQ/WeX2WxN7y2mHsoB7H61hdRt7bYQwABQr3GVZ1Kh0JFXQR
 M7J9GcirxHP/8PuY6YEnQotTMRm45HhlsZK2OWudPccRYuTxLRJz7b5DB8EVujnXZd1g
 0E4v20igSAj0ekjeVo1UzbCKWTtI96eb7hNl+SAWnA8KfrbRU5N84GKh6rUfhfaPqg6F
 6yQA==
X-Gm-Message-State: AOAM533tQ6WkEVs4TLCL6B7SR4txfCUT5ZctXqhO/pKGxXJSQ0rx/1IR
 3RCdsVFD53cOVVrqJZaYLo2R3Q==
X-Google-Smtp-Source: ABdhPJwIsqD13TKJo7mm1SIikHRk6qEvBFD6JpS7ZAJB6SMruIQLkql7OpNf4qMoVFvzMVj7AMSNJA==
X-Received: by 2002:ac8:7dc1:: with SMTP id c1mr551179qte.289.1633128366918;
 Fri, 01 Oct 2021 15:46:06 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id p187sm3759342qkd.101.2021.10.01.15.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Oct 2021 15:46:06 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mWRI5-009Y55-Ly; Fri, 01 Oct 2021 19:46:05 -0300
Date: Fri, 1 Oct 2021 19:46:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20211001224605.GS3544071@ziepe.ca>
References: <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca>
 <20211001134856.GN3544071@ziepe.ca>
 <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
 <20211001174511.GQ3544071@ziepe.ca>
 <95ada0ac-08cc-5b77-8675-b955b1b6d488@deltatee.com>
 <20211001221405.GR3544071@ziepe.ca>
 <8871549c-63b5-d062-87ea-9036605984d5@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8871549c-63b5-d062-87ea-9036605984d5@deltatee.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Alistair Popple <apopple@nvidia.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, linux-kernel@vger.kernel.org,
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

On Fri, Oct 01, 2021 at 04:22:28PM -0600, Logan Gunthorpe wrote:

> > It would close this issue, however synchronize_rcu() is very slow
> > (think > 1second) in some cases and thus cannot be inserted here.
> 
> It shouldn't be *that* slow, at least not the vast majority of the
> time... it seems a bit unreasonable that a CPU wouldn't schedule for
> more than a second. 

I've seen bug reports on exactly this, it is well known. Loaded
big multi-cpu systems have high delays here, for whatever reason.

> But these aren't fast paths and synchronize_rcu() already gets
> called in the unbind path for p2pdma a of couple times. I'm sure it
> would also be fine to slow down the vma_close() path as well.

vma_close is done in a loop destroying vma's and if each synchronize
costs > 1s it can take forever to close a process. We had to kill a
similar use of synchronize_rcu in RDMA because users were complaining
of > 40s process exit times.

The driver unload path is fine to be slow, and is probably done on an
unloaded system where synchronize_rcu is not so bad

Anyway, it is not really something for this series to fix, just
something we should all be aware of and probably ought to get fixed
before we do much more with ZONE_DEVICE pages

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
