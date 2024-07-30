Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CA212F5B3
	for <iommu@lists.linux.dev>; Tue, 30 Jul 2024 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722326911; cv=none; b=DvFI840XCzeuKqdytXb8YoS301876ggYuhbPHwoamlUrYODPFHmAHzQTMHWGvmYdGTsUXrYMWN6YMDbJLEj7poVbjPhts37v6vAooXOu9ihnu/qtgLnAHc+kYV81VLZFw4BrybzKnvbgKXCQ6T9DxmhgacG9OD6BUJIkoAOFR9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722326911; c=relaxed/simple;
	bh=jJbBEws4+9wxc7s41ddcTpMuiU+dFrCzFuJxlG6M4Hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSV4RKo7G+WIp5cmrTLKBv9DM9A2KU2FYXhVVDfW8hrxTtodx2PHljTmgDghoQemDAVZQfuZwgBBq3BEA9icJAHruz/R6yV7rUM6C4c82HYjeOXrD2dYDPmuRO4E2BkZgJ7LfGJ4f9rKbxPM2Ab4pBV0I7BSTzq9UfkbMjzF5wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bH7MRHpH; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bH7MRHpH"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7ab76558a9so823855866b.1
        for <iommu@lists.linux.dev>; Tue, 30 Jul 2024 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722326908; x=1722931708; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QZF+Pz2AhcQY27YBc6J2Fo4eWNRZZfKHCgf0Gc2Vi6o=;
        b=bH7MRHpHDqI1AsnJ9x0PoL3JbCFdThXrceuYc0V6btHc/pYyZtGMrXa83ruHjMfWS2
         u3EOODDz2DqVogic5tQyJPTsZDzbj6H/xJV1K11pw3RgKyQWA344y2RfB3MWH1DvqflA
         5OJE1romKQxEW9TtOsGdUdt56p2Q+/Ku9gcb7d4A9gITZP/VNeUUk97AwL9gt5o3s/AY
         oYsF214yNb6ClQc583E+x7WQrGEa+Y0oZ/4CAvr+5u1HiWpAfi8jEmU4YKQk+5gVP4Mr
         uHCCm0wpGSrNXV8cGZEIzRCVyyFhdQzvGLacOUwn4p/geVmffE5WZ0d9jkHU1KG0u/xi
         Ru6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722326908; x=1722931708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZF+Pz2AhcQY27YBc6J2Fo4eWNRZZfKHCgf0Gc2Vi6o=;
        b=aa9hOA2dNGQAA2p5lg7w2PYLaK+JEmtigz/692Z0SSBJZSS4IJO22olJthmLB3stuB
         UGZaIzo8cbm/LNUC+GQZmDrV/eWswss6jqp5/9zRnidtHNrF/U9f5QbvyUTuWZVlH19T
         jdaGSSg1LYkQ6kqt2+Sg7iXFiR+8IVlDNLqgMGgG80xgScBlESYLKdgB/RfAQOO4hnHx
         vkUvf1YMUAE1lLHd7e7/q8DEcUw4L5p2Zu2UT0tEaq4nAXiQaXwNk3tWVbEAvBL5HpCv
         mqZhPRd0avjpFiMYgxAi83xlHUlo2qVhQehIeC+rrm0wyhO7wXZ6jnLB4Ng+jul/UVX1
         yrCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZcVga8zBB/lGPiDloguy6nUY0SsLJ9I26WEZPfVQaWYq+M6T3/m9/u3BNVVyk2MOZwsNXykkHICAM6+Y09UxleV5aO+w=
X-Gm-Message-State: AOJu0Yw49yXTd0IS3rqd7GPtk30xUP541b52HVMsmCUWaLRukiZIf50r
	+y87IyCDVrdpkoXT0hhxgdW7f9LrhYoAmAeYSUKxOEtgpLPZhUz+OeftNTE8
X-Google-Smtp-Source: AGHT+IHmcD8TT/OjORJf5+HJTjExUKx41HXrJqoDLKcAwWWZieiprfgJ7DuRrTHke21Hmw0S4rjPuA==
X-Received: by 2002:a17:906:bc20:b0:a73:9037:fdf5 with SMTP id a640c23a62f3a-a7d858b3d5fmr129857466b.6.1722326907671;
        Tue, 30 Jul 2024 01:08:27 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad90130sm620226666b.144.2024.07.30.01.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 01:08:26 -0700 (PDT)
