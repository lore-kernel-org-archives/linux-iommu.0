Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2253817C61
	for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989146; cv=none; b=Ign+RW/8pQUByXRS8eo/Qhe1ZOcFcTsLhO5Plhdp439G7GmPnSbiDAQcTUubgEG3fuQ/tVyRzSHOOuYXwSpCy6pTewiKe47o2d1UUeF9/av2Urt7TvIJgW8kEKqrHv4X+UxtxrLIXo2J80Ca0T2LrrQvH2x9FJwmsc2J7Z8ieuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989146; c=relaxed/simple;
	bh=ovUyhUiMjBKTnx4DSiTfVdweq3UHIu1azJ/rG3mlzsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyCiCJCyNHXecjFPENFloh2D3JxJasVI6Uc2MrBwDs74OaW5DCcPDu/gUHDmyPValiD0eKWon7kgTTuDv3XU0b+zbTfY0ljiKzp3QQac5O5kJeBpM9RyFM9vhA2QAyFdsHymEwcMg9AOcg0Dxj2fZ4wm6TVq/0S/5i3+XYnBEMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O9qQQLzy; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9qQQLzy"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6d24737d7so558219276.0
        for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 01:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707989144; x=1708593944; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ut8NlXOEY0y/ncuagbllCtcYDmgG86ebbFIp8z5hh8U=;
        b=O9qQQLzyaMJSGZqAdVQzFXvC1qzOpaoUBmoxJg+6hx/m1urEK/YEPVTlxdiZriYGiW
         G2YW5nVVpjsljQBN9oa529keqYE7KY3tYT7QEY1S3hudp9E4DY1LGoa9ex/9XNDvyH37
         9Rtz1aSw8xt90ESzDd8LGq1MInZ439FVwwpwgyoiZoSjvYhjnLYWj4eWYjdvkXYYs7PN
         H9HQKJ3l0xAXwqxYyjWBo1ZDLmnplLskxAAvQfAQNaYYgLqSO/gDqhmxuHfHReNXJSXC
         aGlKDip9HJFvVyPgZmHP0XXWco3yStJhbtHTI01FiSUzsb+/X+uRmAYpWN7HgKXCJ2uq
         cGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989144; x=1708593944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ut8NlXOEY0y/ncuagbllCtcYDmgG86ebbFIp8z5hh8U=;
        b=Jm8HutJbgx6U1EnM5ErOUX7voS4doamNfvS/mVcEeZXhT6mZgLovQu5kpnBS+VqkKn
         C7ipOvSL8EfMxC+zka8sirzlQjdcbINS6tyxG0IvMIUDhPXcABBARERqgjlubjYxcwci
         2XH1fxPS0haU0qw4ZOG5lS8RJM/pV7tw8atAwGFARJOdLRFxFYCF5MrJCmm/+z49gqy7
         AmC7wst+qvOxh+UCCISa2iACtzyJePE1IL00Ax7ksMzujFdd7pcgJDxB3w5ppPyi6uFA
         oo7h8mA3odAggNBULwYh4xj/SB7ENz4Tgx2StuAXPQO93jbHgG9zYr/1Y2rWHzDqBPNm
         LZKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWgy3C1+5w//g1PgH+kGF1SeguXhNlFFJ3SQJBJK3CsM73K89hM/e+L3QI7avpLW7OGnUQO7+NkvBA2/5kqS0lKQcisfY=
X-Gm-Message-State: AOJu0YzOalxittQbSVnnJNoQPkVIOr7SHDggOvhSENco0nhS1/Fnbh03
	avgGbUqVvvwLWX5QXgKacBkk2d/E8+IWsPEPIMf8R39ABebNXg4ekzwpG47yB8goP3nRFpt0VbF
	z3h1xE4vD2TTRSqKJUMoc9AEgZ4DWSqobxDY9Hg==
X-Google-Smtp-Source: AGHT+IGK2EB5aTs8BfG4jSsckxgl2EOaTmuQv0ycjxUuZs5Mb4QsZ7LrFpeHU2Kn6y9+s5eezLpdwLHcymkVAR1BGTw=
X-Received: by 2002:a25:7447:0:b0:dcc:273e:1613 with SMTP id
 p68-20020a257447000000b00dcc273e1613mr1232044ybc.40.1707989144074; Thu, 15
 Feb 2024 01:25:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240215-topic-sm8650-gpu-v2-0-6be0b4bf2e09@linaro.org> <20240215-topic-sm8650-gpu-v2-2-6be0b4bf2e09@linaro.org>
In-Reply-To: <20240215-topic-sm8650-gpu-v2-2-6be0b4bf2e09@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 15 Feb 2024 11:25:33 +0200
Message-ID: <CAA8EJprpYEhGi5b+uWGWtOa+qbSwUR8C0j9NLC+ah_-nvy-=Ng@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: arm-smmu: Document SM8650 GPU SMMU
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

On Thu, 15 Feb 2024 at 11:20, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Document the GPU SMMU found on the SM8650 platform.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index a4042ae24770..3ad5c850f3bf 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -93,6 +93,7 @@ properties:
>                - qcom,sm8350-smmu-500
>                - qcom,sm8450-smmu-500
>                - qcom,sm8550-smmu-500
> +              - qcom,sm8650-smmu-500
>            - const: qcom,adreno-smmu
>            - const: qcom,smmu-500
>            - const: arm,mmu-500
> @@ -508,7 +509,10 @@ allOf:
>    - if:
>        properties:
>          compatible:
> -          const: qcom,sm8550-smmu-500
> +          contains:
> +            enum:
> +              - qcom,sm8550-smmu-500
> +              - qcom,sm8650-smmu-500

Doesn't this cause warnings for non-GPU SMMU on this platform?

>      then:
>        properties:
>          clock-names:
> @@ -544,7 +548,6 @@ allOf:
>                - qcom,sdx65-smmu-500
>                - qcom,sm6350-smmu-500
>                - qcom,sm6375-smmu-500
> -              - qcom,sm8650-smmu-500
>                - qcom,x1e80100-smmu-500
>      then:
>        properties:
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
