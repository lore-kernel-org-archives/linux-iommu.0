Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36DC111BB
	for <iommu@lists.linux.dev>; Thu, 29 Jun 2023 15:19:18 +0000 (UTC)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7837329a00aso33345339f.2
        for <iommu@lists.linux.dev>; Thu, 29 Jun 2023 08:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688051958; x=1690643958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nRe+VLQZebwwcwm/RXqyCDIRs/U83v9Vgel4a9NPr8=;
        b=e1s8qoC1UaRInCOJpKITnJsdXxGLXevyO/lFV2ExPplDy2LQpyBPIa0vL5VVfTV/f9
         PslmOnhftaoG212yoIVqUXk3K/vAMgUVUGiuKcbkrgXo4CYe9nPVsgoasc7wnZpTnhnS
         hq+Iboy7yoxVOV7Uhn//KvjlxQvrxoTiXhynqqs9oNazIs480cGu0VPE2S+SkAFrgm7w
         JGmi3exAxPVBSCLLIMaKlKNvfC63QL/AbVdtfxJHC4jVJOqV1OIg8UtZU0MzFFyAcMW+
         bO/rKlxPbpnhw8WWyr86dCWGcmNsAzaJ0dVdzrTdCNXuzrm5+a+doQil2HdnmdhMnJlq
         mgRQ==
X-Gm-Message-State: AC+VfDyLdLjOFEMjK++KXXIEMRQ4yzwWEXVpWlv9sCtJyYaNzzaQ+Tjj
	4zoI5jl/XP5AAvmcZVFPaQ==
X-Google-Smtp-Source: ACHHUZ48KcznqwLkw6z0qAkjZFQO0MzxYQ3ANegEU7QUC+CxcohvQReTpyZ1G+rkUcOgPwM8WbHOAA==
X-Received: by 2002:a6b:d808:0:b0:783:491a:13fe with SMTP id y8-20020a6bd808000000b00783491a13femr15716563iob.5.1688051957784;
        Thu, 29 Jun 2023 08:19:17 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f4-20020a056638168400b0042b05c1b702sm454549jat.12.2023.06.29.08.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 08:19:17 -0700 (PDT)
Received: (nullmailer pid 3054549 invoked by uid 1000);
	Thu, 29 Jun 2023 15:19:13 -0000
Date: Thu, 29 Jun 2023 09:19:13 -0600
From: Rob Herring <robh@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Christian Marangi <ansuelsmth@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, 
	Andy Gross <agross@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Will Deacon <will@kernel.org>, 
	Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Zac Crosby <zac@squareup.com>, 
	linux-usb@vger.kernel.org, alsa-devel@alsa-project.org, 
	Robin Murphy <robin.murphy@arm.com>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Stephan Gerhold <stephan@gerhold.net>, Andy Gross <andy.gross@linaro.org>, iommu@lists.linux.dev, 
	James Willcox <jwillcox@squareup.com>, Joseph Gates <jgates@squareup.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, 
	Banajit Goswami <bgoswami@quicinc.com>, Benjamin Li <benl@squareup.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Leo Yan <leo.yan@linaro.org>, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, 
	Max Chen <mchen@squareup.com>, Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, 
	Vincent Knecht <vincent.knecht@mailoo.org>, cros-qcom-dts-watchers@chromium.org, 
	linux-arm-msm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Jun Nie <jun.nie@linaro.org>, 
	Joerg Roedel <joro@8bytes.org>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Xu Yang <xu.yang_2@nxp.com>
Subject: Re: [PATCH 06/11] dt-bindings: mfd: qcom,spmi-pmic: Reference pm8916
 wcd analog codec schema
Message-ID: <168805195264.3054489.18382502326981278606.robh@kernel.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
 <20230627-topic-more_bindings-v1-6-6b4b6cd081e5@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627-topic-more_bindings-v1-6-6b4b6cd081e5@linaro.org>


On Tue, 27 Jun 2023 18:24:22 +0200, Konrad Dybcio wrote:
> Now that it's been converted to YAML, reference the PM8916 wcd codec
> schema.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

