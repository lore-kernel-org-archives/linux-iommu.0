Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8060C433F5
	for <iommu@archiver.kernel.org>; Wed, 15 Dec 2021 05:00:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5172640494;
	Wed, 15 Dec 2021 05:00:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ffJTrlyOsbHL; Wed, 15 Dec 2021 05:00:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0171C4028D;
	Wed, 15 Dec 2021 05:00:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B539EC002F;
	Wed, 15 Dec 2021 05:00:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2A5EC0012
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 05:00:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A93F440494
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 05:00:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T_ynJd0el78L for <iommu@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 05:00:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BD3244028D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 05:00:50 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 n15-20020a17090a394f00b001b0f6d6468eso2792724pjf.3
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 21:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=8sb3K87sdhKiYvwx5bE3jeNXRLJJS0kXGICNRdYkExM=;
 b=GVxjwKmV+XdfIx3OX8dNy0HsVz+rAhcBP4TxG/bSjazWU1VGQl3lo1m/ntwbSt/fE8
 +fLt661wiY2Ob3UprzkHURpD8SPtv4vHfUM/qgarRm+yGZxuZRKRzNHfy6+6gVbu+Hm6
 irdS04nAlXP7ipPNqkW5x5zmKimsFBWvHX9F3Bwrt5Nta8SM6aSBKlZmMehQQRnZQrLS
 jMbPbmJP843pXc50Ss37z22jgJfrijxc5qboOdvVWhHjb7sXSeK2tJftp8Ha2seC/yVQ
 /A9vgVwODdZfImj6DIVkjVQAXWlrbNDT0tUyuL5dQtYdvCvOnt9h1qdW/5d2mw0Oo6mr
 FJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=8sb3K87sdhKiYvwx5bE3jeNXRLJJS0kXGICNRdYkExM=;
 b=qEsAmtqh2lyGDxNlXn645K1LNRHlJn6bP8O1ys3295kqSbZs5DlDFW80lk2+Sk9aiL
 ExhijPh2aPT7UwLvhGDwOpFJIzTlXYe9GOScnsy/8vBBW4YDp1/c4biGpGlOL+sN5DB5
 NQ++8fkRJkcHF3e4I2t0GbqABYkSSqE3UnS4GlL6w1FrSOh6HEELMc8MiLgXjHqbwIpY
 xgSE9ScMvX0qXYiCOCrCxptoXuQpwOX+H+XX6zkBqb9bH5fKfZSx6TwBQYWCk7TOhbKW
 mNnV75A8redJuiZMOrnlSy5Hr1egBkD0wACioBx2psR6F4ygwJz1JWQUJAJFtVqc8uVg
 9DRA==
X-Gm-Message-State: AOAM533YovrXrmFhTPbp2U8ZS6gjdSEsmZwOZdmH1qJ5tQj1rgpzVH3O
 KMarHmq85gxHGW4wegocd/w=
X-Google-Smtp-Source: ABdhPJwcOKly8tCIGgpC7MXZRzN03nfzM7/pY6teJOhQSIlHmDoW624D++0O7lZvpqu65iezQV0wQw==
X-Received: by 2002:a17:902:728e:b0:143:a388:868b with SMTP id
 d14-20020a170902728e00b00143a388868bmr9724300pll.33.1639544450122; 
 Tue, 14 Dec 2021 21:00:50 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50b? ([2404:f801:9000:1a:efea::50b])
 by smtp.gmail.com with ESMTPSA id
 m6sm723040pfh.87.2021.12.14.21.00.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Dec 2021 21:00:49 -0800 (PST)
Message-ID: <fb2ff8b7-ab8c-7c4b-0850-222cd2cf7c4a@gmail.com>
Date: Wed, 15 Dec 2021 13:00:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH V7 1/5] swiotlb: Add swiotlb bounce buffer remap function
 for HV IVM
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@infradead.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com, Tianyu.Lan@microsoft.com,
 michael.h.kelley@microsoft.com
