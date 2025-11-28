Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B76A285C98
	for <iommu@lists.linux.dev>; Fri, 28 Nov 2025 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348501; cv=none; b=NiJ5CbKJK7Q/QFOOy8lo6SyP5ZxABw4fHTxcNOr5Y8WDzL+EmXM3u7dPGU8TiVDgBo8OCgiRwd6z74hKiej6pLyrYKbIazy2JJOKfdD7VzgyyepC573KxcRtY89XJDwW7C81K5Crxg9gHgRTHjPAXrv52KJi8xPw6r0e8nCa6uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348501; c=relaxed/simple;
	bh=pK8K7Pa7QZb6H438w2S79hy/rHjho1lVUg5bIpSNGXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oilIj4CU2NpuX6nAdPZb9LMkn376LwudHFbQtmvEN/GmYd3ItAjHfh5bzsJQjHAaYZY5LKG6OFpu9QGm/CN9UqV3aRkrzTyNUNxDnKunVB2EgSAKUudpOBWKU7D/76JbA8u07oDcn6EVVs1hTuIEPGvCXKzrLJCx9u5Q7fX69pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BJJ0ze+v; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BJJ0ze+v"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b0f54370ecso193390985a.2
        for <iommu@lists.linux.dev>; Fri, 28 Nov 2025 08:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1764348497; x=1764953297; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BAfMjKf1n0EM57yS6vP5/PFm4GU7RlouzaAGnKGJjA4=;
        b=BJJ0ze+vkAIhtepzgnldPEeitmuGcBzX3AuwYFf+8SlcbfD+OqJe1aJulVgkA7kZXT
         SgpdJWCZWuaZwYe21bt52IfPwlSTtFITsNVIzhz4sZLHS3uE5wD6I2z0DQHbU8Aerchd
         X1JvtOoiiXVm35at40Q9UnVBPct+aIT+I5VrMfR9Oy5KUpEf4G5NAg9zjePhkq/9Pq+X
         bCA8CpYko3FU0RhBvZDxXMPw4A+PJYVOeYcyH5MIpvxbRtJfQcAB9FWRJ5ziFYj3spXK
         BnC7H61QVBOzWi1TPkQHXyvJE0pDxEs5blQUhkWtC88eCg4SsxasRdweuYA/exGnmXIP
         6jvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764348497; x=1764953297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAfMjKf1n0EM57yS6vP5/PFm4GU7RlouzaAGnKGJjA4=;
        b=YuBHVpdrHM42zAvLl0ZC41MMqPoZwxzbvZoB5Emq10twUS9aZ0jbRVPfTx/CGwISNM
         NJTDO8DH4Y6grtknnD3pNJ4fMS3MU9RRaxT8DFBTLYCcCleBXyapXB0od5nKgu49aSyb
         WNpLNZhwB9XAdEl/eBQ6r5RLApo8sUoxvCSaA4TXiA8GrUoaj1dK17Xs93S/sf/rljxr
         G+g00/4KfdRaFrelPfmLHUSUUsl7IIJ5GlLi360ntLAhHmCGcWSAG8D3DUqmn6i2qOXU
         AXeLTiw/6VvxQHenxoxaFMyir9CIRL4NVA1ao4WN8ZakWZHA2D6YRaLuC12Nm+H+UJQd
         CDsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUycyweDMj+UTMPAPKAYJ8pVy/ZfWzrWJv1heSbcCQNuiIZztZ0uLVlxbm0SpUBG60pTS8kdw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw52kGQ45byc9Anr01TpRSoEpxUGEJ4ZMC+dUKUha8h3h72x0M8
	tWQ/SMQQiXiEnfstBxdF1zZhQ3yL35YZpD6q2G5xwKyqTq0cWcuUe/oOIlwHE6XQxdM=
X-Gm-Gg: ASbGncuGo0MciI7IUps/wHtQ/va/uky7Q0r9GMxmZef5U5WhTeQUIEZRQR1MhgxrPD/
	7Ij2YALsti2XxEOyrpvAgz6FZwE9OrdiCdfsHhY9VND83EQAQrX5PpUN/1uprXdKinowiE62HJw
	f8fpA7BtUj/Qvd1x/td/p6EdRI8iQ4gJkNv+R7if8zuOJEUWy6HjWuREZHTfLhteLYWSROYdoa8
	A/+DY1XlxTMVHokJs9ddt+dHOEWaXzRrq3yMC1hH1BJCy7eOTSygii8KkNQj2SdJ1Mq7MgiEzVS
	VId4RBpRlpfhI2VFMFwCTgk34EO5Jv2psXyZEzsNXjGnG/iJ406hnOMHWmobMsmKJ3QPFXWTbHL
	FomAToh+LuIMiCQ0V2J5XiCskFect2vCxdQ8mrVziEcgpo5VIMbhSMugbss6h3BCNai5EtD4jOy
	CLOFdmFU3yexvURc82Mp0MP9DwN0aEpAb+Au3Bm8UfhkaLlF5+DwPvDmGg
X-Google-Smtp-Source: AGHT+IHQqaabicTwzKD3aV8B7vGpE1WoUx4p1TCHTluWfNaKtOTmIupEbWyDAmYJQk3capA2QEx8FQ==
X-Received: by 2002:a05:620a:4496:b0:8b2:76c6:a7ae with SMTP id af79cd13be357-8b4ebdb0ab9mr2073856685a.50.1764348497176;
        Fri, 28 Nov 2025 08:48:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b5299a5f1dsm335208785a.13.2025.11.28.08.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:48:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vP1do-00000003PwW-0xng;
	Fri, 28 Nov 2025 12:48:16 -0400
Date: Fri, 28 Nov 2025 12:48:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	praan@google.com, danielmentz@google.com, mark.rutland@arm.com,
	qperret@google.com, tabba@google.com
Subject: Re: [PATCH v5 07/27] iommu/arm-smmu-v3: Move IDR parsing to common
 functions
Message-ID: <20251128164816.GC812105@ziepe.ca>
References: <20251117184815.1027271-1-smostafa@google.com>
 <20251117184815.1027271-8-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117184815.1027271-8-smostafa@google.com>

On Mon, Nov 17, 2025 at 06:47:54PM +0000, Mostafa Saleh wrote:
> Move parsing of IDRs to functions so that it can be re-used
> from the hypervisor.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 112 +++-----------------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 111 +++++++++++++++++++
>  2 files changed, 126 insertions(+), 97 deletions(-)

I don't see that this slow path stuff needs to be inlined?

+10 to my prior remark to not dump all the huge inlines in the main
header.

Jason
