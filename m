Return-Path: <SRS0=nnIB=NG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82C4C4338F
	for <iommu@archiver.kernel.org>; Sun, 15 Aug 2021 15:21:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AE9261208
	for <iommu@archiver.kernel.org>; Sun, 15 Aug 2021 15:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7AE9261208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43C45833C6;
	Sun, 15 Aug 2021 15:21:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C58tmiNheQlC; Sun, 15 Aug 2021 15:21:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1DA1F833AF;
	Sun, 15 Aug 2021 15:21:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF2F2C0010;
	Sun, 15 Aug 2021 15:21:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B0DEC000E
 for <iommu@lists.linux-foundation.org>; Sun, 15 Aug 2021 15:21:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 54266833B7
 for <iommu@lists.linux-foundation.org>; Sun, 15 Aug 2021 15:21:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YyYu3rSZQRkD for <iommu@lists.linux-foundation.org>;
 Sun, 15 Aug 2021 15:21:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AC5B9833AF
 for <iommu@lists.linux-foundation.org>; Sun, 15 Aug 2021 15:21:29 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id a20so18066117plm.0
 for <iommu@lists.linux-foundation.org>; Sun, 15 Aug 2021 08:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lqJuD6ruM5b7S82+pL+Pgu4dT3Aqj2AS9hae1tFkdRo=;
 b=UDo6cP9FMCJZ7xCJSIXhjRcP0ErAenE3P03nucshW6LzGwza1JB05cdoyvyJEbpJya
 8aLc4Djx0DAWFPSijwKCksggpzGOsA8NJq7xgbAAE0ffHXqq0QXSiy6tfbcSn5jEQof6
 2ma3PA51qPRAxAYmuW2j7KtkKsDVNuEpegmAaBxh1f/jI4N5cAWqPcx4oFXN2pO1Ashc
 87gLBUkKiBVoGeCUHLrBIQIIXvlCZHYUAOsOdCOfo4PAkq83QiSfgI8TAI23zhfr8YUr
 vMCV/udIh/MHgkHngzhYrcPnpUZMQSk6GK/ENzO0mZC8nGBR7d73iCxBtmg3WUTr+cQr
 /F0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lqJuD6ruM5b7S82+pL+Pgu4dT3Aqj2AS9hae1tFkdRo=;
 b=U6l0X1xEvy9GqjkOHVKlyQx8j7cZpdLIGOwTCCaO5cwC2WfC8TCvVeU/LumTdzvhRS
 NRwVO9kcZzpN+0K4YHw69Zg34+wj4JUFNVv2FLDysP/Q+Vmx+VZ4d+NCD91usieEPntX
 USYzDCdWTxNkR74F9Q7IBW1IOI5rqPfq8+HYUolHr3bo6GeN1ChzHgVfk5j5yGqtA0WT
 +KOUAQjKtbEgNoYa8abo9QLJTRJhFSldJF1FEHabHYHQAIWDygr83hEvXFIKGUlmaOrU
 YlCVhrBaGD+J+MgplproU6OJt2GQEOqCN0va5i89Zr9lYIln51gBGgkPFz2duXS7d7mZ
 RHeA==
X-Gm-Message-State: AOAM533Ro9K9xDoJNv6A1Zgrw8RCoL0ssC1BnfafzqMX0Cv10jwJ2WmN
 8kYGYnKSarQpcfMrWdEZO10=
X-Google-Smtp-Source: ABdhPJxpcs+C9yGRhB/oJwUav2sPEXUGNBEjk6Xqpn3/4lgsrB3QPLQ97I5YOwA+8w9+RuIKBCv5Rw==
X-Received: by 2002:a63:770f:: with SMTP id s15mr11711033pgc.137.1629040889118; 
 Sun, 15 Aug 2021 08:21:29 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 nn18sm6289319pjb.21.2021.08.15.08.21.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Aug 2021 08:21:28 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH V3 04/13] HV: Mark vmbus ring buffer visible to host in
 Isolation VM
