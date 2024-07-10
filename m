Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19246194AED
	for <iommu@lists.linux.dev>; Wed, 10 Jul 2024 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627129; cv=none; b=NLI+HzeZB91108h2bWeoypVqnrgHLICErHUuHcCn3XYyl7Npi232VczIoOWzzpk+9otZ4uVkFKJNxRjzjvNPZyiewGcbrEXWJ1J2qkwU/CSk24zIR5ZH0sjUhjAhunIsAHfH67qG+TUEpcJkeDQzogBV1VOBY536FQtccBpapnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627129; c=relaxed/simple;
	bh=glBPvWkFzLQfz8TsVq9rjy/MlGkv6G8RoVIA3mtxWlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1f43Jv5cU85TDzgoZjtUEGma9575SuJKMkHm1StHrjV63oSJ4XWnGKi/RX+RcuN1Hzu0Az01u6StHDtXQUAA8f9TXv34JngyeYHufW+mUtviO57HphS7u+4TIB2IqD7j444IhcuT5h+pVUrkw5aM6bNe0Sb9atbH94jxlzLuxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SSF0Falm; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SSF0Falm"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-375deacb3e1so2906595ab.3
        for <iommu@lists.linux.dev>; Wed, 10 Jul 2024 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720627127; x=1721231927; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fGy2kaPZRr3hHhlJ6VMkV6cbieMFPeP7bwQHrR7G1rM=;
        b=SSF0FalmwD98y0yKkdgkuwaPQKq3x9I1aLjw0KJdqvXBZxpweqLj21AtsYSXUl4PFo
         TFt6Wvi50Ec3Ncjj87N0X4msUX+XOmYtPVu4MJEMBFxQDcjyKXzkZAUr0Wfjd/QJfHhZ
         6JxTmcgb9mCuVNnrmTB1bZ6y42SCWwaQH+KvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720627127; x=1721231927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fGy2kaPZRr3hHhlJ6VMkV6cbieMFPeP7bwQHrR7G1rM=;
        b=Sa4OZ0nO8YeY5VK5eRV4TgKsixhWgYcULo0TCN6qpyv00n//usp0BrFwHqb8DF3I+l
         cHNnyq6agQZhGC8rjsMLgEk6TMHovAk98ghsskqxuHWa5yJuM+GB1NKSsQY0J9vYw7p+
         N/CVnG7f6MUdXbMkk2MecUkqiq9W0Y65G0XDHO1u87H7iMT/9EdzNO3wJhsIEBfZAKab
         y3PY98CfsnbUe4L23W57Oi/ETmsjOi8MnYKWUtTocuYWGRixfGGKxV32zVqqVEblHr4R
         14p5vo/EVlfaKFnEBW2lEzL7uzOkyLw8+J/qkGbASvl8UdqyNSQrVAU379/qZsUfihOy
         iNyg==
X-Forwarded-Encrypted: i=1; AJvYcCX32i2moAjkn3k7TPMPYT+Lt+9cWdABRJ8iI/uyKugrMZ6Xvv5MbiB3mHQCTTJJcjIQ3FCafoHNb3kjI5jGOTJGvwO0NcM=
X-Gm-Message-State: AOJu0YwKd1lcDEWb6XKLRcrhPPjYfPP4/NpFIoVovUIhC47WTCthII1y
	pTBD/sJe5Ysiubkv32/uGdrBzkgALgypHfpIiWPxBm4/D4UOeEyhAp68wXS5ub8=
X-Google-Smtp-Source: AGHT+IEgwRKV9JwE1SccNSo0JaXpaHOih6A9ET3LUZTOXD99a4Jq1dI6/XLx3p/8L3bMkmdBqFqAHw==
X-Received: by 2002:a05:6e02:1066:b0:382:774e:a820 with SMTP id e9e14a558f8ab-38a54366279mr62388965ab.0.1720627127323;
        Wed, 10 Jul 2024 08:58:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38a4b870e83sm10117595ab.55.2024.07.10.08.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 08:58:47 -0700 (PDT)
Message-ID: <a3b43a5b-0e32-4ab0-a387-cf58b76525eb@linuxfoundation.org>
Date: Wed, 10 Jul 2024 09:58:46 -0600
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/dma:remove unused variable
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc: chenxiang66@hisilicon.com, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240710065759.5988-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240710065759.5988-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 00:57, Zhu Jun wrote:
> The variable are never referenced in the code, just remove it
> that this problem was discovered by reading code
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/dma/dma_map_benchmark.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
> index 3fcea00961c0..c91b485ca99a 100644
> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
> @@ -33,7 +33,6 @@ int main(int argc, char **argv)
>   	int granule = 1;
>   
>   	int cmd = DMA_MAP_BENCHMARK;
> -	char *p;
>   
>   	while ((opt = getopt(argc, argv, "t:s:n:b:d:x:g:")) != -1) {
>   		switch (opt) {

Applied to linux-kselftest next for Linux 6.11-rc1.

thanks,
-- Shuah
