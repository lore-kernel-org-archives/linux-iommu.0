Return-Path: <SRS0=5fq6=XW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69185C4360C
	for <iommu@archiver.kernel.org>; Fri, 27 Sep 2019 05:35:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE1E20872
	for <iommu@archiver.kernel.org>; Fri, 27 Sep 2019 05:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE1E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6678EF2E;
	Fri, 27 Sep 2019 05:35:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B0301F29
	for <iommu@lists.linux-foundation.org>;
	Fri, 27 Sep 2019 05:35:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 871C71C0
	for <iommu@lists.linux-foundation.org>;
	Fri, 27 Sep 2019 05:35:02 +0000 (UTC)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
	[209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E18D7862E
	for <iommu@lists.linux-foundation.org>;
	Fri, 27 Sep 2019 05:35:01 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id b204so1111186pfb.11
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 22:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=mBl7CqEFnuiBVIosznLhBRSsfbIbyqx6omx1FBXMtlc=;
	b=cBS4QI2ZRScJdK+/8LqEVolihAd4YHjZPa7X1iEUVH4mYrygbqdjvBESlntWK8F0AB
	4UVm6rNxDzbtZsy2kLKTqfRyRFR3sDP52AB+0N+vAaMJtPKEwAp1SlEHBm9uStJYgRaI
	sGM07kMOcZyUias1OsKub/qPRIBirlNcz95JVuoD4jgqx1CkvnmHrTqlqNxMNa5biW66
	yAKegyV0hnpzRcr8tdEQChshw/ia0S1dvF+y/2ydSu2HBhDleP94+qLncYrL5UdWgI06
	chmEAddFIR9mQQg6KHQRgoipaTI5IO8SJ4c9RggL4yr+o60VXVAkImFe0mx4Mr4+ZCx7
	gNRA==
X-Gm-Message-State: APjAAAUgPWUfaWw7fcpmYAFU9j9Aav8QDoO2sbDQISCH5p0QUwpbDl4a
	aGm0n81FqZB58Bjcr+eAv0D0ggVpVBMQTe3LaRKObv/G/NzNLRFaIgIwK7/UfpCje2ymAtrAElI
	UKrv4yA2XmPv1fSjaHml9rl8RxnCL3g==
X-Received: by 2002:a17:902:bcc7:: with SMTP id
	o7mr2651676pls.171.1569562501265; 
	Thu, 26 Sep 2019 22:35:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw+d8wnzo3fq8B9I9MvsVPlu0L/7S0a7m9u5S0N98kvFGYIuq3wGdoeC/vaNpEkgYdVd0Zc4A==
X-Received: by 2002:a17:902:bcc7:: with SMTP id
	o7mr2651659pls.171.1569562500947; 
	Thu, 26 Sep 2019 22:35:00 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
	by smtp.gmail.com with ESMTPSA id s3sm3832607pjq.32.2019.09.26.22.34.56
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 26 Sep 2019 22:34:59 -0700 (PDT)
Date: Fri, 27 Sep 2019 13:34:49 +0800
From: Peter Xu <peterx@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH 2/4] iommu/vt-d: Add first level page table interfaces
Message-ID: <20190927053449.GA9412@xz-x1>
References: <20190923122454.9888-1-baolu.lu@linux.intel.com>
	<20190923122454.9888-3-baolu.lu@linux.intel.com>
	<20190925052157.GL28074@xz-x1>
	<c9792e0b-bf42-1dbb-f060-0b1a43125f47@linux.intel.com>
	<20190926034905.GW28074@xz-x1>
	<52778812-129b-0fa7-985d-5814e9d84047@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52778812-129b-0fa7-985d-5814e9d84047@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Cc: kevin.tian@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
	ashok.raj@intel.com, kvm@vger.kernel.org,
	sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, yi.y.sun@intel.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi, Baolu,

