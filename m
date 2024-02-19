Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E0337704
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354487; cv=none; b=JE34eJxmuCfbII3uMmT6YST5z5oKUpGzo6WTeoAKB8B+uwf0dWLLe5Pb4lrEygZI8J98BlxgNqQwKZR7h1aJOyznq7AjG6y886Ewdgvlp9e51cHMivHbXD/UjbwrX2VOAKT3KD5JghE3/3dgMrYNl2oI1d4Pvq+Dcunl49w+GnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354487; c=relaxed/simple;
	bh=rIE0IP0T9iSOPWSlThQHOn9NtZrcV1Ogn8zpUtpc8js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlWWkyE42sD1v/LrhHlSpXhCT9lTH73ZlIXSee35bgZDu8aQ3T7BrJdd9uRxLe3PvOWhMa1iVOpYB30BcTcGofWn7U0gbEvEVlMCx7QY6gx31t4tZIqm1sbqAjlK+V2vGbE3O1akedmNlxroIxgp40wkYn85oCKKGM+Rn/3x8vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DKxqciAy; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DKxqciAy"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-603fd31f5c2so45475567b3.0
        for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 06:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708354484; x=1708959284; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/+Vf6X891RpEKNXrdBrteASyRB3a3/HliSNBQV8d1lo=;
        b=DKxqciAysQe+H+cJR7vqWrP38Oh+Xya199dUz8sAHxoSJ/RVhZIfuflKfcOEw4hD3Y
         kYoaGTfoOmK/pdLruOOgtPPdSrm3Bsdeqtx10wlr0+MRt8U86pfVASRGzPUZUBgdfqWe
         NRxg/+Jc10MVGHsW/WvYnDVn1N+q7l3OBldrCX+Gsuo5JKhDZEksq9ZhyK+TL+hc/1Zf
         DmEW+ByhJTDyQCDaZ2MEKet/YbWh2vDEk0v9cxiEYxVPyfggzSAuDin2gn14mz6fyYRD
         MK9mZ7zRxmdG4E9e6PAeggi1RuDGOoPGMVPUT5Mx6nPFGP/V5QCXgoe2YhtJFhUfey/r
         ghGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708354484; x=1708959284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+Vf6X891RpEKNXrdBrteASyRB3a3/HliSNBQV8d1lo=;
        b=WYdf3IzUNe9CPmiKdr8sofhQgpHibOxx3ff9hfzkZmYnWs6jX7cSupLtnKwXQz0IpQ
         esKsryyvl7pyFE3i4aGIR9BVCQO4hVC8bth7/ZMAqo6kJJYFCITFDWe4rqzG4Sfw4EeM
         xgTRno2j3j3b9H4Bv7//+BFcxLZfcqNMHre3sKySgLd+ymkSqkIo+xCEcaEGXDokqUQa
         o2RTL4b8A8l+VuscID0jloGsd59Z/PPdxtRywRwwdNrCbUzLgnF+E4TECXhkLrIpQWns
         pRNdKVukvvwhxn6qGn8gKWGWz9vn8igB0bggLqXMiXfs+wVJb0DRy0EAiSZpgR5JCdAS
         vt5w==
X-Forwarded-Encrypted: i=1; AJvYcCXCLi0OI+mXf1xBxNZTux+sVvPiddfJ9ilslp2QSEeodBGGXaKim2rh9EQQh7388oH5iusyNsVWzpLsYWKDYPXmbcv1OsQ=
X-Gm-Message-State: AOJu0YyXnBADIYfpKeCBqkfll4YWcwtyNi98yqtCaHHBqS7bxXglb4Eg
	9M9q4img+dmxVoNKHGsdfvW1pRLusefq7hgFYNfpTejpQlfAS0Unzd1cIoz+/r4y79aJxHursQO
	XdfYhRCAWbDom5R0a84YV9au2g2F05o616+mHQQ==
X-Google-Smtp-Source: AGHT+IHg7XEOTTrtpgQqphtP3Xw9sPuPWwJbqow3gZN5qRELJzU++tbN2bRulnySBEDH7nL4PxT+8aS1knEIIJLBbCc=
X-Received: by 2002:a81:a185:0:b0:608:59a5:4ad1 with SMTP id
 y127-20020a81a185000000b0060859a54ad1mr39629ywg.22.1708354483969; Mon, 19 Feb
 2024 06:54:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org> <20240219-topic-rb1_gpu-v1-4-d260fa854707@linaro.org>
In-Reply-To: <20240219-topic-rb1_gpu-v1-4-d260fa854707@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 19 Feb 2024 16:54:33 +0200
Message-ID: <CAA8EJpq46Wn+gWKL81_zMxyddUpJRuKHDrx=4Q2DvbwufmWHWA@mail.gmail.com>
Subject: Re: [PATCH 4/8] clk: qcom: Add QCM2290 GPU clock controller driver
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

On Mon, 19 Feb 2024 at 15:36, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Add a driver for the GPU clock controller block found on the QCM2290 SoC.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/clk/qcom/Kconfig         |   9 +
>  drivers/clk/qcom/Makefile        |   1 +
>  drivers/clk/qcom/gpucc-qcm2290.c | 423 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 433 insertions(+)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
