Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FBF4A29
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 10:16:45 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-40a47e8e38dso323141cf.1
        for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 03:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692613005; x=1693217805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DBlaKc14FwN7oz3yb3olsvOOqmt5j3x+R4hTmIZQs4=;
        b=FNcTkll9b2OQnSTIUj9oooC6DOgVDY8CQJjvh4hSROYjpLVwHPXk7BIiBc9Zn2rfN5
         zmFhMetAOKN0N37o+cGuNKUqpt1wAHDI4+v+2rCPEOp/5H6Cht28SKNI7cKyUY3JrlIS
         5JxoxqftTexzBMTLrfBoxvUTfqxmtMCG6DWOIvUlsiX2PE0V61D68jCp5dmDKTv78pqG
         +SH05jm2peGOBr/AuRQUFmMu12SV3O+9bpGtuc2F4aGp3ry/+ciQ+j7C1FAV5C9jM23B
         BK4ogzi7gUmt/QEESoJ6PZTooygwHo2Xh8Sri2f3FVx6EEcON+rHIO3t6K82FHBWDtFS
         IOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692613005; x=1693217805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DBlaKc14FwN7oz3yb3olsvOOqmt5j3x+R4hTmIZQs4=;
        b=A12Uk7mNO2cGVpFj74aD4rINVbPVOXElk5ZV3xh+gbMO4kIefjb9DkY2I7IZg7MzEW
         sNNuukbkTpZBFsAnOOMoF8Xh0N1gwFhaVinnAtY7xEZqOzX7p+7sQ07/eImrAHGy37iD
         yn/jfkWF+T298IB+nkO5Bg6VLs0BxIVwDZQynDb34Kd06y2aVLSkw5FhbliXpprR+JM8
         6gRTztsCt8mgq6nXPiEizYCKyur/MrU5ssDzbcPSAsivGCHsKC9NSx0TmkXLtIVcSpzI
         sf9hd3tOaadpCH4m39803NGjcIaUiQpCeIv4isrF3TH6yAwimzcO6i/TOfDIWtKw3wZz
         QgYA==
X-Gm-Message-State: AOJu0YxN1JJB0l8fpt65zq6lpnNe3ZuRw7iVD/ug471XHeWYiEJ50fKE
	AK+y9NkCFHwv0gKQGoiky4jKb+IZ2eS/Zb3UpGpfsj3cwMLQGF6lDuw=
X-Google-Smtp-Source: AGHT+IHR+XOAWuayL0J0548thwTL5vNN/km9VwmcCAbpWlgoxTxZq9SZ2XoemRnY4jNkovDAtrOPYb+nUZ2rZU01heI=
X-Received: by 2002:ac8:5703:0:b0:403:f5b8:2bd2 with SMTP id
 3-20020ac85703000000b00403f5b82bd2mr444300qtw.9.1692613004602; Mon, 21 Aug
 2023 03:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230816131925.2521220-1-mshavit@google.com> <20230816211849.v6.9.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
In-Reply-To: <20230816211849.v6.9.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
From: Michael Shavit <mshavit@google.com>
Date: Mon, 21 Aug 2023 18:16:08 +0800
Message-ID: <CAKHBV274tBz2ydskRfghR2C_u-ibxh9MuEn3dGSaS7tGm8FuTQ@mail.gmail.com>
Subject: Re: [PATCH v6 09/10] iommu/arm-smmu-v3: Skip cd sync if CD table
 isn't active
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
Cc: robin.murphy@arm.com, jean-philippe@linaro.org, jgg@nvidia.com, 
	nicolinc@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 9:20=E2=80=AFPM Michael Shavit <mshavit@google.com>=
 wrote:
>
> This commit explicitly keeps track of whether a CD table is installed in
> an STE so that arm_smmu_sync_cd can skip the sync when unnecessary. This
> was previously achieved through the domain->devices list, but we are
> moving to a model where arm_smmu_sync_cd directly operates on a master
> and the master's CD table instead of a domain.
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> Happy to drop this commit if we don't think it's useful.

Hi Will,
Do you have any recommendations for keeping or dropping this commit in
the end? It's only purpose is to minimize any potential performance
impact from the refactor but can certainly be dropped if you don't
think it's worth the complication.
