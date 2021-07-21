Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F2AC636C9
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 15:11:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591666135B
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 15:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591666135B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A27D402E9;
	Wed, 21 Jul 2021 15:11:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4bE5dG1zpoYh; Wed, 21 Jul 2021 15:11:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BC17D402D8;
	Wed, 21 Jul 2021 15:11:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9CB05C001A;
	Wed, 21 Jul 2021 15:11:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65EC4C000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 15:11:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4CD5B82D2F
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 15:11:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rP04Uq1QaD4E for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 15:11:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BF26282D2D
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 15:11:42 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 g4-20020a17090ace84b029017554809f35so4189059pju.5
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 08:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=D1h2d+g+iMU4/jGzVM3W4ntrau1j74+yLE1tV8PoAic=;
 b=JudKBwJXYhQRbS+X/S9haoQpA4vJDhCumYWHOc7uZasKxl1Q15/54S3UgtA5DU2MnM
 lzw3uMGa0951XioyMj3JRFDtKLLdbQZHKtkmzd142ej6G99ZpSQbf4pbYKJMHmvy2Mvg
 n+IsgH/Gi14qKpxeEr/tuJjCd3FpmXh2SNA8p3U4jEKfIwjxFSccYMGg+ONArMU/Wu6E
 XfXZg/05bIatm0Sic/3vAKBQLh3YqfKOOK2+BKsvSUdJLbF0e9ivPdg52QOQvmKU+WWe
 jjv9l41sek6SngfQtz7UvvRRFhkx72h8LHByGOFdzs8RI71z4WB014t9ZJNaOfnnb+nh
 5peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D1h2d+g+iMU4/jGzVM3W4ntrau1j74+yLE1tV8PoAic=;
 b=VyByPc8649x9QrxOWldnOgoG4sKGDjUrxMf0oaKZSC9qZSpQnfLXHiVc+m+YiNx8yA
 d2d5Qrio4NFgcNbV79X3bZ1S+c1SlfZFjT0yD2kuJbivwegl6F+S2J6IY1x+NOrvM6e6
 Re9dMASoPr+EjteVXXOvkiverHqyNFtP5AUckbEWUjCtSLVjc7we1vR+LeHGANGxErjE
 0ymn5tSQPnI/5c4chK2SqsbIC9cMwpZZIYwX7FoHg4EZJqjHp0h2XMfsrXKckpSfFNYr
 P8fr+mSmI+J7h0EAHJRi+GZLAMcjfNdb9S5ogu+8dajdRz5sg7puJSwKyDteP3KrcjcF
 k+Aw==
X-Gm-Message-State: AOAM533LsCTDnmN5lmvZvGq4WLlnvs1yNTIvgBAphGWAugflyxPOLot3
 CxLKjw0tcPlUHRsgs3ESndw=
X-Google-Smtp-Source: ABdhPJx35AxUVV6O398anppLcbEKI32dfRaLuLVMxOpRJ+rodbbxxyqhUxP+qwoyGdOJ7uanWVT8yQ==
X-Received: by 2002:a17:902:db11:b029:12b:4a2e:7ec4 with SMTP id
 m17-20020a170902db11b029012b4a2e7ec4mr28239454plx.71.1626880302118; 
 Wed, 21 Jul 2021 08:11:42 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 j6sm23210086pji.23.2021.07.21.08.11.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jul 2021 08:11:41 -0700 (PDT)
Subject: Re: [Resend RFC PATCH V4 09/13] x86/Swiotlb/HV: Add Swiotlb bounce
 buffer remap function for HV IVM
To: Christoph Hellwig <hch@lst.de>
References: <20210707154629.3977369-1-ltykernel@gmail.com>
 <20210707154629.3977369-10-ltykernel@gmail.com>
 <20210720135437.GA13554@lst.de>
 <8f1a285d-4b67-8041-d326-af565b2756c0@gmail.com>
 <20210721143355.GA10848@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <0e2ca0e2-201d-68d4-5dc0-7341f8e9106a@gmail.com>
Date: Wed, 21 Jul 2021 23:11:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210721143355.GA10848@lst.de>
Content-Language: en-US
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, david@redhat.com,
 peterz@infradead.org, dave.hansen@linux.intel.com, hpa@zytor.com,
 anparri@microsoft.com, kys@microsoft.com, will@kernel.org,
 boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org, robh@kernel.org,
 wei.liu@kernel.org, sstabellini@kernel.org, sthemmin@microsoft.com,
 xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org, x86@kernel.org,
 decui@microsoft.com, ardb@kernel.org, michael.h.kelley@microsoft.com,
 nramas@linux.microsoft.com, mingo@redhat.com, pgonda@google.com,
 rientjes@google.com, kuba@kernel.org, jejb@linux.ibm.com,
 martin.b.radev@gmail.com, thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com,
 keescook@chromium.org, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, vkuznets@redhat.com,
 jgross@suse.com, martin.petersen@oracle.com, saravanand@fb.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, rppt@kernel.org, hannes@cmpxchg.org,
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



On 7/21/2021 10:33 PM, Christoph Hellwig wrote:
> On Wed, Jul 21, 2021 at 06:28:48PM +0800, Tianyu Lan wrote:
>> dma_mmap_attrs() and dma_get_sgtable_attrs() get input virtual address
>> belonging to backing memory with struct page and returns bounce buffer
>> dma physical address which is below shared_gpa_boundary(vTOM) and passed
>> to Hyper-V via vmbus protocol.
>>
>> The new map virtual address is only to access bounce buffer in swiotlb
>> code and will not be used other places. It's stored in the mem->vstart.
>> So the new API set_memory_decrypted_map() in this series is only called
>> in the swiotlb code. Other platforms may replace set_memory_decrypted()
>> with set_memory_decrypted_map() as requested.
> 
> It seems like you are indeed not using these new helpers in
> dma_direct_alloc.  How is dma_alloc_attrs/dma_alloc_coherent going to
> work on these systems?
> 

Current vmbus device drivers don't use dma_alloc_attrs/dma_alloc
_coherent() because vmbus driver allocates ring buffer for all devices. 
Ring buffer has been marked decrypted and remapped in vmbus driver. 
Netvsc and storvsc drivers just need to use  dma_map_single/dma_map_page().



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
