Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A2BC433EF
	for <iommu@archiver.kernel.org>; Fri, 27 May 2022 19:03:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5EC0E40992;
	Fri, 27 May 2022 19:03:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SjyBuuNVis3O; Fri, 27 May 2022 19:03:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 50DBA40179;
	Fri, 27 May 2022 19:03:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0609CC0032;
	Fri, 27 May 2022 19:03:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46A93C002D
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 19:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 159BD4295E
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 19:03:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jv6xHHQZR08z for <iommu@lists.linux-foundation.org>;
 Fri, 27 May 2022 19:03:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A27264281B
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 19:03:13 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id 135so5596268qkm.4
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 12:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=UcvAlwIFPvCWC2QoKEFkU5cKb9BXBnxHAgM+z3+VvoE=;
 b=pCvvJmfpoo0WDFfVQYDyZGy4qzndOFVtgtSqVXTrWRGEyBqzBA7UAXhKvpkD0Q9/6I
 MSCpLxGE9cFQ1cGdQAtYz+UeGuecy1S3YR7ZbQ9wbQYDjQVRsaTuBol2dHTD44aSUBRR
 IycaJl0ihzjjIE0NocdjmVE2xhgAzy3ISwyDQK8gAI5+MC0ECVrWBJsD5Ckxr01Dq6tm
 NfD6L2oXhGqyHayMYe3j/EFrEVhX3h/t4cx5QraZ38JTD9HD3wAryzP4gzJYXUsnDZYo
 kHgGnIpoEzZEBX8KlbDHtvDbydY35MkFThf2P8sBKcZrGoTNzHOqvBFv/Fi48v3KK05/
 5Huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UcvAlwIFPvCWC2QoKEFkU5cKb9BXBnxHAgM+z3+VvoE=;
 b=keixRsmfaLZIbfUVUZVcLPzIL3XztEIbMU67cmStZET4JTK8auJ2p6o/bSKyGTuV/Y
 df83YRYTHsfAscX6sIOr7Jc/xpF5acRu3D4GQy+nM+lXbUuR0n+so3fCIddK6HRYtJUP
 iT2yptWC5RGUO42KrtTng8X2k9urCS2P2vvIWUh3CXQQbXL6xSgGAwu6HeWQa66ZXlNs
 wXREDMaY8Vf4v1LecoQ6Uu16WBGvzX4ZVeuxVBD9mrEadlZXSDB1kHDN+/qGGnWUg+Jd
 TovHPJLXoKfzIg0Na1qKuJ2st7ngSPqvR57oEQuvbEhuty9254Fvb9UBOnPAA1X+xn5G
 ETKw==
X-Gm-Message-State: AOAM533o/aypv0HVx4ps3i0Y5TwWRMVX5T7ow2js0W9cslfaXaqBrikU
 0sbQrAPjLvdl6yyp6FTz/9ljig==
X-Google-Smtp-Source: ABdhPJyO25WugHG0nEenLRCgTZGSyoFZr8oLpCObiI0Q0Dbj3autEreqfFCD221s7ojQxz7nAKospA==
X-Received: by 2002:a05:620a:298e:b0:6a0:94d2:2e2d with SMTP id
 r14-20020a05620a298e00b006a094d22e2dmr30141554qkp.353.1653678192374; 
 Fri, 27 May 2022 12:03:12 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129]) by smtp.gmail.com with ESMTPSA id
 22-20020a05620a079600b0069fe1dfbeffsm3024426qka.92.2022.05.27.12.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 May 2022 12:03:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1nufEp-00Dd1y-Rg; Fri, 27 May 2022 16:03:07 -0300
Date: Fri, 27 May 2022 16:03:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v6 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20220527190307.GG2960187@ziepe.ca>
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
 <20220527125501.GD2960187@ziepe.ca>
 <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
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

On Fri, May 27, 2022 at 09:35:07AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2022-05-27 06:55, Jason Gunthorpe wrote:
> > On Thu, Apr 07, 2022 at 09:47:16AM -0600, Logan Gunthorpe wrote:
> >> +static void pci_p2pdma_unmap_mappings(void *data)
> >> +{
> >> +	struct pci_dev *pdev = data;
> >> +	struct pci_p2pdma *p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
> >> +
> >> +	/* Ensure no new pages can be allocated in mappings */
> >> +	p2pdma->active = false;
> >> +	synchronize_rcu();
> >> +
> >> +	unmap_mapping_range(p2pdma->inode->i_mapping, 0, 0, 1);
> >> +
> >> +	/*
> >> +	 * On some architectures, TLB flushes are done with call_rcu()
> >> +	 * so to ensure GUP fast is done with the pages, call synchronize_rcu()
> >> +	 * before freeing them.
> >> +	 */
> >> +	synchronize_rcu();
> >> +	pci_p2pdma_free_mappings(p2pdma->inode->i_mapping);
> > 
> > With the series from Felix getting close this should get updated to
> > not set pte_devmap and use proper natural refcounting without any of
> > this stuff.
> 
> Can you send a link? I'm not sure what you are referring to.

IIRC this is the last part:

https://lore.kernel.org/linux-mm/20220524190632.3304-1-alex.sierra@amd.com/

And the earlier bit with Christoph's pieces looks like it might get
merged to v5.19..

The general idea is once pte_devmap is not set then all the
refcounting works the way it should. This is what all new ZONE_DEVICE
users should do..

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
