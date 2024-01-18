Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903632C68C
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600537; cv=none; b=YT+9ZOb2fsGXVe78dz7xs9oz9pe1nOROmtj8cYBALHnUxT9zafPkN+Pe/AO1xXpqBjFlRoKFevCM1cCMtG8RuEcvoERzwpfF/pj68656M3gPlUItQVT+BT4XPgL4ogEwXp6JVzgpzMCWcM06vR4MCRYNpuOiqLvuOkywz10IrCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600537; c=relaxed/simple;
	bh=aisBVFiczj/jDzFOQ/gAkAjn85FMrdiPrHE0pnY7fXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MX7y84x1HKuD2hrL7iAVll+QtJg2hs/E97jcvWfaWsE9zArETg8t78JddI/JzmqRgNt/7DdjMNgCUOuKdh18t/bmdwnWuF/JhV3ouSkI2W1K5DtEfqPZIMpk+UypM8ULj6lHp9AjL97EPMQPzNR89n9VWMChCRhGLpkDvgYAChM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v+BIW7P5; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v+BIW7P5"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e7d6565b5so15228924e87.0
        for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 09:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705600534; x=1706205334; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ij3Aid6rc3/+qPxyjn4VOAO9ySy7PRtD3+5FtjfYAss=;
        b=v+BIW7P5XhHI1GdnheWn46seB0UCUUMPbaXlPWPJ1e/44FLD6pO0BlmYqFdxBPe0vA
         TW7u5LzD6Yp3cirdhIV8HzfcLAEAAHePPEArqJgAdjJSfV+3yHrzLWRqlgeFcOe0PV/b
         gDbBM8HClh6244cXtNDNGIh9Dk5/8lJ/Z0K/P7DRsuIHomfQpgcXe4RoSzQZyhYxH0xZ
         POABF3sDIyv56+0bheX4ym/EYHXOPnZIBduEA5L9cqlA/zK0JvYKUSKUv8FT3wQzaNZ4
         fTG/jEaFARe4NAlKpJw0uFclXURKDaiH9gDafrnJrHAP0jPZee81Xn/+BOppLc/92umq
         UZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705600534; x=1706205334;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ij3Aid6rc3/+qPxyjn4VOAO9ySy7PRtD3+5FtjfYAss=;
        b=FNEBwU/nFkNY5fWteFV6n3Hjrolk5QyhODn9XuYNw539BS5ZsznEmMU4PoF4+2ZtZ9
         i8X1eE3sJUuxSS9B16bdvfwcngDpUM1f1wggKxfAVQsKOdQZVpyCBF6Or9ia7zQgZTXL
         1OU4yZc1bvcjFBEbMNnG67FknrmONq6+m/k308tacaORme+H8q9fmcCxUPs7UJcJ2jZy
         sNagPeFcu6skhJKN3uPVtp+zEVy/Ife1O/xzw3Cv2I1nxBQMHR37737PxWEmChqkX+ku
         FIw9NeNQbQF/EUYJ9PooPE2X7sikIdDi3XFXr8J1mwe3lTA+3McZrd9F2yWQguP3/s6G
         Q5cA==
X-Gm-Message-State: AOJu0YxHRghjDARCV9NVGttE626Hcw9JBlp/F6FxxYmROKmFwrkQGcS+
	voG+28hy8Le0aIhrTKLMcZN8m6YPGwHpC9bTOSb8P305Mok83VKcwZS7QI3BCeU=
X-Google-Smtp-Source: AGHT+IGG228V8tanAnesngcf1mfWcLrYcU8aze9RSKB7jrVY3whXoAFZhO5z1Rmk8AJAf+oAZfApwQ==
X-Received: by 2002:ac2:4c48:0:b0:50e:2f46:1111 with SMTP id o8-20020ac24c48000000b0050e2f461111mr6414lfk.97.1705600533660;
        Thu, 18 Jan 2024 09:55:33 -0800 (PST)
Received: from [172.30.205.26] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id v4-20020ac25604000000b0050f0dc3a08esm644932lfd.151.2024.01.18.09.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 09:55:33 -0800 (PST)
Message-ID: <f25b7a0d-28b7-428f-a88f-2ceecc208f85@linaro.org>
Date: Thu, 18 Jan 2024 18:55:29 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
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
 <20240116150411.23876-4-quic_bibekkum@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240116150411.23876-4-quic_bibekkum@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/16/24 16:04, Bibek Kumar Patro wrote:
> Currently in Qualcomm  SoCs the default prefetch is set to 1 which allows
> the TLB to fetch just the next page table. MMU-500 features ACTLR
> register which is implementation defined and is used for Qualcomm SoCs
> to have a custom prefetch setting enabling TLB to prefetch the next set
> of page tables accordingly allowing for faster translations.
> 
> ACTLR value is unique for each SMR (Stream matching register) and stored
> in a pre-populated table. This value is set to the register during
> context bank initialisation.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Since it's your idea with Dmitry's review suggestions, I don't think
this tag makes sense.

It's normally used for situations like:

Colleague X: "Hey Bibek, I noticed x broke on y, can you fix it?"
"Sure!" <proceeds to make a commit with suggested-by Colleague X>

Just a nit below:

> +struct actlr_config {
> +	u16 sid;
> +	u16 mask;
> +	u32 actlr;
> +};

This, can go here, in the header:

> +struct actlr_config;
> +
> +struct actlr_variant {
> +	const resource_size_t io_start;
> +	const struct actlr_config * const actlrcfg;
> +	const size_t num_actlrcfg;
> +};
> +

Otherwise, this looks good!

Konrad
