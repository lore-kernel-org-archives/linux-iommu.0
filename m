Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5982D20329
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475999; cv=none; b=odQqKuOnE/PPphcNuqGDHSMm8BG5qrU8a0kaJs0RGnQ1wPC0HqkEJPdSmeIFv7Rsu2T767nePfaWqKmRdsZXsNFo0bJ+FhrEkdjI/Hszcok5U1nom/q/4i6dadZizqAfwObQF9vtmjxVam+QICOQzKEfr5X0M2QD0EKe7K0DucU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475999; c=relaxed/simple;
	bh=bBVodIkFUuf5TjuHA1UbbrCx/ebybTBO+Q6c/7GdpAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctmjHjZ3eaKmyA7dXpS/c5xDbt0a73eRMPr/IJregEDSQxW60wkYDg69KQXSc3D0w7WcZ3/rHEYnWma17YN4kS0KWbyu7tzTF1p4HodcwXs8dCohmo4vk6ccL9RYHjWR/LhYb52OQk0XXmBub8yQo2r7Gexndl6erSGj5cTywH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NYg06Epm; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NYg06Epm"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60498c31743so8116987b3.3
        for <iommu@lists.linux.dev>; Fri, 09 Feb 2024 02:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707475997; x=1708080797; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4t5G9ULgip1omppIrMSWBh824NopQFVbRmAIJheoN6k=;
        b=NYg06EpmtNTiAPBzptO75sQy74qFlhmHCl2uYtwp9mDXRkHABE7cx9J00Xz3gCzzyq
         ug83hnyaJIJJ8MYIdLi5KUrf+qqB6H8OlVL+MQbNkHf8rV+LVgVXkLuXpfRhpQb0Esax
         u3vu3+ntVouHiXC2povckjx6vlAt/rf/AlAAO/cwcGARJGmKni5YFVDyvhWV2ysm+ZvX
         VSPsEa7aQp60iDAyhhT5F8+hgvW+LAIMYoGHW4ODxd71Jb8F85QKjNW9dq5SEHy1MeQg
         2KAD5xK2ZEjCUeI6TuPQDzcgpbVN2jHVmOy5o5mbg8tuq2FJIWEHxreOM38FO2+JFdiz
         pHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707475997; x=1708080797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4t5G9ULgip1omppIrMSWBh824NopQFVbRmAIJheoN6k=;
        b=utKeXusjNb7yts0GspOh0PKiLI1WByZ+uZSdA2Kd8cGkrpvFTMhStv9Y6RoPvcMfLr
         tMLuuTbaxfCqbtwHkFwSnpmyJaX8UeJEhyMdUE/nG9DfP4R5aPdkJMNbhQX0V4EB8ca6
         DaU/DtrmT9xGS503jV8ojnNfdRSlt9pgh1xML8BspY8ameInVG1024S6ZhgloOhfv93d
         /a1kk7+6OdZo71iVhnIFym59P7rckWZ+5PtM78/CAmsUJNS8cPDXlY/PeaHciJBCezQQ
         B24LsUahOyDwL55QGehduLixNcFoho34bqiXvLF1qgwOS6xX/mt6Q3i90tnHbTfakEzC
         dXHA==
X-Gm-Message-State: AOJu0YxzZAwyIEOS1EXZLMLt64iEeS5rfqYIh9epkqOi9FNxSLbhT6Uv
	D8ceB+kQtiRhKCa1iWqEo91rafz1hF+RU2frbHckKt8GYxvOzNeL6pGoyObNK22KDm/IM/v53DU
	ARKLENGaJ7UMrsHqtSgZbESwDw3hj6nVovTu5Ug==
X-Google-Smtp-Source: AGHT+IEYr40Xins1Ugu9N2EC470IZHXfOwEHL+myb8RBHaNgBLYJY6StP1BZSABiyzCT43QOSlagmJhV9ZKbAkqTMZE=
X-Received: by 2002:a81:4a42:0:b0:5ff:d871:b4d with SMTP id
 x63-20020a814a42000000b005ffd8710b4dmr925660ywa.44.1707475997376; Fri, 09 Feb
 2024 02:53:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240123144543.9405-1-quic_bibekkum@quicinc.com> <20240123144543.9405-4-quic_bibekkum@quicinc.com>
In-Reply-To: <20240123144543.9405-4-quic_bibekkum@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 9 Feb 2024 12:53:10 +0200
Message-ID: <CAA8EJpr3S1hGSjeBx+vhZZHq0OpyULCmyxasUzF6RGdTvXEBSg@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	konrad.dybcio@linaro.org, jsnitsel@redhat.com, quic_bjorande@quicinc.com, 
	mani@kernel.org, quic_eberman@quicinc.com, robdclark@chromium.org, 
	u.kleine-koenig@pengutronix.de, robh@kernel.org, vladimir.oltean@nxp.com, 
	quic_pkondeti@quicinc.com, quic_molvera@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 16:46, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> Currently in Qualcomm  SoCs the default prefetch is set to 1 which allows
> the TLB to fetch just the next page table. MMU-500 features ACTLR
> register which is implementation defined and is used for Qualcomm SoCs
> to have a custom prefetch setting enabling TLB to prefetch the next set
> of page tables accordingly allowing for faster translations.
>
> ACTLR value is unique for each SMR (Stream matching register) and stored
> in a pre-populated table. This value is set to the register during
> context bank initialisation.
>
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 61 ++++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h | 16 +++++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      |  5 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |  5 ++
>  4 files changed, 84 insertions(+), 3 deletions(-)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
