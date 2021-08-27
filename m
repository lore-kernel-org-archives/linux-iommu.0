Return-Path: <SRS0=n6uX=NS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A2DC432BE
	for <iommu@archiver.kernel.org>; Fri, 27 Aug 2021 17:44:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7196E60EE4
	for <iommu@archiver.kernel.org>; Fri, 27 Aug 2021 17:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7196E60EE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 437BC61588;
	Fri, 27 Aug 2021 17:44:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WP7wpxvE9PJI; Fri, 27 Aug 2021 17:44:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2112F606A7;
	Fri, 27 Aug 2021 17:44:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06393C001A;
	Fri, 27 Aug 2021 17:44:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 888D2C000E
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 17:44:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8436580EBA
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 17:44:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 09ZrGvZsKYuR for <iommu@lists.linux-foundation.org>;
 Fri, 27 Aug 2021 17:44:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E6BD580EA9
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 17:44:20 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 mw10-20020a17090b4d0a00b0017b59213831so9406687pjb.0
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 10:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LPKfuH70y/vowO9PogQlJQs9AemsPOeU5ZCyLaISG1Y=;
 b=HwSSFNicSK0d8SJfbUpGx09hgwlFzVWra5FZoqLpsFB/x+51WvKuctBr6nLXMbO6cf
 M1YA50WBdM0sWHzlp8j5U7XFU84mU13uWGJrK8+pOLzbMDCsX1Sb/xNi2BmSDxbbcXza
 R18ghXowDtCyeUc0qDEp5lcHL3m3iI8G2JsyOod/a4nBKBGxuBgrXX8PcOrPD7xp9VuO
 /+6ym70TQrPMXo7VYAa03ZCcmf5mxE8qkNCNyybf9pWzAIB3F4pHZ8tqL8sUNkUxGXH3
 q5CzVfUu6vNAAN98cQcEw1tC7x5O4qdEugSSAeEekjMP6TLGMepEq4/gpZFscPhnAz0o
 9ETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LPKfuH70y/vowO9PogQlJQs9AemsPOeU5ZCyLaISG1Y=;
 b=loP5AzW/fi1Di0PdWHdq/mOb5Y1TLZRNrrKiNIUw992OnwfIIKv6h/IlvdRZNDBxed
 OGBxsngKjgtIEiGnmJYfQpbvgpzNOTKYAatQacOGj9ZeX4u6n7XGOPsvma5mrVvU5o2H
 iVnUQmxXLX5APtgDjaDIy005ReIvdalfAPpX4U1GQtL75Bl+YaEIq/W3NaeJ+5E6KlMM
 s/tjTIEJKD29ZCQTp16SBtN/KHTM6gCXnc4VTrumWclpL+GvqAS6oSNxyMPdCrGPNSV1
 WHRkWH3US5Dq7cu9ZgNV9DpTbUJT5SC20gZ5H3zlmeAcSIGxX7jz1K7HBJ8XZK1YzdhR
 sdsA==
X-Gm-Message-State: AOAM533DysuzCI11gUuI5dTKmVVk7WBgjX4Qt2dYzAfyG9+QA8yo5ZP7
 lqxToe3ZI9plZxYcJ9/KeBM=
X-Google-Smtp-Source: ABdhPJwvLuJzWOILGWQdJGs2DQihxg3sZ7HLxdKN9J7wFpGmDHFz6cyOnG8qdErrHdAKkfy0VbG6/g==
X-Received: by 2002:a17:902:c9d5:b0:138:9a20:4bd9 with SMTP id
 q21-20020a170902c9d500b001389a204bd9mr4222493pld.34.1630086260299; 
 Fri, 27 Aug 2021 10:44:20 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 t186sm7124382pfb.53.2021.08.27.10.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Aug 2021 10:44:19 -0700 (PDT)
Subject: Re: [PATCH V4 04/13] hyperv: Mark vmbus ring buffer visible to host
 in Isolation VM
To: Greg KH <gregkh@linuxfoundation.org>
References: <20210827172114.414281-1-ltykernel@gmail.com>
 <20210827172114.414281-5-ltykernel@gmail.com> <YSkjsapeNj+2j//o@kroah.com>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <5d665aff-f200-3b1d-7b9b-2f080cf59a59@gmail.com>
Date: Sat, 28 Aug 2021 01:44:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSkjsapeNj+2j//o@kroah.com>
Content-Language: en-US
Cc: parri.andrea@gmail.com, linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 peterz@infradead.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
 dave.hansen@intel.com, hpa@zytor.com, kys@microsoft.com, will@kernel.org,
 boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org, wei.liu@kernel.org,
 sstabellini@kernel.org, sthemmin@microsoft.com, xen-devel@lists.xenproject.org,
 linux-scsi@vger.kernel.org, aneesh.kumar@linux.ibm.com, x86@kernel.org,
 decui@microsoft.com, hch@lst.de, michael.h.kelley@microsoft.com,
 mingo@redhat.com, pgonda@google.com, rientjes@google.com, kuba@kernel.org,
 jejb@linux.ibm.com, martin.b.radev@gmail.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, vkuznets@redhat.com,
 linux-arm-kernel@lists.infradead.org, jgross@suse.com,
 martin.petersen@oracle.com, saravanand@fb.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 rppt@kernel.org, hannes@cmpxchg.org, ardb@kernel.org,
 akpm@linux-foundation.org, robin.murphy@arm.com, davem@davemloft.net,
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

Hi Greg:
      Thanks for your review.

On 8/28/2021 1:41 AM, Greg KH wrote:
> On Fri, Aug 27, 2021 at 01:21:02PM -0400, Tianyu Lan wrote:
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> Mark vmbus ring buffer visible with set_memory_decrypted() when
>> establish gpadl handle.
>>
>> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> ---
>> Change since v3:
>>         * Change vmbus_teardown_gpadl() parameter and put gpadl handle,
>>         buffer and buffer size in the struct vmbus_gpadl.
>> ---
>>   drivers/hv/channel.c            | 36 ++++++++++++++++++++++++++++-----
>>   drivers/net/hyperv/hyperv_net.h |  1 +
>>   drivers/net/hyperv/netvsc.c     | 16 +++++++++++----
>>   drivers/uio/uio_hv_generic.c    | 14 +++++++++++--
>>   include/linux/hyperv.h          |  8 +++++++-
>>   5 files changed, 63 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
>> index f3761c73b074..82650beb3af0 100644
>> --- a/drivers/hv/channel.c
>> +++ b/drivers/hv/channel.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/hyperv.h>
>>   #include <linux/uio.h>
>>   #include <linux/interrupt.h>
>> +#include <linux/set_memory.h>
>>   #include <asm/page.h>
>>   #include <asm/mshyperv.h>
>>   
>> @@ -474,6 +475,13 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
>>   	if (ret)
>>   		return ret;
>>   
>> +	ret = set_memory_decrypted((unsigned long)kbuffer,
>> +				   HVPFN_UP(size));
>> +	if (ret) {
>> +		pr_warn("Failed to set host visibility for new GPADL %d.\n", ret);
> 
> dev_warn()?  You have access to a struct device, why not use it?
> 
> same for all other instances here.
> 
>

Yes, dav_warn() is better. Will update in the next version. Thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
