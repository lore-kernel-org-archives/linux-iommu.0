Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9081D63DF
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 19:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736968365; cv=none; b=C2ZtmC17sBk48W6qmv2Pf3fZX9winwZsRM0aYlBa+N7WDdf5GYSviKmk7xFfOcSiSWRKygIsRTH2Agb1l0hKfPeQ+15X9Nv3FnSHGlmoPbKQE0hg7FBcLOLy31cYsFxRGIjUTwx0zJm//nGwajfwLUEy36iBIInen3WNa0aXgpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736968365; c=relaxed/simple;
	bh=B/gzOdGkeGxzAG0y8FfSoGbbohfBxqKo7MqsY7zNrDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/QlZC6WU/wU/kpYIK/UbqesgVy6Wq0wd0/ABmMV+z2FXUsGRo/vLOnXZcl/MwLUlEgJZZ7mM5IuLtdmx26MXNrScBoukjQ5NV9wKXR2/shYF7fvSa84ZE+RWupzbRD5z9WjABDgaumAM2Q2pHT8IyHf44vypUlIPcFcnuOzcRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ofn7vrpd; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ofn7vrpd"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-467a63f5d1cso1574371cf.0
        for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 11:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1736968362; x=1737573162; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/4oGFxCwPaJgAdqTBVjzj8myjSC006R3VVcxomH2jWc=;
        b=Ofn7vrpdVUjYuxof92udIu+NM4DYYrQgHeKxLb0MLnOKH1677GnrmUMunQ4833a+Tq
         az2MAAw845UP/F22RTfjM4fS2xr4roHu0ovVIWRoMHuqXXLUTmUiUMK9H/gFZUQ2FTsC
         gNY6v+ptl0pZzLly+rgwb242ZgM7pVic8jmjUzt/VgWM+BwSDPCAefl0IzafO8gkC/s4
         adRBFCc0LvbqHMZiQzIL2B5765iXBqo7/qLUGbjG9W8NQmbhS808UP7U+F8fjPvgV7Ti
         mFLDzh6gHJhoJRgpytSE+B+V/B2QGdV/VFPDePgSqIk8/7n/Y3B2eA1PCAtZ6GlxLafD
         t09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736968362; x=1737573162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4oGFxCwPaJgAdqTBVjzj8myjSC006R3VVcxomH2jWc=;
        b=hNbnmAddJzkmmD6Wr4597eWwgliPdosBe28CRaKziyEBUApw/3F+yCfEZovrUIAAUe
         uXsuHXCGgOJ5AZhexOrm/ZaIYg+9mWRyJP+8X0DtU4PU18QMKo9+eMQBuxXpwDvvRK5X
         MPF3P2bcvwvP8HjCDIKOsUGXdiAreyZ9nZGORhgau1cT2DcX3AIq1H4j0ii0N0P4GLxc
         IpD2aN9BcEHG6JwO5YMlL7YJfqth+T41hEwVVXVX/qEw66NEW0FxC3a2spq/c7mRVSq1
         7nc2uqVfdreZd+jxyVld7hoCtq1ML3Cm6rG/7BuIAATGVMBNKyYqRNavRs+fxKRPbilx
         s55A==
X-Forwarded-Encrypted: i=1; AJvYcCVnPZJdTVQcMg4W8FMK8kGNBBtq29K1rq0yt4Zup1bmQXxNgoqBcLlpDZzA7Sk6GglYeRLTXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwU8NpXcDgKHA4bTpvTX/GSh/Gwuwogu89wZ0p73G7nb+6dNDNe
	tzleeNruJAEQRCuwAH70uktZHsGnMG36i76xYRkVMyOUmFePqokTjTv95euulQs=
X-Gm-Gg: ASbGncvpRFMgqQ7sSdcM9un7jA/7Bo9gNHfOoEZS+VLK6yspTxRmMQOI541uXSyzaZC
	Jjw2bXCxbom77sPLWKkfpYrSWk2z+bb8UIkgQgjsMyBsIrE6WjgHd3Ul+QvIDj1mxb7sjWOSHuC
	TwD8Qgq1hW2006xx3rJvFhWecawTQRX0gvkXom+6pk3RPk92B/rdhZPnh5hkaVM9Lyv7yNLuc2X
	kJVFf5fRZKrfD+Ym5TOJxsb+d5kqfhehrdy/PjaMQej5OX9ClO2Gg6oo7LEjTtxbPJDu4n8gxo6
	lPdT98YbiWFZlUOVEDkJN3UOwIzqPw==
X-Google-Smtp-Source: AGHT+IGLgsr87VLlZ/6vxEgew2f6ev8/p69ziLEOON6TEwqWnOVVTirBJBkB/bFj8Dm/enP76kSGnA==
X-Received: by 2002:a05:622a:1a96:b0:462:ea22:33bb with SMTP id d75a77b69052e-46c7107aa17mr104417681cf.38.1736968361749;
        Wed, 15 Jan 2025 11:12:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c873de559sm67648981cf.78.2025.01.15.11.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 11:12:41 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tY8oi-00000002pPE-1jhH;
	Wed, 15 Jan 2025 15:12:40 -0400
Date: Wed, 15 Jan 2025 15:12:40 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] iommu: Use str_enable_disable-like helpers
Message-ID: <20250115191240.GA650389@ziepe.ca>
References: <20250114192642.912331-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114192642.912331-1-krzysztof.kozlowski@linaro.org>

On Tue, Jan 14, 2025 at 08:26:42PM +0100, Krzysztof Kozlowski wrote:
> Replace ternary (condition ? "enable" : "disable") syntax with helpers
> from string_choices.h because:
> 1. Simple function call with one argument is easier to read.  Ternary
>    operator has three arguments and with wrapping might lead to quite
>    long code.
> 2. Is slightly shorter thus also easier to read.
> 3. It brings uniformity in the text - same string.
> 4. Allows deduping by the linker, which results in a smaller binary
>    file.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 ++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 3 ++-
>  drivers/iommu/mtk_iommu.c                   | 9 +++++----
>  drivers/iommu/mtk_iommu_v1.c                | 3 ++-
>  drivers/iommu/rockchip-iommu.c              | 3 ++-
>  5 files changed, 13 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
