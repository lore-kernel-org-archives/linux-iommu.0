Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524DD13ACD
	for <iommu@lists.linux.dev>; Thu, 29 Jun 2023 15:24:07 +0000 (UTC)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-783698a37beso33882039f.0
        for <iommu@lists.linux.dev>; Thu, 29 Jun 2023 08:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688052246; x=1690644246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqOrbkrApUMBf/IMLW4pZSn/5D8w3VaUXsE+FOQe8nA=;
        b=hBSBBsG8aYrhTQriyh4/jYogHczb9Kl+sI1zZwXzFiFl4pB6OaHzcOpQZbAxku8lgp
         kUZHvtSkPgQzbNMpDUBSCjmzAlQSI9cyP3WfDHZ0mE68AXjgweAlJNdhOAIXMbhpsWCV
         O9Mv0TPfb2NOh4jAndLhgC+NZQduZf2O31g6V78fosnDciaGtQtRLd42dDSIYIILVubt
         caU9WgKsQG6LSCHVmtsGNq85UMHSYT/N4sNz5iXyy6hosxbQKveJmnlKSHAaQ4lMnI8R
         6w9EdeIrT3QBsNUhTEUuh8T6WcqrVznb7PZk9Hj02Cdia+okaKGrcUHSamNz4jsNV6oz
         k63g==
X-Gm-Message-State: AC+VfDxa5ZUUfwkXd1OP5EyDJs8y5DUueehcFz0PTrwDJn8JOqAwosic
	aWzsU899uCsoDvsI8pSRMw==
X-Google-Smtp-Source: ACHHUZ5pbxnXCzp2MEXm/J9Ni9E/P2BCRXI4zVDiAbDqngY6/EOJYBBbjy9gNYs39w0iASDYHMGIww==
X-Received: by 2002:a5e:d908:0:b0:785:ff35:f340 with SMTP id n8-20020a5ed908000000b00785ff35f340mr5661463iop.14.1688052246225;
        Thu, 29 Jun 2023 08:24:06 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h17-20020a02b611000000b0041d73d0a412sm3955608jam.19.2023.06.29.08.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 08:24:05 -0700 (PDT)
Received: (nullmailer pid 3061241 invoked by uid 1000);
	Thu, 29 Jun 2023 15:24:02 -0000
Date: Thu, 29 Jun 2023 09:24:02 -0600
From: Rob Herring <robh@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Vincent Knecht <vincent.knecht@mailoo.org>, 
	devicetree@vger.kernel.org, Wesley Cheng <quic_wcheng@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Robin Murphy <robin.murphy@arm.com>, 
	alsa-devel@alsa-project.org, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	Max Chen <mchen@squareup.com>, Andy Gross <andy.gross@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Jun Nie <jun.nie@linaro.org>, 
	Benjamin Li <benl@squareup.com>, James Willcox <jwillcox@squareup.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, Joseph Gates <jgates@squareup.com>, 
	Shawn Guo <shawn.guo@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, 
	Banajit Goswami <bgoswami@quicinc.com>, Vivek Gautam <vivek.gautam@codeaurora.org>, 
	Peng Fan <peng.fan@nxp.com>, Zac Crosby <zac@squareup.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Leo Yan <leo.yan@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	iommu@lists.linux.dev, Mark Brown <broonie@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	cros-qcom-dts-watchers@chromium.org, Lee Jones <lee@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Andy Gross <agross@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-usb@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 09/11] dt-bindings: arm: msm: kpss-acc: Make the optional
 reg truly optional
Message-ID: <168805224161.3061187.9426822881905540470.robh@kernel.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
 <20230627-topic-more_bindings-v1-9-6b4b6cd081e5@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627-topic-more_bindings-v1-9-6b4b6cd081e5@linaro.org>


On Tue, 27 Jun 2023 18:24:25 +0200, Konrad Dybcio wrote:
> The description of reg[1] says that register is optional. Adjust
> minItems to make it truly optional.
> 
> Fixes: 12f40018b6a9 ("dt-bindings: arm: msm: Convert kpss-acc driver Documentation to yaml")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

