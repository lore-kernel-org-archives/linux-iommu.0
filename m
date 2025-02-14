Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0816F201271
	for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739518059; cv=none; b=hSRpRjhu9LZQcNd5o1nvcmkw+Pc8lVSexowYR6+AJC006aXEY7YxHdqbmSLp/2/N2OPxhKbJXm9N4eVV8V/N/OtZMmiK1lv6gvxjuzO3jcxzezgFL2MtWhNqk5/0BLxkQMzhzKzGs0gwJvmAcbMOcCku1cRZm7dQJ5AzvXZC2/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739518059; c=relaxed/simple;
	bh=a7kJ8j1jEvuz2YzSHbabkizHAC80oIWnpGDwLIh+8kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvUMBJoAYwE78sERBr/djploysqCGlagYCheeE9HCg88+/2KE2m5q8A+691PmvQ9AYEzenNWBYM5hmw/CXe8pysEGxKdXlOFxFbONL/OYb9HHbdr7oUi1PI0w0DkAeZj60oJjldEXUuNHBHIgRtG+azCu+mOPH4WkAJ75zKlMa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fPT7mkqe; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fPT7mkqe"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4396590c614so1402585e9.1
        for <iommu@lists.linux.dev>; Thu, 13 Feb 2025 23:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739518056; x=1740122856; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1im5jr/ddqcNKC9+Jp3mOIVJm986PTE6Kc8N1Bsp3/Q=;
        b=fPT7mkqegz1pOgYBudfHfxveGQqok9Mz3yfbP3M4vAi6IXONIF5HUa8jAfPz1GOU8B
         GYqW0vRgHxeBQpc9HmOZ1Zo01wV/T6L+C+M6TG5VLLyomp7nHKS8iDEFZlAc9bLvD3B4
         aABmE6da6z8U5WRU10hFJ1GDAsrmnFIkmBOkM4MwfjFUHoCYuGpQJYLn+M4g/c2yrH1N
         ItHg+YQYqX3XPAyIMeLNlDAFLIFpCkykVxIwA+IJ99afy1MQ4VN7qh55prTU/dnY6e8E
         WtkvjiYG18SDKBr3Dt1Uq7iWMEo0pXEPfzipirFHg7R4YXwOUPS3//nKREgWqR28oFU6
         7CYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739518056; x=1740122856;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1im5jr/ddqcNKC9+Jp3mOIVJm986PTE6Kc8N1Bsp3/Q=;
        b=uSqvlEcHT3nCRac0ZWHrazW3tI/ArU4Q2XNexLuTmZKVcPyjHxkvWc6ivI20MA4+ZC
         m6Ae61KT/XZr/jPkFEXPZQiXUtkLnttvR6eGxuSgVDJgD1zDTAtYu61iLC8NyCNgtjas
         BQuPW20Rvdr9PZx2h8KjWL4wFmLV/g36CUOOkAAQ6n79JMU3yxm5LC2j1lbfXDl13Ade
         m96fcUCVv+q4S7LkWnhhF8aDZlTbXEjRzkZDUe2REbq+umiwkO9W+hCAX8waXETDFhuK
         +c/cs/lbcnF3n4Fe+I9ME+VjWolRti0niKdA9JUBzOn32v9ZcKNtqwHNrx9oW4QwV4QJ
         xYXQ==
X-Gm-Message-State: AOJu0YxyeI4OBI/MgsZ8C2/PiyjmXg4tiSgx1Qy0nE+6TSLcr1QO/gRc
	2bYyFXSJh9Kl80Ga3uySbWpjrJ2PWusvM0OFmGndhcFyF1nkQehK5A9HspqRKzSQjK/lXHWfy1o
	/
X-Gm-Gg: ASbGncszvaqz9z7LfmP3oh9MDCP3h7xmt5BmrkFeQpoUQcf9zu4tE8qUs7lKmbgU0wK
	utEamDr1tmbizRJabLLs9VWQ3jE4X+5WVxxh3EFtjX8oN9jFnMliyKm2mi3ZfhYgnbVdxs0b8eZ
	z9ANZ9oONy28W07dDTXS5ObEhuVJkh3vLoLds2YuVyVYDRF2Vbw4xXCO3GbrBEWcj2te/zqxEfo
	RQlxAcz4/EBwB/NiH0bEVyzbRsZ/5YOQ5WTT668S7spKt5zYaPeX7mA5+La+caF9VIbaMZfcH46
	mQzXmyWdvu29lt34uTmzr90YOAW6/VC4/50=
X-Google-Smtp-Source: AGHT+IH7/enHB0b8VVnakGnUMLsCMc5nvCM/CivMMVM9hZIt2oCyvx+f5hyUkTWYb1OSJ6o/r0eM1w==
X-Received: by 2002:a5d:64ef:0:b0:38d:e472:e6a0 with SMTP id ffacd0b85a97d-38f2c7f7e07mr886032f8f.9.1739518056271;
        Thu, 13 Feb 2025 23:27:36 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8273sm3764464f8f.89.2025.02.13.23.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 23:27:35 -0800 (PST)
Message-ID: <81b449b3-32fe-4f7c-bcb7-8c0f080ff667@linaro.org>
Date: Fri, 14 Feb 2025 08:27:34 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/3] iommu: omap: Simplify returning syscon PTR_ERR
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250212-syscon-phandle-args-iommu-v1-0-c3fab486b426@linaro.org>
 <20250212-syscon-phandle-args-iommu-v1-2-c3fab486b426@linaro.org>
 <dd1b7ca0-ef9f-4b9d-bca1-8a72c22231bb@arm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <dd1b7ca0-ef9f-4b9d-bca1-8a72c22231bb@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2025 12:30, Robin Murphy wrote:
> On 2025-02-12 8:19 pm, Krzysztof Kozlowski wrote:
>> No need to store PTR_ERR into temporary, local 'ret' variable.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   drivers/iommu/omap-iommu.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
>> index 04a7deaaba25cb270eb6eeaf6a21030440f78a5e..bce27805805010ae473aa8dbd9e0cb903dd79bba 100644
>> --- a/drivers/iommu/omap-iommu.c
>> +++ b/drivers/iommu/omap-iommu.c
>> @@ -1123,7 +1123,6 @@ static int omap_iommu_dra7_get_dsp_system_cfg(struct platform_device *pdev,
>>   					      struct omap_iommu *obj)
>>   {
>>   	struct device_node *np = pdev->dev.of_node;
>> -	int ret;
>>   
>>   	if (!of_device_is_compatible(np, "ti,dra7-dsp-iommu"))
>>   		return 0;
>> @@ -1132,8 +1131,7 @@ static int omap_iommu_dra7_get_dsp_system_cfg(struct platform_device *pdev,
>>   		syscon_regmap_lookup_by_phandle(np, "ti,syscon-mmuconfig");
>>   	if (IS_ERR(obj->syscfg)) {
>>   		/* can fail with -EPROBE_DEFER */
> 
> This comment is no longer correct or useful, since it's alluding to the 
> check which you removed in the previous patch. I'd just clean up the 


I wouldn't call it useful ever, but I assume someone wants to note for
themself how syscon lookup works...

> whole lot in patch #1 as it's all closely related, and also turn this 
> return into a dev_err_probe() to capture the spirit of the other errors 
> being replaced, perhaps something like "No valid ti,syscon-mmuconfig 
> available" - that way it adds some value for debugging probe deferral 
> issues more than broken DTs.

Ack


Best regards,
Krzysztof
