Return-Path: <SRS0=praM=XY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDDEC32793
	for <iommu@archiver.kernel.org>; Sun, 29 Sep 2019 05:25:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2DF1206C0
	for <iommu@archiver.kernel.org>; Sun, 29 Sep 2019 05:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DF1206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B99B1B79;
	Sun, 29 Sep 2019 05:25:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B3803B62
	for <iommu@lists.linux-foundation.org>;
	Sun, 29 Sep 2019 05:25:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4404071C
	for <iommu@lists.linux-foundation.org>;
	Sun, 29 Sep 2019 05:25:51 +0000 (UTC)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
	[209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 93642368B1
	for <iommu@lists.linux-foundation.org>;
	Sun, 29 Sep 2019 05:25:50 +0000 (UTC)
Received: by mail-pf1-f199.google.com with SMTP id a1so5157154pfn.1
	for <iommu@lists.linux-foundation.org>;
	Sat, 28 Sep 2019 22:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=U2Fqhrhhc3c5hT+09GB0Tz123AzZHSVYeE1k74C2N8Q=;
	b=AXROnTny4CRgvKONiQb+gCYq/EvICegPvnyX+NlZMF7HxmHDUlVkl+LC6IdVqQf5Xk
	EeKLkc5wLHoWVQbqGX9VZ6TTgQFHIsVNtFWE3bKnvdggkSqFStb5PYuxd2cHQWSb1LpT
	gxvx0K9earRlAc13v5H4k0Ejt6DFdVftxry/35svKTFDByO6a0omnsw5WAOu9H7dWyH2
	EESIzWjKDNrV2fhNFcXRNq5Cs3WZU1y3aNWBHvOIWdU5YzD+iBC6AKDQq9GfIN6X20kh
	aZ87crBiV/D74vdeQlVnK0nwRVNBDrlA9SbvFZFm/OgiZICyf+9Q/5maF1cmZsuh+ojl
	yL4A==
X-Gm-Message-State: APjAAAWlAX/+mdcCvU7m8EC6ytRlEjMDUjcJzmyl+2xo6h6quRHtEhsp
	cQIFjhe/4poEp2ezFD59jMSBtaWFJsHq7fpjiZnMzKrQRbG5b+1mgsCCg9pmYu6WjsCasDXj9lz
	eX5saAnVZD3zfcJnZVXFeIuJbhdIxNA==
X-Received: by 2002:a65:6111:: with SMTP id z17mr17809440pgu.415.1569734749964;
	Sat, 28 Sep 2019 22:25:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxSwESBBqWbUZ8IYCB+ndAeHAFp/knXskQIwKbF6UdAPwArDrPxhK0qMIyDkQyFVFJVbYrxHA==
X-Received: by 2002:a65:6111:: with SMTP id z17mr17809411pgu.415.1569734749539;
	Sat, 28 Sep 2019 22:25:49 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
	by smtp.gmail.com with ESMTPSA id y6sm7985721pfp.82.2019.09.28.22.25.44
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sat, 28 Sep 2019 22:25:47 -0700 (PDT)
Date: Sun, 29 Sep 2019 13:25:32 +0800
From: Peter Xu <peterx@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH 2/4] iommu/vt-d: Add first level page table interfaces
Message-ID: <20190929052532.GA12953@xz-x1>
References: <20190923122454.9888-1-baolu.lu@linux.intel.com>
	<20190923122454.9888-3-baolu.lu@linux.intel.com>
	<20190925052157.GL28074@xz-x1>
	<c9792e0b-bf42-1dbb-f060-0b1a43125f47@linux.intel.com>
	<20190926034905.GW28074@xz-x1>
	<52778812-129b-0fa7-985d-5814e9d84047@linux.intel.com>
	<20190927053449.GA9412@xz-x1>
	<66823e27-aa33-5968-b5fd-e5221fb1fffe@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <66823e27-aa33-5968-b5fd-e5221fb1fffe@linux.intel.com>
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

On Sat, Sep 28, 2019 at 04:23:16PM +0800, Lu Baolu wrote:
> Hi Peter,
> 
> On 9/27/19 1:34 PM, Peter Xu wrote:
> > Hi, Baolu,
> > 
> > On Fri, Sep 27, 2019 at 10:27:24AM +0800, Lu Baolu wrote:
> > > > > > > +	spin_lock(&(domain)->page_table_lock);				\
> > > > > > 
> > > > > > Is this intended to lock here instead of taking the lock during the
> > > > > > whole page table walk?  Is it safe?
> > > > > > 
> > > > > > Taking the example where nm==PTE: when we reach here how do we
> > > > > > guarantee that the PMD page that has this PTE is still valid?
> > > > > 
> > > > > We will always keep the non-leaf pages in the table,
> > > > 
> > > > I see.  Though, could I ask why?  It seems to me that the existing 2nd
> > > > level page table does not keep these when unmap, and it's not even use
> > > > locking at all by leveraging cmpxchg()?
> > > 
> > > I still need some time to understand how cmpxchg() solves the race issue
> > > when reclaims pages. For example.
> > > 
> > > Thread A				Thread B
> > > -A1: check all PTE's empty		-B1: up-level PDE valid
> > > -A2: clear the up-level PDE
> > > -A3: reclaim the page			-B2: populate the PTEs
> > > 
> > > Both (A1,A2) and (B1,B2) should be atomic. Otherwise, race could happen.
> > 
> > I'm not sure of this, but IMHO it is similarly because we need to
> > allocate the iova ranges from iova allocator first, so thread A (who's
> > going to unmap pages) and thread B (who's going to map new pages)
> > should never have collapsed regions if happening concurrently.  I'm
> 
> Although they don't collapse, they might share a same pmd entry. If A
> cleared the pmd entry and B goes ahead with populating the pte's. It
> will crash.

My understanding is that if A was not owning all the pages on that PMD
entry then it will never free the page that was backing that PMD
entry.  Please refer to the code in dma_pte_clear_level() where it
has:

        /* If range covers entire pagetable, free it */
        if (start_pfn <= level_pfn &&
                last_pfn >= level_pfn + level_size(level) - 1) {
                ...
        } else {
                ...
        }

Note that when going into the else block, the PMD won't be freed but
only the PTEs that upon the PMD will be cleared.

In the case you mentioned above, IMHO it should go into that else
block.  Say, thread A must not contain the whole range of that PMD
otherwise thread B won't get allocated with pages within that range
covered by the same PMD.

Thanks,

-- 
Peter Xu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
