Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E41374730
	for <iommu@lists.linux.dev>; Mon,  2 Feb 2026 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770043982; cv=none; b=tO5mG8riyc1YpgHXRLNH024i74J5Qjpjp4oFwfQBD3vIAsgb7VE34gsPXBq4Hiilt0L32CmRDTfmrhRuxiBFKGGXLiG+I9jMaXjdzTzrtjX2eJST7joG+fiHImtyv4RXD22AFinQC+4iH3yEvpnJUIkULSd70YpyUSHfWg/OsSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770043982; c=relaxed/simple;
	bh=7mmYBSlGn9pr58Ada0yI1WrJmu1rxBzreSlmAkai3QA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIFq7M7lZp+8Z+X20YA54TFzCZtJOboh4fXxKfgbfeuMHKlRDg3vFlMJz3qCk3mzpPtOT6RrmiVV5olXO5pyzbrbXSkDcegdQroeKsBr0P4sUKRSW08VLYcGLRYUJMAofQ5Bwq1Pe0W79kcSKzNxj4aZFoEqANMnyIMrMtTUpEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RKKjURkp; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RKKjURkp"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b886fc047d5so858879266b.3
        for <iommu@lists.linux.dev>; Mon, 02 Feb 2026 06:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770043978; x=1770648778; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/FAPn1s81bjTvSS2PqJP+fsJ0s7tNOWXLNO1ZsVsGR0=;
        b=RKKjURkpHxCDf2W1vRrL9R2J3EQ9PdrJ9qKPIXADnc96yVNvkugbnPBgo9WhPlNI2k
         XhKVxUrK41z22PQFmzTz+jcoTIXhKYQMCRulYpuk/3X+vFetINlrx3+1bug/uR4k67eg
         /Fd4mk5EAFtOOjm/mvXXtQ/7CtJfHVFx5VFMCFmd2O1pOOEkm82nZsAoVT/IjkqeItgy
         rYGUgTNQzI/hQtirQCr7NuO4AIPV40q5+NhXNMesh4g8duCTmwG/gBEg1RimXYdl6T+u
         /dTV48c4v7f7RLu+3UaNOr8A9+TTLxY5NExc+PcLGcqhgQpYmZ9f3vgFbXo+gSn2gHO0
         lScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770043978; x=1770648778;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FAPn1s81bjTvSS2PqJP+fsJ0s7tNOWXLNO1ZsVsGR0=;
        b=qJeOFYrXGJczMpY3Bkgm6+Vbl86IGN8XabmaJdTjKCWWGpPZFjNI7wxfVgbmfLd3Vp
         2uk5WFTApLDTsHW7PtykpBxurqjMFzUUp8bnEJVTl3TrAGQ74yDdPqdX7+A1A7SjspQU
         VPmSSGWwu7FKdR71CmNSSFdXvzIOVnlL+RjQnkqoP9PS+Zk/A3MPYux5vIDjyjuz6L0/
         QsgRoCSAtGFGwDxgOZoQ4tEDfphWvYqxMAedJ38gKF5p2pMawOL5GFBi8VLGU4C5epMR
         1itWJ4iC9/oUv9O0gT8IHhsl1moblLqh+IbNR9rxCWNLJQQydn/rV3vm4jsGOs7Pss9q
         E3+A==
X-Forwarded-Encrypted: i=1; AJvYcCV4W4jkv5uAgKpIHQv0xUfdHYS3eterhRj4p4Cz17luvSt5jVeKGieCCHuHwIthJeJpSgHOyw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx94Otzh/aipLY9Fr08ggk8PPNPWgAW2uxz6ukR6DlQ9T0jjmOJ
	qW9yfRLAZICD/t3X0onV0R3WRta/h9twidBGusiEPnk/5uf3wmUQdBAmM67jUQEWhi8=
X-Gm-Gg: AZuq6aIt0EqltGp/wnZ8B11uRgnRgD/3D5shprYSYmxOHenhVaDqcer/u3AdjLLNRBa
	tTQhlVGT3asf2XwLgurhGcc/U6n8UivOc2rwzgRTKe5Nlgr6kmeqjFlDjzv3fE9MCSCaep8nC1W
	p54UiDukw7CFMp4ZUGesotyF9KRdpi4X4bBSULdTHDRZmaztwlElHOp9yvZLYuiV86zYlSzXLZ1
	eWuOcdfqaWYr4mCtzQQeeQWLDBAEA3kkgshthxahX+7F0IcdEfnahswsKBOl9KyUXnpJonFVXZm
	9jNeFAQFcKNMrmpgs8YKqunPa/xvZ6wPXnD8lgL0uqeUaiSYpLrPYnoI7LojBzSYnJPlrxicyY0
	+veaTk4yKIVZcFPeSgXp36kZkbb4kwvnF0vAy2HeRdLLDJcKIyPU+Vcclhrp83PMNrvWK3bPodt
	h7h9wxtpFZExUFoGsEeIMm3S0k5wJk1Uou43SkBZ3IY4MeJ9ir0527
X-Received: by 2002:a17:907:e118:b0:b88:5182:b869 with SMTP id a640c23a62f3a-b8dff53e52dmr517742466b.23.1770043977666;
        Mon, 02 Feb 2026 06:52:57 -0800 (PST)
