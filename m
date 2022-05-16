Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCFBC433F5
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 13:09:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6DFC640B4C;
	Mon, 16 May 2022 13:09:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wQCn9ivYyErk; Mon, 16 May 2022 13:09:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5A48340B44;
	Mon, 16 May 2022 13:09:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B3F6C0032;
	Mon, 16 May 2022 13:09:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03688C002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 13:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE97B40B44
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 13:09:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cIQU1IwmaMZH for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 13:09:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B653540465
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 13:09:06 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id g184so14059245pgc.1
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 06:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:reply-to:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=hhS13NV1du4/5RVMnn0KKcWVRMzgQIx1d7kjkoctpig=;
 b=dqff7cEf+YiKcmpwvNHD98s9Y/gznpGA1n0UHShTOIF3V276B2JTqhQx62EHWto6Na
 xlKvL+P4npCqLCAegGKQ3FS+rLpmko+BwMvn7n7lj72p8KeYb3ZQmz1YKYU2IR0yPnDH
 KRELbnohr2g5t0EdQnYkhgRaXNRU/ZgmtM+BrNSFtLCKLOWqSiXKggCLNUBvoPdLJcBE
 9yP7JlJVBM5rPQM0yOV8kqj4U4zCHkVT9mvKvfvhfvWmU2GQwY2dvyTESAYdT38dKpJW
 whanVpLF8jEGJqgaFIqkTaUg3sdKBBBKYtLguWa6zwHNzvGIU+a08GpAer4TE+DI8hNS
 uKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
 :subject:content-language:to:cc:references:from:organization
 :in-reply-to:content-transfer-encoding;
 bh=hhS13NV1du4/5RVMnn0KKcWVRMzgQIx1d7kjkoctpig=;
 b=HFxixhybqX6DtRKbWYRO9kbctOD9SNaNSXVHSTiLE9FaKDZKAaGRpMlB7cbvPjEPtm
 Oey8M5UTD5a9pYrZVi9DBA5l0TRjsKeFxcOlcNVgxoFdrcBZzo2PqcHC1EyiDyMrV/gV
 bh+WIi0idMyvavo6RkmSfdYKdXfNGHTrTF68PoAlvekCdgbYJge6SA7Hdw0PDLGAPgBI
 Vi2pMuEx5YUWTNWFBHRzOJArH3Gjoy3bV783V43zjUU40qWQ4IvHR52D2g9pXDgpMquE
 Wm8HohJoFp9j1L74wYewD1YLn/R9kJ3GHweZtMm1y2vnexUhnV8/WFeZWkinVUrBQV+W
 79/w==
X-Gm-Message-State: AOAM531y04si0kT79TXW6k04BpVEr6vwVKUFIDT9IvyxL4vBAUXBi5iL
 77y/D/sZ6Fu0UX08wYxrWu8=
X-Google-Smtp-Source: ABdhPJy5OzuugvWNhSWVWfm3wmq6awyPhqi3qnfEcfsdsTuOnu5O0udXQ9MhGMXCLG+FQx4ZyJQnQQ==
X-Received: by 2002:a63:1645:0:b0:3c2:4706:f62b with SMTP id
 5-20020a631645000000b003c24706f62bmr15556314pgw.11.1652706546139; 
 Mon, 16 May 2022 06:09:06 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::597? ([2404:f801:9000:18:efec::597])
 by smtp.gmail.com with ESMTPSA id
 ju10-20020a17090b20ca00b001df313f6628sm3135246pjb.21.2022.05.16.06.09.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 May 2022 06:09:05 -0700 (PDT)
Message-ID: <ad2f9bcb-1aa7-0a35-942f-6a5f674823fe@gmail.com>
Date: Mon, 16 May 2022 21:08:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH V2 1/2] swiotlb: Add Child IO TLB mem support
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
References: <20220502125436.23607-1-ltykernel@gmail.com>
 <20220502125436.23607-2-ltykernel@gmail.com> <YoH+mbxQAp/2XGyG@infradead.org>
From: Tianyu Lan <ltykernel@gmail.com>
Organization: Microsft
In-Reply-To: <YoH+mbxQAp/2XGyG@infradead.org>
Cc: parri.andrea@gmail.com, thomas.lendacky@amd.com, wei.liu@kernel.org,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-hyperv@vger.kernel.org,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 michael.h.kelley@microsoft.com, iommu@lists.linux-foundation.org,
 kirill.shutemov@intel.com, andi.kleen@intel.com, brijesh.singh@amd.com,
 vkuznets@redhat.com, kys@microsoft.com, robin.murphy@arm.com, hch@lst.de
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
Reply-To: tiala@microsoft.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 5/16/2022 3:34 PM, Christoph Hellwig wrote:
> I don't really understand how 'childs' fit in here.  The code also
> doesn't seem to be usable without patch 2 and a caller of the
> new functions added in patch 2, so it is rather impossible to review.

Hi Christoph:
      OK. I will merge two patches and add a caller patch. The motivation
is to avoid global spin lock when devices use swiotlb bounce buffer and
this introduces overhead during high throughput cases. In my test
environment, current code can achieve about 24Gb/s network throughput
with SWIOTLB force enabled and it can achieve about 40Gb/s without
SWIOTLB force. Storage also has the same issue.
      Per-device IO TLB mem may resolve global spin lock issue among
devices but device still may have multi queues. Multi queues still need
to share one spin lock. This is why introduce child or IO tlb areas in
the previous patches. Each device queues will have separate child IO TLB
mem and single spin lock to manage their IO TLB buffers.
      Otherwise, global spin lock still cost cpu usage during high 
throughput even when there is performance regression. Each device queues 
needs to spin on the different cpus to acquire the global lock. Child IO
TLB mem also may resolve the cpu issue.

> 
> Also:
> 
>   1) why is SEV/TDX so different from other cases that need bounce
>      buffering to treat it different and we can't work on a general
>      scalability improvement

	Other cases also have global spin lock issue but it depends on
         whether hits the bottleneck. The cpu usage issue may be ignored.

>   2) per previous discussions at how swiotlb itself works, it is
>      clear that another option is to just make pages we DMA to
>      shared with the hypervisor.  Why don't we try that at least
>      for larger I/O?

	For confidential VM(Both TDX and SEV), we need to use bounce
	buffer to copy between private memory that hypervisor can't
	access directly and shared memory. For security consideration,
	confidential VM	should not share IO stack DMA pages with
        	hypervisor directly to avoid attack from hypervisor when IO
	stack handles the DMA data.
	
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
