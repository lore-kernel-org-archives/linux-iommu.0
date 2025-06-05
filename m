Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6750442C
	for <iommu@lists.linux.dev>; Thu,  5 Jun 2025 03:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749094446; cv=none; b=UVVMkfEfSAq8KISAT8LJSn6QdCLfI2ZQGLRvRZHCsltqK6waZvcUDhQNqqneO3gtCG8ZLDIrAW5IQDUttZV2Fqg1oxUMP2h9cl0Ud4Fk0x3KKM5eT1rejXjP6k+sfsFWc794C5xBcu2mhUvA5FYeaLadP8D10SwGpBbuGmXQGaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749094446; c=relaxed/simple;
	bh=dQqP5Mw9oBgntBuM940PPtoh91B6oGN2B1g372Bat54=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gEP+EMeyq0cMA7ertZPVdM3682LgM75MbksHrG7+wTXpyn1okpboz2fk9vlp4CHwnHaZNL7pWKMuDmY1s54DlrxP5vKnWyiBruKR2ys0oBbCmjybK7yJaK0dQkOJj7tFMAHmBD37yyMdRPsfzu8RjPoi/Dfj1651211lykZT63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXyohwv7; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXyohwv7"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so4034425e9.3
        for <iommu@lists.linux.dev>; Wed, 04 Jun 2025 20:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749094443; x=1749699243; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/vEVlRXJsGRk+CYX2FZa+ooZ3uzbfFEcI/JYbkngtl4=;
        b=SXyohwv7PV50WJBgnZCAvhwy4K2JlPyzS2rdYph2IDqaxZMJM7hxp412v/Nq47mq/z
         K8hn8XTARsnGPGF1R0HvTegU4SrAWjSrh0HfqSoB3rExU9oSbBWOxd8L1W4fPzA1DuSn
         r3lYyPxmppbMAClHXz4eH7UVO1SNgHqvh4eCO/eA6Ko/5r5xuCvEqGH2L6vJFW72jQTS
         89aUPaFmO6hP30IiJgZ9aYrsuxGvqFybKhNj+CyPhxZJXdPwZ4J5YYLOkD9b9rYhpwuw
         /U5WX5L9cAvG/FbgDEOCA47dobD4E/eaad3rcUARU653kAnaUiK4qotPRaxxNHv4jYdS
         q0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749094443; x=1749699243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vEVlRXJsGRk+CYX2FZa+ooZ3uzbfFEcI/JYbkngtl4=;
        b=I314rD+tRCZvnRrvc7+Ek/rTzQ2NsRQ8nBdthZwaOTs2oRMkjHDyXHoPeS66uNDLPH
         TPphcbPLs9p4+jPZw7bWm0g5W8CFyWLy60wDrh15kQoI8hbZ3uNfF+BJjan9RTQ2QiHI
         9iuWsIKB0DKCopa+vbQBALWLjeeAtKugWNEwZTlWx+NsMBlVtZBMEKrEFvOb5eHmZLQu
         v9yBrNcWOWTHUAR153lRgY3gE2PYOunxx/YcX6c5NGUv4TQa9TgJ7aX5G7VvJdbiS/fv
         c3GKe3N5AGu77PZGzFNn879EwSM4WG1cwg7Oq8sREC/6uh17ODz2vqfiGCMR3yZgqPwd
         aRZw==
X-Forwarded-Encrypted: i=1; AJvYcCXNMoVgWZ/AgMhc3XdzF3NW27O8zW1YQLS7aLUt3PquLJJ55VYyUSNpsvBiBuSr2KXrQfXiuA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEm1durWPLwhvBpMQJQOHj2JvAZwJbP5BAed/P6diwrWsiEKQ/
	QHtB8sHrxie2cVgAfflkqccewAfjGk+NS4vB1w6ptOgplwBeolcUg+3b
X-Gm-Gg: ASbGnctlsPr207/up0RcjO95Pr4ujjYwMkNEuPq5D83DFXMfX1Ak5Vb7BrNTiiIsfeR
	duvHIBl52PO1OwzYd1kuBL4NiNPPaHt5TQq0pbF3H4/r4EgpYvyaZAOcmksavynAzi1PxiuGybS
	fmMpLYD1eeu1saSG+d9lshdRzgX12lN2C9oYx4Kv8m12WROIXvXY4y6KSX+cW3tsoDiiiNGsKDv
	hb4A2M9wVAdCnt8nieNXe7cZHFgavMX600VBIzFEtfVjPkGZwkls+bYXVGLXbwc8oMCMtKe6cAr
	ZIpB09BOep76s+NYltD8X6LOEdR58J0oGlyKuk9KWeXnnXjVClKL0DEOwNjJG9A1RxsEpk0sbPH
	k8Um99x3jkNeP5u3LvyWVqWrRoUc2kB5mPimPi0i22kG+hXwpa51nmAwqU2afeInXATU=
