Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61D347ECD2
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583168; cv=none; b=Q8pLOkYRezunRSpRL3TCayw6fviVy0Zw9lcKcxYgA2KnMO6ZS7wvlxdCTuqcS5l7es3nNdLnDlLcI9nEa2BNCLdfrIiTrwtMtqql6O3sML2SF8BaqkHOV7rkmfhXScaoady4POPhBatyOP9syL00GYYKd1Z0OSTXUk5+kH66Tew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583168; c=relaxed/simple;
	bh=RpbeXNzXxaadmZyS/Fy/cu0dWgb+zuhOaJLik03FN/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHRwYv/3HBeeasABmGk1yKAM5ptab4OPM3dn0qtk9hExCajMiBOTY8SFpaYzQuRzKAzcUK80d8yujIXx0EKWD43yrZdCOHKJPmyO0Hq9MtXgivgWRHjTs8sgqMcVCIUApMRFfvk2RDi+Bus2H7H/7uIjJhKaoiQ5kn6tWPJ31+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oN+jtV3d; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oN+jtV3d"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5174a3d9598so7008641cf.3
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 07:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780583166; x=1781187966; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=clkIHT02uZl46rCjOXn4DL3sKNX9XCKfChcmoui9JdM=;
        b=oN+jtV3d6GICHYOHA3iAAU9PAUjNpFuLYbyWMS8iY/taR3F8GXqEddccXv9G/+b59A
         LHOAKDOYub/qPOkLvRB9qNWtqwBSqHVdH6Xb9jqUB8AMnBwjxpRCpndz1Tndqc3kLzld
         cOEQbMIj/0xPpT5d8U3M5UcTrXGe/a3haEmLnK1tiURYA8LzWepBaEt5/PRzvJKWLVkR
         qgHbPNBElpEVCxqRpstSHxfT6ZEFP/wIWzfruReGcdKRAvwZna3xYUtX+vxHQvKfLIZu
         HcYKGIJYjsD+G4g3l08lJA3um0K0u1MK3lanWRWDFAeMC70PH7fJTt3vONeYk2o/XUF7
         FYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780583166; x=1781187966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clkIHT02uZl46rCjOXn4DL3sKNX9XCKfChcmoui9JdM=;
        b=cKxIAYE7pi2BLZEcl+n6sPo2hJWZVG92fT7sAAZm8UY438QjYlpu1VrzjBlfqsqr/Y
         aGN5YeYq76oFR52aJj9WoGy+YZoeuaj8OgFyM5inB60dx+X6yDedKylGBu0t6seM5auS
         YD+BXj8BJIi1yXfi3j2Y0Zb8cauX5AeTxLNc09DL7FGxcCmk+mt8Z8njYLaVdnm1tQEP
         jexQXfPOturOOpsntssNbeZxaSQGHDaw43oDb2VgGzXo76BVQ1+wz9RTYXkLJqrtkDhV
         MJAQCXYtad7z3d4d8Zynoar1LI4rnWLUqbuWeAS9mq+AfdN6F6djpbgH/ykdkN/j1siQ
         i7qQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ESz/iwblCbfykLpYKUONsZ+0a76x2aRNTexm9W6/PhHpmLRaj/QmJwzzSrLzQgjjG3CiK7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjUGjB2QWYN6+uuy6j8B1uhfRBvXnxFYMhOJUxkSzp1aiNwZD7
	dgY9U/Tigza2C068L3yN+aayglotbN+rURAQh/vtMFBtEmsAy3iVO9rB6bRJ2RECD/Y=
X-Gm-Gg: Acq92OGu2wfog73vRJgb1aT9ditLyIcL0W3n/772X4VZHdO0un3MyD02/r8XBn+fToB
	O/2yViV/8F2zNcFSFXDa/Dj1GSvhuN46wZf1pVqpF3dn1/yENNcn+QA5b03m+lvn+4t1Mjdi+Oy
	Jzu2yVIQm7RLN7bZGxNsmx34uv1joJynk51qN8x4qOkfhEl0X/TLz4+1xWoUqpBK5iqC6IhP9pi
	pmBrdlahlWOY87VL/HKj3VvHJyaYU4Or9jNAiFLImPbifbppoaEapw21ucveBzf977YCwvVvVuF
	VwYmnW460puevLw56cLxdUqnwr/DY4Qt/s2OaLcnvOgMOi6yT3pCtHlhhQqB/LsHrFUT3E4y7rq
	8O80iOHfvnob1++7xBQpDuCM8PO0mwSCXGYi5bYMdLscxbB32xAdYurjqcWFJHiPBd5cbJuR0V8
	uzGCB2E8tAjKjOTvXx8eUuK+7w0ma9GYGbmGPIxSgRckw+lkFPeyLusSYFgu31my3vOeonJ58Uz
	gbsLvabs4RW3dxM
X-Received: by 2002:ac8:7dc6:0:b0:50d:7aa1:f405 with SMTP id d75a77b69052e-517785ada2amr113397751cf.9.1780583165966;
        Thu, 04 Jun 2026 07:26:05 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51790d965e8sm4420111cf.16.2026.06.04.07.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 07:26:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wV91J-00000008IF6-09MR;
	Thu, 04 Jun 2026 11:26:05 -0300
Date: Thu, 4 Jun 2026 11:26:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
	alikernel-developer@linux.alibaba.com, baolu.lu@linux.intel.com,
	boris.brezillon@collabora.com, dri-devel@lists.freedesktop.org,
	dwmw2@infradead.org, iommu@lists.linux.dev, joro@8bytes.org,
	kevin.tian@intel.com, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, oliver.yang@linux.alibaba.com, robh@kernel.org,
	robin.murphy@arm.com, shiyu.zsq@linux.alibaba.com,
	steven.price@arm.com, suravee.suthikulpanit@amd.com,
	tzimmermann@suse.de, wei.guo.simon@linux.alibaba.com,
	will@kernel.org, xlpang@linux.alibaba.com
Subject: Re: [PATCH v3 24/32] iommufd: use iova_to_phys_length for efficient
 unmap
Message-ID: <20260604142605.GY2487554@ziepe.ca>
References: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-25-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603151804.1963871-25-guanghuifeng@linux.alibaba.com>

On Wed, Jun 03, 2026 at 11:17:56PM +0800, Guanghui Feng wrote:
> Use iommu_iova_to_phys_length() to get PTE page size in
> +		for (i = 0; i < npages; i++) {
> +			if (!batch_add_pfn(batch, PHYS_PFN(phys) + i))
> +				return;

batch_add_pfn_num()

Be mindful that the num is purposfully a u32 so that will need some
attention.

Jason
