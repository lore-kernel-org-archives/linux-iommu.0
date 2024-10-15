Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A359B1D5144
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006274; cv=none; b=s0Zjcf3cSwkbu8K1BXpj8Nm7Ba/Y4El6lKQ87ek78XECppTo7F7QTG2CD8/01U6lbXSRK1q5smZ8DYlYpayv9yeX45+70J0WRewksLi0RIsQBbeVW+AhFyT+W2wRDkeIRGstT7We11Qbq3vzrPBUBkJcdc7INJemgFVdr0rY4ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006274; c=relaxed/simple;
	bh=V85TGvEVC+FtHONfjTskrRdVP4b9YXQixG7tpBktoH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BC7jgAq2TJjg7qwMFwIQYJpt0h90cS2TDzdd5DN9orOPSlvPVRxgo2gVnQAB++pAvQ+oBwfNH08KBWsA+AoUIvDNn3pYayih8+gGwxv3m76JQk74jK10N1KsGDu3yxBwAGPJPx6SYJ5thO5M6JKmCtxEKfDprjyWIk2LVVXCYRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=an9Ym6Vl; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="an9Ym6Vl"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7afcf0625a9so613999185a.0
        for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 08:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729006271; x=1729611071; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=slL8cxpXW1IGCJQjRxbQDziozSi1qIFH5vLZ04P2rWM=;
        b=an9Ym6Vlzgp8qr3UR5526dWqRVeSROWU4rYxX0jVqFZpsI0PQ/mdcrjRDsYywtIn0f
         OsjbUBAvm4L0Ldq1R9nl+vJXADD9YDtUa0te7QyUdpmIJ1Wj2Fces8aVJrSWNB+daKS2
         NbWxzKZa1opQrKMXBPqmNEQiOIWOoGe6FIbVxdx/SAyKW6ouDH2rkgF69xj+bFBXVS9G
         5AuqMLx8hD3KyLM2DZeCk/VHyJXJXfOal0zYhYLYa1t/tt7FdtzE/y6M95Y/lWHPYNDc
         TCAmQbOJFhL2p/jzf6nh70xjq0NwRDo/Pa3z5rk2GcFDdCCux+N/WutkH0vJuXrSdgvW
         VjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729006271; x=1729611071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slL8cxpXW1IGCJQjRxbQDziozSi1qIFH5vLZ04P2rWM=;
        b=LFsnSxXWO27M81l9oJJBjjt4F08Kg7KDXZMUWRcCa7OK0RAC/kidugd7c4VDllLZGI
         mS9uhMt44RvpBh2HPJ7aDbx0ctmDnvrhFPwPwEzqQDYuBaSoV4zx/vTRNEAmPTk2io6+
         p6VpIodM3CO2el9H5Q1C3jvCiWrOG1xJEWXf1L/y8esHGOnMBpcROfjBalBzGNZByBYz
         z6luJIvLZ91HbPIH+IKXzl8qY78RhOcxCFuLviN6I13Z8CD5rgENqhh1w2CYbiFpw3Mx
         kCb30VRdC3lS0KZEp8yheci3PGOqucz75XD634pwbpYOBFZrZzbIz3taoz03M2uXaqxb
         SA0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLgHe7iiDECKFPoaqQjGFWLbmCb2CKBcnOs/GesrRRmHpD21H6C746cGKzdU4cQGM37pceQw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHi+h9WixdcUy2JTaIQbsKvAzguhOdpGfhA2ScauDCoiyWqy6l
	zc8v+2lQbkw/9xhxwAPxjj4i52t3y3yWh7Um/+9/3n5uUiE/YghOK9k3Hm6bIUg=
X-Google-Smtp-Source: AGHT+IG16JaAevZ5Im3ptzAIoVttBffmFnOmdL7EWY1zQQkpST2IawyAAtu4U5wULGGOSjITPeN6Gg==
X-Received: by 2002:a05:620a:28cc:b0:7b1:11f4:d0af with SMTP id af79cd13be357-7b120fc3e21mr1742610385a.29.1729006271574;
        Tue, 15 Oct 2024 08:31:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1363b5484sm81218685a.119.2024.10.15.08.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 08:31:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t0jVu-00DjTK-Ka;
	Tue, 15 Oct 2024 12:31:10 -0300
Date: Tue, 15 Oct 2024 12:31:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Pranjal Shrivastava <praan@google.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC 2/2] iommu/arm-smmu-v3: Bypass SID0 for NXP i.MX95
Message-ID: <20241015153110.GM1825128@ziepe.ca>
References: <20241015-smmuv3-v1-0-e4b9ed1b5501@nxp.com>
 <20241015-smmuv3-v1-2-e4b9ed1b5501@nxp.com>
 <Zw4kKDFOcXEC78mb@google.com>
 <20241015124723.GI1825128@ziepe.ca>
 <ab21d602-5349-47be-b346-2fbc041fa13e@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab21d602-5349-47be-b346-2fbc041fa13e@arm.com>

On Tue, Oct 15, 2024 at 04:13:13PM +0100, Robin Murphy wrote:
> On 2024-10-15 1:47 pm, Jason Gunthorpe wrote:
> > On Tue, Oct 15, 2024 at 08:13:28AM +0000, Pranjal Shrivastava wrote:
> > 
> > > Umm.. this was specific for rmr not a generic thing. I'd suggest to
> > > avoid meddling with the STEs directly for acheiving bypass. Playing
> > > with the iommu domain type could be neater. Perhaps, modify the
> > > ops->def_domain_type to return an appropriate domain?
> > 
> > Yeah, that is the expected way, to force the def_domain_type to
> > IDENTITY and refuse to attach a PAGING/BLOCKED domain.
> 
> There is no domain, this is bypassing an arbitrary StreamID not associated
> with any device.

If the stream ID is going to flow traffic shouldn't it have a DT node
for it? Something must be driving the DMA on this SID, and the kernel
does need to know what that is in some way, even for basic security
things like making sure VFIO doesn't get a hold of it :\

Jason
