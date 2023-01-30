Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69323569C
	for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 17:01:26 +0000 (UTC)
Received: by mail-io1-f53.google.com with SMTP id y2so1160004iot.4
        for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 09:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tjmaj2MJCcTKHXMncTm7aW6k5LVjR/lC5G4E9cb48UE=;
        b=MNZNEZdmQX7+K0QS12v4RgLYh5FQYC0W9kg6t7wWU9EEDC+KAVWIDekE01y0fpkgBA
         zWEayL2RynNTe0UNuNtaiAA93AfafwBJXsIEfmp8/3lZAyAdOSchhGZkJm2ER/yv9WtJ
         goDVzc/c83wSyg2wtfEZmBqTQ/E2F4j7oBlu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tjmaj2MJCcTKHXMncTm7aW6k5LVjR/lC5G4E9cb48UE=;
        b=iumGW0g9CaXhcB55CGD74uyl1g2+WjpQtanJzhIaseHyVrlpePBiMYH6IDfa8mFaQD
         ITekOqCC9FIwPZfKekid9+Jjay9BqBBYbiQFLzv2YGZWCV5h+mcNcWh6OxwzlidQeQi9
         IbZyOGt0GDcjANq6kkQmFC1fiv3iHjS3Le4cFF4mMV5NmnM3yZMvddJznAHXvc1RuqFv
         DI23mlkW5TN52Cv80kW3NPfR+Ip7BanjhjA/0vGmhIq6S3GACEm2Lk7P90WXJ7WmbmjL
         WOBV3/UefDYnKkLCKU/qF5odqQQPztfDUrAqQ6a+WyCO2x5UlRCM0NYzYIL2Yzzs+TMO
         Np6A==
X-Gm-Message-State: AO0yUKWosSb0Kcaf93BS7FYREJXVE34kRgz64EcyqoT+YcLLHfBXnkal
	lciv3rRPW2Qs4rkiq83ts33G3A==
X-Google-Smtp-Source: AK7set/m9LOt7r7IU303XDwjQdWiXMRNjNB7JM1ZXoUQuMCKkmegQdTBjoVaQwpZ9WFYYV6Ttbh6MA==
X-Received: by 2002:a5e:dc04:0:b0:718:2903:780f with SMTP id b4-20020a5edc04000000b007182903780fmr1282486iok.2.1675098085362;
        Mon, 30 Jan 2023 09:01:25 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id w24-20020a6bf018000000b0071c89dbc77bsm1209271ioc.43.2023.01.30.09.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 09:01:24 -0800 (PST)
Message-ID: <a0dbbe49-ee6d-7e69-a472-5dc76d3e2c14@linuxfoundation.org>
Date: Mon, 30 Jan 2023 10:01:23 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 31/34] selftests: iommu: Use installed kernel headers
 search path
Content-Language: en-US
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
 <20230127135755.79929-32-mathieu.desnoyers@efficios.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230127135755.79929-32-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/27/23 06:57, Mathieu Desnoyers wrote:
> Use $(KHDR_INCLUDES) as lookup path for installed kernel headers rather
> than using kernel headers in include/uapi from the source kernel tree
> kernel headers.
> 
> Remove bogus ../../../../include/ from the search path, because
> kernel source headers are not needed by those user-space selftests, and
> it causes issues because -I paths are searched before -isystem paths,
> and conflicts for files appearing both in kernel sources and in uapi
> headers with incompatible semantics (e.g. types.h).
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: Ingo Molnar <mingo@redhat.com>
> ---
>   tools/testing/selftests/iommu/Makefile | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
> index 7cb74d26f141..32c5fdfd0eef 100644
> --- a/tools/testing/selftests/iommu/Makefile
> +++ b/tools/testing/selftests/iommu/Makefile
> @@ -1,7 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   CFLAGS += -Wall -O2 -Wno-unused-function
> -CFLAGS += -I../../../../include/uapi/
> -CFLAGS += -I../../../../include/
> +CFLAGS += $(KHDR_INCLUDES)
>   
>   CFLAGS += -D_GNU_SOURCE
>   

Adding iommu test maintainers:

I plan to take this through kselftest unless there are conflicts.
In case there are conflicts and you want to take this through yours

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
