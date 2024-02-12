Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1293A8D2
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744746; cv=none; b=X4w24AfmtxRQDjmTfLI431TrKhEG9Q8tb70Y+KQjskDo9jN3HL+B1Fw7U4A8DBXpbyMOGeHLrWAgqPYmyK/7BHKBwmQ18K7E29s4pzlP2v0o/pvpqxxgqn4b3oKcQNZahkygpoelrvCbFnTID98eE8p/YwgjHpJIH6nvgdmxKGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744746; c=relaxed/simple;
	bh=mgxzYa/YHbjlNLGRFv1voK9063RzidnEcbp86ft+y0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsQ4+CvgRU3r+FYE0mH2fNEK5VYihXpa2AAboliEIzVox2wF8xzDWXmYFjLtykdFhOfoKf1xCXC8P+6I9YEx4eGCuV2kYjsqmTvtNpuwWlax2R8s26HrH3BsFK03MgW2Mv0/2nX0eYhoPPDo/A7u8m3xep1znHNOQ//zfAKHr/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yLvqP3ZG; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yLvqP3ZG"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc75c2c3574so1983406276.0
        for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 05:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707744743; x=1708349543; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cc0i1kM3GFsjytyQWwKzSBYGY5dJXRRO6XelaSiPAvw=;
        b=yLvqP3ZGobZ8vCgnaDW4wz4OweAOWca7jo9COmZszRP8ZDg2tKHVTrqNiVZMr1sJ1u
         DNMwgiVch+7R2KhCF3NrkFnumLZfHz8Ge9p0lABd9WHwB8gDYKGkJaFAx86na81b9J7h
         cG3aYnUGLepcv4lhJ/JSJasWezFNDn41lzWdhBJflDMIMHfyvAx4tMcTX8zVq8btOS7v
         IJ6w/AXnNaUFB35VHYo5GVmsTqIryQjV/umxrM93y4b1a2ZJIoidJIVdcIBI3HTiji/M
         bBEHtBNMGI+kLxCEPZuHJInvI3ou4Nr+U/y2z8PUyOIMGQ12iolePEqTbaDFmfkedTk2
         K6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707744743; x=1708349543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cc0i1kM3GFsjytyQWwKzSBYGY5dJXRRO6XelaSiPAvw=;
        b=Sr2WrjXB5TMVXa00QIhyiKrfEpObB+G9zvb9DDbQSj4ZNz2uHjRKEulyAfTPzF0qbW
         NK3YrrN2qj+NPTEd6QhfOheK7XZktDQs/HlBnBZGQpyptayXSyJTBw4gyeF9kXaKvgmV
         7009tPgZYb3RdstUomfRkS46E/LATm8/8BjH21roDhB3BXYzp931wbRaWvbng28EjDQ3
         rjDRblZrknK3KpJUvRpu0WAAE7kTCT5y773baaAt47jCKhzkqcvbajCLt6umiDRmk/PM
         jSfqlli0b0RleA4qvRUW2gXbNzavNX45qgRBaRncCYk4K1j7WfX/iQ0HPAV6GoBEB2Q+
         AKPA==
X-Forwarded-Encrypted: i=1; AJvYcCU4O80WHKDUrK3uV+3962UyIw80eR/cKJIqWzhZwlPjRHzVf23bdcJfiE3NKuwD6AHadDbJJ6q8MT90EM+aaonhlYDDGXk=
X-Gm-Message-State: AOJu0YzWaWQMAn/8miasVquEh1qewSK7LTumTB1r6BCuIjz5vHxq+dUd
	OH195VWsyMaEUxCO/DAVTWUDe7h0VZrF/dQo7ErfpbENuEgxoU3SReKVjhdC4IVzoditYfRknB4
	wWTUQkCM/pNskuRy04dXaASRR734NsxvBvfz3bA==
X-Google-Smtp-Source: AGHT+IHrimlujObx0gy/3DfQFabszO/ewn4clRRIqfcAPZot0WCgYdNU8XudKJCEXiqOZqbCse/xPRfzJJEpg6oz5Yc=
X-Received: by 2002:a25:b117:0:b0:dc7:4439:d14d with SMTP id
 g23-20020a25b117000000b00dc74439d14dmr5093350ybj.54.1707744743273; Mon, 12
 Feb 2024 05:32:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240212-topic-sm8650-gpu-v1-0-708a40b747b5@linaro.org> <20240212-topic-sm8650-gpu-v1-5-708a40b747b5@linaro.org>
In-Reply-To: <20240212-topic-sm8650-gpu-v1-5-708a40b747b5@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 12 Feb 2024 15:32:12 +0200
Message-ID: <CAA8EJpryCXUxs69ockt0TN4LOuBB-4dZkLYHUZyN1Uq0isMjYg@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sm8650-qrd: enable GPU
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 12:37, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Add path of the GPU firmware for the SM8650-QRD board
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> index 8515498553bf..7151f3dc67c4 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
> @@ -525,6 +525,14 @@ &ipa {
>         status = "okay";
>  };
>
> +&gpu {
> +       status = "okay";
> +
> +       zap-shader {
> +               firmware-name = "qcom/sm8650/gen70900_zap.mbn";

But why? For sm8450 / sm8550 we had "a730_zap.mbn" and "a740_zap.mbn"

> +       };
> +};
> +
>  &mdss {
>         status = "okay";
>  };
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
