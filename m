Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A023380FD8
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162854; cv=none; b=j+LE+nzQZVb5RMTpQA4SaONCaAocIAbfgXsDczZm+wQkDK25rdwuKj96Z0qfSuixC7vpooUwAKJ9pNViZpLqdxN51WUE/l18ny+c6XUsrrD30ejXsxVDWX7TMDKruj1giNDMv70AQvAhhFvMP0tSFKeZeSixPSMtOOPBDPdwo6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162854; c=relaxed/simple;
	bh=X82haFxsdgKx1jjnaKgCGlknhRGQInX8s7YpCkTIPnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trlgTDNZ00mLZ+On5ROMwjbFJCBLKjxPaLanFCjbEruxQ3Z/rRkYwWKaqas/4yysGSqPxsHSUPw+LsNMci1qYvbAaEB96suc+VSRKv2DKdOm4WSCprRuDuBZbIvtN/RkTJEX1n//HHNFRJO9n+yxt455ltV1i0qd1n/fQcezUbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WHm948by; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WHm948by"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93f269e335eso3183385a.3
        for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 08:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792162852; x=1792767652; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qAdHy+XfZaVWAHH+k3kEYHLQsWiJDDa9Am4rmLNBNPw=;
        b=WHm948byIcPdCjYc043C6WxQQcvoGdixAaJOtAG+gG0b9WAm3EACHzM3foekLtv4sN
         qpvVTxNB99sBKP4Q+b4eqtLj+RtBV65x01jGRbOCdhd3dx1otFdUYgbabrK+LQzLGK9c
         6fLXOECH64N7NlFkJQsmsn5RsMojqJZcJtxTRhXCt3imEvmrGEp6vllwJRFfOIGsUo53
         IOuZdkGg8rNKCUndvl30st4Q5DXa1hkDZzJKZavBoNSxZ2fjpSqL5ae5zxaBRif9QrHu
         GRogpPfSrWXhrmkRinjAA9KABZ7QloJWDsEQrw5HjZh4CY1BLeyMrUA8sjnjVaTa+sAv
         iaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792162852; x=1792767652;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qAdHy+XfZaVWAHH+k3kEYHLQsWiJDDa9Am4rmLNBNPw=;
        b=snpa+/FUVH2Cjc+OoyDbLxE1ezLH1WGO6jzXCU+Tu4Vu+1SUfBwWG2kLcEu+82KsTJ
         nnz9dTRAYURet9ncuOyM85A0rZHeb4bpBqV6Ov/RisV/QKY4GPZ7Iu5vkXhdZ64go3be
         h3OlHc9kDBdTM412TGFhB9rWZL+8bMw2yvqZFqXiuRgYOFsVDL+PYLCg3nq4XHgfo9Ef
         Fg4lccu3PBHwh3Jxa4+x6oOTruQGE7/0kip4jQsH7ivfo+cjyrvq/xknxEfagKvxOAlf
         fdcYsY6h2dk+ORHSLaPgdcmCNAWKhGZdJtcaSZ5ZVRDm9ed2E5mgXju1qiYU7t9zI0rO
         RssQ==
X-Forwarded-Encrypted: i=1; AKwUvByf1Y2p2woKOTNSJaC1j8gjpUGEQGEj1qjj9ctSuqMTB7UxfA8JyYg9Xlw5US5PsifOvtWDjw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLs+/D3wfs8Lstc24uv9IB/GrDuZQlc7eSYwPfvng39ZXbQgKpb
	L1wFDKFSKmLafxMTcqouznGNjHdO0uXm9a88hSFx7olwJzL7SJ2kZ+OC0c1ICU/cFGw=
