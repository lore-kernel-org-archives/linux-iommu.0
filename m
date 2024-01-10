Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC72A46556
	for <iommu@lists.linux.dev>; Wed, 10 Jan 2024 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i2PYrKAK"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50eaa8b447bso4238156e87.1
        for <iommu@lists.linux.dev>; Wed, 10 Jan 2024 02:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704883772; x=1705488572; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4HAwidvb0e6ayLYLy7I8ixYSx1g7DRV+B9kcqw/hieg=;
        b=i2PYrKAKwrGPqppHxW/A3w5oRlpZkIzBYq77ff5YNIcAww+UtEUxyEn737gfohiEai
         LHCao/5XXsnypN2Fvw9pB/F3UDDB6dH7veZ0QebbBd2AiIBVLf4Kq6QHoyA0j3UM+9Id
         jqpkB5Ak+v7+g+maY6n8+HCGJrXytqUxDwKynuxCdQsMr/4IE9N+rgnJGb/Ut2Cj0vVn
         M6de4apdfwe9zH9YfMx9Fyo5K39wnIQcX3LMybloOXPuzC9ebnnzK2V6bi0ceGhYRVHo
         cSjzlKNoI1oTgRGTqWL7bl5dfeYJsWrUWPOOB8KhEC9Q0frdzOHYd9xecT5ZwUP2BFwF
         FfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704883772; x=1705488572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HAwidvb0e6ayLYLy7I8ixYSx1g7DRV+B9kcqw/hieg=;
        b=CCFwo1s8Zlr3xA2kFNhdWuiUtaOujUaKSQtdSZlWzJUR8IDIgWa52RpPMn+eBCnCox
         YW9l61OZw1Cr+ij5qPHGB7Pl8V0bAFo5wdIxZNntP/Cdcc7QWAAd39uYV7qfiumtaZ1f
         HWXfW4IU2giqAGM6c3OgrrNXi8Sjc+dxhc/5tfYQUZnF+vSZ2IviewXwmWa07GF3L1Bj
         zaEDZFvENhgE1A23XjE9X0qlw4zGJt5NyawpKefer1DtJ20TWYla6798WUO5veSLNa3D
         eTcu1/cQeq+RAHjcNy2UCVA6sPXDF79PpvK5DROjAygaSMZyWfk4MRZdMuRVRNGChMfm
         85yw==
X-Gm-Message-State: AOJu0YxFT25I3sDsue8uw7haF1/oZb+qOC3BNAQSrl88ZCE+yy08T44z
	RG/TS31to7kw7iyIp69G3vf8399GYkw3SQ==
X-Google-Smtp-Source: AGHT+IGH4Qz7/5tf/bBFWTnAs92jT0yCKBWnsVfiMJH5KiWKl3BVTMjQvfanZ3xGGYxdJZu1ZO+YtQ==
X-Received: by 2002:a19:5f50:0:b0:50e:700:bdbb with SMTP id a16-20020a195f50000000b0050e0700bdbbmr145927lfj.21.1704883771729;
        Wed, 10 Jan 2024 02:49:31 -0800 (PST)
Received: from [172.30.205.119] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id o5-20020ac24bc5000000b0050ecae41c51sm590120lfq.135.2024.01.10.02.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 02:49:31 -0800 (PST)
Message-ID: <45314345-36ba-4d85-9d3b-298de26eb069@linaro.org>
Date: Wed, 10 Jan 2024 11:49:27 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] iommu/arm-smmu: add ACTLR data and support for
 SM8550
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, dmitry.baryshkov@linaro.org,
 jsnitsel@redhat.com, quic_bjorande@quicinc.com, mani@kernel.org,
 quic_eberman@quicinc.com, robdclark@chromium.org,
 u.kleine-koenig@pengutronix.de, robh@kernel.org, vladimir.oltean@nxp.com,
 quic_pkondeti@quicinc.com, quic_molvera@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 qipl.kernel.upstream@quicinc.com
References: <20240109114220.30243-1-quic_bibekkum@quicinc.com>
 <20240109114220.30243-5-quic_bibekkum@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240109114220.30243-5-quic_bibekkum@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/9/24 12:42, Bibek Kumar Patro wrote:
> Add ACTLR data table for SM8550 along with support for
> same including SM8550 specific implementation operations.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
[...]

> +static const struct actlr_variant sm8550_actlr[] = {
> +	{ sm8550_apps_actlr_cfg, 0x15000000 },
> +	{ sm8550_gfx_actlr_cfg, 0x03da0000 },
> +	{},
> +};

Please use C99 designated initializers and put the address first.

Konrad
