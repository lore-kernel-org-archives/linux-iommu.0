Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA436405D4
	for <iommu@lists.linux.dev>; Tue, 14 Nov 2023 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TC/PT26I"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5a7afd45199so66857547b3.0
        for <iommu@lists.linux.dev>; Tue, 14 Nov 2023 06:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699970787; x=1700575587; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2R5VXLdFwq3Yr4sy4ojbP/K5dGOeJnAWKMocChwVIJ8=;
        b=TC/PT26Iooya+szx7YxlrucJx8KYmuaZnQqwOc2NVMvWXbqrJlsljs7JeVIOEkALx/
         famcNz9BQaM4NhHNBcyQGA+CufOCtjvB1yviR1d4/gT4j75zlEZgVAVzNgp8p2jbenAX
         EDrVasRt1jn1QLyo3y45utegJ5gsicqex77pKm0dEmaAsE0209gSqvZM5tUHOrO+3h3e
         a40QU9T3kN+JuUQyl+eZfYCZyssl09uNp0mfRXP637kfc0tNDav/FTdNA7TqT5PgZkHr
         Ec2zUSGxu+6akPK8ysT+fuD8m+XosDKlH71G3UXk/chas0dr24aAJ1B91jFoA4C8Bx2i
         t5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699970787; x=1700575587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2R5VXLdFwq3Yr4sy4ojbP/K5dGOeJnAWKMocChwVIJ8=;
        b=UR2Xg8w9QUOFSAP8WgD9RJhjSW0gCBlbbRiU+jyxff8v+KEBY1U0Thp2M1GPSyoyVf
         vFioM/qN/Vm66OlzLmkkVIeKPlOSmVf7KP1KU0K8QSiGp7ZnlqmMOSNK5V70EFD9RU7c
         vP/1nU+bHN/igAD0qZRnw7jhIdneuWhhghddo5gbC3fkxvFKzCjGSMMo6TvQk6LEaO/z
         I2h8RBDicgYpuOqdjr989DSi+gBt/eBp862cHhai+YpKYSj21pNpRuOFFkL85vwNeHTf
         akQ/MSB98iGtthXr94+oOW5MBMOZEgdsEu1S6hiuafTOjfaEYN+3rK7FnjJK5CTRfDxi
         xNCA==
X-Gm-Message-State: AOJu0Yz5qprLHbpVboOM3U73Nbj/oSB3+tkZNqLwGOSbTu7FFsgCvz0i
	SJwe5Z4b9awKaicKGA9aYljyk1LjnfXRzT6IsKOASg==
X-Google-Smtp-Source: AGHT+IEGp77zVfveIN9Tv1vvBchnTPzGdXtXYANmtfvx4aFfUmUd7u+dIH4PTpunAnvF9bFQWXfZM8eoXOYs6RvC8B4=
X-Received: by 2002:a25:cacc:0:b0:da0:ccd6:b8a2 with SMTP id
 a195-20020a25cacc000000b00da0ccd6b8a2mr11294551ybg.19.1699970787662; Tue, 14
 Nov 2023 06:06:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231114135654.30475-1-quic_bibekkum@quicinc.com>
In-Reply-To: <20231114135654.30475-1-quic_bibekkum@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 14 Nov 2023 16:06:16 +0200
Message-ID: <CAA8EJppjChesDEXqUo5E1tRtjj_WH9NUBHKCyy8-n4YDCj0Yeg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] iommu/arm-smmu: introduction of ACTLR
 implementation for Qualcomm SoCs
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, a39.skl@gmail.com, 
	konrad.dybcio@linaro.org, quic_pkondeti@quicinc.com, quic_molvera@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	qipl.kernel.upstream@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Nov 2023 at 15:57, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> This patch series consists of three parts and covers the following:
>
> 1. Introducing intital set of driver changes to implement ACTLR register
>    for custom prefetcher settings in Qualcomm SoCs.
>
> 2. Adding ACTLR data and implementation operations for SM8550.
>
> 3. Re-enabling context caching for Qualcomm SoCs to retain prefetcher
>    settings during reset and runtime suspend.
>
> Changes in v2 from v1:
>  - Incorporated suggestions on v1 from Dmitry,Konrad,Pratyush.

Which suggestions? This doesn't tell anything.

>  - Added defines for ACTLR values.
>  - Linked sm8550 implementation structure to corresponding
>    compatible string.
>  - Repackaged actlr value set implementation to separate function.
>  - Fixed indentation errors.
>  - Link to v1: https://lore.kernel.org/all/20231103215124.1095-1-quic_bibekkum@quicinc.com/
>
> Changes in v1 from RFC:
>  - Incorporated suggestion form Robin on RFC.
>  - Moved the actlr data table into driver, instead of maintaining
>    it inside soc specific DT and piggybacking on exisiting iommus
>    property (iommu = <SID, MASK, ACTLR>) to set this value during
>    smmu probe.
>  - Link to RFC: //lore.kernel.org/all/a01e7e60-6ead-4a9e-ba90-22a8a6bbd03f@quicinc.com/
>
> Bibek Kumar Patro (3):
>   iommu/arm-smmu: introduction of ACTLR for custom prefetcher settings
>   iommu/arm-smmu: add ACTLR data and support for SM8550
>   iommu/arm-smmu: re-enable context caching in smmu reset operation
>
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 156 ++++++++++++++++++++-
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |   2 +
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      |   5 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |   5 +
>  4 files changed, 159 insertions(+), 9 deletions(-)
>
> --
> 2.17.1
>


-- 
With best wishes
Dmitry
