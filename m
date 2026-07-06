Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC423A6F1A
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336063; cv=none; b=MKzV9mMmu6W6HujTH3cTFCnpH/8v8qzcUiqt+Zi2T+pQYbkWs4iwufBUU4ComBNMKhbvnPCRlaG8Nl6rzBLcKfKAirX+bCpMaA/eY7WHMUPZNefTipcb7sFwLCza98OtjnudpfPuF8R38tQnVzO1y5hh3klvqisEIahdIv4rMYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336063; c=relaxed/simple;
	bh=Pb7Xc1kKgr/AtADErH7EMWnxZPWuIpL20gPg2uLqnAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=euMjzkxl0jSgRziEFlzOhCgMImyjEMWPL2jErmWoXugkbodFxgxgsV69kogV2YLcM/Fu68me4+TQo0NJaOmFIzvxym9kPSw0AC+LCb/RFcDfZt3AU0hP8gZAvhRZbDm6n169yv20Y1rrbaRq0Z0wGDSmNd0tnSnJebZRO01BVyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzoOHCbx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzoOHCbx"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493c733f15aso29511805e9.0
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 04:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783336060; x=1783940860; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hwdEJkuxK+8pOC6TCcezbBHIneZ4lflSArjit6m0NnA=;
        b=DzoOHCbxIzoxUfSiFjIzs86wxCLruOR6Xj2Sz8HbXKcCUQBPW7gXo/aSN8+GFEgJzQ
         9zLTkpnrwj7ChJF5edPGz/RXD7FzhDznozB+AM2OCO6gEaqx82Z9gLl+f/SlnE1RvG0R
         eQrcfdn13VMezcyTTkHbDtmZGuwci/vmB7P0apKvCjEMFZhljBkcGQ1yNprmDBdM2x9f
         gjP67EVN1z6sMPdctLtF0vtPqYdo/TS2/hPjWgVgO8ch3gfPlu1AatKhf3AySTXr1Mo2
         F3oy+tAkmTNxpqHUqLEQAkxXpPUPWKuva46Pf6Z38PZNYdWTGe0xr/fWf98pQtZ2FUuh
         9wjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783336060; x=1783940860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hwdEJkuxK+8pOC6TCcezbBHIneZ4lflSArjit6m0NnA=;
        b=GP6gM++wvh8JXnHxiFjrVoFHsOfbaDgOeaz5Oz1xzsnAJj4orNJZg10vbFM1QWyiMF
         x6pU1l+uDBQnv61sjzZeLRUlJvrgBZjy93laLIUBWeofcjYTQExFK7oXdegNxOeuFIMr
         HghVEwR9t4uj6HvBybGr/aLbVrK0Ux2YhwwItiWNJGVuEiEmpP7nQF12lzu63I8PZ/74
         3VirRwZqvhl41Ps6sICCnja4HGCn/BUby+hW7umaG5ewe3IbqNPH/0LxjCM91asMNDtE
         zXLEduMIDXFfeJvymNVxiM8WGs5IEWIw90ZOjBfuhRnS+Xn3TRM0lwDAoHH09ayF98bG
         r+vw==
X-Gm-Message-State: AOJu0Yx1ilj8pczxMrhWupBXmbeG7doD17hIPrg8e3i1LGIua/SRdnsP
	zAc+EfbQdmFZso5LuoTrcuuy2MiT/aLCAfzkOnhrFfg5M+YM4WcVNvA=
X-Gm-Gg: AfdE7cmcCwSji4dhRc2t92bHwX6mh7Vf4T0w8szeo6jwskxIUbMzZ+lI8u2bat600oz
	TmywSB0YYXIkdgvuvSF8khOdk53eUJEX4Up0LyyMisNlI7RUSOmtWP98QKCGgzg5l1j7/UyyM4F
	cLNwYQ6qn/mRamzGf8uZ8d9fglBFUH8G0nHZfOTCHZhzFWaXikj7d3lM8iuahGvlOBIi2Gi74qH
	/FqmnGg1a/KgAkgSi3ol2XgZnLFqUXwZoCcuY/A5P1NmPFUjr3Q1MnrNAuvmmworMcKCmGxu+xb
	/AfcCJWJG17PWdX5+83EVHkteJRwe71WcdrVCKZRoSYYwmdvPgc+k1RycmrGtFNT6tEJBs3RkSx
	p6Liw2i97dR5ZQLp5XTH4bpz6msRkQ+vhscwp1cr53YfIOyV/Y8f1ZftIrcdNiw6L7xiwhYcJ9R
	Iwe2q8Btt/frFNQgM8Q5AS8jNtae36IW1+aw0/88vg6HglmRU3RIlIe8+4fA0u7buEQ6UadQ==
X-Received: by 2002:a05:600c:c16f:b0:492:523f:a3df with SMTP id 5b1f17b1804b1-493d52ac417mr90419125e9.5.1783336060307;
        Mon, 06 Jul 2026 04:07:40 -0700 (PDT)
Received: from ?IPV6:2001:b07:2ec:601d:4b26:1672:75c7:805a? ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce12c40sm463102745e9.13.2026.07.06.04.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 04:07:39 -0700 (PDT)
Message-ID: <64a919ab-8b36-45fe-8da8-5eaaf4d55359@gmail.com>
Date: Mon, 6 Jul 2026 13:07:37 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/13] drm/msm: initialize LPAC ring
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
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
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <93b78299-866f-4a3c-9423-a990d9a7d4cd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/6/26 10:44 AM, Konrad Dybcio wrote:
> On 7/5/26 9:13 PM, Anna Maniscalco wrote:
>> Program all the register needed to start up LPAC and send initialization
>> sequence.
>>
>> Additionally, now that the LPAC ring is live, make the code aware of it.
>>
>> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
>> ---
> I believe some/all of these writes need to be guarded by if (has_lpac),
> as many GPUs lack these registers and there may be side effects on
> others

That's correct yeah. I'm not sure what has_lpac should be though.

Something we add to catalog? Or checking if it is a gen that has LPAC?

>
>
> [...]
>
>>   		a6xx_gpu->shadow = msm_gem_kernel_new(gpu->dev,
>> -						      sizeof(u32) * gpu->nr_rings,
>> +						      sizeof(u32) * (gpu->nr_rings + !!gpu->lpac_rb),
> Should we rename nr_rings to something like nr_XXX_rings
> where XXX is some uarch-generic (i.e. not SQE because we also
> support pre-a6xx) name for the main number cruncher?
Qualcom calls it GC so nr_gc_rings perhaps?
>
> Konrad


Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

