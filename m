Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7608F2641E3
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 05:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767764000; cv=none; b=DbAa0flLcUVgQ3oTXJpi53c2ShfkDYe+K8bZvwnttB08wTbWCByz8LSgzpjx1aog5tcTIf/4t+ct+cfSVz0w13fJBXU4Rh/ZNKBLDqfn9Ruv8PqIw5nIfvsmeNClM82p3PBwXsH/00wP6RlL947D7AEG1NVN2b7Ty3D2jWhQ294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767764000; c=relaxed/simple;
	bh=8AgfhEWDZUNErEUD0EBGzeS5ORKs/qQGumTlGs+iNJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/TLIqqTbAMHBkI5lVfHoorYvxWLQDSAsvI5vFtE8JwPWBpIDhPIK2brkvuVUfXlkAZ6TooUUIRIna9AJDa3yeo4D8gA/ooFs/wwh/ikEazyKuVPa75HcqUAvIrbzGD6DIPydHqPAHS1R8ko9ler3e4220MFQaWQaLX7aSfVo1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H3VE5fL5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f09jD64a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H3VE5fL5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f09jD64a"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60733JYV3889122
	for <iommu@lists.linux.dev>; Wed, 7 Jan 2026 05:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IM7LCQ0sGj6OLZ9XtkfAleS0gJYcIZuB+fuwo6h2M2E=; b=H3VE5fL5naNFXi+n
	O7xIIuISF/Q8t/l2vRelk+DEHVZGL1RHlvpp50ngoj6YQHvBbQuAK9PCniwgUl13
	yQkbcNPO/95BoRFDfPSsIRY+yOGbxc7JABi7MmZAAwxbAV7YvQujWXlouU4fYtKN
	F6fStCrdKFK985jDYaraAtU4LY1Mu5Byad1Yh/dLU8F7fdygoFuNysY+r/Tigexg
	+mLM+0osMw9/8ICdmS9V3u/+X0aBEmM/LKRaoPm7RLj9ftGpIR5MZZv5GGVS+wYo
	774zuUjpBDGad6yVtnO43smRBveMCkt7LyBeKQVJvQv0SHXEnsvQmue8UE/WjA+g
	+uj8jA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh6a0j1s1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 07 Jan 2026 05:33:17 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7f046e16d50so2787729b3a.3
        for <iommu@lists.linux.dev>; Tue, 06 Jan 2026 21:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767763996; x=1768368796; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IM7LCQ0sGj6OLZ9XtkfAleS0gJYcIZuB+fuwo6h2M2E=;
        b=f09jD64a2m1MUB3ssmhLcPnUu1xKxFGYYd9ZDCcHKr9OxMcRS37sT+qZbx8SgD75pP
         vexzhjQ9bObdIODJd2fuwEoklIrTbFnDXj7LGTdcNF28bngrc4tJNIR4Tm+6QXSN9XFs
         gFaGD2XVyIlxJDb4ZxWNc/77pqSZ/CKnNkEzoj7wwqldqNo3bGntCRRRa5uz3vp+KfLG
         wmAbhOjnYAI309dLt38ErKJWsXm+hlDiEJEzeqdhJBJV29Fk01AQJU1+zfxnZ6R+Tf9G
         lmGtWwoJe20QkrHvXA4ktENXE2/0NS1MUxCDl6OxLnRVZw2jWzLz7LnNNs8W6eTAXsyW
         uVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767763996; x=1768368796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IM7LCQ0sGj6OLZ9XtkfAleS0gJYcIZuB+fuwo6h2M2E=;
        b=r8ef2ZcrIc5EBYKmLBMXnc8km8gvVBpHrU5u5HcznX24Kp7A2bE8Q6VCPhC5wSjtsf
         xUfgBrTCQ+Lm256qzfxP8ohQOElg7d1DsLuH6LRo6Y5m/vYz4Z0Ujt3pNFwY17HvHL2y
         w1Ygm2iPYSkwPMy5jAOfxE8z5B6FPfgsvVH49GT6g5FxRslj2CGNvGqTq5sdD0B9uK/T
         d9RFALjUfoLJDXCfHSHPYnBrE6wZTubE76EMccJUkM8uM6PRy/BReu+1pN+Vs+jGKWuW
         SETCeb6OnkLQzc/ZzUJpzaFiZ3FnIM2meCZoUuElO2JLYZXD6yLgjIxrRY0/ef7xCYBN
         o7qg==
