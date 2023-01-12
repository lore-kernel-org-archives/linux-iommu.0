Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098862105
	for <iommu@lists.linux.dev>; Thu, 12 Jan 2023 20:36:55 +0000 (UTC)
Received: by mail-il1-f176.google.com with SMTP id u8so9953722ilg.0
        for <iommu@lists.linux.dev>; Thu, 12 Jan 2023 12:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KeK4mXHfx2/sVPkcx7rO2e+6I+Iv6ezw8FJDgQnyG3M=;
        b=btgsd0yjxZ05R/XKk+8ZYp1ZdSw6JrCgpdhvOMXtXv4gMW97uCzkA80hSlizvH9pd3
         JVlZ/78KjZ1S0kECoKY/YQeXeEDdACgWj9W8JG/r7SkU0dObYdcfZAaHQzT0JCjccSE2
         Znq00aRYtAvlJ+udUIjoYGhMt3YwrHPUjKZzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KeK4mXHfx2/sVPkcx7rO2e+6I+Iv6ezw8FJDgQnyG3M=;
        b=0LPs0ikwXcrekgwRbm415O55Yt5pEdVxDqpA7P5mTxtFv2I0y0ioWCkGFo3l1MO2oM
         3HwxCl1imkLvl443Va08RsYPTyXsW7w5x475Gdn07alNM2RP6lrDBCnqUvR+sMGAnHlk
         N28677yT4ddbxY8CC4JwLVxVA4mBfDIooKdo6PlikvQJf3+oPp3nrox8X3PrGiem2IQC
         aZmIt8InuVPqFuNubFVAl5O6OVZmlYmcTkALs3PxTAHQWHuySFhgp9Xs6fHtYzChsqPr
         OBRNmPl+O3nT4dxsfEAqWSwxn9ojxqHU5XWN+dKyME9Z2xxmbhUNMcSouQ/B/WvR7Nd9
         uryw==
X-Gm-Message-State: AFqh2koyvTDj+V9t0wVsgd5LNEjOMEwwB8TPI74dQjcD4q8yzUanxra7
	VmD2V2f2sySj15p9+29uRka5bw==
X-Google-Smtp-Source: AMrXdXvLIALi+VAlQRvBFU39GylrVZ7tLSlS73fZH9+4b89AHb9Pq5xgaqT+TZU+au9GwpgKslLcVw==
X-Received: by 2002:a05:6e02:20e7:b0:30d:9eea:e51 with SMTP id q7-20020a056e0220e700b0030d9eea0e51mr4163579ilv.1.1673555814974;
        Thu, 12 Jan 2023 12:36:54 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t17-20020a92c911000000b002fa9a1fc421sm5418532ilp.45.2023.01.12.12.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 12:36:54 -0800 (PST)
Message-ID: <a01b5643-3373-d5a0-a3d7-4fa845725dbd@linuxfoundation.org>
Date: Thu, 12 Jan 2023 13:36:53 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] selftests:dma: Fix compile error in user-space tool
Content-Language: en-US
To: Gerd Bayer <gbayer@linux.ibm.com>, Xiang Chen
 <chenxiang66@hisilicon.com>, Shuah Khan <shuah@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20230109180721.187324-1-gbayer@linux.ibm.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230109180721.187324-1-gbayer@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/23 11:07, Gerd Bayer wrote:
> Since [1] the user-space program dma_map_benchmark shares the header file
> linux/map_benchmark.h with the kernel driver in kernel/dma/map_benchmark.c.
> With latest kernel version this does not compile anymore.
> 
> While https://kernelnewbies.org/KernelHeaders suggests otherwise, allow it
> to use kernel headers through the uapi/ include directory. I assume we can
> do so safely, since the controlling user-space program is distributed with
> the kernel.
> 
> With this change dma_map_benchmark compiles with just the obvious warning
> about uapi usage on ARCH=x86, arm64, and s390 and runs on ARCH=s390.
> 
> [1] commit 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header
> file for map_benchmark definition")
> 
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> Acked-by: Xiang Chen <chenxiang66@hisilicon.com>
> ---
>   tools/testing/selftests/dma/dma_map_benchmark.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
> index 5c997f17fcbd..d49d7ea6a63e 100644
> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
> @@ -10,7 +10,7 @@
>   #include <unistd.h>
>   #include <sys/ioctl.h>
>   #include <sys/mman.h>
> -#include <linux/types.h>
> +#include <uapi/linux/types.h>
>   #include <linux/map_benchmark.h>
>   
>   #define NSEC_PER_MSEC	1000000L
> 
> base-commit: 1fe4fd6f5cad346e598593af36caeadc4f5d4fa9

On Linux 6.2-rc3, dma_map_benchmark compiles just fine. You do
have to do "make headers_install" first as kselftest depends
on headers being installed in the repo.

Please let me know if you are seeing compile problems even after
installing headers.

thanks,
-- Shuah


