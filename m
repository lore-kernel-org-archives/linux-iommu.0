Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C45537700
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354657; cv=none; b=ktuyakCWkYkiOz6tWRPDb6gCltwUCTYJpRczKYhvGdDV55p9bSjeEEImIj3j5ca8DE4aTdUurEyvUnIiIqX5aKQEXOeSu+hnMu8AmpAbs4HIc5G6qpGYBm+liRUyvO/bv4zQpsmYVc1jvLU9ZDWkOvtJ20FYFceORJIihLqquFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354657; c=relaxed/simple;
	bh=9Na3wL8jpMpPVnEcaEj/4baqNdNNRN6TgavHTXFRdNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLzfLzuxcW1FUR0R/NCvef5LnWu6qSYSqHj01tFjZdTqrwK3boWVKP4m6D3U11u5iSzXjxlCs6ex2UQUXa5cKPqkgburKCZK5VV6RO13SnFdYrQ1snRQEU3zNeSbgDKp2bgLycm2ITrj8ewVM4Bhs9id+bmdaq2l+bC7h6jgVO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZlllJO/G; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZlllJO/G"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60822b444c9so8071087b3.2
        for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 06:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708354654; x=1708959454; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Szw+QTMnTAcQAZlNeYyyrJj6KbWZ+5DPKy/5tGrWbDo=;
        b=ZlllJO/GoGC5bXBy7ws6r+TnfJLxAwh3Gk2K9ABlzcbVr+JG06RT9YXZqfF4sk4aIx
         d5IbqO6Q1iN22aVBwwukuqQoAwCeWFiiq/yEeVykMWyoCS64ZdJI4+RLLr2P/ybhAs3x
         H56BuLIlkKQXobUVWo0rBoI0PZkLU26VHr1Isud00+PfBDTACop6st/vWzhh6AemFgnx
         IqGxvtzyKZp/WARPxI2g/55ITjAGqOiR8Ankkjt0+0KKW09oNsMau89Zu3zjv/fm485F
         xtM0PjKD4r4YJgbQ0edv62A+M7XYiGN6LhRzZNs+7PW/M7W8wQ1kXgGZKtfqp5SIZPuJ
         I1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708354654; x=1708959454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Szw+QTMnTAcQAZlNeYyyrJj6KbWZ+5DPKy/5tGrWbDo=;
        b=GAlTV0oFC/+sn6ze6N7nP7u7b+o6fjWaMlxrWJwRL7U8D54O+Axsg4dsbg8pHrjECf
         wOa5N1ZkukcR/jOMtXS85MWYFotBv3CoGxbuDy5G3Vusg2Dnqc4asSfgFCCXjGUGVl//
         2P63McCK1nj5Q9rruWbuVhew37SlA04oPoLT4ihPbpxGIGSWFmuhLVSllPHWvYP/ijrd
         6SuXQAWXgR8OyCx0dBwvPt63PJaadXHIsB/jHkwruMaxUIvApCrfOQQTx4qXUKZ9+4el
         KleMQtvYZWPDUxxmbGfqdB4J8GRwZwS0T8QlAK+PT9jW9E7du9KOb5GXJuDa/Smquzey
         Kr/g==
X-Forwarded-Encrypted: i=1; AJvYcCXFiwiwrfSB4Mzs9kyWF/tz3BGCU/NVGqrU1NBnCb1/fEBGCrL18OVKzRwu+oC+mlz9IVtctw76On+5E84OVgBnV1XW6aM=
X-Gm-Message-State: AOJu0Yy+qw1HfpqR3BcbjX5R08OF0q2tuz7MkLMwKerRsfb8qRZhz5Tc
	cKt5wX0QKqMlP8HH8prfp27WpCmk5eTt7xRhh6L2fw2iq8SBnJlhma5D4COWxZrrjILvcy6P6hd
	tbRjKxCBoeGKBP5OMA6VL2r76hXxt1wrWaC9xAA==
X-Google-Smtp-Source: AGHT+IFwS+iE/0NQYgsx7qVKwDMppWGjVew2/XzNi/ojh9QbxDe0oOmgCSu0UPBrXtjFjsGyUMyo5ZWdgudhKw5Ujrs=
X-Received: by 2002:a81:490e:0:b0:608:ba5:729d with SMTP id
 w14-20020a81490e000000b006080ba5729dmr6119664ywa.19.1708354653839; Mon, 19
 Feb 2024 06:57:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org> <20240219-topic-rb1_gpu-v1-7-d260fa854707@linaro.org>
In-Reply-To: <20240219-topic-rb1_gpu-v1-7-d260fa854707@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 19 Feb 2024 16:57:23 +0200
Message-ID: <CAA8EJprpZxCV-3xkE0OuGg4jHrHcb=EPKCi_wSy5viP7jVwPvg@mail.gmail.com>
Subject: Re: [PATCH 7/8] arm64: dts: qcom: qcm2290: Add GPU nodes
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
> Describe the GPU hardware on the QCM2290.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi | 154 ++++++++++++++++++++++++++++++++++
>  1 file changed, 154 insertions(+)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
