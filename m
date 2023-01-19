Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE87517CD
	for <iommu@lists.linux.dev>; Thu, 19 Jan 2023 13:36:19 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so3615268wmb.0
        for <iommu@lists.linux.dev>; Thu, 19 Jan 2023 05:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rWq/yizVAl7S9V3ovhWY4OsnNwxPEQxeEtQ2nHLCzTM=;
        b=wrNU5GWnr3H3PZs0TZnwnMwYLs7RV49edZQYX8aLXYI+JXQdKOizHSG8dXmZzBN00o
         tZ4oxffn+7chO5VHoAIQeXuJTOKKwCEBcD76xggxuVORvAbk7qUdK/Q5zljj22Txf8Hc
         dPFwyXvkrgLPZwcU9785swysknOCy8VLQsAGVz/RJ/gTvZSOzfWR1N0I/I46Z7KW2t2q
         l25BA3O8GwU/ctBsXouUIYzw3LvnLe/VVDMBDkCyhgt5ZvAz+nAfuF1406sorpWs4GpJ
         4vi8Jgng3X1si/0HSIolJ/lIk+7o+UmA33GARzfeWZwtm92CwJ1MQAlCX1L2vyX/rVsm
         o+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWq/yizVAl7S9V3ovhWY4OsnNwxPEQxeEtQ2nHLCzTM=;
        b=TJp7h6fw1o3SsHo8vQ83fy1bU1h35gJrQ4f2Kw6VA/Ad2GiRhgVSVFGGIdIlst7Lpz
         s5G9rfg35jCYgB1CXgxRJ0XCcxVsSqMMfmmSw4kWJAuyDIP9sOn3BobsAL3xXVKySLLL
         lSdfN2Tkp0bHWydmuCgQGecHUF59PvuLGpdIEifu6qiBGiQzO6PJUpnQwIjDyJnK0etI
         Z63YYj+ef4tDOyEEOE2l1YJCGjwa/uhtjKe4hnE6kIizqKX1xICPPxGuCIWCRS8CB938
         wdM7G46OSSrLttqSpJB/NYGIKj7e08xfxvzHRgTekVn1CaAvTMz8uGe/7H6lLqR9IWCC
         LFIA==
X-Gm-Message-State: AFqh2koNh0R/v28tvTE9r+PE9MNmUh9F4iWvv/6oCOJ+a4syL5i7rvXJ
	CBEE16LRlSHXKwOBfGNt8fjpxw==
X-Google-Smtp-Source: AMrXdXsKjSmcqQHPHyH1l93tp75nCJ2mRi+NoOakU7rVj78hivbHOkzI2srayBQye1ppwblDbCeEKQ==
X-Received: by 2002:a05:600c:5386:b0:3cf:9844:7b11 with SMTP id hg6-20020a05600c538600b003cf98447b11mr10792603wmb.23.1674135378084;
        Thu, 19 Jan 2023 05:36:18 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d3-20020a05600c34c300b003dab77aa911sm4731569wmq.23.2023.01.19.05.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 05:36:17 -0800 (PST)
Message-ID: <760c9404-62b7-d3c9-4407-4665b1e336bb@linaro.org>
Date: Thu, 19 Jan 2023 14:36:16 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH resend] dt-bindings: iommu: renesas,ipmmu-vmsa: add
 r8a779g0 support
Content-Language: en-US
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org
Cc: iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20230119133514.1008925-1-yoshihiro.shimoda.uh@renesas.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230119133514.1008925-1-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/01/2023 14:35, Yoshihiro Shimoda wrote:
> Document the compatible values for the IPMMU-VMSA blocks in
> the Renesas R-Car V4H (R8A779G0) SoC.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml | 1 +
>  1 file changed, 1 insertion(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