References: <20211213071407.314309-1-ltykernel@gmail.com>
 <20211213071407.314309-2-ltykernel@gmail.com>
 <198e9243-abca-b23e-0e8e-8581a7329ede@intel.com>
 <3243ff22-f6c8-b7cd-26b7-6e917e274a7c@gmail.com>
 <c25ff1e8-4d1e-cf1c-a9f6-c189307f92fd@intel.com>
 <a1c8f26f-fbf2-29b6-e734-e6d6151c39f8@amd.com>
 <7afc23c3-22e7-9bbf-7770-c683bf84a7cc@intel.com>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <7afc23c3-22e7-9bbf-7770-c683bf84a7cc@intel.com>
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, konrad.wilk@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, hch@lst.de
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



On 12/15/2021 6:40 AM, Dave Hansen wrote:
> On 12/14/21 2:23 PM, Tom Lendacky wrote:
>>> I don't really understand how this can be more general any *not* get
>>> utilized by the existing SEV support.
>>
>> The Virtual Top-of-Memory (VTOM) support is an SEV-SNP feature that is
>> meant to be used with a (relatively) un-enlightened guest. The idea is
>> that the C-bit in the guest page tables must be 0 for all accesses. It
>> is only the physical address relative to VTOM that determines if the
>> access is encrypted or not. So setting sme_me_mask will actually cause
>> issues when running with this feature. Since all DMA for an SEV-SNP
>> guest must still be to shared (unencrypted) memory, some enlightenment
>> is needed. In this case, memory mapped above VTOM will provide that via
>> the SWIOTLB update. For SEV-SNP guests running with VTOM, they are
>> likely to also be running with the Reflect #VC feature, allowing a
>> "paravisor" to handle any #VCs generated by the guest.
>>
>> See sections 15.36.8 "Virtual Top-of-Memory" and 15.36.9 "Reflect #VC"
>> in volume 2 of the AMD APM [1].
> 
> Thanks, Tom, that's pretty much what I was looking for.
> 
> The C-bit normally comes from the page tables.  But, the hardware also
> provides an alternative way to effectively get C-bit behavior without
> actually setting the bit in the page tables: Virtual Top-of-Memory
> (VTOM).  Right?
> 
> It sounds like Hyper-V has chosen to use VTOM instead of requiring the
> guest to do the C-bit in its page tables.
> 
> But, the thing that confuses me is when you said: "it (VTOM) is meant to
> be used with a (relatively) un-enlightened guest".  We don't have an
> unenlightened guest here.  We have Linux, which is quite enlightened.
>
>> Is VTOM being used because there's something that completely rules out
>> using the C-bit in the page tables?  What's that "something"?


For "un-enlightened" guest, there is an another system running insider
the VM to emulate some functions(tsc, timer, interrupt and so on) and
this helps not to modify OS(Linux/Windows) a lot. In Hyper-V Isolation
VM, we called the new system as HCL/paravisor. HCL runs in the VMPL0 and 
Linux runs in VMPL2. This is similar with nested virtualization. HCL
plays similar role as L1 hypervisor to emulate some general functions
(e.g, rdmsr/wrmsr accessing and interrupt injection) which needs to be
enlightened in the enlightened guest. Linux kernel needs to handle
#vc/#ve exception directly in the enlightened guest. HCL handles such
exception in un-enlightened guest and emulate interrupt injection which
helps not to modify OS core part code. Using vTOM also is same purpose.
Hyper-V uses vTOM avoid changing page table related code in OS(include
Windows and Linux)and just needs to map memory into decrypted address
space above vTOM in the driver code.

Linux has generic swiotlb bounce buffer implementation and so introduce
swiotlb_unencrypted_base here to set shared memory boundary or vTOM.
Hyper-V Isolation VM is un-enlightened guest. Hyper-V doesn't expose 
sev/sme capability to guest and so SEV code actually doesn't work.
So we also can't interact current existing SEV code and these code is
for enlightened guest support without HCL/paravisor. If other platforms
or SEV want to use similar vTOM feature, swiotlb_unencrypted_base can
be reused. So swiotlb_unencrypted_base is a general solution for all
platforms besides SEV and Hyper-V.










_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