Message-ID: <3332c732-4555-46bf-af75-aa36ce2d58df@gmail.com>
Date: Tue, 30 Jul 2024 10:08:24 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Work around SDM845 Adreno SMMU w/
 16K pages
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Rob Clark <robdclark@gmail.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Marijn Suijten <marijn.suijten@somainline.org>, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Sumit Semwal <sumit.semwal@linaro.org>
References: <20240729-topic-845_gpu_smmu-v1-1-8e372abbde41@kernel.org>
 <osxynb352ubxgcb5tv3u7mskkon23nmm3gxkfiiiqss5zp67jf@fv5d6bob2rgp>
 <CAF6AEGuWULwrJDWW37nQhByTpc-2bBYVv3b_Ac6OCwaJ83Ed9w@mail.gmail.com>
 <CAA8EJpp9zaQSKbis7J9kYTudTt=RFhfbzeayz3b-VbGQENtqeA@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@gmail.com>
In-Reply-To: <CAA8EJpp9zaQSKbis7J9kYTudTt=RFhfbzeayz3b-VbGQENtqeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29.07.2024 11:21 PM, Dmitry Baryshkov wrote:
> On Tue, 30 Jul 2024 at 00:08, Rob Clark <robdclark@gmail.com> wrote:
>>
>> On Mon, Jul 29, 2024 at 1:14 PM Dmitry Baryshkov
>> <dmitry.baryshkov@linaro.org> wrote:
>>>
>>> On Mon, Jul 29, 2024 at 10:37:48AM GMT, Konrad Dybcio wrote:
>>>> From: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>
>>>> SDM845's Adreno SMMU is unique in that it actually advertizes support
>>>> for 16K (and 32M) pages, which doesn't hold for newer SoCs.
>>>>
>>>> This however, seems either broken in the hardware implementation, the
>>>> hypervisor middleware that abstracts the SMMU, or there's a bug in the
>>>> Linux kernel somewhere down the line that nobody managed to track down.
>>>>
>>>> Booting SDM845 with 16K page sizes and drm/msm results in:
>>>>
>>>> *** gpu fault: ttbr0=0000000000000000 iova=000100000000c000 dir=READ
>>>> type=TRANSLATION source=CP (0,0,0,0)
>>>>
>>>> right after loading the firmware. The GPU then starts spitting out
>>>> illegal intstruction errors, as it's quite obvious that it got a
>>>> bogus pointer.
>>>>
>>>> Hide 16K support on SDM845's Adreno SMMU to work around this.
>>>>
>>>> Reported-by: Sumit Semwal <sumit.semwal@linaro.org>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>> There's a mismatch in sender/committer addresses but that's "fine":
>>>> https://lore.kernel.org/linux-usb/2024072734-scenic-unwilling-71ea@gregkh/
>>>> ---
>>>>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 10 ++++++++++
>>>>  1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> index 36c6b36ad4ff..d25825c05817 100644
>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> @@ -338,6 +338,15 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
>>>>       return 0;
>>>>  }
>>>>
>>>> +static int qcom_adreno_smmuv2_cfg_probe(struct arm_smmu_device *smmu)
>>>> +{
>>>> +     /* SDM845 Adreno SMMU advertizes 16K pages support, but something is broken */
>>>> +     if (of_device_is_compatible(smmu->dev->of_node, "qcom,sdm845-smmu-v2"))
>>>> +             smmu->features &= ~ARM_SMMU_FEAT_FMT_AARCH64_16K;
>>>
>>> Shouldn't we hide that uncoditionally as it's likely that none of v2
>>> Adreno SMMUs support 16k pages?
>>
>> Hmm, that would be unfortunate to have the GPU not supporting the CPU
>> page size.  I guess we could still map 16k pages as multiple 4k pages,
>> but that is a bit sad..
> 
> For now this might be limited to older platforms (v2 vs -500)

In the commit message:

>>>> SDM845's Adreno SMMU is unique in that it actually advertizes support
>>>> for 16K (and 32M) pages, which doesn't hold for newer SoCs.

Konrad
