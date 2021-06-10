Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84457C47094
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 14:19:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A26613C6
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 14:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A26613C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4BA860627;
	Thu, 10 Jun 2021 14:19:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QBAW9zHCWVSk; Thu, 10 Jun 2021 14:19:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9292D606D4;
	Thu, 10 Jun 2021 14:19:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A073C000E;
	Thu, 10 Jun 2021 14:19:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09DFDC000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 14:19:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EBF19606D4
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 14:19:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FyTLFts7FeBK for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 14:19:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D0CCA60627
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 14:19:00 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id d16so1725202pfn.12
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 07:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=S7U7wM1689XPFk0ln7YagGhi2kwC7oBCIYjLHGTATmA=;
 b=j1ssCm/VIao3T0Xc2kwXH6tQqWfrySQ1IoYffbIUZhSffD09z3SFuktT6padpAZaa/
 O6dOSr9MfmJ3BaiaCjc0PA9hj1D56rpnhXvTnUEKbRnxOiqwlkMuTGEQqMho8+laNO3A
 Ps4g2Ewhuj5lqgG3+vb3Pr6h4xORMt0ouVqwcSeoFvA+lTlqRvdEpC++3hJnHyetmZQS
 Y1STui7T1ekgTq6zzEkx3p9dSbyB7UT0DfPgF2o16fgVpJiH+bKr87Q/n9chxbr1Li1Z
 sUz1mgnrmF2Vvd/rNoSeF09YxbBnVBhhC9qN6Rqm62kNLgrUCEgGYVPXMjW1fXotfIvd
 p8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S7U7wM1689XPFk0ln7YagGhi2kwC7oBCIYjLHGTATmA=;
 b=IwIk4oq4x024HzostLzFpma1wgJZlgfZgroxpF00YHKyO5gUIYKeDyduksP19oUqq0
 iiI0ZWfEUKengTJpw2SDWNVttA6myRNKHgchlbjw6w+YxVb400X4JAssoBIx1ZKpOIjL
 TJ0TfnGgDYWvh1oIRh1a/8DDYBimM1o0byKuiIuLKD6XPnky1hb2BzPdz1nzBNxZQtkk
 TXq7eG/L+Fs5wjulJQRLpepPG+D9sdPVzP3jd5KFOIePT3ZEByrt/YeNN+mLeyz0jrUn
 AlCGopEZWZ7G6HUnAbNN5sOL0d0mU7QmWtsVqmhWWWoV+BVpKIDJTwYe1w/Awdg7EM2J
 HdkA==
X-Gm-Message-State: AOAM531JYrsuL+vuCBwbuiUytlVpsP1hleCKxXDGTgEOpEsY/29O489m
 aeXwtGmyqlTj9bCUmjxswP8=
X-Google-Smtp-Source: ABdhPJykpYU7kOZkoptn+vRUH+LpqhlVAnDQIkp8KIQpRwT8RFYkpZNT1LtsR90ESObN7s+cfunBTA==
X-Received: by 2002:a63:7404:: with SMTP id p4mr5123864pgc.405.1623334740224; 
 Thu, 10 Jun 2021 07:19:00 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 s22sm2725797pfd.94.2021.06.10.07.18.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jun 2021 07:18:59 -0700 (PDT)
Subject: Re: [RFC PATCH V3 03/11] x86/Hyper-V: Add new hvcall guest address
 host visibility support
To: Vitaly Kuznetsov <vkuznets@redhat.com>, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, arnd@arndb.de, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
 kirill.shutemov@linux.intel.com, rppt@kernel.org, hannes@cmpxchg.org,
 cai@lca.pw, krish.sadhukhan@oracle.com, saravanand@fb.com,
 Tianyu.Lan@microsoft.com, konrad.wilk@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, boris.ostrovsky@oracle.com,
 jgross@suse.com, sstabellini@kernel.org, joro@8bytes.org, will@kernel.org,
 xen-devel@lists.xenproject.org, davem@davemloft.net, kuba@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com
References: <20210530150628.2063957-1-ltykernel@gmail.com>
 <20210530150628.2063957-4-ltykernel@gmail.com>
 <878s3iyrtg.fsf@vitty.brq.redhat.com>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <2a0170a9-e4d5-1c63-7901-416094f6ab64@gmail.com>
Date: Thu, 10 Jun 2021 22:18:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <878s3iyrtg.fsf@vitty.brq.redhat.com>
Content-Language: en-US
Cc: linux-arch@vger.kernel.org, thomas.lendacky@amd.com,
 linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 sunilmut@microsoft.com
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

Hi Vitaly:
	Thanks for your review.

On 6/10/2021 5:47 PM, Vitaly Kuznetsov wrote:
>> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
>> index 606f5cc579b2..632281b91b44 100644
>> --- a/arch/x86/include/asm/hyperv-tlfs.h
>> +++ b/arch/x86/include/asm/hyperv-tlfs.h
>> @@ -262,6 +262,17 @@ enum hv_isolation_type {
>>   #define HV_X64_MSR_TIME_REF_COUNT	HV_REGISTER_TIME_REF_COUNT
>>   #define HV_X64_MSR_REFERENCE_TSC	HV_REGISTER_REFERENCE_TSC
>>   
>> +/* Hyper-V GPA map flags */
>> +#define HV_MAP_GPA_PERMISSIONS_NONE            0x0
>> +#define HV_MAP_GPA_READABLE                    0x1
>> +#define HV_MAP_GPA_WRITABLE                    0x2
>> +
>> +enum vmbus_page_visibility {
>> +	VMBUS_PAGE_NOT_VISIBLE = 0,
>> +	VMBUS_PAGE_VISIBLE_READ_ONLY = 1,
>> +	VMBUS_PAGE_VISIBLE_READ_WRITE = 3
>> +};
>> +
> Why do we need both flags and the enum? I don't see HV_MAP_GPA_* being
> used anywhere and VMBUS_PAGE_VISIBLE_READ_WRITE looks like
> HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE.
> 
> As this is used to communicate with the host, I'd suggest to avoid using
> enum and just use flags everywhere.
> 

Nice catch. Will update in the next version.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
