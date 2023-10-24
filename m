Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C76D79C7
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 04:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vpvcpw0b"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-419b53acc11so188831cf.0
        for <iommu@lists.linux.dev>; Mon, 23 Oct 2023 21:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698120785; x=1698725585; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwLPMC0O2hPeP82CoRdYg2u15lSWlFGlLpMo2Bl/1jY=;
        b=Vpvcpw0bj8CiimCbA/CZdCVKBtCTKFjln09Y5nl2WxR5d5VsDxjTcso0XL5IDZLR0B
         KgXwa+X6tmzmfKek1pq4K2RZhfq47ky2x97r7mzJgdfoGZOVvmjYjnNjtBe5fwcTFGy5
         Taqn7y6DvzN1v48de0jP9GFZyoh1da59dlvRQDtWGx+Q0/aVgispcUWwGYtC7VOMPJ01
         IpuPqaks1Xb3mu2lO5nbNJ5l+MpFj6AbYoJWqeW5CY8MaimNZOOXDfHg/tZnSskZB0Rp
         gJh95/kHukfq4dB3fv8zDyY/pXquAL29plMUzZlsSWfVdy6y/nyLLzck9/+UGBieyU3c
         IxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698120785; x=1698725585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwLPMC0O2hPeP82CoRdYg2u15lSWlFGlLpMo2Bl/1jY=;
        b=ELQLfRRawwKDSTpgT7zvXrMS7cf7sDZ/csj1H7OPm8WmhGwRff0elYemEVyygnuN8C
         1JAqHK89TwU+mEjiZJooUKp4RIDEdiX+CIkNP4L8tUYfyS9yC+wThx6oFjLIC9RCn4vc
         U/xONYkVkjieHZ2d6rnvdJHT04zrw4X5chEyVCqRe1LQHVNRuukRoDpEWGgpfA4pCg9g
         dP+DnqQnIU5oPcQgsOYpmsc+WbHcksNKFLKBrF6qjOul8YIM88sWnEtW1sJKJ+dPvZcq
         F9hGb5fxroJmhrtMgpdblRo0q4MMAXWq7Al+skgL1S6fkmL/OcvgYMaO7wVSXUhVcBeK
         ZDpA==
X-Gm-Message-State: AOJu0YwNlkEjTsAbpMFzXyNCdtiMa69hXHZaE1ZbN14DGO9JnQ0KpkmL
	V4UBa96NKfx2i6PK8veu7X5omNBumFhFWF5V7jB/2YWE6dVaK2Y/8RO+4A==
X-Google-Smtp-Source: AGHT+IGFYkxpU2dyCP2BaCpnsmBrmFLD+Zw5ZRnO157JoLO+wswU691cZ4kYMKBT1Cm+nOxa+dhRXY/PMrDx2cWAjZQ=
X-Received: by 2002:a05:622a:1e05:b0:41e:2d03:4327 with SMTP id
 br5-20020a05622a1e0500b0041e2d034327mr24011qtb.1.1698120784957; Mon, 23 Oct
 2023 21:13:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com> <10-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <10-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Tue, 24 Oct 2023 12:12:28 +0800
Message-ID: <CAKHBV26n-Fy=GseasjYG_7TNKoDDYBcCx-DPC86yetQe057f6w@mail.gmail.com>
Subject: Re: [PATCH 10/27] iommu/arm-smmu-v3: Move the CD generation for SVA
 into a function
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 7:26=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> Pull all the calculations for building the CD table entry for a mmu_struc=
t
> into arm_smmu_make_sva_cd().
>
> Call it in the two places installing the SVA CD table entry.
>
> Open code the last caller of arm_smmu_update_ctx_desc_devices() and remov=
e
> the function.
>
> Remove arm_smmu_write_ctx_desc() since all callers are gone.
>
> Remove quiet_cd since all users are gone, arm_smmu_make_sva_cd() creates
> the same value.
>
> The behavior of quiet_cd changes slightly, the old implementation edited
> the CD in place to set CTXDESC_CD_0_TCR_EPD0 assuming it was a SVA CD
> entry. This version generates a full CD entry with a 0 TTB0 and relies on
> arm_smmu_write_cd_entry() to install it hitlessly.
>

Is this change observable? AFAICT this will behave the same way but
with an extra CD sync operation to null TTB0 after setting EPD0.
