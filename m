Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54C8C4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 15:52:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DBB9610FB
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 15:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6DBB9610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2FDC0404C0;
	Thu,  5 Aug 2021 15:52:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6bvCEuemVZ_v; Thu,  5 Aug 2021 15:52:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CF5EA4012F;
	Thu,  5 Aug 2021 15:52:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CD5FC001A;
	Thu,  5 Aug 2021 15:52:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8B55C000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 15:52:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 87DD84012F
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 15:52:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hNYj6hpTCL8Y for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 15:52:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BB62E40494
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 15:52:01 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 pj14-20020a17090b4f4eb029017786cf98f9so10555447pjb.2
 for <iommu@lists.linux-foundation.org>; Thu, 05 Aug 2021 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+WAVvy3jG8c4BM1UieKc0hBr5+TPYkK4USUWUu/waLs=;
 b=f9NRItGcA82zfK89pCSO+FmqIIS9do5TDWjGS2Phwk71Ji2CmZnf8PxAfzm2UDR9km
 lAgg56lZbpeu+K8iuYKOH1bUmUq+Y/w/ympLbW5zEuqcXD+Ru4sUL4cDWR8qGdqEidfP
 ziOfCCbUfhxx8uX8F2JJ2xPz5qHc78AmuoWiHkw+umEWamoItzUkWexCOBGuIR0ULKl+
 eOmE9bSQ4nk3xuDfmkfuO0ZE6gpw9xgYHGc/K8FFsdr9ojyhAkwggIRaPFhLl1LTpS6j
 IdRxy4GUR6A7AcO0BdasFcNqOb53Xf4LXDenQVsPE/VC2bZYgbJo499AOTpLdDoOb8Uh
 Zbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+WAVvy3jG8c4BM1UieKc0hBr5+TPYkK4USUWUu/waLs=;
 b=AgOuYoLqKDQkkMDq2ndp7KjJub+Bv22uiyzwB35EirLF0ezWzzVW1HmZH8Q96JkHX3
 wKO/Eyrr21DdoGXMQaVw/5eXEUuHqEg+JRo3wiJhT6xmGRh2aSxvU1zrUhRyGkms27EF
 mp23a4Bj8sK+C0LLStgHnBK6BLJoh9R2etuAM3WFDN5U0HrWDOGun7JqVYADFJ+Xd3uz
 s1RfNCuqHsy3TnMiQx5EpFFmOXrqX1nxg6L6lPRZU42GjBPb2Q4Ipr0WPQl7H+SmIl5X
 F6iNcC2OXrsAEdvWVzbZ2EpVItAEh0vernt6VNrOhyDWIKzun7lOfG34BLKyYxwUwRPU
 OZsQ==
X-Gm-Message-State: AOAM533IcsXHecJ/qER4ASc1d95xPKPFKpBfvj9LocDv0PfIg1brLR12
 K2Qit2oRNHqGuhiYK8ybjn8=
X-Google-Smtp-Source: ABdhPJzLAimd4Y4p28t2bHcnYkc9F26SFPNdWJKKxX6QGrlC4uJA5cMAwBVxgkywklDtK+gtxm7ShA==
X-Received: by 2002:a62:d447:0:b029:291:19f7:ddcd with SMTP id
 u7-20020a62d4470000b029029119f7ddcdmr169701pfl.54.1628178720447; 
 Thu, 05 Aug 2021 08:52:00 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 w11sm8659286pgk.34.2021.08.05.08.51.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Aug 2021 08:51:59 -0700 (PDT)
Subject: Re: [PATCH V2 03/14] x86/set_memory: Add x86_set_memory_enc static
 call support
To: Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <peterz@infradead.org>
References: <20210804184513.512888-1-ltykernel@gmail.com>
 <20210804184513.512888-4-ltykernel@gmail.com>
 <5823af8a-7dbb-dbb0-5ea2-d9846aa2a36a@intel.com>
 <942e6fcb-3bdf-9294-d3db-ca311db440d3@gmail.com>
 <YQv0bRBUq1N5+jgG@hirez.programming.kicks-ass.net>
 <fa63e6ad-9536-d5e9-d754-fa04fad69252@intel.com>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <01d2f33c-6e50-ae88-73ff-84042504c26e@gmail.com>
Date: Thu, 5 Aug 2021 23:51:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <fa63e6ad-9536-d5e9-d754-fa04fad69252@intel.com>
Content-Language: en-US
Cc: parri.andrea@gmail.com, linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 david@redhat.com, ardb@kernel.org, dave.hansen@linux.intel.com, hpa@zytor.com,
 kys@microsoft.com, will@kernel.org, boris.ostrovsky@oracle.com,
 linux-arch@vger.kernel.org, wei.liu@kernel.org, sstabellini@kernel.org,
 sthemmin@microsoft.com, xen-devel@lists.xenproject.org,
 linux-scsi@vger.kernel.org, aneesh.kumar@linux.ibm.com, x86@kernel.org,
 decui@microsoft.com, hch@lst.de, michael.h.kelley@microsoft.com,
 mingo@redhat.com, pgonda@google.com, rientjes@google.com, kuba@kernel.org,
 jejb@linux.ibm.com, martin.b.radev@gmail.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, keescook@chromium.org, arnd@arndb.de,
 konrad.wilk@oracle.com, haiyangz@microsoft.com, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, vkuznets@redhat.com,
 jgross@suse.com, martin.petersen@oracle.com, saravanand@fb.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kirill.shutemov@linux.intel.com,
 tj@kernel.org, akpm@linux-foundation.org, robin.murphy@arm.com,
 davem@davemloft.net, rppt@kernel.org
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

On 8/5/2021 10:29 PM, Dave Hansen wrote:
> On 8/5/21 7:23 AM, Peter Zijlstra wrote:
>> This is assuming any of this is actually performance critical, based off
>> of this using static_call() to begin with.
> 
> This code is not performance critical.
> 
> I think I sent folks off on a wild goose chase when I asked that we make
> an effort to optimize code that does:
> 
> 	if (some_hyperv_check())
> 		foo();
> 
> 	if (some_amd_feature_check())
> 		bar();
> 
> with checks that will actually compile away when Hyper-V or
> some_amd_feature() is disabled.  That's less about performance and just
> about good hygiene.  I *wanted* to see
> cpu_feature_enabled(X86_FEATURE...) checks.
> 
> Someone suggested using static calls, and off we went...
> 
> Could we please just use cpu_feature_enabled()?
>

Yes, cpu_feature_enabled() works. The target is just to run platform 
code after platform check. I will update this in the next version.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
