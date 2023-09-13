Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B932CAD5C
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 07:18:01 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso8540421a12.1
        for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 00:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694589480; x=1695194280; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5E2GWmaKgMk9eaNY11kumMiKx9QbIcNvdM4XUjWrJ44=;
        b=qzAxZjvBsdL/B2mA6EZ/My4P1Lz2gybSMwpJZYKg734k843TgPtXEKwDk5XD94Q87B
         c0ogYidhzxfT+Pbxr+YRWc9bhaRguI9eL12F79Ql1JD1xwMBdp7Hb63x/whlCFtBG3tr
         EbS28/3bmPnhTckJAR3RzzTZv9zCzTw/+XEONuGRezWMEvg8SlXPzR9kY0kziPzUunSq
         hncfPhwkm/BV24FR+KY5b+XIs34MwN0wN/NdnYouS8+WCc8dGkYhcl1XycO8MVpT18l1
         bA7gIRPCrSz+NP8dVvP6q64Y0seTVbk+rb3Knrwn2iJi8WSImMusgfIg12AsYwmTcOH2
         RQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694589480; x=1695194280;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5E2GWmaKgMk9eaNY11kumMiKx9QbIcNvdM4XUjWrJ44=;
        b=TsAaDBtBt4M1xIqsYqajmWal1gMWQ4VZCklXbOFYD5S26rjWswnNHpfFPmGjLcjOFu
         vPOxI0uQumVntlkLLvA0iCp4jfnGAVgXS0vOYQKG/ttgBAqbW/UhPmhH8goTcBQGfUjs
         RR8o4HulfrQYnOnuMt3B/jSaEr3oip4qr5eKwUznHmVAS5IsgAttuXvv4Hkyw5DoPiub
         iXzkfa8J8CAQyixCQJgamzSIbxUcvunCXwXFSuRmkAlQJ5Bwvta7V0EJ9IQSJCItDxT7
         5vpEneiWUxC0WxqTqbxRTi86aoiakQ8hLdlnM8Pyh884wmqCw7r97zicylnQLbND+jNX
         x1sA==
X-Gm-Message-State: AOJu0YydLkyDTV2Xh5kgOTVOdZg8OoDIYf14pa2R0dCjuSx1PoWDFDTr
	XVIrTIkaY27YD+E7p3Z0dkkHEQ==
X-Google-Smtp-Source: AGHT+IEIxkxJMHTHddH6e9vxURb7vyya0U8l8ijNR3g0bzw+qT3mlAGtTd1Mz3CsBWlsWVc9jIz9CQ==
X-Received: by 2002:aa7:d1d6:0:b0:525:528d:836f with SMTP id g22-20020aa7d1d6000000b00525528d836fmr1588780edp.18.1694589479936;
        Wed, 13 Sep 2023 00:17:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id bc3-20020a056402204300b0052348d74865sm6702364edb.61.2023.09.13.00.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 00:17:59 -0700 (PDT)
Message-ID: <c4420c00-5c45-c46b-ae73-15c6d8af0694@linaro.org>
Date: Wed, 13 Sep 2023 09:17:56 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 14/14] arm64: dts: qcom: sdm630: Fix USB2 clock-names
 order
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Sibi Sankar <quic_sibis@quicinc.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>,
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-usb@vger.kernel.org
References: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
 <20230721-topic-rpm_clk_cleanup-v2-14-1e506593b1bd@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v2-14-1e506593b1bd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/09/2023 15:31, Konrad Dybcio wrote:
> The last 2 clock-names entries for the USB2 controller were swapped,
> resulting in schema warnings:
> 
> ['cfg_noc', 'core', 'mock_utmi', 'sleep'] is too short
>         'iface' was expected
>         'sleep' was expected
>         'mock_utmi' was expected
> 
> Fix it and take the liberty to make the clock-names entries more
> readable.

This was already fixed:

https://lore.kernel.org/all/20230723141849.93078-2-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

