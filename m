Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00DC4A07
	for <iommu@lists.linux.dev>; Thu, 18 Aug 2022 21:34:34 +0000 (UTC)
Received: by mail-lj1-f181.google.com with SMTP id v4so2931668ljg.0
        for <iommu@lists.linux.dev>; Thu, 18 Aug 2022 14:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=57R1i97Exb7jiv3R+C+sLGgx2BChX5wJqOqueGuOy8o=;
        b=BpRf1j8XsCn/7ww8tOLJtJpEEyVf9B0Nkp8dZSfI90CLV5ieBJ3CDZMbPVxru2yVXz
         1l55Td1/RKqMyoMByybvH6bmTKczz2GHoaAtHV3VWUl3Y00PEJ8XFZO2YaqWKSmIgtUO
         q0beRrI68dYUftzgYBU/HmlW5n9hFBxIYlEfcaydSVpzwzwllso/sppoPR7KJBMe+EZu
         sd1gzVfaHnCD4gk5nvR/JfMkFXwk0yspHGUUoH7MJf/iiQzWqV+kFVBxVoPioup37F4u
         +uk0PDEXhbotpzeLvczvh3m7KQm6I+UvCmXb5OPqZ20iZ6mmdKFkbICd257afSvtVG5c
         3vyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=57R1i97Exb7jiv3R+C+sLGgx2BChX5wJqOqueGuOy8o=;
        b=4XM0T0xudeQLHgWV3hu52i+Wvu9AlcgaFIjGwQMO2gb4gs2h9uPzTOAwVQLo0pg1yX
         oObfyAFJo+Se6iZthtsBymB3qUhekTOcIY8tudBTz8h82LWA/tvubp36x3vGyvCHvZiP
         VmBwBBQ0yt5Ua2LAH+ADLbMBXbBiF37O3EWwZzjBZHHmxtmoi7JdDHYYQ0lrpQQXlXW6
         3llEgTJnPUPK5zKuaIAnoaFc/B4Pcp8To1gsWSrbmlADY7zIXX1/qjuw2v67i53Scmq1
         IwXNBjTIl2Tv9aOAc9rwNf9t+IfTzRLS/iBWTYsaTNH1iHRfUtrVBEo+q1eOvR6FUeMk
         Zn2A==
X-Gm-Message-State: ACgBeo3rIcVga2AwTDvfTJOHhLpobB/mX+yjhrO1fqK0B4EiTXYZmxUg
	gK4hDqUJ4LmM5DrwfgSfSVblsFJZfxTwtlUj7aSpxg==
X-Google-Smtp-Source: AA6agR6GJXPp5/z0JTiP0q9mPDVCKJiO4ywyVq/9cFPr4MM0zelM0e/lZlpgvN0Odpiov3nkO1VEAYbE8La/yBkG2AA=
X-Received: by 2002:a05:651c:1718:b0:261:8700:25f4 with SMTP id
 be24-20020a05651c171800b00261870025f4mr1333316ljb.229.1660858472545; Thu, 18
 Aug 2022 14:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220815100952.23795-1-a39.skl@gmail.com> <20220815100952.23795-4-a39.skl@gmail.com>
In-Reply-To: <20220815100952.23795-4-a39.skl@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 18 Aug 2022 23:33:56 +0200
Message-ID: <CAPDyKFrc5aneqqC=uGKeQ0ROx69eMJhQ1pFA3GN8d5NpXHGEEQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] dt-bindings: mmc: sdhci-msm: Document the SM6115 compatible
To: Adam Skladowski <a39.skl@gmail.com>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
	Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@somainline.org>, Vinod Koul <vkoul@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>, Loic Poulain <loic.poulain@linaro.org>, 
	Emma Anholt <emma@anholt.net>, Rob Clark <robdclark@chromium.org>, 
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, linux-arm-msm@vger.kernel.org, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>, Sibi Sankar <sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Aug 2022 at 12:12, Adam Skladowski <a39.skl@gmail.com> wrote:
>
> Document the compatible for SDHCI on SM6115.
>
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index fc0e81c2066c..a792fa5574a0 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -41,6 +41,7 @@ properties:
>                - qcom,sdm845-sdhci
>                - qcom,sdx55-sdhci
>                - qcom,sdx65-sdhci
> +              - qcom,sm6115-sdhci
>                - qcom,sm6125-sdhci
>                - qcom,sm6350-sdhci
>                - qcom,sm8150-sdhci
> --
> 2.25.1
>
