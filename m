Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A6725B669
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606090; cv=none; b=Zur+fKcpOtwXgZVaMMN0i+sxi3PhoBkdNfdZlzl3MdZyjZdjXHM1pQeFiCHEQ344/4Kun6xPm4HwNUyi1hpvZk/pCSbE+T4yrs9jIGpniXHCyBbQ/XpkdwzJxOa0k2WwZushHSP1n3V1eX48R1xaN1zusPUFqRxBZWuFXWDSLNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606090; c=relaxed/simple;
	bh=Di9FYpPtVfl7GsOFof37nEkaTPeYYC8IFNc3O29zZBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKCKz54+QJyDP9G2RKyhm3NR7QQyJB3dMjN+TW4OLI6eU7EoiqklOl5tdJ0EWyJ1Cq8nfCmgQSkFp4JYk55Rn1OZUHW41SxthKTmJ5UkEdPTsjwl7TWCdsECWbv0RoktuHdVxHuzdFS9Ef9N2GilZvvgw7rpnjLnMXOfr+ZBhUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ACuT4gN0; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ACuT4gN0"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d2af701446so2613545ab.2
        for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 13:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740606087; x=1741210887; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FGewUZ9tiTuQ/iU86a6R/FdqPI/FHFuOTv+IuUM0fSI=;
        b=ACuT4gN0IleOGXOwBfvjFJriLbtq16DOVHZC7HiI7ktKX8IN8Pk12a+gUyzatCDgwr
         Pgjf8UU9zeSt/iYRmYSE+kZ/pMcFaQtG0UtwDVc0zMC5aWOyUUf8973Td7thyaSsjOkl
         CWr2RudMiBdfJ27lLgDs/pr7LgK8q48AbAX+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740606087; x=1741210887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGewUZ9tiTuQ/iU86a6R/FdqPI/FHFuOTv+IuUM0fSI=;
        b=q96FVpEpvvjBkIIB6T59eWU0RraGnaE0+4AMXRUFi0k0MjRCPULyxtkij9zMY1wn77
         uPPFfzgwEwfsx8ck/XFIFLl2QZN/kvSAyyB6UhBFckPtpdtRoYMeVuGIwWwuGtS3Jfic
         n5SO+vft8xycipzoefuDZaIY2nAaxdEh0XW3dKpnd/ZpEd9zlhmn8g3Jc76oWmC9UA3Z
         JvL+V24q7korHIKx2OKkAA5U4+yj4DSysnpbtEWN0Qb3edk60pfRk0a9D69SxpJ8fXJQ
         havddXYUm6rWOO+v0QtJ7pZ1q60o87LbzZdOlK8WAshdWMSbq5GhonZmfwNPSRUMOltX
         nFTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAxGQSaQ4/lONfSgUMYhg0mAADBsazjfX2x1J2Nq0+i8AVALe1Se655DjBCj4e/n23yHbK9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywpxd5uNq7Ga9n5PH+jFRFjeuLJb2b461T9GZcQHlwsDF7wvsoP
	Ke3s89OPeux/Jpu1ON++mR1B4UxCAM3NuCn1ehhTP2nsZSq36pjNYlPOsm5gYCQ=
X-Gm-Gg: ASbGncvcDYh51iZsaFP70etcQcx7P4MYZKhzGnK3bMneVlfkNfbVvgqXdYDpJnq6F48
	foO7NLxiVLQP6st6F7ctfpmRqu1NKa19rB0fhK8xuBmD93A7RpE1ilZMLb7zA7UTMi1AslC4Hkr
	wkjCMDcEcq1w6hcAjurOssEj6fmzerbMG1wUpwAfO3YdSObEYCaDCeQ7lv8dz1BERS/+FXtARN5
	0i5SHWRLT4kcJoWpzwrTEmpOD+rFZzmr4qCNqL0Fr+UsBvxCmT6ONNCNkukwNKGf7IVhdIK28Om
	XJG4RrN08EA3ZqcUbkuK9ibAcQD79Nd6JwxB
X-Google-Smtp-Source: AGHT+IGEnHXG2qu9LDh932QF8VC4PSeuGzxYdyTHYY6hisaHR02G7GnV2uKJV/Dq51cIKq8C5TdmhQ==
X-Received: by 2002:a05:6e02:1c09:b0:3d3:ce83:527c with SMTP id e9e14a558f8ab-3d3d1f140cdmr58022385ab.1.1740606087525;
        Wed, 26 Feb 2025 13:41:27 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061f790bcsm38180173.126.2025.02.26.13.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 13:41:27 -0800 (PST)
Message-ID: <0758d73d-98b7-4f9b-a3b2-001d69eb949d@linuxfoundation.org>
Date: Wed, 26 Feb 2025 14:41:26 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/dma: Fix bad array reference.
To: liuye <liuye@kylinos.cn>, shuah@kernel.org
Cc: zhujun2@cmss.chinamobile.com, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250206021239.51897-1-liuye@kylinos.cn>
 <3b51ae45-4dd4-4238-bf3f-3cb4d263eda4@kylinos.cn>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <3b51ae45-4dd4-4238-bf3f-3cb4d263eda4@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/25/25 18:31, liuye wrote:
> Friendly ping.
> 
> 在 2025/2/6 10:12, Liu Ye 写道:
>> dir[directions] should be directions[dir] to correctly index the
>> directions array.
>>
>> Signed-off-by: Liu Ye <liuye@kylinos.cn>
>> ---
>>   tools/testing/selftests/dma/dma_map_benchmark.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
>> index b12f1f9babf8..b925756373ce 100644
>> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
>> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
>> @@ -118,7 +118,7 @@ int main(int argc, char **argv)
>>   	}
>>   
>>   	printf("dma mapping benchmark: threads:%d seconds:%d node:%d dir:%s granule: %d\n",
>> -			threads, seconds, node, dir[directions], granule);
>> +			threads, seconds, node, directions[dir], granule);
>>   	printf("average map latency(us):%.1f standard deviation:%.1f\n",
>>   			map.avg_map_100ns/10.0, map.map_stddev/10.0);
>>   	printf("average unmap latency(us):%.1f standard deviation:%.1f\n",

How did you find this problem?

thanks,
-- Shuah