X-Gm-Message-State: AOJu0Ywtz7ehE9jJnH8tLf3eVTxFduiU9kc2cVpnfDFNwn44oZENjehI
	NVryKSkAhm+AlKx97q2dwdHpZd7eFP7aS8Whr7q1dDyMpNjAL7qoKFiiANurzY3IYyM5K/XUzvc
	6PuBsgXqUT3Mxrk9nBI07F0uR4DyEL8bOt9xDXm3jo5D9kiYzcA3esYVjtQ==
X-Gm-Gg: AY/fxX5JZ18WMNfp1KwzKRbA3Lk86kxvXEfAN4dL++oP+IxVDd5eN/Z2j1xJlcyDi0l
	x9Lf1ORfS2/xwpl4jQBZeUgj4FX4p0vF4nrRuWRa1xvAsi1EyuWOp3mo//bTtNbgVtelTm2i7Gi
	jj56BlL1EtiLtS6RDzBiI6OuqmQZVgGkqgGn3mZkXiPfJEktEsmJ9PYoqA1blBuRijEo8LszDg0
	1AI+xHuOhyl5baYXQ/mwy24B5UT+i+L3YlDlMN0myt0cR3Rcx3JBCRWrcxSWMYrCImQHtw1HvSK
	tV89wvtcfzo3ptYh8w9iX6PwkSK8Uxs7GZm95KtTpZk1PILokds1P2eHuuyshFk71tY3NBvx0s6
	K9r0W8u58cktpsbCowXfgZ0UZSiE7XJ2g0X8yBwbTpVP6
X-Received: by 2002:a05:6a00:340a:b0:7ff:a5d2:7c9e with SMTP id d2e1a72fcca58-81b7de5c1f0mr1403687b3a.21.1767763996159;
        Tue, 06 Jan 2026 21:33:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsU6Tll0jH+4cPRN75Crua0J0WmF4N1GJ8rbvbzF/Esty0h551IC4VDJ/8fjpEFvJJVbAYFA==
X-Received: by 2002:a05:6a00:340a:b0:7ff:a5d2:7c9e with SMTP id d2e1a72fcca58-81b7de5c1f0mr1403666b3a.21.1767763995641;
        Tue, 06 Jan 2026 21:33:15 -0800 (PST)
Received: from [10.219.57.109] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5de66d1sm3684127b3a.62.2026.01.06.21.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 21:33:15 -0800 (PST)
Message-ID: <fde70548-61fe-41f3-9bdf-37ceda603e02@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 11:01:11 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] of: Respect #{iommu,msi}-cells in maps
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, saravanak@google.com,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20251231114257.2382820-1-vijayanand.jitta@oss.qualcomm.com>
 <20251231114257.2382820-4-vijayanand.jitta@oss.qualcomm.com>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <20251231114257.2382820-4-vijayanand.jitta@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: vuwk-Fh_vxpWqBnjuLeIzSwcOE_jHqP1
