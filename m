Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A832E648
	for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yHJXupdR"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-507973f3b65so9919355e87.3
        for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 08:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700066624; x=1700671424; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKwvuedBc9zWWjZXrz7fOSDDi6eG4P0hcIfiBzhjapM=;
        b=yHJXupdRr2vz086eJ2Bw76GtAeEqqCTpFwgSWcwSNh65EE6Kty7qJxrRWjEee69dXw
         4YCX8l2/cTt4QzJwc1kC8uhBC2rnxUXq7jLSiK1JNJ1v3EKMWZL48cJA5B59zyOp54za
         RufuF+j8HueiVahi0V4CkpF5MJrMkb9y8Ia8sk3AAPb7Qk2zSQXXIRMdaIZjlUXrtKeC
         deYThrXNA8zlvXZe64lzzXNBT7gJppmXGE6q/vNzKeAZbMQC4vOZOFZaLzgaKC978lKF
         Ymjo+yMZ6tJDy79fmwOrNZItdMywj4U/tNxsN/DP/2bDZXDKGBfnWkWKr/ME+v9IoGkl
         Kj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700066624; x=1700671424;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKwvuedBc9zWWjZXrz7fOSDDi6eG4P0hcIfiBzhjapM=;
        b=hfnrYRYSXgr66ru2mJcyYcxrDBbFr6aI1sZMMxp2gp3fiJYKLLcUgKsnzYxYSmaPng
         fYghrEVzyq/7SMFSHrwjuFUWr23S5OJMJBvY2GxcrfJ0HfB4owze77WGNsrzinAyGHbj
         +/ENhtgVNaF5LDnjcFtAdaMpnOkbtj+6k91aaBjkHSRB12IkfcXu7Ze/IF3k7E4sE93K
         A/rCohllOdfUT0Az5qEc6ID0ZbRacgIGHhOjHvj+hri6v5AfWAnkMSFOeaL6nIaLaIoB
         OodJVnCW93m141qp3ZMBnq68hbpKnzdc0iyj4ihwLTY1GGXT+OEquLR5xxLn6eOnXpxG
         wYcQ==
X-Gm-Message-State: AOJu0Yxxw6C3Q7INYiwsDda5vgcFyvMiQMmkVxHwYXOZDsSn+Lv3VsQd
	xeX499lPRu/YcroT1U6PTlKvsw==
X-Google-Smtp-Source: AGHT+IEyO+JuxqtD22IlDEHQfvtuGmYUZnlYNdcdmZAwd7aiUoKMqvknqimL7DYcdHAQ0SP/2ilgmQ==
X-Received: by 2002:a05:6512:3f1a:b0:508:266a:e85f with SMTP id y26-20020a0565123f1a00b00508266ae85fmr9820326lfa.1.1700066623747;
        Wed, 15 Nov 2023 08:43:43 -0800 (PST)
Received: from [172.30.204.150] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id d27-20020a19385b000000b0050a026d3a26sm1705739lfj.227.2023.11.15.08.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:43:43 -0800 (PST)
Message-ID: <e5b0d8c7-82cf-4a3a-9a6e-28e7b468df8d@linaro.org>
Date: Wed, 15 Nov 2023 17:43:42 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] iommu/arm-smmu: re-enable context caching in smmu
 reset operation
Content-Language: en-US
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, dmitry.baryshkov@linaro.org,
 a39.skl@gmail.com, quic_pkondeti@quicinc.com, quic_molvera@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 qipl.kernel.upstream@quicinc.com
References: <20231114135654.30475-1-quic_bibekkum@quicinc.com>
 <20231114135654.30475-4-quic_bibekkum@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231114135654.30475-4-quic_bibekkum@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/14/23 14:56, Bibek Kumar Patro wrote:
> Context caching is re-enabled in the prefetch buffer for Qualcomm SoCs
> through SoC specific reset ops, which is disabled in the default MMU-500
> reset ops, but is expected for context banks using ACTLR register to
> retain the prefetch value during reset and runtime suspend.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
And I assume that goes for all SMMU500 implementations?

Looking at the 8550 ACTRL array from patch 2, CPRE is not enabled
at all times.. Is that because of performance, or some other
technical reason?

Will this regress platforms without ACTRL tables?

Konrad