X-Gm-Gg: AYBFou3Tst2au5biwLRagNWSPDD46zhVYYAZB5D65PJIibRBHI+SrNruq8KGDad4fXN
	okHP1tESavOQP2fzdNTS1QT5RhJl4Rvl/1RK3By8+HK2vJ3ic3plqw31ZOKVS/8TrXP0v+BJnM5
	vZxzru9/KuuN68n09ksJCv7eeb0+RlFg5uM/LUWH2DfpSsI1U2ETGZJKFXY3M8LX4jBsoY9IceY
	XP7h8Z5pJp/RVZZRBpL3U62tl137IKQqBFjgcTx9LR4GArMi647xogv7Gik99uKqZVsIWMrvjeZ
	GFqRl/Bkopqxg15hxyPWC2Vqx0/0n3/sESkfmIlb1bv8V1lJ5piHmGr3IzxQnTAJWk113H+ea1y
	I5lg8mHuLTITKfxUFEe7qLZRx61RpKgkyM6lnApbXB2msMGpYjVgdPZcvprCBEVESq8J+NrOe7g
	zmSiYeRDG0haTskAs1kDXcXHbf3k7/vnjycPetBm/WpzbBQJugFKl+6CbFVpUMpbw86XBAWC/yp
	HCw/Qihwhu7DYRWt5Ig+piCP0Nb2jnduv+chK39tRZn+0ZcwMtLYteu
X-Received: by 2002:a05:620a:40c3:b0:93e:646c:9133 with SMTP id af79cd13be357-93f29da5d84mr10749685a.64.1792162851675;
        Fri, 16 Oct 2026 08:00:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a0d0718sm232558985a.5.2026.10.16.08.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:00:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xHjQP-00000001teG-31SO;
	Fri, 16 Oct 2026 12:00:49 -0300
Date: Fri, 16 Oct 2026 12:00:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Gong Shuai <gong.shuai@sanechips.com.cn>
Cc: alex@ghiti.fr, andrew.jones@oss.qualcomm.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, atish.patra@linux.dev,
	fangyu.yu@linux.alibaba.com, gsh517025@gmail.com,
	iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	palmer@dabbelt.com, pbonzini@redhat.com, pjw@kernel.org,
	robin.murphy@arm.com, seanjc@google.com, tomasz.jeznach@linux.dev,
	will@kernel.org, wu.fei9@sanechips.com.cn,
	zhao.qingye@sanechips.com.cn
Subject: Re: [RFC PATCH 02/12] iommufd: Add RISC-V IOMMU hwpt and vIOMMU types
Message-ID: <20261016150049.GG14213@ziepe.ca>
References: <20261015235400.GZ14213@ziepe.ca>
 <20261016073020.10119-1-gong.shuai@sanechips.com.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016073020.10119-1-gong.shuai@sanechips.com.cn>

On Fri, Oct 16, 2026 at 03:30:20PM +0800, Gong Shuai wrote:
> Hi Jason,
> 
> Thank you for your review.
> 
> > > +/**
> > > + * struct iommu_hwpt_riscv - RISC-V IOMMU stage-1 page table data
> > > + *			     (IOMMU_HWPT_DATA_RISCV_S1)
> > > + * @tc: Guest device context translation control
> > > + * @iosatp: Guest device context stage-1 root page table pointer
> > > + */
> > > +struct iommu_hwpt_riscv {
> > > +	__aligned_u64 tc;
> > > +	__aligned_u64 iosatp;
> > > +};
> >
> > Like the others you need a spec reference explaining exactly what
> > these fields are.
> 
> I'll add references to the device-context sections of the RISC-V IOMMU
> specification ("Leaf DDT entry", "Device-context fields", "Translation
> control (tc)", and "First-Stage context (fsc)"), and I'll also include
> detailed field information, as ARM does.
> 
> Also, I'll rename the field from iosatp to fsc. It holds iosatp when
> PDTV=0 and process-directory-table pointer (pdtp) when PDTV=1, and the
> two share the same layout, so the name should cover both interpretations
> and the uAPI won't need to change when Process-Directory-Table (PDT)
> support is added.

You might be better off just to have a data[] array of the device
context. I prefer the fields are not parsed out in userspace..

Future specs may add more guest controlled bits and in other places?

Jason
