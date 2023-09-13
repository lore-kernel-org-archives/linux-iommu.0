Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0565156C5
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 07:07:47 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-52c9be5e6f0so7773623a12.1
        for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 00:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694588866; x=1695193666; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQ2nEJFL1xkjEyk0YmCbI44Cb7r640D/NpFhcEOFdXM=;
        b=XPwr1Uiv45Q+FU22J15OTyE5nDVdOqIDxCqxV7oyoJPAX0jYuKUtNiUS4oChRo2Lqk
         +mJAkwNe+LS0OzQDUspaL94etsWnhpyk0b1bPEPs7xKdQ4fbWoQRG68KOCJruz+PBVOr
         pzC3Grz87F0nDO2cpTrwaLh+w90Xep0A3Jhnow8JB5TjyDc1zmtDC/KYS7LkiFhWPR5b
         byJFvUh12uLWyfMYvIE+HZ2of/INi6OkZ/hBNmdsFp/pLoxaHhmokjZRmoTen0WXW02G
         CiupRVLe72cE0R4tlfGd6eGVVw+chVyZ5SC8ewfZcmrXbB/Lj5rHRGWsLsRmPO0yE+VE
         iXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694588866; x=1695193666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQ2nEJFL1xkjEyk0YmCbI44Cb7r640D/NpFhcEOFdXM=;
        b=VEyTLpMfKP4OHVzp6F55pER9eS0xxLqHI+vbIbs9hYdmGSZX4aTcLc5LgqGpzUS/ql
         q/9ixWzaAbrRlDSuTkRQYh1Qj7jL/PXSQth6hXuYbkYKMZaiMLfHiOglEvtH1Y2/gdWK
         2SFQwmvat2kyInIJViKnOW3DaCy3TVNphD5gHet7lAdHWlB9UwH+RPceUJ4Ai5B0IAEt
         IwkglzEU1h7tqQ2z25ODJkRYqp52TWaJ+DdDsd0pFuTDkPOY/CEzO9LtGARg3yj+oaSJ
         a5X0BMNz76czrBs+3rgF/lz82NUX81NDU3A4YsadwGnOYbN5F06Kwou8JGUrssOXtt7t
         V4pQ==
X-Gm-Message-State: AOJu0YzSiW1sEMjFAOUaaKBJYKW1pEFd2HvyEMaWIh0fCFpPdBD0C8z2
	76VsHvn4yyN6VjPOX3/GsxHYPg==
X-Google-Smtp-Source: AGHT+IEDdTdAYJBvC/NTElwaroM1jCmLl9Ptm9/vSLtcb32A5skuiBvr0hCVl70ozremDvSEn4TN4w==
X-Received: by 2002:a17:906:32c9:b0:9a1:bd82:de1c with SMTP id k9-20020a17090632c900b009a1bd82de1cmr1165437ejk.41.1694588865733;
        Wed, 13 Sep 2023 00:07:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id b9-20020a170906490900b00992f2befcbcsm7892650ejq.180.2023.09.13.00.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 00:07:45 -0700 (PDT)
Message-ID: <bd11d1b1-efe5-4f96-43e7-163fca5d3278@linaro.org>
Date: Wed, 13 Sep 2023 09:07:42 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 01/14] arm64: dts: qcom: msm8916: Drop RPM bus clocks
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
 <20230721-topic-rpm_clk_cleanup-v2-1-1e506593b1bd@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v2-1-1e506593b1bd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/09/2023 15:31, Konrad Dybcio wrote:
> These clocks are now handled from within the icc framework and are

That's a driver behavior, not hardware.

> no longer registered from within the CCF. Remove them.
> 

Changes in Linux clock drivers should not cause some clocks to disappear
from DTS...


Best regards,
Krzysztof

