Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534578;
	b=uhvFXN/DPuPHDiiL8FES27ksI7bjY7PdbA6eIn3Aq4dnnxAdKGtfjwzJwiR8yuhU2UQE
	 yzlgrM/GWXgdeoCKFLz3W7QtnRCbSFYt2oF6Dxlco4+216jBpNAxnRGH2sti10v6Hkl3Q
	 2k/UkTd6hWIFzr6HacaPNjgnIvgvMEVDRJwfxG2J7vgmZ1d7VRUonADs3oh4ylU66qfai
	 8FJeXtuMZJHAQljZYu5OvjooajXDQ8MpcQfK5i704LhPmsS92TuekzBMeEyy1JrvTJx10
	 NESynFxsYauRzR+L+jOhnJNWjrEolT5zk6oJmBMVEVmzKS0/+oYBd3OuWyVRdzYzp8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=pztq+Cm1+ZAP57GA6CuWEqPVZxEOeq25+Hlck3k+Nv8=;
	b=touOACkeF7L2t6MbbxLnkkgJlpT3UWDrfPGHmmXgNTo3wMct246zOq4NvdcbR2dpEsZ7
	 qROBkS/rMdlC/J9gavN2TNuFqP1tESwo9e1GNLUjV20rpVh4y70TtcFbxrQphg16yJdB8
	 SGfiXmI2GjsKnjQxt98dVAj8Ebd90O80VUM/As2kOn3fvV0QXQt8TCysRC5A5X5qyHksz
	 gzZB3hs+2FLZ52oc3udeciR9DnswGOKkw4iDI1DwFUKPbIOSr7Df1AklIh04n76/eWjmA
	 J64BwgnKo6A4tLPX4ALVi522vHpiK12EiY619nTGvZ/vAKzTvi8HMKZsYdWF7q+gSgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=icW55hv6;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70DF606A327
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 15:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E70DF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=icW55hv6
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9495d543c42so474138885a.3
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 07:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795534577; x=1796139377; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pztq+Cm1+ZAP57GA6CuWEqPVZxEOeq25+Hlck3k+Nv8=;
        b=icW55hv6Oyz0/hRGNdZ/6vl9MyrOn2rTLqQyx4h9OHl89URqjdSysTsF6tpaMZJzKi
         TTG91uoZlxJQzko+c+4H+KYjLqZDuQ9TcsQp2Ouq3Nylg7g9LQRmO6WcJsfaW1R04v2h
         B0CMbB7pv0w8N1cld6m04Uxgvfvi47MwC4Zzn4IgSH9ah+TMmK8NhBvGPZiVrzR6sxMI
         O2tzim6+gv8yHLgQ4hSEaNtwgawLG1pgVy7w/8tcWVRsoYAdxdkVALd0MVj5uBavLlUW
         UOcOR3NF+dpXGIzrKs/8erDFZzyJQv11SEglRtl5GgNY2ynnG60gHm7gl02ricExBQ2d
         d1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534577; x=1796139377;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pztq+Cm1+ZAP57GA6CuWEqPVZxEOeq25+Hlck3k+Nv8=;
        b=bKSbzagdBi/y7rJNSuv/KJ1S2/I4sMkYAKmPsd9c2t4KG7s0EfCkDBRzUKYz0AbwjJ
         Z2RMWlfrr0ev+dDT6k0+FzOYyVHsOHW2YbmXLsRvEaeCU0SxvrtPunLLw14s6I+hY9f1
         3GFSZm6NrIQtatthRfd2Rpi8JWz8NsHLYbR77Ng9kt3iNMlhTlSE3AaM+VThTFnd6k6B
         IDAX9dI8MnzkI/j5Q71m7WrJR+eBIy7/P3IHzehphLQbU6rNqbhkgA+2bBq86kUdf4aw
         sGy1VwJEAsdsSuYWpZGV9WcRqs1o1AzkUHAKKjrjonFifVNIhjTvUK1811YlZZcUB6YD
         W4Xg==
X-Forwarded-Encrypted: i=1; AL+hErEwA+Qxb31m93Ljn6InADr1wtZ9sSKBwMBG4Jyvp2g6xuQ9yL7QAzd2VdL0e5weyXvfJi3gUg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9RZOQVf4WqYcnzjjd7uJyoI9T7WGuQmsdgzbqhGBl7/0AAnNl3
	4u7guE1T199WbqXV4mZi5f2A9MfSbGCYqUdRyMaOA9fUQxJDVZ0DG91fCRRUBi1g/lw=
