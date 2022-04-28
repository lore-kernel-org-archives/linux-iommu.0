Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7E3C4332F
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 15:54:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8530961080;
	Thu, 28 Apr 2022 15:54:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B7vhMjskG205; Thu, 28 Apr 2022 15:54:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 660C560AFF;
	Thu, 28 Apr 2022 15:54:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38844C0039;
	Thu, 28 Apr 2022 15:54:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0DA9C002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:54:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A857983E6F
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:54:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dQ4HTKECWXty for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 15:54:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BA02A83E6A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:54:39 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id p8so4603862pfh.8
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 08:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=zOz9eswdSnbnlgCE4u1qshAALQqhtjly6s/zYnzoZDo=;
 b=CM62eKY9hR/wJXqj/fSH1DWGMTfmyPZhE42jrqWpTk5Tb5UjPt5F2utBvVAHO90tMY
 3t/ROcUikaw6dA1pndL0nQIZHAWw7CHz2ijI3vAnTb2LOxXel+3BjBnwmEEdvR5slL1r
 x7bKFNpKvom0Vy8PQaUKmxn2OhId2Ft71PWmd51R0Lyv14320aqUgcV+KZDD4AGU0LGc
 f8Qeoi1XC8mKXU8DoC5GD+hiQ5XxLtzd3Ni45nZLjnWgbYk1el+uPGdE9w1GKTgO96W1
 3cFh014HSIYspHjf9ETJZdpmsDQV4A5Z8dp5g0PlTJlj1S58K3vf/i1sySaiR+h5q38Y
 qoiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=zOz9eswdSnbnlgCE4u1qshAALQqhtjly6s/zYnzoZDo=;
 b=hbiMxkdlYSwNyMQYNzSNY4ifRMlagcRztBDTOodFYC14XwNTC+2tiBm0PJ1Owj4RJQ
 w88ttPGTVLmeWb3XUhgivuGuLpj5BIOzD5zICkOBKyEyOLCP454zN11Bu3V/P0PTzmWD
 wKvCglin/vYXOhgPQOiASu+0YUbH6u5ssZ2uADQwO4JWMEZ7b3q/Kko2oNL6kF7xqdIT
 3ZS0kgi72iq6dFrKEVH/j17BQmfoTcCXYDcOVq4txs4+5zg9qf52lMxzUf1LVTMvOglT
 AqcCQxowUc/hpDRgllRxTkTFZah18HO/y2K+3bZO/dZs/Uo2wRENgARALq3MZiZbvOvD
 N+kw==
X-Gm-Message-State: AOAM532ovEZuW/vk6G/keOJuiWJ9c9u3U5HfAD5MlOmeNfdVnrpmMxw3
 MkN41BkCgmQj8WJSrU4odJQ=
X-Google-Smtp-Source: ABdhPJzy1CMlqjk+9uNH6NdqFcYpmSfdQG+AYRCnlMaOyH7EMI9Q+gIoiuOMIk5Wll/bh8zkd0CnAA==
X-Received: by 2002:a63:bd49:0:b0:39d:a2d3:94a2 with SMTP id
 d9-20020a63bd49000000b0039da2d394a2mr28279423pgp.242.1651161278983; 
 Thu, 28 Apr 2022 08:54:38 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::597? ([2404:f801:9000:18:efec::597])
 by smtp.gmail.com with ESMTPSA id
 16-20020a621410000000b0050aca5f79f5sm261023pfu.97.2022.04.28.08.54.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Apr 2022 08:54:38 -0700 (PDT)
Message-ID: <8c390129-4fb3-dd7c-cf83-0451c405d0b9@gmail.com>
Date: Thu, 28 Apr 2022 23:54:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 1/2] swiotlb: Split up single swiotlb lock
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, hch@infradead.org,
 m.szyprowski@samsung.com, michael.h.kelley@microsoft.com, kys@microsoft.com
References: <20220428141429.1637028-1-ltykernel@gmail.com>
 <20220428141429.1637028-2-ltykernel@gmail.com>
 <e7b644f0-6c90-fe99-792d-75c38505dc54@arm.com>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <e7b644f0-6c90-fe99-792d-75c38505dc54@arm.com>
Cc: parri.andrea@gmail.com, thomas.lendacky@amd.com, wei.liu@kernel.org,
 Andi Kleen <ak@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 konrad.wilk@oracle.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, kirill.shutemov@intel.com,
 iommu@lists.linux-foundation.org, andi.kleen@intel.com, brijesh.singh@amd.com,
 vkuznets@redhat.com, hch@lst.de
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

On 4/28/2022 10:44 PM, Robin Murphy wrote:
> On 2022-04-28 15:14, Tianyu Lan wrote:
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> Traditionally swiotlb was not performance critical because it was only
>> used for slow devices. But in some setups, like TDX/SEV confidential
>> guests, all IO has to go through swiotlb. Currently swiotlb only has a
>> single lock. Under high IO load with multiple CPUs this can lead to
>> significat lock contention on the swiotlb lock.
>>
>> This patch splits the swiotlb into individual areas which have their
>> own lock. When there are swiotlb map/allocate request, allocate
>> io tlb buffer from areas averagely and free the allocation back
>> to the associated area. This is to prepare to resolve the overhead
>> of single spinlock among device's queues. Per device may have its
>> own io tlb mem and bounce buffer pool.
>>
>> This idea from Andi Kleen 
>> patch(https://github.com/intel/tdx/commit/4529b578
>> 4c141782c72ec9bd9a92df2b68cb7d45). Rework it and make it may work
>> for individual device's io tlb mem. The device driver may determine
>> area number according to device queue number.
> 
> Rather than introduce this extra level of allocator complexity, how 
> about just dividing up the initial SWIOTLB allocation into multiple 
> io_tlb_mem instances?
> 
> Robin.

Agree. Thanks for suggestion. That will be more generic and will update
in the next version.

Thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
