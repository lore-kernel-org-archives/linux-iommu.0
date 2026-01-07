Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3DE34EF04
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801671; cv=none; b=E0y7Qc0DlG8QWU66HVo2EkK2u6QU3VG+T/MlNkXGHRAeQp39hgSSQI6Ce8TDPv2XpLKhbOUIFLsTqBRS8IyHobNGLSz3WlynRBNi6d39YKWD2qQFXoJL7ZjCMdbNwX3UtDLHw19Rur6N7b12sF4irDhNkG2eOQiau2tdQakwTBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801671; c=relaxed/simple;
	bh=V4bVj2wSElYjvUgQlZ6az/4rqywQNYaAH3LZ9i/qB6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9QcJ0FwsDMEznb6IM+G4j0zRkwWI2Aw6DzSKSvJnn7opd7d3WGo81dNcu6BQfcE3HlJoOdQHhYMV5wGT/U001/TY9SrHE1KfQDQij8WlieSIbgMR9+pWVUeFYeTWVkNWUsoKSEkxRGwRmLrqelI2wxQLCFJGmK/Wj0feA6y48Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aZWTHzjh; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aZWTHzjh"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88a2e3bd3cdso10107366d6.0
        for <iommu@lists.linux.dev>; Wed, 07 Jan 2026 08:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767801653; x=1768406453; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ftSoJlbCa6MOGNHtdz3xW3rHVknPRmwRfQPP71m23p0=;
        b=aZWTHzjhZBU2W/zQyXGE0lm1Pc+/VUTf8qLO1ZZV6xjlsF+XD3QbOvzX8VGYK3UyGE
         f04IPfiOZA7YLpylFWtUt7YN6WxUvMoMMc2Xb5+MkHlNlTJy7BGSQTM55ChkRZXxI5BM
         Mb70OwGhEFCRD51Bd/60+qRAP7/glQWRv+5bYhOHKTBo/iu2rLTaulkZb1CGTVKyRyUw
         w1knMwGC5ANHpTzq63rAwdOYhp+SeK2lIKyh28d+ZcP3LqFbUXeh2ZtArHHFskEU0NoH
         rX7GAR7URtExpmL7eQlgdflxt7QMe7DaymGu0p4v0JiiDFl35LQ9aW7OPtrSpjVj5rwd
         4CIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767801653; x=1768406453;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftSoJlbCa6MOGNHtdz3xW3rHVknPRmwRfQPP71m23p0=;
        b=Ae0uIPNeIjjkNIO4Avh/z/X19b/KDPOxbTpvSgddW5KIvzNN6LjotnsWGbo88iawkZ
         aaMff6tU53g2gSSd9CVrhd7aF6wE81X5gBNdW+Eo+/tS//1M/Tevg8ivjkRn3/loKB3b
         ma0HwW+ZDi21Dj+oAv2IfJKZc6U/Pzw+277yrkn/1OMFYV5/Zo9iip2XYLucLadQ4coB
         ngR1WMHfBg4jdgwlEvZZM6fzrv0vHxAgNTn6SN+wCeDcxi6yKWuuu6JeXdx0swSVw83t
         VmqE8NxY4Rv/bNcKauEpgaAH01TkmwHk8XvRmKCLcSfFvA+FtphoMZo4km7kud4gkTYk
         tpbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuZHkhxikD2FgnXlvDFX6FEOp2Q8RZuuVnt/jTz535iSAvWb9xGtqOtbBb0s7KCQ2uBmkJ2w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzabr4AmpafBEZWePfiWEfphOaQ5KIeIdqEmWAUWovid7j/br2U
	81FBLglJAQfJTwsm+F7UGtSAZmtF3ZtvfGOaLOIYADRp58U/ywW0R7S2zCSZ9sSGNGQ=
X-Gm-Gg: AY/fxX7OlggUPr9D2CacIEioXPvEZJqmXFNDh98d3MMBHUrauI0JxiQxuTfyN05SVi4
	CVJp+RQPxtg1gZ4pOnwkqW3SlxpzA0TrXbn/UNHFvXMxXvUrQ7/xsxFq79hpbuSBxxfQmAezx0b
	79dcXt5sMF0ezl+C7jpAyd6BMIN/FUUUQDHT/UVtnyxO8JYgECRk3u1tLXFyrgeSDEzVhE/lyM9
	8zYTumBOpWXVSzxDq8Od9zkVu6OtFuJJJRADZ4Mdh4I32+WlxbSY4ZOU1IzjI3A/9tF9VYvUG4h
	PuGc5aU0n1OsuvUadPjJcjFn8Xu8S/f1u0OwbQ4xlET8j+RstMkRO+PY6YfnshbLPd7++DJ0u2X
	4pZo8olLE/8ZQXUk2XXVh4eMj0HuzZEl9gMGSTE7Qj1iF5xGkCJYDifk/yffyfvmeTBnU3LH8Dl
	Q4b4XdB+aZj8IErdZufD+Ne+OcPGNth/gjUvHBUhMckAXk9nvyFUk8Id0v2KjAv6ry2gHR3Kq54
	2dnaA==
X-Google-Smtp-Source: AGHT+IEsFTBclBHNaJgPLh58sVSxPObjQlXbE6JZhrOur9VbgMkz2k1BHIEIa/RCFDyuscOAoE/vIQ==
X-Received: by 2002:a05:6214:411:b0:888:4930:7989 with SMTP id 6a1803df08f44-89083d0d91bmr44153996d6.36.1767801649963;
        Wed, 07 Jan 2026 08:00:49 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8907725ffc7sm34937966d6.44.2026.01.07.08.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 08:00:49 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vdVxn-00000002CVI-0vE2;
	Wed, 07 Jan 2026 12:00:47 -0400
Date: Wed, 7 Jan 2026 12:00:47 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: types: reuse common =?utf-8?Q?phys=5Fv?=
 =?utf-8?Q?ec_type_instead_of_DMABUF_open=E2=80=91coded?= variant
Message-ID: <20260107160047.GB340082@ziepe.ca>
References: <20260107-convert-to-pvec-v1-1-6e3ab8079708@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260107-convert-to-pvec-v1-1-6e3ab8079708@nvidia.com>

On Wed, Jan 07, 2026 at 11:14:14AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> After commit fcf463b92a08 ("types: move phys_vec definition to common header"),
> we can use the shared phys_vec type instead of the DMABUF‑specific
> dma_buf_phys_vec, which duplicated the same structure and semantics.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Alex,
> 
> According to diffstat, VFIO is the subsystem with the largest set of changes,
> so it would be great if you could take it through your tree.
> 
> The series is based on the for-7.0/blk-pvec shared branch from Jens:
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/log/?h=for-7.0/blk-pvec

Great!

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
