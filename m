Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F71CC43462
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 20:00:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A85726105A
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 20:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85726105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 71EB6401CF;
	Fri,  9 Apr 2021 20:00:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eyfcO2Ktg8pJ; Fri,  9 Apr 2021 20:00:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2B0A1401C9;
	Fri,  9 Apr 2021 20:00:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E29AC000C;
	Fri,  9 Apr 2021 20:00:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37B4FC000A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 20:00:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 19071401CF
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 20:00:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jTywaVHeGM2x for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 20:00:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D9D45401C9
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 20:00:36 +0000 (UTC)
Received: by mail-io1-xd29.google.com with SMTP id x17so7132585iog.2
 for <iommu@lists.linux-foundation.org>; Fri, 09 Apr 2021 13:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cgshE6EYnolIShLRm5FI9d7+7bz8uNIyn1uZIy0SnYk=;
 b=P+0ssMYSZARmrpU7MaDh0LAz4Nsm9BirVFy68Wgek1heXXY45shgwR8l2yCLMRixvM
 gHejADh8yLI1kWEwJsl96uXZXuXBktI7xPT76f+/Iq9q3JV//4UITVQpA4y1ENRQE9LF
 aRbV35/My1YsmojhyfG/Pxadmg73YZ+GzD6Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cgshE6EYnolIShLRm5FI9d7+7bz8uNIyn1uZIy0SnYk=;
 b=B74sJ1rcmQOYewswdnL2vVtMv3ItJmVgsoZ7UcvaROYKGTC+pgA3jYI986aU0IB0IW
 fTTNolqNH2XgoJZPjjTLh1MNyLmqFd4UIzfrahFa0n7lAOIf8pm89WYFcSQ7t+G/gWnl
 EQ/GeWaT5wSMOyHA1MWh2OKC69rOy/vsCIm9Fi/eOTIOiuCHkAno/iBZ+lq+QmP//sec
 O4Ag7LUt/MIPQeA2f7DSUHpVifOzRAGZBglXOnWorww2Uehyaom3ddYCl/k4rOXaTfn6
 Qbz5+63fFXoYS8+vT+d1k6F5dodMsyEn43j/2CGhSaU/maN4YIRBR1wUPS22wYM/zwCy
 aARw==
X-Gm-Message-State: AOAM531SOr27TJ27LK0BxoBQESqd4PMSdOKJ4oN6m8+bs2mFEilmy737
 4br2hLfcbT+RM+MHaansXXlGEIZm
X-Google-Smtp-Source: ABdhPJzChhxXyqliGmiCUhlRXZWNybL45CB4wGrK1sdALXTbkRB6XEqjA6pDuJdJ5sHy+1Fcaz75uQ==
X-Received: by 2002:a02:850a:: with SMTP id g10mr16476595jai.140.1617998435941; 
 Fri, 09 Apr 2021 13:00:35 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net.
 [24.9.64.241])
 by smtp.gmail.com with ESMTPSA id o6sm1658992ioa.21.2021.04.09.13.00.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Apr 2021 13:00:35 -0700 (PDT)
Subject: Re: [PATCH 2/2] iommu/amd: Remove performance counter
 pre-initialization test
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
 <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
From: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4f007897-afac-35e3-9c76-281c94d660c7@linuxfoundation.org>
Date: Fri, 9 Apr 2021 14:00:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
Content-Language: en-US
Cc: pmenzel@molgen.mpg.de, Alexander Monakov <amonakov@ispras.ru>,
 David Coe <david.coe@live.co.uk>, Jon.Grimm@amd.com,
 Shuah Khan <skhan@linuxfoundation.org>, Tj <ml.linux@elloe.vision>,
 will@kernel.org
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

On 4/9/21 2:58 AM, Suravee Suthikulpanit wrote:
> In early AMD desktop/mobile platforms (during 2013), when the IOMMU
> Performance Counter (PMC) support was first introduced in
> commit 30861ddc9cca ("perf/x86/amd: Add IOMMU Performance Counter
> resource management"), there was a HW bug where the counters could not
> be accessed. The result was reading of the counter always return zero.
> 
> At the time, the suggested workaround was to add a test logic prior
> to initializing the PMC feature to check if the counters can be programmed
> and read back the same value. This has been working fine until the more
> recent desktop/mobile platforms start enabling power gating for the PMC,
> which prevents access to the counters. This results in the PMC support
> being disabled unnecesarily.
> 
> Unfortunatly, there is no documentation of since which generation
> of hardware the original PMC HW bug was fixed. Although, it was fixed
> soon after the first introduction of the PMC. Base on this, we assume
> that the buggy platforms are less likely to be in used, and it should
> be relatively safe to remove this legacy logic.
> 
> Link: https://lore.kernel.org/linux-iommu/alpine.LNX.3.20.13.2006030935570.3181@monopod.intra.ispras.ru/
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201753
> Cc: Tj (Elloe Linux) <ml.linux@elloe.vision>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Alexander Monakov <amonakov@ispras.ru>
> Cc: David Coe <david.coe@live.co.uk>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---


Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

Results with this patch on AMD Ryzen 5 PRO 2400GE w/ Radeon Vega
Graphics

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

                156      amd_iommu_0/cmd_processed/ 
                 (33.30%)
                 80       amd_iommu_0/cmd_processed_inv/ 
                      (33.38%)
                  0       amd_iommu_0/ign_rd_wr_mmio_1ff8h/ 
                         (33.40%)
                  0       amd_iommu_0/int_dte_hit/ 
                (33.43%)
                325       amd_iommu_0/int_dte_mis/ 
                (33.44%)
              1,951       amd_iommu_0/mem_dte_hit/ 
                (33.45%)
              7,589       amd_iommu_0/mem_dte_mis/ 
                (33.49%)
                325       amd_iommu_0/mem_iommu_tlb_pde_hit/ 
                          (33.45%)
              2,460       amd_iommu_0/mem_iommu_tlb_pde_mis/ 
                          (33.41%)
              2,510       amd_iommu_0/mem_iommu_tlb_pte_hit/ 
                          (33.38%)
              5,526       amd_iommu_0/mem_iommu_tlb_pte_mis/ 
                          (33.33%)
                  0       amd_iommu_0/mem_pass_excl/ 
                  (33.29%)
                  0       amd_iommu_0/mem_pass_pretrans/ 
                      (33.28%)
              1,556       amd_iommu_0/mem_pass_untrans/ 
                     (33.27%)
                  0       amd_iommu_0/mem_target_abort/ 
                     (33.26%)
              3,112       amd_iommu_0/mem_trans_total/ 
                    (33.29%)
                  0       amd_iommu_0/page_tbl_read_gst/ 
                      (33.29%)
              1,813       amd_iommu_0/page_tbl_read_nst/ 
                      (33.25%)
              2,242       amd_iommu_0/page_tbl_read_tot/ 
                      (33.27%)
                  0       amd_iommu_0/smi_blk/ 
                (33.29%)
                  0       amd_iommu_0/smi_recv/ 
                (33.28%)
                  0       amd_iommu_0/tlb_inv/ 
                (33.28%)
                  0       amd_iommu_0/vapic_int_guest/ 
                    (33.25%)
                  0       amd_iommu_0/vapic_int_non_guest/ 
                        (33.26%)

       10.003200316 seconds time elapsed

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
