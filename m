Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D39336F903
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436569; cv=none; b=Je/XYNn4CHM1g4hXOrATBURoVH07CNB2RDrvdUBO1MlCCy3b/DvpN5CgA4NnNguqXafIikLe4bvfORt/CZWzp3OkbzYdtiGu+DN5L9zG7owZOybTGFJ0TqMv/1qOCkjNQh34zWVF0XA67XsnGL1nZirNYPtMaIwZluPDEPAdKKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436569; c=relaxed/simple;
	bh=27lbe9R0uJfA1lOEGeN84RLKHIKzjAm6O94agj9GLmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=biB5Uv2X6u0jeGS/sgliKm5zCdRj/39SgOLZsBqJwTomj6VaS0BNrajBkUuBWSoJv7LjoxVFjPHWgogwX8FltK4kJoQx/Xxj43A6WzoIOgKVSd+EPFsQrrCaUd+vfpf6SD7w6zPvqcQdWZsuV0YIBG2n3LqJ4d2R2xbfbZEXX7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1czpzEh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1czpzEh"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so40681895e9.1
        for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 08:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783436566; x=1784041366; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d8YHwGJCeEFKefM96NEtoTmLf7gsLMxJ2f5daJOJFZk=;
        b=f1czpzEholPMOiLD9OweEDfFlAyXGBD/Jto3S/66PQ+RgLsBNVQFSDKX2jvBzehgtJ
         8PkCho5JAquwBA/oDpJ7Y+XNhvLlh4XUZUoRosvAB+qm+BlXoMiuvj/T/o8vN+StBEUx
         LLgPmCVDdYmwkE8z+xmVHmm8Eea5pgC5hgieSxYp/xRUVO5IjP6TNhAvIFb2yYwWSvoH
         5r+pyYiIXDBTt/aGtxQyae1Fp+5jmqc/AW19qrgYyadDVKv6onGxM1BZAy1EL46JZh5Q
         HzL8gwgwxVkyZFxNkWgpy+eP0hUW8C2B53UeVkzyaGFqUOH/ytGNXGvFqa6tQVjwW++H
         11Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783436566; x=1784041366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8YHwGJCeEFKefM96NEtoTmLf7gsLMxJ2f5daJOJFZk=;
        b=DzXxs/36lL2YdoyNlkeam6/SHuBDTKAARRC9EbJ3Z6qjmyyyDl/kh7rmmclJ/kXcUN
         2u134+uhtZd5dr5sVEAHlP2kjrBRvGWQhYLpfa+baunA/MNk1WMCSIenFGB6zKOhWjDE
         /0Bwu1KFNHOETLtUpRqiZvpAtiWBU4fdJW+TcvZFwLQTY6Xi2FdmFP5rmuvWKu+RT5W4
         EGxQjJiqV2R1WRUMnBOp1nfjqCsQcQVNQ9/z1M18FKL3msZZWfk9tZ13pcZ1nDCvwdwx
         sL+EnYH+dfHKO3xi8bNsdDF+LsL0Nl1ArBlLlrWRQxuTDaDlZxrRwiiPraLKq0Zq8ZGz
         mYgQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr4qOSQ/xrqqeO8dViQqlhPvbGHAUX6Pbl/+AQlhuF07QXvE8e1LCCK7MD4sH8etGbiezhyOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxlyoYRigY7lcyrGAFJKEacEAOrR7M8u9LPrtrxrtIY/9kAZHd4
	TRkf1O1mF6tst4LVTM402gBT7UEaaMy1G9cLZi0s9PAN4Ch5bKGaFdQ=
X-Gm-Gg: AfdE7cluQKwVOfnH8NVr48twVUfpqACCo64cBPI9mGywFErj8mUJmDtVJVMyetWyvSP
	yE0KesoPGK8TCabHVIqP7gpC6qLOen2OeF7p9L47pVB6RiOz4xLTRaZRegHptvS1TtIIcc+BUmF
	SvFLiKC/eh3oDt/UMgPzi1KcJ6gepuqK+bZttmVD3kyFmzV7UJbGF0qIV7pLDHo6Liase1cSorV
	e6JFm85nvSux9r+zi2NAtkibyvXlPhgn995sJOUTl9Yip1SU87o/ID4pA2o2M371dE4ILwfqdK7
	Wx+KSFqP7vut/YcAGi6+JdkvizyLq9MTHSHSZg82BQFodPMCTcYUwOVhl6ZAMy6yZe3UpdwzXya
	iqDX5XUilhqe6b4zveNCLVk9BifhSlB5oYDgcWeV7E0d0ODWYB0+2uMuwTIxcCYXsRqpOJ8a8Tk
	LbC70/KKXG2RsPQJgPYnNeQ1q1ouXa0DZNv9PJNdqe+pHSCl7VT1HKFIPj5YL8Oab7c8iuIw==
X-Received: by 2002:a05:600c:4747:b0:493:be3e:cc3 with SMTP id 5b1f17b1804b1-493df093146mr65333955e9.21.1783436566150;
        Tue, 07 Jul 2026 08:02:46 -0700 (PDT)
Received: from ?IPV6:2001:b07:2ec:601d:4b26:1672:75c7:805a? ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e10af392sm62069495e9.2.2026.07.07.08.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 08:02:45 -0700 (PDT)
Message-ID: <dc5aef2e-600e-4e97-b76b-dcc8bd72c709@gmail.com>
Date: Tue, 7 Jul 2026 17:02:43 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/13] drm/msm: look for lpac from dts
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
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
 Thomas Zimmermann <tzimmermann@suse.de>, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
 <rwohvfbsw2brpxrfg26egu5arwe6g7n2etelo33eegmu5cz65k@3syofuxzsjrc>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <rwohvfbsw2brpxrfg26egu5arwe6g7n2etelo33eegmu5cz65k@3syofuxzsjrc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/6/26 5:04 PM, Dmitry Baryshkov wrote:
> On Sun, Jul 05, 2026 at 09:13:37PM +0200, Anna Maniscalco wrote:
>> In order to associate the SID used by LPAC to it's own domain and
>> context bank we need a separate node on the DTS.
> Can we use iommu-map instead of adding a new device using the same
> addresses? You provide zero explanations, but it seems like you are
> trying to separate a part of the GPU into a separate device, but it's
> unnecessary.

What I was trying to say is that we need to map sid0 and sid1 to 
different context banks.

 From what I recall, so long as we use the same dt node, the iommu 
drivert provides no way of doing this.

What kgsl does is having a node for the iommu and then subnodes for gfx 
lpac and secure.

The address on the lpac device doesn't really matter. I have very limted 
knowledge of DTSs but I think we could just leave it out altogether?

>
>> Add the code to look up that node on initialization.
>>
>> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
>> ---
>>   drivers/gpu/drm/msm/adreno/adreno_gpu.c | 21 ++++++++++++++++++++-
>>   drivers/gpu/drm/msm/msm_gpu.h           |  1 +
>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>

Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

