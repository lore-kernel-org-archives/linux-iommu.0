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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8214EC43462
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 19:18:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9E06135C
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 19:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9E06135C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 030DA8430F;
	Wed, 19 May 2021 19:18:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d6X865-dZOdA; Wed, 19 May 2021 19:18:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1422C83EA2;
	Wed, 19 May 2021 19:18:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD033C000E;
	Wed, 19 May 2021 19:18:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5735BC0001
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 19:18:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3DFC383E88
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 19:18:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u0IvXOhYl7ih for <iommu@lists.linux-foundation.org>;
 Wed, 19 May 2021 19:18:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A786183EA2
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 19:18:20 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id t193so10159152pgb.4
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 12:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qkzCD1nWkBURpBrpJXY23W3vLoZSck6AY/wcT/olSRk=;
 b=Jr32Uvht2cSrNILgfPTD5ViC6pT8b+8Rv+juxOSQTQwrJ1CAD0MBJHubcHjyOKsUbI
 JfDjb6IlvhZ8t3+ym7sOQ4a9U6dHEsOXxzesVMPv6UDrlo59kYq82tWRbs9w2uqU+yYo
 8oA/biTXJEGtIK7ZUbiBmZQYbJzsutIezjLCjW+be0py6uPVuz9vfS/rc828YcCt+zVs
 WRnXVlWSjrk7BMwlJdqMQwTvyoJQltUeu2a7CMQB207kX6rGqLkbNNdIKCNuEPYfxlj8
 c8CbGpi6xXQEr0VSmTVe/i1v9YaB96qj2/4NW8B/lTGCTjbb7h0/a34Yz4Z5jXjVRuz+
 oRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qkzCD1nWkBURpBrpJXY23W3vLoZSck6AY/wcT/olSRk=;
 b=gLFTi8covwzTsNbnjyBbQk+au7eEAJOjD/6ci8IGSQhe4MiPmmtwI/vxE+M9e3VmRn
 pAhPeqdr3ZnQMsk8wNx/cfhTgmM7Qf0xkANPwT2bS8WzWOUW94FgaBpT3axyNnh43fGK
 iTNnVpE9rWI+zCXLlYys2i+giC2rhKWv7dWD4rOs+IDBSJt8Yk83x07HBL0zTPTObcUi
 iX3JdmDS0DOnv8DxgK0S2JU3s61Y43z3nELb1bSMxKLsHi9XgNiX+uryNqP3qV3vLPl/
 BY+lXuMArPSk3R4kSxxOJMFWRvKmg7kKjK2NtK4ZMYL3DnDfbu5qa8wIUd6ITOVFZgrx
 uPTA==
X-Gm-Message-State: AOAM533+nHEnaf05VUxwlTNwCqUZqqUsFKwDgFCJzMfeQFYFv51Kj779
 v3d42wlrDOES4pSu0IGhRCU=
X-Google-Smtp-Source: ABdhPJyun5zEd3qUDcE/GtFSWzJiED1dVWEJkkT2Lvnwoihmboc879WuDVAjjHLr8vtaHKK8YVFCpg==
X-Received: by 2002:a65:4286:: with SMTP id j6mr636207pgp.261.1621451900054;
 Wed, 19 May 2021 12:18:20 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id d131sm147671pfd.176.2021.05.19.12.18.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 May 2021 12:18:19 -0700 (PDT)
Subject: Re: [PATCH v7 05/15] swiotlb: Add a new get_io_tlb_mem getter
To: Claire Chang <tientzu@chromium.org>, Rob Herring <robh+dt@kernel.org>,
 mpe@ellerman.id.au, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, boris.ostrovsky@oracle.com,
 jgross@suse.com, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-6-tientzu@chromium.org>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <52714d95-3562-97fc-0dee-761adfc364cb@gmail.com>
Date: Wed, 19 May 2021 12:18:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210518064215.2856977-6-tientzu@chromium.org>
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
> Add a new getter, get_io_tlb_mem, to help select the io_tlb_mem struct.
> The restricted DMA pool is preferred if available.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
