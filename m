Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AAFC433F5
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 19:55:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4091261350
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 19:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4091261350
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A03141580;
	Tue, 28 Sep 2021 19:55:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vgv6DCbuEtNH; Tue, 28 Sep 2021 19:55:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C6FB541586;
	Tue, 28 Sep 2021 19:55:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F714C000F;
	Tue, 28 Sep 2021 19:55:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EC93C000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:55:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7C550405E9
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:55:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oZnWmQ7fKrJ9 for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 19:55:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9657E40175
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:55:21 +0000 (UTC)
Received: by mail-io1-xd2a.google.com with SMTP id z184so116681iof.5
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 12:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=1dkOoEowsVEai15whHpEaoKklD3em5dZIMAiSQ/NBXA=;
 b=ZeD06VESIVwTz1xeRXSBHGWRRwsuqhJZqQwA7cS8w7S36OQJ9M42GPOt60GoPm4LLN
 EhyE/ygXrJFIONCKDGKyPvXji5TLlEPtth9nQsRZuy/IeYGcjbWWP7tWPdZ/g49vlVEV
 D4ziTYxHr8njp8La9hvWgYGQygcfX8fs0pN+lyR+t1RqdyHwC/7j9ctRh39DBoSxrCAF
 W7fZNVt8JY3zn5Gg4p3VkhBgFht+DBRN4Umj8cH8EE9Lo3YE6taSK+G2eOxlcDNL8a69
 u/eiBSoiyJw8GFFxy3BA4RXuA7thqLvfHkJROM11lKZey1rvl8Ml9UFTDNyZ2L/Vl66Z
 9YzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1dkOoEowsVEai15whHpEaoKklD3em5dZIMAiSQ/NBXA=;
 b=VVc0LCfYNnJcOt0dYx9gTxVt8SyKB9bicEt3/t7RjftOvqjplpn8Gq2bQxVnsp9oxX
 Y75q9lZ3v2D1nLbUyYP7OAzMtXchy7IG35hfS3U4TQQZ/6wFLFf33DX0v91+AQMwoo64
 s7BernxsyyDiqLEXrgZTSHKCqVrLDWz+JaWSWwANyAouQZJUc+FDQBQhBX8U4oCk8AcT
 LF+nkMkM8xAsnd4mwqGyB2px2nlja7xRrkgF/PjmQ6ceMy7CrQYUkqwJu8KEfAnktdnR
 lPcQEFJw4fuVJNBHimN4QWAYJa9FhtegQXoQWTePfCkC2TLiWDZyaYFAuF0Uuc9uscYs
 wG5w==
X-Gm-Message-State: AOAM532TpnnMDObXA+0aVev9Seh5BQew/vBJ381LbTLA3L60xzxa5jlW
 cA6OnCdW/6yjS99SRMiotT6ipQ==
X-Google-Smtp-Source: ABdhPJxDG+imIW+LC31md8sJ9W5FJ6CYFuQFlJipqlnxhkrntzvi5fuKARgO5VrFwZOn9a7R7YqD3w==
X-Received: by 2002:a5e:c018:: with SMTP id u24mr5346781iol.129.1632858920781; 
 Tue, 28 Sep 2021 12:55:20 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id r20sm30511ioh.19.2021.09.28.12.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 12:55:20 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVJCA-007Gjs-VN; Tue, 28 Sep 2021 16:55:18 -0300
Date: Tue, 28 Sep 2021 16:55:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20210928195518.GV3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-20-logang@deltatee.com>
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

On Thu, Sep 16, 2021 at 05:40:59PM -0600, Logan Gunthorpe wrote:
> +int pci_mmap_p2pmem(struct pci_dev *pdev, struct vm_area_struct *vma)
> +{
> +	struct pci_p2pdma_map *pmap;
> +	struct pci_p2pdma *p2pdma;
> +	int ret;
> +
> +	/* prevent private mappings from being established */
> +	if ((vma->vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
> +		pci_info_ratelimited(pdev,
> +				     "%s: fail, attempted private mapping\n",
> +				     current->comm);
> +		return -EINVAL;
> +	}
> +
> +	pmap = pci_p2pdma_map_alloc(pdev, vma->vm_end - vma->vm_start);
> +	if (!pmap)
> +		return -ENOMEM;
> +
> +	rcu_read_lock();
> +	p2pdma = rcu_dereference(pdev->p2pdma);
> +	if (!p2pdma) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	ret = simple_pin_fs(&pci_p2pdma_fs_type, &pci_p2pdma_fs_mnt,
> +			    &pci_p2pdma_fs_cnt);
> +	if (ret)
> +		goto out;
> +
> +	ihold(p2pdma->inode);
> +	pmap->inode = p2pdma->inode;
> +	rcu_read_unlock();
> +
> +	vma->vm_flags |= VM_MIXEDMAP;

Why is this a VM_MIXEDMAP? Everything fault sticks in here has a
struct page, right?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
