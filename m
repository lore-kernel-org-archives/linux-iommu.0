Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110C13043B2
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776773408; cv=none; b=C5PpX+ZfXb4R3oKCXMnUYDsat9PY6rZDbQgrrk6tvdNci1MlF97mTk6Si8aY/kmmS1w/Z8xX8JrIdSR784zswdbEyCY0WHHJ26GfOVxZS+bJ4L2gxOPZjRUamEobyQ7wo8K1R11O8LwzSGBV6I6tWfLsuKXYQDbLhXVBJKhnalY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776773408; c=relaxed/simple;
	bh=XbKdlZH8Wn5Q2Gv7aa3pDFxSc1M2qfNLzzDFE8v4jqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSbH85dYQBqt/0usGiFeJxFq4gqBAtrs9UR8WVnksrdmHs4kxssWnNj07aaoCODjnNy4yq2Th80T5CBcWNOWsUPFAM+SRtPLRfW+FeZ2fyi40a3HPInFtjkyYR3Z2I6B7giXwzfi1S/NixMQyZbG/bbtfuamAUeGb0WocVWotXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=B+/hXyHX; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="B+/hXyHX"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c7212836bso10854247c88.0
        for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 05:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776773406; x=1777378206; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HpS1oVTR3rIZCafWVa+4FbkfcJKXjhWy8xb1rynP1OU=;
        b=B+/hXyHXQp8vZOPS0rYY6aqtQSIBbOMd6VSg8jJfrlaH17g5dpTj68I+szROq3+zDq
         S7M4/HOXiH0YyZ6E0v1D8gdrglQGqlL40lLO3Uf7THgPgBHPssUMXrK02hpOnxjb3SDu
         usQlh4MD/jFDjLyTs15ApLydQMoagBEfAV/gGfTdcjtseX8E4EMhD6aO6qnCxj0c1qdK
         So8o7/8siO6sZOg45D/MuwyOSvqZu+NrMDZHE531SqHpqR2v3X51VMVF1lvPDL+xYOH3
         0Lr8AKIwmsNGKe12H14s50lASnQp1YrAcQMXmUHXwlJ+TTiGvXcfIzfvDMPaoZTi8Y8b
         y/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776773406; x=1777378206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpS1oVTR3rIZCafWVa+4FbkfcJKXjhWy8xb1rynP1OU=;
        b=FaExpS57vDMPiake0AwDubxgHnMKtxwM6VQMKQJ2nmIVmN9YEVfhfDkGzsDbSj+Xnt
         kkzUEV0+z9R6HlgtADr6aAlDhlSibTItYWtjkXhhL5ur5i6eEldciIee4IBFfDBrIuI4
         TF+snxIPsZCaXjCi7bj7os9Q8q4Bn9BvWUbfECCn/X4v0IhyC+vzi66ryF04Sm1D1uzd
         wgOulV0/yQkXHIF1BQNwKb0oD1LMIExwqZ5SDKvODaps+kKw48ECspk9d8fi8qcXTtg8
         2uY2CK6EWHAy9m5I2IFe66OvALCBVCweCDqumlB/uCUur24woCUh01y2230q3f1mS+Tt
         D3vw==
X-Forwarded-Encrypted: i=1; AFNElJ+3hsjI/HRdNGKnTmcg2hfe48CctLASMIST5rS1XYKnVa24s+hDOk3xA5kePdC/6qyBcQl8ug==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHrUCsyU5rrLSYvaXJar/Npk4JQeJ9nXxVBoPQLMbei+pQ5oCs
	zYXtq20zoYykiwtZ9jrUS/uK6IZcJdXQrfAdcByZaVTkHUSz8jjs2JHQKIEcKIPmfoA=
