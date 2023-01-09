Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EABE8BFD
	for <iommu@lists.linux.dev>; Mon,  9 Jan 2023 18:22:46 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id ay12-20020a05600c1e0c00b003d9ea12bafcso4397391wmb.3
        for <iommu@lists.linux.dev>; Mon, 09 Jan 2023 10:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4I9a2u/ZrGLHIwScZmGllc87eUh/OufbbnBg0RjayAc=;
        b=imulFjmKfL16MFAUV/KLR82FSiH6U2btmRS0B4dqItTP+kGzdlQa19UyW9DQ/O7H+7
         bTYgi3Biswev63WU+wSWP/jPv20/RZft55i6fdJ2QR3u9CQlPWZMFV70FzX6Y84wL+oa
         4pa2OAQ8DNzMnEngg25Y8Ynn4T3Y1q5Gms+1p5wPrh7mGliSwI24rNyePuKIlsAdhemA
         F7Oz5Q5LlbBY3DScIe/p2dLqbT/T/6y7v5xVG2nu/CbfGN1FeUsZLBOmQZE+cWhc22Qa
         dOVy9RdsDRYTZAPi1AB7BSmo3HQlYkf+X1nXE3Jorm1AI+uxxKB65DB3jvQrJTk3dLif
         axaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4I9a2u/ZrGLHIwScZmGllc87eUh/OufbbnBg0RjayAc=;
        b=bXksBKBCxOyHvRgjDELsUfBz9t6/5EBmYgi64Vd9FzZspnPUlugYZBF+27CUNjWUKr
         jgm7sEoCe1wQE8RaXPMhc3abI8oMKl109UB05G+bzp4reRh5EnTvGcwIORzux0P88cbR
         Uqfgofa+l02fgQDLk3T5svb1W3F0Ci1EfYOW44kWxEr90kqZ540PGrcN761mW3aeTQ/C
         Mix5uEFUS/WDkPKvdbANMV3j7xOze7N7PLb/eDMo+yGwBUBY9qo7dMmX4orrJknQ6m5Y
         NcQML2HprhOb5B9XBHVGknC2pC7KOcJLii0a+pZthdA28HuxPuubFcaIOnXfpjUQB/Sx
         Lmbw==
X-Gm-Message-State: AFqh2koapiFHT7mmp0E0KRLwTJozBPPYC/s+gzTReJNSd1VJkan56WPY
	Y/DiR6XoRC+JVEC1wYzlTrZcGg==
X-Google-Smtp-Source: AMrXdXvzOQzmnUHWBiYlOCVrua6gXZN+THvm33Jb9HAxI6MjBJD6kMOIRY3fa1ON2R158EliBRBjGw==
X-Received: by 2002:a05:600c:c07:b0:3d9:73fe:96f8 with SMTP id fm7-20020a05600c0c0700b003d973fe96f8mr40571156wmb.32.1673288565332;
        Mon, 09 Jan 2023 10:22:45 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b003d96b8e9bcasm18555195wmq.32.2023.01.09.10.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 10:22:44 -0800 (PST)
Message-ID: <61b2de99-060c-d37e-60ce-4524ced84033@linaro.org>
Date: Mon, 9 Jan 2023 19:22:41 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 12/18] dt-bindings: mailbox: qcom-ipcc: document the
 sa8775p platform
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230109174511.1740856-1-brgl@bgdev.pl>
 <20230109174511.1740856-13-brgl@bgdev.pl>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230109174511.1740856-13-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/01/2023 18:45, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a compatible for the ipcc on sa8775p platforms.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

