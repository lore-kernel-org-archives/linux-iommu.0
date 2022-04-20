Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB76C433EF
	for <iommu@archiver.kernel.org>; Wed, 20 Apr 2022 08:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C73C441872;
	Wed, 20 Apr 2022 08:55:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y50OqpdYmw7G; Wed, 20 Apr 2022 08:55:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 54F5C417A3;
	Wed, 20 Apr 2022 08:55:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BD28C002F;
	Wed, 20 Apr 2022 08:55:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 153A0C002C
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 08:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 020A641836
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 08:55:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ioa359_prDS9 for <iommu@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 08:55:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7D825417A3
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 08:55:43 +0000 (UTC)
Received: by mail-lj1-x22b.google.com with SMTP id y11so1133966ljh.5
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 01:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TApnnOk49bznf7nS/pO6YXmwSrM65zNNRoE0LsS+6Cg=;
 b=oJ16xqKIn/hdHrCjEfqcYSejmULG9AlbIt3z3/cM+gdZ1kK3T/Iwv9foQvcWWdS7tP
 A+qccV40M4m8MzS+VFOttc1xqk2Pw6yBWnbo5L5YDTZ6Ex1MWIgnQkSOn6RmZspzWmn4
 17P3Ace2/iYzIRErQ3XCNVnUUwp3lLmEfIJ/LV9isfOl6OfLYPO2fY8TAvgz3AB10Swx
 erh7+01Smj+QYEulza67Nc39S5xUqEoFssbg1g0fJMFMFrtKt7OvbI0c+9k+LnXEN6Lu
 XHCJzwcgzyWo5FTy4FoWIpp2KGNYcnij6j4lFvFNgJeUplDMGBArUqRGsyklzh9HG8Xk
 gnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TApnnOk49bznf7nS/pO6YXmwSrM65zNNRoE0LsS+6Cg=;
 b=yWowwXQJf6N8BJqpjo+TgdxMYoeDVroQRNQZi3e8CzCzlRU+4qHFd8HXCfktXQ46Yd
 W29bxi30jX2f/IDJ5xNau7MkK+p+fkPtRIpqXW8312a99fsFqxk8nDgF93UBUylp7qif
 fv3CKxtDK65oCSnBugqeMkgRF8GfJt9to0jGpQGMG2zBTIiC3CktOmWk5aLBxLZHJyZI
 xVHCo4W3sHnKc2LF+JevVuny6iBYjtl7KulJ+SEBe9ezHn5aCPA0iswvKAlUiyACIQCW
 qGltojiG96l/Q/VeFL7QxgFGQtOS0I9cuhUeTdGJmDMQppJ7ijEJRiOX3a4bpZ/3mXfy
 Z7KQ==
X-Gm-Message-State: AOAM532GK5/D7KEriiUb2HcsBooUVV3bRd+hG7XjvcyB14my2RwtosTG
 5+EZlxrYyDse07FHtwTvJlw=
X-Google-Smtp-Source: ABdhPJyKyJ+u2S17+IotOm0b/2FyzpxuQuznRj9JHVocQh8Ri+xRlCZkxkHJvQpRWZ2M1zZXo5kgvg==
X-Received: by 2002:a2e:8811:0:b0:24d:c4ac:1249 with SMTP id
 x17-20020a2e8811000000b0024dc4ac1249mr5353893ljh.307.1650444941188; 
 Wed, 20 Apr 2022 01:55:41 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
 by smtp.gmail.com with ESMTPSA id
 a8-20020a19fc08000000b0046bc1c21ec5sm1757401lfi.1.2022.04.20.01.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Apr 2022 01:55:40 -0700 (PDT)
Date: Wed, 20 Apr 2022 11:55:38 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/25] dma-direct: take dma-ranges/offsets into account
 in resource mapping
Message-ID: <20220420085538.imgibqcyupvvjpaj@mobilestation>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-4-Sergey.Semin@baikalelectronics.ru>
 <0baff803-b0ea-529f-095a-897398b4f63f@arm.com>
 <20220417224427.drwy3rchwplthelh@mobilestation>
 <20220420071217.GA5152@lst.de>
 <20220420083207.pd3hxbwezrm2ud6x@mobilestation>
 <20220420084746.GA11606@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220420084746.GA11606@lst.de>
Cc: Rob Herring <robh@kernel.org>, Vladimir Murzin <vladimir.murzin@arm.com>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
 linux-pci@vger.kernel.org, Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
 Serge Semin <Sergey.Semin@baikalelectronics.ru>, dmaengine@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>,
 Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
 Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On Wed, Apr 20, 2022 at 10:47:46AM +0200, Christoph Hellwig wrote:
> I can't really comment on the dma-ranges exlcusion for P2P mappings,
> as that predates my involvedment, however:

My example wasn't specific to the PCIe P2P transfers, but about PCIe
devices reaching some platform devices over the system interconnect
bus.

> 
> On Wed, Apr 20, 2022 at 11:32:07AM +0300, Serge Semin wrote:
> > See, if I get to map a virtual memory address to be accessible by any
> > PCIe peripheral device, then the dma_map_sg/dma_map_page/etc
> > procedures will take the PCIe host controller dma-ranges into account.
> > It will work as expected and the PCIe devices will see the memory what
> > I specified. But if I get to pass the physical address of the same
> > page or a physical address of some device of the DEVs space to the
> > dma_map_resource(), then the PCIe dma-ranges won't be taken into
> > account, and the result mapping will be incorrect. That's why the
> > current dma_map_resource() implementation seems very confusing to me.
> > As I see it phys_addr_t is the type of the Interconnect address space,
> > meanwhile dma_addr_t describes the PCIe, DEVs address spaces.
> > 
> > Based on what I said here and in my previous email could you explain
> > what do I get wrong?
> 

> You simply must not use dma_map_resource for normal kernel memory.
> So while the exclusion might be somewhat confusing, that confusion
> really should not matter for any proper use of the API.

What if I get to have a physical address of a platform device and want
have that device being accessed by a PCIe peripheral device? The
dma_map_resource() seemed very much suitable for that. But considering
what you say it isn't.

-Sergey

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