X-Proofpoint-GUID: vuwk-Fh_vxpWqBnjuLeIzSwcOE_jHqP1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA0MiBTYWx0ZWRfXwH5C+I4R35F8
 bISiCmeG9bf4i6CIb3sGjcUzQNkYUF752TqIdSiE2iiY1mpTV5MGkVvbTPztCPd9us2yYMvsUGS
 zSF/TK3qT5NrGbWHq6y2SJJNKKD5zepQFtuc2dKyV83bsJuEsaQ/EUZ3/Fnz81tnqNiUonJKqlB
 tYuBeMZT/bOle2xkkY9brTL9WwTifA62o6qTPMiGtXMTy5R89cE73D9cbb5uM+dXRaFGv1jq2b9
 1ZfKoZh93L6V66RMBtAEbMZcu24Tqlr5Jjk9Q56ah15JK7FDg9Iil29L2yajXzR71Y/mWhyWv91
 7AJthWP+wC55gUtvPC38RmdtozHXE4wAG2mvyeyuj6rsI0YurV6Ki7m24uo1W3wbNiQLqEWhiYb
 s11sf9qgqv4mERCF6kLBlNkmrWJc6dYK9e0Bw7ygggLwuI0u+IWj8ab3QD+YoE1fwI9eEGPZ9F9
 Q3OTnz0feLuD8er0s9g==
X-Authority-Analysis: v=2.4 cv=MtdfKmae c=1 sm=1 tr=0 ts=695df01d cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8
 a=3f3g1KydcdST7NtTSaIA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070042



