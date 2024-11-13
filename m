Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3BD1534E6
	for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511346; cv=none; b=UyLMHjjC7JMJCsAko0t5ZW1w/9T22FaPaK/HZ8LTeiMlCyN5S0b5bQZ4Gz9h4Ri4bjanVDV/CQhDzuywJrtrFa0P4IaqofehLDGxnBE0ZL0WZt9BTDn5fWZKwdKVHaOqmhPUkjwLCgXEwFx1qmuEogI2jUvcKwM0jppoAfGF3ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511346; c=relaxed/simple;
	bh=HhOwop9BJOKj5T+Nes36w0KnTxUb3W599pW6+HWRufM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=se5uPmK+JiarzYqxpk55HG68tvZSX7h7qj4CHSO9pFoEDFGOX7fjCNyRZNBtwCG18J8zYNDN9UWE48C4jbCh5vVPoDpXC/tbTHyXWQmk5V9/aSeHCxze5T+xPqI58FOXzerNDgI419AWAhywdTbFqvsgnIvVPXzBVkqvPUMVqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m8pagaPA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m8pagaPA"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d4fd00574so591089f8f.0
        for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 07:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731511342; x=1732116142; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kyz8CAV7UjnZy1sBo5de6wt5Xr9fxxfh9Ju5xZPyESI=;
        b=m8pagaPARIhLilPqgbQf7jQmY1zEQqMc8IqJHtVGmWuh1z2MX65zl/Rt9CInsTOwRP
         Tcq3G6vSgOlZh2Oy9d3n11vpt2Xvxe774kYdXYA2HDjt7pT6xKkTvHfPDve7C25YvKHw
         eyb8uwOHvH6N0WMG8Am6/9wyxUIkjMZEbr3iWRKlbPts8WN6cZ01D4aOuGUeV33g1zDP
         pLNY10LI5uzH0TKFB6gkavbUmDn1NX2pXf2kzhjJXicvFHMh45wRdgIAh2trBje7HCqg
         jaijQidMQ55SRtYEm2wcJn+sxp9l/4zQ5vAXPb8tzFqp+bfqZXYRyi6GlfeUtjpjQKcU
         NWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731511342; x=1732116142;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kyz8CAV7UjnZy1sBo5de6wt5Xr9fxxfh9Ju5xZPyESI=;
        b=EfU7z7H1YHL3E1QeBZIBQRRN2c0yqsOlbUQ3lYLgJGPeAJbMGc6G0dWOa/RGycFS8s
         0bsoy/c2mz4v4iZpyA5FQ0i2fM5EWxT1yh0fy62h2cD8LqQXQpBxvcpsMBZpMTf4/Jrr
         kiEJpX71HQKd085XRe/MOP+KddoR2AfNSFa8Y+Cx/1rcWSkYuPE+bD9BGQtp4f99PcPC
         MXV7pr6q/dfsmRKAOTLHsjJelVDusS8cBLinYVo+QkTP0BkAVizzSURxba8AhDAPtRqe
         ZvTwhId+YoghCEYylL9FEEJm6EV6Ffqd8H+xV3oKVQlIJg6uCRIPbx2Uq+W6xmjeZrNI
         0zNg==
X-Forwarded-Encrypted: i=1; AJvYcCXMeka7vjF+iELjNyWvSuSDBvPDz9IyNDnQfoY+Y9V72q+nnomBzOGAF9FHdfiLULgWo6L+Gg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDowni38sXKPxBKGUEoKaJU2G6iM69jLn+ba+hPeW5CG9Clr3P
	kc30phxPWEf1IrQogNbyzcONbjQxTLED77A1noJNtzPeGvzklV+Y//2A6sS39i0=
X-Google-Smtp-Source: AGHT+IGkBBKScUdnq+eFrrUWl5WZg/WDJVAp06eoD/G82CPwKOfPCXQv+8oY7dXz8ArJe9wVy2UbvQ==
X-Received: by 2002:a05:6000:1f87:b0:37d:443b:7ca4 with SMTP id ffacd0b85a97d-381f0f5e2ddmr18929643f8f.14.1731511342593;
        Wed, 13 Nov 2024 07:22:22 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432d54e2cbesm28265185e9.4.2024.11.13.07.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 07:22:22 -0800 (PST)
Message-ID: <cfe27773-383f-4178-9aea-d92c2bcf8991@linaro.org>
Date: Wed, 13 Nov 2024 16:22:21 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/10] thermal/drivers/qcom/tsens-v1: Add support for
 MSM8937 tsens
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, iommu@lists.linux.dev,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20241113-msm8917-v6-0-c348fb599fef@mainlining.org>
 <20241113-msm8917-v6-5-c348fb599fef@mainlining.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241113-msm8917-v6-5-c348fb599fef@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/11/2024 16:11, Barnabás Czémán wrote:
> Add support for tsens v1.4 block what can be found in
> MSM8937 and MSM8917.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
