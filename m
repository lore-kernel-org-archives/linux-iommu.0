Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE3616D4FE
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898780; cv=none; b=rP9yRKKsplaAAO7DjdkUFs9JsPOGHlQ+ZUcvSboSvmRH5o1P/28axr0eVt1bQevMV2TyFrHPuDv1eYYAMl50IEhgmDzoQMX14FcYj3FGsRLE04A917KsIhDlNr63tp5LuVjncBc/x5UDb2gHfd1vgp7ZmKB1uSRjMk/gaus4x8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898780; c=relaxed/simple;
	bh=2I4Qx4+DWic0UT3mZtzbY5yRspiHN1TfRVJkozbFlvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOOt32IwkMIugI+AijBT+NzFVDHIk4B1QfNz9wMixkqF2TOo3isIYy/TDYz3FHgBfnUAxIHoQFsDEBF66OUJzDlQDSX+noqVsJhG5nikyqqNh9UVLJepIFJfkFEYNRaes36BOBg7c0vX78sMVJ64+0056aIS2FozpaUY4QLMXZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QlOoaDXM; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QlOoaDXM"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5238b5c080cso885405e87.1
        for <iommu@lists.linux.dev>; Tue, 28 May 2024 05:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716898777; x=1717503577; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hju/dzcDGwp1N89SfT9zfOLpGA1kJ/+7Gbdzfhg30W0=;
        b=QlOoaDXMDnS/jW75NH0AmN1ETw6nCqnw5yV64MkBPRqZjMe7Un4B1Dc6Qy6PZkoi4q
         TFexioIiog4ff/6yngkqr2t+P61ihLl0RwyyALaJ6zH6uT4n9aNHzA4u+UShm8t6HwTz
         DeDRPU1rwp2uz7JTdHGF9xYtfvsTixGVp+oGKDa6+FmVYSYEV6k17sDYjM50VGu3xYSg
         pM0dQThmIjSnnuEgGZto6Pvaw6PYCizbY22NY4Da5v5SXH+i/4+lSmEHixw/Eplu/98e
         JDSNSC7Dld8PKlr6Dz6pq3vKugu8+jnEdmIjYw/VkzCkSzgVIyeGOK9QL9j4J8wmqWVl
         KGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716898777; x=1717503577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hju/dzcDGwp1N89SfT9zfOLpGA1kJ/+7Gbdzfhg30W0=;
        b=NEB3cVDXi0T8gSPb33gerOLm+ykhAwBXCEzE9SlHLzko7Gbz9lYYUlrMGp+AmgGI9r
         mwtQMliRlO9nRK8QWbJWQNJNsgERsuXRK4XGcWL9GtA/+ck12JN0ebCF+uNcrNSBeb8t
         qQPXfBzojUXxbaFfKTbQh1idZ5C6b2LDklU5HqrmzOvvCmZg4ZeFg8xAuSZ5OjptmpLw
         4144ny07Y/US2Qe/7qIMc1IAjzdoVm/CxRrzzUAbEIlISdNV8TK77UYmnAER60dEqRKi
         +rR4AnkAIqrW2DpRySMwhY4oysAc0SFUw++zl+TzM7AC3nwPLH8YJtdroq2WLRBDFp1r
         70rA==
X-Forwarded-Encrypted: i=1; AJvYcCWyhuHDt1S6Ym5cMD58B0oWTsjZu6R/Cc2VkaXW3McSnnOK4uzZ++5xu77wBWVS07GS9h03btJkPpx0Tm3NfOjZyygoEhw=
X-Gm-Message-State: AOJu0YzeIoI2VP4vg4qTpanRNCXB1/a7PGHP2dmQI4CmgxMumMHwAlAt
	24UzU7cBbH2WYFU+cg7qgfkP252osaWQa/NxJyzM1BSGzulLoFzll4dtTXtD3rc=
X-Google-Smtp-Source: AGHT+IHb1zZQ0sL2m4mtu8iyp037bOz4p0I+XuGUCtiG8LAL7GAHOoS34U8irKyS9Nn44UCM5bAh2Q==
X-Received: by 2002:a05:6512:6c9:b0:520:9775:5d4b with SMTP id 2adb3069b0e04-529641099a8mr10692697e87.13.1716898777293;
        Tue, 28 May 2024 05:19:37 -0700 (PDT)
Received: from ?IPV6:2a00:f41:c97:23a9:35bc:df2e:d894:2c76? ([2a00:f41:c97:23a9:35bc:df2e:d894:2c76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52970c32e26sm941501e87.184.2024.05.28.05.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 05:19:36 -0700 (PDT)
Message-ID: <9d26e798-739c-4128-8d34-79725f1b058d@linaro.org>
Date: Tue, 28 May 2024 14:19:28 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sdm450: add Lenovo Smart Tab M10
 DTS
To: Bjorn Andersson <andersson@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20240523-topic-sdm450-upstream-tbx605f-v1-0-e52b89133226@linaro.org>
 <20240523-topic-sdm450-upstream-tbx605f-v1-3-e52b89133226@linaro.org>
 <r243r56bz7nrp2guaqj2n26exdv6y5jyjtoytmceutd3cqbaao@r5xk3qlspwsi>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <r243r56bz7nrp2guaqj2n26exdv6y5jyjtoytmceutd3cqbaao@r5xk3qlspwsi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/27/24 18:33, Bjorn Andersson wrote:
> On Thu, May 23, 2024 at 09:59:35AM GMT, Neil Armstrong wrote:
>> diff --git a/arch/arm64/boot/dts/qcom/sdm450-lenovo-tbx605f.dts b/arch/arm64/boot/dts/qcom/sdm450-lenovo-tbx605f.dts
> [..]
>> +&rpm_requests {
>> +	regulators {
>> +		compatible = "qcom,rpm-pm8953-regulators";
> [..]
>> +		pm8953_l8: l8 {
>> +			regulator-min-microvolt = <2900000>;
>> +			regulator-max-microvolt = <2900000>;
>> +		};
> [..]
>> +		pm8953_l11: l11 {
>> +			regulator-min-microvolt = <3300000>;
>> +			regulator-max-microvolt = <3300000>;
>> +		};
> [..]
>> +	};
>> +};
>> +
>> +&sdhc_1 {
>> +	vmmc-supply = <&pm8953_l8>;
> 
> JFYI. Not ensuring that the vmmc-supply is in HPM mode bitten us
> multiple times in the past.

it's not rpmh ;)

Konrad
