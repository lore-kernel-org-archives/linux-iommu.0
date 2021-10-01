Return-Path: <SRS0=Y/Kh=OV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C5AC433EF
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 22:14:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0C5613A7
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 22:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D0C5613A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C3094402DC;
	Fri,  1 Oct 2021 22:14:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3QmV51rUYvNM; Fri,  1 Oct 2021 22:14:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4E64640836;
	Fri,  1 Oct 2021 22:14:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16CA3C0011;
	Fri,  1 Oct 2021 22:14:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3E5BC000D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 22:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DCEEE60753
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 22:14:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3zTU9ylzDe36 for <iommu@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 22:14:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D9B9B60689
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 22:14:07 +0000 (UTC)
Received: by mail-qv1-xf2d.google.com with SMTP id k3so1831714qve.10
 for <iommu@lists.linux-foundation.org>; Fri, 01 Oct 2021 15:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Dlj3GwcHZB/hfgpWys67iaiDnLMMEzD7BT0/JUJOZSA=;
 b=EYJBCgdxRWFQwama5Ss0sx2D4qnIU/NFx7XF8E6GPLVVfNfvYaFMHC2BJIcCXsVoIF
 iCVvjpeBI3ImpoxruP60EpxdKHxMF088MpggWRWO7IYnFWYmW7H6nN3tO2gp7dE0tPcr
 PZxWZiHqQ0kOXeNKhD0DGvipG0AB/RuuNPtsQvgGuq0gEvYHfaW0BPvSOUVVBNQSYbh9
 0YWWGW3L+w61nc7KMA8GAJec757jPzc4w6+ESAcdFTN5R3q4fIgS/oiFDTnJz8JfMv7h
 ts1ZBK4JepAEgYw1PQejU7GFCd4skwXqph1TdAhgLH6c2/iHJ7h16XxYT4AhYwcn5M99
 FT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Dlj3GwcHZB/hfgpWys67iaiDnLMMEzD7BT0/JUJOZSA=;
 b=22oDkunThtKO2tQfsVIpjFuki6inS/eTi8eujq2x5DB+NNaUaEIOicWhWGDCnQjgAo
 TBrDiOrX3a2aMfu1SazOrmvvgPw2E9krDVQxz7zm1LImkwl/yrQqrvir7pgwKF+ZXZhP
 kcYyYNmLQVU1HmkufGQqNvaf1dp7NoA61LTQLJ+vcIb+CfyEbYtpPwQ/6yXXjdsBxAHQ
 I3EXxYGzDabTof0zU8GB2dnjajaIl3HVlEJRxmbUwCuZBGhF1KaCtOujJklGzRyoQD0y
 VV5RqHFzHUTW9jO9C0v6V6phNa1VM+CE1TAeai3WkdqpL9xWcJ829CZutM4tDv8BMsul
 BhpA==
X-Gm-Message-State: AOAM531mCOXxS5YUAN0FXUpem4KHbiocnOCCMk8drizplDz9MgS6IDno
 eR762XkTmInFMSKGuzLkQPSx0Q==
X-Google-Smtp-Source: ABdhPJxstfy2KGuFAOeM51qITA8tU2CEYk8H/V5BgLnRDG7386cROIjg8GYfgca/wk61maljwb6gxg==
X-Received: by 2002:a05:6214:dac:: with SMTP id
 h12mr7351043qvh.39.1633126446714; 
 Fri, 01 Oct 2021 15:14:06 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id p9sm3635312qkm.23.2021.10.01.15.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Oct 2021 15:14:05 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mWQn7-009XgW-9E; Fri, 01 Oct 2021 19:14:05 -0300
Date: Fri, 1 Oct 2021 19:14:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20211001221405.GR3544071@ziepe.ca>
References: <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca>
 <20211001134856.GN3544071@ziepe.ca>
 <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
 <20211001174511.GQ3544071@ziepe.ca>
 <95ada0ac-08cc-5b77-8675-b955b1b6d488@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <95ada0ac-08cc-5b77-8675-b955b1b6d488@deltatee.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Alistair Popple <apopple@nvidia.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
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

On Fri, Oct 01, 2021 at 02:13:14PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2021-10-01 11:45 a.m., Jason Gunthorpe wrote:
> >> Before the invalidation, an active flag is cleared to ensure no new
> >> mappings can be created while the unmap is proceeding.
> >> unmap_mapping_range() should sequence itself with the TLB flush and
> > 
> > AFIAK unmap_mapping_range() kicks off the TLB flush and then
> > returns. It doesn't always wait for the flush to fully finish. Ie some
> > cases use RCU to lock the page table against GUP fast and so the
> > put_page() doesn't happen until the call_rcu completes - after a grace
> > period. The unmap_mapping_range() does not wait for grace periods.
> 
> Admittedly, the tlb flush code isn't the easiest code to understand.
> But, yes it seems at least on some arches the pages are freed by
> call_rcu(). But can't this be fixed easily by adding a synchronize_rcu()
> call after calling unmap_mapping_range()? Certainly after a
> synchronize_rcu(), the TLB has been flushed and it is safe to free those
> pages.

It would close this issue, however synchronize_rcu() is very slow
(think > 1second) in some cases and thus cannot be inserted here.

I'm also not completely sure that rcu is the only case, I don't know
how every arch handles its gather structure.. I have a feeling the
general intention was for this to be asynchronous

My preferences are to either remove devmap from gup_fast, or fix it to
not use special pages - the latter being obviously better.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
