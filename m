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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B99C4338F
	for <iommu@archiver.kernel.org>; Thu, 19 Aug 2021 10:03:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEA7E61139
	for <iommu@archiver.kernel.org>; Thu, 19 Aug 2021 10:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AEA7E61139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7017880CFF;
	Thu, 19 Aug 2021 10:03:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JjHAZzcCbJkY; Thu, 19 Aug 2021 10:03:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3932980E57;
	Thu, 19 Aug 2021 10:03:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3EA1C0010;
	Thu, 19 Aug 2021 10:03:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB78DC000E
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 10:03:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A2826400C3
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 10:03:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zzZvhhCnDxjF for <iommu@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 10:03:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8536F400AE
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 10:03:19 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id x1so1052433plg.10
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 03:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0Z5bZ3ATC9rIbWdXJn4JmmnZhJaPoQBdkWHt9cjrKG8=;
 b=IT2Usca3A4sKF8ubQedNM5SaMd/P+GOOPAsVwIijlGErP0fzExJmYSY+A4eUcUkpXJ
 rlIgf13cji4zTPlulH73wgPhlbbzcXLto1AWAY23pc05ugnHQG+lyNsgg/hndXCJDvOZ
 akViMH02DTRkHylRGYPHa/SdGfpAhtYNgDzsjZBFu8ziREk5Ir52t81sOV2jRIjUiWu/
 9kVTMEdyW5UV9EJv7Rbge0li4OczD1s3+x4R5IGStjZTrxrYWtpg+4kGHyRYWdS60W/5
 Am1K2wsgWrjeJ9fH+MvIMoJfBnS3nAhxZjbc45vuLQjaMveZqMq4x3zvuPukeR63TOml
 jWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0Z5bZ3ATC9rIbWdXJn4JmmnZhJaPoQBdkWHt9cjrKG8=;
 b=KSEg7Q2KMCFB7+oY2Y/B7nzM51iajT8RGmaBzjqgTM/hV8C9YIpCHHy+63gaQEFW1x
 lS9icpwzaUt4144G6KjhtD7p52LU39Ie+f2skhakI+kM1kXPCKLejChOuSlJdePNKmQl
 A03xLo0amUypeI+XkrPUstVzqNI42jWUTECBKNGjpmOp0uFs5lAXy6wNtpgcEuJ/B/72
 D5L/hNk8zuR99lbk93mscRAbrbz2uSpTUi0ejtsUyej3pjn9W5ItBYfbu7TXY2nUbpRN
 Dc8syolIS3w7sH2Q4Os9qDyT6APEe4TMB3DxEmaPVunLmSNp98FbTAjYNOLxHIRXoYVe
 Zbkg==
X-Gm-Message-State: AOAM530IHxt9aURaifs+yADOtI75vGgsZQzZXII0GqkgUzRmAy+qZ4o5
 cgdowfgsYYWP+9jwUCs+fAY=
X-Google-Smtp-Source: ABdhPJzfJPRP2BLYCvwXpllkEgoVoCQWlDbtUrPyndvtVP/tYRGu2BCJLYGTmAw6sGYSn2DMVJ/QVQ==
X-Received: by 2002:a17:902:bc4b:b029:12d:77e8:2c26 with SMTP id
 t11-20020a170902bc4bb029012d77e82c26mr10961353plz.67.1629367398962; 
 Thu, 19 Aug 2021 03:03:18 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 l11sm2847556pfd.187.2021.08.19.03.03.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Aug 2021 03:03:18 -0700 (PDT)
Subject: Re: [PATCH V3 10/13] x86/Swiotlb: Add Swiotlb bounce buffer remap
 function for HV IVM
To: Christoph Hellwig <hch@lst.de>
References: <20210809175620.720923-1-ltykernel@gmail.com>
 <20210809175620.720923-11-ltykernel@gmail.com>
 <20210812122741.GC19050@lst.de>
 <d18ae061-6fc2-e69e-fc2c-2e1a1114c4b4@gmail.com>
 <890e5e21-714a-2db6-f68a-6211a69bebb9@gmail.com>
 <20210819084951.GA10461@lst.de>
 <1c5ae861-2c35-2ef5-e764-db45bbcb88a9@gmail.com>
 <20210819100200.GA16908@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <8bcadc06-ce4c-8be9-c1ac-44c544e02960@gmail.com>
Date: Thu, 19 Aug 2021 18:03:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210819100200.GA16908@lst.de>
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

On 8/19/2021 6:02 PM, Christoph Hellwig wrote:
> On Thu, Aug 19, 2021 at 05:59:02PM +0800, Tianyu Lan wrote:
>>
>>
>> On 8/19/2021 4:49 PM, Christoph Hellwig wrote:
>>> On Mon, Aug 16, 2021 at 10:50:26PM +0800, Tianyu Lan wrote:
>>>> Hi Christoph:
>>>>         Sorry to bother you.Please double check with these two patches
>>>> " [PATCH V3 10/13] x86/Swiotlb: Add Swiotlb bounce buffer remap function
>>>> for HV IVM" and "[PATCH V3 09/13] DMA: Add dma_map_decrypted/dma_
>>>> unmap_encrypted() function".
>>>
>>> Do you have a git tree somewhere to look at the whole tree?
>>
>> Yes, here is my github link for these two patches.
>>
>> https://github.com/lantianyu/linux/commit/462f7e4e44644fe7e182f7a5fb043a75acb90ee5
>>
>> https://github.com/lantianyu/linux/commit/c8de236bf4366d39e8b98e5a091c39df29b03e0b
> 
> Which branch is this?
> 

https://github.com/lantianyu/linux/tree/isolationv3
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
