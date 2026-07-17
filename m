Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFA7315D40
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784304441; cv=none; b=UCSxuD5lfeTAkRPjQvedG+BQ9/3pK7nqpcNo/3/OKAW21IJm/zCLBYvdLAfzgxomYkwtPWepf+Wm6sxQZZAOFEMFpPFVxhL7fY9yDfpM2VPWU7phVyVdrSk8DY6JviZqCO18DMa/qh9r2Aaiy7aYwK8cqdwxX6RXMIb5o1/AGpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784304441; c=relaxed/simple;
	bh=iVyrSwrZmNx4bprcJ7yvv2W/LjWegRQAvxGt7YUy2mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtdAhWJezAiTyNecyYM+4+oA5gmNSXDPys+NJaYClV4tuhNQjm/KaOR+voxY6mOsp5Itucm1BV3PJqE4NwFVMta3KtaYm7/w0sIxIDY7nZlB9Pt4dfOXnofSYZxYmAmh74Gwx5TgEOHSq77p5nnmbmzmvsLnZ54IN5Iwee99V4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PVglpI6y; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PVglpI6y"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c0cea8883so19574881cf.1
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 09:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784304439; x=1784909239; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iVyrSwrZmNx4bprcJ7yvv2W/LjWegRQAvxGt7YUy2mg=;
        b=PVglpI6yiChV2alwRp3ErX1BpiZbP/8QBkBderHcls/e4tJy7TUv46ML3xoI8myZ69
         6y2WpURhUl0TkkGdVB0d/9mVGYkkFBN2aLAiMPAoxcNccgBn02/C66tdyAb29HhOTVTM
         S5e6p/p/224RNNXDVu6vPBbh47Yi8lLWjforRuIbaQEb3alxXLvMaZoYNJYSdXqsf2x4
         R0//Uzh+qexhRWP90BBQpV4AbBtLZTgRKfmi1Xm0VLd8PHTJduaPSU6xZD+Xl67bR1C4
         FEzj7WSaPnP+5xCXG590f67KolT9nFvymUR7n6rAc2JcgP0fXrj43nFU7gPvmVY4PoxW
         HTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784304439; x=1784909239;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iVyrSwrZmNx4bprcJ7yvv2W/LjWegRQAvxGt7YUy2mg=;
        b=FM3XArBjDwHSRKHeuF2zQYrOyft5zga5kvYs2kQRRvuHZeOZQ3naMCnh326uY6xnMD
         YNNmUY3cQ0z3ecAmoLpJuE4Uy8CAD5Hq7JketFxBROOpAWi7WXPStWGcPeILQDMy+2Cr
         G9HfyxlHQB0NFZ5PLTjXxuWctrJcvJp7DYfPhUjzz7yORQKEfmmBtKQAt+wNG4YOVFvP
         FitBZJTieB0f9NhvT0gUcW/YtVR9O88Wjbc5+bTqafauFs7Grw/p4zU+o5wrZr1MMpCN
         jlLJi7IxAg2RVaLh5rgkpkWtOXm7fExRhDjHxyvcr6bh0Hd/z1856A3dw93Ztl4xKEbr
         snzQ==
X-Forwarded-Encrypted: i=1; AHgh+RpRcejqXKSnzB17aPAA2Rbv/GAuRax5419ZPKas3YiFBBuDZq2BKJX/25YXNVhzHAVZwp9Hzw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTjy0XIc8BfhdyCAStziA3F1+iBokypdGcoYHx24xW6dHU1Jgl
	ka3/VqZgmAoEa++QzcwRfd0YB5ENYsVX5adNiwHYyD2EnZ9AUoTAyY10aw+9aoq4hjY=
X-Gm-Gg: AfdE7cmPJbzL2Q7XfG8nTLSm3TQikfxxmHcidwUQb27KTP61Rq3hNdgZfpjc9x3nTze
	a9wy5RiqxU5WQgxcy0INRtG19j1P+EVCEJ3wNtcbcsKzi1BsxJWxiQ2nHoE8k9c43C4uTQV/gKC
	0m8aEpH3aIH6SnT/thirCApqNWLaaSJTOUHPEMvCPkqwJ4wfXA0S4XMeMAtLo9WrBLewMSBtp1Q
	FZh7qjgwyzJd+vJBLoUYsUnu2nAk+a/Ro+Kh92wwcqJ1BU7OrKAElVwNFiBGAm7QsJ2JVBr3Uw+
	p/VZNKmHUnf+edu5QrXpyAUZJa0tWZGH2IvBThq2RklxaUcZbBSzYdDwboW+u54Ls7ll9OVoEGo
	2OtbVcP0GzexLcK1a1DXxZr+KkfbIDUIEALhoI6d3mbt01ez3KA==
X-Received: by 2002:a05:622a:1b12:b0:51c:558:cbbd with SMTP id d75a77b69052e-51fc214bd5emr69273551cf.41.1784304438760;
        Fri, 17 Jul 2026 09:07:18 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9077871d06csm20242736d6.43.2026.07.17.09.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:07:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wkl5o-00000004hEV-4513;
	Fri, 17 Jul 2026 13:07:16 -0300
Date: Fri, 17 Jul 2026 13:07:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Konrad Dybcio <konradybcio@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	will@kernel.org, m.szyprowski@samsung.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, dikshita.agarwal@oss.qualcomm.com,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Robin Clark <robclark@qti.qualcomm.com>,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: Re: [PATCH] dma-iommu: Introduce API to reserve IOVA regions for
 dynamically created devices
Message-ID: <20260717160716.GA701389@ziepe.ca>
References: <cfd23f75-8952-4463-abd5-815b995031b0@arm.com>
 <bb59f07e-ca7e-f012-6a4b-0a148350b69c@oss.qualcomm.com>
 <20260612172649.GM1066031@ziepe.ca>
 <da77c21d-25b3-46c3-a48f-71f0549e9f5f@oss.qualcomm.com>
 <20260615125257.GS1066031@ziepe.ca>
 <dcc0d02e-91fb-ddbe-399a-0191bab94c4f@oss.qualcomm.com>
 <20260617194038.GC231643@ziepe.ca>
 <e9e76c9f-b3b1-4ffd-9547-183556f6bb60@kernel.org>
 <20260618151745.GD231643@ziepe.ca>
 <dba037fa-0f21-4a50-8727-076a3b177c47@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dba037fa-0f21-4a50-8727-076a3b177c47@gmail.com>

On Fri, Jul 17, 2026 at 12:44:54PM +0200, Konrad Dybcio wrote:

> I was kinda hoping there would be more buy-in to follow what PCIe
> does, but to my understanding you're opposed to it because "vpu_bus"
> is not dynamically discoverable.

PCIe allows describing devices in DT. What this weird vpu_bus thing
seems to be about is to actively avoid describing the devices in DT
while simultaenously treating them like devices. I think it makes no
sense..

IMHO the approach inverts the thing, you start the main driver then
use vpu_bus to dynamically create a bunch of struct device DMA handles
for the main driver to use.

I think it is much better if you start the main driver, use the new
component stuff:

https://docs.kernel.org/driver-api/component.html

To aggregate a driver from the struct device DMA handles that DT will
create automatically. ie the reversed flow, the struct devices
pre-exist created by DT instead of being created by code in your
driver.

Jason
