Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C59149382
	for <iommu@lists.linux.dev>; Fri, 23 Feb 2024 21:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723474; cv=none; b=cnSm2fY5XuMHvnZiOy9LCokM59yiJA5dtm/g1P1E+Y3EMNPLDAnAd+UMscqe2vri1yQ4oJ3vHDOxYWNtMldBgeLBC6jsLmemVtMehzQ1vgTIyOjcLwUWx6IMDPVvz2v2l6ydnlUyETn0SxEH6HXWOPZK+XMXF0/WjHDrzFS4YNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723474; c=relaxed/simple;
	bh=H/tJhqv8w47L674SEcvyX50L+C3QiQZtQ8jkIBC/B54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+KUWtZzVaxiIdXOS2fN5TCTeKrelMmZ1/086jppL56oUauiPaWICezw+KRm8pY3xFVGF4+hM2cszgLJzaNH2QpE9F6wdXsRHOBP/ujKJUOVa9VrQRyVzT+nYQSkDHEg6X282otrqNqs0XdomeoGH1bX3DFp+FFmtUGlzRCzjjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zvy1eCGY; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zvy1eCGY"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so1264299276.1
        for <iommu@lists.linux.dev>; Fri, 23 Feb 2024 13:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708723471; x=1709328271; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=akuPkkgI0y/oHinOKr0HxoZmwUf171P0m6vGM5/O5Js=;
        b=zvy1eCGYHnAyJQoP1qy28qHS7rlZkwG6ZYXl4HwIQRUfHp7tfIGFPtUf8vnN0TcB4P
         fUsPTkEejQhIUc/fUS6rjevqxST7mOiI+KnzLq/S/QSjJjamMSBYAzrOzPBX/0x9o2kx
         f8xjfgVPv5AhRe5beVMLbWGiF2tlV2A5vNtVRWa4XL2c3gXU/p7bb5EfK1ZgsRnfGdpi
         Yu1Nq45COANVoEmRucLnGgnYkYRxFYWhEjqdkhVv/ybMaKj3WE1tDHLoeczJJyksd16J
         oA2/1xZf3ficCQ9qBhRuVWNcCuI6oeUIFyIDjioBWRy2DGR0O0dpMkrIff1AUjzxMp5Y
         uVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708723471; x=1709328271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akuPkkgI0y/oHinOKr0HxoZmwUf171P0m6vGM5/O5Js=;
        b=ACV3q/vRqw+/h3NEycjcZJB8mHw+xUfKy/Hck/6QEX932qA/s0KVzJWLTtu39uuPBv
         /gGTFIQlarA+4LThscjm17QvGCltg/5IRt5VDHwFvYvzZ0ER8iuSul0m2RHCAU06r8oh
         VGdV6apOCXZWO4RRs8vBo7ichj9SCzNf0kgdMyRwnmpWEMOtQSrfB+bzX02R55xdLovv
         vDgsZXVt9ywpJEfV42UYvueARIutEZAWZKu06lOSPS+J7hTL9xhszKuGJX+/2NtaRKiW
         0mY6DXrUNq1LvZAqNRyBY3OcDiZwvHAX4oyY44Xeu6oLFYsGcHq8Dsoio00PebEJZPRi
         AFYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVugO4BHDokblY8FHP7E27z8YZT/5rKOx3tUl/Ih+NgeaevquWJBILtGQhlGmAOcmHWKj2RzSsmS4sM4yh+/tmgflLGDt4=
X-Gm-Message-State: AOJu0YzDutlbSxzxyRZS2mniayEVHzkFl8/ykaWtghxzA9gWpSH0LVEP
	9/MSuj2xN15wlSEwzMI01fFtnCFqDKv7hknsxgb67bA5tnfA2Mv4PGiMHPR838hqlUpCWtXVIah
	nWfMBz2D4hid0kHx8+RhmDMgISjh+Zue9ok1Bpw==
X-Google-Smtp-Source: AGHT+IFbG9R3qzPDyULutJwOdT2KkYVwoLnuTNnZQAQUOT10IOJuFq9jx8p8pvPNgR7Ok5iVzV0j+sTC9nwDRCxlZ88=
X-Received: by 2002:a25:c511:0:b0:db9:9537:2c39 with SMTP id
 v17-20020a25c511000000b00db995372c39mr1121626ybe.2.1708723471023; Fri, 23 Feb
 2024 13:24:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240219-topic-rb1_gpu-v2-0-2d3d6a0db040@linaro.org> <20240219-topic-rb1_gpu-v2-2-2d3d6a0db040@linaro.org>
In-Reply-To: <20240219-topic-rb1_gpu-v2-2-2d3d6a0db040@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 23 Feb 2024 23:24:19 +0200
Message-ID: <CAA8EJprR=tPUsFit7DEzh0U9TDOm8TY29m=JVJwXQwH6vEN49A@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] clk: qcom: clk-alpha-pll: Add HUAYRA_2290 support
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
> Commit 134b55b7e19f ("clk: qcom: support Huayra type Alpha PLL")
> introduced an entry to the alpha offsets array, but diving into QCM2290
> downstream and some documentation, it turned out that the name Huayra
> apparently has been used quite liberally across many chips, even with
> noticeably different hardware.
>
> Introduce another set of offsets and a new configure function for the
> Huayra PLL found on QCM2290. This is required e.g. for the consumers
> of GPUCC_PLL0 to properly start.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/clk/qcom/clk-alpha-pll.c | 47 ++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/qcom/clk-alpha-pll.h |  3 +++
>  2 files changed, 50 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
