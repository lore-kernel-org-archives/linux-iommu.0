Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04FD1E7C11
	for <iommu@lists.linux.dev>; Wed,  4 Jun 2025 07:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749021941; cv=none; b=aCDuxNQPYWReXkqwplvRFwbUS2AkbB6ueqsN8r+NFpndB3D2ifRosUr32WmH9IS56PAxqkhkb7yX0SeIxeBAqaOvk7KLk1JPAz/hu4HTurkI5/nKF9u2FPRe/lwu2I6Q+bh5mHeLylTx6S/J/96OZ6Xg09W+EZ/5shAqe96qG6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749021941; c=relaxed/simple;
	bh=1t7qv+A6Nz7eR1m21oOGQ5Dl0LE/sq7hDSCBZWr7i4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r+Pk+zFBbnzgW7CKMdLgsLml0nB+nJ272MkrO6eFL4xvbrjJaMRzcMKhKbVCUdXfY5hk2uHJMYfMT/x5gfZ9wEC270fBns0MLN7gVSmnTWXOw4vJ4VQGW1yutb5BvuW4MvxR2zRFHEv76HJWG4/TX154lE13qK7KXqd0qcSiP2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jooYOCS2; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jooYOCS2"
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ad88eb71eb5so798421666b.0
        for <iommu@lists.linux.dev>; Wed, 04 Jun 2025 00:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749021938; x=1749626738; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NTJBF0zlkgV8NEXSrbX9kCVJQCiDuy34QKFs0Z6aUcI=;
        b=jooYOCS2EiMG44drohZTRgukwm7vhsY8D8b2Tc8awUVjTf6xGNtn5uCz/cTSuzMcMi
         ZCx/4TL1+4Up+ISTEkPBS75hbLSd19f4UOHt+JaXA284cqOdTWi/PlBmpBWHFeRKvunj
         lONoPwagqtK4M8FZGvxBVa9t1c76LGRSx20pL8KRjk3lhUHKVJmSsAasIez/Dzed64ll
         HgctMmIjqGoZnkYVyTf+NCOTDSByAOlgWMWG3cFSqE3UvpZumwfNx1ndvy8L6gmia905
         aEbTn+L86d3mP+AGlp6dpuaIWYRs6rEI7NeS0dhOIjZ4bnd5HnIjqALG/psdus3xQVtd
         h7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749021938; x=1749626738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTJBF0zlkgV8NEXSrbX9kCVJQCiDuy34QKFs0Z6aUcI=;
        b=W3HgYKTfL35TSC69NfPxR/gQFenIWEzkGKAh5ETAAVbTX0vCjxry4aDqAMWdPfNFTH
         r73yhT6HI9gWN7IOmHY4mEPNOb7PBOjfruTVc51pAQQlLgM7hFNb6DY1aFYHL4VYJm1M
         2vMpjipj0RXId57d2W1MxqHr/iAW9NYkIIV2xkiyKfYnhNyskNmR6VBiD7jQdrevhOvo
         pnN3NDLmoPjOSS7WgzHgZotbSfFUlZVXKm44NV47UVIC01B+lj6hP/QwyQD8vcTudQkQ
         IQmhW+5gVMuoodSy6Ig3jNiYxWleRRl9FYSl4GMKU8ENtFf750vgZE3kLrrGSOiaKHTB
         1QzA==
X-Forwarded-Encrypted: i=1; AJvYcCXN4Uxzh2z75RE1/BDMCg5E6tFj8M4GdUIkd1qK56fvI/1lh0JewKF/WuB71DGvomk4t5w+OQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8yxNuhUB4N+Fy7M3AF3W4Myw3tMbQSsrZWQJefhSCe9dRek6n
	S49HEEH9Sxh/6OlTNnInIAJ/HYNIH7tIH3eXASYGDaIvF7jncaUEr+it
