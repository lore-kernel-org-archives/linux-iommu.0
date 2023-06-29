Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AE513ACD
	for <iommu@lists.linux.dev>; Thu, 29 Jun 2023 15:24:34 +0000 (UTC)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-345b231322fso3216095ab.2
        for <iommu@lists.linux.dev>; Thu, 29 Jun 2023 08:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688052273; x=1690644273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eQgcjG/JNZBQYsHaOaghoEHW/pYFGXm2Ot9OAjBn+I=;
        b=IO+rD/A1NiZT7ZzEcwNAR3a08kn9rDeQMSUzi/QGiqOVflqpPYvVNvcM+Etseytyq4
         kjiptvFppoY3V996yGzuvJ2t9HKw4/dy8155N+8QRKePUm1Aflx7aj0URPZjF00ymOdS
         HwzNh2ZKYPqm1Txyj577/Oh68c4WMiadzZOwuwuD59VT6tf+IuuawDRZjspF8Oj72UHe
         UINs1JuPWy3Seb4q7WsxRvvJnLHPGUJLhW35PQRQtdLrAq6AHH6Gag69lPn7Guj0FVsL
         S/y+OVQzMWLA0Ac31zfbINkZNE1CgCjX12ef+nuNpH5DC3msb0al4tLbQRPTJE6B7LnO
         1oIA==
X-Gm-Message-State: AC+VfDxCOIbdaLKTWhRTv5d/fktUyP15V7eVxX+nSn6/OeQHqugHMtMl
	S5V8YurpYkvKVJ3TX0rHMw==
X-Google-Smtp-Source: ACHHUZ6aWR2cNKLqqna8mhpYMU4KBK1rHsg3TJ2zE4I+ravgqHborA0R3NbQyITNWdKK9jJT6CE9HA==
X-Received: by 2002:a92:c802:0:b0:33d:8720:7d98 with SMTP id v2-20020a92c802000000b0033d87207d98mr31008278iln.13.1688052273202;
        Thu, 29 Jun 2023 08:24:33 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id o13-20020a92c04d000000b0033a50ad8176sm4232350ilf.18.2023.06.29.08.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 08:24:32 -0700 (PDT)
Received: (nullmailer pid 3061956 invoked by uid 1000);
	Thu, 29 Jun 2023 15:24:29 -0000
Date: Thu, 29 Jun 2023 09:24:29 -0600
From: Rob Herring <robh@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Xu Yang <xu.yang_2@nxp.com>, iommu@lists.linux.dev, Will Deacon <will@kernel.org>, 
	Jun Nie <jun.nie@linaro.org>, alsa-devel@alsa-project.org, 
	Andy Gross <andy.gross@linaro.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Christian Marangi <ansuelsmth@gmail.com>, Max Chen <mchen@squareup.com>, 
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	James Willcox <jwillcox@squareup.com>, Andy Gross <agross@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Benjamin Li <benl@squareup.com>, 
	Vivek Gautam <vivek.gautam@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Zac Crosby <zac@squareup.com>, Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawn.guo@linaro.org>, 
	Leo Yan <leo.yan@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Joseph Gates <jgates@squareup.com>, linux-kernel@vger.kernel.org, 
	Vincent Knecht <vincent.knecht@mailoo.org>, Banajit Goswami <bgoswami@quicinc.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephan Gerhold <stephan@gerhold.net>, 
	Lee Jones <lee@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Joerg Roedel <joro@8bytes.org>, linux-arm-msm@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 10/11] dt-bindings: usb: dwc3: Allow just 1 interrupt for
 MSM8996
Message-ID: <168805226868.3061904.18194272296816895150.robh@kernel.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
 <20230627-topic-more_bindings-v1-10-6b4b6cd081e5@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627-topic-more_bindings-v1-10-6b4b6cd081e5@linaro.org>


On Tue, 27 Jun 2023 18:24:26 +0200, Konrad Dybcio wrote:
> MSM8996, similarly to SDM660 has two DWC3 controllers: one for SS and
> another one for HS operation. Allow just specifying the HS interrupt
> in the latter case.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

