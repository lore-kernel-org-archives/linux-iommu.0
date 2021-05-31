Return-Path: <SRS0=AF0h=K2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3545AC47082
	for <iommu@archiver.kernel.org>; Mon, 31 May 2021 04:08:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2756611EE
	for <iommu@archiver.kernel.org>; Mon, 31 May 2021 04:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2756611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 87C78401C0;
	Mon, 31 May 2021 04:08:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2k9X9f0bFeNU; Mon, 31 May 2021 04:08:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 77F0E40185;
	Mon, 31 May 2021 04:08:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4259AC000D;
	Mon, 31 May 2021 04:08:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE46FC0001
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 04:08:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9EEB16090C
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 04:08:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G4oF_r4ryEgW for <iommu@lists.linux-foundation.org>;
 Mon, 31 May 2021 04:08:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 02048608FA
 for <iommu@lists.linux-foundation.org>; Mon, 31 May 2021 04:08:35 +0000 (UTC)
Received: by mail-pf1-x42c.google.com with SMTP id 22so8030369pfv.11
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 21:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=B5E+Z+YC3ztWK1Gz5JJ/ZjFYfV7x7WXsq6pvj4QOEV8=;
 b=qpIh0hZZdMUbO/xaXOluESyDyKh1wuXDzVMU8DbvilQdbzUAKKvtHMi2tZHdZZl6FD
 pzHWR1qJ9SA0OUooLhgYA/FHAGzMTwF85gH2zMJXOjHY8akNBlPm2ZAFPL/BsX6AECn0
 g+snaripSV02Ww2TMRpmrTPml1udHoN6L4hr2lbSznbW+9RR1UtQlYNf3WxE5hsOWUtQ
 ktECgJ1y4SLarJMnSz0M8Q7rpMoLOq1xtTjLcSnDW6jj68DsuSfsO/MEvpsp4a3+Pm5b
 T6ij0KxeYE/ElhOhht4tRwlDS7A1Bc2B1m97gM084MLnflqwYjE/MK2P0UCAVk17tm4z
 0i8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B5E+Z+YC3ztWK1Gz5JJ/ZjFYfV7x7WXsq6pvj4QOEV8=;
 b=cjJxPNg2UrT8WCUfjmVHOvjDRMaguktiqfzYzoql69MJS3YaLKJizxdKRGkIU+8I4H
 egffRYm2KSt+O8zlOuz4dpaP8l5mzCbZzt9qDh1uvoeziRVW7JjnVr4rOSND/qQyymyY
 UMCaxFMBcbgEZiUan4iOCUI9MdmG6/9hGxtBEAHLpClkyqlHYrZkydbp4tlmzp2viKgP
 8jRlMZXlEvbzn2sfuxIztNm4Dg4rPo4uhoZ4bRbc/TTUcnX6Gf3Ely+k/DkKBI4ftkw+
 B8Kb9q8plU3ZU3cGJyFHNsm1FsbsclK7nuqsiWx92iPS9jeRmt2AVTS66sCvTGsgDYxd
 WEKg==
X-Gm-Message-State: AOAM530Adn8aILYrEDuoPVy5o+9kbJlu3biPne/I4JrqeHmV9VNDoGlB
 twMBX1s/AmRJQhcyWuMRaHs=
X-Google-Smtp-Source: ABdhPJx+HANXtJX9yvLkBX/HVsORb2hbS4daFpETnK5c9NyvtRnVmWON27YgYVQ2Kp8imni+2oGhjA==
X-Received: by 2002:a63:5a43:: with SMTP id k3mr21331103pgm.308.1622434115432; 
 Sun, 30 May 2021 21:08:35 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 v4sm4275222pfn.41.2021.05.30.21.08.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 May 2021 21:08:35 -0700 (PDT)
Subject: Re: [RFC PATCH V3 03/11] x86/Hyper-V: Add new hvcall guest address
 host visibility support
To: Borislav Petkov <bp@alien8.de>
References: <20210530150628.2063957-1-ltykernel@gmail.com>
 <20210530150628.2063957-4-ltykernel@gmail.com> <YLPYqxF7urDIAd9z@zn.tnic>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <3716c9e0-2508-3553-5a70-e4b3f5f4c82e@gmail.com>
Date: Mon, 31 May 2021 12:08:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YLPYqxF7urDIAd9z@zn.tnic>
Content-Language: en-US
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 thomas.lendacky@amd.com, peterz@infradead.org, dave.hansen@linux.intel.com,
 hpa@zytor.com, kys@microsoft.com, will@kernel.org, hch@lst.de,
 linux-arch@vger.kernel.org, wei.liu@kernel.org, sstabellini@kernel.org,
 sthemmin@microsoft.com, linux-scsi@vger.kernel.org, x86@kernel.org,
 decui@microsoft.com, mingo@redhat.com, xen-devel@lists.xenproject.org,
 jejb@linux.ibm.com, jgross@suse.com, Tianyu.Lan@microsoft.com, arnd@arndb.de,
 konrad.wilk@oracle.com, haiyangz@microsoft.com, kuba@kernel.org, cai@lca.pw,
 luto@kernel.org, krish.sadhukhan@oracle.com, tglx@linutronix.de,
 vkuznets@redhat.com, boris.ostrovsky@oracle.com, martin.petersen@oracle.com,
 saravanand@fb.com, netdev@vger.kernel.org, sunilmut@microsoft.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 kirill.shutemov@linux.intel.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
 robin.murphy@arm.com, davem@davemloft.net, rppt@kernel.org
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

Hi Borislav:
	Thanks for your review.

On 5/31/2021 2:25 AM, Borislav Petkov wrote:
> On Sun, May 30, 2021 at 11:06:20AM -0400, Tianyu Lan wrote:
>> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
>> index 156cd235659f..a82975600107 100644
>> --- a/arch/x86/mm/pat/set_memory.c
>> +++ b/arch/x86/mm/pat/set_memory.c
>> @@ -29,6 +29,8 @@
>>   #include <asm/proto.h>
>>   #include <asm/memtype.h>
>>   #include <asm/set_memory.h>
>> +#include <asm/hyperv-tlfs.h>
>> +#include <asm/mshyperv.h>
>>   
>>   #include "../mm_internal.h"
>>   
>> @@ -1986,8 +1988,14 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
>>   	int ret;
>>   
>>   	/* Nothing to do if memory encryption is not active */
>> -	if (!mem_encrypt_active())
>> +	if (hv_is_isolation_supported()) {
>> +		return hv_set_mem_host_visibility((void *)addr,
>> +				numpages * HV_HYP_PAGE_SIZE,
>> +				enc ? VMBUS_PAGE_NOT_VISIBLE
>> +				: VMBUS_PAGE_VISIBLE_READ_WRITE);
> 
> Put all this gunk in a hv-specific function somewhere in hv-land which
> you only call from here. This way you probably won't even need to export
> hv_set_mem_host_visibility() and so on...
> 

Good idea. Will update. Thanks.


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
