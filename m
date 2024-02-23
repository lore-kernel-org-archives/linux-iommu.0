Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8B6142649
	for <iommu@lists.linux.dev>; Fri, 23 Feb 2024 21:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723496; cv=none; b=uVqRgNcbGDmo2ZP1pbikkZQK78FGOEN6n9s4v/POqrIpzapVYC3Lsqopcx26SJnpnA66E3s28VkCpIrnuf1PWj0VhUNZrZdFkVe1VftNqZCeDai4SVs3YzbNeJL1COWWaxYEvMed1N5o0R6Tx8BpXgQwHp34WPWx0MacZeltQG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723496; c=relaxed/simple;
	bh=FvyHoKuJyRa2YSuYvwYb58L/t6J6cqmjt53b8ta4lpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7V3S9p3pDtXevKnRoZu9hJXgDvskwhuFPhE6y58CpYd78aaHPHNoxVO6T+PZD17jNikEchpmFenvPR3eN05wjxzRecZI1EkDkm4ZaAqrbIXp4FcXwOJBgrM6BP4rDypBSQcbgsU508hkLoBHNvXFbwIdWIQ7KR1JM/eBOncgHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xY4VjiOb; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xY4VjiOb"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso616842276.1
        for <iommu@lists.linux.dev>; Fri, 23 Feb 2024 13:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708723493; x=1709328293; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wgdv/OJ7jeihH3J71yo7/tj9HKsPe0FnbUozf7yDTNQ=;
        b=xY4VjiObRlhcV2DIjsNB4mb/lp4siuqfG4NdvaDEwKF6GfYZboDkXRx9rZWshG8GfV
         AA7JYlD1t/uJgpsi3oc8cZIFhSRgzuf1MqWZEAwQihpYvCYMremgzpLo6ncCGlnD8/mY
         hO/5r5zGvFR4S+++ssUhUcg3UZa9iY4cqE2HtCsbQwGfBcMkIRH6DDDiaWAT/dB2cfld
         /UUxlUhFE1b6yPCX+3yWQm5cV1q46RflT7xAriyRoqi4g1WokplBcfMdwYdtohRn1ASN
         ChbpntK7/B8el6T7E4n+YmrO+k6x02Ymd7GDp+PFKP1dOAkybISCIsbY5Moos1Vv67Js
         MYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708723493; x=1709328293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgdv/OJ7jeihH3J71yo7/tj9HKsPe0FnbUozf7yDTNQ=;
        b=Ce4JRWva5jKJF4sEb/nnjW3BhI90KJto67PLJ84UlC+DRWBkXyV0LTfmGJE5Tt8yyo
         fynqjyKqXaPJyVbY2ByEjqW5Id0qf/0cCL13A1hCoO4wbdGHNp3IUWtmlCcAKP1XzCg7
         3KYyNRf5K+v9YCsmwz7wCv2SIgv5r5CnJtOcAj9/SK1ZIQAlpkAxjD/5MX6cnar8BsPn
         chLFZWbni4wmakDl4eBbCa6MQcZ6FJ7Uk5XmOxBRIMERzAHhet/0rde4P4Jo+laCpw6x
         jwz8wbwXGG35zmO32rbkrAWyVn2wXX8BazsQj6CGSx7iNdED24bIXAfahQucFGcFKgz0
         ytzg==
X-Forwarded-Encrypted: i=1; AJvYcCWBdK1f3tFOogmAkSPIm3z0FGx67fGTfRNLiO1T5S50IKf/jc00knO4WTndyevijaLZxzkHnvAXJxjhJ0vqi3zMfXPpJeM=
X-Gm-Message-State: AOJu0YxtFMUDRauAHrynpOF4IdFyyzG6QO1z3shsSqFydMvZGv4KPMRK
	zLvmSgo8PZxzhJ0UmnQmGEHrBzbkIXiz5wiBSaR8BAWuzyaaZzYQTG03skwr8Jv8SrUOB4ij4oM
	lLou3xdOzZK21o9Xuck+IEVfV/5mXRxPhHPOT2g==
X-Google-Smtp-Source: AGHT+IFMmUBgDbCE2Q2G9lsAmZpvVhtEQwvP+lU1HPMuQilfEiaGC1y+Wv7lhCQH4132jTFroLi4zQTtEiwxKXXZKTw=
X-Received: by 2002:a25:3082:0:b0:dc6:c2b2:c039 with SMTP id
 w124-20020a253082000000b00dc6c2b2c039mr998519ybw.41.1708723493452; Fri, 23
 Feb 2024 13:24:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240219-topic-rb1_gpu-v2-0-2d3d6a0db040@linaro.org> <20240219-topic-rb1_gpu-v2-4-2d3d6a0db040@linaro.org>
In-Reply-To: <20240219-topic-rb1_gpu-v2-4-2d3d6a0db040@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 23 Feb 2024 23:24:42 +0200
Message-ID: <CAA8EJpqnAoCDer93V34BaFHf5mhiNOFMQTP1Xaeoio0BWaPzhA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] drm/msm/adreno: Add missing defines for A702
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 23:21, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Add some defines required for A702. Can be substituted with a header
> sync after merging mesa!27665 [1].
>
> [1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/27665
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx.xml.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
