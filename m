Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841A06FC3
	for <iommu@lists.linux.dev>; Mon,  5 Jun 2023 15:50:16 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-bacfc573647so5579499276.1
        for <iommu@lists.linux.dev>; Mon, 05 Jun 2023 08:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685980215; x=1688572215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/rwEbo5JSTdoMaDlmiLIrc5B4xTObKdifeh+A92pBE=;
        b=tehXU3POZZFMf6S0xCJwhCc8lbhQyW0kfHxtEmy/yPV8CjRAWwZjEKDl38RSm0vvuv
         65O+s/Qi0reXdb602murjsaUDQeMFhr9bxzJVpQXAuxtvRJ33LIjA2LobSVtUmphfc5t
         dpn6X14T8TMcAQ4vb0cZMAZgpfyPrSOsnmrb08XY3EwNupf2HPUUJAtqiGG8xqfBe0Vt
         lmcegKpDmonufWCF8lVOPj309+dKQXO9NYS+aN+N6Qi5GofT4jFT/qRmYvXgLhDNNIbL
         pOKvHRuplKHrDLKLMhCIBNv0MH/h3/Y51IxejjcNqOuUYLY3kzX/0NonGFHb5GuuYo/N
         Wj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685980215; x=1688572215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/rwEbo5JSTdoMaDlmiLIrc5B4xTObKdifeh+A92pBE=;
        b=SggubnZDqIlOFveVk6yo9nJFDea/pCau80J60e75kefuV/Sesm2b2BsCnklwR1GEHr
         ogoIHvlR6sGhG8CVKrsn452E/WpCQa9yvgLH9+kmWL117uFeGLcQb2HG4LTUxdTphQ3p
         FLynwgI7hCNI1qAV5upmp/AimA0dI+YyMovEznftC978ww1AfaeNHt1tsYoGSYgAn2Yw
         090jueFkLk+unfX950CLgwWGVMi5bk1FnEgsFdwJVxbd+iu0m0Ki7BW+fO6X2JogaFYQ
         M7EsdWht6/hL5iPPHsMp4F8WOEvYnz7MBKHw3GkhhjrDrVa8NkwJSRvREJrg8yiomNTh
         b2xQ==
X-Gm-Message-State: AC+VfDwVgoT7uw85pYpPM3qa9zkBrHEky6hKswXcdBvoT231xYH5uX15
	ChujSDJ7btYpKIjlo9QGf2TJCa16J+VG1KGOCp4/yw==
X-Google-Smtp-Source: ACHHUZ6MHDlIng6j4s3BtKAAZMCZm1zhShzwTWAQXnaSPZwJ4LxHLDzNz6uFTbf5FdnJFQjUWxB++bTBFfAD8DVON7Q=
X-Received: by 2002:a25:41cc:0:b0:ba8:1f85:46cd with SMTP id
 o195-20020a2541cc000000b00ba81f8546cdmr12844287yba.45.1685980215190; Mon, 05
 Jun 2023 08:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
 <0fbe5ddb-c3de-0724-fb69-a99e4980b26c@linaro.org> <20230605154338.GC21796@willie-the-truck>
In-Reply-To: <20230605154338.GC21796@willie-the-truck>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 5 Jun 2023 18:50:03 +0300
Message-ID: <CAA8EJpp3H9RWh_MRtEkuyWbKEsrCrSKR-40=t+fx0FS5SfjC1A@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] SM63(50|75) DPU support
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, Rob Herring <robh@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@somainline.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Jun 2023 at 18:43, Will Deacon <will@kernel.org> wrote:
>
> On Thu, Jun 01, 2023 at 03:16:52AM +0300, Dmitry Baryshkov wrote:
> > On 23/05/2023 10:46, Konrad Dybcio wrote:
> >
> > [skipped the changelog]
> >
> > > ---
> > > Konrad Dybcio (12):
> > >        dt-bindings: display/msm: dsi-controller-main: Add SM6350
> > >        dt-bindings: display/msm: dsi-controller-main: Add SM6375
> > >        dt-bindings: display/msm: sc7180-dpu: Describe SM6350 and SM6375
> > >        dt-bindings: display/msm: Add SM6350 MDSS
> > >        dt-bindings: display/msm: Add SM6375 MDSS
> > >        drm/msm/dpu: Add SM6350 support
> > >        drm/msm: mdss: Add SM6350 support
> > >        drm/msm/dpu: Add SM6375 support
> > >        drm/msm: mdss: Add SM6375 support
> > >        iommu/arm-smmu-qcom: Sort the compatible list alphabetically
> > >        iommu/arm-smmu-qcom: Add SM6375 DPU compatible
> > >        iommu/arm-smmu-qcom: Add SM6350 DPU compatible
> >
> > As we are now nearly ready to merge this series, Will, Robin, what should be
> > the merge strategy for these three patches? Would you take them through the
> > arm-smmu/iommu tree?
>
> I'm happy to take the three IOMMU changes, but the bulk of this series is
> replated to display and GPU so I don't think it makes sense for me to take
> those.

Could you please then ack merging them through the msm-next?


-- 
With best wishes
Dmitry
