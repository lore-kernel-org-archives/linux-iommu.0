Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4046108
	for <iommu@lists.linux.dev>; Mon,  9 Jan 2023 18:11:07 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id t5so4666240wrq.1
        for <iommu@lists.linux.dev>; Mon, 09 Jan 2023 10:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fML4kPdr/TJZTTTjmDRqZF2NKNyIrXL/psZmLGwFohM=;
        b=m+fHzmBRRmF0BsG7LIAgKERc94P4/TYZiGuv2hl2kyEkRddu8aKFzX9476xmik78CG
         UsJw18F5gsV9YLSp8LMulmGbo1rrCZI/o3bDIe0W8l30ll1ABpAY6m04D7bQK4wo/kKB
         xVUEoSchbv5Qt1rguhdILk1ezkn7KVaPbEGAIirexPPBmqoN8Lp8UGUQdyQPnVQXy1dE
         xysaH5osPcYaE1IJfvlKrTw3cHMyEnpBocHevQ9EqRUPZNX/xBrrYNvP0aHlRNcy6mtr
         clG/Mt8HIMOjgc+tRH4qcP+UXGaSoxO4A9IlzcI7amrv1SDxIz2FWQJdaTqaYV447O4l
         D1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fML4kPdr/TJZTTTjmDRqZF2NKNyIrXL/psZmLGwFohM=;
        b=X8TiTbZ0mPLmlx5mtc4c7m6x20VqbSAjVhyNg0B4yJvt2dHdThpW2gjmfT5X+gqdb0
         hiy+xWyv+SwBAQ6Ox9Jbpwjb4hvkqvr/KcgTjLIrit2cqb3H7joCFvMRLUlJ+rvCQiVf
         RAaQ5436GElWfixjWgSbeJ0bCDLcr/I1OHCXGHTyQ31ReTOnqYf47PKOSs3I/ABwtCr7
         ePxKDuKh9vHHHGwEhbGzUvfJV1T0XYJx6feLHpdrZRkZ7rmaKergbDxpskNorWjI+lCt
         QuunJReCCRPtYtoi8EIe400hG1M+53OnhcUO83tU/0Gl82Btkwl2cjZ/E50zvAhjopff
         Rg6A==
X-Gm-Message-State: AFqh2kqtms92kujBmbMuRBApLmrJEnVITtQoK5rG5GvxE9l+AM+/XuXD
	P6NIgJ0wid+vsYJ15DJK27ugoA==
X-Google-Smtp-Source: AMrXdXt7fojJue/+zqiYvHFyhcP0O74KqMDyTAn2+LC1MBCbIrE+iHWW/13fcFX63cwCA3EoHUAtcQ==
X-Received: by 2002:a05:6000:136c:b0:2bb:e1fb:5d83 with SMTP id q12-20020a056000136c00b002bbe1fb5d83mr4390655wrz.58.1673287865741;
        Mon, 09 Jan 2023 10:11:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y15-20020adffa4f000000b002bbec19c8acsm3846694wrr.64.2023.01.09.10.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 10:11:05 -0800 (PST)
Message-ID: <04bcb4c5-0605-2ea8-d658-feee4370ac4b@linaro.org>
Date: Mon, 9 Jan 2023 19:11:01 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 11/18] arm64: defconfig: enable the pinctrl driver for
 Qualcomm SA8775P platforms
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
 <20230109174511.1740856-12-brgl@bgdev.pl>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230109174511.1740856-12-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/01/2023 18:45, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Enable the Qualcomm SA8775P TLMM pinctrl and GPIO driver. It needs to be
> built-in for UART to provide a console.

One defconfig patch for entire SA8775p patchset. There is no point to
enable piece by piece because anyway each defconfig will have to go via
qcom soc tree.

Best regards,
Krzysztof