X-Gm-Gg: AZFdTZfWgrLj3ZxtJRkiTZg6XjQXb50azDUMC8LD7f5IfeZjQ7vufWDq0mlAIyNMFK3
	DODIr6275cAD5q1BvLfAHgewexKVDK6741zVM1bYk8UlrLuHXrTCLYeiopSZ/XlXgAneu+4Pv4/
	z3hG9BlfkSBvj1pfpFvgtT2uZtsUdG6SALloPBKVPGIeA7gyFD844WplyKIxmbLOWXMVw/d7aS6
	3oNRH81jSrOVX+nd5lF0kyDuEGHKOXaXDdqngi9Hn78DVB1xAU9ij4vgSiHtC1/y8F6o1M/uE5s
	JNkmXEryMOeQyJyk7gCemfKz3/0U+L4c7MrlEYQi3A5X+rP+vVKCumpzAomeJfBNlWVybaXYkC7
	HsEiYVMjib0QYPX1qjRFT//20Wh8lD0C/qwp/MoHXmm2rYp6+euGns3bohtbnJQT8NbVi9F2TD2
	1ixpNZQUrgUxQIXyMoe5E2mw50ssIlrFa8UDScYF4tzyfe99c98Ri2YZgbABb+0/+MJijlxsRwa
	EGmE7xPKwTdlcEyegN3boL6SsXwZGGFnceg5i0cNlvoZXAHFhHWZS4tAHrzVX32glCtJFeLgD8z
	bCJK3A==
X-Received: by 2002:a05:620a:6892:b0:947:7691:7316 with SMTP id af79cd13be357-949bab3d3bemr2564224485a.81.1795534576594;
        Tue, 24 Nov 2026 07:36:16 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb4219c4sm1073980385a.41.2026.11.24.07.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:36:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVsZ5-00000000WyP-1TgI;
	Tue, 24 Nov 2026 11:36:15 -0400
Date: Tue, 24 Nov 2026 11:36:15 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Shukai Ni <shukai.ni@kuleuven.be>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Halil Pasic <pasic@linux.ibm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Carlos Bilbao <carlos.bilbao@kernel.org>,
	linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Subject: Re: [PATCH] swiotlb: clear read bounce buffers on confidential guests
Message-ID: <20261124153615.GA114530@ziepe.ca>
References: <CGME20261123205317eucas1p2f96032281e0f5e9f17acc7ec343acced@eucas1p2.samsung.com>
 <20261123205302.1034348-1-shukai.ni@kuleuven.be>
 <42415609-c784-45d4-a79d-ef3cc5e6c3ef@samsung.com>
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
In-Reply-To: <42415609-c784-45d4-a79d-ef3cc5e6c3ef@samsung.com>

On Tue, Nov 24, 2026 at 04:17:20PM +0100, Marek Szyprowski wrote:
> Hi!
> 
> CCed Jason and Aneesh.
> 
> On 23.11.2026 21:53, Shukai Ni wrote:
> > On confidential guests (AMD SEV, Intel TDX) all device DMA is bounced
> > through swiotlb, whose pool is shared with and readable by the untrusted
> > host. swiotlb_tbl_map_single() copies the destination buffer's current
> > contents into the bounce buffer at map time even for DMA_FROM_DEVICE. For
> > a reused read buffer that still holds private data, the host can read
> > that data from the bounce buffer before the device overwrites it.
> >
> > For DMA_FROM_DEVICE into a host-shared pool, zero the bounce buffer
> > instead. Zeroing rather than skipping the copy keeps a short read from
> > returning a previous transfer's data.
> >
> > Fixes: ddbd89deb7d3 ("swiotlb: fix info leak with DMA_FROM_DEVICE")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> > Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> > Signed-off-by: Shukai Ni <shukai.ni@kuleuven.be>
> 
> 
> I'm not sure if DMA-mapping or SWIOTLB is the right place for such fixups.
> 
> Drivers should be aware that doing DMA from unsecure device to the given
> secure page might reveal its content to the host or other parties and
> prepare for that (like zeroing that page).

I think given the semantics we have to support partial write we don't
have a choice but to continue them as it is the DMA API.

The driver would have to opt out of partial write support somehow to
trigger this, and in that case it is more of an optimization and
shouldn't be linked to CC.

I'm curious if there is a real issue here with a definitive issue on a
driver or it is just speculation?

Jason
