Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CEE1AAE25;
	Thu, 20 Jun 2024 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878631; cv=none; b=XtZgmBdiJRSmE1ZnRBLvng0PK0XaEoG+ARIpuE97SUfVJYrPLM2ieZiMWdrJkfC+o0kxj8jrmIH6gefh9DODJN34Lg1zdLeY5udD5Kboh1gkzKr1bvjeDueVoiK9BqPNeVpNEIetCOcT5EIREQQeQafOZL7vOOo5ohcXOdqg/jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878631; c=relaxed/simple;
	bh=I852Ejxeh6UBMbuDlX5f1x21bZJ26MMuC54Ks2Ixqy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGyeG8ARMVv/KUWOVFCkvWJR+A+dfPp/gkNi7hPyQEhzwPTuNc4Kz3pArkNME+pD0xu7IRS0fffCg8/9+7neXC1CfswL96kiMpfO8rCh2rs21xHrSiZ2pfwUuirCVtFy7U38S1z0et4ZHA5Py6fzw4H6tPp0cpncZJDLfDOJBaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7ebe019b9cdso23051939f.0;
        Thu, 20 Jun 2024 03:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718878625; x=1719483425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Ii5+G2KJSVTDisMBcuARMzoZC7l2YVn4JwkkJV90oQ=;
        b=egUsW0TxBpREF8O944TB2+dxDbHkzPb1wofN+MJC3UIg+tE29SxI/pbYrn75ypGpWv
         APvr/UEUl91TaysEaAPzJH/QFMlz555wh6vUHino+qr2mg7IOuhZNsog81mF4zx7QOcC
         8jTIsuwg7KtaPhOtkli7yDu5VE/HkJkB2vlFrVy3JbpDAwBhsjVfwndOWMcp4SZv2efH
         VErXbL6pmyKCJupUv/QiE++KVfzpmJbCE7PPT0xDYf4kHxELr97rWRoeqnHWVIBTSMNb
         9rlGaVbGlL8YvIrm/+wMFq48NCaLcA5NWvYwmOBoOAoVRpdUVK+bNPjCP7D+GBj49RbS
         nlFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvuWfguIkU45+vxVNczw0Az9rmFCTl4ROLJjFJpMhj9pMNjRkx2t8RWzzTdsPMD7JlutFJL9rzTkK2pICVn2/WshYhUPfm4U/l0jbEB0xwS7Ec0rOziN721wiKn31rrEHnqA==
X-Gm-Message-State: AOJu0Yxz1SL7j4D0ogWXaKBrxvvFs57v7wfb6niULb6CMbEFWBnrmoP+
	mItn4RmdlxFL3D2mcCIey7LObdgIguHLa/70x1FydTsZjNqr7901h/PmKxaRlkBnxw==
X-Google-Smtp-Source: AGHT+IHvg3jK/b7b7r9mjXrG7N2BceVFYYUJqgc+2ls4R+81Oi1Bk+pcyalpJb24urlqUT/vmH0nuw==
X-Received: by 2002:a05:6602:1347:b0:7eb:2c80:5329 with SMTP id ca18e2360f4ac-7f13edde6e4mr577442639f.7.1718878625255;
        Thu, 20 Jun 2024 03:17:05 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b958ee4441sm4175953173.59.2024.06.20.03.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 03:17:04 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7ebdb5d9915so22570439f.1;
        Thu, 20 Jun 2024 03:17:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9v7AiZIAr/CtnqxwkY5rsYP0UqtB+aCL8slcULGReKY8i8nERCRYTZ2Fs3tWymg9q8YtiPpJVT8mte+tK2dVJP6kkEPPpsEQnne5cZh4PuzdSaMIwDFe2vwSorU4ZP+fb9w==
X-Received: by 2002:a05:6602:1347:b0:7eb:2c80:5329 with SMTP id
 ca18e2360f4ac-7f13edde6e4mr577440439f.7.1718878624678; Thu, 20 Jun 2024
 03:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240616224056.29159-1-andre.przywara@arm.com> <20240616224056.29159-2-andre.przywara@arm.com>
In-Reply-To: <20240616224056.29159-2-andre.przywara@arm.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 20 Jun 2024 18:16:49 +0800
X-Gmail-Original-Message-ID: <CAGb2v66-a+BOB-V5Q+YOS3M=QTZ7VMG73N0yFtRo6p-xh=muTg@mail.gmail.com>
Message-ID: <CAGb2v66-a+BOB-V5Q+YOS3M=QTZ7VMG73N0yFtRo6p-xh=muTg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] iommu: sun50i: clear bypass register
To: Andre Przywara <andre.przywara@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Ryan Walklin <ryan@testtoast.com>, 
	Philippe Simons <simons.philippe@gmail.com>, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 6:42=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> From: Jernej Skrabec <jernej.skrabec@gmail.com>
>
> The Allwinner H6 IOMMU has a bypass register, which allows to circumvent
> the page tables for each possible master. The reset value for this
> register is 0, which disables the bypass.
> The Allwinner H616 IOMMU resets this register to 0x7f, which activates
> the bypass for all masters, which is not what we want.
>
> Always clear this register to 0, to enforce the usage of page tables,
> and make this driver compatible with the H616 in this respect.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  drivers/iommu/sun50i-iommu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> index c519b991749d7..dd3f07384624c 100644
> --- a/drivers/iommu/sun50i-iommu.c
> +++ b/drivers/iommu/sun50i-iommu.c
> @@ -452,6 +452,7 @@ static int sun50i_iommu_enable(struct sun50i_iommu *i=
ommu)
>                     IOMMU_TLB_PREFETCH_MASTER_ENABLE(3) |
>                     IOMMU_TLB_PREFETCH_MASTER_ENABLE(4) |
>                     IOMMU_TLB_PREFETCH_MASTER_ENABLE(5));
> +       iommu_write(iommu, IOMMU_BYPASS_REG, 0);
>         iommu_write(iommu, IOMMU_INT_ENABLE_REG, IOMMU_INT_MASK);
>         iommu_write(iommu, IOMMU_DM_AUT_CTRL_REG(SUN50I_IOMMU_ACI_NONE),
>                     IOMMU_DM_AUT_CTRL_RD_UNAVAIL(SUN50I_IOMMU_ACI_NONE, 0=
) |
> --
> 2.39.4
>
