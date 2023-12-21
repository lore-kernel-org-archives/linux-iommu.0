Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2E1635
	for <iommu@lists.linux.dev>; Thu, 21 Dec 2023 00:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ci8/ORLe"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dbd73cc1e52so239636276.0
        for <iommu@lists.linux.dev>; Wed, 20 Dec 2023 16:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703118499; x=1703723299; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5sMbFiggIUmpWXZnrREwNxuVRfp3qHTdWSSj+2QBgxQ=;
        b=Ci8/ORLeCZ4lgDWfuKFIAlmmbnDC/FohEu3vo36aw/BWbwqAK0DrHvtWvqGjiqLluZ
         bd3KeZ16fv24q54uQDUpDYiv9KwsT6JsW9Oy6wRL93tbtZgZKbmNuUohtW/IyxgMVFLl
         FIoBqit23p99ynVVqM3MSTOWL1oTPUm1RjhlcSS5zbVHGrg+yTrBj5bUMsiWBDRuIuX0
         DwZ4OfTboSD01eVELk/LZ5p2anfOSalfa17uYcIS5OCRPR5Nbi+dkA3EZfphtQU4bLNY
         epwuii+ZJYjWr41DOzxS0PFwxmdle/cKkChyqT8zXhrXe/1G5Hk0+IsWQ2++jD7ijqsz
         /C2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703118499; x=1703723299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sMbFiggIUmpWXZnrREwNxuVRfp3qHTdWSSj+2QBgxQ=;
        b=FHwcfGHdCQs74cyjjZNrYZwxtK1evU7cV5mUoVYW26t8zi1pdYQWXm4mKc8LdYHNFc
         DZEu3ZqgG6Azh1jPgKZ/p8zs9KzIbTE1X7LShOGNglN3MA5faRiGU5LjgQdT5egQ3f3P
         Cu5ajbCwpQfML9mLkUKbYKFlhBemU11ISD18dk52DlTA3M/rfZKG4CKY2NgWQ+I8ekZ0
         Xpa8DhDbmsUO0l7RKDdUVz2ufyZuYI0u1Iz9cmQr1XZc1lDXIyS2lk17MGrzvsyMFvIk
         P7JBSzsAXUBk8TwSs6/ZStN1PJbd0shqOt5o6CHeFK6bNoH/odn2KTSjj7Y67YI8Kx0V
         ROSw==
X-Gm-Message-State: AOJu0YwC43BKeXD4WyzsJRjsduWguS+wi1GrW7FSQzKS4tnAW5xtRXHS
	S1Fc+iGwKbfl1MqOOo+Bpi/qZA1YJEYo3Y1TD9HC6g==
X-Google-Smtp-Source: AGHT+IEXA5o0utbapRU0+vSEAQxdKOvIWZZnqGp+XkTJgxSCokGvW5Qw4aB0oXschndT2a3KehjpQUnEbq8jzosLp4w=
X-Received: by 2002:a25:2d11:0:b0:dbc:e3cf:5763 with SMTP id
 t17-20020a252d11000000b00dbce3cf5763mr552348ybt.57.1703118499654; Wed, 20 Dec
 2023 16:28:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231220133808.5654-1-quic_bibekkum@quicinc.com> <20231220133808.5654-3-quic_bibekkum@quicinc.com>
In-Reply-To: <20231220133808.5654-3-quic_bibekkum@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 21 Dec 2023 02:28:08 +0200
Message-ID: <CAA8EJpoh_jsA6UrH1aEaJ4cufBTKENvG1zqjciy7WSTEh9nmnQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] iommu/arm-smmu: refactor qcom_smmu structure to
 include single pointer
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	konrad.dybcio@linaro.org, jsnitsel@redhat.com, quic_bjorande@quicinc.com, 
	mani@kernel.org, quic_eberman@quicinc.com, robdclark@chromium.org, 
	u.kleine-koenig@pengutronix.de, robh@kernel.org, vladimir.oltean@nxp.com, 
	quic_pkondeti@quicinc.com, quic_molvera@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	qipl.kernel.upstream@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Dec 2023 at 15:38, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> qcom_smmu_match_data is static and constant so refactor qcom_smmu
> to store single pointer to qcom_smmu_match_data instead of
> replicating multiple child members of the same and handle the further
> dereferences in the places that want them.
>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c | 2 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c       | 2 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h       | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
