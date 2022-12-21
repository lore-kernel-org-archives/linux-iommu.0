Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536541FD2
	for <iommu@lists.linux.dev>; Wed, 21 Dec 2022 16:44:48 +0000 (UTC)
Received: by mail-io1-f48.google.com with SMTP id n63so8275872iod.7
        for <iommu@lists.linux.dev>; Wed, 21 Dec 2022 08:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cmw8eXLntCULsyu3Z4jUmMz+7oaxZIPRcoI0xwxZcI0=;
        b=ULaMJxfMJHP+e0ResDGTjcot+9ACqiBWzcBbo7Wk+3NV8TKC4hS/iM4NBzTlJDViOJ
         4oHGh7Ie5B/jAuNydOCj/yNWHOEZDDrCuXODAB9iHcZ9t3A+DCJLSND4Qg27C9jbC8xf
         /oN27n8cJy0T1d5HmqS0pAXEZh54stlBxX6vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cmw8eXLntCULsyu3Z4jUmMz+7oaxZIPRcoI0xwxZcI0=;
        b=lJpf4XE5vTwWBLSDYcvP8fEvWUf5MHMrBbUUhp6hkVtVZyaNxW/kZkgyYGai7lVmSc
         y3DZDTO+Hb5GMhjNXS2xA/Pwp4d40QxsPZgexbUBr37wOMb4TJjzQ+8EiXEa9AcK+D6C
         L70A83fQR70VMN7k5mVPnmG1fgb5MBNivyOGO30SFx4UvVa+zwDcA1s6C4T7LCYN8YyF
         Pm9q/arbV4aHNoOgnExvl3WP9mFhj2LEJDKE+24C9KUaz+7wUpmzC4vvQ65il3kNnGsB
         E9QU0BKSA30DjknRZ+Y8g9YRa/7g2Z7puSXXXR3/7Y/iWMS0CwQ8ApE4WJUAqGiklqT5
         rcgg==
X-Gm-Message-State: AFqh2kr1tSOXbPXNREH15ArJ0VgFfovrtRmZ8HHF8QR78REyNZxq7ViM
	WrdlP9M4lHbT4zpr/M57gcFXdA==
X-Google-Smtp-Source: AMrXdXslzEfD10arj67onobgRm+nyF7tr6gURXtW/cnts8rC6EvRTZwFLHwyesMdVC8XypAdh4tYvQ==
X-Received: by 2002:a6b:d107:0:b0:6e2:d939:4f30 with SMTP id l7-20020a6bd107000000b006e2d9394f30mr324050iob.0.1671641087245;
        Wed, 21 Dec 2022 08:44:47 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a20-20020a056638059400b0038a06a14b37sm5772938jar.103.2022.12.21.08.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 08:44:46 -0800 (PST)
Message-ID: <cdfc618a-5091-8989-7ca2-5d8d467b4adb@linuxfoundation.org>
Date: Wed, 21 Dec 2022 09:44:44 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dma-mapping: benchmark: Fix compile error in user-space
 tool
Content-Language: en-US
To: Gerd Bayer <gbayer@linux.ibm.com>,
 "chenxiang (M)" <chenxiang66@hisilicon.com>, Shuah Khan <shuah@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>
References: <20221205135022.49708-1-gbayer@linux.ibm.com>
 <fd189113-deae-d6b7-bb9a-a5a94f7b0815@hisilicon.com>
 <3193d6833feccc5c2fbdef9b1f71f292eddb8f27.camel@linux.ibm.com>
 <4d8454c5-35d9-13f7-9571-4d38006061e2@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <4d8454c5-35d9-13f7-9571-4d38006061e2@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/21/22 09:39, Shuah Khan wrote:
> On 12/16/22 07:35, Gerd Bayer wrote:
>> On Tue, 2022-12-06 at 11:13 +0800, chenxiang (M) wrote:
>>>
>>> 在 2022/12/5 21:50, Gerd Bayer 写道:
>>>> Since [1] the user-space program dma_map_benchmark shares the
>>>> header file
>>>> linux/map_benchmark.h with the kernel driver in
>>>> kernel/dma/map_benchmark.c.
>>>> With latest kernel version this does not compile any more.
>>>>
>>>> While https://kernelnewbies.org/KernelHeaders suggests otherwise,
>>>> allow it
>>>> to use of kernel headers through the uapi/ include direcotry. I
>>>> assume we can
>>>> do so safely, since the controlling user-space program is
>>>> distributed with
>>>> the kernel.
>>>>
>>>> With this change dma_map_benchmark compiles with just the obvious
>>>> warning
>>>> about uapi usage on ARCH=x86 and s390 and runs on ARCH=s390.
>>>>
>>>> [1] commit 8ddde07a3d28 ("dma-mapping: benchmark: extract a common
>>>> header file for map_benchmark definition")
>>>>
>>>> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
>>>
>>> It also solves the compile error on arm64 platform.
>>> Acked-by:  Xiang Chen <chenxiang66@hisilicon.com>
>>
>> Hi Xiang Chen, hi Shuah,
>>
>> so is there any chance to have this compile fix integrated into linux-
>> next still, or is this too late now?
> Plan to apply this after the merge window closes
> 

The reason for the delay is this patch doesn't have the right commit
header. This should have been "selftests:dma -----"

It makes it easier for maintainers to parse and pay attention to the
patches if they indicate the area they fall under. Something to
keep in mind for your future patches.

Please resend the patch with the Acks you received and a correct
commit header.

thanks,
-- Shuah
