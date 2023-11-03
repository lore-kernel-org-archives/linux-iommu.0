Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DC52107
	for <iommu@lists.linux.dev>; Fri,  3 Nov 2023 22:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gn/A0m6L"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5b383b4184fso31170097b3.1
        for <iommu@lists.linux.dev>; Fri, 03 Nov 2023 15:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699051491; x=1699656291; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5pXAnVldJ3nanWX3o4K4wMNI9RumqfofpvcrvhRbJBE=;
        b=gn/A0m6Li88U1CjClXmuGGdsVlunKqZFgNysFINzjZ+vhOcZXMGwrKpCpsd1MYsuwM
         nZDAMrx/WISDX2fLbNlXDq9H3JMSkM+sbOou1qBee2++J8yetarjnx09cp0pv4YDtOGX
         AI05fgS78GtOFWiLh3Txxn6aWCdDpf8h+5lTLAXA/ZxqTxbKHks+hBqqn/A0fbc1nU5S
         XOpLHtYYtQEYJZFXeMkzsiFpJuZD7y5ekaVrogTs7WuX0sEG0uMPp5d1RdVogDlQ+XiV
         eeX3bTkQ5VHAgwDfvb1Q6YrtXvMlUjK6doNFogODpwGgRyWnOul4dHgsT0yJtdXrfXs4
         Ke3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699051491; x=1699656291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pXAnVldJ3nanWX3o4K4wMNI9RumqfofpvcrvhRbJBE=;
        b=DS2ONFUyFASC1JUgpvT6Wa2zX3Vx4zIaf37oEPozdK1wj0sVfUrUArnyZ2uEJvxuIt
         dI52stntwXn0tWMtayxEVQGfLhnG5TRq1VQ8n5eATQjm/O6wHSdpZ7ZxcgZNoAUVN6Tl
         p2rUIExr2jek4fHAJG5oFc1AMUR79LPUML8vvSNk8qeUZGq7MDUnOfu9gSqijEAonPSO
         A7rvo5886opUlwmbRRR5ENAPLXXdVWFRt+xWmgDirbDq4iECAeXPHNg/vKwXHBj3/XPz
         dcmoLst5+4OZRWCneZpT1cgi5vOkkAkSk9En0xzNUTWbkO5M5/t8RgLh5IFOs4PpjruX
         g33Q==
X-Gm-Message-State: AOJu0YwBgiZn8V8G/7eSvVOS33hYv3J29sdEDrlOGZXd2/Kd9e5UNKtb
	XPtiNoXRUvRsJAiY/FnczzKJfXJRC3uaqx/m5/UxZg==
X-Google-Smtp-Source: AGHT+IEm9VwzgigzWfkuoz9kqjEtpavw7kmTAvP+ZZNOjFYy+eTQNahaWC/UkcJxqxAHwTChWi2eyod6Er9zTty6Shw=
X-Received: by 2002:a05:690c:f04:b0:5a7:bc38:fff2 with SMTP id
 dc4-20020a05690c0f0400b005a7bc38fff2mr5168299ywb.15.1699051491000; Fri, 03
 Nov 2023 15:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231103215124.1095-1-quic_bibekkum@quicinc.com>
In-Reply-To: <20231103215124.1095-1-quic_bibekkum@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 4 Nov 2023 00:44:39 +0200
Message-ID: <CAA8EJpqtZXNSz2-VEdQL2XTxi6GnZBkLABLe1qSUcwCbfoEHVQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] iommu/arm-smmu: introduction of ACTLR implementation
 for Qualcomm SoCs
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, a39.skl@gmail.com, 
	konrad.dybcio@linaro.org, quic_saipraka@quicinc.com, 
	quic_pkondeti@quicinc.com, quic_molvera@quicinc.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, qipl.kernel.upstream@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Nov 2023 at 23:53, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> This patch series consists of three parts and covers the following:
>
> 1. Introducing intital set of driver changes to implement ACTLR register
> for custom prefetcher settings in Qualcomm SoCs.
>
> 2. Adding ACTLR data and implementation operations for SM8550.
>
> 3. Re-enabling context caching for Qualcomm SoCs to retain prefetcher
> settings during reset and runtime suspend.
>
> Link to discussion on RFC posted on ACTLR implementation:
> https://lore.kernel.org/all/a01e7e60-6ead-4a9e-ba90-22a8a6bbd03f@quicinc.com/

First two patches in that thread were not archived for some reason.

However, as there was a previous iteration, it is suggested to include
the changelog between RFC and v1.

>
> Bibek Kumar Patro (3):
>   iommu/arm-smmu: introduction of ACTLR for custom prefetcher settings
>   iommu/arm-smmu: add ACTLR data and support for sm8550
>   iommu/arm-smmu: re-enable context caching in smmu reset operation
>
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 143 ++++++++++++++++++++-
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |   2 +

Although it is not mentioned in the MAINTAINERS file, could you please
CC linux-arm-msm when sending v2?

>  drivers/iommu/arm/arm-smmu/arm-smmu.c      |   5 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |   5 +
>  4 files changed, 146 insertions(+), 9 deletions(-)
>
> --
> 2.17.1
>


-- 
With best wishes
Dmitry
