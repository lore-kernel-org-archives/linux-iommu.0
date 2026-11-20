Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201965;
	b=OPW3khFBSgDX7C/17pQruImpHY2U6R9cxGqVgrIXW2+A5gkM3NVxJmBIvMXwIxJ3vFPV
	 QSbYO6qD5ymAx6E8N9KTEckMtUhu5j15I47xxKVA7PheyFxdX1DVPhJe1laSXQ3TKPc9r
	 fxuqVm+OubVD7q1aRHNbM5fPTv9o3WZRXxm4/YZy9nyfhPtjKtkCnrX3NLYje0KwYUOWY
	 AebHqp87QFTG0c2z00g7QqcObqf8ztIVmTnxjPh5e+6vjFY9lRXmyAERXomqzYNw1GNLR
	 PS2nBiVA6erwgSGbv0970duffgcLFEu3yIxbnUqjPWySToBC3VfS85xXKHc4DMEAUfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=H9RQqwSYuKH6BmFXT3u1NJ8tFtpyybE8Xg+Th6P/DFk=;
	b=hWLlWsVEJIPAFeQ0g6VJw9phmbg0u6sK6xDmKIlGY/Nkpo/tLCowc56rhFGipOlVbh/d
	 FwLy2BNnyBjvbl/eLQi6SoSFBEtYo+ng/SYSFt2qFTzHxGYYw0aq9jRjIRI4fFnK8Jy3F
	 vyK4N2KpVFTgjYj+2ClSxxFtGmMG4LBlfbwHOb5lKY2/oqjV+rOhZLC/+iHHinObsh+yy
	 BOVZ2semvqVXxXscx5KTpbs3Iz/Ml4UlobmX2uWYz62AAyewpVTsam19O75/gxkqcWmAy
	 aIZD1s7fAM90J2dHBtrlZILRGY+6E4CRkWcjAEaFYrGAXxGsucN5jBit1ZfT3JkkCtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="Dyt6h1u/";
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35A60A262F
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 19:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B35A60A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Dyt6h1u/
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-55d03bfd477so14609841cf.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 11:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795201963; x=1795806763; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H9RQqwSYuKH6BmFXT3u1NJ8tFtpyybE8Xg+Th6P/DFk=;
        b=Dyt6h1u/WJFTvKCVhM7S++/ejrdByFKNPV6t7lpqc+QEd2Pdi3mAZljwVpxR2kn9Jk
         DnLQ8xXC0rIZTu8vX94KUHOE9DN9uYozyeR3SzdZdsURea8T/b8oRZ1dhPRx1ciaXTuH
         z0XfizHHpayU736owJJyIoTMDkx43q2zMU82LbxCO0SC4iCdrQGI86orlBOurf+Ka5NN
         TG9Sa2zHDHcyS3Mw58c39z4j1PpT/MQkBzg1eM383HSVHPbbd/x6vzgXA5aEMHyTroh0
         P+8nzMbYrqcIGZHot3tozn4HhZjKnlDz5v374hxvjISlWwVunmn1KsCDiHUkK74pM7E8
         1zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201963; x=1795806763;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H9RQqwSYuKH6BmFXT3u1NJ8tFtpyybE8Xg+Th6P/DFk=;
        b=m4pZoZY7OVeDlSFgzzbTz75BykvzmSVY9FDYIO7ZyQcixrqsCRuMeGEAGvk6ZUBk1L
         R2lbqnq5qVBXi9uB7UgSAJ7LGrPniYr/w8P5n1aCq3hytxOWNMsbuA8PFU5hFFEIGAOT
         n2ok48Y8zKX55BFcb9DLSsJAF9nrhyIRKHDl49fEWC2JT0umZPHSyNrB0l3tBxU2Lvoj
         pQFcOCqlq4eZ66UZl7HGVO334LnIBukAZpEqXIJPogSxihBVcMR5TQarVfyYwGkowtgP
         87oTKpU6mR4tICoqwI4FAkPtEj11+0P1brCe8HnYrJqN6gV8S3bTB9NDgZqHrF+CNaiB
         2EeA==
