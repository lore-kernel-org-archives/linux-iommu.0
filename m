Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C821FD6
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 07:15:53 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4c0so1371623a12.0
        for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 00:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694589351; x=1695194151; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mBCDvXDryw/KYfK9g4kN2ilPFiBF/RnPpswQ/I6D7Bg=;
        b=oQ4MkLdPijq4v3lUusKzYzMMyh0/kFg5n1E1vOP+vR7iQ3dgn7KGMllMlkd/sgcBMN
         RzwpUqUVZ7KS8f29y7z696FhVK+4SswhNK4ZjLyHd20R9J/FIO5466MHbaPTb49E/r1p
         T1O8bdB0F86w0PmK1JtTOpLiuqwVQjy6y7br2VZkOTHM4xPM888dUZq1dCVP5oBZfnJW
         cLnm9xouLUXQQwV3DKpFagbAULV+L7Fo3c5ZWqKAYZxgnWySqjcgmVYedpn6hDzrOAx+
         taQAuGWtV3GUeDtyQ0RFzCpcwZgg985/D5Rz+iGcewD1Qo9wKPG8lgdAwEkqQUCodqyy
         YYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694589351; x=1695194151;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBCDvXDryw/KYfK9g4kN2ilPFiBF/RnPpswQ/I6D7Bg=;
        b=B4O6myhnWmBI9ML78CE3jDahgP85Teqh44VtABC47CyfOoApj4JoL9j0ZsZ9DIBvIp
         hGneuEA8CBvdrZdCtQQbVBn8LMHLofbMNzwZNS1BgwBXKzblFdDFgHhKolEMMyMlUKi5
         NW1fcD+rl9yonwyLgDwJSfhD+RGqSO38LsgdsxyZp6oIH970PSyZH4GEHX8fFTZBWkmS
         Lm6snL6MHmySAlqbkvGC4uWesyA9WGUIJkHa3/5Ktl6jpGOws2DrT+eWtHPf1/ELSjEn
         DvKEUzLKc/0VlDM7MIjUv3ZHZtIH1wrap7uXFieKsH04q0lVMXshjiM86bzX4hzaBq7C
         9rHg==
X-Gm-Message-State: AOJu0YyUIcWU4xEzFKeo/390l2jTwxFMOwC4AN9lkDEh2rDyMNelqpPv
	vtnWRDewENAcNs+bnXYBy/sbAA==
X-Google-Smtp-Source: AGHT+IFCV4YlTvAtDyAlzkHEVsoI9Be6Y3BoL0WQT09ZQ0JwTHlrVtgJXzAz7QRzMOmKIWA+yiInow==
X-Received: by 2002:a05:6402:d06:b0:51d:b184:efd with SMTP id eb6-20020a0564020d0600b0051db1840efdmr6286295edb.20.1694589351445;
        Wed, 13 Sep 2023 00:15:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id y22-20020a056402135600b0051e0be09297sm6921977edw.53.2023.09.13.00.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 00:15:50 -0700 (PDT)
Message-ID: <a2586dbb-30e6-d2d6-3580-c074701b1374@linaro.org>
Date: Wed, 13 Sep 2023 09:15:48 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 07/14] arm64: dts: qcom: msm8939: Drop RPM bus clocks
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Sibi Sankar <quic_sibis@quicinc.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>,
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-usb@vger.kernel.org
References: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
 <20230721-topic-rpm_clk_cleanup-v2-7-1e506593b1bd@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v2-7-1e506593b1bd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/09/2023 15:31, Konrad Dybcio wrote:
> These clocks are now handled from within the icc framework and are
> no longer registered from within the CCF. Remove them.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

