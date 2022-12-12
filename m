Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3C228ED
	for <iommu@lists.linux.dev>; Mon, 12 Dec 2022 13:43:42 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id 1so18641472lfz.4
        for <iommu@lists.linux.dev>; Mon, 12 Dec 2022 05:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LlNSc60ZEW+VzadcTtuvtEZT642+BCsZkZyfuK93bU0=;
        b=vzxDbaRKh1TQ5/DeXhU54jbEFtJJE+Vtqu0Ns4nw492JK2svhI/svde87/WtSlBo0F
         /wp29d6vIDSHkgKEx64uYuFiVG4MJ4WsWG/PO0hjgCvKCmKh6893lyx/PFD+EABCucxl
         DZ2kOcttyZ68yFiCKQOcf1VWoDRuJiuhXov47Rfm1STzseTy9OAJxNWaKp2D2cSoUryX
         +vPOBYUSA2+pYHmThbSBVfZtWWdg+jzyfd/V7q8vbMtjiPliGon9Puz4geLE/bxesagK
         ME7ADxTICKrEBs5CBH/D8ipKJrKtouV2jJ3Hl47DxM+0z8lz0H9mVj019QCHXyTEVJrf
         19pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LlNSc60ZEW+VzadcTtuvtEZT642+BCsZkZyfuK93bU0=;
        b=2OvEdCL8g6CIAUyYZQA8nMl14CZc61mPRSaNGRN4cY9gC1Sgg7PRvFtB+Qd7JIvXlp
         bS4yxUjFRMI2/wbNpAsS4BoujvysyToqS1iqkMUQ6eiCspHHYHpdnW+vTU6oyt2dsnvH
         kP5V0uQybUsGVVzuGAZOPEwpmAgX/RZiwB2t5x1Ie7m6X3/lQpoYKZchC7yZekTSqSsa
         9j8JczgbStjNsh1kZYCp88QSF5dp39v1HZTsqaZ1ztTjU3ZQGYU/lx+dHlEHV/JOTII3
         Of7n5nbK9PH1fH/S4XQj4/hdVLeDmgvzv3WEqvp5nw8rOhk+goTr7ul1G+1INbkSFN1v
         EQvg==
X-Gm-Message-State: ANoB5pl134WgM4b2LZjvSCWX+3Y75Kuyoe57PlnLos7YLTFFdS9JPXoS
	QF03mfFf1Oq7/M6pK9tCQ+GNaA==
X-Google-Smtp-Source: AA0mqf6iieQPyfMoTtuY5t5RV7tMQk1d4Hxa8XKrKZzjh8dWgg3gVaJqHnbBTSXzYJRnJ+zrRQ+50Q==
X-Received: by 2002:a19:f00b:0:b0:4b5:7dd6:4df0 with SMTP id p11-20020a19f00b000000b004b57dd64df0mr3672610lfc.32.1670852621039;
        Mon, 12 Dec 2022 05:43:41 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.102])
        by smtp.gmail.com with ESMTPSA id w6-20020a05651234c600b004b5480edf67sm1653404lfr.36.2022.12.12.05.43.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2022 05:43:40 -0800 (PST)
Date: Mon, 12 Dec 2022 16:43:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org,
 andersson@kernel.org, agross@kernel.org, krzysztof.kozlowski@linaro.org
CC: marijn.suijten@somainline.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
 Emma Anholt <emma@anholt.net>, Rob Clark <robdclark@chromium.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-qcom: Add SM8150 DPU compatible
User-Agent: K-9 Mail for Android
In-Reply-To: <20221212121054.193059-1-konrad.dybcio@linaro.org>
References: <20221212121054.193059-1-konrad.dybcio@linaro.org>
Message-ID: <B63B8438-BE40-4E75-8F61-29A507524D1E@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 12 December 2022 15:10:53 GMT+03:00, Konrad Dybcio <konrad=2Edybcio@lin=
aro=2Eorg> wrote:
>From: Marijn Suijten <marijn=2Esuijten@somainline=2Eorg>
>
>Add the SM8150 DPU compatible to clients compatible list, as it also
>needs the workarounds=2E
>
>Signed-off-by: Marijn Suijten <marijn=2Esuijten@somainline=2Eorg>
>Signed-off-by: Konrad Dybcio <konrad=2Edybcio@linaro=2Eorg>

Reviewed-by: Dmitry Baryshkov<dmitry=2Ebaryshkov@linaro=2Eorg>

>---
>Changes since v1:
>- rebase on clean -next
>
> drivers/iommu/arm/arm-smmu/arm-smmu-qcom=2Ec | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom=2Ec b/drivers/iommu=
/arm/arm-smmu/arm-smmu-qcom=2Ec
>index 91d404deb115=2E=2Eed884c85e262 100644
>--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom=2Ec
>+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom=2Ec
>@@ -250,6 +250,7 @@ static const struct of_device_id qcom_smmu_client_of_=
match[] __maybe_unused =3D {
> 	{ =2Ecompatible =3D "qcom,sc7280-mdss" },
> 	{ =2Ecompatible =3D "qcom,sc7280-mss-pil" },
> 	{ =2Ecompatible =3D "qcom,sc8180x-mdss" },
>+	{ =2Ecompatible =3D "qcom,sm8150-mdss" },
> 	{ =2Ecompatible =3D "qcom,sm8250-mdss" },
> 	{ =2Ecompatible =3D "qcom,sdm845-mdss" },
> 	{ =2Ecompatible =3D "qcom,sdm845-mss-pil" },

--=20
With best wishes
Dmitry
