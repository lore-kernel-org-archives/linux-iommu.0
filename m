Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792792912;
	b=ovqg3KxhvaQslhP5Aq3vSipi8wOyD2ILURvucTXkL0pBwhR3ASgcJEec3edSyDDJgIGC
	 sovmQXN8ApkrvIvgquppelHuICzH5auhAAhFrMmSJQ7zzCIxRAYgznwXQEFs51IGF3BMH
	 H3S7bWNJGoKS5FXTcd8GCig8S8yGcl/hr3ARhSzNKsYmObYeAOFivWJzC4ilRcx2vfTdi
	 TBuGHP9Nsae+XVRisCFGndLsOFtaTUvU5vKbnTBZsovOzxAv46DH/hcQYkyGYPjQTdTKm
	 22qgnV/RZDyyhc+F2kCdxgmBowuFv0l+wGMYzi634EwhiSA1A4bhgG8OTiatlBxPsUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792792912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=7bRloCtYRc/1CN8Q7Hs9aasGSanwrF1DkhN4CIO4rT0=;
	b=OGSe3W1JhwgyFqYuBq3FaaR0+7W4p57zsFq2gJEYqcd3AWgYyuOUL0MRm9Uz3EAhO48D
	 VscN1CRsIfuZoNWKXrqvBi/wwHdW/YxbxM77hiv4w6LeIPolJIaButRKPVKRu/CCawMcc
	 ewrU5MtrA3TP6MDP/KYox9Rz+Ff0jp2GXxKIoyZw/4qO52gKsSOfvg43qYfVR2IjE9Q4f
	 Uslrm0BFa3MnBQYhX7ACt5aV8SNWxsKqbkV46BPvwpgPx8NVWSpDWfJBHpjt6Q8SG4L4a
	 04vOzd8K9o3rmLhhjjZr6ShLUqvz/oUCikuFoRAvlr0unI11t3MdeDEgPNEcMbcv/Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Fa13M9mv;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4958606A31B
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 22:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4958606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Fa13M9mv
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93e503815adso137009185a.1
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 15:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792792911; x=1793397711; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7bRloCtYRc/1CN8Q7Hs9aasGSanwrF1DkhN4CIO4rT0=;
        b=Fa13M9mvnEi3T8bTX5w+7jOOfENTfNEJ8L+xQdol36NX/26B+bIHx40KfxW5+LxxOM
         Ct6pIe5cQWH56GtMwRWvDi3Jrat9ioMM3TwerQd3s2D5Q3JnKJwCD6jaA4O/xT1aGutJ
         ioxq985opFjCDMVcgVGCh2IKjmhMuG6RWTwz9fsJUN3dJrdWinOOdm9HOn7B7aM2UXXu
         GDOILtbuxPwvADIsPblVC3p6ruvnIht+XPWDX+dzqSJNNm4JzrsYwuukCtjDXPD7fm1S
         tqkgmqRLyEK4txPfYS1kiIwlo3+8+o8u7Y8KXGN02mfYhoDgoGNs/mm41arUF51Zsp3t
         DQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792792911; x=1793397711;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7bRloCtYRc/1CN8Q7Hs9aasGSanwrF1DkhN4CIO4rT0=;
        b=jSaLrd+NqaNUOTLYjyTrUZc9yX2HtNuDXcFdxNrPLYvdF8gm6BR0lVmdpu5WVnv2uK
         ltNy6L5Z+4ZUWMunx/sWtp1Xl4SFLWQSs7m305pQayxaGkR3QeoofZci7VwfwhaNX3k3
         BG0M72thc/F4ePUmVtxIuLgzC/tCLwfIu7sxj+xhRq0IAwtTtq6ty3kMmUdfWEMnKYB3
         fr4RCUV6PU8AygKkd2eu99T/jrqoihH9wU3u8FWuHKNXqJ6rLKAprKOtyfE82xldTt4C
         nM+lme2x8jTinsd2MQaBJ96gq2QO+9bluvb3AMvKf6gljn38MrMWnipqJO74fyNHdzHL
         VGrg==
