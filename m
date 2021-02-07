Return-Path: <SRS0=bugC=HJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E433FC433E0
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 21:34:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF82B64E15
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 21:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF82B64E15
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B0BA686072;
	Sun,  7 Feb 2021 21:34:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xi8Hu26ePexs; Sun,  7 Feb 2021 21:34:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D6ED4862F4;
	Sun,  7 Feb 2021 21:34:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6086C0891;
	Sun,  7 Feb 2021 21:34:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61EC3C013A
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 21:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4FD0186F9E
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 21:34:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cK71WpRXrmTL for <iommu@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 21:34:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 37A8886F90
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 21:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Y+S/LX44a9NNx3dGKU3W10H4coPDrc53Kmvv4eVUILs=; b=jk3k6ovvjVTWnfOKs4KKL28gHs
 E3infYdAisvXmp2e28FqZSi8PowAudg/J4HUU+RQZkOd4jyrho7b1D2lBJL/Zi0gyDGl6Zhkz6+CX
 61rDbpkJo3h7u9i/iGE0BIu1tHx5KkSe0b78+GMS62RmlOZcEpWcN6GRwbMQI2HBmJ9ukrRvmeHN8
 T92alHBcH65ZJXdEW+4Ldz5OtgSFwNgd11YIKUjsk39oW/3MyqppThjjUZmLKNFhLTFE34L8rgcYl
 1AScMZodOOkOZCxEDymnpEc3MrtSAHSFauRuDhn3zomqsOxWHJFoMLUqZ1wtHGze+DL2xmOnj+hr4
 7Qc/yQog==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1l8rh3-0059pm-0q; Sun, 07 Feb 2021 21:34:11 +0000
Date: Sun, 7 Feb 2021 21:34:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory pin
Message-ID: <20210207213409.GL308988@casper.infradead.org>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com,
 Sihang Chen <chensihang1@hisilicon.com>, jgg@ziepe.ca,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 gregkh@linuxfoundation.org, zhangfei.gao@linaro.org,
 Andrew Morton <akpm@linux-foundation.org>, liguozhu@hisilicon.com,
 linux-arm-kernel@lists.infradead.org
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

On Sun, Feb 07, 2021 at 04:18:03PM +0800, Zhou Wang wrote:
> SVA(share virtual address) offers a way for device to share process virtual
> address space safely, which makes more convenient for user space device
> driver coding. However, IO page faults may happen when doing DMA
> operations. As the latency of IO page fault is relatively big, DMA
> performance will be affected severely when there are IO page faults.
> >From a long term view, DMA performance will be not stable.
> 
> In high-performance I/O cases, accelerators might want to perform
> I/O on a memory without IO page faults which can result in dramatically
> increased latency. Current memory related APIs could not achieve this
> requirement, e.g. mlock can only avoid memory to swap to backup device,
> page migration can still trigger IO page fault.

Well ... we have two requirements.  The application wants to not take
page faults.  The system wants to move the application to a different
NUMA node in order to optimise overall performance.  Why should the
application's desires take precedence over the kernel's desires?  And why
should it be done this way rather than by the sysadmin using numactl to
lock the application to a particular node?

> +struct mem_pin_container {
> +	struct xarray array;
> +	struct mutex lock;
> +};

I don't understand what the lock actually protects.

> +struct pin_pages {
> +	unsigned long first;
> +	unsigned long nr_pages;
> +	struct page **pages;
> +};

I don't think you need 'first', and I think you can embed the pages
array into this struct, removing one allocation.

> +	xa_for_each(&priv->array, idx, p) {
> +		unpin_user_pages(p->pages, p->nr_pages);
> +		xa_erase(&priv->array, p->first);
> +		vfree(p->pages);
> +		kfree(p);
> +	}
> +
> +	mutex_destroy(&priv->lock);
> +	xa_destroy(&priv->array);

If you just called xa_erase() on every element of the array, you don't need
to call xa_destroy().

> +	if (!can_do_mlock())
> +		return -EPERM;

You check for can_do_mlock(), but you don't account the pages to this
rlimit.

> +	first = (addr->addr & PAGE_MASK) >> PAGE_SHIFT;

You don't need to mask off the bits, the shift will remove them.

> +	last = ((addr->addr + addr->size - 1) & PAGE_MASK) >> PAGE_SHIFT;

DIV_ROUND_UP()?

> +	pages = vmalloc(nr_pages * sizeof(struct page *));

kvmalloc().  vmalloc() always allocates at least a page, so we want to
use kmalloc if the size is small.  Also, use array_size() -- I know this
can't overflow, but let's be clear

> +	ret = pin_user_pages_fast(addr->addr & PAGE_MASK, nr_pages,
> +				  flags | FOLL_LONGTERM, pages);
> +	if (ret != nr_pages) {
> +		pr_err("mempinfd: Failed to pin page\n");

No.  You mustn't allow the user to be able to generate messages to syslog,
just by passing garbage to a syscall.

> +	ret = xa_insert(&priv->array, p->first, p, GFP_KERNEL);
> +	if (ret)
> +		goto unpin_pages;

Hmm.  So we can't pin two ranges which start at the same address, but we
can pin two overlapping ranges.  Is that OK?

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
