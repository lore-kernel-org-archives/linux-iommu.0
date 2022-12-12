Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD7623BD
	for <iommu@lists.linux.dev>; Mon, 12 Dec 2022 10:58:13 +0000 (UTC)
Received: by mail-lj1-f178.google.com with SMTP id n1so12095805ljg.3
        for <iommu@lists.linux.dev>; Mon, 12 Dec 2022 02:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KKDIIwC0muGe5b+qB8UELuXYDs0YM6jtOaRVfXtdpWw=;
        b=QOLjn72Kyxy4sxjiGDDxScP1UNkxBkF/8M/iTlnmW53PXHpKIentX3q0/wZTxyOcL+
         LWWFQmSQ/jHKGsOKJDF3AS8Ixt+S66Ny20pkwmaRVUshFxiyC1LouYWzmYgS5BVZIOwI
         aVIKObaeUnCuwM1wZTwmrW1NSGUgS/yEVmI0FXENm8UZ3Cz4883O3d97LMUf8U3nYHKH
         B6zN0vhFeShJVvWP6Oi/6xy2hD6cDwSOlgTChTCyNcSG5lDRdTXpKxXlrGCjc0YjNmsj
         9lldmF9Zct/sKxilY3U3y7fk6Osfpf8l84XNBtzlUS1fmLOBgtcwlNWjNTG0GbxuQTFy
         COjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KKDIIwC0muGe5b+qB8UELuXYDs0YM6jtOaRVfXtdpWw=;
        b=ZSDlBIOmnZ7M5n83Mc/2ouxdossmoJ3SzDdAzbaVI/SewkZUk9WqhFc91JVWGRs6Uj
         8DANJPG+dXD4D5FO2ThZOxldsYU1rfmibI6aRStKwz3eBKseZfbjh27v/OUASTin7Wvl
         W/eFFhtm4OEuhfiYODiSUG6he07DDLAia0fuN0pUvsIyFv7JPJICV1xKpuQPvFN1R2n0
         TiWuUc79aZPPNhJF+cgINxHEgSW2r4PJoLRrb++mcMy2pS++we2Yh8PmrYGo7VnyHLxS
         CjR8PkOfw9OtrE0cc0Fd+wtZNIkChnhxAM0YiYdy3uoGDWLF4wkO7Ozk6jxzGSHTXXW6
         94+w==
X-Gm-Message-State: ANoB5plZbQ9RFFhAdphW7uOWZqwe93dWogACnzr4JPnDRc02EpOroYAE
	FCS1A6mwUAv+05nTgg07GRaPqA==
X-Google-Smtp-Source: AA0mqf5Lzb3ZKCF/89HxYr7XxLLhyljEIA7mBJvEm4UjPpNzQi6ngb2mpoJc/FYKG3ddZZ8lt/tZgA==
X-Received: by 2002:a2e:3619:0:b0:279:c6bf:f3d1 with SMTP id d25-20020a2e3619000000b00279c6bff3d1mr3458812lja.33.1670842691686;
        Mon, 12 Dec 2022 02:58:11 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.102])
        by smtp.gmail.com with ESMTPSA id b13-20020a2eb90d000000b00278e9c0d3a2sm1183017ljb.33.2022.12.12.02.58.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2022 02:58:11 -0800 (PST)
Date: Mon, 12 Dec 2022 13:58:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org,
 andersson@kernel.org, agross@kernel.org, krzysztof.kozlowski@linaro.org
CC: marijn.suijten@somainline.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
 Rob Clark <robdclark@chromium.org>, Adam Skladowski <a39.skl@gmail.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Add SM8150 DPU compatible
User-Agent: K-9 Mail for Android
In-Reply-To: <20221212100617.18190-1-konrad.dybcio@linaro.org>
References: <20221212100617.18190-1-konrad.dybcio@linaro.org>
Message-ID: <552EFDD5-4BBE-408D-90EA-C96F4A0876B7@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 12 December 2022 13:06:16 GMT+03:00, Konrad Dybcio <konrad=2Edybcio@lin=
aro=2Eorg> wrote:
>From: Marijn Suijten <marijn=2Esuijten@somainline=2Eorg>
>
>Add the SM8150 DPU compatible to clients compatible list, as it also
>needs the workarounds=2E

Please rebase on top of linux-next, this part was rewritten=2E


>
>Signed-off-by: Marijn Suijten <marijn=2Esuijten@somainline=2Eorg>
>Signed-off-by: Konrad Dybcio <konrad=2Edybcio@linaro=2Eorg>
>---
>Depends on the binding here:
>
>[1] https://lore=2Ekernel=2Eorg/linux-arm-msm/20221212093315=2E11390-1-ko=
nrad=2Edybcio@linaro=2Eorg/T/#t
>
> drivers/iommu/arm/arm-smmu/arm-smmu-qcom=2Ec | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom=2Ec b/drivers/iommu=
/arm/arm-smmu/arm-smmu-qcom=2Ec
>index 6610f5d2877d=2E=2Ecd74c1efcfde 100644
>--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom=2Ec
>+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom=2Ec
>@@ -255,6 +255,7 @@ static const struct of_device_id qcom_smmu_client_of_=
match[] __maybe_unused =3D {
> 	{ =2Ecompatible =3D "qcom,sdm845-mss-pil" },
> 	{ =2Ecompatible =3D "qcom,sm6350-mdss" },
> 	{ =2Ecompatible =3D "qcom,sm6375-mdss" },
>+	{ =2Ecompatible =3D "qcom,sm8150-mdss" },
> 	{ =2Ecompatible =3D "qcom,sm8250-mdss" },
> 	{ }
> };

--=20
With best wishes
Dmitry
