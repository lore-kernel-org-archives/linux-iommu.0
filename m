Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CE8C10F0E
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 10:04:41 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6935B2083E
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 10:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YBZTCpib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6935B2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 391C9C11;
	Tue,  9 Apr 2019 10:04:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 369BB25A
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 10:04:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E9896CF
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 10:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ECN5RtyAoOFeKS2bytXLHxuqXCY8zXSsiaFPh0hQOLE=;
	b=YBZTCpibRaLdOoYWUhK9zEG/0
	BTqM90ug44ilMFjAoeZSG1zHMsGuzCmfCw6zMxBSVSwaiUxPPEttp+BVD4PxBgWkTUiWkcouLTNkm
	3cO3mpOjPHaR+Yh1aXQSmj6s7qR8TCRY9N+dyrq4ShyJKFS2Dx7AsXv29PHt9l+Uwpy5vB3fsc3lZ
	oDu5i+lPtNXqjsNhQ6B4NIrREIcorgn7GuD4o2shm/2Fr4J4b+kNvFVKsnR+9p+9nP/hmcJKHh73X
	bUx5+sib41bVfh8IjO4ycM+bzbqA0x53BifGUJRfr+4NAB7f1nj5WebbWG0HqYZhIw+ANg3On6m0Z
	+SoGUUkRg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
	Hat Linux)) id 1hDncK-0007WU-W6; Tue, 09 Apr 2019 10:04:36 +0000
Date: Tue, 9 Apr 2019 03:04:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 01/18] drivers core: Add I/O ASID allocator
Message-ID: <20190409100436.GA28683@infradead.org>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1554767973-30125-2-git-send-email-jacob.jun.pan@linux.intel.com>
	<20190409100049.GC9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190409100049.GC9224@smile.fi.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.ibm.com>,
	David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190409100436.Vt-5EU__CTmFojwkex3fpMv1LDukR7J947mWV0seSzY@z>

On Tue, Apr 09, 2019 at 01:00:49PM +0300, Andriy Shevchenko wrote:
> I think it makes sense to add a helper macro to rcupdate.h
> (and we have several cases in kernel that can utilize it)
> 
> #define kfree_non_null_rcu(ptr, rcu_head)		\
> 	do {						\
> 		if (ptr)				\
> 			kfree_rcu(ptr, rcu_head);	\
> 	} while (0)
> 
> as a more common pattern for resource deallocators.

I think that should move straight into kfree_rcu.  In general
we expect *free* to deal with NULL pointers transparently, so we
should do so here as well.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
