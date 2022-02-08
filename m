Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BD5C4332F
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 14:19:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B202160ED9;
	Tue,  8 Feb 2022 14:19:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eVuA5zkdVauH; Tue,  8 Feb 2022 14:19:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8430B607B0;
	Tue,  8 Feb 2022 14:19:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43BC7C001A;
	Tue,  8 Feb 2022 14:19:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A504DC000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 14:19:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F1D781B23
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 14:19:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wtymNg1yJ12A for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 14:19:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 086A781B7B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 14:19:28 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id qe15so6904139pjb.3
 for <iommu@lists.linux-foundation.org>; Tue, 08 Feb 2022 06:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=wxTG+XyoVyvm3qwt67A3uD8d+hQFZ2NnOQ/flBE0K98=;
 b=Dcro/51npE6vWkDlp954rF9hqbFflacWu4JiIGGktclCeAmxm93szVWwkjci8bhdFJ
 36QJEAczLxpsK0jwHsOuPvdjL2WToJgY8N6aGnUP+w9Gj9WgMP5r0XsFE9yIv4NdnMlu
 qfYKz8q0A1LMRLC/dRdGUw94ANm9VgfZC+Ljakagf8CsKcv5Occ3rxLsAfjrGm5Uy37D
 8lAMM00gBwsDDMrFyNMhI0YpEesWLlk2gvmGPe4Dpra7S+uucD57GJ1CAmsaN5RruBio
 nabdG4q6UQb6hkdxr08YJY9bZObUVDCuO/tlaF1Q2MuUGuo1A8N5HpVqWPXRQDqMcRkJ
 f2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=wxTG+XyoVyvm3qwt67A3uD8d+hQFZ2NnOQ/flBE0K98=;
 b=MiLoa5tV+Qwgs2P1An6PHCqoLU1Et111hvwo4MznLFyyG3HxfYZwNxVCsu5Jt3nOOv
 x4s2/TR8DhaUUaWfog9gXJw9FopigYr4+tSi2McQe9wvtVcGb0OzkEiCnjH1AINXlxW6
 6d9dBiMoSGRN808spJlFj0tpsba5nrK+IRfCFfkYuAzbvrAL29Va6gJQkJTHXb+/epv6
 8s+VqtsdfaO+Cx+U69KlDo6maJ1T8ct5D/6HUAIswpNzgUeTgnuzHYJWJl+ICV/3v9h7
 o8BIKMW1Hpwely7lBK8J53nqHOkVsylTzNblBaFVJCs00co4OfJQKCLvEQfEfzeCwSVj
 ohvg==
X-Gm-Message-State: AOAM532YPj8DmnIVyoyjvSzSlA9RFeY6tOTgtbnvxIt0BBU5rmqevJ5M
 L+InKmH7PFxARYZfkH7k3LI=
X-Google-Smtp-Source: ABdhPJz67xSgge/ra2Q7eUO/CH9AuwGGYdwz22g+8hA50Wkv9TgPYjVaIUTlf8RdSMiEj29u5mBg6A==
X-Received: by 2002:a17:903:120e:: with SMTP id
 l14mr4691979plh.124.1644329968221; 
 Tue, 08 Feb 2022 06:19:28 -0800 (PST)
Received: from ?IPV6:2404:f801:10:102:8000::f381? ([2404:f801:8050:1:c1::f381])
 by smtp.gmail.com with ESMTPSA id f15sm16713478pfv.189.2022.02.08.06.19.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Feb 2022 06:19:27 -0800 (PST)
Message-ID: <6ee926b0-5579-bb9b-da94-51d793a3d782@gmail.com>
Date: Tue, 8 Feb 2022 22:19:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] Netvsc: Call hv_unmap_memory() in the
 netvsc_device_remove()
Content-Language: en-US
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "hch@infradead.org"
 <hch@infradead.org>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20220201163211.467423-1-ltykernel@gmail.com>
 <MWHPR21MB15935F58E55D05A171AE9ED4D7279@MWHPR21MB1593.namprd21.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <MWHPR21MB15935F58E55D05A171AE9ED4D7279@MWHPR21MB1593.namprd21.prod.outlook.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On 2/3/2022 1:05 AM, Michael Kelley (LINUX) wrote:
> From: Tianyu Lan<ltykernel@gmail.com>  Sent: Tuesday, February 1, 2022 8:32 AM
>> netvsc_device_remove() calls vunmap() inside which should not be
>> called in the interrupt context. Current code calls hv_unmap_memory()
>> in the free_netvsc_device() which is rcu callback and maybe called
>> in the interrupt context. This will trigger BUG_ON(in_interrupt())
>> in the vunmap(). Fix it via moving hv_unmap_memory() to netvsc_device_
>> remove().
> I think this change can fail to call hv_unmap_memory() in an error case.
> 
> If netvsc_init_buf() fails after hv_map_memory() succeeds for the receive
> buffer or for the send buffer, no corresponding hv_unmap_memory() will
> be done.  The failure in netvsc_init_buf() will cause netvsc_connect_vsp()
> to fail, so netvsc_add_device() will "goto close" where free_netvsc_device()
> will be called.  But free_netvsc_device() no longer calls hv_unmap_memory(),
> so it won't ever happen.   netvsc_device_remove() is never called in this case
> because netvsc_add_device() failed.
> 

Hi Michael:
       Thanks for your review. Nice catch and will fix in the next
version.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
