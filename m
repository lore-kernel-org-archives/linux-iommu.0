Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099718BFD
	for <iommu@lists.linux.dev>; Mon,  9 Jan 2023 18:23:13 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id bs20so9118027wrb.3
        for <iommu@lists.linux.dev>; Mon, 09 Jan 2023 10:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A00xyofDnmYBC+YdwEJ6rLbaZfkGLo4zgr19f7CaBy0=;
        b=Nn560XwbDWnu6G77ftDb5073LFO23GkitBB9lcflnyEaIUw6AmwQ40dLP+Fesu/+gU
         So2x/k+DlrgBQp4MOuwLTGgW/jrh+w9xRoQjI4FzwiyOi9zwkhZ3v4UPjxF1El9qTIFN
         A4/3U0/cgq7jTetYBLGPkwd5YVIvwNW3J8eGHihIRBcyc8KuUgjd00lPBHuqlWNtlFOi
         SsH78muTDUrTIQDzAbjGLJFRENx+pdugFomt97C4CVvjR3HQzpC1B+6fgaN0d6FlNg+D
         C3cmDbAE79TDfnAUsRisA+a5RXmGm1foH294ilbiRRQ3NiWM+NrufrI0U4L5pWL3RSAF
         4PJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A00xyofDnmYBC+YdwEJ6rLbaZfkGLo4zgr19f7CaBy0=;
        b=u9Iy/3q4C37qdTbe+kOrSs0lDElBmEPD+uhkkLADddTwjMlhjx/abfRNHq5qzF8A0X
         oQE2VJbaExmV1SZIdxTMQnRySveIUPhrVsapMuYlR81k7bRPnvfu7QjbhFlRb/L5EeXg
         c4Y807Rj4elV25VztE/unVucHbkN+Blrsv+27X7Id6yBzJFYb9Aekn8ZFrpPTYHtSs/g
         0y8KEFl1+CpJ+j0Mmq5kWXt5aDDVFTsaJknuGYPQyOOyrsf83ueB2u5fG9Jx++rM/S4b
         YKUoRunBUahR3L3EywQ4f/h3uzROWMaoOi4aGg7q1ifheoNZ1lx+0IBihIueKX35dnoD
         lR6A==
X-Gm-Message-State: AFqh2krPrqgc7nYS5GNFM31yLfU2bN09Cf2a6m1UvEeQqzmwVKUZkg0/
	drvFETtWsbgT7yIDDiMvAUD0PA==
X-Google-Smtp-Source: AMrXdXuMGYUrHoq4kIUWUWO5tf56nNLAhc62b2axVIsjwOUdF/rm8nQM5YAguQaJeokfqPilyj+DXQ==
X-Received: by 2002:adf:e383:0:b0:242:3cb6:36b8 with SMTP id e3-20020adfe383000000b002423cb636b8mr42328232wrm.44.1673288592385;
        Mon, 09 Jan 2023 10:23:12 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u5-20020adfdb85000000b002ba2646fd30sm10713382wri.36.2023.01.09.10.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 10:23:11 -0800 (PST)
Message-ID: <aa146dc5-b4de-0e77-345a-8592b097f444@linaro.org>
Date: Mon, 9 Jan 2023 19:23:09 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 13/18] dt-bindings: power: qcom,rpmpd: document sa8775p
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
 <20230109174511.1740856-14-brgl@bgdev.pl>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230109174511.1740856-14-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/01/2023 18:45, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a compatible for sa8775p platforms and relevant defines to the include
> file.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

