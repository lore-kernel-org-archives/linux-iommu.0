Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33AE1FDA
	for <iommu@lists.linux.dev>; Tue, 16 Aug 2022 07:49:03 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id f20so13698918lfc.10
        for <iommu@lists.linux.dev>; Tue, 16 Aug 2022 00:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=OWzEWZaxyxOuDUG77wk5x1RGXvDnyDigjIAWDCcNa50=;
        b=CP1SJ1WCfBQTbSs+JNdpd5uWIIWOz8Jb8vnE7FWAWuSq59Yw/w37A5RWLfljFndIHa
         Jl47Lr1GQqwc3pA2UdAQ4ay+qnswguoef8YolXVncCvnkoXLNFB/5Ijivs1e/muPp/Ts
         FCihLDDNgWHjyAmzkqZJQTNOGemyzQvEzBiv4KBeXlYMJT86Ea5DPH6LSTk4Puy2nINh
         1ozyypJj1CJzGB+SYAnzAi4ZgC9H8dJ50YeLgqA3d33XqLJpLgPaNOlzAOI57xySfZFa
         YN0HkZygzsBdpF2VLkj/XULURUhlJrtHaywC3ZAhXs+px9HZh+v2sYeN4b/qwZI6QtZE
         Vxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=OWzEWZaxyxOuDUG77wk5x1RGXvDnyDigjIAWDCcNa50=;
        b=8G5exKXiAwGAvndvqbVOp2xvVdvWPCGd8/QjhFMVe4UFi/8eXTiismsALYnGbBsAmi
         wb5UqfPbA94aCPRGVHqjAkn6a2Xu7zBr3nWud9fx8wKNiMBfJIybj2rFW1UzqSBSSj8c
         XKXupFKxybAvZ+eDNERShBGlqScqhEBOSBxOHUe3NDBVic/5dRZCU+OLgiX7+Wy/DZgz
         8ErEPFwPW0e9dH79aVoocztbwciwp2qOeU2objQCI9casxf2GTNJAnTwEQdraiaekmiJ
         GJ0jK5WzNYz6XXrI1WLJ9YAlITVmWvRzfuK66PnwSLSODnDrIejjlnmWOoAFlFrB7yNF
         ECLA==
X-Gm-Message-State: ACgBeo37ChroUMQEXnNE3p23onFwDcFv3iqE67eRJSh/THrarpXIlNks
	JNwPAhUMoawIGIYbQ/BKvNJjJA==
X-Google-Smtp-Source: AA6agR5ql1UCM6jh0XKUGnlAiHiqXduAtZTrJfQZ4cfHKMl6uCLp6yMnP9THXPVGKy4dJsgFSps1eQ==
X-Received: by 2002:a05:6512:15a7:b0:492:85af:e9f7 with SMTP id bp39-20020a05651215a700b0049285afe9f7mr3727101lfb.1.1660636142100;
        Tue, 16 Aug 2022 00:49:02 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id z13-20020a05651c11cd00b0025e4fcadc72sm1692159ljo.92.2022.08.16.00.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 00:49:01 -0700 (PDT)
Message-ID: <8c970e9d-3179-6fe9-3773-ce9d58d80be4@linaro.org>
Date: Tue, 16 Aug 2022 10:48:59 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/7] dt-bindings: dmaengine: qcom: gpi: add compatible for
 SM6115
Content-Language: en-US
To: Adam Skladowski <a39.skl@gmail.com>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Andy Gross <agross@kernel.org>, Bjorn Andersson
 <bjorn.andersson@linaro.org>, Konrad Dybcio <konrad.dybcio@somainline.org>,
 Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
 Loic Poulain <loic.poulain@linaro.org>, Emma Anholt <emma@anholt.net>,
 Rob Clark <robdclark@chromium.org>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>, linux-arm-msm@vger.kernel.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org,
 Stephen Boyd <swboyd@chromium.org>, Sibi Sankar <sibis@codeaurora.org>
References: <20220815100952.23795-1-a39.skl@gmail.com>
 <20220815100952.23795-2-a39.skl@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220815100952.23795-2-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/08/2022 13:09, Adam Skladowski wrote:
> Document the compatible for GPI DMA controller on SM6115 SoC.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
