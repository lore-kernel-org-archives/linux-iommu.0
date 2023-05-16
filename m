Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8435252
	for <iommu@lists.linux.dev>; Tue, 16 May 2023 23:22:34 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ac82b07eb3so86111fa.1
        for <iommu@lists.linux.dev>; Tue, 16 May 2023 16:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684279353; x=1686871353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F0lqRcsSsQH0bBfoyNKX+3AOqI8xO1VZEspaatlK78k=;
        b=uA7/LYKh5HNBNHXQxR6NRDVGEgME5E/5oAkzu0StP2gjzSumdlZ5g/rL//IZqzjU2A
         +gViSD7O4lfppe164q8n3Xky20BhzZGAf9iDiwAoTUlqsRsCx4UDh6Y/4F2Pbhdlqr7y
         yYeUOjhEnhKVEUFdeF5UPkS2h3e5qRfnS4HxxaJ5HaIUa+T1kYHvOhBXJczw9/U8vjEa
         hDN85Ae1svLt7wJIHQffrL0BDY/BTIN9Q+HdpgaykIIQbVNyGHRd8tDHTu7LnyBvKsIg
         aZw8IXL3rbqbK4RVyIEKRlyjXcgTXQjY6UuJ/rLJ0hPQ0Z1PI90sjmJFeIddz1YMZvjs
         ypXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684279353; x=1686871353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0lqRcsSsQH0bBfoyNKX+3AOqI8xO1VZEspaatlK78k=;
        b=BGqDng9RqcBzB78QVXSlWJrFNskHI9o8UbHpjlJf2kM8mxRyP4BYe6bbs7Rzrd/MrA
         Xzxb+KF8St91IOw5+Q2tvXIGHpJyBJa659SGgeFvYt/vHZD3XO51yUJz3k0TBnWkUmmc
         QIPEQyGxbB+E37BiSQKk9Ig2zoCU/mEP+w/WqAxBA4iuY+AM0Az44FP1hTC0ukP81HEo
         5SA3SmG7vmSZbnInSLiWE72c98EUuwFQHWXyta97i2mwRBaOUoz4kh7vlHbgEUT3xNOa
         sr8DOk2BjsktmSUaUWVFx285Bxd1vkk2xAYvu8UDpW77y0dJYIUPYeb/svrSMcvi0Tht
         TiQQ==
X-Gm-Message-State: AC+VfDxxIU/HyVjATQBTGcFtKZVTNamFUjTwCcrw62+BklXNNFfA6N39
	dfzc5rP6CJxS06BjfsNoyUesNw==
X-Google-Smtp-Source: ACHHUZ6pKQ/IyOU0B/3fMGnHOQ5asgHXtu0mkqxW5VGYBRoXChUBKHyVyTbPwB9oD8Q/wqE0YYfidg==
X-Received: by 2002:a2e:8851:0:b0:2ac:8e69:c06d with SMTP id z17-20020a2e8851000000b002ac8e69c06dmr9126360ljj.49.1684279352762;
        Tue, 16 May 2023 16:22:32 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id e4-20020a2e9e04000000b002aecfa8c58bsm1321531ljk.40.2023.05.16.16.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 16:22:32 -0700 (PDT)
Message-ID: <fdd07b5b-a3f5-0cbf-0d71-602d0b3b9847@linaro.org>
Date: Wed, 17 May 2023 02:22:31 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 1/2] iommu/arm-smmu-qcom: Fix missing adreno_smmu's
Content-Language: en-GB
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
 iommu@lists.linux-foundation.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Will Deacon <will@kernel.org>,
 Rob Clark <robdclark@chromium.org>, stable@vger.kernel.org,
 Lepton Wu <lepton@chromium.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
 Bjorn Andersson <quic_bjorande@quicinc.com>,
 Elliot Berman <quic_eberman@quicinc.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Melody Olvera <quic_molvera@quicinc.com>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 "open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20230516222039.907690-1-robdclark@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230516222039.907690-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/05/2023 01:20, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> When the special handling of qcom,adreno-smmu was moved into
> qcom_smmu_create(), it was overlooked that we didn't have all the
> required entries in qcom_smmu_impl_of_match.  So we stopped getting
> adreno_smmu_priv on sc7180, breaking per-process pgtables.
> 
> Fixes: 30b912a03d91 ("iommu/arm-smmu-qcom: Move the qcom,adreno-smmu check into qcom_smmu_create")
> Cc: <stable@vger.kernel.org>
> Suggested-by: Lepton Wu <lepton@chromium.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

