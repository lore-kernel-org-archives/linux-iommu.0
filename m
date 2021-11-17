Return-Path: <SRS0=sOBO=QE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E67DC433EF
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 13:32:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F0261B3A
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 13:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A5F0261B3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6E56F40208;
	Wed, 17 Nov 2021 13:32:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TJfu6xmNiuPv; Wed, 17 Nov 2021 13:32:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3303D400D2;
	Wed, 17 Nov 2021 13:32:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BDE2C002E;
	Wed, 17 Nov 2021 13:32:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C731C0012
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 13:32:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B6114091F
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 13:32:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GoZpZzJ0Pgri for <iommu@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 13:32:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB4544091E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 13:32:26 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id z6so985399plk.6
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 05:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=zR3oNRYhTYJUZxaoak8qMlUuBunZjm5m9hqskt3h3S4=;
 b=ggvPHm4xgldOYNuvLAK0wCZC8fi4QdT92wt9aO0Z1D+A8KeOi+P1P1JWtXkWduE+Ch
 r6ou4FvXsNhepLE8E70VqGkz+/lDwWv7enCCiPmHwIBtd8kf2It6TjK/tqJvLKuShbGK
 0bql4MAv8/pbMx8YyG0cDh/0zTFZMrBCBap5FVuQdaMLz170KD8tA2xrwcyOnV2CGSaU
 XC9McvnV4rtzWcYyCt8336Tl0rj1KT9TWDrtW7oGGCWhI41aW30RYAShzVcOFPieXpQ2
 2szScJ98dW1z6BZ6y4Px5EjFn8WqTBG7cb5V8p7izkymWXTEpGK00GSfEtG9CuZzRkDF
 KZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=zR3oNRYhTYJUZxaoak8qMlUuBunZjm5m9hqskt3h3S4=;
 b=u5nd22WehcL94arjb5xiBeYBdLmBAuXdELfephsv6vQO3Nt6EVFiMPL4vaWqh3biTe
 pyvN8lp7FXpRIWsc8fPbq00j6o43L8RG0YC04VBmwOMhzq1NFDkNdSx4t1VRr5gTo+uB
 Fyztq7fCCDvx5yIVEDgU5oaSlvx3+HtQa6RPQoq+dZN3FSUHZR3FCqEMbYsrzYpCvv5m
 aJKPkQKdHqcRaRQ4XuRofXDGxzhKVS2j/D7i0w6dxafTKNsSw4D3AS/hZfaIQQud9Llw
 n9AoyjcsR9qBIQpn+hO6qanTL8ihhz1GFJtOmGM2Myo4O3NbWIPwrKPkNGabnxGpU+d1
 Zpdw==
X-Gm-Message-State: AOAM530trPjXXtkNk2UmRyK6EMWN72hTSkF+DWe8ju6xjLSG76M9gg8L
 kyoo3TbSbNgWCperqfhtn+U=
X-Google-Smtp-Source: ABdhPJzUpe9LLZVlH0z5E35okJoiJmMYQnfNMpmq8a9kmB7F5FUzY6wGExQKYAIJCpzqgtl9+SISaw==
X-Received: by 2002:a17:90a:ab17:: with SMTP id
 m23mr9499872pjq.194.1637155946398; 
 Wed, 17 Nov 2021 05:32:26 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50b? ([2404:f801:9000:1a:efea::50b])
 by smtp.gmail.com with ESMTPSA id
 y28sm23237747pfa.208.2021.11.17.05.32.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Nov 2021 05:32:26 -0800 (PST)
Message-ID: <0ab42ae0-9323-9297-c2c8-1cfc1ebada08@gmail.com>
Date: Wed, 17 Nov 2021 21:32:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 1/5] x86/Swiotlb: Add Swiotlb bounce buffer remap function
 for HV IVM
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20211116153923.196763-1-ltykernel@gmail.com>
 <20211116153923.196763-2-ltykernel@gmail.com> <20211117095953.GA10330@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20211117095953.GA10330@lst.de>
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, peterz@infradead.org,
 dave.hansen@linux.intel.com, dave.hansen@intel.com, hpa@zytor.com,
 kys@microsoft.com, will@kernel.org, boris.ostrovsky@oracle.com,
 wei.liu@kernel.org, sstabellini@kernel.org, sthemmin@microsoft.com,
 linux-scsi@vger.kernel.org, x86@kernel.org, decui@microsoft.com,
 michael.h.kelley@microsoft.com, mingo@redhat.com, kuba@kernel.org,
 haiyangz@microsoft.com, parri.andrea@gmail.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, konrad.wilk@oracle.com,
 jejb@linux.ibm.com, bp@alien8.de, luto@kernel.org,
 xen-devel@lists.xenproject.org, tglx@linutronix.de, jgross@suse.com,
 martin.petersen@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, robin.murphy@arm.com, davem@davemloft.net
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

On 11/17/2021 5:59 PM, Christoph Hellwig wrote:
> The subject is wrong, nothing x86-specific here.  Please use
> "swiotlb: " as the prefix

OK. Will update. Thanks.

> 
>> + * @vaddr:	The vaddr of the swiotlb memory pool. The swiotlb
>> + *		memory pool may be remapped in the memory encrypted case and store
> 
> Please avoid the overly long line. >
>> +	/*
>> +	 * With swiotlb_unencrypted_base setting, swiotlb bounce buffer will
>> +	 * be remapped in the swiotlb_update_mem_attributes() and return here
>> +	 * directly.
>> +	 */
> 
> I'd word this as:
> 
> 	/*
> 	 * If swiotlb_unencrypted_base is set, the bounce buffer memory will
> 	 * be remapped and cleared in swiotlb_update_mem_attributes.
> 	 */

Thanks for suggestion. Will update. Thanks.


>> +	ret = swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, false);
>> +	if (ret) {
>> +		memblock_free(mem->slots, alloc_size);
>> +		return ret;
>> +	}
> 
> With the latest update swiotlb_init_io_tlb_mem will always return 0,
> so no need for the return value change or error handling here.
> 

OK. Will revert the change.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
