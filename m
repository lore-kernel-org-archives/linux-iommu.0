Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B788653E3E
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 21:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708378669; cv=none; b=uq8nNUIFfsDkw4TUgBlsX90PMvUOZ2s3gEfQlGB+rd+O5M2qVsMfEndtxN5kzsrZoTfjx0qzBfIqRTozbZunXsP53P5Nsi2//iy0Yshf+HIj4Xm7hc6Oqr1ksWmvBauJ8W4+mx0eXW4lAB0t8jtswA9Z34iB4GAAswY7p+Sd4cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708378669; c=relaxed/simple;
	bh=mVdCOLa4vNpEE/e67IyWO1/E8dm4wo/8XueEHdZSyXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdIY4gyBqr+DlgfUzqyf14WsyQRqyh4zFAGlZAR2lINjAcw25gNbez61v+upXmiknTQldQ+5FPAXtA487tOzk6O77anBVNv83PliOS21aDVtGSSHi1DQvegup9iDRoQqd8LHvVWdfhVQMDwniMHsfFvMZwgOBHLFdFR6JNlW3n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EBmFplCo; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBmFplCo"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c457b8ef7cso184398139f.2
        for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 13:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708378667; x=1708983467; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pu6g5yftLiVv7gzZzzrLLgus4wextVLz0oNREySNgzU=;
        b=EBmFplCoqTjvhKAzpHq5cEJ4LQKEOBTXb1xKxO463rMLNbWa0ezPuThM0sC8UHFwPC
         ryIFvT+dmGMlEgzBjvRNnRR8XNoYGhcUSPWrhYxjfaAqKYjdLOlNAwL52jIp1R1CN+v/
         XTIs8uH5hcW1dr4esBTD41Xe8/7Tx2UOKjLSEeKp+N4bBn32nylgkcX3kEqtyD7VVt/F
         bh2abZfzDrA497PGPwi8PABodj/G5Wx2vSy5c0oRk5f92NlNmFV+f0W/mi8MWgP1/csc
         PU/fClrz6zK6f0kH45Blk8lWTnMy8RS7meceQ5zLZ2VS7Pasj0ZSZEew/ajRCJrB14PS
         yc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708378667; x=1708983467;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pu6g5yftLiVv7gzZzzrLLgus4wextVLz0oNREySNgzU=;
        b=M0oV63aPWvCN6QrhoqmBsKZTf3+/UdL9s+umbPb+M7sPWsHQVBj+oEvfsMHAhdDK0/
         rLqNFGxy0v7rWb27Fv4TxvdFJb/7gHIybT0bcoKiOOhnK68rqj9EmsKRLzNrfNJL8phi
         FxN9qgJuObJXBv3b0dIdbboYpzd/0ocOD02E/CRwDwFANQ8V7fxH5xVYiyv5SlhR15+v
         c+N71zZi+Nmx5nrKjZrVzk5/9Y6K1kLriOAodMUDkUarKJcIYf2uHiZVFJ4Ez6epbcKp
         ZkNbCLkAf4/RWy8K6GxcQsrCU2LZI4FojnQTXmhs/He3qHznoqceXi47+O9oWZNmjMpo
         mSaA==
X-Forwarded-Encrypted: i=1; AJvYcCUvwd7j3xPzDeKcl4Ac2l438eHrm2qzRM4MhVl5ko6VL0pFyN8UzzNHtc4WtcOxVoIzHQ/E1fV58zsRbxOFFy5o6O8s60Q=
X-Gm-Message-State: AOJu0YzadGfGT3mYIarMJVditKWOkpc6bHo3u/Q94x1KfH//4aiJjZ99
	paLKUkqxCd/TemtDBrfoZpEXO7KpKbWj5kFl/gY14TfJrL7O1o8XR+CuGqYaj7s=
X-Google-Smtp-Source: AGHT+IHHodfPh8+zZHa5pC68NadfSM5VyTFrqakTzatd2R6WfLeoBbHIC1ajK3I9MAE4ena3DfCGhQ==
X-Received: by 2002:a6b:6e0d:0:b0:7c7:61cd:ff52 with SMTP id d13-20020a6b6e0d000000b007c761cdff52mr118392ioh.19.1708378666899;
        Mon, 19 Feb 2024 13:37:46 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id s8-20020a02cf28000000b004742a4647edsm614498jar.159.2024.02.19.13.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 13:37:46 -0800 (PST)
Message-ID: <b73e329a-02a4-46e0-bda4-5d5fae0a1180@linaro.org>
Date: Mon, 19 Feb 2024 22:37:39 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] arm64: dts: qcom: qrb2210-rb1: Enable the GPU
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org>
 <20240219-topic-rb1_gpu-v1-8-d260fa854707@linaro.org>
 <CAA8EJppPvXfkz=wVca8aFBhFaVUe9+OiVzcQUq7D8zPbK+T1FQ@mail.gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAA8EJppPvXfkz=wVca8aFBhFaVUe9+OiVzcQUq7D8zPbK+T1FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19.02.2024 15:49, Dmitry Baryshkov wrote:
> On Mon, 19 Feb 2024 at 15:36, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> Enable the A702 GPU (also marketed as "3D accelerator by qcom [1], lol).
> 
> Is it not?

Sure, every electronic device is also a heater, I suppose.. I found
this wording extremely funny though

> 
>>
>> [1] https://docs.qualcomm.com/bundle/publicresource/87-61720-1_REV_A_QUALCOMM_ROBOTICS_RB1_PLATFORM__QUALCOMM_QRB2210__PRODUCT_BRIEF.pdf
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> With the exception of the commit message:

:(

Konrad

> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
>> ---
>>  arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 8 ++++++++
>>  1 file changed, 8 insertions(+)
> 
> 
