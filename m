Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358DFC43460
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 20:20:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7E0611C9
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 20:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7E0611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7304660771;
	Fri,  9 Apr 2021 20:20:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id npbRxUGQCguS; Fri,  9 Apr 2021 20:20:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 399EF606C2;
	Fri,  9 Apr 2021 20:20:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11B97C000B;
	Fri,  9 Apr 2021 20:20:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0392CC000A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 20:20:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D162F83FAB
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 20:20:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b3Nd318Nerqk for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 20:19:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BE7B083F52
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 20:19:59 +0000 (UTC)
Received: by mail-io1-xd33.google.com with SMTP id v26so7168409iox.11
 for <iommu@lists.linux-foundation.org>; Fri, 09 Apr 2021 13:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4jo0e+Vjj3cJ40iEJOh4rf81zAT4Jhhwl4ZeYyYej1w=;
 b=XDWQz7wAYkXZgUUBliFvMvQ2p+0KnEfvr5XhTLLrnCHpN29Qk7LhcVQhGAr7FrdEAB
 lzywTHIEsc6oyWxXSTzYU+hf7w6K6MKh+h4ICjFqtLn9M+OWge32sfmtUQwBlDK21HLu
 xDgCe3BBD+ffIpbdeEv1R6AgbTyoAvvn7AoLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4jo0e+Vjj3cJ40iEJOh4rf81zAT4Jhhwl4ZeYyYej1w=;
 b=l8xt9r8oJPbYvHQQBl5M4MX+KFKeUD7wwt/fzSFkF89vqKCOqaGB4TAAMmVSjZq1ar
 PLun3XIdMrw6/E70AX5Fpm0cYkdXIMLi1tD3rP9qKZ+ZdwxP+C+30zoE/HKj0pYK6iEV
 3V9Cc/wXxsHVbGwSt2Tcq+sIWkG5wHsRw86tOwgR8HzuSm9Mp0kd49Ub/NZXWZDyVfbV
 Ttt1tS6L3+HHyL5O6v8FapexiRH5bsurk9LutLz4ifmK0r/EmaErxaSK2V3VMsY4Ucb/
 FNRKcSy+i72+ta0xgjIlrY5Aj9PArtZD9IxIUzMLKI7ysF6EobONKy598PhN6sINhHZ4
 5LKQ==
X-Gm-Message-State: AOAM531RyKMwRr43JJn4sVJ5Ez7b4yh360EY84nnPPus22xu7sMoN6/S
 +YBomxQ9aNTUoJAbkN1uMzv+5SS/
X-Google-Smtp-Source: ABdhPJwFfDJF762woYudGXWODvyKztEOJ2DlWF4ywug3/Nb37mHtz4ik7ZyxgrlMLYYKZ1MqwbTdNA==
X-Received: by 2002:a5e:cb4b:: with SMTP id h11mr13030061iok.108.1617999598839; 
 Fri, 09 Apr 2021 13:19:58 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net.
 [24.9.64.241])
 by smtp.gmail.com with ESMTPSA id u20sm1638118ilj.63.2021.04.09.13.19.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Apr 2021 13:19:58 -0700 (PDT)
Subject: Re: [PATCH 2/2] iommu/amd: Remove performance counter
 pre-initialization test
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
 <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
 <4f007897-afac-35e3-9c76-281c94d660c7@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <028da60d-4f67-60bf-4360-83fe37bcbb7e@linuxfoundation.org>
Date: Fri, 9 Apr 2021 14:19:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <4f007897-afac-35e3-9c76-281c94d660c7@linuxfoundation.org>
Content-Language: en-US
Cc: pmenzel@molgen.mpg.de, Alexander Monakov <amonakov@ispras.ru>,
 David Coe <david.coe@live.co.uk>, Jon.Grimm@amd.com,
 Shuah Khan <skhan@linuxfoundation.org>, Tj <ml.linux@elloe.vision>,
 1917203@bugs.launchpad.net, will@kernel.org
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

