Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DFA54F86
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 22:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708380990; cv=none; b=afv9cTvo89LuNCSMPTSZAjKAkQNz8NvoRzdZGDk6A1jsBKjhDlXb9v5P0fVBJKUphm0zNv4wkbAp3Q+hh/dARwaic8avZXRlp2oBEomlhAgF00bN8vACLnldOXyCTwrixhWHFlZ327/KSQJezS07FAx7T1LLxDImkIJ7jWJcnv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708380990; c=relaxed/simple;
	bh=zSVu9prVWtzcMIX8nr93vi35ZuujWLtnr1gGDj9Uwf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uok5+CfuajVWq0iKZoiccvC6+jtI12SdAAUJRTEvHEk1TgXQfrONFRYFYjvgioac5RP5pqtzPRD5uYWN/HypySUaL5wO5+i2FXwu6bG+yY3GjTeNpweaTb5ltfyuYOUHvJxhkzpS1eLp21zLl3Sq5L//oTdm39BiHSeXs1JZZ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kKA2ntbk; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kKA2ntbk"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-607f8482b88so32503887b3.0
        for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 14:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708380987; x=1708985787; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vuTySsKzEO2OmI0ErX6jaDfKcwaUj4TjQngL5AX3Egg=;
        b=kKA2ntbkOU760xf8csJqgNCeTR6tMiXXe2N3NGWdbgE3OO8BXWid6oUOis061zutoC
         l5xVgUGPm3KOXdGEMJxmYyduCIeHp2r5uV2XFdQQoeNNSYsJQs3iHfODNkO1NtkKmmRk
         gNW9ZRSO4brK89ItV/pv8klbRaw9rtayEoMeKxaYqR43wcjoZ6CLv+iKnWqpVdRPyG5s
         WnrCFOQRQFlcMplQWX3GbhjUnsMJXXx54YOgKApSdXbIen+HP1oa9/+8/bg64UP2v16g
         jEyX6czi2Lf92XNT+r6NzSXCnm+wIQO5aElmEYpO8nOXedR+cYwLjCSwrhTRvR6SIy15
         QXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708380987; x=1708985787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vuTySsKzEO2OmI0ErX6jaDfKcwaUj4TjQngL5AX3Egg=;
        b=O7ITFakeEtiFfPKvBoLnwmaGVPSADiW5PPhpPdZbZdWfLaPkLc9I18bWubrKv/5VN1
         4TfsRR19BoYNAVt1Jkb7LlamqFOqV/a3GJjCKb3VgTKS1QJ3fwNJUwlbGWNFrC0KTM/D
         doS2AQvCgubcBE0QvhybE1juSVRE9ewKT9rZHAnpPA8TCiMTnZRl8XraugBc+RFKKzjI
         TPPrks1KE8YIxIEfFZzljDIfZKPKiHwcjZuAYMhxMhI1apvVsz1E9EZx65Teo7aunnE+
         pxSRiHFoaSRb9T13BEIqcNRRqAUFANcoIjcqc6RJ4Xx6OwOtU6dIA4PTS6YJ8rS9Y6cY
         I37Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVQZtDomnm2zPmYxQMKxocUqaMO9lp64KjstLCKVRylCnxm/lc4z6p0FAKfcaCEsqXdp12fa/xfQ/sxu/3VNcPwM7pc4s=
X-Gm-Message-State: AOJu0Yz06CW59vnBUNkmWsAogUgJlEWUi4aJuuVU1QxOAY0Uz4stIaxM
	ealnBbgSBB+c6Z5cV3FAepCHMSZ58sV1VKiu7lu1NODEgGSL1V348FGHQs2eK7w6iusuyjcywOJ
	NHzmZjkD7i08YLh6oJGorr4VPOkG6g2FqjC4SvQ==
X-Google-Smtp-Source: AGHT+IH0q4G0NXDEX6RVYpZcdEntLJmn3kJY/UlQlPbUsZWH3aZT8Y8yzl3n5AhYDOYefhK8BUnY9HP1u6mwOkNWfWE=
X-Received: by 2002:a81:431f:0:b0:608:e2f:e3d2 with SMTP id
 q31-20020a81431f000000b006080e2fe3d2mr6514646ywa.22.1708380987231; Mon, 19
 Feb 2024 14:16:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org>
 <20240219-topic-rb1_gpu-v1-8-d260fa854707@linaro.org> <CAA8EJppPvXfkz=wVca8aFBhFaVUe9+OiVzcQUq7D8zPbK+T1FQ@mail.gmail.com>
 <b73e329a-02a4-46e0-bda4-5d5fae0a1180@linaro.org>
In-Reply-To: <b73e329a-02a4-46e0-bda4-5d5fae0a1180@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 20 Feb 2024 00:16:16 +0200
Message-ID: <CAA8EJpqxYdjKx54Oph3=+H-42+cKpw=t=5GGJq54FVcOa26TDQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] arm64: dts: qcom: qrb2210-rb1: Enable the GPU
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

On Mon, 19 Feb 2024 at 23:37, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 19.02.2024 15:49, Dmitry Baryshkov wrote:
> > On Mon, 19 Feb 2024 at 15:36, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>
> >> Enable the A702 GPU (also marketed as "3D accelerator by qcom [1], lol).
> >
> > Is it not?
>
> Sure, every electronic device is also a heater, I suppose.. I found
> this wording extremely funny though

3D accelerator is a bit outdated term, but it's still valid. Well,
unless using A702 makes 3D applications run slower than when using
llvmpipe.

> >> [1] https://docs.qualcomm.com/bundle/publicresource/87-61720-1_REV_A_QUALCOMM_ROBOTICS_RB1_PLATFORM__QUALCOMM_QRB2210__PRODUCT_BRIEF.pdf
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >
> > With the exception of the commit message:
>
> :(
>
> Konrad
>
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> >> ---
> >>  arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >
> >



-- 
With best wishes
Dmitry
