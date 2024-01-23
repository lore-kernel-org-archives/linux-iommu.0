Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DB9823B1
	for <iommu@lists.linux.dev>; Tue, 23 Jan 2024 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035353; cv=none; b=CrjzMT2z2alMTeKwBwal/Od3YJrgtfzq6+GigGFY/MLBdM72u4ksYFaeVacCQzYejl3yM4q9fOr6zb6zNGI8oQ82V5iu/Ye67BaYnADFJ+j4gAmB5fCfFt2c0g3qiLatunRyc1rVO4brwP549jjpmbFdH+TJP+sm1sJwzSFavlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035353; c=relaxed/simple;
	bh=lOlGlh6X349aNC5GuDUfgVZHmOFNRhSYOwVnX+TNSDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emHNg3IdFkTo06aWoNThEmgy5vbuUggRKO/3FFgeypi5s1KNZSy2pYInrAwpJaBxIVUr04+YgubJNcdjloB+3c4CqdkrV2Au3oK7C8VRlSgFDzmXksbTjngx9cbUc1WH5L/pK5m+gzNZOwEafsWLHxBfOaAOJLvmSTI4PV8bE14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SB4qTm33; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SB4qTm33"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso5772249e87.2
        for <iommu@lists.linux.dev>; Tue, 23 Jan 2024 10:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706035349; x=1706640149; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6EjMPAHtaQ8hjurD0Wwpn8cJ7F+mlxK/BDZ6aAcgP/s=;
        b=SB4qTm33tSdL6/gxlhxOXs+ftv9KN1WHwS2gPmOsmnJg9tPp9asey4bujbUlX6iHBg
         yjypJqQOfIK4SWh9U+NSQBv0Wlzu2mDuZatwmlInoH8DbnkuLzAoAJvtXDfnamunEFZw
         Br+Uii0m3pgG6Fqtec5u1Rp7IRTRB4FIRhLdw1i/gy4SZ9hQGYDvcVwaHX9/WZYdobli
         5hLZOdt5ZCtfKPzTpIXS6r8Gw8kJfUaylR/T6yDMHcdcIRZBboFepphrmRmEKlClJ/sz
         8m64DSkC+xvskf72VqoMVjR2FvU2q+VZGZzTNj7+MgsuMqVpR4029+HgDMDQ/W72Bsrc
         A4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706035349; x=1706640149;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6EjMPAHtaQ8hjurD0Wwpn8cJ7F+mlxK/BDZ6aAcgP/s=;
        b=K4J/nGfEPhrLb6BlDDt+hXzOBsHyF+2p3yWLDJm+Ps2ltQhQHSHXCO8KuXd3C49IyX
         BYe6qXKMJISJndF3rfINcjRjunm1dAuG8yvNFJrazVScLOmnV/jV3XZ6VM1R4Gq/NuF6
         rCMe7DyhrJyFShRcIcqZllcSqFr6u6mXny1tDQytg7UdgFsyWlzwlBLaoAzPRs4j3Fj6
         rlpvEdjiv100MVJHakK4okRJ5VFPX76n9X1whGnxIQmzzDzj5MdGzcghsz+arqhY64qb
         ntLW3ymJYvZBqdNTFC1IJ/7gAu1/P7ujVABvvOSL/NHABf8HhmXzx3ysmNa0U/c8l7Ti
         3flg==
X-Gm-Message-State: AOJu0YxEdxvXAHXmiS0b9wLgP8U39WZ5E7ZJNox+FvLLZ4106vY76kPN
	CwTypJcRM1hP+SVzz8Bn7f1MMMxMS2d7sTCMwd6XCDnHBZjA8pAWnVuRd1Q690U=
X-Google-Smtp-Source: AGHT+IH4rZ9jLHR4HLcdTKeh97zjQd2g5iE4sly5QEUhYVZ4fYd8HkX+9LsRNA5CJ/Yt+5J5MGok/w==
X-Received: by 2002:a05:6512:e8a:b0:50e:d9c5:199a with SMTP id bi10-20020a0565120e8a00b0050ed9c5199amr1707051lfb.25.1706035349242;
        Tue, 23 Jan 2024 10:42:29 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id ep26-20020a056512485a00b00510091c44a6sm40347lfb.165.2024.01.23.10.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 10:42:28 -0800 (PST)
Message-ID: <97589847-47ec-4012-ac07-7ffb85c27637@linaro.org>
Date: Tue, 23 Jan 2024 19:42:27 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/5] iommu/arm-smmu: add ACTLR data and support for
 SC7280
Content-Language: en-US
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, dmitry.baryshkov@linaro.org,
 jsnitsel@redhat.com, quic_bjorande@quicinc.com, mani@kernel.org,
 quic_eberman@quicinc.com, robdclark@chromium.org,
 u.kleine-koenig@pengutronix.de, robh@kernel.org, vladimir.oltean@nxp.com,
 quic_pkondeti@quicinc.com, quic_molvera@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240123144543.9405-1-quic_bibekkum@quicinc.com>
 <20240123144543.9405-6-quic_bibekkum@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240123144543.9405-6-quic_bibekkum@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/23/24 15:45, Bibek Kumar Patro wrote:
> Add ACTLR data table for SC7280 along with support for
> same including SC7280 specific implementation operations.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
