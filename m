Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDAA32D0E9
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476208; cv=none; b=uv+7zOyi1HIbUYY7nCRLixPxF1yp/rF0T7IEZYIbRHKvllMf+96pU1mYwbW8ldCFrDdNOBrqr2NlFIoBlVUUrun/PPUUPQAwlHhQDMqZl8rKe95k1001VjOMpPR5DFxZRap25saNIvTsS3uAxFzxuxd+DNXyLuhL322EzE+1oEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476208; c=relaxed/simple;
	bh=Vzm9kAK03gjq3/EFXB7Lf/qLfrswTurpUBT72P7Q9wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9b7qx6IZdZONdAUCJJ2DHH1LmDDEtJI9NhWDLF0tOUVfHCc+8oDJqjWxz78/yXTwHdB25+gXQxdtf58Dhm5qZ7dKC4eC4rFQfE3SsauUuca64KsY+HusH+84hPufWRLyS0woFAoCIrDqbRTm8Pd2PDuzPSnqz1EqoQZTbISb+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NGGixmdv; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NGGixmdv"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b144ec3aa8so556435185a.2
        for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 06:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763476205; x=1764081005; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gAj/lhLwXUkQIe838UyunLw5D1V/iLtJCJGMnOEEnt8=;
        b=NGGixmdvsy18Msb3XDUUK6sLzPy5I5cW6YNl7d9aq69F/uapxH7vq6EskeJ55vDzMZ
         x+qrGbcoAGz1FpnWf3sg3Rkjp+Ar7b0fwu+hiWGhez7Nz9OcCeQp72Dk6xsPY+CV4Ff9
         sgJD7pIApsBmwKKtCpFtreX6NCbgZEzoM6RN0PCvBcKu0nmqEgX/EqX+zbQz4J2QBTuK
         7mG62KkYhJdBCpfp681VPM2LL3LrYeKWin7q74vE4qD5KrYwtDx+eFqkZbwJV2fQv2TL
         R1juW0P5wbN7gbbrnJAV857rZW37Z/Ctrzf8tQftnqX4vWlmaFvRPBIx3GQBb2FwBm2/
         x2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763476205; x=1764081005;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gAj/lhLwXUkQIe838UyunLw5D1V/iLtJCJGMnOEEnt8=;
        b=LoW5ek5LoyOkA0kz0YbvvAAye3Semmsk1g5aR4Q/abrNpNZ9yun8S3rw8h2e99hWV8
         hLvPTM+b09Iwn8by1QzVZSAJOa4EgKJDtrYlgafqgnyyLHoRXZ2wK2196X7VxfQuQXHC
         yFpdNNtiqZhsw/96cxku/MTuwE9VsELC7lH7M8KN4zqXAttXFnr1gA0gX/psozT3wUWj
         rgZDxDjcX/NjWdDf8UAA80NqRHMg/UGPmXWM5ffuKBWuN9EsysXjL8awa5jyf088UDwp
         0fQYpTci3y+zfW6qfHVszsH5+eIJ20rYQQN+ot/evi0UUbq0y6KTvWM2+F1yVIcz0yxV
         MytQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt3N5Ke5hOOpNlXRI+Jr/Lo+TgNQ6c5xIceeS4TuwIIMz5vdKnvPdSrhenGGMSxoZwRP4DFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1NjAF1gAW4agL/nhipzh+K5ndWer1iXoGDlHrgDBHGJsS8oAZ
	dnh7zmJJwV5/xAMmP6nR+Cc65rhG2KwjOGkBUf9NWHZsh3uwYHHMGSBkRvv5eaIi7ew=
X-Gm-Gg: ASbGncvwp82BRBHte/XE/avTqIGvhs1AcX4i/W0VzgTXDMpPCu51yvdaXEYCUZrNbhP
	vaXGWCSFtHU2kKZ3QPElEVYnPWFbTMqA7/hc+lZzW2vo5S1CBWMufg4UCzxhdLQHmNmJjJgyjyi
	r6iB9C4J3uCZj1tbo8AxsQmu/eBm1YCJCKBW20yY5d+4qNVm0ZwK6FlvopQ43aY12XQSPkg7SR8
	upMqYZj+Ddp1fanVzPy+oG495S3JKuQ1bsKMk5PdIbImYytNnnm/RwkWSpFrGLIgQUQ+mpITmxX
	a5LWK+L5z5IVpbbpy2T2jwXwSSY7ovfBxU7v9VYGzx8We8FzN/NlGLF+bSeVHCVVsZpH3T7NprN
	hj/vAfDI8G2uJQBeBMfSndF1+LG+Ox4FCYuLtQ4ahWh/CWOP9O8m9vNL2XY+123Tzcj7lPVNOXt
	bsVrlS2nwVOLnu9mue9LdBiBH8D5yTCYeWn43xrsqxvlcoyl5hk033hPQNyhG0FoJcUmk=
X-Google-Smtp-Source: AGHT+IGl2QxjkDkgi5jKGR6lwtLy9hLDUjSd3xhjzd2vh/OGWRtCENW0fUVdt2sQ45uUuO7DIyidjQ==
X-Received: by 2002:a05:622a:4a15:b0:4ed:df82:ca30 with SMTP id d75a77b69052e-4edfc875136mr206770331cf.13.1763476204719;
        Tue, 18 Nov 2025 06:30:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882862d0944sm115395396d6.9.2025.11.18.06.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 06:30:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLMiZ-00000000NFZ-1yj6;
	Tue, 18 Nov 2025 10:30:03 -0400
Date: Tue, 18 Nov 2025 10:30:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	Alex Mastro <amastro@fb.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v8 11/11] vfio/nvgrace: Support get_dmabuf_phys
Message-ID: <20251118143003.GH17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-11-fd9aa5df478f@nvidia.com>
 <SA1PR12MB7199A8A0D17CDC980F819CC6B0D6A@SA1PR12MB7199.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA1PR12MB7199A8A0D17CDC980F819CC6B0D6A@SA1PR12MB7199.namprd12.prod.outlook.com>

On Tue, Nov 18, 2025 at 07:59:20AM +0000, Ankit Agrawal wrote:
> +       if (nvdev->resmem.memlength && region_index == RESMEM_REGION_INDEX) {
> +               /*
> +                * The P2P properties of the non-BAR memory is the same as the
> +                * BAR memory, so just use the provider for index 0. Someday
> +                * when CXL gets P2P support we could create CXLish providers
> +                * for the non-BAR memory.
> +                */
> +               mem_region = &nvdev->resmem;
> +       } else if (region_index == USEMEM_REGION_INDEX) {
> +               /*
> +                * This is actually cachable memory and isn't treated as P2P in
> +                * the chip. For now we have no way to push cachable memory
> +                * through everything and the Grace HW doesn't care what caching
> +                * attribute is programmed into the SMMU. So use BAR 0.
> +                */
> +               mem_region = &nvdev->usemem;
> +       }
> +
> 
> Can we replace this with nvgrace_gpu_memregion()?

Yes, looks like

But we need to preserve the comments above as well somehow.

Jason
