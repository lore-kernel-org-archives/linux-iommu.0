Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FA113070
	for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 16:51:24 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso608735e9.0
        for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 09:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687884682; x=1690476682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+ghELfAbO0R2iBEq1LRki0jyaslOJziYlRqk/abt60=;
        b=YN8xqJyCcfIsFN5ItLxMYi7S50o/mbnKJLTAsU5g1qeod6zCgluQd/7dt6sYI9Iaj3
         sZHXPNaZM+LiJPVTh/kam3Wutv9Se+HqE688ZfC421r7kBGkJSGQP0kvSZz3pDnY6v53
         lwS9i6vb112cH/GyHfwIznBUFSj39UXa0racgSbxDqu2TXt1PM5Vfo80I+2VKS9s41Ly
         WBp9mirzJ5sAXh+bOBxsp3zH2XwrTFg/mO/izcyBqnzuZuebZ72l9ff3on747H4U2SpW
         1E7Kddd40pzYz248nakUcPwqrOczJ4QrwNTHe8XvcwLTOc0XYYsxF9/DjigUZZbt8wpc
         /6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687884682; x=1690476682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+ghELfAbO0R2iBEq1LRki0jyaslOJziYlRqk/abt60=;
        b=ctE68O9XvoTl7KgUphT7h0vcRPv5B4hGHLL/rsUveiCD2VLqccdERyYQd+FfdVUPLC
         4qlPHOVAMHqDFhMsk0nPR3HQlwR8xRW2dEuaD4h3+QF1M1uWtLBL14R+/b6FBn2ONm38
         OpQCpRkOcuvmPtgTXxQMFO7T8+HY2wNJUR8JfjNZxjURh3JMcRdjXT3NllUxGIRDSa9Q
         EQGSSXWpA3z31aWNlcmolrPo/6C7nlyVaKccI3XY13gO1ZLp+xnyo9P7YBlsqIt3xfEE
         IvUIYveDVT5HFLm72KFoCwNdeY2JdCPXMJ0qtRe2wsBiRJVMf4m8JInynKi63F/InsNg
         Wmsg==
X-Gm-Message-State: AC+VfDw5BLs4akSPizxRdQgCijiKZWR0XnwC9l7LQsn9SjVKaviUuOyA
	e+dopah06my7Jr8Ci4Dg/kYU3A==
X-Google-Smtp-Source: ACHHUZ5TeYUj7/7HDBAlPldZyXIYBI7vmCrqF9hOAg0Jk1yTzlA3HVAZWU6tAaOodr2QXV3fBfGLFQ==
X-Received: by 2002:a05:600c:511f:b0:3fa:9996:8e03 with SMTP id o31-20020a05600c511f00b003fa99968e03mr5802169wms.10.1687884682415;
        Tue, 27 Jun 2023 09:51:22 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c229800b003fa98908014sm5986545wmf.8.2023.06.27.09.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 09:51:21 -0700 (PDT)
Message-ID: <88cdfdec-b498-ad1d-6f87-a5595ffcdc5c@linaro.org>
Date: Tue, 27 Jun 2023 17:51:19 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 04/11] arm64: dts: qcom: apq8039-t2: Drop inexistent
 property
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Benjamin Li <benl@squareup.com>, James Willcox <jwillcox@squareup.com>,
 Joseph Gates <jgates@squareup.com>, Stephan Gerhold <stephan@gerhold.net>,
 Zac Crosby <zac@squareup.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Xu Yang
 <xu.yang_2@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Wesley Cheng <quic_wcheng@quicinc.com>, Jun Nie <jun.nie@linaro.org>,
 Max Chen <mchen@squareup.com>, Shawn Guo <shawn.guo@linaro.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vincent Knecht <vincent.knecht@mailoo.org>,
 Konrad Dybcio <konradybcio@kernel.org>, alsa-devel@alsa-project.org,
 iommu@lists.linux.dev, linux-usb@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Leo Yan <leo.yan@linaro.org>, Rob Herring <robh@kernel.org>,
 Andy Gross <andy.gross@linaro.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
 <20230627-topic-more_bindings-v1-4-6b4b6cd081e5@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230627-topic-more_bindings-v1-4-6b4b6cd081e5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/06/2023 17:24, Konrad Dybcio wrote:
> 'pin-switch-delay-us' is not used anywhere in the mainline kernel.
> Drop it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
