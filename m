Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D365192B7F
	for <iommu@lists.linux.dev>; Wed, 10 Jul 2024 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720626526; cv=none; b=SMcyoAg3ALQtj/okl3iiRwUECuK3LdVHyDSeQNjOsVs4UzSgPbOXZQFRvMWLrQbOsFW+6pzgnNext0JYjkl3zYvVnkXPF9y9z8m9tQrLBT7uF5IDFcIf1ItIyPhmP+XwBhKapBRAqe9dW0M+MZDWp7vRNr3y5SUb2gdjyRJ+yhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720626526; c=relaxed/simple;
	bh=iorRHs1FfFnnoZBWAuEPvxWAQCRVQH5UaGIKV9cGMW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHD4YtyP7c/YntMng7DVOdixSPCmTPXHuy7rBxo5oVPzkFVICHSZudQo7CLbHzsHcam3wyeEmUVTjuo0uICn2AArLvBnOLIeCEHd8W5bYtx+AIeOiBH1JHS9311zhmZeECR3AsoarJUD8ro8vvHwoBCM7cGe8gAmIHltOSH80gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WQH9UjyZ; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WQH9UjyZ"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7f976f18955so11668239f.0
        for <iommu@lists.linux.dev>; Wed, 10 Jul 2024 08:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720626523; x=1721231323; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LS47NwTHSzZjUEoROwPuK2RM3LnHChBCx0vrrpQXSqA=;
        b=WQH9UjyZV1jlCBgLVTjJ7Ghtp/UPmzmcYvguaDU0i/xFCFIyBc5ibblPwgEPmp0uOX
         F8Xs+3bH7GMo+gH14bmOY8oukegu+/57iebyRzV8yzeK+HpUsI5K6F0NdBYODumuggD8
         lOWlKL1PEseeuUrczSH3TtAA9tknHLu4kjNBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720626523; x=1721231323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LS47NwTHSzZjUEoROwPuK2RM3LnHChBCx0vrrpQXSqA=;
        b=vi6J/5oP6dhPOKwYueJPZtm3iYFvvnMkQIhTGK1rOvlWZ5wvoqcDOCfhrjX/VavLZk
         sDRu2bGwIvUpQyCZWZJeVVQ/ez2h3yrNRuIkp0huwODr6PMPT3JdzqE6s8Qxq4yKn9Sp
         fFLapQMjOWk2aBj1wqpt0KqYJepiEEJcrnJSuJlU0obQVPbwuFl/pOYc8Awi7OKyvLQu
         GzzBgvPxV98QcvsG9dpTLl/t91w5oHQkI6kA650wOV6YBfwh2RL9KqTWjaFHo1tgN74P
         FbavFpwzOvxcyql4DLsJ/QrpsrcV54UoSirSh/4yVJ0BVcjPnOtCa4TLLROuo1Gq9rqQ
         2UCw==
X-Forwarded-Encrypted: i=1; AJvYcCW+RzsgyXnXp2dt12ffN9nYm7R+mtT3uT3DyiilHzMXdVJVXs9TfCnIue+3CnVidbAIFAQQz5lpnwEnjrUf+2huHn6nrCM=
X-Gm-Message-State: AOJu0Yw8cFrUFmugkkVqxuTzNJl1IVVDxs0wmoNCYpC5RQ+53v0tlaVO
	ROXpheo6w4untguJ20FMIQE2YvgG5M4ldpjSLR84tOeNpufWXBGOSHtoemZF5Uk=
X-Google-Smtp-Source: AGHT+IFRD6fL3OQ1OLKpghMhlBlympGGayGAHOv8YbYdzU4CyToyqM5gp8L/0wFHUzroGW6XGt//dA==
X-Received: by 2002:a05:6602:6103:b0:7f6:85d1:f81a with SMTP id ca18e2360f4ac-80004dea088mr658795739f.2.1720626523218;
        Wed, 10 Jul 2024 08:48:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1bf8601sm1222131173.105.2024.07.10.08.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 08:48:42 -0700 (PDT)
Message-ID: <0fcefad8-540f-487e-b5b6-b78009bf5d9b@linuxfoundation.org>
Date: Wed, 10 Jul 2024 09:48:42 -0600
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/dma:Fix a resource leak
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc: chenxiang66@hisilicon.com, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240710063045.5308-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240710063045.5308-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 00:30, Zhu Jun wrote:
> The opened file should be closed in main(), otherwise resource
> leak will occur that this problem was discovered by reading code
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/dma/dma_map_benchmark.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
> index 5c997f17fcbd..3fcea00961c0 100644
> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
> @@ -114,6 +114,7 @@ int main(int argc, char **argv)
>   	map.granule = granule;
>   
>   	if (ioctl(fd, cmd, &map)) {
> +		close(fd);
>   		perror("ioctl");
>   		exit(1);
>   	}
> @@ -125,5 +126,7 @@ int main(int argc, char **argv)
>   	printf("average unmap latency(us):%.1f standard deviation:%.1f\n",
>   			map.avg_unmap_100ns/10.0, map.unmap_stddev/10.0);
>   
> +	close(fd);
> +
>   	return 0;
>   }

Files get closed when this process exits. There is no need
to make this change.

thanks,
-- Shuah
