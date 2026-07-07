Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D6B371899
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436692; cv=none; b=WpNLwv0KwOmabzhAcnVkqYXrutBbAEt78epYy2mFTy9UzL6QSqpn7RQ75w+IemJ7FTJCvfk8oSAarsMoZm8oIT6uN1sXlSy27WkmRpGQIxFW2+4z7/VbmXTFwjETwROe5Jpdga+5iiI32bXT+xgGkA6iAbvEioNbtczlcfVaIcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436692; c=relaxed/simple;
	bh=JW6561mML8m0Es0w6oBxup+aCmHVJh9Hrl4KT/dgDAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7GnrDqGNVZ+K8QLEwvpsaQHsUaHMIFzEpZeoQtFQ8gs6XhYYffR+S5wGpgoLLZn3L+asCwvu7Ip46hE7+m7MlDJGMAZ0k5W45lNCmHrd4oddZBSi5LKJYCRSF53UdGvJlH3GAfPUX4+/sHZr+qBpgfRHU1TaQtTOFho0NhDwUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCYVtc95; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCYVtc95"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47db714766aso429096f8f.0
        for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 08:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783436689; x=1784041489; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yjaKNQDIB8x3lV2bAr2D5lvHBXFHHvfoE6oAh2cW/Bg=;
        b=YCYVtc95UDRNUNmNqlhiXsLvMdBgbuz7VXhJhxXOnD6+ad1PBaQF6DJ8TVfvFEO2Y+
         mu7MZfONd+XihVMamLDIdvaMRvT1A34G3cy0EpFlznLaa0OfE/aUZHX66K0ER2F2h6rB
         lbL2D3o9lSr+hBa1P3oQUVwPLGVSIiPO8wzbCtTTFaqs4JSbUvnH42uCXGhPow2uokGA
         dPY43lriTc1fQ/ptoi8/waJq7nKyBqkHx993DVL1zjPC5YKi+EbJSU0pU1qBEJooQnTE
         u7biVucDW7GlBR99u/MG1gHJi/pjjOv3Sa6y3rHSVrmqNuoCpdMeTwIrqV5cNv+tXYjv
         rwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783436689; x=1784041489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjaKNQDIB8x3lV2bAr2D5lvHBXFHHvfoE6oAh2cW/Bg=;
        b=VOEUSeZkJqx50qk4emhwcECYENT38IEFe7P0GhrGhxTdYR8Zg8W4/Gv11HRm8cRgE6
         iLGs58WHjL4wRcSlrjSbpmQ7eiHJ2VEuH0kk96lGzbn5E5yY6xiKOrfVnQ12+CBoGHgO
         t5s3cwIVNoNzjXgeMcFGzohpblxb/E7gjtOHXEVHsdENHFwnMv/tvDFFtIziPu/13C2K
         EOeMV0RjaJGLGR1yeqI5yrtCdnbLXZkd3W+HFiC3Fgp8aiU7v/W75E9vK2gNU/3LNYU8
         tmN/0XmHKGj4QZzqq8LPq7idOd2jtPciAaaBsGDtLju1yKZpsw/wCekJt07CmUzsINvA
         TYMQ==
X-Forwarded-Encrypted: i=1; AHgh+RoD+O/0ZVl5gdKHDiim08LYAbQldEa9rtJdRjb6iHLGc/AO+rXSNGo6Pr5jWx+2Wki8wk/CnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7BkMZ5xY5rLXHuKLTFuggyd35o+0Vy1cOIgYLRCpvW2jr+UrA
	jLOBEvTJSnaGi/01idSkRGgf2k+dbYOygcqffZZdc7LeXx78iN2nWBI=
X-Gm-Gg: AfdE7cnNI6zpW5T50cOx/qsZTaFnK+Ea/8jNVCYLbiatkwBUl4K3iObc63dB75eh4jl
	wi4QoPtypZ1RRreS78jQSJxutE31ki6VKF9de3M10ceSyEeVk6CbaJHg1wBu7bj/LQQj8eJciOo
	9RizNuk6UhUSNqPmkuYUj5m6I3js0kTSts4nfKXSR9gG0Yu/qJklfxPNqPcpDWFQxpE3qPg5OZn
	sbkKJTLjz+HztF5n5gRKMsYWqAirZ3Ht4w8dWbPdlAOvgqMxK1Yc+VATBk4SBIltMZxyFkpC1cd
	aSPg6ZBWyy3FRDZqrxmL2ZaVzgi0wXR5UbJ6maKQPrDZfLERvwWw7LlxgWDM/LlKZYkEfJAb2Kn
	lGyY+SygYZkgaBzhU0oWsKZqQRsLZuEV4C3DPdsGxjjCVDBibA7D6p7wkUBs8R8fTwngul6jOSA
	FEYc4r5Qklm8k7MHjiVKFOdRs+o+XEyW6Vzx7SY22FrcmECPg3oTv7KHtEQBzlArPezVX7aQ==
X-Received: by 2002:a05:6000:2584:b0:473:6590:c42a with SMTP id ffacd0b85a97d-47de97ea689mr3990217f8f.9.1783436688978;
        Tue, 07 Jul 2026 08:04:48 -0700 (PDT)
Received: from ?IPV6:2001:b07:2ec:601d:4b26:1672:75c7:805a? ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f21328sm35142014f8f.32.2026.07.07.08.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 08:04:48 -0700 (PDT)
Message-ID: <6acf86dc-0df0-492a-b3dc-224a666214b9@gmail.com>
Date: Tue, 7 Jul 2026 17:04:46 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 01/13] iommu: arm-smmu-qcom: Configure lpac device
 with split address space
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
 <20260705-descriptive-name-lpac-upstream-v1-1-01d50c3e0c99@gmail.com>
 <5vfdbrk4bu77e7wgutp4h3ilbpjhcxxnwemqiufmtiwoffp4sl@oaonwwouw4qm>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <5vfdbrk4bu77e7wgutp4h3ilbpjhcxxnwemqiufmtiwoffp4sl@oaonwwouw4qm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/6/26 5:00 PM, Dmitry Baryshkov wrote:
> On Sun, Jul 05, 2026 at 09:13:35PM +0200, Anna Maniscalco wrote:
>> We want the context bank used by LPAC to use split address space just
>> like GFX.
> Why?

I'll update the commit message in the next revision.

The reason is the same as GFX, we want split kernel and user address 
spaces so we can use per context page tables for userspace submissions.

>
>> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>

Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

