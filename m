Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D6A823DC
	for <iommu@lists.linux.dev>; Tue, 23 Jan 2024 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035333; cv=none; b=AVnnJuHHXzA4RXyQLiYW3/5+WL3mI61sVK8DnfZcs29zhNfXLKAuGeHjsCNqxLJsMrsVNqGOI4vWXWqmfb14FkJWtfTvEc5/73Wre1+GLGAomM9LulmiwSymcKeDJwCcgTDxnzThMhZoFkiiPVCxl6ly9E9Xt1P01QnimCQSm5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035333; c=relaxed/simple;
	bh=jYLyxNEUsjD3oHw3RfCJzuYV90CU0PZCraZsQjrd19Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvBSqLDU+EhQ0g2UmnMIA1WUe7fxhGowdatKLhsBeuF/XAKpJjmVCgY2N2mDxyEIt3Ug4n3EZaYzip8b5pnuAev3LWd+l2sge0+wKosjjWmWijDxvQWTi2ZdLWlrha+DQ9ckRCUMbHXJrKeEMlviLvp8gEOkV28EkxzfGq9hECo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B83fDvXF; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B83fDvXF"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e7b273352so4887311e87.1
        for <iommu@lists.linux.dev>; Tue, 23 Jan 2024 10:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706035330; x=1706640130; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yzsTsGczKI6Xyfdy4MTULSYbNs/jLsDoqBb/j5tuTTg=;
        b=B83fDvXFOCGbjQeiqa3LrC3jZeXM7kWyoDr1pxquQ59oZdr8j0q1y6DThN445BbUL/
         ij7e7xyaNJM54nqP9NAECsHWl1ux5RfOr07CwQUDr1EXLF2AGoKFfIO/xSIlw7zQqv58
         CW04ASvLeoVqr+aFZqDZqAZ1rdD/wv83jxgW9bazeBvvBdxlal8GoS/Qjc73MFITFy5h
         dYshqCvuQiXaIcMkdTPYlvC70yMFSfH9MoycHkzZYHOtBnAKtnYSSnCz6sKq1Lc2agJa
         CV/RnYCiupSYLcJvs4AAmSju7CCnCXfpiC1ufDdpNeZwpKb690wGS3E3JsM7k4fJjAe7
         CD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706035330; x=1706640130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzsTsGczKI6Xyfdy4MTULSYbNs/jLsDoqBb/j5tuTTg=;
        b=C4bbnH7927QjGXJ5Vu4v2VUDvX1PhFePlfZqlq+ss7rdfr8z+FiL+6B1HXG7q28JaS
         mOgKbGZ8pF47JdAmaQoGefyLA6KLUzTU+anVqcIRIwB47ipqrjI2QYKhjKvJNqD6NvR9
         XtnfL60MwDj10ZLNwsX1wiFPLMaF9DfjgRZUJhTEyub+lRuM7wDDwG/PKmpJbTLztI+z
         gvpZJZss0ykxr2b4uV133Y47r4IFJzVTos6OHAdJl5hf7F0AmI5NEn9rXbjNC+AXK/yl
         eouCkw3OJ6phNNy5qD9pRv/NLJZw30cQDKx/QXpGfO4R59otmoL6I5jC6/IA429PEMhF
         y4PQ==
X-Gm-Message-State: AOJu0YxzoCAhc58f15/pZTKtnIZuungvHvIAjJCvowazDzZ+QzvV1zPb
	Ii4a9znYh0YBL45Tew5gvfCmEEO3SYckYfIoMt4Q4MtD3JNMZj2JfvJQywCvHHw=
X-Google-Smtp-Source: AGHT+IGaEnFdqksia0Yy81wIZbaYWiYzTjjDrfLdKLLyXbeWrgcxmcdx+hLeizeeBQyBYR7z+QJLbA==
X-Received: by 2002:a05:6512:b90:b0:50e:7c70:fdf0 with SMTP id b16-20020a0565120b9000b0050e7c70fdf0mr2913447lfv.85.1706035329800;
        Tue, 23 Jan 2024 10:42:09 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id ep26-20020a056512485a00b00510091c44a6sm40347lfb.165.2024.01.23.10.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 10:42:09 -0800 (PST)
Message-ID: <61730f0a-bed9-4755-9c47-1bd2044176ed@linaro.org>
Date: Tue, 23 Jan 2024 19:42:08 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/5] iommu/arm-smmu: add ACTLR data and support for
 SM8550
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
 <20240123144543.9405-5-quic_bibekkum@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240123144543.9405-5-quic_bibekkum@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/23/24 15:45, Bibek Kumar Patro wrote:
> Add ACTLR data table for SM8550 along with support for
> same including SM8550 specific implementation operations.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
