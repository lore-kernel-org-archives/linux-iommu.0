Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C0A1386C9
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 18:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759256523; cv=none; b=Z2RuYX+XiB8aeMiaPGfxjk8dgEkhKIaXH9kZLDk54mqHEQI7lAWvtYlF63jYt1FUv/K3zfC4gjnP5RdQ0mVSNHN6/+cz4/aGynQdH7kvke54k182pky3AZQ+yxvYqKe0k7J3sSFZgEFL4sctx826jEFLF+RchmI8aGrbOaqLAz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759256523; c=relaxed/simple;
	bh=9UYdLztjfxNJnURtmw+lbRKpcyjpnYaxwEjrSGbrTg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bryHVwm2wVuiUr9D5OTdvmW5vF7Mm37zymFVC8E78BP/Ny0aKHZucZ7AUW+lij1f25jRqYweJkmAY193sxya5F9tuSAc/C2CjE6+o987AUhI1LMOin1Cg6puOdXzdNQw+O1Y9W7Xk7OcL0+sjfwykKsd/H/HyNVlmw1VJ+fBr9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nU3bTaUz; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nU3bTaUz"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-84dcf6f28e0so641057085a.2
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 11:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759256520; x=1759861320; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UYdLztjfxNJnURtmw+lbRKpcyjpnYaxwEjrSGbrTg4=;
        b=nU3bTaUzDNQM8a0VZSjbgUzxfLkZ+Elx1vpbcufo3jE3IcdjAZKOmFrCvki81wvlcM
         n3KRka2ISmK5wmGxwczv7weUippUW8jrwG7V/ACGGD3U1r+Qb9QPLm29cwO1lJm3qiyT
         4WeMe5k3MHob2GJ15PETy5xJ4wJYuYfgsyrxzxSG01mvbPVtVlkg5Qp5NXaHQvuZIPnp
         sQRLzhHbd7m9wc2gP1kB3Nms0BuJ0/BH364w2gb98pTDFXdOOQyB+wGGv1OCA6r9AwMk
         Ho/4vPOwYfsi+DmPt1iU3CHjYC0+lmPC5yPjVtZPJIW53PWMpUPyx1VtjcDwcwB0/UNQ
         vZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759256520; x=1759861320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UYdLztjfxNJnURtmw+lbRKpcyjpnYaxwEjrSGbrTg4=;
        b=rD42mc8qV8OxDguHyLo2EcwD7mKxrSreSfHk2FCBQIvDg/PDu4NtgWVe2stCxNNcNj
         tVWFFQ+4wa+2BSANSESZY7Aj+lLTQ4Jn/Qa+GnXvljP6jdbgiuPDnJRh0xK/4JnU4bBQ
         eVbSZrkpIEk1CX0IXakIJsR4iZSwCsgSccL68527bRDA9K5oBw11IaSLCk1WUFahMjal
         /O1QlTouy2dmzKlJFObGVdMutLTJ2rh5N6or2GVH5HmQG/2q3qRLaF9nbbPPZaOGt0+b
         6EH1OXuauzMR6Ll4uO0OrRjNxhSzIzxd+JRutAmI3yQC2MBnSZafn6v/JfuWRltjoEtR
         moYw==
X-Forwarded-Encrypted: i=1; AJvYcCX1OVjwQCtI5NWpK0GpWblmt5BFJruKAkqwQNKPfJNfVbb0rJDcYBNBEaSovrnKaiBm9DYWdA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbRR6+IFB5Xm9O7YWKhxnzaomehG85vWAygiHThz6GEm/EvZaL
	Kx6zYKjaww9K/ZGas8xMHrWSA87XLZWsF/r8XuTWHWg70ewaunKOAYWSYfOxYmPxGbg=
X-Gm-Gg: ASbGnctb1A6M443cE9s4RRZp0bDRO2gE3VvvFwLcSzli57PIQaOdXtzAYK7l3uv5oIu
	zdWHpO3WNgEfZYN7mMaO9veEExGPJt+knSdPfMEyGu8Kt9Ps8KybpP8xTCy2/kFP4+Estcydg1N
	jrsGZHrCLa/UXYkDfhttzoXZEbdeGo5PWUB4xmgnDYGCpGoxWOZ57QaK6qxEcDdq6tRgFMgeJaE
	6VKsbsxcusODZovCf0PFfIsjy9mmu6g+GU4uqI6vvrrEhyMKXa+Gg/8kMv3KC4kF3gsx48tSQii
	orlEmCk+cLHi41B2BFBu/CwkHVNaQ0TaaMw2+wBU9+mR4x8oemx0nZBZSkcr+qMhqJv09OajyDE
	RKIN1ovFsm1ZwERdmWe7BPyA49XkZ3i4=
X-Google-Smtp-Source: AGHT+IFsIfsirssruboI26MlaM0NZggtj52mIktm8BzOMFTKBqd4QU6pWwedeMRBbz+8NtekD4Df5Q==
X-Received: by 2002:a05:620a:1a0d:b0:85a:1caf:d07a with SMTP id af79cd13be357-873721b7327mr111082085a.34.1759256520220;
        Tue, 30 Sep 2025 11:22:00 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c288a0f7dsm1081472585a.17.2025.09.30.11.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 11:21:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3ez8-0000000CgR4-1wgY;
	Tue, 30 Sep 2025 15:21:58 -0300
Date: Tue, 30 Sep 2025 15:21:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Johan Hovold <johan@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] iommu: fix device leaks
Message-ID: <20250930182158.GS2695987@ziepe.ca>
References: <20250925122756.10910-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925122756.10910-1-johan@kernel.org>

On Thu, Sep 25, 2025 at 02:27:42PM +0200, Johan Hovold wrote:
> This series fixes device leaks in the iommu drivers, which pretty
> consistently failed to drop the reference taken by
> of_find_device_by_node() when looking up iommu platform devices.

Yes, they are mis-designed in many ways :\

IDK if it is worth fixing like this, or if more effort should be put
to make the drivers use of_xlate properly - the arm smmu drivers show
the only way to use it..

But if staying like this then maybe add a little helper?

void *iommu_xlate_to_iommu_drvdata(const struct of_phandle_args *args);

Put the whole racy of_find_device_by_node / put_device /
platform_get_drvdata sequence is in one tidy function.. With
documentation it is not safe don't use it in new code?

Jason
