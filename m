Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D27C49EB7
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 14:11:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CFFB613EC
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 14:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFFB613EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BDF36062C;
	Thu, 24 Jun 2021 14:11:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Nu_jjlWTGum; Thu, 24 Jun 2021 14:11:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4C6ED605E1;
	Thu, 24 Jun 2021 14:11:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F01EC001A;
	Thu, 24 Jun 2021 14:11:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9FCBC000E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 14:11:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8A298605EC
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 14:11:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id incbKFXCX3sj for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 14:11:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com
 [199.106.114.38])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E3F8A605E1
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 14:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1624543859; x=1656079859;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=jIPt55RUzMMbkq7vhbeD6czYPulB4Zz8LFVe0v3gRZ0=;
 b=HPrafZwejBwzC36jkSdbvaUBdQLBaQtfGa+xaiqEN//oDn9ae67TJgVg
 ZXIdONhObbr4ReCMTBBnx/aEivFxDvcYeamgta7UWJaQfTCDEDHFmdWLy
 xgRFgkPBIu9kR20CxGZsaLUNEcHr+WoXRoSVLx26W/JWJh1lnMehhlZ39 U=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 24 Jun 2021 07:10:59 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 24 Jun 2021 07:10:57 -0700
Received: from [10.111.163.161] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 24 Jun
 2021 07:10:52 -0700
Subject: Re: [PATCH v14 06/12] swiotlb: Use is_swiotlb_force_bounce for
 swiotlb data bouncing
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20210619034043.199220-1-tientzu@chromium.org>
 <20210619034043.199220-7-tientzu@chromium.org>
 <76c3343d-72e5-9df3-8924-5474ee698ef4@quicinc.com>
 <20210623183736.GA472@willie-the-truck>
 <19d4c7a2-744d-21e0-289c-a576e1f0e6f3@quicinc.com>
 <20210624054315.GA25381@lst.de>
 <CALiNf288ZLMhY3E8E3N+z9rkwi1viWNLm1wwMEwT4rNwh3FfwQ@mail.gmail.com>
 <364e6715-eafd-fc4a-e0af-ce2a042756b4@arm.com>
 <20210624111855.GA1382@willie-the-truck>
 <452155d2-c98e-23f6-86d6-3a2ff2e74783@arm.com>
 <20210624114829.GB1382@willie-the-truck>
From: Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <43ec9dd6-12c0-98ec-8d5d-b2904292721e@quicinc.com>
Date: Thu, 24 Jun 2021 10:10:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624114829.GB1382@willie-the-truck>
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03c.na.qualcomm.com (10.85.0.106) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Cc: heikki.krogerus@linux.intel.com,
 linux-devicetree <devicetree@vger.kernel.org>, peterz@infradead.org,
 benh@kernel.crashing.org, joonas.lahtinen@linux.intel.com,
 dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk,
 grant.likely@arm.com, paulus@samba.org, Frank Rowand <frowand.list@gmail.com>,
 mingo@kernel.org, Jianxiong Gao <jxgao@google.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Saravana Kannan <saravanak@google.com>, mpe@ellerman.id.au,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Dan Williams <dan.j.williams@intel.com>, matthew.auld@intel.com,
 Nicolas Boichat <drinkcat@chromium.org>, thomas.hellstrom@linux.intel.com,
 Jim Quinlan <james.quinlan@broadcom.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 intel-gfx@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 jani.nikula@linux.intel.com, Rob Herring <robh+dt@kernel.org>,
 rodrigo.vivi@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 Claire Chang <tientzu@chromium.org>, boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 airlied@linux.ie, Thierry Reding <treding@nvidia.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, xypron.glpk@gmx.de,
 Tom Lendacky <thomas.lendacky@amd.com>, linuxppc-dev@lists.ozlabs.org,
 bauerman@linux.ibm.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 6/24/2021 7:48 AM, Will Deacon wrote:
> Ok, diff below which attempts to tackle the offset issue I mentioned as
> well. Qian Cai -- please can you try with these changes?

This works fine.

> 
> Will
> 
> --->8
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 175b6c113ed8..39284ff2a6cd 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -116,7 +116,9 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
>  
>  static inline bool is_swiotlb_force_bounce(struct device *dev)
>  {
> -       return dev->dma_io_tlb_mem->force_bounce;
> +       struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> +
> +       return mem && mem->force_bounce;
>  }
>  
>  void __init swiotlb_exit(void);
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 44be8258e27b..0ffbaae9fba2 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -449,6 +449,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>                 dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
>         unsigned int nslots = nr_slots(alloc_size), stride;
>         unsigned int index, wrap, count = 0, i;
> +       unsigned int offset = swiotlb_align_offset(dev, orig_addr);
>         unsigned long flags;
>  
>         BUG_ON(!nslots);
> @@ -497,7 +498,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>         for (i = index; i < index + nslots; i++) {
>                 mem->slots[i].list = 0;
>                 mem->slots[i].alloc_size =
> -                       alloc_size - ((i - index) << IO_TLB_SHIFT);
> +                       alloc_size - (offset + ((i - index) << IO_TLB_SHIFT));
>         }
>         for (i = index - 1;
>              io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 &&
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
