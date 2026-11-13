Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599978;
	b=OPPO4i/LGZNebYE4XGBASn8dsWLiucgClnPjJN5PxEQdDSFu3d7ojOvF2bExi9FtvIfb
	 G4IAIGY5Zn8TsVAIEiOc7jLp5k9u6jouZu6aMhx4CUz1+h1H0J8fyojobdmP7Z98m6VYm
	 c65uXoklF5FuTjez3/rEhtbq9z48a+TSWG/3X0Yb33G9AgXvCgw2k/9zhM8NZ5QOkJb/O
	 mMCzXWxA8PJmk6z7AGKztsp5rSXHPrEkG0l6J3zkkrTkUFYXHyNfWWq90UvYd3IGOy3YZ
	 x+lQLmxi8qrMKpjSc5CYlGCbmR/zyHpKF/ODCxnevMZux1aHmlbOdKJqpUJ3wSM+5oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZZ2nZZ3s6y7qol6GLZvqI4xyT/lOQ3RMsv1KGP5S3jA=;
	b=QtGT89lG0qlEedq736rjwTb53pFd+BqX+XSv+BFH3l3kOK0+1pA3ODNB9/JcCtENZs18
	 s4XTceuoJgQ+Z52qdeaarAWMS3cdSVTBIlSvsDD+l5VPfHW8IlIG+efxLOW3fK61wpvbX
	 V+MJWOjEAEYrzEEi9IfFY4b2pFYTOKauUtMPs8F//KE9xJCc5c/l9x9p+rIpXWadhdDdK
	 cewqYNLPw5JBEFc8F8zzPjZNfnd27+ZetUt9+uaUUQOeQ3xWxc/7lK0raHaNgJvrYVUo0
	 kStpNGCCAaLQw9RA9yGIkln1Z9XCAhRzbIROuRh02wfxDWEMDHkat8ssuiRTnXjXJvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=hnSXD8dh;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B25F606B563
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 19:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B25F606B563
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=hnSXD8dh
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91ccfb88e4dso31393966d6.0
        for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 11:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794599977; x=1795204777; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZZ2nZZ3s6y7qol6GLZvqI4xyT/lOQ3RMsv1KGP5S3jA=;
        b=hnSXD8dhHUCaxdgaV/ylPmAxEuq+LsJSD4D/hEQeh6K7uxgrEQnc0hIFbC8mEWVTTs
         oap6ia/+PBz9dVhojJX4+Taf+XLbQ+vSzB2hWZ09fAqeWpe+9dzCB2QmhEQIBMCxMiaC
         AR2PSxkrZ49JP+WTf//4wGgMs8u6siJKa95Ykk72ONm3DhF9cAlMYPBxAihLEIRq48tU
         IW6TwkssKKOwEkTXn4QY2fPfSv7mn8oMJebA/elzPK7l0qpM5HsEm2SQ5eU9mBB10u67
         Ea+R3k3CtaB6ZtUWn1RscHHFq6iC+VQTqV1fTGpHEDoUtwOVGTGqFvGPQesrh68PXrjD
         6GUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599977; x=1795204777;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZ2nZZ3s6y7qol6GLZvqI4xyT/lOQ3RMsv1KGP5S3jA=;
        b=FOOSXAO3cyHSNkj5inUW16LRlvLdZ7MzmZY2H8OaCZ0OPTwGG12oX5KMuHc0wUJZhW
         OsObMnqEw8DU9eFnl/Z/pq9J0qXbMAMJ4hbxtl99IgW/5vkJa4yOZHSWL2QFWjAzn2NA
         lMf44CKSQODNRJrADByyinHtywBF51BLWlRGVt2P2qm/9dEp+B5i29a+Mk59jLn80s8A
         eZp8BtJ+NTzuuyGHUl/w1WrDXbUcpJsmXJxVF9yDxogKOVKxltKRU9DCYMb6x6cbrRV3
         SmGCcWyuvcBCmAxJnUZd/WQzBm9/ZjJX9ovBpysqWsl+JoUVhlNdc1elmleX7wMI7FCE
         LE3w==
X-Forwarded-Encrypted: i=1; AL+hErFOdP/ik5b6LGUKkwtgw/R87ucyDDSS8KcV+NhX6o1kaC48VUaKxNe0rSKb2AiaSND3rgFCFA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+YTgE7y3kCV1zFeXLq3wyGaKkhtpqtzwrLRp5GTmtdnxawxHzx
	bnBoKoOdLWyPJPjg3Ca9EdjjBqTyLTD0nob65TGAgBvdcx3G3z73DOJPY1gQF3SSeDo=