X-Gm-Gg: AeBDietlBkdQLCpveCj5mT1vHyaKyxat4WlCnKbOssPBVjRTkKVahgBZTNW084xIpeO
	PJ/NNNd/6FtFT5v9IapO8VwNvU6E1JGvJDLLH8Crk+UeuoyB0mm7d9tTyaG2PWOoRurZ9qNWBPr
	P5B9lamelZtdNsZDMP2N3MqYxbQ5Mdxtn/H4oQ8iz5UL1ZjT9dQXcH63/1z11blPjZbUQw2/2Zc
	qD+LIjAz7zOZ/i6xcYCFDzTpvAynYQ/BAoTnzS6msg9Al92/OUtn2FBr7vRYai7UcniNuh1jJqG
	ZQEEKmpeMMeNUrptP2pfw14aSCRhi+OOPXYsc7UQuMfJcsVLCdRLdZTESIZUUBvaAbpoyyAET+T
	llSXQRTyW5QgCnv6ALIbwrdqxIudfWPi3ZSxuRAJ2MvIv9F+xlKLW+p528EDeu3agCztFwc1eGj
	2aCGuSmjrkikR5RlWt9OY=
X-Received: by 2002:a05:7022:ff45:b0:128:ca6f:adf2 with SMTP id a92af1059eb24-12c73fae276mr12134183c88.32.1776773406031;
        Tue, 21 Apr 2026 05:10:06 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a2ac32sm19260013c88.15.2026.04.21.05.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:10:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wF9vY-00000001ErI-0ePf;
	Tue, 21 Apr 2026 09:10:04 -0300
Date: Tue, 21 Apr 2026 09:10:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	iommu@lists.linux.dev, linux-media@vger.kernel.org,
	sumit.semwal@linaro.org, benjamin.gaignard@collabora.com,
	Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com,
	christian.koenig@amd.com, m.szyprowski@samsung.com,
	robin.murphy@arm.com, leon@kernel.org, sean.anderson@linux.dev,
	ptesarik@suse.com, catalin.marinas@arm.com, suzuki.poulose@arm.com,
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v5 1/2] dma-mapping: introduce DMA_ATTR_CC_SHARED for
 shared memory
Message-ID: <20260421121004.GA3611611@ziepe.ca>
References: <20260325192352.437608-1-jiri@resnulli.us>
 <20260325192352.437608-2-jiri@resnulli.us>
 <yq5atst6ywbl.fsf@kernel.org>
 <4qdizkkoeke3cvkcf35upa7p7ick6s654eqlrizmi7ozkw5eze@tnpk2e34xgwl>
 <yq5awly0d504.fsf@kernel.org>
 <tteiecxfqy4k24wnzvp6ocxnuopyhmqtne2xwh5htwldlbzjnp@o6cbzdlurxld>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tteiecxfqy4k24wnzvp6ocxnuopyhmqtne2xwh5htwldlbzjnp@o6cbzdlurxld>

On Tue, Apr 21, 2026 at 01:53:31PM +0200, Jiri Pirko wrote:
> >> You reach there when is_swiotlb_force_bounce(dev) is true and
> >> DMA_ATTR_CC_SHARED is set. What am I missing?
> >>
> >
> >So a swiotlb_force_bounce will not use swiotlb bouncing if
> >DMA_ATTR_CC_SHARED is set ? 
> 
> Correct. Bouncing does not make sense in this case, as shared memory is
> already being mapped.

It is a little bit mangled, there are many reasons force_swiotlb can
be set, but we loose them as it flows through - swiotlb_init()
just has a simple SWIOTLB_FORCE

Ideally DMA_ATTR_CC_SHARED would skip swiotlb only if it is being
selected for CC reasons. For instance if you have the swiotlb force
command line parameter I would still expect it bounce shared memory.

Arguably I think this arch flow is misdesigned, the
is_swiotlb_force_bounce() should not be used for CC. dma_capable() is
the correct API to check if the device can DMA to the presented
address, and it will trigger swiotlb_map() just the same without
creating this gap.

Jason
