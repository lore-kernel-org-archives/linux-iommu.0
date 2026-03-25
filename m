Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F243C3453
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451770; cv=none; b=szkIfy1IcdGTqZcfDSTqM8h045AxNVKGHEJmTARt3CSKRWSiKqMod4DX6F1uKQMg0PzmpIE4A0gPjtlZcGTbn0hXgZ6Pysm5otzi3XfU90Z8KApteOt/4bJWJOFqcQK8/dvLkRK+z+Ztd95kH2zB0gU4RGEKQBN1uIsxcf9jQzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451770; c=relaxed/simple;
	bh=/vywv4hZ4+kE2TvgFYQ3L9kVw42zFJldnDoEQi5wZGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bVC0Y67DuuTFU+v1TrcvEXqRycjUcsIx2rKpoyN2OJWLWMR+M7wzyFqYCaWRMr0pg5IkDkiJkAAtSduSusrOdPx5P1bEMxFwruluMMf44BY3z/Pa9pIw8WM3+rBBlWBVHQq7MK9mjDdCPaIwrFwwPhgJUD5vpAjqLUmydiDukrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lt+SXlxA; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lt+SXlxA"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66970715adbso7630992a12.3
        for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 08:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774451767; x=1775056567; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jeZDmS4QXWBXj1GSyJBXJGYP+hGJySEXWFfrbydgUbc=;
        b=Lt+SXlxAHj6XCOfpPekHiErOtYSMGHb1ViCJ9fIfQfpcr5DIPFQhhwAkAldZcYIJRg
         bc2jzcr5VwlU/E1F2SCwX+UQxkc+45zTJe1ibO/5BAHgJVtn2Qwqeo/x0fDBHnOy/nLI
         d0HAgecoDySzTb8dmfcKjbhAJGw8DS5Yk3BmfBUY9DlLPu6nCELyzxv1elPJsMmMZzWa
         /c0+M8buE7A3mLuNCKoc8qty+G+oXj/w++qUhB1J6gEz/AGHqwVB0bUIZ7ku7yA4Y1Nn
         /qSPc8w5zcwvuWjwRSrCCjXtkyv9JJ/iV2MZzQyrt/q7Bx2NmNcd4XWdLuABOFysi1j1
         n1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774451767; x=1775056567;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jeZDmS4QXWBXj1GSyJBXJGYP+hGJySEXWFfrbydgUbc=;
        b=Ng6HY68Cya+QU6CJMxQh1L/ZmKPbE7rkpr0O/yhiFrSccKDNf8rEBy1QwTO11Hw/Tv
         bdlSSANRo9c2sNFvbTd/JKlhPVbhoy763gic9edU5nMYfGMa2Kd9qFrCyj9Foy+CFI1i
         9gJNNbWMGDkfH47qKCLorgjX9BRKZd2EFi/aZAvP/t12+FyjYfmXE3nLMU39coSwknVB
         41WKFB4/RNb3S7p1gYFdLY5fMWxzqqTVhLUU/12Uz1VILnT5Di7BF8ame8OIySSWjkzd
         pCSqwX2pyAAFPqOH+ki3V4j+oc4GLb5+sJlHc1iRuu0DoZ6P3KtuNoQbZj5spyAf0yqo
         xmwg==
X-Forwarded-Encrypted: i=1; AJvYcCU285tnwqt6Jqpm4S8/K54uZZuePZETUT0wHegfFGYXz46XFXZ/XvqA4NsNFP/+k8e+8K/sMw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yye3fXpggJbyEq5ywlkCwjL3jWcqIPkB1umec7P0Nm6KQ8qqs4k
	JdBV1kHy0OBT4OVUGCLE6hBSL0zNOd4alqVO+6I5pxpHKPeGghJw7K11LDmBNy/Rklw=
X-Gm-Gg: ATEYQzzyPb/T9QNeWKmOhY7p0dzinFYJQJF3+QxtGhNbiPIJWrbal9N89/67qg/ghpV
	s2QbQKp8+aK4/p4zH4ESLqA14UrhTvr5hWtf1zylRkqyfZTH11S7qDqbJQdHSCxa/yKXb+n0rCK
	vHHh9pzl8ObJU02JgLsq3asPkAqis1mZ7PqSfn2ncPw5lN55fZIPFbTSYb76Q1VviX/j2YecR6C
	ypDLpxlSZu1yOv9klDV0a9ZG45EHwT+OQrrr/Ics8UZ7Rw9x0lb0gAXpACpDzCdd05n244VBMYS
	TWQkcHa4rBw7VjVd2FhVAc4vQFFpVgyZ+F6IjWht6vfusP089OCja94v0uFk3pWbfq60vdIWvNp
	UgJK1D2Wb0z8WbPMvvwmr4CheujaJEgVDDO9/9dIyJ4G3Zn/ssvYsAwPtAFID4fNDfn0kY+yKq2
	423s/9WKpa/r0k92cAnICZf05ARLm9V+/HqeOo
X-Received: by 2002:a17:907:619b:b0:b98:1129:51 with SMTP id a640c23a62f3a-b9a3f1abe69mr195370666b.17.1774451767271;
        Wed, 25 Mar 2026 08:16:07 -0700 (PDT)
Received: from [192.168.0.167] ([109.76.163.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9832f440e7sm800025966b.3.2026.03.25.08.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 08:16:06 -0700 (PDT)
Message-ID: <2c5b8402-6036-43b9-bda3-aeee0c6a9d7d@linaro.org>
Date: Wed, 25 Mar 2026 15:16:03 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] media: iris: switch to hardware mode after
 firmware boot
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Conor Dooley <conor+dt@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20260313-kaanapali-iris-v3-0-9c0d1a67af4b@oss.qualcomm.com>
 <20260313-kaanapali-iris-v3-2-9c0d1a67af4b@oss.qualcomm.com>
 <7dbf7a23-7a02-4e9e-99c8-6716e3dcf7d9@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <7dbf7a23-7a02-4e9e-99c8-6716e3dcf7d9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/03/2026 15:14, Vikash Garodia wrote:
> 
> On 3/13/2026 6:49 PM, Vikash Garodia wrote:
>> Currently the driver switches the vcodec GDSC to hardware (HW) mode
>> before firmware load and boot sequence. GDSC can be powered off, keeping
>> in hw mode, thereby the vcodec registers programmed in TrustZone (TZ)
>> carry default (reset) values.
>> Move the transition to HW mode after firmware load and boot sequence.
>>
>> The bug was exposed with driver configuring different stream ids to
>> different devices via iommu-map. With registers carrying reset values,
>> VPU would not generate desired stream-id, thereby leading to SMMU fault.
>>
>> For vpu4, when GDSC is switched to HW mode, there is a need to perform
>> the reset operation. Without reset, there are occassional issues of
>> register corruption observed. Hence the vpu GDSC switch also involves
>> the reset.
>>
>> Fixes: dde659d37036 ("media: iris: Introduce vpu ops for vpu4 with 
>> necessary hooks")
>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
> 
> Hi Bryan,
> 
> Please pull this fix patch, let me know if you need me to resend this 
> separately.
> 
> Regards,
> Vikash

np

---
bod
