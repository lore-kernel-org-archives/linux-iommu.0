Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754CD381A4
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354168; cv=none; b=KUQd3Rq5njr83dDyevH9enC9am47gbuEi0w3cOJTr5I3Tez34/3WDZamLuR8omDK8SZXZTKHFilW0rxVFPVYUYAbLb5jqFCIW7rJFHcOF49nw7W6QWwx3BtqkXdJJcR9lyKKR2wQrXIrIPG4UjktC5L9WzK5HsHyqw4fGFw42W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354168; c=relaxed/simple;
	bh=cXd+iZRHyG6Z54ZlDyEkvwRUedt1tgiayxTf/h55RT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJXaQ+fiWnZ7bWJ2KgZEVtfE1V8/qHzDzlUKzBVEIH9WRXmfLqMrffvrPnj0OTUJ+A4lqYbPBvZBMV/mkXjkfkzUzAM61WwpL5+WnrFGj5aOwQ0L6IARpVHWlfz59e9Q4TqGmQN40s9h3acKrhITiyO/zeQjufFVeO4VWful+eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ne2+FYkC; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ne2+FYkC"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60837b7a8ddso10742997b3.3
        for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 06:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708354164; x=1708958964; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WJI1teD2wPawZOQzTgWhX+w1Ti/ZVP+Yv2CET7JvPGw=;
        b=Ne2+FYkC0juiZtSRI0EQGFYUpvpwFFd/j0XiJEXAfFBppHEn8jy09rHhMcNgY/rkf3
         M64LAY17ZmJjSz1vFcuMHK8DVLrjfUaDWHysI6dBw1k71DftylJqQo0RPKiLn4F2DNHL
         rKvTo67rqUUwGk1ev3YTe8+mHADMQAEuxoYyRAGicFWDYPpDTbl4vZ5GZb1AmlBSmAcU
         S58PwqkghMEOXP4Oz/F8W7kkttpcgMnOqhHf1EMO3gHJyWthzMvKcG9ac/HbAg+b/yqp
         Pj8/SCk0XYpndn8g2dZaGVwdG9As85WerUY8Bw1AFFii98Y5QZYDjvSUGQK49CplC8MC
         FFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708354164; x=1708958964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJI1teD2wPawZOQzTgWhX+w1Ti/ZVP+Yv2CET7JvPGw=;
        b=Jpz30el9dSJjm8DEBuIrPQnFNNTbtNL2GgeDPKI8bgGW4lDVshGPoXvNyyH6j2Qi40
         Y7v8GQtz4SkDtqsNYKlfmRrOgUT4La5+wyoAa3k3JSz1cf3/p2c2hucR2nWgF0+8HZak
         Qk2DApqIxRdmQghJbvZok/lrfpatlMZIkZQnEBM/AtdHvjbQ5eOY3+KSCVH4+CYOSptO
         BJX4vjahuOxOp6+kWlupPdyqaj97GYsFBLYa5vTvfTrSc+m0ZZ2GIf/Nn/CO5OuSX+pC
         eHyUFx6lZW11SHk3VvBSjMXK2EEvFUCGOgF/KWUdJSeNuj5DtfskuGjaQMS9wQ7Hr8rK
         Eq+A==
X-Forwarded-Encrypted: i=1; AJvYcCV+te5RGz0fwSpodCJonhegq3jO3eoXnSNwnkmv2l/6cHs/Inu+sU+3QI2l55UZ42K0Lnif+n19tBaL2qsP5IzFC7QeL2I=
X-Gm-Message-State: AOJu0YzhtsMtOHXtOmmIvHd9s9WTY5jsIRpxXHbB6NM0D/Sb6nEYNyW4
	HroFirH588Oc8CjkcX3N8icSvnO0tQiVRg+Hb30VQZUNfdspBdOwhDfsnBmgDIFJDAuc97ASdbf
	rrhSUL6TqYWDSyUFQC+4ybmw/u5kiAlDJIFmQUg==
X-Google-Smtp-Source: AGHT+IHr/IUKFhapXnOD7toFxlQf0Om4NTc3bUIZPM42rFzdOhQ5udZqS0lilrwVoRYH1x47luPm3EintARWerYH8fE=
X-Received: by 2002:a81:ad1d:0:b0:604:a47e:6e52 with SMTP id
 l29-20020a81ad1d000000b00604a47e6e52mr12358877ywh.32.1708354164616; Mon, 19
 Feb 2024 06:49:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org> <20240219-topic-rb1_gpu-v1-8-d260fa854707@linaro.org>
In-Reply-To: <20240219-topic-rb1_gpu-v1-8-d260fa854707@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 19 Feb 2024 16:49:13 +0200
Message-ID: <CAA8EJppPvXfkz=wVca8aFBhFaVUe9+OiVzcQUq7D8zPbK+T1FQ@mail.gmail.com>
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

On Mon, 19 Feb 2024 at 15:36, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Enable the A702 GPU (also marketed as "3D accelerator by qcom [1], lol).

Is it not?

>
> [1] https://docs.qualcomm.com/bundle/publicresource/87-61720-1_REV_A_QUALCOMM_ROBOTICS_RB1_PLATFORM__QUALCOMM_QRB2210__PRODUCT_BRIEF.pdf
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

With the exception of the commit message:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)


-- 
With best wishes
Dmitry
