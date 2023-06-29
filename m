Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6F5111BB
	for <iommu@lists.linux.dev>; Thu, 29 Jun 2023 15:18:53 +0000 (UTC)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-777a6ebb542so33366439f.0
        for <iommu@lists.linux.dev>; Thu, 29 Jun 2023 08:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688051932; x=1690643932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2F5panrQ9N51YbtKXEYqm4xFh86mMaEOlU/moUG6+Y=;
        b=G9KXPndRE0G57bS7rB4oko/t9tyGxkMVIIoSCxTDBok5LK2GAcND7HYkj+lr9z1IAw
         06ploCPT/0gV9Jq4Uo0kfnDJAUg7/lRn2PHFygb9Ew47bnFGZI8CapmLw8NwasKssYXe
         53ktDopZFg09F/QBSl1KF0/zwxmKmc4zgiIioopE6b4fb61JxH64tbKXeKo12ZitFkTC
         XAxvfPiWAAXb/pA03QOZpHflOj51T0ZJHxNY+ZE2kkvO8P4PUwywpW45LcF9LpCeq7Mf
         p5FlHYnybMUBhYFuy9vitBz0LnPuV8N+vdJeAYoRDL4wCNH/JX3B5iNcQzCLmHgTJJlo
         vUhg==
X-Gm-Message-State: AC+VfDxrfrhA9Ov22x/5kedfqUbW0EUX92W0jDGETEo+h4nhyPLGUXmD
	wZtObMnPRyUE3kHFlhTFrQ==
X-Google-Smtp-Source: ACHHUZ6s9Jdl5RFEqCdgdp0bwGY7cGwuE+P2Z34gk2rOEic26k/FpRgytM547mDniAnRHCO5gYxGXA==
X-Received: by 2002:a6b:d912:0:b0:786:2c7d:dd19 with SMTP id r18-20020a6bd912000000b007862c7ddd19mr3191265ioc.17.1688051932111;
        Thu, 29 Jun 2023 08:18:52 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id a22-20020a5d9ed6000000b0077e3566a801sm4430658ioe.29.2023.06.29.08.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 08:18:51 -0700 (PDT)
Received: (nullmailer pid 3053897 invoked by uid 1000);
	Thu, 29 Jun 2023 15:18:48 -0000
Date: Thu, 29 Jun 2023 09:18:48 -0600
From: Rob Herring <robh@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, iommu@lists.linux.dev, 
	Konrad Dybcio <konradybcio@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Conor Dooley <conor+dt@kernel.org>, Zac Crosby <zac@squareup.com>, 
	Vivek Gautam <vivek.gautam@codeaurora.org>, Banajit Goswami <bgoswami@quicinc.com>, 
	Shawn Guo <shawn.guo@linaro.org>, Joerg Roedel <joro@8bytes.org>, 
	Andy Gross <andy.gross@linaro.org>, Jun Nie <jun.nie@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, 
	Leo Yan <leo.yan@linaro.org>, Lee Jones <lee@kernel.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, alsa-devel@alsa-project.org, 
	Stephan Gerhold <stephan@gerhold.net>, linux-usb@vger.kernel.org, 
	cros-qcom-dts-watchers@chromium.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Max Chen <mchen@squareup.com>, 
	Benjamin Li <benl@squareup.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Vincent Knecht <vincent.knecht@mailoo.org>, James Willcox <jwillcox@squareup.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Joseph Gates <jgates@squareup.com>, Mark Brown <broonie@kernel.org>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, Andy Gross <agross@kernel.org>, 
	linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 05/11] dt-bindings: sound: Convert
 pm8916-wcd-analog-codec to YAML
Message-ID: <168805192771.3053849.17023496929175540009.robh@kernel.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
 <20230627-topic-more_bindings-v1-5-6b4b6cd081e5@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627-topic-more_bindings-v1-5-6b4b6cd081e5@linaro.org>


On Tue, 27 Jun 2023 18:24:21 +0200, Konrad Dybcio wrote:
> Convert the PM8916 analog WCD codec bindings to YAML.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/sound/qcom,msm8916-wcd-analog.txt     | 101 -------------
>  .../sound/qcom,pm8916-wcd-analog-codec.yaml        | 160 +++++++++++++++++++++
>  2 files changed, 160 insertions(+), 101 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

