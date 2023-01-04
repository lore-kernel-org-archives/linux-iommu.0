Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02453BA53;
	Wed,  4 Jan 2023 22:06:42 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id fy8so21961255ejc.13;
        Wed, 04 Jan 2023 14:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHNB4xUxc83E7S0i8SezgHCvjQP7q2U3o8WSif5WD7Q=;
        b=MfQGj99SlUr1fOLRLRVILmz4F6okd8DXBufbVYhWmMNUyXZGvvIb4j1ugYSTxxCHJE
         DI1qPtmY+k9HTBSLVnNUEduzc0cC2DYr/PjEcEbxMaCyhHpcHkZOD9wWIRKLn6H+AEHA
         rL8W4BxLBtu5Ky2McPF6Ih2tWFK1LIkpLNlHuUNiuEGhPYUGlXF7D/qw+qKYoCYBMeHv
         uOE47EVbdCGvsHYVQ5AMsuAB7X84ub1yyFi8SAi14Fi4RQUDtIe3+B/JLO2XzYGCjKWo
         IV19+kK46W29k+g7AlabmKUfu4ePT+KSYU36oXfklmSB3qYtrvn+zh90KjO0LvDNPUCZ
         Yw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHNB4xUxc83E7S0i8SezgHCvjQP7q2U3o8WSif5WD7Q=;
        b=bbqSbu9H6EPJiiWUxZi4oD2JaE0f3wJ7eiJnLnGhETCOgadkKEtCgGyMFHwKuKqeey
         uVm+zVl7S5rYV7EkCXFAPnX/0e6ur0GC7+NiBxl0UMibCBFoerWwBRkRzUD8EIDxNE3M
         PaptBHgoaD+eQgXZEMUSc3ENuvbmFxOZvogL7P9COvfJnD37WCkgomKE9/3/aspTQJl/
         Eb0pfdgQVJ39SeQw/xXZiU8X5EQiti/AQmPnP0AnXOaaF0v2UA8fZwBMuRWYHVhuCmIC
         F3B7+N2ZmFqWHO1qH/MAxZmxrvln/hCIMZaSr2XzOAQNalGTKatNotM8FNCUgyam4oA3
         mtIg==
X-Gm-Message-State: AFqh2kobVywxBvh1TctbNQVPjxp98FIDXvvWu5jBinGORl9ORpVkhHUi
	EoGUwftGUV7zeK4r2IkxxJc=
X-Google-Smtp-Source: AMrXdXtfxwTmyABikpZ/U2qwnWLwnM/iIR2n2N7XSsqhvHK/LVPaI/WQnVEHgFS1Gmdc3b2A3eVV3Q==
X-Received: by 2002:a17:906:b752:b0:7c0:b292:e56b with SMTP id fx18-20020a170906b75200b007c0b292e56bmr46452874ejb.68.1672870001298;
        Wed, 04 Jan 2023 14:06:41 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id a15-20020a170906368f00b007a9c3831409sm15713919ejc.137.2023.01.04.14.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:06:40 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Samuel Holland <samuel@sholland.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 3/6] iommu/sun50i: Keep the bypass register up to date
Date: Wed, 04 Jan 2023 23:06:39 +0100
Message-ID: <3394428.QJadu78ljV@jernej-laptop>
In-Reply-To: <20230103010903.11181-4-samuel@sholland.org>
References:
 <20230103010903.11181-1-samuel@sholland.org>
 <20230103010903.11181-4-samuel@sholland.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne torek, 03. januar 2023 ob 02:09:00 CET je Samuel Holland napisal(a):
> Currently, the IOMMU driver leaves the bypass register at its default
> value. The H6 variant of the hardware disables bypass by default. So
> once the first device is attached to the IOMMU, translation is enabled
> for all masters, even those not attached to an IOMMU group/domain.
> 
> On the other hand, the D1 hardware variant enables bypass by default, so
> keeping the default value prevents the IOMMU from functioning entirely.
> 
> Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