X-Gm-Gg: ASbGncuo03TEyZLaQRBy4VxDsl/7aLAljXgvVdzleD3H/AQ8Xu+S9KfdsDc8S/QBoD3
	u2gctpZbWyHRsRn29KFo2kwuM6E43q9EoFpEsO/3FDLCU/0Jz9QWEt3yO+uGYV6CYdLkGovL8TG
	VqOzhKFLFInPILxoidtx0bRFb/UbVhsoL6clbIOAOhmFygUuVh2OgmMQl0JhHvpmy6LtvGnAyaL
	cwsAQb9DrhbS9CM1EnpXSajo25Izmjhrfc2tLV00BAtrM5VejGXRev9Hv2lNaLttmeTzUuUdttP
	GnUnCWTvicgfxWZpHBmeo0+iR7yosvwz+/lDiEcoGgu45ZTdrbS3yPuwirr93sNEYUYANv9VQ/g
	/HlSouxrW3/rbd0UCvRA6lEidz/hsZ3X3e9xzcSKBcdIrOaza3mDvWhs=
X-Google-Smtp-Source: AGHT+IG4Kf5PhViqrLF+eMTC6S3fFHKzxFILRhsMk0cH0xe64tF6PCWmM4fnkEoQaNioUD5GKNphdw==
X-Received: by 2002:a17:907:7248:b0:ad5:27b6:7fd1 with SMTP id a640c23a62f3a-addf8cf6f62mr159077866b.17.1749021937474;
        Wed, 04 Jun 2025 00:25:37 -0700 (PDT)
Received: from [26.26.26.1] (97.81.207.35.bc.googleusercontent.com. [35.207.81.97])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad39ef6sm1054395466b.154.2025.06.04.00.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 00:25:36 -0700 (PDT)
Message-ID: <5fed2452-ae2a-4fca-8483-85ecf645ec1b@gmail.com>
Date: Wed, 4 Jun 2025 15:25:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] iommu/vt-d: Remove the redundant logic in
 first_level_by_default()
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Ethan Zhao <haifeng.zhao@linux.intel.com>, "Wang, Wei W"
 <wei.w.wang@intel.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "jroedel@suse.de" <jroedel@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20250523081056.223082-1-wei.w.wang@intel.com>
 <01e5d0a9-715a-48d4-a2a4-2a0b5d99149b@linux.intel.com>
 <BN9PR11MB5276CFBD4CF795CCB3ADCD1B8C66A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <BN9PR11MB5276CFBD4CF795CCB3ADCD1B8C66A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/29/2025 2:11 PM, Tian, Kevin wrote:
>> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
>> Sent: Thursday, May 29, 2025 1:48 PM
>>
>> 在 2025/5/23 16:10, Wei Wang 写道:
>>> This original implementation included redundant logic to determine
>> whether
>>> first-stage translation should be used by default. Simplify it and
>>> preserve the original behavior:
>>> - Returns false in legacy mode (no scalable mode support).
>>> - Defaults to first-level translation when both FLTS and SLTS are
>>>     supported.
>>>
>>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>>> ---
>>>    drivers/iommu/intel/iommu.c | 10 +---------
>>>    1 file changed, 1 insertion(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index cb0b993bebb4..228da47ab7cd 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -1366,15 +1366,7 @@ static void free_dmar_iommu(struct
>> intel_iommu *iommu)
>>>     */
>>>    static bool first_level_by_default(struct intel_iommu *iommu)
>>>    {
>>> -	/* Only SL is available in legacy mode */
>>> -	if (!sm_supported(iommu))
>>> -		return false;
>>> -
>>> -	/* Only level (either FL or SL) is available, just use it */
>>> -	if (ecap_flts(iommu->ecap) ^ ecap_slts(iommu->ecap))
>>> -		return ecap_flts(iommu->ecap);
>>> -
>>> -	return true;
>>
>> The function works like a digital circurt has 3 single bit inputs  sm,
>> flts, slts and one bit output ret.
>>
>> so the true value table of the orignal function looks like
>>
>>      sm   flts   slts    ret
>> a   0     x     x      false
>> b   1     1     0      true
>> c   1     0     1      false
>> d   1     1     1      true
>> e   1     0     0      true
> 
> 'e' is actually wrong. We should not return true when the 1st level
> cap doesn't exist.

If so, this patch should mention it fixes such case with fix tag, not
  "removing the redundant logic with the same behavior".


Thanks,
Ethan
> 
>>
>>> +	return sm_supported(iommu) && ecap_flts(iommu->ecap);
>>
>> And the true value table of this new one looks like
>>
>>      sm  flts slts    ret
>>
>> f   1     1     x      true
>> g   1     0     x      false
>>
>> h   0     1     x      false
>> i    0     0     x      false
> 
> so this table is correct.

