Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349A0364032
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763581004; cv=none; b=OOrnY2y07R42xqh7u3HKvAEXwICfq54oIJLqJW48a09yPK4/2wrbA/1YZV397bbhAve0y0YI/JcS62d4xSFN28gmuMKj/4UAHVumySFmfSc7pGhwuPouzURlAanQb/R9DM+WzV9Chu/TGFO3g5UbPgCNOV9PNQYEOWyiV/84z0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763581004; c=relaxed/simple;
	bh=sztelLlBrONBmM282viGyh6kz65i94yYxCWrYWozdqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E03fG0Ub8CKCd22rSRqwJHPv7r8Fby/hn3E/99/z8ti723u55hsv66n/v0wjdBbdAs43CYcY1bMekAC6uaRtAgrRWX8RMcObMsjS3N2CfRcP6TQ1nIrP2iquzEw6jnqvN+W6YaRm9nW9FO8WDqt2uznY+FovO/dJpb5dXCk9Mr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZNWQmgvj; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZNWQmgvj"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b144ec3aa8so9395885a.2
        for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 11:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763580999; x=1764185799; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sztelLlBrONBmM282viGyh6kz65i94yYxCWrYWozdqM=;
        b=ZNWQmgvjE+qdi0eOhdzGWsUTd7F/75nMm4aVJiuhzCSD4tBAptPMnqwLxTgnuBecxa
         I2mBp1nhEkg1x2tN0eDQUEhUilmROLPPAgADlRI0sKZK3zsqmZ8jxgE3Mfxdj2wEIXib
         8zILyT2FzVwibVDaAjGscU6zg6xdZHTsuMEsd5D0PMJEb05pzlTaiwIg9dOQ6AfLEgau
         cvP9qD0faAojTH2JqVkCIKOtx3rhLv6lJeZzLETM0uIPWE1FsXgCVJxVpxRMl2OqmT9l
         x5n03dk+GWwHPMJhA74HOBb/rcl+DCM8xJkWvdv25VrcS+MtrrNjIu3GqQ3ElS+CJB71
         wqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763580999; x=1764185799;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sztelLlBrONBmM282viGyh6kz65i94yYxCWrYWozdqM=;
        b=uO/DkGcZ2mQgJpT6ROOvnqu9OcQsrn+GgPBohkLnHKLS4t6AcEtD1M2SFfQN4ba7GM
         j1J5AzoXxhTM4nkUSx0h7EAOEzPoXPWJBasUmKUORbqVMJV3YsbGOydN1ICbzqgUsf+6
         R0FrN/VHZ+WMT+LOaXInDA+/8U7fbjenZDI8lPKYt/Nn0WgE02Tzbcx5VsOdHLxag1LS
         +0XOTOQqj6HExlmHNkFasjHrbGmYmk+M+K1t0AtRLJa/Df2NmUdGx8JMwQzky9dxdnCZ
         NZ7FwBXNrMfw9dj4cdEdcO9uPxnCjV52rDRI6djKFagMWxEQhkwY7iayhQDT9ZtmAWHQ
         mBGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV0zVb4hjF9jczO4e7a2a9qAFum9cmgZHPcBmXVr3AQiX9Ox/7d0tdIHjA0N/4JddHC6GOGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdFWopvSTnGxRutvn5wXQScBpxzNdfgWxeQ9Nmf65HhI0pT+ny
	5dylZXySv5vHBq1Xy3obkFQUhX1kYwaS6P3gxi/RYFEcmwScDOOaGQmtADePtwyqnH3NLW6zhH4
	8WBGL
X-Gm-Gg: ASbGnctNtU9X5/sKPgwdrlGOWB0CNlhn/EzPlUguSOZ8pC0u3USr8z2LaNQrnY4Xtt4
	qMtSu81o47BY6R7Sh7yE64dAyOnWdgr9L0oAyqZPIqBJfM5Br10+rkYbPsFlTO5VQ6ukrEoKVhm
	stK4W4B98EGqxxm100srCnBa1qzNFugaOcQBq+rUl2XwgsN56hBZq3AgR+S2+b15rmT3iaHyS0A
	7SkBoz0LlZYgKZfA/1pb6HFwEXx/8vxlNT8PbW/t4JlgmtfTtzTIExDKY+wZNa7XmJblUwrwFGW
	WCVa08W9J3Ibl/536qogrxb/G/2KHYhNq1L0obx/XAOeBs/UWL+J6QVCOAvUgDvxNhtvpvQjb9Y
	tpVYsCGjPSGmium6CpAuDftQFHtjT6aUMzgnsi/hNH3x3BuTTgGZbaK2QVDKAVIZqweWmH62DZR
	8x5y7E16F3wSoGNQdcbF0Bq75tW+U/EHG3lSt9E2IysQ5ZvBrEXpEi6pGh
X-Google-Smtp-Source: AGHT+IEogkhlTHFcyAE9/u1UuBQV+X3tukog/nHIoHavB/ndnYOWZGPWrkYoYNh/EOln2cA+Kp4KoA==
X-Received: by 2002:a05:622a:310:b0:4ee:1d84:3068 with SMTP id d75a77b69052e-4ee4971a985mr8236121cf.76.1763580999342;
        Wed, 19 Nov 2025 11:36:39 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48d64503sm3117901cf.13.2025.11.19.11.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 11:36:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLnyo-00000000bYz-0lQx;
	Wed, 19 Nov 2025 15:36:38 -0400
Date: Wed, 19 Nov 2025 15:36:38 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org, Alex Mastro <amastro@fb.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [Linaro-mm-sig] [PATCH v8 06/11] dma-buf: provide phys_vec to
 scatter-gather mapping routine
Message-ID: <20251119193638.GQ17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-6-fd9aa5df478f@nvidia.com>
 <8a11b605-6ac7-48ac-8f27-22df7072e4ad@amd.com>
 <20251119134245.GD18335@unreal>
 <6714dc49-6b5c-4d58-9a43-95bb95873a97@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6714dc49-6b5c-4d58-9a43-95bb95873a97@amd.com>

On Wed, Nov 19, 2025 at 03:11:01PM +0100, Christian König wrote:

> I miss interpreted the call to pci_p2pdma_map_type() here in that
> now the DMA-buf code decides if transactions go over the root
> complex or not.

Oh, that's not it at all. I think you get it, but just to be really
clear:

This code is taking a physical address from the exporter and
determining how it MUST route inside the fabric. There is only one
single choice with no optionality.

The exporter already decided if it will go over the host bridge by
providing an address that must use a host bridge path.

> But the exporter can call pci_p2pdma_map_type() even before calling
> this function, so that looks fine to me.

Yes, the exporter needs to decide where the data is placed before it
tries to map it into the SGT.

Jason
