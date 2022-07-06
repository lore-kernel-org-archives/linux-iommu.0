Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3316C43334
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 10:21:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 71F3C404BA;
	Wed,  6 Jul 2022 10:21:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 71F3C404BA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=jPknnkWS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WA3pcqq2V70m; Wed,  6 Jul 2022 10:21:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 305214049D;
	Wed,  6 Jul 2022 10:21:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 305214049D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00C41C0033;
	Wed,  6 Jul 2022 10:21:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFC43C002D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 10:21:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AB85660D53
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 10:21:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AB85660D53
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=jPknnkWS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2EQ0woB5IT8h for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 10:21:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1DE5E6059A
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1DE5E6059A
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 10:21:15 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id fz10so8704883pjb.2
 for <iommu@lists.linux-foundation.org>; Wed, 06 Jul 2022 03:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=UzsK5A/Pd2DS/q+pu2TPIXsF74uXoZ2jR8FiWqOBTf0=;
 b=jPknnkWS+HyznwuLvLZ32EFNaMi2kYHUveXX06LBsxWi8WWk54fdGGslOYuaNSzAC1
 +C/+81V/BTWAnyuW8zpzEOQ+3m5kTKePsPyILyW85ZxloaLy8smIa1RrjtcLHK+50AnN
 yH5/1g7GUFT38DXkivHkyB65dBQ5OBuhhzy8EUzkCEJTf3ZiONObArhVTtB/OcViMTCO
 X8KJZBJU4Y7DZ7cizzptUG1IJyL3aKSnpY0xM5e5mg68r1rnl3nGzJWE9g1ZeO/yvMHJ
 7jvS9E7520rHkopiOmyafXJGnjCstN3kCYMy2ZH1/+Y8EfKqhyAZCsV/fFXXHCJrvG+e
 ygDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=UzsK5A/Pd2DS/q+pu2TPIXsF74uXoZ2jR8FiWqOBTf0=;
 b=XsiIY80R64ymjr1+Nl8KlnNicY6ClCsjpgsckgdPshKbd4VxQLwGlljFKZOpmtw/s7
 SD9a6sE0edB6FUXXka1U0WAI5Szr2MCjKQvUnbD+y1HNWs70eP0uMK3gz90lXEWP+tKj
 Lz/chFc2j/9ar1LK3pvC/AkY2YZeFHPJRjXrk0FteUXqUdnx1/l01bk2qVdGbHtoUJRM
 Yy/huFkJn2EiKoWRJpT3IE2wWkHaALbt6pE3p9zuNflr4oLd3OYQNxdRz1y+GIGdxWbe
 3Ch1eGLQzpm/aXUSBd2FDp6B7Iw/fWpmjJlEzUFNcyNJUKFTwLAA6bBeiEh/UPJBzOJa
 Q2Qg==
X-Gm-Message-State: AJIora+un59BQZ8V4eF5W9/RKwqlOp8m99PIq7tBElHljlER/TEKCOUt
 GiHjIH8+iGo4DvdjovL0vvA=
X-Google-Smtp-Source: AGRyM1u62ff8Zjp/L+wMPt2MQjdQjkuAxTYu9AnfGkSn1v7kxGjrvXqT5UyLr/SkNP7QrlRhVQcR8g==
X-Received: by 2002:a17:90a:c7cc:b0:1ef:775e:8df1 with SMTP id
 gf12-20020a17090ac7cc00b001ef775e8df1mr26574178pjb.28.1657102874543; 
 Wed, 06 Jul 2022 03:21:14 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
 by smtp.gmail.com with ESMTPSA id
 w21-20020a656955000000b0041282c423e6sm2085990pgq.71.2022.07.06.03.21.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Jul 2022 03:21:13 -0700 (PDT)
Message-ID: <71242da1-8a7a-53ca-06d6-7a1363141bd8@gmail.com>
Date: Wed, 6 Jul 2022 18:21:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] x86/ACPI: Set swiotlb area according to the number of
 lapic entry in MADT
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
References: <20220627153150.106995-1-ltykernel@gmail.com>
 <20220627153150.106995-3-ltykernel@gmail.com>
 <YrxcCZKvFYjxLf9n@infradead.org>
 <a876f862-c005-108d-e6f9-68336a8d89f0@gmail.com>
 <YsVBKgxiQKfnCjvn@infradead.org>
 <10062b7d-f0a6-6724-4ccb-506da09a8533@gmail.com>
 <YsVPwYGHUoctAKjs@infradead.org>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <YsVPwYGHUoctAKjs@infradead.org>
Cc: linux-hyperv@vger.kernel.org, rafael@kernel.org,
 dave.hansen@linux.intel.com, pavel@ucw.cz, hpa@zytor.com, kys@microsoft.com,
 wei.liu@kernel.org, Andi Kleen <ak@linux.intel.com>, corbet@lwn.net,
 damien.lemoal@opensource.wdc.com, x86@kernel.org,
 michael.h.kelley@microsoft.com, mingo@redhat.com, andi.kleen@intel.com,
 parri.andrea@gmail.com, len.brown@intel.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, keescook@chromium.org,
 paulmck@kernel.org, linux-pm@vger.kernel.org, kirill.shutemov@intel.com,
 bp@alien8.de, songmuchun@bytedance.com, tglx@linutronix.de,
 vkuznets@redhat.com, rdunlap@infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thomas.lendacky@amd.com, akpm@linux-foundation.org, robin.murphy@arm.com
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

On 7/6/2022 5:02 PM, Christoph Hellwig wrote:
> On Wed, Jul 06, 2022 at 04:57:33PM +0800, Tianyu Lan wrote:
>> Swiotlb_init() is called in the mem_init() of different architects and
>> memblock free pages are released to the buddy allocator just after
>> calling swiotlb_init() via memblock_free_all().
> 
> Yes.
> 
>> The mem_init() is called before smp_init().
> 
> But why would that matter?  cpu_possible_map is set up from
> setup_arch(), which is called before that.

Sorry. I just still focus online cpu number and the number is got after
smp_init(). Possible cpu number includes some offline cpus. I will have 
a try. Thanks for suggestion.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
