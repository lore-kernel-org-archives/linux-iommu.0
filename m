Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57E62D03B
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600710; cv=none; b=VBccqovxjvlg3IK/fVFdQc8tIYmZ/PG0qYFYkWVY0Aa8Zt8xNYkGpcAkLkMWkP7Mc8Km+F9135KStvjDFQvRR2u6rPVXkOlYdUIGKwwFk3J0hkbtCsn3FJmBCGJJmkf4lFl+ZEM+TOaL4VE+7qcplgjbPkrCzbxONbPqcxoEqig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600710; c=relaxed/simple;
	bh=QVF+n5V+O+hXfuYnJEtJo6fru3J22c12jHPTEEHaopc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gul2xsrMB1eD027CML3HR4SpuvtP4DXAJth0wlhKqLPxwUw9Qo1GBcNv+P4O3m4UyC5qkVi6t4TXP0sTLjVuk13M8n8E5oS/L/cp11MHjcu4greHCa3l00KsutCFaml6y6BbFn1562Wim+kLxmKj+W9bJONcA9X11pxbgjj+QxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yf3U4Zog; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yf3U4Zog"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cd8b64a52dso86177281fa.2
        for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 09:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705600707; x=1706205507; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NrlV4jgpWCJfzB/7NzgqxnwjrFZnXY4okb0+G7cWf8A=;
        b=yf3U4ZogN3WquOGCxHqMb0nYaq5V08lTQ9HWonHpShWmpXQd+y8yqNZHYNX3AHvZFf
         M8d5J9ihC2NR0SZHp+XRYuTI0vUdhTP4iFCcnB5HwRbTSDAeFbhW+kS+HTHH1dcvJp9o
         SS7YFGkYvCTa3D3apyjKWLDgvOdBi0MTVM6q85posms0ZM76kDaPUEqbyDUBpEeLTlpI
         dCtjTLgrOTHfBjD5A2Nip3ip5KOiE7cogLww72dNOPhkbzANO43nJU+NLfC/KwucU83J
         zMk2tYFOzCN1gc+1GRqxJy9V9g57HMehjQ9y+eMkdeQsqJ1hjStOEY7SYhA4ZBJKKgKf
         pgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705600707; x=1706205507;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NrlV4jgpWCJfzB/7NzgqxnwjrFZnXY4okb0+G7cWf8A=;
        b=h4uS6385VlFsdXLakGGX1PgTwTIFo4o6RvzdYhSWYbwcMcrH0ImTMkXNeplKS6QQ//
         /jlPnjM9pHNGc/f+hM3hEvKKduWSk/XEywwHsg6gzHXz6O4Em5RuQ1SIJmzq8Brlkg89
         +i3XYA8s+H2cyF5r7n0H2E6BsVM17yQ4eKkDSD+3OFehfaYmKwjbrd7OqU98u+bpHL9a
         N+vYVlutUvd8SnPBcFC5URdMhGM7XkTF3y41WJ5Do6iCz0YT30j6Luon+jbfnwETchbx
         XpzgFnYVaMyT8Ylzx0yJNXiSptmJwK7phdgxJq2nfkwXVWc7BfT+j5wJHMk/lVS0qz8h
         acyA==
X-Gm-Message-State: AOJu0YwEMMOU/GJ2g73W6oMWBz8PSfnPb8ze3ByJOu51axRpEmiT0W0B
	qMZ+ZoUe1nT6UVZSUSMbHg5Vmp1k2JFm7v/CE14W2aq0dMcjqObjOnjcWfTVpV4=
X-Google-Smtp-Source: AGHT+IHA3nsf2QxBjJzDDsSCfuzn2I5E9MPsp1wzSuINFGRlDEcs7im02+W9DqUrmxZ7PrDqlAUQ8w==
X-Received: by 2002:a2e:a555:0:b0:2cd:23a7:a346 with SMTP id e21-20020a2ea555000000b002cd23a7a346mr1045547ljn.83.1705600706894;
        Thu, 18 Jan 2024 09:58:26 -0800 (PST)
Received: from [172.30.205.26] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id x43-20020a2ea9ab000000b002cdb6a40096sm1507098ljq.131.2024.01.18.09.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 09:58:26 -0800 (PST)
Message-ID: <7d012b9f-b1ca-4633-8dc2-03d90c418e7d@linaro.org>
Date: Thu, 18 Jan 2024 18:58:23 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] iommu/arm-smmu: add ACTLR data and support for
 SM8550
Content-Language: en-US
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, dmitry.baryshkov@linaro.org,
 jsnitsel@redhat.com, quic_bjorande@quicinc.com, mani@kernel.org,
 quic_eberman@quicinc.com, robdclark@chromium.org,
 u.kleine-koenig@pengutronix.de, robh@kernel.org, vladimir.oltean@nxp.com,
 quic_pkondeti@quicinc.com, quic_molvera@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240116150411.23876-1-quic_bibekkum@quicinc.com>
 <20240116150411.23876-5-quic_bibekkum@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240116150411.23876-5-quic_bibekkum@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/16/24 16:04, Bibek Kumar Patro wrote:
> Add ACTLR data table for SM8550 along with support for
> same including SM8550 specific implementation operations.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---

[...]

> +static const struct actlr_variant sm8550_actlr[] = {
> +	{ .io_start = 0x15000000, .actlrcfg = sm8550_apps_actlr_cfg,
> +			.num_actlrcfg = ARRAY_SIZE(sm8550_apps_actlr_cfg) },
> +	{ .io_start = 0x03da0000, .actlrcfg = sm8550_gfx_actlr_cfg,
> +			.num_actlrcfg = ARRAY_SIZE(sm8550_gfx_actlr_cfg) },
> +};
Just a nit again, but if struct definitions need to be wrapped, this looks
better:

{
	.io_start = 0...,
	.aclrcfg = ...,
	.num_actlrcfg = ARR..,
}, {
	.io_start = 0..,
	.aclrcfg = ...,
	.num_actlrcfg = ARR..,
};

Konrad
