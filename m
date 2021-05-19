Return-Path: <SRS0=NBt+=KO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD94C433B4
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 19:00:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CAA3613BE
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 19:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CAA3613BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8D0C83C30;
	Wed, 19 May 2021 19:00:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UVbiROFJkfNj; Wed, 19 May 2021 19:00:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB92483B3E;
	Wed, 19 May 2021 19:00:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6A0AC000D;
	Wed, 19 May 2021 19:00:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89862C0001
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 18:59:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6F3594013C
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 18:59:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mF3l9cdGI5UJ for <iommu@lists.linux-foundation.org>;
 Wed, 19 May 2021 18:59:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 571E54013D
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 18:59:58 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id e19so10563918pfv.3
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 11:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=M073CmbM6OvFOLG+SWp0SNpXEbUxhFfHxxoda72NgXE=;
 b=Ekc2ScXY1SHvF4H29yTRhgjiTSWV6Cyne34MQrajkIT3p2pu6mu773Qlyr0kpC2NNU
 P+GJiyNV1K2vRtkjtAhIgI9VHVYmFkAxziAc3YITYD5dCFwhGNrQytvT7wWGVjrLLVt/
 Z+eGZOsPbQoTabmseviirRgNiL7jb93KoBbw+F8LkLIJVv78TKzBCCrYFTn6M7Wbv/bo
 0UQmBpP3G5FMrLaiP4lB4mvY0KeluMFddI6VD1W8D7dp8q/8Zp42g/wrvlGw3mxI6q03
 5p/katWWYvUn05FJWNltsTeqIMenps29TVH4Onz8E4y1A5fSnj1TT7Ka2b9bvOBYDjcG
 zYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M073CmbM6OvFOLG+SWp0SNpXEbUxhFfHxxoda72NgXE=;
 b=OJkI6L41ybhmP/b47G88Z9uEYEgwbI6JPhNc/Y0z1H5itnqlDILoZtPDFPAqyZsVDz
 pf4jb6kmAkWz42RkLPAeU/DvVzMYJy7s4XV/1D6vJhnyc9HNd+7749MmvSB2gPDuH2DU
 K6VeKk3maE8C+z1IKPELTJHn3/ZyiAxvj2mRxVyHJMVyzq6MiZlo9OXSBbQ3Xeu6N/KD
 WgHYKCqBLW6bYzbVaO4uFrgF7viJbREHgZ3/b+2nbsVEBiQ9AFUOxpYvLFyHjToOC7/6
 CzLtyWIoCfXqhRANRC9LR30kSd+Zu6NyN2PobsOXaIbBc6ltXZjLVyCsdDZMuPj5cZuD
 bs5A==
X-Gm-Message-State: AOAM531CFq//tCxrx06FvlLg25amwXNCr5aHHHEMewYRn2zbgcn4g727
 VwLOtEcznzoeVVsDXxWpELc=
X-Google-Smtp-Source: ABdhPJyp0yRJO2tDNgGd4CfLo9HXihdjW7DvkJwzlUWA3fY93WK5PBHIJbH2WL1TmMBXCaStbeZwNQ==
X-Received: by 2002:a65:48c2:: with SMTP id o2mr575344pgs.376.1621450797716;
 Wed, 19 May 2021 11:59:57 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id 63sm140020pfz.26.2021.05.19.11.59.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 May 2021 11:59:57 -0700 (PDT)
Subject: Re: [PATCH v7 11/15] dma-direct: Add a new wrapper
 __dma_direct_free_pages()
To: Claire Chang <tientzu@chromium.org>, Rob Herring <robh+dt@kernel.org>,
 mpe@ellerman.id.au, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, boris.ostrovsky@oracle.com,
 jgross@suse.com, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-12-tientzu@chromium.org>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <8c274da9-db90-cb42-c9b2-815ee0c6fca3@gmail.com>
Date: Wed, 19 May 2021 11:59:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210518064215.2856977-12-tientzu@chromium.org>
Content-Language: en-US
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 mingo@kernel.org, jxgao@google.com, sstabellini@kernel.org,
 Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, jani.nikula@linux.intel.com,
 Nicolas Boichat <drinkcat@chromium.org>, rodrigo.vivi@intel.com,
 bhelgaas@google.com, Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, Robin Murphy <robin.murphy@arm.com>,
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



On 5/17/2021 11:42 PM, Claire Chang wrote:
> Add a new wrapper __dma_direct_free_pages() that will be useful later
> for swiotlb_free().
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
