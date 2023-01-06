Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104E91869
	for <iommu@lists.linux.dev>; Fri,  6 Jan 2023 12:54:25 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so3475722wma.1
        for <iommu@lists.linux.dev>; Fri, 06 Jan 2023 04:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oAcEY5QDOfkdRSnyMYTlvLW8Pg0hIuO9y1yVmApVX1w=;
        b=xAc1OdRgkSK0ibNTwmMxA2vRKezTYCAkbSa1Kdhdm0wiV35B/X5tMCfo1pddCcp5oN
         XOY+BLDPn9BHWVsMLXSP5/krZUEtfLfpZhoCVncsjvaziXnC34KYbE9fdr+2FY023FTO
         l93s8vY6VCX42Cxc7D4kBPvBxkE6bc/QsJFMcqijKQn0iZI8afVjzgqEugKhFllGGpeQ
         25YatiF1j8W6gs4+2J3Cghw2FG9sDAWUFdEuRo0W8C+qW5mO2dmR+xubTYFTqGyK/Gc1
         TmcbLMsqNGsm5Uakm7WtpLE7xj/IEpPXdbrqzXdrK7rYwvFK+8vjlIXNkNO8k4usXEG1
         APTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAcEY5QDOfkdRSnyMYTlvLW8Pg0hIuO9y1yVmApVX1w=;
        b=lHO7Bxq8lPl8JmTaSvIU6g3jnWIfXXRdI6dJ6bUruUKB67qQFIGA0vG42HOYm0IHHV
         PpzHKwiQfEvEoeuXs7FMyqZCRImpUiS5f+5Kob1vigKDVBxXdxMFBthQUmZISYQHt4DA
         ZpxKoinZ350cXzuSICMarA3r2zj/yHMqzylzl48qz3mU+YkfVdtSfH9mb/sm/3pcqHKZ
         t7bi50IkhyKh3eN7FcxvNzpIvnv2DPSGqaBD2xPcmolY8R1uPNNS/6Q1fkJDHH5KGrij
         w7puYV/1/4YjXUMQ+B838skT/xeDgMV72+bjbVhU5q7zYQeATfZQHn9XUKSzcL0Xxe2P
         GJKQ==
X-Gm-Message-State: AFqh2kq35pMjiL6rclQKPeWddmj4u402fsfp02aIqlogxO9swxFEBKH+
	8wTmSKdHfReTIoJLQhMfkv0q0Q==
X-Google-Smtp-Source: AMrXdXvY41dETmYzEjIuz328GjPEwBw9xuksu6v0MUxjxupPBzuhjweqXLUquS+fs1oYcya4bPnS+w==
X-Received: by 2002:a05:600c:a51:b0:3cf:6f4d:c259 with SMTP id c17-20020a05600c0a5100b003cf6f4dc259mr38182202wmq.39.1673009664393;
        Fri, 06 Jan 2023 04:54:24 -0800 (PST)
Received: from [192.168.1.102] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c458700b003d974076f13sm1853882wmo.3.2023.01.06.04.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 04:54:24 -0800 (PST)
Message-ID: <29d2fc29-4075-33ab-e750-2891e837215a@linaro.org>
Date: Fri, 6 Jan 2023 13:54:22 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/7] dt-bindings: iommu: dart: add t8110 compatible
Content-Language: en-US
To: Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig
 <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, iommu@lists.linux.dev, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230104110013.24738-1-marcan@marcan.st>
 <20230104110013.24738-2-marcan@marcan.st>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230104110013.24738-2-marcan@marcan.st>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/01/2023 12:00, Hector Martin wrote:
> t600x SoCs use this DART style for the Thunderbolt ports, and t8112 SoCs
> use them everywhere. Add a compatible for it. No other binding changes
> necessary.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