Received: from [192.168.0.40] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbeff5629sm891897166b.27.2026.02.02.06.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 06:52:57 -0800 (PST)
Message-ID: <47fbba15-6375-40fc-bd2c-8ebf2788837e@linaro.org>
Date: Mon, 2 Feb 2026 14:52:54 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] of: factor out of_map_id() code
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
 Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
 <20260126-kaanapali-iris-v1-2-e2646246bfc1@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20260126-kaanapali-iris-v1-2-e2646246bfc1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/01/2026 12:25, Vikash Garodia wrote:
> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>

This commit message is confusing and inaccurate.

First up, you're not factoring _out_ of_map_id() - factor out 
of_map_id() means to remove of_map_id() - you are refactoring of_map_id().

Your patch title should be something like "refactor of_map_id() to 
prepare for mapping of multiple IDs to a single device"

> Linux interprets multiple mappings for the same input ID as a set of
> equivalent choices to pick one. There exists usecases where these set
> must be maintained in parallel, ex: on ARM, a dynamically created child
> device(s) is referencing multiple input id's in parent iommu-map.
> 
> Factor out the code where multiple mappings needs to be maintained in
> parallel can be achieved through callback from this factored out code.

Which callback ? There is no ->function(pointer, here...); ?!

Just make some plain and straightforward statements about what you are 
doing and why. There's no need to resort to dissertation-speak.

> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>   drivers/of/base.c | 47 ++++++++++++++++++++++++++++++++---------------
>   1 file changed, 32 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 0825f3dc93f2472e9947af09acdde72031ab85bc..606bef4f90e7d13bae4f7b0c45acd1755ad89826 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -2122,6 +2122,32 @@ static bool of_check_bad_map(const __be32 *map, int len)
>   	return true;
>   }
>   
> +static int of_map_id_fill_output(struct of_map_id_arg *arg,
> +				 struct device_node *phandle_node, u32 id_or_offset,
> +				 const __be32 *out_base, u32 cells,
> +				 bool bypass)
> +{
> +	if (bypass) {
> +		arg->map_args.args[0] = id_or_offset;
> +		return 0;
> +	}
> +
> +	if (arg->map_args.np)
> +		of_node_put(phandle_node);
> +	else
> +		arg->map_args.np = phandle_node;
> +
> +	if (arg->map_args.np != phandle_node)
> +		return -EAGAIN;
> +
> +	for (int i = 0; i < cells; i++)
> +		arg->map_args.args[i] = (id_or_offset + be32_to_cpu(out_base[i]));
> +
> +	arg->map_args.args_count = cells;
> +
> +	return 0;
> +}
> +
>   /**
>    * of_map_id - Translate an ID through a downstream mapping.
>    * @np: root complex device node.
> @@ -2162,8 +2188,7 @@ int of_map_id(const struct device_node *np, u32 id, const char *map_name,
>   		if (arg->map_args.np)
>   			return -ENODEV;
>   		/* Otherwise, no map implies no translation */
> -		arg->map_args.args[0] = id;
> -		return 0;
> +		goto bypass_translation;
>   	}
>   
>   	if (map_bytes % sizeof(*map))
> @@ -2185,6 +2210,7 @@ int of_map_id(const struct device_node *np, u32 id, const char *map_name,
>   		struct device_node *phandle_node;
>   		u32 id_base, phandle, id_len, id_off, cells = 0;
>   		const __be32 *out_base;
> +		int ret;
>   
>   		if (map_len - offset < 2)
>   			goto err_map_len;
> @@ -2238,19 +2264,10 @@ int of_map_id(const struct device_node *np, u32 id, const char *map_name,
>   		if (masked_id < id_base || id_off >= id_len)
>   			continue;
>   
> -		if (arg->map_args.np)
> -			of_node_put(phandle_node);
> -		else
> -			arg->map_args.np = phandle_node;
> -
> -		if (arg->map_args.np != phandle_node)
> +		ret = of_map_id_fill_output(arg, phandle_node, id_off, out_base, cells, false);
> +		if (ret == -EAGAIN)
>   			continue;
>   
> -		for (int i = 0; i < cells; i++)
> -			arg->map_args.args[i] = (id_off + be32_to_cpu(out_base[i]));
> -
> -		arg->map_args.args_count = cells;
> -
>   		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
>   			np, map_name, map_mask, id_base, be32_to_cpup(out_base),
>   			id_len, id, id_off + be32_to_cpup(out_base));
> @@ -2260,9 +2277,9 @@ int of_map_id(const struct device_node *np, u32 id, const char *map_name,
>   	pr_info("%pOF: no %s translation for id 0x%x on %pOF\n", np, map_name,
>   		id, arg->map_args.np  ? arg->map_args.np : NULL);
>   
> +bypass_translation:
>   	/* Bypasses translation */
> -	arg->map_args.args[0] = id;
> -	return 0;
> +	return of_map_id_fill_output(arg, NULL, id, 0, 0, true);
>   
>   err_map_len:
>   	pr_err("%pOF: Error: Bad %s length: %d\n", np, map_name, map_bytes);
> 

