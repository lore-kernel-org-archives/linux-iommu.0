Return-Path: <SRS0=vqUx=OG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8132C433EF
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 14:44:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F8961214
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 14:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 61F8961214
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 285B640120;
	Thu, 16 Sep 2021 14:44:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e5PVGOkyS3eH; Thu, 16 Sep 2021 14:44:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9C15340248;
	Thu, 16 Sep 2021 14:44:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F04FC000F;
	Thu, 16 Sep 2021 14:44:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EE70C000D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 14:44:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D70C4159F
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 14:44:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WZM3LllBAVd1 for <iommu@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 14:44:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 355E64159E
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 14:44:11 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id v1so3979088plo.10
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 07:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=daOJCQ5ZGPvwc1951n97peFQn5CdNcYRqjhdeKz1vfU=;
 b=kFhwzpK+Y6fzZ8X7nPLZDzATwjammU+fVatUdP6GQmmOa4cwb7pps1Nw0JafcdN05c
 us+rB0fvubZS9oiEAFzEFlFf312AuI1o1bEmAQE4QmcO1zjNKu1RZh97KgxL0BNdbt63
 0Jr+VY4PzihMoQPiBbmbSubnZSyQYJcQQgB+obVuZmtoGKsNqbBtlR5Gbo8zv710wZ9R
 a8mRhJlIllHxWHu31340de111QSrO67EpQHGFhSYs/S/jlv0B8eWaFAGTKy4KKxxqu/i
 pxm1iG7a99zgqWZv5DChQlteGUPk7MFUk4oD2MTOCUtVe1ZR4X5ZKY5Ua3wnolLudPA4
 hmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=daOJCQ5ZGPvwc1951n97peFQn5CdNcYRqjhdeKz1vfU=;
 b=58WYUQBNvA3FUaW8bSyy8V+O0c9yxOBsj/ntAseDQXCn3C52xA77JZtdXt/qrJM01D
 Ura0QpNgTz5Xohw1lzBrCEDMnNeV89k+4UXVJWWp6FajI/NF/3+HJbzVlRqqBBJ50AME
 hUIenDo1DcRepkm+oleH9J+7TG5ozQMJ2agqBPWXf9Cml6lAMuHlZSBQI83/JPDDb0KK
 xWUOWcyQxnhMRF1UpVgmBruzPVWACQoESz7O00yPl7241bVynqp9TgrMXHJdGkAt+ZYL
 ajZOK82OfgsZvrWlYFq83T73p11JAlRI2alW5bL1acVO2k/Evas88KNGlS5PHyolKjOZ
 P+1A==
X-Gm-Message-State: AOAM533VIT1liiOwF/Sz0GnohWZgyVTyGCO3e0YR7078NW+OCKIwc/xI
 r0OuHyK9Y6Z+gh1/CYVZipU=
X-Google-Smtp-Source: ABdhPJy1NmsnM3CBTxeh4uCd/At4jyjgdaLl8A9jDJfcHgoAtY82XgoTk9uMDIbNLVKuF0mho51VHA==
X-Received: by 2002:a17:903:248f:b029:128:d5ea:18a7 with SMTP id
 p15-20020a170903248fb0290128d5ea18a7mr5070119plw.83.1631803450601; 
 Thu, 16 Sep 2021 07:44:10 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::50b? ([2404:f801:9000:1a:efea::50b])
 by smtp.gmail.com with ESMTPSA id
 d3sm3759819pga.7.2021.09.16.07.43.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Sep 2021 07:44:10 -0700 (PDT)
Subject: Re: [PATCH V5 12/12] net: netvsc: Add Isolation VM support for netvsc
 driver
To: Michael Kelley <mikelley@microsoft.com>, KY Srinivasan
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "luto@kernel.org" <luto@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "jgross@suse.com" <jgross@suse.com>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "jejb@linux.ibm.com"
 <jejb@linux.ibm.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "arnd@arndb.de" <arnd@arndb.de>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "pgonda@google.com" <pgonda@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "rppt@kernel.org" <rppt@kernel.org>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
 "saravanand@fb.com" <saravanand@fb.com>,
 "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "tj@kernel.org" <tj@kernel.org>, "rientjes@google.com" <rientjes@google.com>
References: <20210914133916.1440931-1-ltykernel@gmail.com>
 <20210914133916.1440931-13-ltykernel@gmail.com>
 <MWHPR21MB15939A5D74CA1DF25EE816ADD7DB9@MWHPR21MB1593.namprd21.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <850a0129-ef82-67e9-165f-8503da6889dd@gmail.com>
Date: Thu, 16 Sep 2021 22:43:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB15939A5D74CA1DF25EE816ADD7DB9@MWHPR21MB1593.namprd21.prod.outlook.com>
Content-Language: en-US
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dave.hansen@intel.com" <dave.hansen@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 vkuznets <vkuznets@redhat.com>
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

On 9/16/2021 12:21 AM, Michael Kelley wrote:
> I think you are proposing this approach to allocating memory for the send
> and receive buffers so that you can avoid having two virtual mappings for
> the memory, per comments from Christop Hellwig.  But overall, the approach
> seems a bit complex and I wonder if it is worth it.  If allocating large contiguous
> chunks of physical memory is successful, then there is some memory savings
> in that the data structures needed to keep track of the physical pages is
> smaller than the equivalent page tables might be.  But if you have to revert
> to allocating individual pages, then the memory savings is reduced.
> 

Yes, this version follows idea from Christop in the previous 
discussion.(https://lkml.org/lkml/2021/9/2/112)
This patch shows the implementation and check whether this is a right 
direction.

> Ultimately, the list of actual PFNs has to be kept somewhere.  Another approach
> would be to do the reverse of what hv_map_memory() from the v4 patch
> series does.  I.e., you could do virt_to_phys() on each virtual address that
> maps above VTOM, and subtract out the shared_gpa_boundary to get the
> list of actual PFNs that need to be freed.

virt_to_phys() doesn't work for virtual address returned by 
vmap/vmap_pfn() (just like it doesn't work for va returned by 
vmalloc()). The pfn above vTom doesn't have struct page backing and
vmap_pfn() populates the pfn directly in the pte.(Please see the
vmap_pfn_apply()). So it's not easy to convert the va to pa.

>   This way you don't have two copies
> of the list of PFNs -- one with and one without the shared_gpa_boundary added.
> But it comes at the cost of additional code so that may not be a great idea.
> 
> I think what you have here works, and I don't have a clearly better solution
> at the moment except perhaps to revert to the v4 solution and just have two
> virtual mappings.  I'll keep thinking about it.  Maybe Christop has other
> thoughts.



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
