Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718626;
	b=Ut79YhKq5MzPP/3EDcJv5ZDH3mqGUEBO7O8QXLzEaL9EI4IBG6G5iiU4Um9/GdwaCzkF
	 BeYmtpfwvRWin2tWtyvaK9J6FdyOGjiqO6qkznX8FYWoOKb4+8sqeMY9eOFAHE6Zk+fTD
	 WF1jMMqZf/GADtw9qbZggr+l5Bz7eGKU6AjTW9rb3wjWnI1RDx86JRq1pJoRle5Bq404W
	 cYfYuurD9pKrwiutl1K3CoPR9t3JbvncnPvLyb3O9/vLYrRHaCfiDvmyIg6djs96JzHYd
	 TzvKcQv5ArIFERJdTk53GZ3H+/qSXo4ZIwa0BF48ga9my/or7UzRI6DdWvJFjBf08lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Vt7h2p23Imler/JHYQ9qmz6AHyS0w7TaI6hUPIpmc2U=;
	b=PIK0XPSJXBT59CFA+IpI2m5zcmLi8FEVV06BgzS48KAERg0PnuIP+87frBC079Tq0Lzh
	 zxRZg6CV9qGIkkdLidbY89PiJzF1/mJWHJp9d8foF1qnZCarTp4Tg0t5uNcrHASrFG+Wm
	 Mh9rFAKoEri94w8Tv2NeqJUky58RyZwpn3Sr60UkPU8jYBSGcVoSRivyV5m4oXHHNM0GD
	 Dsj7rwnXPo4/LMkbcMnCwhLxvmOmm93I2oTraTy5Np5tFNc/h+TjP4va4gs2NvD00a5Am
	 ZHNOJdn6SFkA156dK9rcbR7If3ynCRP4uKxWLBtZKBXIMp/tFtJyQh0A+B+cI5kRu5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="ckpbcc/N";
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D793606BA26
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 15:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D793606BA26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ckpbcc/N
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-533778ab0bdso60274301cf.3
        for <iommu@lists.linux.dev>; Tue, 03 Nov 2026 07:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793718624; x=1794323424; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vt7h2p23Imler/JHYQ9qmz6AHyS0w7TaI6hUPIpmc2U=;
        b=ckpbcc/NSgjx5ZA8eeMYcxbuCasE27AKGP65UY+axFwfo4G8/bR+qep2BJ9egP1IsN
         6/Ekd4yoA013QslDsGHB8PCjpdo1CIPGhnY2u2cu//wGq+0nCbGILTKreUQ5Hwn5Q1VF
         idC53fE28Rjchb4GYCdyk4Kw3xGTcpoZznSBQsOx7P74Ow+PMc1TSCmGFTC/zIPhCMCH
         Ut1nvKKqK4iEdWfrMO+FbvizVZcV0Kp3Py+7wGrc9i491x0owmCIVRZ6zhR/McFjiuXl
         MkhAzbUKhUcvh7n805UZPvf0tnP3IxobCl/vi5oqYwmdMLK9bijP7m1eyMaxCkMOPAxS
         mmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793718624; x=1794323424;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vt7h2p23Imler/JHYQ9qmz6AHyS0w7TaI6hUPIpmc2U=;
        b=xkBw6s+girJbELUDGpCJjSGN+8Vms180O1PzCVc3APoLPpuKIjbgxJAf/AMhlhrE8S
         2cCP7zEc3ZjsaN9Z7Vo8lhjwMLAHDzti0NeeVpTC95TsSnyip763F7MRxqCd6M8jYdNW
         4F+uKeRl+DMPuUbsRWxzWIZD+0izhQCHn09nQ61NjBATVwtH2vM9Hbr70zqj0FreIjOV
         aRlvdUSpnizMLROun8FUHusJgcBhesL3407eXw6EJyafW/n3hT3p3AP3f34Q4vM4k97C
         kh4lNWt1atA0tK3HMfOAKjIiitDNYgEyKyx+AQ3azq2e8vsGadhz507ZCxzUcf8PTxgE
         IQsA==
