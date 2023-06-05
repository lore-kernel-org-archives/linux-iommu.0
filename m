Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4766FC3
	for <iommu@lists.linux.dev>; Mon,  5 Jun 2023 17:09:40 +0000 (UTC)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-bad1ae90c2eso6049950276.2
        for <iommu@lists.linux.dev>; Mon, 05 Jun 2023 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685984979; x=1688576979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4GWJEMZcMO5R6CDwitNhGNBkGuDXmhHZQItLXpH0uTo=;
        b=pdj/9TlRmRWlyOYd2VLiS64oTqpWOU5PMoiNL5+SGh4vpokaM+qFex8O9+ljopL6Ek
         HBHAvWJQ0M7e3j7sWibBIHzTbZ7f0rfjCT19VhAxApvCJvkBEPAgvtJD/iULeeRRvCsi
         K35kvKwzQOmmk0iNm9NTpfGFzEPZdQgW4GpiloBxi+Vz0V3YRJrdjU9HBlFfsBa4rHBZ
         AMMH3+pYaBrY1aT1mSRJiwNLndUGS6EZpe7XL9uEaZ5GKuZDs2fYRQG8OrwCZzXYkbDw
         +AMx1QTVgl/f3GRDvoqcC+bh1ZarvG2crDi3cMscnTGrZkgloX4ChOL359x5llIys0Fd
         qNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685984979; x=1688576979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4GWJEMZcMO5R6CDwitNhGNBkGuDXmhHZQItLXpH0uTo=;
        b=lDGVadS1LRUkHZnvtKtvZ3ktjLymdV9OHuNoNoUlxIcS4PhKrCM/jZj+YleDKUQsJm
         lQJVRuqtanAcIVGFCFWG+qua7cqjI+3tRdiz2Vl4V0Kx4nURQN1pL3Hf/+a25Ptn/83C
         LZBAiGWe2XjHXr/xlmFjxkbNFvwGYKFBG4pZ79K7Sb8LLZtGTpl67/iAHMmYejJ3Khe3
         XbtPllm6Ob5NBjIbPK4qvkEvJf5YMZPfeXnRUhdj40U6gyPCc+Nb2bTcQnIgd1LyEAZU
         qPbQC4XonbEqRnNhPiknYFn4oW844XlBuHRCI2lJCrZ2dSqlKtb7A/l4ZcZR+yEKvPNA
         ccMQ==
X-Gm-Message-State: AC+VfDy+YUUpd5ja2ku5FcfiM3VFnMwFyMMi69YWYRveIaMqL4tiWQEL
	iGkCSYUE5dLj1g2Tv7M0vL9Mn768sn4JiqPjayJ+XA==
X-Google-Smtp-Source: ACHHUZ4p/Fv7/1YL5aK6ni9BSkRIpB2mD0PTUJxt1VEJdkmZiqICIOae+tEFI3eDyVtAjNHYulgKIeUo+lKq/F6nazA=
X-Received: by 2002:a25:ade5:0:b0:b9e:6d83:7bcf with SMTP id
 d37-20020a25ade5000000b00b9e6d837bcfmr12259782ybe.27.1685984979703; Mon, 05
 Jun 2023 10:09:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
 <20230411-topic-straitlagoon_mdss-v5-5-998b4d2f7dd1@linaro.org>
 <e9da7236-5915-b9df-59dc-c2baa960f52b@linaro.org> <ea8d1808-b04c-332f-834a-c3f237e0b931@linaro.org>
In-Reply-To: <ea8d1808-b04c-332f-834a-c3f237e0b931@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 5 Jun 2023 20:09:28 +0300
Message-ID: <CAA8EJprAiB8xrrx23fX95PnVockeH=6omppEwDJAxU6kGS5LwA@mail.gmail.com>
Subject: Re: [PATCH v5 05/12] dt-bindings: display/msm: Add SM6375 MDSS
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Jun 2023 at 20:01, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 4.06.2023 20:04, Krzysztof Kozlowski wrote:
> > On 23/05/2023 09:46, Konrad Dybcio wrote:
> >> Document the SM6375 MDSS.
> >>
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> >>  .../bindings/display/msm/qcom,sm6375-mdss.yaml     | 216 +++++++++++++++++++++
> >>  1 file changed, 216 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
> >> new file mode 100644
> >> index 000000000000..3aa4f0470c95
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
> >> @@ -0,0 +1,216 @@
> >> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/display/msm/qcom,sm6375-mdss.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Qualcomm SM6375 Display MDSS
> >> +
> >> +maintainers:
> >> +  - Konrad Dybcio <konrad.dybcio@linaro.org>
> >> +
> >> +description:
> >> +  SM6375 MSM Mobile Display Subsystem (MDSS), which encapsulates sub-blocks
> >> +  like DPU display controller, DSI and DP interfaces etc.
> >> +
> >> +$ref: /schemas/display/msm/mdss-common.yaml#
> >> +
> >> +properties:
> >> +  compatible:
> >> +    items:
> >> +      - const: qcom,sm6375-mdss
> >> +
> >
> > Same as 6350 - drop items.
> Ack
>
> >
> > Similar concern about interconnects, although we don't have header file
> > for them, so I assume we will fill it up later.
> Yep, they'll come later and other SoCs may need a bump up for a third icc
> path soon..

4th ;-)

>
> Konrad
> >
> > Best regards,
> > Krzysztof
> >



-- 
With best wishes
Dmitry