On 12/31/2025 5:12 PM, Vijayanand Jitta wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> So far our parsing of {iommu,msi}-map properites has always blindly
> asusmed that the output specifiers will always have exactly 1 cell.
> This typically does happen to be the case, but is not actually enforced
> (and the PCI msi-map binding even explicitly states support for 0 or 1
> cells) - as a result we've now ended up with dodgy DTs out in the field
> which depend on this behaviour to map a 1-cell specifier for a 2-cell
> provider, despite that being bogus per the bindings themselves.
> 
> Since there is some potential use in being able to map at least single
> input IDs to multi-cell output specifiers (and properly support 0-cell
> outputs as well), add support for properly parsing and using the target
> nodes' #cells values, albeit with the unfortunate complication of still
> having to work around expectations of the old behaviour too.
> 
> Since there are multi-cell output specifiers, the callers of of_map_id()
> may need to get the exact cell output value for further processing.
> Added support for that part --charan
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> ---
>  drivers/iommu/of_iommu.c |   4 +-
>  drivers/of/base.c        | 114 +++++++++++++++++++++++++++++++--------
>  include/linux/of.h       |  16 +++---
>  3 files changed, 101 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 646ac5a67475..768eaddf927b 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -46,9 +46,7 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
>  				     const u32 *id)
>  {
>  	struct of_map_id_arg arg = {
> -		.map_args = {
> -			.args_count = 1,
> -		},
> +		.map_args = {},
>  	};
>  	int err;
>  
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 9f327c6b4f6b..f0507ddb6dae 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -2045,11 +2045,38 @@ int of_find_last_cache_level(unsigned int cpu)
>  	return cache_level;
>  }
>  
> +/*
> + * Some DTs have an iommu-map targeting a 2-cell IOMMU node while
> + * specifying only 1 cell. Fortunately they all consist of value '1'
> + * as the 2nd cell entry with the same target, so check for that pattern.
> + *
> + * Example:
> + *	IOMMU node:
> + *		#iommu-cells = <2>;
> + *
> + *	Device node:
> + *		iommu-map = <0x0000 &smmu 0x0000 0x1>,
> + *			    <0x0100 &smmu 0x0100 0x1>;
> + */
> +static bool of_check_bad_map(const __be32 *map, int len)
> +{
> +	__be32 phandle = map[1];
> +
> +	if (len % 4)
> +		return false;
> +	for (int i = 0; i < len; i += 4) {
> +		if (map[i + 1] != phandle || map[i + 3] != cpu_to_be32(1))
> +			return false;
> +	}
> +	return true;
> +}
> +
>  /**
>   * of_map_id - Translate an ID through a downstream mapping.
>   * @np: root complex device node.
>   * @id: device ID to map.
>   * @map_name: property name of the map to use.
> + * @cells_name: property name of target specifier cells.
>   * @map_mask_name: optional property name of the mask to use.
>   * @arg: contains the optional params, wrapped in a struct of_phandle_args,
>   *	which includes:
> @@ -2067,18 +2094,19 @@ int of_find_last_cache_level(unsigned int cpu)
>   *
>   * Return: 0 on success or a standard error code on failure.
>   */
> -int of_map_id(const struct device_node *np, u32 id,
> -	       const char *map_name, const char *map_mask_name,
> -	       struct of_map_id_arg *arg)
> +int of_map_id(const struct device_node *np, u32 id, const char *map_name,
> +	      const char *cells_name, const char *map_mask_name,
> +	      struct of_map_id_arg *arg)
>  {
>  	u32 map_mask, masked_id;
> -	int map_len;
> +	int map_bytes, map_len, offset = 0;
> +	bool bad_map = false;
>  	const __be32 *map = NULL;
>  
>  	if (!np || !map_name || !arg)
>  		return -EINVAL;
>  
> -	map = of_get_property(np, map_name, &map_len);
> +	map = of_get_property(np, map_name, &map_bytes);
>  	if (!map) {
>  		if (arg->map_args.np)
>  			return -ENODEV;
> @@ -2087,11 +2115,9 @@ int of_map_id(const struct device_node *np, u32 id,
>  		return 0;
>  	}
>  
> -	if (!map_len || map_len % (4 * sizeof(*map))) {
> -		pr_err("%pOF: Error: Bad %s length: %d\n", np,
> -			map_name, map_len);
> -		return -EINVAL;
> -	}
> +	if (map_bytes % sizeof(*map))
> +		goto err_map_len;
> +	map_len = map_bytes / sizeof(*map);
>  
>  	/* The default is to select all bits. */
>  	map_mask = 0xffffffff;
> @@ -2104,27 +2130,64 @@ int of_map_id(const struct device_node *np, u32 id,
>  		of_property_read_u32(np, map_mask_name, &map_mask);
>  
>  	masked_id = map_mask & id;
> -	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
> +	while (offset < map_len) {
>  		struct device_node *phandle_node;
> -		u32 id_base = be32_to_cpup(map + 0);
> -		u32 phandle = be32_to_cpup(map + 1);
> -		u32 out_base = be32_to_cpup(map + 2);
> -		u32 id_len = be32_to_cpup(map + 3);
> +		u32 id_base, phandle, id_len, id_off, cells = 0;
> +		const __be32 *out_base;
> +
> +		if (map_len - offset < 2)
> +			goto err_map_len;
> +
> +		id_base = be32_to_cpup(map + offset);
>  
>  		if (id_base & ~map_mask) {
> -			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores id-base (0x%x)\n",
> -				np, map_name, map_name,
> +			pr_err("%pOF: Invalid %s translation - %s (0x%x) ignores id-base (0x%x)\n",
> +				np, map_name, map_mask_name,
>  				map_mask, id_base);
>  			return -EFAULT;
>  		}
>  
> -		if (masked_id < id_base || masked_id >= id_base + id_len)
> -			continue;
>  
> +		phandle = be32_to_cpup(map + offset + 1);
>  		phandle_node = of_find_node_by_phandle(phandle);
>  		if (!phandle_node)
>  			return -ENODEV;
>  
> +		if (!bad_map && of_property_read_u32(phandle_node, cells_name, &cells)) {
> +			pr_err("%pOF: missing %s property\n", phandle_node, cells_name);
> +			return -EINVAL;
> +		}
> +
> +		if (map_len - offset < 3 + cells)
> +			goto err_map_len;
> +
> +		if (offset == 0 && cells == 2) {
> +			bad_map = of_check_bad_map(map, map_len);
> +			if (bad_map) {
> +				pr_warn_once("%pOF: %s mismatches target %s, assuming extra cell of 0\n",
> +				np, map_name, cells_name);
> +				cells = 1;
> +			}
> +		}
> +
> +		out_base = map + offset + 2;
> +		offset += 3 + cells;
> +
> +		id_len = be32_to_cpup(map + offset - 1);
> +		if (id_len > 1 && cells > 1) {
> +			/*
> +			 * With 1 output cell we reasonably assume its value
> +			 * has a linear relationship to the input; with more,
> +			 * we'd need help from the provider to know what to do.
> +			 */
> +			pr_err("%pOF: Unsupported %s - cannot handle %d-ID range with %d-cell output specifier\n",
> +				np, map_name, id_len, cells);
> +			return -EINVAL;
> +		}
> +		id_off = masked_id - id_base;
> +		if (masked_id < id_base || id_off >= id_len)
> +			continue;
> +
>  		if (arg->map_args.np)
>  			of_node_put(phandle_node);
>  		else
> @@ -2133,11 +2196,14 @@ int of_map_id(const struct device_node *np, u32 id,
>  		if (arg->map_args.np != phandle_node)
>  			continue;
>  
> -		arg->map_args.args[0] = masked_id - id_base + out_base;
> +		for (int i = 0; i < cells; i++)
> +			arg->map_args.args[i] = (id_off + be32_to_cpu(out_base[i]));
> +
> +		arg->map_args.args_count = cells;
>  
>  		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
> -			np, map_name, map_mask, id_base, out_base,
> -			id_len, id, masked_id - id_base + out_base);
> +			np, map_name, map_mask, id_base, be32_to_cpup(out_base),
> +			id_len, id, id_off + be32_to_cpup(out_base));
>  		return 0;
>  	}
>  
> @@ -2147,5 +2213,9 @@ int of_map_id(const struct device_node *np, u32 id,
>  	/* Bypasses translation */
>  	arg->map_args.args[0] = id;
>  	return 0;
> +
> +err_map_len:
> +	pr_err("%pOF: Error: Bad %s length: %d\n", np, map_name, map_bytes);
> +	return -EINVAL;
>  }
>  EXPORT_SYMBOL_GPL(of_map_id);
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 0b0d545b80a3..ee07e8642133 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -460,9 +460,9 @@ const char *of_prop_next_string(const struct property *prop, const char *cur);
>  
>  bool of_console_check(const struct device_node *dn, char *name, int index);
>  
> -int of_map_id(const struct device_node *np, u32 id,
> -	       const char *map_name, const char *map_mask_name,
> -	       struct of_map_id_arg *arg);
> +int of_map_id(const struct device_node *np, u32 id, const char *map_name,
> +	      const char *cells_name, const char *map_mask_name,
> +	      struct of_map_id_arg *arg);
>  
>  phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
>  
> @@ -909,9 +909,9 @@ static inline void of_property_clear_flag(struct property *p, unsigned long flag
>  {
>  }
>  
> -static inline int of_map_id(const struct device_node *np, u32 id,
> -			     const char *map_name, const char *map_mask_name,
> -			     struct of_map_id_arg *arg)
> +static inline int of_map_id(const struct device_node *np, u32 id, const char *map_name,
> +			    const char *cells_name, const char *map_mask_name,
> +			    struct of_map_id_arg *arg);
>  {
>  	return -EINVAL;
>  }
> @@ -1442,7 +1442,7 @@ static inline int of_property_read_s32(const struct device_node *np,
>  static inline int of_map_iommu_id(const struct device_node *np, u32 id,
>  				  struct of_map_id_arg *arg)
>  {
> -	return of_map_id(np, id, "iommu-map", "iommu-map-mask", arg);
> +	return of_map_id(np, id, "iommu-map", "#iommu-cells", "iommu-map-mask", arg);
>  }
>  
>  static inline int of_map_msi_id(const struct device_node *np, u32 id,
> @@ -1456,7 +1456,7 @@ static inline int of_map_msi_id(const struct device_node *np, u32 id,
>  		},
>  	};
>  
> -	return of_map_id(np, id, "msi-map", "msi-map-mask", &arg);
> +	return of_map_id(np, id, "msi-map", "#msi-cells", "msi-map-mask", &arg);
>  }
>  
>  #define of_for_each_phandle(it, err, np, ln, cn, cc)			\

Rob, 

Gentle ping, could you please let me know if the latest patchset looks good enough
to be considered for the next merge window?

Thanks,
Vijay