X-Gm-Gg: AYBFou16AaU2n1wwcv88E5n23Bgylzd/7rAxoxl2DC/Xnnx11+CJHhSWBBMwRuBYdkH
	kgUIofY8K+02KHTTU2FFPLBgfZX8/Q8gjFUd1hXrT6Sc7Vlfg1/VH6SyzXJGODGW2RrtmzbQD4U
	+fYAOFxBZUsQS3BRJHd1E6pvFMT3vlUtYhaMfjFGxOn4u/pQTByYn5Uw5ggp+tz010HqvccU9Gj
	z3O6BVeUft0qEfEy2x8Wsj4OM2meT1A17rPui1CvaGweo3BLgFlKY/1eMmZdPlFrREyFE38/GJ5
	uPvmR39ylN6q/oBCgf2k+3u/1ZIcYe7qB9WE+BlsaGXQ4+xkwGtUJzFniSvceUkJS8wdd6HRF+K
	JHCcPUhTEV9+WwnlVNCw55LLen1M2/0JaMk88byBFpySwVEYV4Vzo61f7zSMr8Mn9EvsILeGLsx
	Hb/LH2nVDKr6AvDUR9k9zNDe8uDr06ZaoCKGd5stAA0q9byCby0i6W8cpQgJkfNA2eKF+iL5Ymy
	QjfLGFqBdNYQWqk9vK7Qg+9lKqxEiMl9fUNrTk0JJr8nSdqOrOcOG78cv5qOJuoWs6LKGmC72kz
	8lFX0w==
X-Received: by 2002:a05:6214:451e:b0:91e:8d6d:21c8 with SMTP id 6a1803df08f44-91f2423e922mr59090456d6.54.1794599976764;
        Fri, 13 Nov 2026 11:59:36 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db49c5sm27322246d6.41.2026.11.13.11.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:59:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xRxQs-00000001ekG-3813;
	Fri, 13 Nov 2026 15:59:34 -0400
Date: Fri, 13 Nov 2026 15:59:34 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v13 00/19] PCI/P2PDMA: Route peer-to-peer DMA by TLP class
Message-ID: <20261113195934.GD2532299@ziepe.ca>
References: <20261111121602.GQ8635@unreal>
 <20261111224136.GA754433@bhelgaas>
 <20261112092326.GU8635@unreal>
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
In-Reply-To: <20261112092326.GU8635@unreal>

On Thu, Nov 12, 2026 at 11:23:26AM +0200, Leon Romanovsky wrote:

> > I guess one benefit of this series is that a path where P2P Completion
> > Redirect is set used to mean that pci_p2pdma_map_type() would return
> > PCI_P2PDMA_MAP_NOT_SUPPORTED (unless the RC was allow-listed), and now
> > it might return PCI_P2PDMA_MAP_BUS_ADDR because if P2P Request
> > Redirect is clear, Requests can be routed directly?
> 
> I'm not sure the first part (return PCI_P2PDMA_MAP_NOT_SUPPORTED) is correct,
> since callers have so far ensured that P2P is supported before calling this
> function. The second part is correct.
> 
> > 
> > That sounds great as long as the Request uses Relaxed Ordering, so the
> > Completion won't be affected by P2P Completion Redirect.  But devices
> > aren't *required* to use RO even if enabled, and I'm doubtful that a
> > non-RO Completion redirected to the RC is going to work.  So I don't
> > understand how p2pdma.c can guarantee safety.
> > 
> > Translated Requests seems similar -- are we assuming that if ACS
> > Direct Translated P2P is set and ATS Enable is set, the device
> > *always* generates Translated Requests?
> 
> PCI spec allows "A Function is permitted to intermix translated
> and untranslated requests" and p2p doesn't decide anything except
> if routing is possible or not.

Both of these are basically the question we left open in the
discussion with Christian.

To use this new TLP specific API correctly the initiator needs to tell
the API what kinds of TLPs it intends to generate, and ask if that set
is OK.

So you need to say 'I will use translated, I will use RO, I will use
untranslated' because each of them can have different routing.

NOT_SUPPORTED has to be returned if the modes the driver asks for
don't have identical routing.

I forget how this ended up when that got deferred, but that missing
driver input is an important part of the puzzle.

eg mlx5 knows exactly which of the three TLPs it is going to generate.

Jason
