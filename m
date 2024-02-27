Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED361369AB
	for <iommu@lists.linux.dev>; Tue, 27 Feb 2024 10:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028766; cv=none; b=Cmtz3yLRWvi6CsboamW7kXkElOpDMN0pOFlJXed/MAjTtru1LlZnOUINBEe0n1z4H+IeX1PbYwF2S5vkfaoH1rqJWY7zb0l+Tp05jtl3Krnm8fcLYhiBfqi++naFvvYr/B4rwtTVXk5hxjzWVFaTv0Ji45eAgqL6Rr83K1i2tI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028766; c=relaxed/simple;
	bh=RPCuL5Zw1DFBhHuejMGcZGxtCQR3v1sWQkrzuFlOItw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQD5+qM1Lj3D//0Za64tf5ZlhlksBZht0YH+zbDP5bWk4RL9MNs3N4aPGTxjof/m9JBxc0FwKZpcabe9xCfcjMzqMRysMIZkBEcWfnxHOBVdwIpAUgwW2lbNJTaADfEHFxBQhqN2cpC2vCX0I6dSFQOxXr+pZ205Br0c9P6CclU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dByusN4Q; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dByusN4Q"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512e1991237so3401579e87.1
        for <iommu@lists.linux.dev>; Tue, 27 Feb 2024 02:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709028763; x=1709633563; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xdcTuKOvy0EUhMzr/avSzwKVXZwTIOQgOR4V6+G/+Rk=;
        b=dByusN4QyTKGr6OgSIJFbr6gECe9pKKsI51Vt4JDH4By9rqfpjp71lHHaLDXQnaEWN
         a0P/7tzfz1XuOKV9utJ1FF9jOjL8Bemt7hjNlcVpbYYUkyMPkRyUooVexTLADJwi8aeb
         FC3wsy8J8zyiTN9JVmGuFle4TFqaeIZQYlH/FsV4Xh8gmpmRIykRMmwAxeGM79/jA2Oz
         3AG0bbgwSFg6EV7iLSEDSXoa20sOFHQ0wiwJQPiHbnyiBcG8odwweNZRLm3IXCGf2c5u
         wV464ckehJ+31uqMEZ5yI7NXqSCc+Sun77p00/7PdzE5LOUAuWFhemrQ1tB9WWhjQbnQ
         XnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709028763; x=1709633563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xdcTuKOvy0EUhMzr/avSzwKVXZwTIOQgOR4V6+G/+Rk=;
        b=cEZERFAxF3ash8BKexfNcIW9r+J4gkZENBDe4+zSjRF80821sX253kPqt8NfZdJPIS
         47rsuiY6BgutQikOifB2KmCcEmhfpX2vLKELvhtAldmq4tQsRzvA4YKEvv/XxUSjPl/R
         9xrVMe08wk7ORPnTnWhvqDh5oqBhm7CMvRmqVxOCcEyA2K+6LwlkR5jGUbqQvHLK6Vat
         VZiL1vOIL0xfSM/sUKESwALDzcgm1SuZr4G5c6mm45ndxmvuUeuFGcaOVgyzJv+f9QqF
         vC+zMhNaWlJBTE98u//VZWYoodysZwVv/bEYVDA7u5/Tij8wDl8xrfhSe3037TiEnSQI
         SY1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5mWMThJRbUaDVPaLVYPTbkkizl0aqtRrZC6R4/IAOBvYC92CXVF04vO7aBFD18l7lApEaXjn1Aj1xxft7sb1+/tbVaIk=
X-Gm-Message-State: AOJu0Yx70uIwv0OhJ7WSbpZw+GElmR3CiiunMoC4V+S4y1+bRfNTSzo1
	3/2G/MGKR7jUA9++xPBgJz+MOdDTW72CPvT9p4/5cC2xLDXDKrI7LE2lyGPk8Qg=
X-Google-Smtp-Source: AGHT+IEuX+LAvgGR0dujrY6Se1xlvX+40UrwavICTj8b1/cNQL1xPoiOn1bdI5jJdrL4sEXbMeapyQ==
X-Received: by 2002:a05:6512:11cf:b0:512:f389:d6e0 with SMTP id h15-20020a05651211cf00b00512f389d6e0mr2702097lfr.4.1709028763072;
        Tue, 27 Feb 2024 02:12:43 -0800 (PST)
Received: from [172.30.204.241] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id x18-20020ac24892000000b005128d0e2a07sm1136919lfc.308.2024.02.27.02.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 02:12:42 -0800 (PST)
Message-ID: <f5b373cf-79fb-4d62-9d3f-9a9ffbfb5d8a@linaro.org>
Date: Tue, 27 Feb 2024 11:12:37 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] A702 support
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>,
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
 <20240227101055.GA13753@willie-the-truck>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240227101055.GA13753@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/27/24 11:10, Will Deacon wrote:
> On Fri, Feb 23, 2024 at 10:21:36PM +0100, Konrad Dybcio wrote:
>> Bit of a megaseries, bunched together for your testing convenience..
>> Needs mesa!27665 [1] on the userland part, kmscube happily spins.
>>
>> I'm feeling quite lukewarm about the memory barriers in patch 3..
>>
>> Patch 1 for Will/smmu, 5-6 for drm/msm, rest for qcom
> 
> I'm guessing you don't really expect me to take the clock bindings?!

Sorry, I didn't remove this hunk from v1 (where it was smmu changes
that you already took)!

Konrad
