Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D96EC43334
	for <iommu@archiver.kernel.org>; Thu,  2 Jun 2022 00:00:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7FEE417BB;
	Thu,  2 Jun 2022 00:00:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ex1IKhWeSFts; Thu,  2 Jun 2022 00:00:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7025D4174F;
	Thu,  2 Jun 2022 00:00:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E299C0039;
	Thu,  2 Jun 2022 00:00:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB418C002D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 00:00:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A22CE403EA
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 00:00:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tqmUYjCqejx0 for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 00:00:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7C146401FB
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 00:00:41 +0000 (UTC)
Received: by mail-qt1-x834.google.com with SMTP id hh4so2371719qtb.10
 for <iommu@lists.linux-foundation.org>; Wed, 01 Jun 2022 17:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=XHclFl6TiOnpsdbRTbpf8I5ef93NwLHxOT7ZftAP5OQ=;
 b=PNI9gR5OxCMLK2wesmPP7beTza1LVUIA9KonYJGbDAFowaWR1+gOMSPFQyILlCbdK9
 gUfn5ltQQND4Igpr1PcoJgKaxcD5dBAwzrvhneuGmR5cB6Xf3NpyEwE9pIIgcm5WsDfj
 OMBTPHZn69Csi4sdfYc+o9dQdNtlWVyz5OxRR+X8nyDPYF6K2ahO4BRlxiavJkdgkk5b
 vBCAgX831wn8MMIkjC+ZBM62WCGcevuCk6vOX7Pr2o1vHeySgvRlg6SFXHlD9BjBBgRR
 tgzeldcoyTnuS2Xyrkl/LEo9UbgD40oyCdtA/wA5nQPC/hTnaLXrjoV5QjIEjd2lSEr7
 qhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XHclFl6TiOnpsdbRTbpf8I5ef93NwLHxOT7ZftAP5OQ=;
 b=inSC5rbRoQ+FZBdJXYHCdDqGLVXTMFOshNsDScnlNeT6yvbhSJRZPSXFJuhT8car8Z
 qedFyC3KK/ml0wfjQQG/AuvoWZvxHh+CsBrgz4wmFHIuF9PELMh2Iw9P/metrvIZkgeK
 f4sx4cfP00mby44+dEQKBR2GYTILAkf2SEXqxEhcqbtFCsV36RcJCDYs90fm5q8VE4uC
 MxprosB1hIDcxa1KS6n2B45TgoXS0y5lV01e0CFvmLyUhtnj47vGStYH//+FjMnJTDZP
 KWVj6r9z6ErLekwJHUAsQJu6RNqLdVucBsmBQwWVMfeO8il/g16dtyA5w35TMW1o8544
 HkrQ==
X-Gm-Message-State: AOAM533jEhHL7Q9lT/JTIPYN3JQTOUAvxKZU61oy0BD5eEpZepSWlgQB
 beA91Mws4eak5CB2cnSgLr7ZEg==
X-Google-Smtp-Source: ABdhPJyvPa7jsnbpw9EbFCPQVbuxZnWhMX7Sx5D9T0fweaGvqMgcaf7CabbpUfVwopaFMLH+hIknjw==
X-Received: by 2002:a05:622a:313:b0:2f3:b9a1:dd4a with SMTP id
 q19-20020a05622a031300b002f3b9a1dd4amr1870963qtw.536.1654128040009; 
 Wed, 01 Jun 2022 17:00:40 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129]) by smtp.gmail.com with ESMTPSA id
 b16-20020a05620a04f000b006a38debe62csm1867208qkh.89.2022.06.01.17.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jun 2022 17:00:39 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1nwYGU-00GCY4-Af; Wed, 01 Jun 2022 21:00:38 -0300
Date: Wed, 1 Jun 2022 21:00:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v6 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20220602000038.GK2960187@ziepe.ca>
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
 <20220527125501.GD2960187@ziepe.ca>
 <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
 <20220527190307.GG2960187@ziepe.ca>
 <d336cfe8-2451-04c3-a2ce-0e8e47afd1e3@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d336cfe8-2451-04c3-a2ce-0e8e47afd1e3@deltatee.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-block@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
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

On Fri, May 27, 2022 at 04:41:08PM -0600, Logan Gunthorpe wrote:
> > 
> > IIRC this is the last part:
> > 
> > https://lore.kernel.org/linux-mm/20220524190632.3304-1-alex.sierra@amd.com/
> > 
> > And the earlier bit with Christoph's pieces looks like it might get
> > merged to v5.19..
> > 
> > The general idea is once pte_devmap is not set then all the
> > refcounting works the way it should. This is what all new ZONE_DEVICE
> > users should do..
> 
> Ok, I don't actually follow how those patches relate to this.
> 
> Based on your description I guess I don't need to set PFN_DEV and

Yes

> perhaps not use vmf_insert_mixed()? And then just use vm_normal_page()?

I'm not sure ATM the best function to use, but yes, a function that
doesn't set PFN_DEV is needed here.
 
> But the refcounting of the pages seemed like it was already sane to me,
> unless you mean that the code no longer has to synchronize_rcu() before
> returning the pages... 

Right. It also doesn't need to call unmap range or keep track of the
inode, or do any of that stuff unless it really needs mmap revokation
semantics (which I doubt this use case does)

unmap range was only necessary because the refcounting is wrong -
since the pte's don't hold a ref on the page in PFN_DEV mode it is
necessary to wipe all the PTE explicitly before going ahead to
decrement the refcount on this path.

Just stuff the pages into the mmap, and your driver unprobe will
automatically block until all the mmaps are closed - no different than
having an open file descriptor or something.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