X-Forwarded-Encrypted: i=1; AKwUvBwNTHpvhMW6hJdVSUb6uTrrsUStrrxjspKd9WWOgla8/w8QSQWHXyvv/OAJcI56ojj4I5UZdw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8kLQy43LDS1EgVsIBSBYZkEQ/nKa8py9L9NI2EGxb++Z0zBjEn
	Tz3bN2YLWdTHyfy3DGfE9GmVlt7R4Z6ocjBkI7bJy+MCk1s8OnkZLMh9hIgMpo2a0RM=
X-Gm-Gg: AYBFou1WYoQUMyEJNqnI8dxFeLmJyuIiZx2L/BdvHt7kcubOQv2ZcIjnyO0i0zNJ80g
	PShR+TVLn0VXUq1lkOa5aQVl9QKBHw9jMR2T3iDNFlpQ99GOd0MxfXlZGeAUpIMyn2y55bjBwqq
	8/UwEpZ/D06KfoOYcKYseUhVyhl7qILP8kTYHWVrAwykcCFjLHdWvoK3oyyCi0Lrz5J1nLjYXLv
	FyLsc1eFB90i4oFkmaWhuE56Wsy4vK9QKz2/QUCutFUvwUNjGcEQi64xCeKz7bFwBY0oGuxNVsH
	oln8zs1AfZ0chTkbEuGXwppqJltrNaZ0J1whroIRh+w/ZsTHZ0DoUGP8s051Pkw1wWS4i0bk1ep
	Zd/QdVyaUS5CsHaqTAKcWd7vhe6+5NGjKTPaen+3u29WhhStVBy+U/iG8PZHL4ZfnMbAgfyci0p
	a7aycS3CyY30EqaXfRG9qIhNnytfZo9OZ4mwfHQ2fGKyN9MVIKZa5oe3MYgFThld48IrJ6Aa8+s
	ttbmpSOXcEnSKdFhr+ri4mwUxbl01cTdRodfZSQkRDRUzWVBYPLtCtztMnDLamGT01BjgRz+SxK
	Hxt6HldOTUzhkSuXkY8QkNGPVeh0nmdtQMAp/fnwtbJ33VXnAtNsH4tuqgUoLiB+CcobK0VfS4G
	womSQx+B05A==
X-Received: by 2002:ac8:5a06:0:b0:536:26db:d4e2 with SMTP id d75a77b69052e-542b639bb42mr236124421cf.15.1793718623983;
        Tue, 03 Nov 2026 07:10:23 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498b49dcbasm27980831cf.6.2026.11.03.07.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:10:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOG9V-0000000DAq9-0szH;
	Tue, 03 Nov 2026 11:10:21 -0400
Date: Tue, 3 Nov 2026 11:10:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Luigi Rizzo <lrizzo@google.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev,
	netdev@vger.kernel.org, linux-mm@kvack.org,
	driver-core@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
Message-ID: <20261103151021.GK3889730@ziepe.ca>
References: <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com>
 <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org>
 <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
 <20261022201229.GH3381610@ziepe.ca>
 <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
 <20261023140107.GC3977851@ziepe.ca>
 <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
 <20261023145023.GH3977851@ziepe.ca>
 <20261103080933.GA4213@lst.de>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103080933.GA4213@lst.de>

On Tue, Nov 03, 2026 at 09:09:33AM +0100, Christoph Hellwig wrote:
> On Fri, Oct 23, 2026 at 11:50:23AM -0300, Jason Gunthorpe wrote:
> > > Disk I/O is still potentially affected by the same problems
> > > (cost if io mapping/unmapping, iotlb thrashing, bounce buffers
> > > in confidential computing...)
> > 
> > The disk folks already have a proposal to address all of this using
> > io_uring and preallocated buffers. I really doubt yet another version
> > is going to be interesting there.
> 
> Huh?  If you mean the dma-buf I/O it doesn't really have anything
> to do with disks, except that this is the first user.  

Yeah

> The dma-buf iovec can work for every ->read_iter/->write_iter
> consumer, and should be adopted more broadly.  Including by
> networking instead of their own totally weird different world.

I'm not holding my breath on that one..

Jason
