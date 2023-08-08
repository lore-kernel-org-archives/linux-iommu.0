Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE18A12B6C
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 15:10:51 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-98377c5d53eso799497466b.0
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 08:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691507450; x=1692112250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FFQCxsSM2uVo6fho+aJ/OGP5I8Vv4VqgpwCByYL+BHc=;
        b=o3hNeAR3gsFsAZWRhFBx/onsAPl/wKluHqClQpX+bjenaV/LKQVnsJVbBrMv+8bYvJ
         Pe7XYVxdXC4tW1dQzTzjDwsWDqno3Tw6UrrDgX3BadL8pVJfeuqpa4g7w4JcC2Zxqxn7
         C4MXQ6rjmQt2ilP1OlsFcTwLo35UARaKLGnzAk7yX6zrtRSbiM6XFROHMXl0K/JdAjsm
         HqBJgZtMtoUe/JZOGjFvW/coLUtEqFX4QVLRe6K+bCZeFOCKNvC8qEleIYlz/oXMX09q
         RDS1BjGpfuqUi0QJlMaC3V6FWwF3KReKIVXxQrN2ODsunRbR2K1oCr8ULCUvhzOMleUm
         4e5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691507450; x=1692112250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFQCxsSM2uVo6fho+aJ/OGP5I8Vv4VqgpwCByYL+BHc=;
        b=fI3Ef78On/ShEJLsfmDNUzPJZ9KThxRJeGaGEfqWRqB90/HHmHCjTi47/ocvupmG06
         06zAJ5UmtegOyLsTzT3aiYWBmJ1HeDwcMgx/i0sAgppCT1ftn/pJHmg4Lm1MpAa003lC
         70CBUJ3ZGoehAXtLcFxs4HVYCsCQyFKt5b3GzEDKXC0VYgzWNbmY2Pj6CH8QmiDUITm4
         Na171cTwvtfFYOHlg2V1espwg7MyT9saeqyKqy4NDpL/Tl0/LmrJrO5cAlGVW71Y9uRU
         PX4Tf5XjgZSB0JurrhPaYdSIrHchsMBwcealnlnLh1xlXnYvql5sWeqPSQAJBOZquZOI
         bPTw==
X-Gm-Message-State: AOJu0YzABdcmklytJbC0PYH2Lu0HQRFjSXK7y9vmP+SMeePNRoGu8rjh
	/YU1hEYzZDqKiJp7OBSnZ2Yx7w==
X-Google-Smtp-Source: AGHT+IGHV9+UYzYvn5Ls/Ez67OotAAo6suz5ZNdonadR1VetzpLzmLYFNFXgqtoLI29IJKXXrA9EdA==
X-Received: by 2002:a17:906:220e:b0:99c:7333:199d with SMTP id s14-20020a170906220e00b0099c7333199dmr11376507ejs.30.1691507449835;
        Tue, 08 Aug 2023 08:10:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id y25-20020a1709063a9900b0099bc80d5575sm6773608ejd.200.2023.08.08.08.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 08:10:49 -0700 (PDT)
Message-ID: <f7f9b3a6-7ba3-3ac1-eb8f-4973d31690f4@linaro.org>
Date: Tue, 8 Aug 2023 17:10:46 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 6/6] dt-bindings: arm-smmu: Fix MSM8998 clocks
 description
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
 Imran Khan <kimran@codeaurora.org>, Rajendra Nayak
 <quic_rjendra@quicinc.com>, Joonwoo Park <joonwoop@codeaurora.org>,
 Jeffrey Hugo <quic_jhugo@quicinc.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Jami Kettunen <jami.kettunen@somainline.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20230531-topic-8998_mmssclk-v2-0-34273e275c51@linaro.org>
 <20230531-topic-8998_mmssclk-v2-6-34273e275c51@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230531-topic-8998_mmssclk-v2-6-34273e275c51@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/08/2023 11:44, Konrad Dybcio wrote:
> MSM8998 was abusingly referencing one of the internal bus clocks, that
> were recently dropped from Linux (because the original implementation
> did not make much sense), circumventing the interconnect framework.

Please mention here that effectively you are dropping bus-mm clock and
the rest is the same as before. It's not possible to figure this out
from the diff alone.

With updated commit msg.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

