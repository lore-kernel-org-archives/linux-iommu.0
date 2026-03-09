Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC603D3D1F
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069239; cv=none; b=D17EmL03L5l+skfDTWJ7kecaePpLyQeKkFv/b2x4Sg7sgliZvEwQt3XCkpcB2LTBYV7tLq56x9w0nZKwX9AXTz+3/XBAEEHHznuPpUvU27unafz8blK66DrjeKY5uEeB/ymqLso9ZEawh1jrsh/8mxjAIGvwdDsNca314W5mv6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069239; c=relaxed/simple;
	bh=EmTN4lfqvNBf2NGWRvyoj3Pdz7Zrbn88TVlk/KgiBfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNqzg4+IeNWWj4ikMfZhkR17MQOnptmQ5wt3DTB4pZr4qW9xJ8ddpfpsSeZlEMfjUGNi331AaZsEbOn5g4jvn8yrzkp0YFRF1+gTNNIhqivTw4QCizltaFw646DMrdZZUtE0aJC/xeT4PbFTgzv01t8/kDM+YDh8yvoMj6A31DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Z1C/wI4H; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z1C/wI4H"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-899a5db525cso108995696d6.3
        for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 08:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773069237; x=1773674037; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EmTN4lfqvNBf2NGWRvyoj3Pdz7Zrbn88TVlk/KgiBfY=;
        b=Z1C/wI4Hotcfwcf7X46ZNmNiOXdT7cqaq/6NC3R4V12s5S4HI887hHZr27MRHEBjAM
         a6qouQV+Ux7HA/U47CRfLVGmWv2uio6/Qx6HW4px+uEIKrmNDFAmuIemRKHnzkDNTxST
         6ICupqZVMyvR13c3cSrVBE0rqf8Hm66eT6Fz3HqINrxB15umd+i+WNgklSxkD3rtlDpc
         aCCk9RkNwtYHMjJaWgQOFiVoSI9Ri1tYS5yV6bi9+zcao0pNf/CcYFTFQo0TKmvQZraJ
         SvsMPp/q8sN9tFUPNnWG5oZkqJAjC5XGguxQVsyicnf4oGIigpFBVMCaMeGPT8/1e5DF
         vqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773069237; x=1773674037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmTN4lfqvNBf2NGWRvyoj3Pdz7Zrbn88TVlk/KgiBfY=;
        b=h7NUuw7IT/pawY+VME8ZUNM6D+tCtOmpmVqL8F47NuAozgGslErPxsFYdiqVng2sTg
         cqA8ZzR6sNQbE+VzJivrel1NdJVlhkTpx+/QWKVLIzG+xE5ovZukhYlWDd9IGKPrn4oo
         wOkEeG5L52OrwZE5c2rt5Rk38Y7DhNWMtVWt7EV4ZxqWlv2L/m6T3A/dDpPmBBlhsjfv
         ic+nr2V4Tnu91nMDhGO9zUD0JKCtnF7P7UMxro3Zq2R+o6Jeg4nlxj2ECJK+VNOknvbK
         MnEcVc1z7AJGaUu5z7Ep81FLk7DCMdyrV4kT4Z3voEhR17ccGqVIDcnkbqgQPk9Imxp4
         yXWw==
X-Forwarded-Encrypted: i=1; AJvYcCVFodnkg8zL9S53TWhBIL7eQS8uDak4jfB5O3fb6hgMMkx5BkuOSbzGMuKRkKN+rDSBhpBKSw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzy98H4ie1xCDxNXxEL4tv95d9BGESvAfrOnX+p4+LQ8dn7Kkgv
	LaGlp6hP+4t2DfNNNcOQQkNXGRD8AzhlUC/L97JYu9DdW61YhHQmw/eipUa/cAxrNWc=
X-Gm-Gg: ATEYQzzxPrJoV8xdBTa17cbQTEE3bW0sd3KRdinOXv0azuHG46n1pPLz2Bo3dGC7MuQ
	7wmsskoh9MustRnQPP4RzijO4hTUidsHH8bci0tn+ofxv+eDfglIVpiyzKm28dIm25ZllGMNQcF
	B5LwO61wuGuSmsTGzo6EbntIeywFob2mC+uFijZb/P6xkIBVUYeBUTiOVfwqij99tK+r0Ai4UQs
	el9o0JZkK7F+ZCC+COPInXnXReo8/Y+dC+vS8kIZzffGR9eHGmHPlo9P25OMGTNGSIVWEcpzYkO
	eUHap5tTmoWvZx9aHAhPxfjVryFGJpacWgMsM+D3LXv05sO3bE5VkeaIp3pax2dtu08XPZiYm6V
	lTEDa8ER47W7XWF2D245RwJlADJehapv6/L2u+KwxOdyDD2auxG8VcU5uiid+b9CvfBdvQTlpb3
	KkYXXrf/D/TREPaNHRXeVhNg+TekALw8tBmZVpu88eXSG0ZstBt+NOg+A9Rm9R7WcAGwv9cBQhe
	jaD8o8Y
X-Received: by 2002:a05:6214:224d:b0:89a:909:260 with SMTP id 6a1803df08f44-89a30acc08amr165840456d6.48.1773069237301;
        Mon, 09 Mar 2026 08:13:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316d8936sm85242106d6.28.2026.03.09.08.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:13:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vzcIu-0000000GhN4-0sDe;
	Mon, 09 Mar 2026 12:13:56 -0300
Date: Mon, 9 Mar 2026 12:13:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/3] dma-mapping: Clarify valid conditions for CPU cache
 line overlap
Message-ID: <20260309151356.GN1687929@ziepe.ca>
References: <20260307-dma-debug-overlap-v1-0-c034c38872af@nvidia.com>
 <20260307-dma-debug-overlap-v1-2-c034c38872af@nvidia.com>
 <20260308181920.GH1687929@ziepe.ca>
 <20260308184902.GR12611@unreal>
 <20260308230916.GI1687929@ziepe.ca>
 <CGME20260309090352eucas1p283a75c78cac495b5ad87df74c79aab07@eucas1p2.samsung.com>
 <20260309090342.GS12611@unreal>
 <c1d058f3-f864-4ed7-9f7a-683d6f4bf1ce@samsung.com>
 <20260309150502.GX12611@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309150502.GX12611@unreal>

On Mon, Mar 09, 2026 at 05:05:02PM +0200, Leon Romanovsky wrote:

> Regarding failure on unsupported systems, I have tried more than once to
> make the RDMA fail when the device is known to take the SWIOTLB path
> in RDMA and cannot operate correctly, but each attempt was met with a
> cold reception:
> https://lore.kernel.org/all/d18c454636bf3cfdba9b66b7cc794d713eadc4a5.1719909395.git.leon@kernel.org/

I think alot of that is the APIs used there. It is hard to determine
if SWIOTLB is possible or coherent is possible, I've also hit these
things in VFIO and gave up.

However, DMA_ATTR_REQUIRE_COHERENCE can be done properly and not leak
alot of dangerous APIs to drivers (beyond itself).

It is also more important now with CC systems, I think.

Jason
