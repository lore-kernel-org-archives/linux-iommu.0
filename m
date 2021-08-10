Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431DCC4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 12:18:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E47E260FC4
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 12:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E47E260FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF3B3837DA;
	Tue, 10 Aug 2021 12:18:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BlbxxQE1HEOh; Tue, 10 Aug 2021 12:17:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8F09183459;
	Tue, 10 Aug 2021 12:17:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A9F2C001A;
	Tue, 10 Aug 2021 12:17:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05C15C000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 12:17:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0133E40522
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 12:17:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p7WVUrewWVr4 for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 12:17:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CD8D34051A
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 12:17:55 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 gz13-20020a17090b0ecdb0290178c0e0ce8bso2765317pjb.1
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 05:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nvD6+M9t7qTrvrmcvKckt/OKOvl8Bvz01WtaH3hiQrw=;
 b=W8VJHgJYz2WQSwNj+l2V4hKZLutN1MT1dVCGeD6amKZrIf5ru9mj7Kr5RPC5btWdWX
 RcBrITr2iOAHNEFyRwZNQK2DWBs/jeslabKlgJrh6HL+/vTklPVAPdNaLnbz89wRnuqp
 vInDusDjinU1k1tXuSrvNl+arW4OUoLjK4+N1kssywggZW7Jvt3yFTBcvkkKO5md3u7e
 bBYY198+1xHTBLt8BAqooipJ4q/UaotaCIigVxqnzz3L1RWNDBQzAY5XUbKRG2hYDfQr
 DyJeQjfUNmnEVrq8buf0/t08+AhEw6uB7PdFS6dLDgmOJUh/gxis1n7pHXyKAOel03W2
 Aoig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nvD6+M9t7qTrvrmcvKckt/OKOvl8Bvz01WtaH3hiQrw=;
 b=qQlsaEOFW619SWMUq2n5eL8JLBQuKrkNgXf+Oga3PNevwihHhoQ7uIaKROWrDubDc4
 fzW+U68WUXwpHoL3ZBBX5m4aMhq3Hw9oimsOIrHNTIeIfqsV7vx0q+laYBoAd+2RGqCR
 74U6vsCP8JVnEcsC70veFnom0mHAV60Vu7ezAHYP7Ev+XyikhIACZ8k0A8nuKZxdgA7i
 g73SN/5VM6M/aWA5gRRsTh3D/1OfV3QKjfB6qqdOGlI+BlPciQi9QZRwqE5fgmqbzaaR
 P/mzIrFH1SZz01z3ZKzdG8DE4qQBBrKU1g/VhUNtUv2tOLpWYcHhQjn7KbWMbvJr54r/
 3yNA==
X-Gm-Message-State: AOAM531MoLlx7QO28dYG32Qmat8DqgbuYSSGnMUsLpsRmOtZ7PvDLw/m
 5DVqS7pG2ZjGJA8xa7cmTBU=
X-Google-Smtp-Source: ABdhPJzf0LwxUC1SEDmEJ4+woyBt3uEtabjBKjNM9eN5IQM2eh4nYHReWO5vIVqWyXP8Bs1frIDsoA==
X-Received: by 2002:a63:131f:: with SMTP id i31mr348459pgl.207.1628597875367; 
 Tue, 10 Aug 2021 05:17:55 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:18:efec::4b1])
 by smtp.gmail.com with ESMTPSA id
 ls16sm22103844pjb.49.2021.08.10.05.17.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Aug 2021 05:17:54 -0700 (PDT)
Subject: Re: [PATCH V3 01/13] x86/HV: Initialize GHCB page in Isolation VM
To: Wei Liu <wei.liu@kernel.org>
References: <20210809175620.720923-1-ltykernel@gmail.com>
 <20210809175620.720923-2-ltykernel@gmail.com>
 <20210810105609.soi67eg2us5w7yuq@liuwe-devbox-debian-v2>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <93f3b1c6-feec-9c3b-c2d0-6fceffd00ae9@gmail.com>
Date: Tue, 10 Aug 2021 20:17:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210810105609.soi67eg2us5w7yuq@liuwe-devbox-debian-v2>
Content-Language: en-US
Cc: parri.andrea@gmail.com, linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 peterz@infradead.org, dave.hansen@linux.intel.com, vkuznets@redhat.com,
 hpa@zytor.com, kys@microsoft.com, will@kernel.org, boris.ostrovsky@oracle.com,
 linux-arch@vger.kernel.org, sfr@canb.auug.org.au, sstabellini@kernel.org,
 sthemmin@microsoft.com, xen-devel@lists.xenproject.org,
 linux-scsi@vger.kernel.org, aneesh.kumar@linux.ibm.com, x86@kernel.org,
 decui@microsoft.com, hch@lst.de, michael.h.kelley@microsoft.com,
 mingo@redhat.com, pgonda@google.com, rientjes@google.com, kuba@kernel.org,
 jejb@linux.ibm.com, martin.b.radev@gmail.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, akpm@linux-foundation.org,
 jgross@suse.com, martin.petersen@oracle.com, saravanand@fb.com,
 netdev@vger.kernel.org, dave.hansen@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, rppt@kernel.org, hannes@cmpxchg.org,
 tj@kernel.org, ardb@kernel.org, robin.murphy@arm.com, davem@davemloft.net,
 kirill.shutemov@linux.intel.com
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

Hi Wei:
       Thanks for review.

On 8/10/2021 6:56 PM, Wei Liu wrote:
> On Mon, Aug 09, 2021 at 01:56:05PM -0400, Tianyu Lan wrote:
> [...]
>>   static int hv_cpu_init(unsigned int cpu)
>>   {
>>   	union hv_vp_assist_msr_contents msr = { 0 };
>> @@ -85,6 +111,8 @@ static int hv_cpu_init(unsigned int cpu)
>>   		}
>>   	}
>>   
>> +	hyperv_init_ghcb();
>> +
> 
> Why is the return value not checked here? If that's not required, can
> you leave a comment?
> 

The check is necessary here. Will update in the next version.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
