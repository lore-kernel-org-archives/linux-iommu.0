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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3B4C4338F
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 14:09:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D17660725
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 14:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4D17660725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 102BF401C3;
	Mon,  2 Aug 2021 14:09:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pr-Q8H3lQDtN; Mon,  2 Aug 2021 14:09:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BC8DD400DB;
	Mon,  2 Aug 2021 14:09:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D692C001B;
	Mon,  2 Aug 2021 14:09:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5205EC000E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 14:09:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3CB31403D4
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 14:09:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id plgrZKUzRoR0 for <iommu@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 14:09:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 51AC640378
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 14:09:00 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 u13-20020a17090abb0db0290177e1d9b3f7so2803503pjr.1
 for <iommu@lists.linux-foundation.org>; Mon, 02 Aug 2021 07:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/cdM8HpdDM3Yh7GGE7exLVKVMbD9iA/9tyiszM+STgg=;
 b=EyGzIbCm/4WfGRl2TIpRtI8exR5hEZdzfziWgkyJF2rPPiSQ75H+98IAopMmYevfFk
 Ov/fJ43JIQnILsE3s/0qzNMc0nrf6uUXE2j26BExy5g7B3BpTmvtolJxygg5zsp4OzjQ
 /7pE2ruUo+gM4LDOxH4S0QCLE3cZn8HjYiXLd7zaPCzN5tcqN75mDO2ycYHk5nf3h82W
 fzBmyU3qV/42PwBr8KexEQmrjqnx6SCVYEPtgGSjDXNVb1Uffuv26Hb9ID8hcdFyzcOI
 2ZeoAyGM+UdW1S66kVSqZMjoR5QEIes/nzm112DtVAisubEuzui0RUvnkB/UUMAP1zyE
 JLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/cdM8HpdDM3Yh7GGE7exLVKVMbD9iA/9tyiszM+STgg=;
 b=Kh/54M4Yt36o/L4v3CPscmnPrgTu2j5V75F2nWTWcIM0cWJY7vYp13WlJIjzKF+uF1
 rLbVuunvDHCJ75srVDtWZd8ENg5ufswA7xsfeVD5WVDJdPLs2R9qa7QKT9kLbyWfvtYO
 HGzyv1ADDhgiMzSxzOz6Xb5roLt6D/sJSWUoHYQDx6llVsIb9JBdpT+7S1mqTlJUq4dN
 SZHz0orsm+sSiWRKaLZkFqOePBKSMEWCbjcRgBsdxmHwqx0AnsVFhPZyJDv062H0a8C8
 l8ByLrqYZL9yTbfRL74DdpsGYQw1iEhAqqFDWEezJAj7vlrA4ssdujNo2d2Re+y5KrP9
 AJ7A==
X-Gm-Message-State: AOAM5331zv40KVwFaXJ42YaUoeyqUWQ2S4vdzs9HVrNH+PTrqUlI7Z6l
 FDtQSeK2qkjkbsq0qv2hs6w=
X-Google-Smtp-Source: ABdhPJz9/oIt1d6cc74gFPmQ4IHl6g1R2CxfQ4Ko9VZ15V7BmdIE77nzkycqmmDE/JgZuYIJykKPEQ==
X-Received: by 2002:aa7:8148:0:b029:31b:10b4:f391 with SMTP id
 d8-20020aa781480000b029031b10b4f391mr16506898pfn.69.1627913339735; 
 Mon, 02 Aug 2021 07:08:59 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:18:efec::4b1])
 by smtp.gmail.com with ESMTPSA id
 fz10sm11071046pjb.40.2021.08.02.07.08.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Aug 2021 07:08:59 -0700 (PDT)
Subject: Re: [PATCH 13/13] HV/Storvsc: Add Isolation VM support for storvsc
 driver
To: Joerg Roedel <joro@8bytes.org>
References: <20210728145232.285861-1-ltykernel@gmail.com>
 <20210728145232.285861-14-ltykernel@gmail.com> <YQfxA/AYfOqyqNh0@8bytes.org>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <eaeb75b7-7e98-ad2d-0e2c-0565b9db79dd@gmail.com>
Date: Mon, 2 Aug 2021 22:08:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQfxA/AYfOqyqNh0@8bytes.org>
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

On 8/2/2021 9:20 PM, Joerg Roedel wrote:
> On Wed, Jul 28, 2021 at 10:52:28AM -0400, Tianyu Lan wrote:
>> In Isolation VM, all shared memory with host needs to mark visible
>> to host via hvcall. vmbus_establish_gpadl() has already done it for
>> storvsc rx/tx ring buffer. The page buffer used by vmbus_sendpacket_
>> mpb_desc() still need to handle. Use DMA API to map/umap these
>> memory during sending/receiving packet and Hyper-V DMA ops callback
>> will use swiotlb function to allocate bounce buffer and copy data
>> from/to bounce buffer.
> 
> I am wondering why you dont't use DMA-API unconditionally? It provides
> enough abstraction to do the right thing for isolated and legacy VMs.
> 

In VMbus, there is already a similar bounce buffer design and so there 
is no need to call DMA-API for such buffer. Calling DMA-API is to use
swiotlb bounce buffer for those buffer which hasn't been covered. This
is why need to conditionally call DMA API.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
