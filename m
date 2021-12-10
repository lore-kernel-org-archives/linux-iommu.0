Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6F3C433EF
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 11:26:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A83D8852B1;
	Fri, 10 Dec 2021 11:26:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lCtFlwtcMzjB; Fri, 10 Dec 2021 11:26:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8F7B2852AE;
	Fri, 10 Dec 2021 11:26:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C885C002F;
	Fri, 10 Dec 2021 11:26:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10E44C0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 11:26:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DC1DC852AF
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 11:26:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PjKi7NrZ3e5F for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 11:26:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 46FF1852AE
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 11:26:53 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id u80so8194687pfc.9
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 03:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=oNMML2GUfpRe4KuxNkgjDIBCEtPq+5IBWg/SvCiB1ac=;
 b=R6WJg/vOJke+Pss70tPbsPfFF/c3xP//0lNWb4hUhYl4MWKxQP2AhRoJk4Y5bJnZp1
 KlS/DCpvqpFeiAygTjN3XgOkI4wsSUC3pOrCoqxfXll66oNqjjEsxdBGCU8QLOGpiVFR
 LWobxq8LFE1rEMc9YMoXunbOVZdz+3AjoVc8Kg1y1K0br5h1EYdR+RZpCv+3N4AQ+bZY
 pcM/MyWJuqJ15I3uei6a2bY9gaYAbKfpGIxypgOKVezQsvr67voKcAS9cTyw+4bd89zI
 U6kMYbLLJuqyUsx1sojCQ4Giu6rXvLiH2AL0GvH1cco0m27EzFRtcTcBh4LPEZ09Zf0b
 hZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=oNMML2GUfpRe4KuxNkgjDIBCEtPq+5IBWg/SvCiB1ac=;
 b=IvYHmlZ55DcFiLXqBv4049TU4XTxXswMooPQ92ITsPXBND1tO0VR65+9P6fWlSljMN
 hB7XjAHxVHIe2VgMR9T0xwSCRlQ3U1T3VRRBy5hyAnMvZ9ZryXnnk535iF6pDvUY1diA
 cX5U2uAxvIzCbvAeNPsmthM42yZt7j2pz9E+Ar4dIJtRIRyUUTV9Gf7ZTonbfktOZ8Ls
 GVfcnpdn3Ygx0jGjIC5GQA0K3ot0crJat6wT13MuDqNdyQjWr6FyAAFa5v6JHTvyVbh6
 7pouKutve6RP2vJvkASjICYLgl9wDRvG4lawTdHBOIq/pwtIyPCr5P9tixjAGjZgYcrL
 oKaQ==
X-Gm-Message-State: AOAM530BKyfT3Vs6MsqA5aJN/FPrKqgnbCMzKiWM2PUoQ2/L2DbWOTAX
 +rydeIogwFtwYcXAu9i3P9o=
X-Google-Smtp-Source: ABdhPJwHRIt+DqTuxKr3Ov92YpyxCIqQ63650YjNIjSjqT5l4iFIeahNGLj6YxvmmYkMJGFzIrL5ng==
X-Received: by 2002:a63:d753:: with SMTP id w19mr5091188pgi.174.1639135612496; 
 Fri, 10 Dec 2021 03:26:52 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50b? ([2404:f801:9000:1a:efea::50b])
 by smtp.gmail.com with ESMTPSA id
 on6sm16041313pjb.47.2021.12.10.03.26.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Dec 2021 03:26:52 -0800 (PST)
Message-ID: <e4125f7b-fdd9-dc0d-63d0-93d841dbb3c3@gmail.com>
Date: Fri, 10 Dec 2021 19:26:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH V6 2/5] x86/hyper-v: Add hyperv Isolation VM check in the
 cc_platform_has()
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
 "kuba@kernel.org" <kuba@kernel.org>, "jejb@linux.ibm.com"
 <jejb@linux.ibm.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "hch@infradead.org" <hch@infradead.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>
References: <20211207075602.2452-1-ltykernel@gmail.com>
 <20211207075602.2452-3-ltykernel@gmail.com>
 <MWHPR21MB1593F014EC440F5DEDCFDDFFD7709@MWHPR21MB1593.namprd21.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <MWHPR21MB1593F014EC440F5DEDCFDDFFD7709@MWHPR21MB1593.namprd21.prod.outlook.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dave.hansen@intel.com" <dave.hansen@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 vkuznets <vkuznets@redhat.com>, "hch@lst.de" <hch@lst.de>
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

On 12/10/2021 4:38 AM, Michael Kelley (LINUX) wrote:
> From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, December 6, 2021 11:56 PM
>>
>> Hyper-V provides Isolation VM which has memory encrypt support. Add
>> hyperv_cc_platform_has() and return true for check of GUEST_MEM_ENCRYPT
>> attribute.
>>
>> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> ---
>> Change since v3:
>> 	* Change code style of checking GUEST_MEM attribute in the
>> 	  hyperv_cc_platform_has().
>> ---
>>   arch/x86/kernel/cc_platform.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
>> index 03bb2f343ddb..47db88c275d5 100644
>> --- a/arch/x86/kernel/cc_platform.c
>> +++ b/arch/x86/kernel/cc_platform.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/cc_platform.h>
>>   #include <linux/mem_encrypt.h>
>>
>> +#include <asm/mshyperv.h>
>>   #include <asm/processor.h>
>>
>>   static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
>> @@ -58,9 +59,16 @@ static bool amd_cc_platform_has(enum cc_attr attr)
>>   #endif
>>   }
>>
>> +static bool hyperv_cc_platform_has(enum cc_attr attr)
>> +{
>> +	return attr == CC_ATTR_GUEST_MEM_ENCRYPT;
>> +}
>>
>>   bool cc_platform_has(enum cc_attr attr)
>>   {
>> +	if (hv_is_isolation_supported())
>> +		return hyperv_cc_platform_has(attr);
>> +
>>   	if (sme_me_mask)
>>   		return amd_cc_platform_has(attr);
>>
> 
> Throughout Linux kernel code, there are about 20 calls to cc_platform_has()
> with CC_ATTR_GUEST_MEM_ENCRYPT as the argument.  The original code
> (from v1 of this patch set) only dealt with the call in sev_setup_arch().   But
> with this patch, all the other calls that previously returned "false" will now
> return "true" in a Hyper-V Isolated VM.  I didn't try to analyze all these other
> calls, so I think there's an open question about whether this is the behavior
> we want.
> 

CC_ATTR_GUEST_MEM_ENCRYPT is for SEV support so far. Hyper-V Isolation
VM is based on SEV or software memory encrypt. Most checks can be 
reused. The difference is that SEV code use encrypt bit in the page
table to encrypt and decrypt memory while Hyper-V uses vTOM. But the sev
memory encrypt mask "sme_me_mask" is unset in the Hyper-V Isolation VM
where claims sev and sme are unsupported. The rest of checks for mem enc
bit are still safe. So reuse CC_ATTR_GUEST_MEM_ENCRYPT for Hyper-V.


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
