Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1763F58C6
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 22:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783376026; cv=none; b=UCwxTeSYjAlnDrjvkQKyP6VCZz5THAM1esOTD5U8reZeobllZ+IHBcklmbY6AHxgGhIvi2SunjdzG93TZYROJGtLnKLieN3g6LYrTzkv/OXM/Fely7zLvkw7rpo1xbsNuS7raKsJ1P9VWgyqytExaMZg109IHs8sg7iiQbBWEF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783376026; c=relaxed/simple;
	bh=m3kaKDuOinnzWNHwerx5pFFY+Eflp1o8yKhTqlHb8xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBQyeaVNBEWfFAxJxHmt/il0dFqEvQZ2U19Ad2foV22uWUo2q+s8Ukx0KPb1I3hmxMoaaFOlYmCMmUbZU3Cy+Z2vF5AphcdaSbg2sYeNCxWUWXF6Z0J+J3caAJnCJ6zDi53Y2dl5s4LWw51QCeLC9LkEwwNB4ozB1tOENRZzCnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFpqwg2K; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFpqwg2K"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-475881b9a4bso3045640f8f.3
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 15:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783376024; x=1783980824; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3VUxjcvyG7o7DixEmYl5pZcfD8TvxQHqFhtXA36U/44=;
        b=RFpqwg2KRZtHoPok73fMZIFNyHblImv844Zg8XAr8XDw+b/z9sBacS14vDoFbl5Z4L
         wf9Bjt1V09u9iAQkiu86d6+81OGs9UDtzoYgU2Qd2s6xCiYCN2vnmsXRSLRn5WZd1GBg
         9f2A5u97TXQ8Z5Zi27Ky3/5xOJtTBN4h9yc7fiCAJiXD8Tdlx5+YQvZFBLWJJ9qczR9a
         2EOueHRBHkAwVLUwzJqKVZ2X+HfKzCSUI/QpRLAcrMcsioPefcOfl28xlFTTY24gOcoC
         HHCwAsxSeqrS25TxwK2tZaFRwqzZcGYx+1yEemEZ62OF6ObeHVCqjGWUk/PDQvcdTE4G
         1tGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783376024; x=1783980824;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3VUxjcvyG7o7DixEmYl5pZcfD8TvxQHqFhtXA36U/44=;
        b=KjjdIaOtGxbTGrU8VY0aj8xSK2a+QiKHKXEuZCHG3oxoBICv6pkk/1ycPB8eLF/HbD
         5yJl8P2jGVw4yNWOpJez3uHGlsZCyrY0efJFBA2gurMOMDX8WMA8vfnr67sC8aMsNjhw
         cmmu4vHtRRV88gE71wXWv9QW8YGXxddGnJbLD0kUdX6SSSW3em5CzVyCPkHDdzqKTMBi
         P/IedpUgeLMbFyCp3kL2cSPyKzdpVS7a5QaSevEuStIl5zbtdeIOxwBIjHXDw6dHEKmp
         tCm4hTwYTP9ju3KOO36f1KGRLhhjsA96s44gpRzXfpLb72UN/19MLNpJNJIXj5fQDNwm
         Xp/g==
X-Gm-Message-State: AOJu0Yx5BFFkA556TQKFAzRT9NgIsYHdur894uJlJNhthYYEc2zjEfER
	xF8uPWK4L6glrqqNAOFP52CIkthVbaqBA816QD+pYeHTPis4SmQmNvc=
X-Gm-Gg: AfdE7cl3Kh9XM61MNJ+pbCiE8ul3+Wi+jGvrYyYrW9BdZEEF52FixXT5YxNjxKELqlV
	5lRJv/wtKPTwdQPfzvQf1osnVHu59kO3N579EVxa5uDBFD3+EmzT82X8Rxl6ZJWQvLqA7sB+oeh
	Y9ZxLrTWLGsGSePMCIowVJgry+KbNJF/wxlboLIPVxPgqQzd9oek3TZZ9kN5b1wq6z2b2CleoKK
	BjdfCTYHaDWZL6AQDb90b46Me7FYowr5UZbxcykknBevat7KvURD3w7r7rfmpIl6+eX1gxs4UsF
	W8hgyKKHLO7rHDGbBw6AIhgbZQTzruE7Lw9P0ECAHX5PQ99ARsiW6fuLpzkMr1p9YXL1D3JcUG+
	ZgTboPiZi442s0vpAKFc8rtUYuMVgDTqNFJMbqTWre1rcMZS/2orJRMdE5Exo4dA2lfzV2iaaUE
	lBryUCyAXenACCZXDs1ecEOr+5lA/kKTbZoAVHPT8G/jLwFTVu/qNAUmZ3bLvp/Hb91zuC8w==
X-Received: by 2002:a5d:45ce:0:b0:476:c622:d41f with SMTP id ffacd0b85a97d-47de66dd5e9mr1597139f8f.47.1783376022918;
        Mon, 06 Jul 2026 15:13:42 -0700 (PDT)
Received: from ?IPV6:2001:b07:2ec:601d:4b26:1672:75c7:805a? ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039afacsm26722332f8f.19.2026.07.06.15.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 15:13:42 -0700 (PDT)
Message-ID: <ad91c7ec-83db-402b-bec3-3821dbc607f8@gmail.com>
Date: Tue, 7 Jul 2026 00:13:40 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/13] drm/msm: initialize LPAC ring
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-10-01d50c3e0c99@gmail.com>
 <93b78299-866f-4a3c-9423-a990d9a7d4cd@oss.qualcomm.com>
 <64a919ab-8b36-45fe-8da8-5eaaf4d55359@gmail.com>
 <2a556ca0-d276-4c56-a44e-9d8b92a3af6b@oss.qualcomm.com>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <2a556ca0-d276-4c56-a44e-9d8b92a3af6b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/6/26 11:56 PM, Akhil P Oommen wrote:
> On 7/6/2026 4:37 PM, Anna Maniscalco wrote:
>> On 7/6/26 10:44 AM, Konrad Dybcio wrote:
>>> On 7/5/26 9:13 PM, Anna Maniscalco wrote:
>>>> Program all the register needed to start up LPAC and send initialization
>>>> sequence.
>>>>
>>>> Additionally, now that the LPAC ring is live, make the code aware of it.
>>>>
>>>> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
>>>> ---
>>> I believe some/all of these writes need to be guarded by if (has_lpac),
>>> as many GPUs lack these registers and there may be side effects on
>>> others
>> That's correct yeah. I'm not sure what has_lpac should be though.
>>
>> Something we add to catalog? Or checking if it is a gen that has LPAC?
> We can introduce a new QUIRK (ADRENO_QUIRK_LPAC?).
>
>>>
>>> [...]
>>>
>>>>            a6xx_gpu->shadow = msm_gem_kernel_new(gpu->dev,
>>>> -                              sizeof(u32) * gpu->nr_rings,
>>>> +                              sizeof(u32) * (gpu->nr_rings + !!gpu-
>>>>> lpac_rb),
>>> Should we rename nr_rings to something like nr_XXX_rings
>>> where XXX is some uarch-generic (i.e. not SQE because we also
>>> support pre-a6xx) name for the main number cruncher?
>> Qualcom calls it GC so nr_gc_rings perhaps?
> How about nr_gfx_rings as those rings can handle graphics workload?
That could be more intuitive yeah
>
> -Akhil.
>
>>> Konrad
>>
>> Best regards,


Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

