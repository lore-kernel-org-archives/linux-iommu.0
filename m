Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8A3C433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 23:05:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3857F617E2
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 23:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3857F617E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08CCC83E93;
	Wed, 29 Sep 2021 23:05:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QxfnOLK_4GWr; Wed, 29 Sep 2021 23:05:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D564B83E7F;
	Wed, 29 Sep 2021 23:05:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD4AEC000F;
	Wed, 29 Sep 2021 23:05:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35AC7C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 23:05:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1680E40210
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 23:05:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MYtOWj1zw50O for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 23:05:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 37C914013A
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 23:05:46 +0000 (UTC)
Received: by mail-qt1-x835.google.com with SMTP id e16so3957193qts.4
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 16:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Rb14cjSJqqt1iOg7v1WUt5AVmuRSH7cZOE8ujwxMcMg=;
 b=DIaskCn5WR5tA6jhdOqyO4JGz4+XatRitSbJTb+kmIqDsCr01GjZ0p3lPuKzblpDJT
 zhfIKMKyyPJmhP4fwKW9s1DOIPeWnXpgnGWww2ZsqZXMAXwagCxFkdbr/ZZNpdbvhNz6
 yhMxNtaJ4799pZOw9yof96R6NI1pis1TXcHgXiz2OGYJ2JTRjUBWxNfY9Bnx4SBlBLHZ
 NOkoZJeyzIFho5nhxKuuBqHTm7LkOuC/VLVY0i+EnUBy4CEUt/GqO7FcsIRDEUISOa/r
 ebsfSg+Kyd8gPXIldmrnVbOFPyE5xD126E/0FnMFaQl4NuKh0l+VCCKdHBolF0rJnHvM
 E9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Rb14cjSJqqt1iOg7v1WUt5AVmuRSH7cZOE8ujwxMcMg=;
 b=7si+FWeAPRSDnSx+EFvfNsqcTsD1xw3n59sTzLgF9Uo4fLvfn5695cxV6CIzeswYZB
 l46MFNl/vBdjco9+WC/rOdcJ3+QCAra0JQZX4kbulx+RiMOQNkXAXcIDfW614TfLMNHp
 AWkV/NTvAetqR8lAPw88WDqBQ5Vvu2grQxCF2CQ7XECQqQaX34hIWr6xK40lR3wAhTBO
 uczFUH/IBzu66SCxcc5z1YFf/iWFXk9aolItwMMTH2zag+Zn6sSWL62JrofmGZ8Miofv
 eAIVD09owtyKLskUB7tR1fl5ZHQPVUKvPlkn8IfYFTlEsNUwq7EUhWVKKAHbB2/iEap/
 WmSA==
X-Gm-Message-State: AOAM5338poqrfr/Q/tYuIbOZucL1N3TZ617FRdcdy6T5c97GcOGEgz76
 UyVL9KXwAjR6xtdw2ZUmSi3Hew==
X-Google-Smtp-Source: ABdhPJyapID+TUOl/mUzGMXiMJpXeNaxe+8Z2o/bunUXmIm+EzT4IvoM8B4R+kDDMjzs5lMTxyRE3w==
X-Received: by 2002:ac8:7613:: with SMTP id t19mr2882513qtq.365.1632956745011; 
 Wed, 29 Sep 2021 16:05:45 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id h4sm645980qtj.83.2021.09.29.16.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Sep 2021 16:05:44 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVidz-007iU5-Sx; Wed, 29 Sep 2021 20:05:43 -0300
Date: Wed, 29 Sep 2021 20:05:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20210929230543.GB3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
 <20210928195518.GV3544071@ziepe.ca>
 <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
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

On Wed, Sep 29, 2021 at 03:42:00PM -0600, Logan Gunthorpe wrote:

> The main reason is probably this: if we don't use VM_MIXEDMAP, then we
> can't set pte_devmap(). 

I think that is an API limitation in the fault routines..

finish_fault() should set the pte_devmap - eg by passing the
PFN_DEV|PFN_MAP somehow through the vma->vm_page_prot to mk_pte() or
otherwise signaling do_set_pte() that it should set those PTE bits
when it creates the entry.

(or there should be a vmf_* helper for this special case, but using
the vmf->page seems righter to me)

> If we don't set pte_devmap(), then every single page that GUP
> processes needs to check if it's a ZONE_DEVICE page and also if it's
> a P2PDMA page (thus dereferencing pgmap) in order to satisfy the
> requirements of FOLL_PCI_P2PDMA.

Definately not suggesting not to set pte_devmap(), only that
VM_MIXEDMAP should not be set on VMAs that only contain struct
pages. That is an abuse of what it is intended for.

At the very least there should be a big comment above the usage
explaining that this is just working around a limitation in
finish_fault() where it cannot set the PFN_DEV|PFN_MAP bits today.

Jason

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