X-Google-Smtp-Source: AGHT+IEZgXvmDKwf9FJeIM45CjWz76tqF1urHtCuuWuqbDzmF4SGEdtCa9SQaWtDO2CfP9KYiUjtrw==
X-Received: by 2002:a05:600c:3e88:b0:450:d611:eb95 with SMTP id 5b1f17b1804b1-451f0b269a4mr51677185e9.17.1749094442734;
        Wed, 04 Jun 2025 20:34:02 -0700 (PDT)
Received: from [26.26.26.1] (ec2-63-177-217-227.eu-central-1.compute.amazonaws.com. [63.177.217.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f99198a9sm9586775e9.30.2025.06.04.20.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 20:34:01 -0700 (PDT)
Message-ID: <d30b70da-d06e-4d96-b110-1459533e2943@gmail.com>
Date: Thu, 5 Jun 2025 11:33:56 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] iommu/vt-d: Remove the redundant logic in
 first_level_by_default()
To: "Wang, Wei W" <wei.w.wang@intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Ethan Zhao <haifeng.zhao@linux.intel.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "dwmw2@infradead.org"
 <dwmw2@infradead.org>, "jroedel@suse.de" <jroedel@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20250523081056.223082-1-wei.w.wang@intel.com>
 <01e5d0a9-715a-48d4-a2a4-2a0b5d99149b@linux.intel.com>
 <BN9PR11MB5276CFBD4CF795CCB3ADCD1B8C66A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <5fed2452-ae2a-4fca-8483-85ecf645ec1b@gmail.com>
 <DS0PR11MB637325E3CD8FECC9A1D1213ADC6FA@DS0PR11MB6373.namprd11.prod.outlook.com>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <DS0PR11MB637325E3CD8FECC9A1D1213ADC6FA@DS0PR11MB6373.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/5/2025 9:04 AM, Wang, Wei W wrote:
> On Wednesday, June 4, 2025 3:26 PM, Ethan Zhao wrote:
>> On 5/29/2025 2:11 PM, Tian, Kevin wrote:
>>>> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
>>>> Sent: Thursday, May 29, 2025 1:48 PM
>>>>
>>>> 在 2025/5/23 16:10, Wei Wang 写道:
>>>>> This original implementation included redundant logic to determine
>>>> whether
>>>>> first-stage translation should be used by default. Simplify it and
>>>>> preserve the original behavior:
>>>>> - Returns false in legacy mode (no scalable mode support).
>>>>> - Defaults to first-level translation when both FLTS and SLTS are
>>>>>      supported.
>>>>>
>>>>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>>>>> ---
>>>>>     drivers/iommu/intel/iommu.c | 10 +---------
>>>>>     1 file changed, 1 insertion(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iommu/intel/iommu.c
>>>>> b/drivers/iommu/intel/iommu.c index cb0b993bebb4..228da47ab7cd
>>>>> 100644
>>>>> --- a/drivers/iommu/intel/iommu.c
>>>>> +++ b/drivers/iommu/intel/iommu.c
>>>>> @@ -1366,15 +1366,7 @@ static void free_dmar_iommu(struct
>>>> intel_iommu *iommu)
>>>>>      */
>>>>>     static bool first_level_by_default(struct intel_iommu *iommu)
>>>>>     {
>>>>> -	/* Only SL is available in legacy mode */
>>>>> -	if (!sm_supported(iommu))
>>>>> -		return false;
>>>>> -
>>>>> -	/* Only level (either FL or SL) is available, just use it */
>>>>> -	if (ecap_flts(iommu->ecap) ^ ecap_slts(iommu->ecap))
>>>>> -		return ecap_flts(iommu->ecap);
>>>>> -
>>>>> -	return true;
>>>>
>>>> The function works like a digital circurt has 3 single bit inputs
>>>> sm, flts, slts and one bit output ret.
>>>>
>>>> so the true value table of the orignal function looks like
>>>>
>>>>       sm   flts   slts    ret
>>>> a   0     x     x      false
>>>> b   1     1     0      true
>>>> c   1     0     1      false
>>>> d   1     1     1      true
>>>> e   1     0     0      true
>>>
>>> 'e' is actually wrong. We should not return true when the 1st level
>>> cap doesn't exist.
>>
>> If so, this patch should mention it fixes such case with fix tag, not
>>    "removing the redundant logic with the same behavior".
>>
> 
> Probably not a fix (just code improvement). Your 'e' above is not possible
> from the hardware side, and the old implementation doesn't have it too.
> 
Is there any items in Intel VT-d spec to say "It is impossible to have 
both flts and slts to false" or you design code under an assumption that 
hardware always works perfect ?

You made an assumption that the hardware never would reach there and 
then got a conclusion 'e' doesn't exist ?


Thanks,
Ethan
> 
>>>
>>>>
>>>>> +	return sm_supported(iommu) && ecap_flts(iommu->ecap);
>>>>
>>>> And the true value table of this new one looks like
>>>>
>>>>       sm  flts slts    ret
>>>>
>>>> f   1     1     x      true
>>>> g   1     0     x      false
>>>>
>>>> h   0     1     x      false
>>>> i    0     0     x      false
>>>
>>> so this table is correct.
> 