On Fri, Sep 27, 2019 at 10:27:24AM +0800, Lu Baolu wrote:
> > > > > +	spin_lock(&(domain)->page_table_lock);				\
> > > > 
> > > > Is this intended to lock here instead of taking the lock during the
> > > > whole page table walk?  Is it safe?
> > > > 
> > > > Taking the example where nm==PTE: when we reach here how do we
> > > > guarantee that the PMD page that has this PTE is still valid?
> > > 
> > > We will always keep the non-leaf pages in the table,
> > 
> > I see.  Though, could I ask why?  It seems to me that the existing 2nd
> > level page table does not keep these when unmap, and it's not even use
> > locking at all by leveraging cmpxchg()?
> 
> I still need some time to understand how cmpxchg() solves the race issue
> when reclaims pages. For example.
> 
> Thread A				Thread B
> -A1: check all PTE's empty		-B1: up-level PDE valid
> -A2: clear the up-level PDE
> -A3: reclaim the page			-B2: populate the PTEs
> 
> Both (A1,A2) and (B1,B2) should be atomic. Otherwise, race could happen.

I'm not sure of this, but IMHO it is similarly because we need to
allocate the iova ranges from iova allocator first, so thread A (who's
going to unmap pages) and thread B (who's going to map new pages)
should never have collapsed regions if happening concurrently.  I'm
referring to intel_unmap() in which we won't free the iova region
before domain_unmap() completes (which should cover the whole process
of A1-A3) so the same iova range to be unmapped won't be allocated to
any new pages in some other thread.

There's also a hint in domain_unmap():

  /* we don't need lock here; nobody else touches the iova range */

> 
> Actually, the iova allocator always packs IOVA ranges close to the top
> of the address space. This results in requiring a minimal number of
> pages to map the allocated IOVA ranges, which makes memory onsumption
> by IOMMU page tables tolerable. Hence, we don't need to reclaim the
> pages until the whole page table is about to tear down. The real data
> on my test machine also improves this.

Do you mean you have run the code with a 1st-level-supported IOMMU
hardware?  IMHO any data point would be good to be in the cover letter
as reference.

[...]

> > > > > +static struct page *
> > > > > +mmunmap_pte_range(struct dmar_domain *domain, pmd_t *pmd,
> > > > > +		  unsigned long addr, unsigned long end,
> > > > > +		  struct page *freelist, bool reclaim)
> > > > > +{
> > > > > +	int i;
> > > > > +	unsigned long start;
> > > > > +	pte_t *pte, *first_pte;
> > > > > +
> > > > > +	start = addr;
> > > > > +	pte = pte_offset_kernel(pmd, addr);
> > > > > +	first_pte = pte;
> > > > > +	do {
> > > > > +		set_pte(pte, __pte(0));
> > > > > +	} while (pte++, addr += PAGE_SIZE, addr != end);
> > > > > +
> > > > > +	domain_flush_cache(domain, first_pte, (void *)pte - (void *)first_pte);
> > > > > +
> > > > > +	/* Add page to free list if all entries are empty. */
> > > > > +	if (reclaim) {
> > > > 
> > > > Shouldn't we know whether to reclaim if with (addr, end) specified as
> > > > long as they cover the whole range of this PMD?
> > > 
> > > Current policy is that we don't reclaim any pages until the whole page
> > > table will be torn down.
> > 
> > Ah OK.  But I saw that you're passing in relaim==!start_addr.
> > Shouldn't that errornously trigger if one wants to unmap the 1st page
> > as well even if not the whole address space?
> 
> IOVA 0 is assumed to be reserved by the allocator. Otherwise, we have no
> means to check whether a IOVA is valid.

Is this an assumption of the allocator?  Could that change in the future?

IMHO that's not necessary if so, after all it's as simple as replacing
(!start_addr) with (start == 0 && end == END).  I see that in
domain_unmap() it has a similar check when freeing pgd:

  if (start_pfn == 0 && last_pfn == DOMAIN_MAX_PFN(domain->gaw))

Thanks,

-- 
Peter Xu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
