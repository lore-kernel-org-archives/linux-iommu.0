Return-Path: <SRS0=jPbF=ND=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A37C4338F
	for <iommu@archiver.kernel.org>; Thu, 12 Aug 2021 15:38:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F04B60F91
	for <iommu@archiver.kernel.org>; Thu, 12 Aug 2021 15:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7F04B60F91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 388F5400DB;
	Thu, 12 Aug 2021 15:38:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dq1X2FtA3cU6; Thu, 12 Aug 2021 15:38:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 00619400FA;
	Thu, 12 Aug 2021 15:38:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C89F6C001A;
	Thu, 12 Aug 2021 15:38:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71699C000E
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 15:38:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6669440433
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 15:38:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E34xIjMS-cir for <iommu@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 15:38:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DADF140417
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 15:38:43 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id b7so7808371plh.7
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 08:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JDlSeWOgXcTARSX0Sb/7iqT+nIM3mRl7e9seVpJTDsQ=;
 b=eKwdoqgzbDwCSyrgnVW4fQAzUSWeoRx/kyQpFmKK+Fp7BDnr2/nHtS2A8lP7dy74pV
 DhjbUbYBUBvR9ptLkWXPFGdb66asLd49SRfdmf9wxKJzWqlZ8T7NSu4mDDdOyr8QYGjC
 0lNFiTw2Utqsdhq+i1tE7yKdLkrhwYJ4GcUjf5y7cP+4awTK44NJV01YV+BxlT3oQexu
 0CRKAKLjxtq43dNgpQlyRzLdedFvCS41p+H+3bYjSaKBrgs7oVUsW9kyJWLlM734zPxy
 UEVzFvb9jP9wMt2dE2D+cHyIUPC4b4v/Fn8lr0Ong2WornEq8pHks9kPtVFyDLYSburS
 y7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JDlSeWOgXcTARSX0Sb/7iqT+nIM3mRl7e9seVpJTDsQ=;
 b=IzKRuKWBHQH1Lu8cdUUxlkerXyKhf8dW8raofQVmrD8eXuEoMN/MISBKbEPOkk0dfC
 L+cMd8SrtWVjVcb9+FHs/p23SFuSpDmwXGonEiKrD7fk4HTHBU0rEsUQiSmD1X+A1XkD
 sN1eDehiuGvPLYcqmMkttuGJ4Ug7vHPPlf0qOnGIEZHjlpuJXrNBgOxU+pMDkeRiMBhR
 3ZozrV7CYGsDH1yboQ3HjR3muyHLS2HP0PLBCieHFUtnQOulmGeMNCDwVm4Gu+mxOosf
 34hUn8I3bW6iZ/yijGdXvReeGYNkRdOD/4IKC3XMVa41cm4nNUNxUJ2UbJ+npHys4BJM
 5/7w==
X-Gm-Message-State: AOAM533+Xcchf+Gw/C1S9iXPwkZeZTJfe50zPDziFWVK2aDeFlcjYFQi
 aUYcsXsrqkf0ziQcLCLqK/E=
X-Google-Smtp-Source: ABdhPJzM/sI+FsioyGJB+Q38ExsQyZIIBjJUHCnSB8L/yQaI33b3CkRfajWOppoDj5zZgXKq84mYaQ==
X-Received: by 2002:a17:90a:648b:: with SMTP id
 h11mr5000375pjj.141.1628782723341; 
 Thu, 12 Aug 2021 08:38:43 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 y7sm4139094pfp.102.2021.08.12.08.38.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Aug 2021 08:38:42 -0700 (PDT)
Subject: Re: [PATCH V3 09/13] DMA: Add dma_map_decrypted/dma_unmap_encrypted()
 function
To: Christoph Hellwig <hch@lst.de>
References: <20210809175620.720923-1-ltykernel@gmail.com>
 <20210809175620.720923-10-ltykernel@gmail.com>
 <20210812122657.GB19050@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <0598906d-9a47-34a9-16bf-4bacff7fa058@gmail.com>
Date: Thu, 12 Aug 2021 23:38:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210812122657.GB19050@lst.de>
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



On 8/12/2021 8:26 PM, Christoph Hellwig wrote:
> On Mon, Aug 09, 2021 at 01:56:13PM -0400, Tianyu Lan wrote:
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> In Hyper-V Isolation VM with AMD SEV, swiotlb boucne buffer
>> needs to be mapped into address space above vTOM and so
>> introduce dma_map_decrypted/dma_unmap_encrypted() to map/unmap
>> bounce buffer memory. The platform can populate man/unmap callback
>> in the dma memory decrypted ops.
> 
> Nothing here looks actually DMA related, and the names are horribly
> confusing vs the actual dma_map_* calls.
> 

OK. So this still need to keep in the set_memory.c file.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
