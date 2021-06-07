Return-Path: <SRS0=ynGH=LB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E49DC4743F
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 08:15:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0EE8611ED
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 08:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EE8611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66B6E402DA;
	Mon,  7 Jun 2021 08:14:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id myMRcRoTBkmz; Mon,  7 Jun 2021 08:14:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB9F540195;
	Mon,  7 Jun 2021 08:14:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78A07C000D;
	Mon,  7 Jun 2021 08:14:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C1E7C0001
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 08:14:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E605B82675
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 08:14:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aJJG3pVdhYIH for <iommu@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 08:14:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 08EBC823E3
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 08:14:50 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id v13so8198287ple.9
 for <iommu@lists.linux-foundation.org>; Mon, 07 Jun 2021 01:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=c5tZw1PE5ja1kIfp0A9CThFtz7RTJJ96vn5JKsdn4zo=;
 b=XoQyLvz24OoCRIOShkQNcu9DiR7bBkokC0zH2y0VsTYjxJfKw7R0siA80dncjT3YUK
 wAQolPJ8LMP2QAHMUANfaqPmSCX0C5CGSEEQPtRRcQTl1EKUo8gRIPdRN/yizwXOvk7a
 MyxLl0xOVUFh4CzE2lkyyns1y8zU/3BfW8wnjMepLuBa14dDIuRlcgHvnJy9KhXaOr8X
 f1b1b3SWDcQzR8oj41QVFoJZ6XqUPNURZphda8kDAwgTk/UUkxjzRis3jA/H1Gt2YM49
 MOGgQu1k2QTfbhGmrfPyoKrM3mYFHKWoquCiDY9UKYa1vj3gMvLKx5aFnrcD/cKhHcp4
 J8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c5tZw1PE5ja1kIfp0A9CThFtz7RTJJ96vn5JKsdn4zo=;
 b=crbOqi15B+JzoHKhbsS1LEWVTqiOyRJ4QYvvTEJTHkz4ntMXOpSfpXwK/BmvHDSCcn
 Gb5I4BBRYK8SOv9ZSCy/hSyrL2K2GakwbGVdRtBAxhMXBj0l90RWMZNZblb1/1pPqomf
 Hc2hi/YhQqTEwZb+Siahw/ScpKj+x5hPdhbns23Dx7xusM1Ee8jSEmsaEwdGMSRdrLBm
 0COUUlOFh4ooiZkts8Yl+EDL4QHeu+gfO0iiGWmb27v2BIwQx7Q2XWcoaOXofRCDx8QG
 8T32xgFKc79DkEVaCd1O1mjHw13yeo6M0K/9nOidrF4DLYnEWektxVw7n0nZj+UEkiEq
 BvoA==
X-Gm-Message-State: AOAM531FIzg8s8LORvp9RrYfgiEnoSMDTQVcp2gOLBwHMAMtGEevBy7d
 nxv3pZCogsIr887Pgbjk07s=
X-Google-Smtp-Source: ABdhPJz5DsUF3lCnv8yQA4dIwCqwn7lOEnqmDAyx9VQ48+J+hBL0/9GZGiwWD3mDm4r9zCHOflaTmA==
X-Received: by 2002:a17:902:9a42:b029:f5:1cf7:2e52 with SMTP id
 x2-20020a1709029a42b02900f51cf72e52mr16701852plv.25.1623053690127; 
 Mon, 07 Jun 2021 01:14:50 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 r11sm8236573pgl.34.2021.06.07.01.14.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jun 2021 01:14:49 -0700 (PDT)
Subject: Re: [RFC PATCH V3 01/11] x86/HV: Initialize GHCB page in Isolation VM
To: Christoph Hellwig <hch@lst.de>
References: <20210530150628.2063957-1-ltykernel@gmail.com>
 <20210530150628.2063957-2-ltykernel@gmail.com>
 <20210607064142.GA24478@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <37260f47-bd32-08f7-b006-f75f4d3c408a@gmail.com>
Date: Mon, 7 Jun 2021 16:14:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210607064142.GA24478@lst.de>
Content-Language: en-US
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, peterz@infradead.org,
 dave.hansen@linux.intel.com, hpa@zytor.com, kys@microsoft.com, will@kernel.org,
 boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org, wei.liu@kernel.org,
 sstabellini@kernel.org, sthemmin@microsoft.com, linux-scsi@vger.kernel.org,
 x86@kernel.org, decui@microsoft.com, mingo@redhat.com,
 xen-devel@lists.xenproject.org, jejb@linux.ibm.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, kuba@kernel.org, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, vkuznets@redhat.com,
 jgross@suse.com, martin.petersen@oracle.com, saravanand@fb.com,
 netdev@vger.kernel.org, sunilmut@microsoft.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kirill.shutemov@linux.intel.com,
 hannes@cmpxchg.org, cai@lca.pw, akpm@linux-foundation.org,
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

Hi Christoph:
	Thanks for your review.

On 6/7/2021 2:41 PM, Christoph Hellwig wrote:
> On Sun, May 30, 2021 at 11:06:18AM -0400, Tianyu Lan wrote:
>> +	if (ms_hyperv.ghcb_base) {
>> +		rdmsrl(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
>> +
>> +		ghcb_va = ioremap_cache(ghcb_gpa, HV_HYP_PAGE_SIZE);
>> +		if (!ghcb_va)
>> +			return -ENOMEM;
> 
> Can you explain this a bit more?  We've very much deprecated
> ioremap_cache in favor of memremap.  Why yo you need a __iomem address
> here?  Why do we need the remap here at all? >

GHCB physical address is an address in extra address space which is 
above shared gpa boundary reported by Hyper-V CPUID. The addresses below
shared gpa boundary treated as encrypted and the one above is treated as 
decrypted. System memory is remapped in the extra address space and it 
starts from the boundary. The shared memory with host needs to use 
address in the extra address(pa + shared_gpa_boundary) in Linux guest.

Here is to map ghcb page for the communication operations with 
Hypervisor(e.g, hypercall and read/write MSR) via GHCB page.

memremap() will go through iomem_resource list and the address in extra 
address space will not be in the list. So I used ioremap_cache(). I will
memremap() instead of ioremap() here.

> Does the data structure at this address not have any types that we
> could use a struct for?

The struct will be added in the following patch. I will refresh the 
following patch and use the struct hv_ghcb for the mapped point.
> 
>> +
>> +		rdmsrl(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
>> +		ghcb_va = ioremap_cache(ghcb_gpa, HV_HYP_PAGE_SIZE);
>> +		if (!ghcb_va) {
> 
> This seems to duplicate the above code.

The above is to map ghcb for BSP and here does the same thing for APs
Will add a new function to avoid the duplication.

> 
>> +bool hv_isolation_type_snp(void)
>> +{
>> +	return static_branch_unlikely(&isolation_type_snp);
>> +}
>> +EXPORT_SYMBOL_GPL(hv_isolation_type_snp);
> 
> This probably wants a kerneldoc explaining when it should be used. >

OK. I will add.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