On 4/9/21 2:00 PM, Shuah Khan wrote:
> On 4/9/21 2:58 AM, Suravee Suthikulpanit wrote:
>> In early AMD desktop/mobile platforms (during 2013), when the IOMMU
>> Performance Counter (PMC) support was first introduced in
>> commit 30861ddc9cca ("perf/x86/amd: Add IOMMU Performance Counter
>> resource management"), there was a HW bug where the counters could not
>> be accessed. The result was reading of the counter always return zero.
>>
>> At the time, the suggested workaround was to add a test logic prior
>> to initializing the PMC feature to check if the counters can be 
>> programmed
>> and read back the same value. This has been working fine until the more
>> recent desktop/mobile platforms start enabling power gating for the PMC,
>> which prevents access to the counters. This results in the PMC support
>> being disabled unnecesarily.
>>
>> Unfortunatly, there is no documentation of since which generation
>> of hardware the original PMC HW bug was fixed. Although, it was fixed
>> soon after the first introduction of the PMC. Base on this, we assume
>> that the buggy platforms are less likely to be in used, and it should
>> be relatively safe to remove this legacy logic.
>>
>> Link: 
>> https://lore.kernel.org/linux-iommu/alpine.LNX.3.20.13.2006030935570.3181@monopod.intra.ispras.ru/ 
>>
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201753
>> Cc: Tj (Elloe Linux) <ml.linux@elloe.vision>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Cc: Alexander Monakov <amonakov@ispras.ru>
>> Cc: David Coe <david.coe@live.co.uk>
>> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
> 
> 
> Tested-by: Shuah Khan <skhan@linuxfoundation.org>
> 

Revert + this patch - same as my test on Ryzen 5

On AMD Ryzen 7 4700G with Radeon Graphics

These look real odd to me. Let me know if I should look further.

sudo ./perf stat -e 'amd_iommu_0/cmd_processed/, 
amd_iommu_0/cmd_processed_inv/, amd_iommu_0/ign_rd_wr_mmio_1ff8h/, 
amd_iommu_0/int_dte_hit/, amd_iommu_0/int_dte_mis/, 
amd_iommu_0/mem_dte_hit/, amd_iommu_0/mem_dte_mis/, 
amd_iommu_0/mem_iommu_tlb_pde_hit/, amd_iommu_0/mem_iommu_tlb_pde_mis/, 
amd_iommu_0/mem_iommu_tlb_pte_hit/, amd_iommu_0/mem_iommu_tlb_pte_mis/, 
amd_iommu_0/mem_pass_excl/, amd_iommu_0/mem_pass_pretrans/, 
amd_iommu_0/mem_pass_untrans/, amd_iommu_0/mem_target_abort/, 
amd_iommu_0/mem_trans_total/, amd_iommu_0/page_tbl_read_gst/, 
amd_iommu_0/page_tbl_read_nst/, amd_iommu_0/page_tbl_read_tot/, 
amd_iommu_0/smi_blk/, amd_iommu_0/smi_recv/, amd_iommu_0/tlb_inv/, 
amd_iommu_0/vapic_int_guest/, amd_iommu_0/vapic_int_non_guest/' sleep 10

  Performance counter stats for 'system wide':

17,761,952,514,865,374      amd_iommu_0/cmd_processed/ 
                    (33.28%)
18,582,155,570,607,472       amd_iommu_0/cmd_processed_inv/ 
                         (33.32%)
                  0       amd_iommu_0/ign_rd_wr_mmio_1ff8h/ 
                         (33.36%)
5,056,087,645,262,255       amd_iommu_0/int_dte_hit/ 
                  (33.40%)
32,831,106,446,308,888       amd_iommu_0/int_dte_mis/ 
                   (33.44%)
13,461,819,655,591,296       amd_iommu_0/mem_dte_hit/ 
                   (33.45%)
208,555,436,221,050,464       amd_iommu_0/mem_dte_mis/ 
                    (33.47%)
196,824,154,635,609,888       amd_iommu_0/mem_iommu_tlb_pde_hit/ 
                              (33.46%)
193,552,630,440,410,144       amd_iommu_0/mem_iommu_tlb_pde_mis/ 
                              (33.45%)
176,936,647,809,098,368       amd_iommu_0/mem_iommu_tlb_pte_hit/ 
                              (33.41%)
184,737,401,623,626,464       amd_iommu_0/mem_iommu_tlb_pte_mis/ 
                              (33.37%)
                  0       amd_iommu_0/mem_pass_excl/ 
                  (33.33%)
                  0       amd_iommu_0/mem_pass_pretrans/ 
                      (33.30%)
                  0       amd_iommu_0/mem_pass_untrans/ 
                     (33.28%)
                  0       amd_iommu_0/mem_target_abort/ 
                     (33.27%)
245,383,212,924,004,288       amd_iommu_0/mem_trans_total/ 
                        (33.27%)
                  0       amd_iommu_0/page_tbl_read_gst/ 
                      (33.28%)
262,267,045,917,967,264       amd_iommu_0/page_tbl_read_nst/ 
                          (33.27%)
256,308,216,913,137,600       amd_iommu_0/page_tbl_read_tot/ 
                          (33.28%)
                  0       amd_iommu_0/smi_blk/ 
                (33.27%)
                  0       amd_iommu_0/smi_recv/ 
                (33.27%)
                  0       amd_iommu_0/tlb_inv/ 
                (33.27%)
                  0       amd_iommu_0/vapic_int_guest/ 
                    (33.26%)
38,913,544,420,579,888       amd_iommu_0/vapic_int_non_guest/ 
                           (33.27%)

       10.003967760 seconds time elapsed

thanks,
-- Shuah
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
