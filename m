Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A03EFBF5
	for <iommu@lists.linux.dev>; Sat,  4 Nov 2023 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c82i3ePq"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-540fb78363bso4875535a12.0
        for <iommu@lists.linux.dev>; Sat, 04 Nov 2023 04:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699096963; x=1699701763; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WJWALZUYEHz2qJrIzaykiHfq3vsVJp3Wwr9DqTqCaGs=;
        b=c82i3ePqBNpOkeQTgW+kATgviVQL7nxmgDinvZaE86njPiCaaC12UPFwTRAUg5QuxJ
         XUfXx/Ckap4jNUkhT7t6rLWCRYLTc+1lFKLI9eF9o3ZZkSooYB35f8f7XobR/qYRsrhl
         hbUXaUxrDPBmnOeyiPU20RA8hzfdSfVlzvqwTT0wgxvRyzb02gPJFylL6Nh0vuFKWqEJ
         ioqDb5hQo3qaXz8TWN9nsOIuyu2tGqaypbcj2S9+V9g+quc4HtG/wC6KLarQoIA2ELY4
         1T5DUT0Eyz2JkVSlMiQHpvv5ojp3LI90dSttVOOms+n7Ge4Z0bBlEmF1FSzkOX1VDmui
         /GDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699096963; x=1699701763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJWALZUYEHz2qJrIzaykiHfq3vsVJp3Wwr9DqTqCaGs=;
        b=QNrEHu1DU1hXcDbr7+/0c1i2Gh2/pBqut0cXqH023zGHf7hm4G/Ca6dTnv5mVQdl0+
         iTHwvyXrfC7fvGHq4UZat9PDDd6m/c1D0bTQtSBMl8BHsJGh9LODmXb1Oay2YGVRZKIQ
         VjG+LDI6+8pl1nq9rkJKPaSYwpNotPm4D0Ex9FN7PX8fac6m0tkBYZHX/vTSJwmScpQ0
         E20r3i0MOeDTfAUjeHrOnAaPF2mv5NIFzj3YqPFSwb2cZTp46hEWBFBlZP0do0kPeyh4
         9jkWf7NJH4ksC303mireh+POyG60zyEhdtqFEUVIGdJnF/mUrx5eH8lMnz/UFj7mlC1G
         ty3w==
X-Gm-Message-State: AOJu0Yy966mYfsDy2Xy9qJgbOkzv7QIky7P63S249G0GlL5GDs5TL7WR
	WYvqSHVY3VzjURE8c9p3EtUPvw==
X-Google-Smtp-Source: AGHT+IFYwit9a4cCM20TiSal/gji4jZsIkBNwk7fYnmu8fkSz+lTSGolK6MFnP+SUhfQWJ7rZjhAzg==
X-Received: by 2002:aa7:cd54:0:b0:531:1455:7528 with SMTP id v20-20020aa7cd54000000b0053114557528mr16625987edw.40.1699096963205;
        Sat, 04 Nov 2023 04:22:43 -0700 (PDT)
Received: from [192.168.0.153] (178235177017.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.17])
        by smtp.gmail.com with ESMTPSA id i14-20020aa7c9ce000000b0053fa13e27dcsm1978317edt.48.2023.11.04.04.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 04:22:42 -0700 (PDT)
Message-ID: <3e50565a-a098-4a33-b7c9-3b9a55077a8a@linaro.org>
Date: Sat, 4 Nov 2023 12:22:40 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: list all Qualcomm IOMMU drivers in the
 QUALCOMM IOMMU entry
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Rob Clark <robdclark@gmail.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231103225413.1479857-1-dmitry.baryshkov@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231103225413.1479857-1-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/3/23 23:54, Dmitry Baryshkov wrote:
> For historical reasons the 'QUALCOMM IOMMU' entry lists only one
> Qualcomm IOMMU driver. However there are also the historical MSM IOMMU
> driver, which is used for old 32-bit platforms, and the
> Qualcomm-specific customisations for the generic ARM SMMU driver. List
> all these files under the QUALCOMM IOMMU entry.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
