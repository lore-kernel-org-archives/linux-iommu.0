Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F05313064
	for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 16:52:07 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fa94ea1caaso472275e9.1
        for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 09:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687884725; x=1690476725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=USpfAI1OKAg8OpDqtpnMJgq7elMP7uvf2P1RNsX/vYg=;
        b=VCEcHabYJExfQZ7CA8MPuO3bSHxPfDkhJbqqsgoW90ItGkyxpjKJq3RwuR4QWaC8Rk
         Ux6k0efVo6+a8hy349Y9sc0pksQnocG8ivXecX5sQld1JVwZn990ZlZS1m/RQhKW5cwF
         uLXraEdi7OpiRo7ko9nYwtI2/LSZyixWKWMRMUsRLi9BidBYT9izlLb8GXJuue1A/05D
         lOWyRvA/kPQ62xDISbHsTcf0pwi2cEIR7Kt0veehL4qotFA2kiqA2kST0PcSTh7Pgfgr
         HSN7irvJhu6qI6ciVrLaq6Be653ViZQ4a3JxgLHxwZjyjGs5U1+Vlzh9j5A+EEMxojAi
         5HmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687884725; x=1690476725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USpfAI1OKAg8OpDqtpnMJgq7elMP7uvf2P1RNsX/vYg=;
        b=OgKfq8I0AT/mTiHVC9g0UWkOXxZf3DPQtg5hDq1xCjnFid58+XB6fG9BEYLSyYXWjg
         C0XnVRxICXrolBTxeGadqAW1YYjwIzePr8hLs2ga9+MYVL9TLkTXIPlUEr0w+uWdfGCC
         5wBZ4QH/lFTTta2gwW6Ccw+/CmeYj9nvj1t+e+m7jFiiXjr7OSt9bXLOKqCGT+op3teo
         i2m1TKGv04c0Xwi2GotG1dZKIj3Ghaz6XoNeaiVFx57qQFtx+zUBM+FQbIuUrjnqGfc/
         WL8sf0USRZchf9aeUZ9EiMtaMwRWGBmymZrPky0i+lCataNJruJwGzuUhUuVoGAsFizw
         ExMQ==
X-Gm-Message-State: AC+VfDwrQLbBoMfVaou7dzOGgvXlBzt9LeGQJgvPG3L6s9mYXNH0AOct
	1Rx6Ml8VgHxugpwZPO1+0r10mw==
X-Google-Smtp-Source: ACHHUZ7LzkqGsxsFpbadxBUX52EaujfQ1jgOJSmKZ8dsh0QhDuIh6RbbYX2hBZyk83iG9EWVNZLyAg==
X-Received: by 2002:a05:600c:2215:b0:3fb:416d:7324 with SMTP id z21-20020a05600c221500b003fb416d7324mr3786608wml.6.1687884725311;
        Tue, 27 Jun 2023 09:52:05 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f90067880esm14251778wmk.47.2023.06.27.09.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 09:52:04 -0700 (PDT)
Message-ID: <aee6e901-01b7-048a-ffe1-57a8895edda2@linaro.org>
Date: Tue, 27 Jun 2023 17:52:02 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 03/11] arm64: dts: qcom: msm8939: Add missing
 'cache-unified' to L2
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
 <20230627-topic-more_bindings-v1-3-6b4b6cd081e5@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230627-topic-more_bindings-v1-3-6b4b6cd081e5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/06/2023 17:24, Konrad Dybcio wrote:
> Add the missing property to fix the dt checker warning:
> 
> qcom/apq8039-t2.dtb: l2-cache: 'cache-unified' is a required property
> 
> Fixes: 61550c6c156c ("arm64: dts: qcom: Add msm8939 SoC")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