X-Forwarded-Encrypted: i=1; AKwUvBzJYbX/dKE2wLIOrJaYBIhYOq67nrOhcbOUG6AAQbLYjnLZU3KFzPVs0RvEVLt1sPT6Xt6/Lw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJg48s1/DJ2x/uaVrS4x8M03IkKlmDm6pMvx+akkOfM5lBKXTtD
	gFhGguR+MLXj/5ZUVahaFHrFigQdUvGGSVtU3ZwscB9bH94tIcnXb261dwIMkwpB0WU=
X-Gm-Gg: AYBFou3wpxqnYhhp/L7Hmwz/UtlXE44hcWcmkOfyCaia+GWe36KM7E/vCfboHcS4pBf
	C7KtvBoTLcsOQICgtQXzX2WnqvGY8EnMbbmttABx2A/VDNydqGL+kZ06J7K5CvQjiBRQypQgLkU
	d1H247BvcOV9+FibDuPHIbJaB1EIrFtjQyiNRNlzumf/T4oMQYmhgUrgLLPduTrqdWlbmpP8lfk
	ykDuJ1ZlomvHyDrdNHHe8BfmIYZXppDMI4z48vwYwuvgCUegfEiZU5hAbmh828yoV2t2GLle+Cw
	5t/p5ckyPNkJP0svF2sca0+XHn2i+XsedUb7ucI4S6Iipu9EBShds1wNn4/hIM+g75t6g9xoj+Z
	ViE3swtIwoGMMTZc7b/mfSUtNV8ZIdsK9lHGAZprgkqwAmBLl+hIhqZgXhshUivHW77et8+Sjm/
	HvgGk5JOfW+8UtT4jEJwvEfX/3rGIlWCgMmpF5qT69FXh4aQVJ2F0BJ8JBZyX+SCkXmFxToX+YH
	+xQZsTyKypPy3pUYZxYR7H4yLKapFhtpgJVCuPX8KHLCx1PdUXwJLzGh4o7/gEolBaYNWTAp7oP
	ZQABlvXmo6q16oW1PAJJVaJ6Y8j9DwkYdDRPaw==
X-Received: by 2002:a05:620a:4441:b0:93e:c12c:f137 with SMTP id af79cd13be357-940ef9c87e0mr54142985a.82.1792792910841;
        Fri, 23 Oct 2026 15:01:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f078a762sm18520585a.30.2026.10.23.15.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 15:01:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKNKe-0000000H7Vk-3jIV;
	Fri, 23 Oct 2026 19:01:48 -0300
Date: Fri, 23 Oct 2026 19:01:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH v9 02/18] PCI/P2PDMA: Derive routing from directional ACS
 controls
Message-ID: <20261023220148.GN3977851@ziepe.ca>
References: <20261023190036.GL3977851@ziepe.ca>
 <20261023201531.GA2805244@bhelgaas>
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
In-Reply-To: <20261023201531.GA2805244@bhelgaas>

On Fri, Oct 23, 2026 at 03:15:31PM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 23, 2026 at 04:00:36PM -0300, Jason Gunthorpe wrote:
> > On Fri, Oct 23, 2026 at 01:27:15PM -0500, Bjorn Helgaas wrote:
> > 
> > > > Yes, the ACS combination is selected to avoid ordering issues
> > > 
> > > Does a user have any way to know whether the configuration is safe?
> > 
> > No, unfortunately in PCIe so much is really difficult when it comes to
> > deployment :(
> > 
> > > I'm wondering whether users might use "pci=config_acs=" to configure
> > > ACS so things appear to work as they prefer but may not provide the
> > > ordering guarantees drivers depend on.
> > 
> > I imagine that could happen, but on most practical systems the root
> > complex will blow up if you do asymmetric routing so there is an early
> > indication.
> > 
> > I know this because I've help debug such configurations at
> > customers. Some servers helpfully MCE if you do this. Lovely.
> 
> I'm still confused about this because earlier in this thread, I
> thought Leon said you do asymmetric routing:
> 
>   Bjorn> And I guess asymmetric fabrics must mean fabrics where
>   Bjorn> Request Redirect and Completion Redirect are not set the same
>   Bjorn> way?
> 
>   Leon> Yes, in some of our systems, deviceA to deviceB is going
>   Leon> through different route than deviceB to deviceA.

Yeah, that's what I clarifed, it isn't quite accurate. The asymetric
routing is between Strict Order and Relaxed Order TLPs, not
request/response.

Jason