X-Forwarded-Encrypted: i=1; AL+hErGJhz226sy4f9kcwtNY2k/NHA/slqcGm401Hyms6bvR/SHRVtgdNpGiylV+hLBrIFNUGEmtEw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+wAviPFZLKkKoGmQmxVp1kWc2t6qZleWTWVCL7rv6UocSj70IA
	iJAtmZQTcLOJ28UIWX02ZgWrPgfjeoXtxhhM+maGymPeic5UOWpVYTH4rlGhDXVrQAk=
X-Gm-Gg: AYBFou0DWCFAIiL97SuSgPcHj2QVt3j6QsG+c2Lo+U7m/stivleBRLLtx+qH63pwnk0
	sbJsu9cRKyDHOTdjHrtGb0ILTovQ8RuKe8NKn8SBWfXuvkojrOm/ENAliq5HXm+NEfyxDX6nU1h
	KjuKAN7eZ6/JkYz4z7rcNAY6N3+2N++JWbm96soimdU9ttLZQztvcgdsWXRAHJKW/4ewgu+C9Pm
	zRMFSBmHkh3EahyriRNm9YA9YpaTLOkC3tvV0luMxaNTLn3Z9Ty5uzUIYZE/b0wUQ8SJvViXEo0
	UEdOVOQChQ/J+PBs7lqi53k434bkLC4Yg0owCN5OfvjdT7Owwn88FZTab99mH8laByF+tMSGr+S
	WZEgt+xjNpUH/Ed1KT2FtQ9kEt8LhE9BI04VIp2u8s3OwdD2blNy4j+2N0Yt7bfyQ5emUoyqfQA
	Y94JUjoSlVFxCROHg9DcvgPZYz76u1u4/jFSPj5rr+ljxDZwM0VoV5dbjuc327kok+vcRLq3DYu
	BocexEWiog+ELjIRbRl1uQPFxTcQ2AwvupdOElQJabl/acUN3rnT/XpzcQ+9ZWdd/mbVflJXLuk
	UdakUiyFYeD0mXtA1basDABUBJM=
X-Received: by 2002:a05:622a:598d:b0:55d:3540:5da1 with SMTP id d75a77b69052e-55d76a2799fmr67233091cf.19.1795201963342;
        Fri, 20 Nov 2026 11:12:43 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d788548a2sm29714901cf.19.2026.11.20.11.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:12:42 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xUU2L-00000004oEv-3NN7;
	Fri, 20 Nov 2026 15:12:41 -0400
Date: Fri, 20 Nov 2026 15:12:41 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Graf (AWS), Alexander" <graf@amazon.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>
Subject: Re: [PATCH v2] dma-contiguous: support percentage sizes in
 cma_pernuma= and numa_cma=
Message-ID: <20261120191241.GD1133597@ziepe.ca>
References: <CGME20261114145340eucas1p2f7699b88eae34f7904cf68109dc3eb4f@eucas1p2.samsung.com>
 <20261114145328.1307-1-graf@amazon.com>
 <fa38a878-1735-4682-b208-5de1616f7e4f@samsung.com>
 <28a0f946-af4e-497f-a923-f11b79d94930@amazon.com>
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
In-Reply-To: <28a0f946-af4e-497f-a923-f11b79d94930@amazon.com>

On Thu, Nov 19, 2026 at 12:27:08PM +0000, Graf (AWS), Alexander wrote:

> Ideally all of this would be policy that only takes effect later at 
> boot, so that we don't require pre-boot logic or a reboot. For this to 
> work, we would need to have Linux restrict its memory allocations to a 
> small'ish region instead of spreading them, maybe to the KHO scratch 
> region, or maybe by favoring allocations in phys addr order. At least 
> until the boot is at a point where you could perform the allocation. And 
> then we would also have large physically contiguous blocks available to 
> allocate from and potentially change the tag to CMA.

That actually seems like a sort of reasonable idea...

What about the reverse, you boot with a huge CMA and then shrink it in
the initrd to what you really want? For this you'd just want some
command line indicating how much non-CMA memory to have, which should
be fairly predictable to get into the initrd?

Jason
