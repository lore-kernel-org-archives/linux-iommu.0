Return-Path: <SRS0=vo+x=MZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4ADC4338F
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 12:56:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E9060F6D
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 12:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 34E9060F6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00DAE4039B;
	Mon,  2 Aug 2021 12:56:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8vsv7fiaJ2Dw; Mon,  2 Aug 2021 12:56:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DA4E44014F;
	Mon,  2 Aug 2021 12:56:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73B5FC001B;
	Mon,  2 Aug 2021 12:56:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFD6CC000E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 12:56:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B0B9A83A85
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 12:56:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V-CJT-NnAztJ for <iommu@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 12:56:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3AD7183A5B
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 12:56:46 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 o44-20020a17090a0a2fb0290176ca3e5a2fso24566170pjo.1
 for <iommu@lists.linux-foundation.org>; Mon, 02 Aug 2021 05:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/GYPS7X+85wR6YC8425aJSok3ZXyi4U2bTyYNUsfO5w=;
 b=pyQkhPeDqOZN1lKQvpgjaZhDuqcfBH++qI9Yz80iquDkO6oGt+tBuSPtyV0nMGVBJ1
 M2E5aA/XAnoteOyDQT8M+x5AliZKopkoGnInKwL3m2QqBiWDu36W26gL/YPC8K/KeYlr
 lKiZUAf6XKEOBg70NsE3K9fU4mOPUUIoCYKqtgQQ2HjvRH1Q+CjUYFOowxeVCbfkbnu7
 GXswmjuYPprsxcXIE4NienyvsAMjibDdMeps+gxmOrpMJQUHeDF7e/9b+DgNRmsrf0dj
 R82WDqtlRqQuveuh5cTGWXuurfZKwGo+CrnXy7KJkYXeft1AWFi82RFU5cJODZER7tHh
 HwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/GYPS7X+85wR6YC8425aJSok3ZXyi4U2bTyYNUsfO5w=;
 b=g6HLTlfMf44nJzMETk+koy/qLx9Xbu+kQRdiDHf2He3SQn8fSTdFc0kwSmogEcQ84z
 p8PexZK1THmEA1QjuB9220p1EnZhDqLgKbiSAfEUdJ6WXuwdcY3t0w1cIux1Cia/CvIr
 BTX0Og1Ui0YZlQfh6n2Lv0hm0Q15+kw/bCUH04djDGK8o0Q9zuveI+ccmI9asBsxd5QX
 QGNRDt1DHV8uhgdtZnL6dyM83KIa0OI0EbO0Tqcn1ZG40Zh0dVRYhwbKyc8u3HPDQ7Qu
 hB1cV7fhmCEox/tYqccBiv3EjHz4/rQOe0WEFhxpoVcuYk+cUPA0SWIpWqPGNYkgJ+HW
 vN7Q==
X-Gm-Message-State: AOAM532uwvMGdzah13GxGJYYKuDrg/ZrYL1g5v7r761meTvm0E52jOe4
 /H0WvGGEdUS0DKLRfkgnSuE=
X-Google-Smtp-Source: ABdhPJyLDEEPYFYa8bCYhczgLUorbl2lwmF46SVfXQIXh/rESGtdQ+84YDRl3Rg46/KGbl2xu2SCOw==
X-Received: by 2002:a17:902:b48b:b029:12c:59b:dc44 with SMTP id
 y11-20020a170902b48bb029012c059bdc44mr14086944plr.47.1627909005643; 
 Mon, 02 Aug 2021 05:56:45 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 g7sm6679837pfv.66.2021.08.02.05.56.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Aug 2021 05:56:45 -0700 (PDT)
Subject: Re: [PATCH 04/13] HV: Mark vmbus ring buffer visible to host in
 Isolation VM
To: Joerg Roedel <joro@8bytes.org>
References: <20210728145232.285861-1-ltykernel@gmail.com>
 <20210728145232.285861-5-ltykernel@gmail.com> <YQfgH04t2SqacnHn@8bytes.org>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <173823d1-280c-d34e-be2c-157b55bb6bc3@gmail.com>
Date: Mon, 2 Aug 2021 20:56:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQfgH04t2SqacnHn@8bytes.org>
Content-Language: en-US
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, david@redhat.com,
 peterz@infradead.org, dave.hansen@linux.intel.com, vkuznets@redhat.com,
 hpa@zytor.com, anparri@microsoft.com, kys@microsoft.com, will@kernel.org,
 boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org, sfr@canb.auug.org.au,
 wei.liu@kernel.org, sstabellini@kernel.org, sthemmin@microsoft.com,
 xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
 aneesh.kumar@linux.ibm.com, x86@kernel.org, decui@microsoft.com, hch@lst.de,
 michael.h.kelley@microsoft.com, mingo@redhat.com, pgonda@google.com,
 rientjes@google.com, kuba@kernel.org, jejb@linux.ibm.com,
 martin.b.radev@gmail.com, thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com,
 keescook@chromium.org, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, akpm@linux-foundation.org,
 jgross@suse.com, martin.petersen@oracle.com, saravanand@fb.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kirill.shutemov@linux.intel.com,
 hannes@cmpxchg.org, ardb@kernel.org, robin.murphy@arm.com, davem@davemloft.net,
 rppt@kernel.org
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



On 8/2/2021 8:07 PM, Joerg Roedel wrote:
> On Wed, Jul 28, 2021 at 10:52:19AM -0400, Tianyu Lan wrote:
>> +	if (type == HV_GPADL_BUFFER)
>> +		index = 0;
>> +	else
>> +		index = channel->gpadl_range[1].gpadlhandle ? 2 : 1;
> 
> Hmm... This doesn't look very robust. Can you set fixed indexes for
> different buffer types? HV_GPADL_BUFFER already has fixed index 0. But
> as it is implemented here you risk that index 2 gets overwritten by
> subsequent calls.

Both second and third are HV_GPADL_RING type. One is send ring and the
other is receive ring. The driver keeps the order to allocate rx and
tx buffer. You are right this is not robust and will add a mutex to keep
the order.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
