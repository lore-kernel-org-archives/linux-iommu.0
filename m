Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758D313AD3F
	for <iommu@lists.linux.dev>; Thu, 18 Jul 2024 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721305628; cv=none; b=L4zJ9z893KyX+MkDuOMW/orDz/cNEU8HrUUuyobz2/MT9bMjjclsNef8CyUwPUKZFKLvyUgQ50fDoValWzhnXm3v8OeI64/ZyOMI0tcU6r+PvgKC62qJ8qL2XCar+Kxfudrid0OZKVP0/Z9avUkyFuiecp9A0AXUgCHf1zsZ1iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721305628; c=relaxed/simple;
	bh=5ch03PbNO0KcpUZDwUEQITWA/MHyvkqxecTlQA6KFMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fr7zcu3pFsac0xv1sVMEhj1mJv2iQ1TuwuvrocRlpCBjPO3f6Fwg/paHUY/86EX1kwm1aJtY/Fo9rmKQ1LU6wrP+bprVNQNFTJjA6Fm8Q0i7IVu6+PPuqyIAhwcmdLoB2ikbE/Dg8uiJKtQLPWDMRQCqdDFP8zll1nC3efaexWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i73+p647; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i73+p647"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52ea0f18500so256932e87.3
        for <iommu@lists.linux.dev>; Thu, 18 Jul 2024 05:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721305624; x=1721910424; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q2XFn5QQgFe1WnayUef7JKEEQ6sdt3Zxd24uxnNsJOo=;
        b=i73+p6477tF42J29Cjq4gY7z0sI4CvlQJAcMYYL616ohtgq6Nupgloy/MYlMnS59JP
         Xq5O3K9c+Um+CDUwQ9jI0uIA+fzgRs+7xmOzSWNnsyStJnJID1zq+P//uJkixqN2NrrA
         Iuu9Ypv9eCG8USDjU69jL3Ch1F8dX3DJGdEvMsumz3Wl00FWA6ehuFUmr0IeJnLPZst2
         YtuLQ6Akf+O2ZEU5TC2v7/ImAMT6dPwTzaefc3xhlMDAhsl63HVBqryFsvproVa+tRwZ
         AT3Sgrm+KwOn4fdEA5DojxH/ycf6/pxB8qY0Uqf7C7jVY81MGOBUR9J63V5M1BVeeTdm
         Zu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721305624; x=1721910424;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2XFn5QQgFe1WnayUef7JKEEQ6sdt3Zxd24uxnNsJOo=;
        b=YZwrdhb0CchoSZOJPJqqrkOZX+zhApmxONa1kFsUpn9D2GzKzSdEbGEugcbYPF8ZIh
         5XSqPrCIooSuZIbSNM8MhqTVuyaOubFoESzFTwMikw0WqQyJ6RgNRmwFIYcJFlgO/3L1
         JfHh3z3UeM1OaQ+Ynu/cFy71aDB56UyN20TC8vqnb/ZiSvjR1yARmdGkaQMxK9oe2Z4w
         C2wFVUs77+9NdKG/srSg4E6dvWDm5jbyThcxVTd5tuGh0xaYQ2Q7kxoRsab2O5aF3QKA
         FlM6BqmQ7kXVsN6maMd28M9msPqhNBrSb/Uuz4rch61QKm6HQY395ThO3IwjgTnuTAQ1
         GSvw==
X-Forwarded-Encrypted: i=1; AJvYcCU+IP8whbtgHtzkZ6uJaNg8rU2XuhUEs73dI26WPs+TLzMpv0/jNbpN5LWHDO6jxB9gJS45jfAkg+I6cD6sLuBMZqdwts0=
X-Gm-Message-State: AOJu0Yx55J2ADSelk3RE8LFLZEvlHCR8Fns2ad39D5GF1U1Eths6qJ4O
	cEUXlujCd/MBPaZsKx17KUVOk+rb9l9CNSdz7VQ3WkxRN9nZM33hP5cnvco5eyA=
X-Google-Smtp-Source: AGHT+IFpho18lmDKc7X0msF9sfCuM30i0lyf/vediCfHZae4eLSGRU9CVd8hHv7u8hXrqS7690aQVw==
X-Received: by 2002:a05:6512:130a:b0:52c:e17c:3741 with SMTP id 2adb3069b0e04-52ee53acb53mr3121740e87.5.1721305624269;
        Thu, 18 Jul 2024 05:27:04 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5a38c2sm551628566b.44.2024.07.18.05.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 05:27:03 -0700 (PDT)
Message-ID: <fd74e1e5-a652-4fd9-a4fa-d44e1482a9b6@linaro.org>
Date: Thu, 18 Jul 2024 14:27:01 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] drm/msm: Extend gpu devcore dumps with pgtbl info
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
 Rob Clark <robdclark@chromium.org>, Sean Paul <sean@poorly.run>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20240717163627.43423-1-robdclark@gmail.com>
 <20240717163627.43423-3-robdclark@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240717163627.43423-3-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17.07.2024 6:36 PM, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> In the case of iova fault triggered devcore dumps, include additional
> debug information based on what we think is the current page tables,
> including the TTBR0 value (which should match what we have in
> adreno_smmu_fault_info unless things have gone horribly wrong), and
> the pagetable entries traversed in the process of resolving the
> faulting iova.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 ++++++++++
>  drivers/gpu/drm/msm/msm_gpu.c           |  9 +++++++++
>  drivers/gpu/drm/msm/msm_gpu.h           |  8 ++++++++
>  drivers/gpu/drm/msm/msm_iommu.c         | 22 ++++++++++++++++++++++
>  drivers/gpu/drm/msm/msm_mmu.h           |  3 ++-
>  5 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 99661af8d941..422dae873b6b 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -861,6 +861,16 @@ void adreno_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
>  		drm_printf(p, "  - dir=%s\n", info->flags & IOMMU_FAULT_WRITE ? "WRITE" : "READ");
>  		drm_printf(p, "  - type=%s\n", info->type);
>  		drm_printf(p, "  - source=%s\n", info->block);
> +
> +		/* Information extracted from what we think are the current

I'll keep poking you for not using

/*
 * foobar

instead :P

> +		 * pgtables.  Hopefully the TTBR0 matches what we've extracted
> +		 * from the SMMU registers in smmu_info!
> +		 */
> +		drm_puts(p, "pgtable-fault-info:\n");
> +		drm_printf(p, "  - ttbr0: %.16llx\n", (u64)info->pgtbl_ttbr0);> +		drm_printf(p, "  - asid: %d\n", info->asid);

0x%08x?

Konrad
