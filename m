Return-Path: <SRS0=qbNH=NK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B00C4338F
	for <iommu@archiver.kernel.org>; Thu, 19 Aug 2021 09:59:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276CC61139
	for <iommu@archiver.kernel.org>; Thu, 19 Aug 2021 09:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 276CC61139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E18A840134;
	Thu, 19 Aug 2021 09:59:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NoNPWYo0Kbaz; Thu, 19 Aug 2021 09:59:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A642A400AE;
	Thu, 19 Aug 2021 09:59:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79C80C0010;
	Thu, 19 Aug 2021 09:59:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34AD2C000E
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 09:59:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1AFF2400C3
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 09:59:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wo4lqblGaqAC for <iommu@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 09:59:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C94C5400AE
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 09:59:17 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id a5so3611901plh.5
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 02:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DtRnMoZnz8ASe+6YEYHxKI9ebqeYiuiGyG8rZ+bU7W8=;
 b=e343ePw9FQBl3OmT4CjV4LRITbC1d6hYo+qRgo8O4g8DDiM0SXgUjKDzINrKBOdPuD
 16no3rFQBxZjEOjFpmVKbvGS3ZfHA34iGMzVP0GUuGwXxQcavGar4tq9NUO4BYQKL/fr
 +IcuileX2Ofw9lJAzZQDVNiSgg1ae4c7il80Ygl7Z/hArsq9NmfC57xbUCxKi+8x3zUf
 +2HPq01a+R9VEwnfGBnJGrLBlpiAjunOOPLv4ZoA/DAFfCnCqMOcoGxM88wGuVAJptCS
 RhIs91rvHPz+nEa9mRAXOsXqj+K3ODhUvtqP1kKQfDBVLC2qUMGw6g7AIb4+VxGalL4b
 xg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DtRnMoZnz8ASe+6YEYHxKI9ebqeYiuiGyG8rZ+bU7W8=;
 b=VhW38XuHrhEe1b+LxYzXiGbnWW8Z+l/0KoNhHuGnAnVTxw3njoJGpiYaFgsWoT9mlU
 iBV2zMcGSBGeyL27SNc/diZ837cqHFtFTa+IJHibQwSmZupx/i46QiKf5rNpGm1HElsE
 5+cXN7IGxrahfDNUwuO+mhO36gx3YUiP2D3yZOYzuP1hZnoJOwG7vAbnjLnfG2FgDGG3
 HQgV2GDPYBv655VJtKlE/RTUIFmNsaL0l9b08IlNybCdDZ7FaBA/FEQHOPPkrk3C0VRf
 WjdQXfT31Togs65aJ713STw7AgoB3os/Qapwuv3w0Tv5FchptBxG09B7LIZpNK5e/Nlz
 KRmw==
X-Gm-Message-State: AOAM530IVpdphaTS1NFkoYQObDU5BfQzmSXvx8fr0f9DoCWesVTOdcnM
 uBKZI47ARHaRBpuLlf85PmQ=
X-Google-Smtp-Source: ABdhPJxqSXdosZ9pc3k976d6RTkMk29F0RsgVn3Hn0/Mju7aILj/ApNHDMVBQRT0TOZLXDLJbYbMUw==
X-Received: by 2002:a17:90a:8905:: with SMTP id
 u5mr13892030pjn.95.1629367157291; 
 Thu, 19 Aug 2021 02:59:17 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 p24sm2697989pff.161.2021.08.19.02.59.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Aug 2021 02:59:16 -0700 (PDT)
Subject: Re: [PATCH V3 10/13] x86/Swiotlb: Add Swiotlb bounce buffer remap
 function for HV IVM
To: Christoph Hellwig <hch@lst.de>
References: <20210809175620.720923-1-ltykernel@gmail.com>
 <20210809175620.720923-11-ltykernel@gmail.com>
 <20210812122741.GC19050@lst.de>
 <d18ae061-6fc2-e69e-fc2c-2e1a1114c4b4@gmail.com>
 <890e5e21-714a-2db6-f68a-6211a69bebb9@gmail.com>
 <20210819084951.GA10461@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <1c5ae861-2c35-2ef5-e764-db45bbcb88a9@gmail.com>
Date: Thu, 19 Aug 2021 17:59:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210819084951.GA10461@lst.de>
Content-Language: en-US
Cc: parri.andrea@gmail.com, linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 peterz@infradead.org, dave.hansen@linux.intel.com, dave.hansen@intel.com,
 hpa@zytor.com, kys@microsoft.com, will@kernel.org, boris.ostrovsky@oracle.com,
 linux-arch@vger.kernel.org, sfr@canb.auug.org.au, wei.liu@kernel.org,
 sstabellini@kernel.org, sthemmin@microsoft.com, xen-devel@lists.xenproject.org,
 linux-scsi@vger.kernel.org, aneesh.kumar@linux.ibm.com, x86@kernel.org,
 decui@microsoft.com, ardb@kernel.org, michael.h.kelley@microsoft.com,
 mingo@redhat.com, pgonda@google.com, rientjes@google.com, kuba@kernel.org,
 jejb@linux.ibm.com, martin.b.radev@gmail.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, vkuznets@redhat.com,
 jgross@suse.com, martin.petersen@oracle.com, saravanand@fb.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, rppt@kernel.org, hannes@cmpxchg.org,
 tj@kernel.org, akpm@linux-foundation.org, robin.murphy@arm.com,
 davem@davemloft.net, kirill.shutemov@linux.intel.com
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



On 8/19/2021 4:49 PM, Christoph Hellwig wrote:
> On Mon, Aug 16, 2021 at 10:50:26PM +0800, Tianyu Lan wrote:
>> Hi Christoph:
>>        Sorry to bother you.Please double check with these two patches
>> " [PATCH V3 10/13] x86/Swiotlb: Add Swiotlb bounce buffer remap function
>> for HV IVM" and "[PATCH V3 09/13] DMA: Add dma_map_decrypted/dma_
>> unmap_encrypted() function".
> 
> Do you have a git tree somewhere to look at the whole tree?

Yes, here is my github link for these two patches.

https://github.com/lantianyu/linux/commit/462f7e4e44644fe7e182f7a5fb043a75acb90ee5

https://github.com/lantianyu/linux/commit/c8de236bf4366d39e8b98e5a091c39df29b03e0b

> 
>>        The swiotlb bounce buffer in the isolation VM are allocated in the
>> low end memory and these memory has struct page backing. All dma address
>> returned by swiotlb/DMA API are low end memory and this is as same as what
>> happen in the traditional VM.
> 
> Indeed.
> 
>>        The API dma_map_decrypted() introduced in the patch 9 is to map the
>> bounce buffer in the extra space and these memory in the low end space are
>> used as DMA memory in the driver. Do you prefer these APIs
>> still in the set_memory.c? I move the API to dma/mapping.c due to the
>> suggested name arch_dma_map_decrypted() in the previous mail
>> (https://lore.kernel.org/netdev/20210720135437.GA13554@lst.de/).
> 
> Well, what would help is a clear description of the semantics.
> 

Yes, I will improve description.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