To: Michael Kelley <mikelley@microsoft.com>, KY Srinivasan
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "luto@kernel.org" <luto@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "jgross@suse.com" <jgross@suse.com>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "jejb@linux.ibm.com"
 <jejb@linux.ibm.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "ardb@kernel.org" <ardb@kernel.org>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "pgonda@google.com" <pgonda@google.com>,
 "martin.b.radev@gmail.com" <martin.b.radev@gmail.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "rppt@kernel.org" <rppt@kernel.org>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "saravanand@fb.com" <saravanand@fb.com>,
 "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>,
 "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "rientjes@google.com" <rientjes@google.com>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>, "tj@kernel.org" <tj@kernel.org>
References: <20210809175620.720923-1-ltykernel@gmail.com>
 <20210809175620.720923-5-ltykernel@gmail.com>
 <MWHPR21MB1593CCBBBB83E721F8FDACD3D7F99@MWHPR21MB1593.namprd21.prod.outlook.com>
Message-ID: <43d4cb59-5ddd-516d-1f5c-4a1a799a9f2d@gmail.com>
Date: Sun, 15 Aug 2021 23:21:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB1593CCBBBB83E721F8FDACD3D7F99@MWHPR21MB1593.namprd21.prod.outlook.com>
Content-Language: en-US
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dave.hansen@intel.com" <dave.hansen@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 vkuznets <vkuznets@redhat.com>
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



On 8/13/2021 6:20 AM, Michael Kelley wrote:
>> @@ -474,6 +482,13 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
>>   	if (ret)
>>   		return ret;
>>
>> +	ret = set_memory_decrypted((unsigned long)kbuffer,
>> +				   HVPFN_UP(size));
>> +	if (ret) {
>> +		pr_warn("Failed to set host visibility.\n");
> Enhance this message a bit.  "Failed to set host visibility for new GPADL\n"
> and also output the value of ret.

OK. This looks better. Thanks.

> 
>> @@ -539,6 +554,10 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
>>   	/* At this point, we received the gpadl created msg */
>>   	*gpadl_handle = gpadlmsg->gpadl;
>>
>> +	channel->gpadl_array[index].size = size;
>> +	channel->gpadl_array[index].buffer = kbuffer;
>> +	channel->gpadl_array[index].gpadlhandle = *gpadl_handle;
>> +
> I can see the merits of transparently stashing the memory address and size
> that will be needed by vmbus_teardown_gpadl(), so that the callers of
> __vmbus_establish_gpadl() don't have to worry about it.  But doing the
> stashing transparently is somewhat messy.
> 
> Given that the callers are already have memory allocated to save the
> GPADL handle, a little refactoring would make for a much cleaner solution.
> Instead of having memory allocated for the 32-bit GPADL handle, callers
> should allocate the slightly larger struct vmbus_gpadl that you've
> defined below.  The calling interfaces can be updated to take a pointer
> to this structure instead of a pointer to the 32-bit GPADL handle, and
> you can save the memory address and size right along with the GPADL
> handle.  This approach touches a few more files, but I think there are
> only two callers outside of the channel management code -- netvsc
> and hv_uio -- so it's not a big change.

Yes, this is a good suggestion and Will update in the next version.

> 
>> @@ -859,6 +886,19 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, u32 gpadl_handle)
>>   	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
>>
>>   	kfree(info);
>> +
>> +	/* Find gpadl buffer virtual address and size. */
>> +	for (i = 0; i < VMBUS_GPADL_RANGE_COUNT; i++)
>> +		if (channel->gpadl_array[i].gpadlhandle == gpadl_handle)
>> +			break;
>> +
>> +	if (set_memory_encrypted((unsigned long)channel->gpadl_array[i].buffer,
>> +			HVPFN_UP(channel->gpadl_array[i].size)))
>> +		pr_warn("Fail to set mem host visibility.\n");
> Enhance this message a bit: "Failed to set host visibility in GPADL teardown\n".
> Also output the returned error code to help in debugging any occurrences of
> a failure
Yes, agree. Will update.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
