Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC078111BB
	for <iommu@lists.linux.dev>; Thu, 29 Jun 2023 15:19:52 +0000 (UTC)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7837329a00aso33374039f.2
        for <iommu@lists.linux.dev>; Thu, 29 Jun 2023 08:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688051991; x=1690643991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blNjDhPR65WgulG05Ac/jsdyPBHD4bO3KAhnWSq5dEY=;
        b=Na97k4aTKFNnAcTb1+cIHa/T021Jn0VUiz8z5kuia23fGgFgYw6BXq0Z5DnznMfs65
         C1d0Q13AwVhz8zorHzpg9Sm5CujqUA43jl6WIZHYUE9302V2tGtR5VX6al18z+mQ4ViM
         inWGS8r39qB6qWPwus5oWLGoE5FjQLOU+gwXaEhqJJQ2tToNVm2ZztUTZc01ynEZRTHi
         3QQVbxhmysrcCMluwD6/iZ51u10d4rFEMNvMVlZ9D9uVgD7IL41Wg3LIOgbIFPYtItHg
         MvtovL6RiNWyl2G7ijmY5a0J7swor+N5JBDR5kZUl6JFXoZoj7XyESiuJngy0/gCtVIT
         XRzA==
X-Gm-Message-State: AC+VfDwqGP5NImxAFhRUMoySf26Qgr69aycrzlLSS0XJwGCgMhk9x+G3
	19+DQSW3p4iSH9Zm3xrTOA==
X-Google-Smtp-Source: ACHHUZ59kmFHq1B7LvOcwOCer+K8x3ClmeCwbxyRPdlMfA5CYMemTP6T11UDwDiVATlIKwta/nogpQ==
X-Received: by 2002:a6b:d808:0:b0:783:491a:13fe with SMTP id y8-20020a6bd808000000b00783491a13femr15718132iob.5.1688051991594;
        Thu, 29 Jun 2023 08:19:51 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s24-20020a02cf38000000b0040908cbbc5asm3892004jar.68.2023.06.29.08.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 08:19:50 -0700 (PDT)
Received: (nullmailer pid 3055405 invoked by uid 1000);
	Thu, 29 Jun 2023 15:19:47 -0000
Date: Thu, 29 Jun 2023 09:19:47 -0600
From: Rob Herring <robh@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Joseph Gates <jgates@squareup.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, James Willcox <jwillcox@squareup.com>, 
	linux-usb@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Leo Yan <leo.yan@linaro.org>, 
	Stephen Boyd <sboyd@kernel.org>, Andy Gross <andy.gross@linaro.org>, alsa-devel@alsa-project.org, 
	Conor Dooley <conor+dt@kernel.org>, Christian Marangi <ansuelsmth@gmail.com>, iommu@lists.linux.dev, 
	Stephan Gerhold <stephan@gerhold.net>, Banajit Goswami <bgoswami@quicinc.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Lee Jones <lee@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, Will Deacon <will@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org, 
	Benjamin Li <benl@squareup.com>, Max Chen <mchen@squareup.com>, linux-arm-msm@vger.kernel.org, 
	Andy Gross <agross@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Vincent Knecht <vincent.knecht@mailoo.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
	Zac Crosby <zac@squareup.com>, Bjorn Andersson <andersson@kernel.org>, 
	Vivek Gautam <vivek.gautam@codeaurora.org>, Joerg Roedel <joro@8bytes.org>, 
	devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 07/11] dt-bindings: iommu: qcom_iommu: Allow 'tbu' clock
Message-ID: <168805198676.3055346.17759635264123087851.robh@kernel.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
 <20230627-topic-more_bindings-v1-7-6b4b6cd081e5@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627-topic-more_bindings-v1-7-6b4b6cd081e5@linaro.org>


On Tue, 27 Jun 2023 18:24:23 +0200, Konrad Dybcio wrote:
> Some IOMMUs on some platforms (there doesn't seem to be a good denominator
> for this) require the presence of a third clock, specifically for
> accessing the IOMMU's Translation Buffer Unit (TBU). Allow it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

