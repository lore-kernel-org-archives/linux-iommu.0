Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC96210185
	for <iommu@lists.linux.dev>; Thu,  1 May 2025 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746117556; cv=none; b=bGKG/gNdxOssWmo4FvpWxmXbleUToJKdGE3OKMN80ZntuPGvLSwrIx+H4ZjQYk+ziO5tQvEjB+NI9peJubs8hXUWlOd+RJew6poTgUOsyJ0eUi9WJhmoXNnGZa4Mh9g81yCd72QDuJY2sqzyT4KKw7bH53J936niiqwNK9BnPzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746117556; c=relaxed/simple;
	bh=OhXqVvV2jok1I00N0CwDqLUrzDi937D39pRWFVrmM+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=klpXyPT/B92fnA8lAjYilaKaxv2O8Y/mmc3xmHl5+NPxqs/YfT0mb/rb4KMxWGFdSPkXu2SodeoJQO5t3dlmuBirBMPR4FZxQOIDjAXAV3uH+s6Jynk4BwYnw607DFfMQS27Q8RG61K1OUMefhaalAP0KIeSyXJfBHX1YzEL1M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hg0iTgZh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hg0iTgZh"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d16a01deaso1509805e9.2
        for <iommu@lists.linux.dev>; Thu, 01 May 2025 09:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746117552; x=1746722352; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=blFO9nj94W2sQqi74hSHTooSl7uV3ZKhQoJ+90nLCFw=;
        b=Hg0iTgZh6TWtNUHX1g6CHvy2RxcXclKXZMnkZKOQEm+IVMuRaOx5Ry+Vo4NoGCey2o
         B/JZhxg32JDJCzguwiklt2A0ShLdxbKPOKWIHD0XMpggae+j5nN8VBxYRZLTcgYmRfJJ
         zQU/KtBIX4ASI1X2p2qDUCwWVBe39ZNBbR08dFyYc7UmSRbt03AXOaOa+1fCw+zQX+Qn
         7cZo3SBpXGjlAFYQjwm8fnqDajEAnjrQz3LqZIWHDUJIHZXAE5auEq42LSv4ZTx3vuf6
         Av06VaqLJMBQ9CnJT4PI0swutxVPh48YVxPrHVXQyqwh32t5NYAfvgCPJ8d58cz/S/7L
         6KbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746117552; x=1746722352;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=blFO9nj94W2sQqi74hSHTooSl7uV3ZKhQoJ+90nLCFw=;
        b=T0EpHRszGY3G9O9gFwaCysxjDQdk3Ky+pGSWtEEzls9Pz/aunxIqlm3QTyhjNJjh4n
         H0wAwfQerFFwMBlI63K66TpDChgecQqnCcSHsWfzqBnBo29Id25jFsn1N3TuZNkM5lQ5
         UnwRualsGlwdGZNgws6/vsptDE0rHRumzUVJJmHBj87sYfkTy/1HgMAwSbpCAQiagH40
         e4AJn6kxahpBBVEdcV9WKnm9qmyLsaBwF/7OW6TYuN6zUXeMUCSP6R2BRqt6tsV+AuTu
         AH2D1xTQY/ztX1xZpPwlOswxna5Vr1MgaT4wrjF0Ur1i9/GaU6+Pi4VLtFdGtWbV5vNL
         ijnQ==
X-Gm-Message-State: AOJu0YwQkCxWHcfgONaeKkc4n6pWkg+BprBIV04uzVzX9iNtiMYPLvga
	rpbRtfm05g/9NO7tLLNq8y/hPalceeVfuajxK3nLZdPyYYwXOtyCZZWJw+MJvWQ=
X-Gm-Gg: ASbGncsEBY2fhkG5wYT3bydNS7vHF/uKMPbtTKHZb9a7VjaemOD9EYUrvA9lGqtvuI4
	rDmbvyMZF08tdPqX/0l3jI9d4K6Jq9ZWNWEnM1ktWtIvpqN9BUAyDMg01ohLdI98JcmJgUBLw+3
	wOgIpxj5VcxCPo8mQZFwmecxfQUthxia8Lwsj5Vu+xZ6azgC3UGRljqAD8ASTMm4kaWB+VQmWop
	kBlgakoadkGs96ihJGvg2dBiDpK8tVlcH8odsN40XwjykGFA0HlzMsgU6GbS3r2PIAppI0JI4US
	cQaLrZAF16ZTwzajiFyfKmiZO1szcQkcY8hY6qeh9NybJho4lVSKq/8XQj+839R6M5vuNg==
X-Google-Smtp-Source: AGHT+IFHLM3Gn90P1rxzB0WphTkEncIZiEbe/YA5FpOViIqbhpj9J1eXj04iTVLfCmwcAEk/SUFj8Q==
X-Received: by 2002:a05:600c:46c5:b0:43d:745a:5a49 with SMTP id 5b1f17b1804b1-441b2dea5cbmr25205735e9.4.1746117552581;
        Thu, 01 May 2025 09:39:12 -0700 (PDT)
Received: from [192.168.1.28] ([178.197.207.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89ed4f5sm17693655e9.18.2025.05.01.09.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 09:39:11 -0700 (PDT)
Message-ID: <53e51779-1e05-48d9-971a-efe8f907e12e@linaro.org>
Date: Thu, 1 May 2025 18:39:10 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 0/3] iommu: omap: Simplify few things
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20250501-syscon-phandle-args-iommu-v2-0-5a3cab296972@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20250501-syscon-phandle-args-iommu-v2-0-5a3cab296972@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/05/2025 18:36, Krzysztof Kozlowski wrote:
> Changes in v2:
> - Combine patches #1 and #2, add dev_err_probe() and drop the comment
>   (resolving Robin's comment)
> - New patch: iommu: mtk_iommu_v1: Simplify by dropping local 'mtk_mapping' variable
> - Rb tag
> - Link to resend of v1: https://lore.kernel.org/r/20250212-syscon-phandle-args-iommu-v1-0-c3fab486b426@linaro.org
> - Link to v1: https://lore.kernel.org/r/20250111-syscon-phandle-args-iommu-v1-0-3767dee585a6@linaro.org
> 
> Few code simplifications without functional impact.  Not tested on
> hardware.

I forgot to drop the subject prefix from b4 - this is not a resend, just
v2. Apologies.

Best regards,
Krzysztof
