Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A01C13DDBE
	for <iommu@lists.linux.dev>; Thu,  6 Jun 2024 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666061; cv=none; b=Vv3YarIYzhZvATOXOao15CDklafl7c1/YEVcnzOenF9mNem34qqemKrXpyO5CFqjFFfQreeiLRGCCz2ZxYikGS1MZuS9OGwyNuTides3QciP4m6X6a1KzxK8fbYbF7JpYDW26/qHSsL+Uk2wK4+Sb9+Kp8dy6TfPIfXGOiKNYR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666061; c=relaxed/simple;
	bh=rYnqU+2ou4u7Kaw4R/jgOa2YNlkFkEhv+b9vNxA6IfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TwluhYmy+DObybB5x0XrJ+nQPu0F2vBganZMm81I4nDDrDbX9QGnsUT/KkfrmVtHyv775LRoL4s7DZG0dLo3sHEDzpCruVLj/tJwV8C4xCaVcfGwsP5QhZvsIQx0/aNzlnVy0qQkU8ToBMAvmir+WHjQDL09A2Kvuj153algsn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dOb0nqM9; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dOb0nqM9"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a23997da3so727732a12.3
        for <iommu@lists.linux.dev>; Thu, 06 Jun 2024 02:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717666058; x=1718270858; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4coGUS5rqVO/XkMEjgpDlue2Pr3XzDgvTCMJ1kTn61Y=;
        b=dOb0nqM9UGeJhGT0+PnDB0kqNMnP0mHqEdBeauvVbphlqfTaBxLDo/XIQwStKgHDJq
         u38/iDFMvbXOHiDOXx1GmAgm68bX7qF+wFUVkqsnX6CbZJordDwMb+32wnpEVGXzWUUt
         Cb3ys/q0jvz3QqGjUI3xzOOxoyhx68XHF54Qsmw8kEVxqiAQpUOY0wj3MvDGVX1vgYYk
         ibWKr+R8kLv+KSFEJaGGnU9FJSLSB8iAZP22df2T9eHiPDtOjwmaGgf/NC1yhXNrhRio
         XCD6/jRONsXNNN6kkOK8z8Qo6kG0oVe/f2e2okl1WH4sd9qibTn+BLZ1O+TGiIjZ1USy
         oR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717666058; x=1718270858;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4coGUS5rqVO/XkMEjgpDlue2Pr3XzDgvTCMJ1kTn61Y=;
        b=s1xqTDJgofHGhp8eslnZRKjXBt9Mx3TJSmp/E7m4pwoPdp1Xwsj1VWN++O/cZXb7cF
         l40Voyd+LavqZdvAcXWtoLghBgOlqNxelGyZvudLMXvizSo3/0DepWMm7nB/HCVW3xiz
         Mk1HNvMAwosLBeszHcqEutD/UEJc0kC2G8xvbCEdkfqrnEcMzZIku9Op9aKEWylx4AvN
         Fa9Vaw4gjSKSU8hujnyntOZ25/pHBivPSzqce48puCAv123W9cmEL+ZThUOtlmc/uHY2
         Z5vqcpmOup/1j0hF5BYyeGRHRWp/JuJXAi92NJKdmOq6dGeyXFAGzszQcrPFfuqxZUHD
         3U7w==
X-Forwarded-Encrypted: i=1; AJvYcCVxqLlwU9KWnRA8zpU1HFc5OdKeGzZ1Wuv/ljEoGNKYKa8/ZzaA4gvrO3mJ9lS6yDKEIkIUn9aSy3tAIgZLKiCbZUQVLwI=
X-Gm-Message-State: AOJu0YxpDXS6NEHwhHfGJCgRnH6FcFi8p3gkCIwxgTc4X2NGrrsDCDKh
	VlkWA4FRzbTYWNASww5o9n4ExPhcNqKxteEDpvBkj9nppSf1qGX3r9RiJLMRiTc=
X-Google-Smtp-Source: AGHT+IGqN8B1VWaFB5hpOX3x2j23zjabMi+w1OoZszVo5ULIhjp7d0F8Xv74HZa+5EdL58oQ+GHQ2A==
X-Received: by 2002:a50:d5c8:0:b0:574:ebf4:f78c with SMTP id 4fb4d7f45d1cf-57aaaf0eb41mr807201a12.7.1717666058529;
        Thu, 06 Jun 2024 02:27:38 -0700 (PDT)
Received: from [192.168.128.139] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae0ca5e3sm766761a12.25.2024.06.06.02.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 02:27:38 -0700 (PDT)
Message-ID: <fca5168d-9ea2-4fe9-a247-0d97ab175eb3@linaro.org>
Date: Thu, 6 Jun 2024 11:27:34 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] drm/msm/adreno: Add A702 support
To: Connor Abbott <cwabbott0@gmail.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20240219-topic-rb1_gpu-v2-0-2d3d6a0db040@linaro.org>
 <20240219-topic-rb1_gpu-v2-5-2d3d6a0db040@linaro.org>
 <CACu1E7FTN=kwaDJMNiTmFspALzj2+Q-nvsN5ugi=vz4RdUGvGw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CACu1E7FTN=kwaDJMNiTmFspALzj2+Q-nvsN5ugi=vz4RdUGvGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23.05.2024 2:14 PM, Connor Abbott wrote:
> On Fri, Feb 23, 2024 at 9:28 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> The A702 is a weird mix of 600 and 700 series.. Perhaps even a
>> testing ground for some A7xx features with good ol' A6xx silicon.
>> It's basically A610 that's been beefed up with some new registers
>> and hw features (like APRIV!), that was then cut back in size,
>> memory bus and some other ways.
>>
>> Add support for it, tested with QCM2290 / RB1.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---

[...]

>> +
>> +       if (adreno_is_a702(gpu)) {
>> +               gpu->ubwc_config.highest_bank_bit = 14;
>> +               gpu->ubwc_config.min_acc_len = 1;
>> +               gpu->ubwc_config.ubwc_mode = 2;
> 
> I just noticed, but this is wrong. ubwc_mode is a 1 bit field and what
> this is actually doing is overwriting hbb_lo, making the highest bank
> bit 15 instead of 14.

You're right, this should be a 0. Thanks!

Konrad

