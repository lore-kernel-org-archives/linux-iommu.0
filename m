Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04061308A
	for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 17:55:00 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5634fbf0cf4so1642675eaf.3
        for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 10:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google; t=1687888499; x=1690480499;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KMDH1mlxwV2sLVWQuxFIR054U5xIxrFoM4b9Bswiao0=;
        b=bhv2tUNU2iTGPX6FqlVo3PZZoWxpv2x8hi1srmfXdLDB+wA77R3xwpagLS02aKWGTu
         nH44RpBB5uqk9mlUsTdQ3+BgRf0Wpx1uunj1YdPgGmlFkClfdGVqb7Zh0tG4SvCx9lvG
         pavLbGTcnIF10qIrSKFpRaJU9moYBw1u1/GSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687888499; x=1690480499;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMDH1mlxwV2sLVWQuxFIR054U5xIxrFoM4b9Bswiao0=;
        b=R8vdlTRGH32T4yFsmRo2PxaKUcBF3T6c91sGHb7SMAfCheQLJGqNEXNDWLkR0KAL4E
         8RMJo/0t1w65w06J6TMcJ8qUsbXj3IfqYikivQPORVGEfVb6ODNgb1DYkXNTwEgLpA+a
         uRcavI/HTbzta2Nhcp54pxnyBfXyBnbdY43u64DHSDfSmpNOae2dj74e90bLWNijHqX6
         KfyIZJAgPCZK0SeuH0MA0HKilLWRqrtzSJifjsyvtBM7N4R7tAApKdu+Pn+2uYvndryu
         +WCP9w0s+YaxsEzTzh1cq9G4j8oSQ3mE/LlNXQO3TZD900OIvTL/uV/o4L2R3aGLLHAy
         TYqA==
X-Gm-Message-State: AC+VfDyeScorgyso+/Dytq8l3A7qQ8IARyq6iW6c3xRXRhWqKa4FY2EM
	kNewryMb0PpJquxHO/GfwbAS3g==
X-Google-Smtp-Source: ACHHUZ5128JJUpofvc84U9QEvguT6ylxK0NPBUtGocO3qCpVL4swAAl6Xq4iRqzHQOelQG16lCO4FA==
X-Received: by 2002:a05:6870:c812:b0:1ad:1ce0:c348 with SMTP id ee18-20020a056870c81200b001ad1ce0c348mr15263035oab.11.1687888499657;
        Tue, 27 Jun 2023 10:54:59 -0700 (PDT)
Received: from [10.96.32.61] (137-025-033-021.res.spectrum.com. [137.25.33.21])
        by smtp.gmail.com with ESMTPSA id d88-20020a17090a6f6100b00253508d9145sm6879840pjk.46.2023.06.27.10.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 10:54:59 -0700 (PDT)
Message-ID: <30944ea8-d4aa-d0fd-7eaa-64b59e32eb6b@squareup.com>
Date: Tue, 27 Jun 2023 10:54:55 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 02/11] arm64: dts: qcom: msm8939: Drop
 "qcom,idle-state-spc" compatible
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 James Willcox <jwillcox@squareup.com>, Joseph Gates <jgates@squareup.com>,
 Stephan Gerhold <stephan@gerhold.net>, Zac Crosby <zac@squareup.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Xu Yang
 <xu.yang_2@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Wesley Cheng <quic_wcheng@quicinc.com>, Jun Nie <jun.nie@linaro.org>,
 Max Chen <mchen@squareup.com>, Shawn Guo <shawn.guo@linaro.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vincent Knecht <vincent.knecht@mailoo.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>, alsa-devel@alsa-project.org,
 iommu@lists.linux.dev, linux-usb@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Leo Yan <leo.yan@linaro.org>, Rob Herring <robh@kernel.org>,
 Andy Gross <andy.gross@linaro.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
 <20230627-topic-more_bindings-v1-2-6b4b6cd081e5@linaro.org>
From: Benjamin Li <benl@squareup.com>
In-Reply-To: <20230627-topic-more_bindings-v1-2-6b4b6cd081e5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/23 9:24 AM, Konrad Dybcio wrote:
> As of today, the only cool and legal way to get ARM64 SMP going is
> via PSCI (or spin tables). Sadly, not all chip and device vendors were
> considerate of this in the early days of arm64. Qualcomm, for example
> reused their tried-and-true spin-up method from MSM8974 and their Krait/
> arm32 Cortex designs.
> 
> MSM8916 supports SMP with its arm32 dt overlay, as probably could 8939.
> But the arm64 DT should not define non-PSCI SMP or CPUidle stuff.
> 
> Drop the qcom,idle-state-spc compatible (associated with Qualcomm-specific
> CPUIdle) to make the dt checker happy:
> 
> apq8039-t2.dtb: idle-states: cpu-sleep-0:compatible:
> ['qcom,idle-state-spc', 'arm,idle-state'] is too long
> 
> Fixes: 61550c6c156c ("arm64: dts: qcom: Add msm8939 SoC")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Benjamin Li <benl@squareup.com>
