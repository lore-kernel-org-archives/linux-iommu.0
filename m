Return-Path: <SRS0=ynGH=LB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90558C47082
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 14:57:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3260F61108
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 14:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3260F61108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E58016079E;
	Mon,  7 Jun 2021 14:57:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fbDEG1_dGLtg; Mon,  7 Jun 2021 14:57:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5044605DF;
	Mon,  7 Jun 2021 14:57:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB77DC000D;
	Mon,  7 Jun 2021 14:57:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3765EC0001
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 14:57:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1E5C7831C1
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 14:57:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XzCSrzqYzudw for <iommu@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 14:57:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B228A831BD
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 14:57:01 +0000 (UTC)
Received: by mail-pf1-x42a.google.com with SMTP id d16so13234996pfn.12
 for <iommu@lists.linux-foundation.org>; Mon, 07 Jun 2021 07:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mkL4psSj+prMNO7AohBJyTx+Q189qdo7fgANRpB5e+4=;
 b=lhaKoBcNOuAsXD3pTAmPwsFop0hqZ7JU5MLd+d9L1no2Uoec0Qyp3qHl7oh02shWeI
 Jes/SZ8q3U+KfCNoq9c1Xrlmq8EXws4qXzfcpkEnMBLnTwTeOLVn57/5lNMv0IIQu936
 eZ7O1rSFr9fTp5zpfxPADKjK5NrHWx5QoMUdi6NsRSJlWsZAOZ1xE13fUHg60coHCGz9
 L8KTelBvvQsClf1NodL6YCelq4Ol69U2fD2Jwlp+Qg82jWdc6cKvPRG+8Dfwd10h1GXK
 eJIB1Vu38FzkxJlUAMfqjcOa76EjkPTv6FXCcrF7OHioGvvqCsPHt0hXWXzpcsKlznTI
 Ov6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mkL4psSj+prMNO7AohBJyTx+Q189qdo7fgANRpB5e+4=;
 b=Dblv2sF+aU2mYNZ3CBqIBEiWKAtkdk863QZ6hjj0vOk3NzHRV0BTTbE9BcZPx8F7IA
 uGB4F9g530VdlwR6xVTWQS+p1FpBRcDeiY1XIh5IkKE11OJn/P5HhpG16by+OPjrYwPN
 bop1bUExaLupUdBoXtVsQD9zRp2lICEThv8tkQU/VFjjtrNvNPoykErEBBVDQropC8WU
 1uafOoN2TunqovrQGfJfU5nsJZZICSvLFxzJkb26tzoaNEmwgaD7StLbp3r+1FMuF8I3
 dnEWx1XbIlpifMBSFkCgnf+oCITpy1U9bRsmMUhaTYgG0y7UTGqhYuI2UZdYFI1yvnui
 kSCA==
X-Gm-Message-State: AOAM533lVEMrcdS2tj971EKm23swDhxRN9WOSMRjO/+hFoIhtdNzRejs
 3iFZVQ4vbus+v7rYmAK4uUM=
X-Google-Smtp-Source: ABdhPJyAa6AVd7SFvf1Ep4fkh59q91v76tY7vbke901CKM7Z5XY+dbd7TJGFiS7g5cKGjx+7iiHgJA==
X-Received: by 2002:a65:6a51:: with SMTP id o17mr18093661pgu.170.1623077821197; 
 Mon, 07 Jun 2021 07:57:01 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 p14sm9148073pgk.6.2021.06.07.07.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jun 2021 07:57:00 -0700 (PDT)
Subject: Re: [RFC PATCH V3 08/11] swiotlb: Add bounce buffer remap address
 setting function
To: Christoph Hellwig <hch@lst.de>
References: <20210530150628.2063957-1-ltykernel@gmail.com>
 <20210530150628.2063957-9-ltykernel@gmail.com>
 <20210607064312.GB24478@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <48516ce3-564c-419e-b355-0ce53794dcb1@gmail.com>
Date: Mon, 7 Jun 2021 22:56:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210607064312.GB24478@lst.de>
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


On 6/7/2021 2:43 PM, Christoph Hellwig wrote:
> On Sun, May 30, 2021 at 11:06:25AM -0400, Tianyu Lan wrote:
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> For Hyper-V isolation VM with AMD SEV SNP, the bounce buffer(shared memory)
>> needs to be accessed via extra address space(e.g address above bit39).
>> Hyper-V code may remap extra address space outside of swiotlb. swiotlb_
>> bounce() needs to use remap virtual address to copy data from/to bounce
>> buffer. Add new interface swiotlb_set_bounce_remap() to do that.
> 
> Why can't you use the bus_dma_region ranges to remap to your preferred
> address?
> 

Thanks for your suggestion.

These addresses in extra address space works as system memory mirror. 
The shared memory with host in Isolation VM needs to be accessed via 
extra address space which is above shared gpa boundary. During 
initializing swiotlb bounce buffer pool, only address bellow shared gpa 
boundary can be accepted by swiotlb API because it is treated as system 
memory and managed by memory management. This is why Hyper-V swiotlb 
bounce buffer pool needs to be allocated in Hyper-V code and map
associated physical address in extra address space. The patch target is
to add the new interface to set start virtual address of bounce buffer
pool and let swiotlb boucne buffer copy function to use right virtual 
address for extra address space.

bus_dma_region is to translate cpu physical address to dma address.
It can't modify the virtual address of bounce buffer pool and let
swiotlb code to copy data with right address. If some thing missed,
please correct me.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
