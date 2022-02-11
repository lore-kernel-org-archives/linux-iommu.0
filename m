Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37181C433F5
	for <iommu@archiver.kernel.org>; Fri, 11 Feb 2022 17:12:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7EC1416BE;
	Fri, 11 Feb 2022 17:12:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TLzwvBLes3FV; Fri, 11 Feb 2022 17:12:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AC321401FA;
	Fri, 11 Feb 2022 17:12:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D72DC001A;
	Fri, 11 Feb 2022 17:12:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20DD9C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 17:12:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E8FF401AD
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 17:12:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JtT9XV_pAyho for <iommu@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 17:11:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 184E5400A6
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 17:11:58 +0000 (UTC)
Received: by mail-il1-x131.google.com with SMTP id o10so7400551ilh.0
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 09:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zjkXwvtCBDId5CtC4jr5PHJd1ckKx2uKu+NSVsZGKoU=;
 b=dReCiEKgX9kIOa267yo4luUrFq2PdntGD/NuFxdqnAErdYhsQzIpRqQfeIawfY/8FI
 Vbj/1gorL0l3SE73ULO+qVu1Z9KYe0T1BlAddLSExUCPv9m6QtJK1EIhMlixBaKDMnX2
 EQY7b6M2ZpxEvwRRIXJ70DpWvA4HvRUiOu1Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zjkXwvtCBDId5CtC4jr5PHJd1ckKx2uKu+NSVsZGKoU=;
 b=nTBSznNEDTo5ocffxiobf+wFXFsnM3TqCbuv339cm2auevpeh9onNBtShtq32QO50T
 vEYX7/J2kVuMZxoCBLWGXV8c0YpFpsYWJMi+CVhCJPjIPoncSSTkWtRwXQSmC+SeB1Op
 zkQWJ925dSRvk/kjLbvVNtFx1XyvGqL/551VlmvPX4NQuaRe7UI5Fglw1f6DiRUNtj9Z
 lTJx9CEHSrxazhpOlgzN/h+KKI7TG6XxwFCwaxucRB/Wrlx1x+Gi5EulwxUkhEcTCRnQ
 f3mqd5kWMr6wrDcaQ3fDKY3bqv4i04vBe7MK73136VeJ+k4iDq9nao24BmQ4U2egHc9f
 x+Nw==
X-Gm-Message-State: AOAM5317joDgbbOMjdFy23OTjioUJ/wfFrHn2I9n2VzZG+e1c1ecuzQU
 3yGAQdZ1T0ybsGHhRR03TpACcnZq
X-Google-Smtp-Source: ABdhPJy2keANu+GgfebUDtlUmddy8XYQuxvuMxp/ogCEVf9YPKwhW+PnqNnYu4a+JgLRJis//PxEMA==
X-Received: by 2002:a05:6e02:b25:: with SMTP id
 e5mr1385991ilu.125.1644599518163; 
 Fri, 11 Feb 2022 09:11:58 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
 by smtp.gmail.com with ESMTPSA id s10sm12724274ild.84.2022.02.11.09.11.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Feb 2022 09:11:57 -0800 (PST)
Subject: Re: [PATCH] dma-mapping: benchmark: Extract a common header file for
 map_benchmark definition
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
 "tiantao (H)" <tiantao6@hisilicon.com>, "shuah@kernel.org"
 <shuah@kernel.org>, "chenxiang (M)" <chenxiang66@hisilicon.com>,
 "hch@lst.de" <hch@lst.de>
References: <20220211031441.41126-1-tiantao6@hisilicon.com>
 <d3dd5f61efcb41c981b0971e128da907@hisilicon.com>
From: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <39bd03ff-d083-5f81-d7d0-f40043cc47a5@linuxfoundation.org>
Date: Fri, 11 Feb 2022 10:11:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <d3dd5f61efcb41c981b0971e128da907@hisilicon.com>
Content-Language: en-US
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2/10/22 9:22 PM, Song Bao Hua (Barry Song) wrote:
> 
> 
>> -----Original Message-----
>> From: tiantao (H)
>> Sent: Friday, February 11, 2022 4:15 PM
>> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; shuah@kernel.org;
>> chenxiang (M) <chenxiang66@hisilicon.com>
>> Cc: iommu@lists.linux-foundation.org; linux-kselftest@vger.kernel.org;
>> linuxarm@openeuler.org
>> Subject: [PATCH] dma-mapping: benchmark: Extract a common header file for
>> map_benchmark definition
>>
>> kernel/dma/map_benchmark.c and selftests/dma/dma_map_benchmark.c
>> have duplicate map_benchmark definitions, which tends to lead to
>> inconsistent changes to map_benchmark on both sides, extract a
>> common header file to avoid this problem.
>>
>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> 
> +To: Christoph
> 
> Looks like a right cleanup. This will help decrease the maintain
> overhead in the future. Other similar selftests tools are also
> doing this.
> 
> Acked-by: Barry Song <song.bao.hua@hisilicon.com>
> 

+1 on this cleanup making this code maintainable. We are moving in
the direction of cleaning up defines in selftests for the same
reason.

Let's just make sure this works on older kernels. We do support
mainline kselftest on stable releases. With that:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
