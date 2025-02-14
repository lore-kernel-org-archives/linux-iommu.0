Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013EB229B2C
	for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525097; cv=none; b=szOE0rKwmxSnH6+EnY1XQjXhWilphNYAHb3YXSdK1XIWEr3+7jdM3/GH2zihU2tMmHPBXi0hpgyot0/EMq77kFXoWZREo4IFzkqT5dDMAIJSwlO3ta9w9rXV161GH1B7d64RMLMnZ8MADPjL+pjqgvitYdElko3Ra+1hFj7UJeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525097; c=relaxed/simple;
	bh=d1wlMH588Z6yDEP1MFtLtFRjpV2D0arHjgG/BXApk7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CeIxluoGp5WXFyrpoUV/lTbpnvyymDuuU7je7RQWU1p2uwLa1Uz4ygeT/I2+PVTS7/wBYEoY59vh8m/+XTF4J2IUEUKVLZUcRCrn8n3DVY/OBiGMMax5+1IG/MgfsPS3HEZIW0PMJasDMbs/76gaSCtlBQ4fyYvyMT0hsZy/ORY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YfoMHmmb; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YfoMHmmb"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-543e49a10f5so1935902e87.1
        for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 01:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739525094; x=1740129894; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+8xrkm9mttHMT5UbPbCNDDmwidLeRPd7KRTfBhHPCas=;
        b=YfoMHmmbAsX8shL2b34YEAb6G91B/tvm/yMnLvhtAKKvj6vodHXt7hqM5m15aAoTxI
         iR0qA2h5S5kMp7iqtk+RoHnhVFZVaQIU6QwRUN/5pUwU7UK3+robzd05O6+b2xRxQTRo
         yZHHVD9u9WvT+fk77d6Sn5T4galMUknvKXWj+4oCma4ksCWTRIvDrWJ+pTAx60CPC1Eo
         3g4o2GzZw20kW8jDNx+wQtYzEsdaceBnlWQkqx/rb8GZ/HmbavykscauwtOdQ7Oz/T5s
         Grdo8QJ9rlLx7/pt5FVXEsyg1phDzJjl32WQM9yCFxb71OFXqxs3dMGWSpZrvu7/FsGb
         EAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739525094; x=1740129894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8xrkm9mttHMT5UbPbCNDDmwidLeRPd7KRTfBhHPCas=;
        b=AvVZvNoFrxbfwrq6ttwWIUTLzF0ADUw5dIBNPHX2pYRaO/J64kqit0F5KFepv+3AM+
         WGlsWd/+k0CNsvIiobWB/+V37kP7jkjSigQNefghOesnI0fbIia3XQBS8kSpAot1VSrk
         /08neUXKjB2hkAtn08aIYUexNJqMbC4IU+TUMux05rlmsZ8p0XQZm5jpWs9I+bJSqzQS
         Gf14E2eIJv3JACw+GcalEb94Cp+qJhlbR9IS4704/reFLCPpShyesxFWAp/hyg5u8/rZ
         MKXBykTKRN1bPF64iWDkAHoGFQpukUbppv6mA6GL7xensnzwoBTxCfwuXTWDv5fKBYDf
         8b2A==
X-Forwarded-Encrypted: i=1; AJvYcCUPEfyppJJag4x2zgJD7d/Zb1wyx90JQzNMFn8g6m/fZWeGGsBn+c1UCvK0XVWoxQCJw9wucg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEdgtWlcX8f646L2AjOQbDBcO9UXoX/ZgRvHT2P1v1GZOXzxJe
	OuSCA++P47NYO0Kd0jNOmQC6w0GCjWvDfZl0uChINy/u80ZiVo3WFFEyrPJ4t6eubdXDrufiDw6
	c0XLJy2HDDsyyfXKILgO0nGMcE9+4dwSjAaNmMw==
X-Gm-Gg: ASbGncuZKHlGqsE3z+awkS2jQEAtr1fiy8itNWktps4541nd+trIw+SFnUw1xjBIadn
	v+OecLmTx5zZzzPDU/PEhL1ujk3Odts4f0VFaKwlMM3RU5xFmTQ0djIaNfobdWtYDeJZYZjE=
X-Google-Smtp-Source: AGHT+IFWV1F2V+9LL8q2W9e+NB5QweZAcTYLtOomoEx+6dpIzsXrtn4v0Oy/tpP4l9Wn5FZ6Y5Eo1ipBdEkZ0Chsm7I=
X-Received: by 2002:a05:6512:e97:b0:545:2b24:c711 with SMTP id
 2adb3069b0e04-5452b24c92cmr353044e87.21.1739525093936; Fri, 14 Feb 2025
 01:24:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com> <CABQgh9FMy7oVt9+enSpJxXvkux+czMFqbsPZVgmBV+rFWWvhGA@mail.gmail.com>
In-Reply-To: <CABQgh9FMy7oVt9+enSpJxXvkux+czMFqbsPZVgmBV+rFWWvhGA@mail.gmail.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Fri, 14 Feb 2025 17:24:42 +0800
X-Gm-Features: AWEUYZm4VYXZs9D9gG1u5f1QdB-hm7ET9-KXeIGkEb4d3KyyjUcKgmCuOU2-Pdc
Message-ID: <CABQgh9HTCN8mgZhUc1+oNGPK4Pcw-iuQAyiVqTYnegCq4gDfpQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Feb 2025 at 16:43, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> Hi, Baolu
>
> On Fri, 14 Feb 2025 at 14:11, Lu Baolu <baolu.lu@linux.intel.com> wrote:
> >
> > The new method for driver fault reporting support relies on the domain
> > to specify a iopf_handler. The driver should detect this and setup the
> > HW when fault capable domains are attached.
> >
> > Move SMMUv3 to use this method and have VT-D validate support during
> > attach so that all three fault capable drivers have a no-op FEAT_SVA and
> > _IOPF. Then remove them.
> >
> > This was initiated by Jason. I'm following up to remove FEAT_IOPF and
> > further clean up.
> >
> > The whole series is also available at github:
> > https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v1
>
> I quickly test this branch
>
> 1. host test is OK
>
> 2. qemu boot one device, test ok,
> though reports this when guest bootup.
> vfio-pci xxx: resetting
> vfio-pci xxx: reset done
>
> 3. qemu boot multi device,  test fails, host kernel reports [Hardware Error]
> qemu can boot no problem
> Test fails.
>
> Will do more checks without these patches.

Test on 6.14-rc2 without this patch set

1. qemu boot multi device,  test OK

2. log "vfio-pci xxx: resetting/reset done" also exists.

Thanks
