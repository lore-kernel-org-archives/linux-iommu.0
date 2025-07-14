Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E904B22257B
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752473593; cv=none; b=igOoekv+udMa6d19CmjRHHtyZr+15i0ZVbdSfN3hafj/fbYPUOR1PgkGMNmB7X1wUqaNU7MozAnULse8bKxi4rCkj9BgQl+7tEB+a6RqiS+ya1KswrRtB2hD5omuTaDCeptELbI3TP6KqMIndoZXoPGuI+yIKsHyyyaAUhK0neE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752473593; c=relaxed/simple;
	bh=K6rTZa+mjUsFCcLD5fAui8r+wQYrBXhnTQ2dLU8CeRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/VDA0grBrMvshtcQ1hdjGI9Gd/6mVK5X/WdZjK9v5oFRhm/9D4Q4+6EsUjrlRSFWNSIIm54UWIpAa+0onJzeiXqZAXNeoaGT1nlZQKqwH6zkdscxH75WBDbmZdFY1aptYbO1oeVLHpCO2eRS8b0zwnIAlnea9endxOiKjMIvHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZpOnQkO; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZpOnQkO"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60cc11b34f6so8787258a12.0
        for <iommu@lists.linux.dev>; Sun, 13 Jul 2025 23:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752473590; x=1753078390; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vvozbmvdghn0xuJhVjwu4pQc8eFowQW5vD9wXdzvh2E=;
        b=iZpOnQkOLkjfRAPmVin2jgLr4boULdSyLgtiucH/de6wyC+DsyLfjSGCmb4SJz2k/B
         zvrC99pwn2Mk/FhvmQKHiieinArFEal0Ass5nC5Mjjb+At0e9REi84nt2XM/GOmJKlPI
         Z430knrp+aqp65KsNm28P56ag6wHEZZPYlw75pLS6+ccTtG3WfF7/9eAgZn+1TKDeiqu
         yHnXVq0WDxWqnZK0QNXIyTyfy6REslna89ha8rzkZGZtUv5d5IJs8qlbfu7nhBsovNkQ
         LfkTx9w2OkSz0acNtd4KWVe8eQVM15oL9rrbzIz429zbQpL5cJrIdqffERxhvJH7bIBF
         NwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752473590; x=1753078390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vvozbmvdghn0xuJhVjwu4pQc8eFowQW5vD9wXdzvh2E=;
        b=wP0QYkoJnlhBaBNonjCjfuHc4rV9xuK3Euv1D/hVoYOrcb/4B2CAVca7Ti6VknrvYY
         NUY50hSIFLmMV2ZM6Oh5RJozB55GSoPx5aJ4orOPW3WoRsX6ITTh8bqohOTm3nZ6Wg23
         N85aWClexFIF24aMTwbiBKpaG1Wl2pT4qrdRuG6vOFq3y7bq6vWRke5P9r5vb6TwZTFf
         Ek2sB4t8CRkAaLOakOi2lzCT4rHDLYkLiAzCW9XjJS3AAXV9MwOqJPfrm98O2w8kmgQc
         sUXBBZ8cratP8Zyf1gP7s/y/e0+lQGPj50KcHqqiiOC/b0GPmTRL5fP94g5QEwGngWdT
         /EIg==
X-Forwarded-Encrypted: i=1; AJvYcCVROlVTnI4Wniz3WUUruGha9wpXIWgxPNM5glY3/ACq5+PckZi8ljkHCb5QJY0C8OC9T1HOmg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDqCNdbI/2gWAh+C+XUv3ixRFz4SV+SoQ2Jlydl4MpLhPKBRpH
	0qbsIB5le7OJTZ+rvVXoA864RVlw/yGM8I9ZD6KKH/AlV5Jda+1ndlvE
X-Gm-Gg: ASbGncvHNGkAHkYB9oxjJ+25P2dU/ypg1/KIRk7hZ+mzxX5etUlV1EdHhSWY1640ePm
	U1rTSLnaPtrwRVdb+wX7a+fcGMimhYXF3scK8pASbKpB5NlG5mJWywx3839tFXIGhAPsLK+OHww
	ilZBi8YZVVQ1ZeAzEmjY6t9b8W7fvkJ4OO6LOTOUras6WHUAC2kzWL38oEwL0yoDbjjrik/6HTi
	Bm+ZthEiGR2t70Q07WXOqit4ps5/lQN+0goVV/1lsy6f33kaAs8zbn+oZYoAHPt1grYfWJsIR8w
	/yujU+urmzPm9nUBOTM/oJEZzG69mccZtgbdfUiPBwTdDGfs3mMHRjMFhq3HS320/5mHpqa3V7k
	1+Um0ymualGng7Zz6WvnsOj+aW34dNPuPBVKmi0k56mqTfiVle/d242U4C46abLers/sRlVOvzK
	K5ehx4xAo+6BoJwy/4cav2NA==
X-Google-Smtp-Source: AGHT+IHhpjs0q3mi1BpnwNvryChqNwp5/Dw+yK56vrj/BWwwZ/DXYC0z9I3eOOpItRqe5sk1H/USWg==
X-Received: by 2002:a17:906:9f86:b0:ae3:a4a6:a32e with SMTP id a640c23a62f3a-ae6e253ddf4mr1701256366b.29.1752473589912;
        Sun, 13 Jul 2025 23:13:09 -0700 (PDT)
Received: from [192.168.0.124] (ip-37-248-155-42.multi.internet.cyfrowypolsat.pl. [37.248.155.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294bc2sm766171566b.135.2025.07.13.23.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 23:13:09 -0700 (PDT)
Message-ID: <ee0d148e-71cd-4136-b3cb-145566abdfbe@gmail.com>
Date: Mon, 14 Jul 2025 08:13:05 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] Various dt-bindings for SM7635 and The Fairphone
 (Gen. 6) addition
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>,
 Das Srinagesh <quic_gurus@quicinc.com>, Thomas Gleixner
 <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
 <aGMI1Zv6D+K+vWZL@hu-bjorande-lv.qualcomm.com>
Content-Language: en-US
From: Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <aGMI1Zv6D+K+vWZL@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/30/25 23:59, Bjorn Andersson wrote:
> On Wed, Jun 25, 2025 at 11:22:55AM +0200, Luca Weiss wrote:
>> Document various bits of the SM7635 SoC in the dt-bindings, which don't
>> really need any other changes.
>>
>> Then we can add the dtsi for the SM7635 SoC and finally add a dts for
>> the newly announced The Fairphone (Gen. 6) smartphone.
>>
>> Dependencies:
>> * The dt-bindings should not have any dependencies on any other patches.
>> * The qcom dts bits depend on most other SM7635 patchsets I have sent in
>>    conjuction with this one. The exact ones are specified in the b4 deps.
>>
> 
> Very nice to see the various patches for this platform on LKML!
> 
> 
> Can you please use the name "milos" in compatibles and filenames instead
> of sm7635.
Hi, small half-related question - does this mean that future Qualcomm
SoC additions should use the codename for compatibles instead of the
model number as well?

I was working on SM7435 (parrot) patches a while back; when I get around
to submitting those, will I have to use "parrot" or "sm7435" in the
compatibles?

Best regards
Artur
