Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A625FC433EF
	for <iommu@archiver.kernel.org>; Mon,  9 May 2022 11:50:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4465860B0C;
	Mon,  9 May 2022 11:50:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e4GdwC_2Z9Zf; Mon,  9 May 2022 11:50:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1BAB960B06;
	Mon,  9 May 2022 11:50:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02557C0032;
	Mon,  9 May 2022 11:50:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74336C002D
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 11:50:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 619DE4024B
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 11:50:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MmsEdV_uEz7Q for <iommu@lists.linux-foundation.org>;
 Mon,  9 May 2022 11:50:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CD800400C1
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 11:50:01 +0000 (UTC)
Received: by mail-pf1-x42a.google.com with SMTP id a11so12036744pff.1
 for <iommu@lists.linux-foundation.org>; Mon, 09 May 2022 04:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language
 :from:to:cc:references:organization:in-reply-to
 :content-transfer-encoding;
 bh=P8Pt48qpDGet0WO3ZKzHwCy7mbKSUJ/hQ+8osFnMYxw=;
 b=Mz5DtpZT7eJ7E/sQndaERILByLw6Fh8Cb0uCLHC2jqIiIasnF30mUpf/BujTN+KEU7
 wL93G7XaVrUzmUcbOz8Bnira9GvY8g51aHwbtV/gWUgBdISHGEaWFDwwlSPPqMQVnHoi
 RrbtTIMr/jUNj/JjITw8S3tXf1C3iWJcaVdiHnrGDGhWa6fqJ4kVVRIQbIXdCI8Ng6JO
 6jLTLzznBp6t3rREyZFuXByuSAM05e25sLPiVS4HXLrWwlJCIyWjnAS3DkTG93q28CbE
 c9ktfxeVwphxBbcJRqG1yoNTMGFgLyueDnKtbT9B2Tm3F4Fz3UvBOGOQNOHmLIvwwxRq
 qnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:organization:in-reply-to
 :content-transfer-encoding;
 bh=P8Pt48qpDGet0WO3ZKzHwCy7mbKSUJ/hQ+8osFnMYxw=;
 b=SRlYWYVJ2cEB0HtmFeXF70ywJXcc8Ex7LqspxfztUP+PH37vXdJSPnKsfH8SmH2Y0q
 1LLjylavbf/3B4bbnhucNMqbgMZ/MlSfbhHoaQ0xEBPfCTeLRTRx9Fh8e6fG9NkfgDdx
 rDhYPIc7SMBywguKbDf5Tg8VnRnWhuIynHn02jLwvYG6XQ4p+XZJ/LtQ6zVGnseGw35k
 KW5+LUsnteTnOaA5Tlg3Dj36C8bP67DfDjBf+f2eQRwy1iyeZ6+e8yqoVmkLePRUk3OE
 6bN4yEe66Yq2QNQ2q2YKzsbiwl8uPiSClmfLjWqHloySkVrAKnPZFh59DS77jZgLWuZI
 wo7Q==
X-Gm-Message-State: AOAM530TspYEiwENvAkWb8ybiQVVRTxbeau5U1PABCKy3wMAptLLTS1p
 nS+Sh7HPlk8hBHtzuXek1w4=
X-Google-Smtp-Source: ABdhPJyKtWbdfxfuTYbyjipaToniwqfDmdzUjccHsrWp0pbRq7kPVBMCe3+tK5J2L98uV3ZTDaHNUA==
X-Received: by 2002:a62:31c1:0:b0:50a:4909:2691 with SMTP id
 x184-20020a6231c1000000b0050a49092691mr15959938pfx.64.1652097001285; 
 Mon, 09 May 2022 04:50:01 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:6:8000::206? ([2404:f801:9000:18:efed::206])
 by smtp.gmail.com with ESMTPSA id
 b2-20020a056a0002c200b0050dc7628143sm8299420pft.29.2022.05.09.04.49.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 May 2022 04:50:00 -0700 (PDT)
Message-ID: <419605e8-6275-8459-801e-979ea042e5d7@gmail.com>
Date: Mon, 9 May 2022 19:49:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH V2 0/2] swiotlb: Add child io tlb mem support
Content-Language: en-US
From: Tianyu Lan <ltykernel@gmail.com>
To: hch@infradead.org, robin.murphy@arm.com
References: <20220502125436.23607-1-ltykernel@gmail.com>
Organization: Microsft
In-Reply-To: <20220502125436.23607-1-ltykernel@gmail.com>
Cc: parri.andrea@gmail.com, thomas.lendacky@amd.com, wei.liu@kernel.org,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-hyperv@vger.kernel.org,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 kirill.shutemov@intel.com, iommu@lists.linux-foundation.org,
 michael.h.kelley@microsoft.com, andi.kleen@intel.com, brijesh.singh@amd.com,
 vkuznets@redhat.com, kys@microsoft.com, hch@lst.de
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

On 5/2/2022 8:54 PM, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> Traditionally swiotlb was not performance critical because it was only
> used for slow devices. But in some setups, like TDX/SEV confidential
> guests, all IO has to go through swiotlb. Currently swiotlb only has a
> single lock. Under high IO load with multiple CPUs this can lead to
> significant lock contention on the swiotlb lock.
> 
> This patch adds child IO TLB mem support to resolve spinlock overhead
> among device's queues. Each device may allocate IO tlb mem and setup
> child IO TLB mem according to queue number. The number child IO tlb
> mem maybe set up equal with device queue number and this helps to resolve
> swiotlb spinlock overhead among devices and queues.
> 
> Patch 2 introduces IO TLB Block concepts and swiotlb_device_allocate()
> API to allocate per-device swiotlb bounce buffer. The new API Accepts
> queue number as the number of child IO TLB mem to set up device's IO
> TLB mem.

Gentile ping...

Thanks.
> 
> Tianyu Lan (2):
>    swiotlb: Add Child IO TLB mem support
>    Swiotlb: Add device bounce buffer allocation interface
> 
>   include/linux/swiotlb.h |  40 ++++++
>   kernel/dma/swiotlb.c    | 290 ++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 317 insertions(+), 13 deletions(-)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
