Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFE5C433EF
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 14:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6DF981A1C;
	Tue,  1 Mar 2022 14:01:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p4uxjU60FYyn; Tue,  1 Mar 2022 14:01:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8070181426;
	Tue,  1 Mar 2022 14:01:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A573C0077;
	Tue,  1 Mar 2022 14:01:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DEBDC001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 14:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D07B4044D
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 14:01:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JRwXsKFMxItn for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 14:01:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 89EC64019E
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 14:01:38 +0000 (UTC)
Received: by mail-pg1-x52a.google.com with SMTP id o8so14466472pgf.9
 for <iommu@lists.linux-foundation.org>; Tue, 01 Mar 2022 06:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=F/G/xOe5a6nu2fkfw8uYGgqkNpKpcFX9OCeRV8lAMEA=;
 b=M/WZf0dAladje4iv4F/hGYw9kuGhDb1eMm48tQLJEnoRzblIt/aaanhWYp0t9h/V3M
 SuaN66brC8T6KHk+R352mSC/VcYpyj2kjP8Ez3Pql0l0SR3cJnKqcNDtz3DeI3ap70EY
 Dw9fSmqgFY6SnfEnzJTOVO/8sM7qM+TG8qri/2MqjQvfLBNT2Eg+xxxc18Rs2QnPbwVe
 nyT3fQITL+d+iJXkZ/aLWAK6khTJABVSLpet4naIZNrsJC8rk6DSCLvu0OE0mcsJNfqz
 q5Wv//Jl1c/DV9aXHGm0x0OOLuU9+/G4Z6Paou3BJS59ZU0TiD78jiaA9ZFpmpiSMOk6
 /JDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=F/G/xOe5a6nu2fkfw8uYGgqkNpKpcFX9OCeRV8lAMEA=;
 b=slpo870ogpsyPPbBdyuZ+9xI4nW+KPWykFHpIlMKll/SMpC99X8v/kILQ6ytGu12gb
 zdLoLG0sXfS7TmZFhpNVDOI3y6Imz2KM/sddJ4moUBOsaQm94RDpweHKqinTIynCO9zE
 UFWB6+5UW3iSpOvFbTj5qOMnIHAKE70dP86rrwGLvUfUmc5saw/RX7HwLCh8YNRXI6VD
 cXslh/RLkubDie/K10k6c89l6JOfOSaMX7/MmI96SKeMitbxuw5i5s9DmyhhIxNRm3ki
 lmyDk16zxDDY3h7VnMYARUuolDeJxQM3CfObQ3N7QAWfXoshqt0qUDkZ/5Yp0bXL9cPy
 rcyA==
X-Gm-Message-State: AOAM533BAy515oLHqzLfkkkyX/ZI9sfHcf478tEQzbZrO0w3OQK+PINQ
 H57BUu0iyt7a0AIJrNyTMPM=
X-Google-Smtp-Source: ABdhPJxvTIlnU3gMQxETAVp/xnqA49sq44Qij7ZknsOWr166EOYo94ZbcpGEHGEGivB+qWQ6chrIaQ==
X-Received: by 2002:a63:b06:0:b0:374:5e1a:150a with SMTP id
 6-20020a630b06000000b003745e1a150amr21702994pgl.137.1646143297904; 
 Tue, 01 Mar 2022 06:01:37 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::754? ([2404:f801:9000:18:efec::754])
 by smtp.gmail.com with ESMTPSA id
 v14-20020a056a00148e00b004e1cee6f6b4sm17730734pfu.47.2022.03.01.06.01.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Mar 2022 06:01:37 -0800 (PST)
Message-ID: <f76c15c5-9ee4-a825-73c8-223564a26d74@gmail.com>
Date: Tue, 1 Mar 2022 22:01:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V2 1/2] Swiotlb: Add swiotlb_alloc_from_low_pages switch
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20220214081919.GA18337@lst.de>
 <4f433f07-05be-f81f-43e8-55c3f1af23b3@gmail.com>
 <20220214135834.GA30150@lst.de>
 <8d052867-ccff-f00f-7c89-cc26a4bfa347@gmail.com>
 <23f4a64d-5977-1816-8faa-fe7691ace2ff@gmail.com>
 <20220222080543.GA5412@lst.de>
 <00112505-4999-ac41-877e-49c4cc45312e@gmail.com>
 <20220222160039.GA13380@lst.de>
 <40f91949-58fa-4be2-5b01-ea34dda58670@gmail.com>
 <a80a7efa-f15d-3649-f39f-c24820f9ef2b@gmail.com>
 <20220301115340.GA3077@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20220301115340.GA3077@lst.de>
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 dave.hansen@linux.intel.com, hpa@zytor.com, kys@microsoft.com,
 wei.liu@kernel.org, Andi Kleen <ak@linux.intel.com>, sthemmin@microsoft.com,
 x86@kernel.org, decui@microsoft.com, michael.h.kelley@microsoft.com,
 mingo@redhat.com, parri.andrea@gmail.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de,
 "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, robin.murphy@arm.com,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
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

On 3/1/2022 7:53 PM, Christoph Hellwig wrote:
> On Fri, Feb 25, 2022 at 10:28:54PM +0800, Tianyu Lan wrote:
>>       One more perspective is that one device may have multiple queues and
>> each queues should have independent swiotlb bounce buffer to avoid spin
>> lock overhead. The number of queues is only available in the device
>> driver. This means new API needs to be called in the device driver
>> according to queue number.
> 
> Well, given how hell bent people are on bounce buffering we might
> need some scalability work there anyway.

According to my test on the local machine with two VMs, Linux guest 
without swiotlb bounce buffer or with the fix patch from Andi Kleen can
achieve about 40G/s throughput but it's just 24-25G/s with current 
swiotlb code. Otherwise, the spinlock contention also consumes more cpu 
usage.





_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
