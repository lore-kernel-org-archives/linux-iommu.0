Return-Path: <SRS0=vo+x=MZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B48C432BE
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 13:18:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F9860F6D
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 13:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 53F9860F6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 02BAF4038C;
	Mon,  2 Aug 2021 13:18:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HJrPNYH-7CUk; Mon,  2 Aug 2021 13:18:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5004940215;
	Mon,  2 Aug 2021 13:18:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 299D5C0010;
	Mon,  2 Aug 2021 13:18:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FEBAC000E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 13:18:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4157E82B9F
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 13:18:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6vQ3koufvtBx for <iommu@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 13:18:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 11C3282B69
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 13:18:34 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 pj14-20020a17090b4f4eb029017786cf98f9so14033428pjb.2
 for <iommu@lists.linux-foundation.org>; Mon, 02 Aug 2021 06:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NCI3lHDyDwNRa9nHRAWUMeIv6E94OBk/ArQgKFFM5dk=;
 b=PML2k1Dht8uODKlH3PjAFdc6s/CTDMJQb0vSXp+tWKBkOZKDTm+GB/eR8aVXQ70FAX
 jEcnBX+WXP5rLcq4W5X5HFrW9hJ51Vmvgvy8hGNIdNIWJPbXr/Z0woDD3x3PwhBautYj
 f/s264QOiroQXi9rnewmDedviFD+3T3gC4ei7Z5FsKr/y65Ls/dYfdoaKAM+Ec2wHvVd
 aA36ny4fOTLJxiB1mC/JAk1BfVfacZyAbJGrI98dEdqVsjhB5uZtuVM6yydcCZZA8s9D
 eyWMrETGzJOpt/w2FVnHDuzrREi+J5sEiaxqqYpsUx4zqF5/iQRjwnI3UJJpHaysMi13
 lAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NCI3lHDyDwNRa9nHRAWUMeIv6E94OBk/ArQgKFFM5dk=;
 b=U2/5OZ07hxJ6RoZTqUniww55nSd1QtcO4lzVfVOC4AmrFi2aC+GM+VqGZlxnw9iudh
 rkCVJyyciVHE8VHFtZBidToXo9N1fHKRiXmUqPo6iJkUvKlGQyuDM8M+ukgQDR6nrCst
 Ly0tf1I6Kwd0znpeElIt8or3og1ri3DYhkxm5PBhql+34fcEowOl9SxZ4hw5MnpJofzx
 JfOqCxfvSY2gfakMIUj+vZsTK+LxxcfQxRebxWspcXpECk83lEDXowvHecbBfdQk/b4i
 +8ohRJc+3a7p28a4fVWbORWf9dRD31C3Ix33Ml0nuXrlPoyQj48kO3h06TNFl8eJDqtP
 r22g==
X-Gm-Message-State: AOAM532mmCOSzZDaABGPI3sjZy/01PBRZoQUuFrIKGCHZskVNgmiyteT
 kJNsE2MZPF52Km2/MVOoaHE=
X-Google-Smtp-Source: ABdhPJzFSB7pHIeqEWjNLoxbHlaMRkkWu5nfzAixwCVuwFPeXy4oAXbwBpyGfDBS8UB6XOVjOVOqpg==
X-Received: by 2002:a62:5587:0:b029:3af:776c:2d02 with SMTP id
 j129-20020a6255870000b02903af776c2d02mr16019093pfb.11.1627910314492; 
 Mon, 02 Aug 2021 06:18:34 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 e13sm12540053pfd.11.2021.08.02.06.18.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Aug 2021 06:18:32 -0700 (PDT)
Subject: Re: [PATCH 05/13] HV: Add Write/Read MSR registers via ghcb page
To: Joerg Roedel <joro@8bytes.org>
References: <20210728145232.285861-1-ltykernel@gmail.com>
 <20210728145232.285861-6-ltykernel@gmail.com> <YQfk9G+k0Tj8ihyu@8bytes.org>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <988f20e4-821f-b493-c25d-ca9107a6e891@gmail.com>
Date: Mon, 2 Aug 2021 21:18:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQfk9G+k0Tj8ihyu@8bytes.org>
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

On 8/2/2021 8:28 PM, Joerg Roedel wrote:
> On Wed, Jul 28, 2021 at 10:52:20AM -0400, Tianyu Lan wrote:
>> +void hv_ghcb_msr_write(u64 msr, u64 value)
>> +{
>> +	union hv_ghcb *hv_ghcb;
>> +	void **ghcb_base;
>> +	unsigned long flags;
>> +
>> +	if (!ms_hyperv.ghcb_base)
>> +		return;
>> +
>> +	WARN_ON(in_nmi());
>> +
>> +	local_irq_save(flags);
>> +	ghcb_base = (void **)this_cpu_ptr(ms_hyperv.ghcb_base);
>> +	hv_ghcb = (union hv_ghcb *)*ghcb_base;
>> +	if (!hv_ghcb) {
>> +		local_irq_restore(flags);
>> +		return;
>> +	}
>> +
>> +	memset(hv_ghcb, 0x00, HV_HYP_PAGE_SIZE);
> 
> Do you really need to zero out the whole 4k? The validation bitmap
> should be enough, there are no secrets on the page anyway.
> Same in hv_ghcb_msr_read().

OK. Thanks for suggestion. I will have a try.

> 
>> +enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
>> +				   struct es_em_ctxt *ctxt,
>> +				   u64 exit_code, u64 exit_info_1,
>> +				   u64 exit_info_2)
>>   {
>>   	enum es_result ret;
>>   
>> @@ -109,7 +109,16 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
>>   	ghcb_set_sw_exit_info_1(ghcb, exit_info_1);
>>   	ghcb_set_sw_exit_info_2(ghcb, exit_info_2);
>>   
>> -	sev_es_wr_ghcb_msr(__pa(ghcb));
>> +	/*
>> +	 * Hyper-V runs paravisor with SEV. Ghcb page is allocated by
>> +	 * paravisor and not needs to be updated in the Linux guest.
>> +	 * Otherwise, the ghcb page's PA reported by paravisor is above
>> +	 * VTOM. Hyper-V use this function with NULL for ctxt point and
>> +	 * skip setting ghcb page in such case.
>> +	 */
>> +	if (ctxt)
>> +		sev_es_wr_ghcb_msr(__pa(ghcb));
> 
> No, do not make this function work with ctxt==NULL. Instead, factor out
> a helper function which contains what Hyper-V needs and use that in
> sev_es_ghcb_hv_call() and Hyper-V code.
> 

OK. Will update.

>> +union hv_ghcb {
>> +	struct ghcb ghcb;
>> +} __packed __aligned(PAGE_SIZE);
> 
> I am curious what this will end up being good for.
> 

Hyper-V introduces a specific hypercall request in GHCB page and use 
same union in the Linux Hyper-V code to read/write MSR and call the new 
hypercall request.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
