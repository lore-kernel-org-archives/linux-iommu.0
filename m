Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B098BFD
	for <iommu@lists.linux.dev>; Wed, 10 Jul 2024 22:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720648886; cv=none; b=kY5Y3GaHzf/myd0rjce97U815VPJszS45yqISmkJL1OUQSfeCFUCJUAnly8S/26Ieg0liyHj++R+JlYlo4UEYKWqfEbo9XutEIuRdKfaGnHsP4CLzGS7Sv9LOVJ+MHch5nA+TZo14+GN/FBFv+s3IvadfQHFyBh81h/FhD7KI9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720648886; c=relaxed/simple;
	bh=0/ZsPcsndPYqDvEZoLQtpd2fDcgR8R9jtx5n2cpHTfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GkcdIGpb7JqsXVMbQI/GVXC3obyrZCQfL1bTYxjDNxNq9kD1vnrYzauvvPKe5wTQLqHMBfTOuP4OKb9PWL0N8wT4CK6jJVa9Ff55+7WWNE4e5yti2ienoW8K+Q8dCOtKTBtiDvNRJS1Cw97tYKfCj2zGZb8MSsNudex25D3SBR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=awG5mcBb; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="awG5mcBb"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a77baa87743so24764366b.3
        for <iommu@lists.linux.dev>; Wed, 10 Jul 2024 15:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720648883; x=1721253683; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zf1pp9dOgmxGyQBYWisVbbmnW9QAhbQOazYQx/2Fl7w=;
        b=awG5mcBb+L7wABiXiH11PVfCUVgAKph57pF5VxNmqHZ1uLYZqvPOy2Neo9ZCByVuqY
         1Eli2clKVEYcBzXFkSGPyVkiqh17yUkHvf/AnWPaIn5FayocnN21pddg2vmkHUi/6nC2
         +SqvdNDo+dgSP+V9M0uQAgE3RVFichA0KTyADDAQ8dFLHB6VnHQO18mm3U5KfaLEhqHa
         at2pKCVgF3N4OnHLBdl1EVP7Zs3GrUZ5n1OdXnD9WQd6HPrxKwqA/7JwT0am0x+URBsa
         KpMGyF3MSPZBHLv9fd7xgcfNgdwph5XAU06K/61lkjdxx3fjK79B0b3Di1eCGLhJaMgZ
         vfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720648883; x=1721253683;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zf1pp9dOgmxGyQBYWisVbbmnW9QAhbQOazYQx/2Fl7w=;
        b=Rr9TRX8yuAUS/lQBKU7OppIkdq4XoBHwEqz/coHfwjxB0hNo3fNSlDRjjHMdsuhyE2
         /MXcNlKFXOK01JZOXvFVD5TAb+t7W1hcHgEUF4PfcEDlBJI3/K2d8oWe0bbKCIJx+ijs
         dW4CBctLVFRRR7/++aJA0HZKIHr6qWn8FiIuAnAD1w+pAZbvISE5806bFSgZSynpwlgP
         pOB2+oCcnHJrpvMqmeouaUNhl+Fk56uMffaEmbkhLWICJK+s1SyW1uEa/2+kzhcpahWF
         j8i2RigunV7mrp4Pbko8f+mxxOFdw3mY3UmzuObp08Nhl9gMCObRxYDE29aVnyGLq7bZ
         ljYg==
X-Forwarded-Encrypted: i=1; AJvYcCWdTng7MSezWmU6O9oBcNpZLcsL6CbL1Cwi1UQ9lFrNV0jfCWnJEAQXXWhj6wOXDU1xDmbEhnTv2znhH3OHRqbLxSlS3Hs=
X-Gm-Message-State: AOJu0YyhHcmWQpWoD4HkmsFt3NvlmqoagiSX2VwAGAXf5wiundH3Hodu
	yzDmX0TXwRNydzXwnVjcwfEYdhv3JPimhUUHHjnIApcb+rbdAPAAL9oVKeGQnmU=
X-Google-Smtp-Source: AGHT+IF4jq8yt4jQDz/VDWCfZu27ZsRCQpuF/N2TiFiwqjAXZchm3oBEIHNy84eHP2CV5+WZrCx7hg==
X-Received: by 2002:a17:907:e90:b0:a6f:4e1f:e613 with SMTP id a640c23a62f3a-a780b6feffemr629317166b.37.1720648882916;
        Wed, 10 Jul 2024 15:01:22 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a855f09sm193561366b.164.2024.07.10.15.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 15:01:22 -0700 (PDT)
Message-ID: <f4994451-9dc4-4d25-b544-49531709e76d@linaro.org>
Date: Thu, 11 Jul 2024 00:01:19 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 6/6] iommu/arm-smmu: add support for PRR bit setup
To: Rob Clark <robdclark@gmail.com>,
 Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca,
 jsnitsel@redhat.com, robh@kernel.org, krzysztof.kozlowski@linaro.org,
 quic_c_gdjako@quicinc.com, dmitry.baryshkov@linaro.org,
 iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Clark <robdclark@chromium.org>
References: <20240628140435.1652374-1-quic_bibekkum@quicinc.com>
 <20240628140435.1652374-7-quic_bibekkum@quicinc.com>
 <CAF6AEGvroi8rJimFv95tkWmRFa5_aTpBJ7GFcRAuZpLGdSyEYQ@mail.gmail.com>
 <0650ba0a-4453-4e2d-8a76-0f396ac1999c@quicinc.com>
 <CAF6AEGv_9e-TDW1r0N4-db6pY_aV_EZFqrpNbATVS5Vy6+fs1g@mail.gmail.com>
 <4a5f54c7-120e-427d-8a0a-9fb83e13a72e@quicinc.com>
 <CAF6AEGtrtFNxDWtuADA4oOHhZJ=dJZcGaJ1XLFJt4fe4Xp=pTA@mail.gmail.com>
 <3b7c05b1-8f36-4c81-a55c-dbb467314099@quicinc.com>
 <CAF6AEGuRKU+DkL0-b3xdR1R45_MiiKQYRRXEXYz-xohu8rUaEQ@mail.gmail.com>
 <CAF6AEGtbw06-gOSvX9gAbi=SA801gmD3_8c5xkOU-G9g2qKptQ@mail.gmail.com>
 <9509f256-04a4-4907-98fc-148c5087d74d@quicinc.com>
 <CAF6AEGuLwZ0yFGWMKX-O1VjQB2M57K+CsyJ=7PCKXE=b=VsSNg@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAF6AEGuLwZ0yFGWMKX-O1VjQB2M57K+CsyJ=7PCKXE=b=VsSNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10.07.2024 7:01 PM, Rob Clark wrote:
> On Tue, Jul 9, 2024 at 12:43 PM Bibek Kumar Patro
> <quic_bibekkum@quicinc.com> wrote:

[...]

> If there is a clean break, such as all smmu-500 have PRR and all
> smmu-v2 do not, then it would be reasonable to use the compat strings.
> If not, I think we need a different way.

if (a reserved-memory region is passed in dt) {
	init_prr()
}

Konrad
