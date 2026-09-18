Received: from queue02c.mail.zen.net.uk (queue02c.mail.zen.net.uk [212.23.3.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6C2547054;
	Fri, 18 Sep 2026 07:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.23.3.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789714893; cv=none; b=qTVH9yZrwBkxBVJmKYv9JAhtFS2orKsf//ShP6O972fMrrxC/QM0XFnfmS8Cpl5ajdamCRYFidsk875ohrAKKoHppcmhQ7Ye16VeBze489ZIruEf6DRoP8DSo5ZfIQtQlujQ+EzwPAbAD7B2fEYG5bq1jwJ1bBtxck9x54J2EYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789714893; c=relaxed/simple;
	bh=D3tXcR0yXcecukPOsQcdq2tK67La2xUkLLzl3GWTeeo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LJ8IVtOFBwYs9kQXlWUnd6OSM7vIfVc+c4NC001sQiBIcuiYv+aiS9KAAZSBMtKoxQK9AWgvYuX5mkpNgWcZehzEL8jaGMO+um96myMMvv7zVCICzkw+CElTaCGKt1gPrM1tvh49liB4onmKJKb2zDcRciDvc+hKwDe/Bbdrh/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dingwall.me.uk; spf=pass smtp.mailfrom=dingwall.me.uk; arc=none smtp.client-ip=212.23.3.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dingwall.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dingwall.me.uk
Received: from [212.23.1.3] (helo=smarthost01b.sbp.mail.zen.net.uk)
	by queue02c.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97)
	(envelope-from <james@dingwall.me.uk>)
	id 1x7SE9-0000000BaNw-3JP2;
	Fri, 18 Sep 2026 06:37:41 +0000
Received: from [217.155.64.189] (helo=mail0.xen.dingwall.me.uk)
	by smarthost01b.sbp.mail.zen.net.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97)
	(envelope-from <james@dingwall.me.uk>)
	id 1x7SE1-0000000APxL-1jF3;
	Fri, 18 Sep 2026 06:37:33 +0000
Received: from localhost (localhost [IPv6:::1])
	by mail0.xen.dingwall.me.uk (Postfix) with ESMTP id B8838F401F0;
	Fri, 18 Sep 2026 07:37:32 +0100 (BST)
X-Virus-Scanned: Debian amavis at dingwall.me.uk
Received: from mail0.xen.dingwall.me.uk ([IPv6:::1])
 by localhost (mail0.xen.dingwall.me.uk [IPv6:::1]) (amavis, port 10024)
 with ESMTP id Yl6ZiyD8Q2tD; Fri, 18 Sep 2026 07:37:32 +0100 (BST)
Received: from behemoth.dingwall.me.uk (behemoth.dingwall.me.uk [IPv6:2a02:8010:698e:302::c0a8:105])
	by dingwall.me.uk (Postfix) with ESMTP id 9C0D1F401ED;
	Fri, 18 Sep 2026 07:37:32 +0100 (BST)
Received: by behemoth.dingwall.me.uk (Postfix, from userid 1000)
	id 8B7A5123608D; Fri, 18 Sep 2026 07:37:32 +0100 (BST)
Date: Fri, 18 Sep 2026 07:37:32 +0100
From: James Dingwall <james@dingwall.me.uk>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: BUG kernel 6.12.19 defautl_swiotlb_limit() returns wrong value
 for CONFIG_SWIOTLB_DYNAMIC=y effects atm only under XEN dom0
Message-ID: <aqzcLJQCCmqpdxz3@dingwall.me.uk>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Originating-smarthost01b-IP: [217.155.64.189]
Feedback-ID: 217.155.64.189

Hi,

I've been having a problem with a Dell HBA330 SCSI controller (mpt3sas)
when booting under Xen and CONFIG_SWIOTLB_DYNAMIC=y is set.  I had a
similar issue with a megaraid_sas card that I previously posted about:

https://lkml.iu.edu/hypermail/linux/kernel/2407.3/08254.html

In that case we rebuilt the kernel with CONFIG_SWIOTLB_DYNAMIC=n.
While investigating the current problem I came across a patch that was
posted on the xen-devel list:

https://lists.xen.org/archives/html/xen-devel/2025-05/msg00991.html

I have applied that to the Ubuntu 7.0.0-31 kernel sources which has
resolved the controller initialisation error I was encountering and the
system now boots as expected.

[    3.921136] mpt3sas_cm0: no suitable DMA mask for 0000:03:00.0
[    3.921275] mpt3sas_cm0: failure at drivers/scsi/mpt3sas/mpt3sas_scsih.c:13610/_scsih_probe()!

I've included the patch below, I don't have the author's real address
for the s-o-b.  I'm able to test alternative fixes if there are any
issues with this one.

Thanks,
James


Signed-off-by: Andreas Greve andreas.greve@xxxxxxxxxx
Tested-by: James Dingwall <james@dingwall.me.uk>

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index abcf3fa63a56..742e6cbbe852 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1654,7 +1654,16 @@ phys_addr_t default_swiotlb_base(void)
 phys_addr_t default_swiotlb_limit(void)
 {
 #ifdef CONFIG_SWIOTLB_DYNAMIC
-	return io_tlb_default_mem.phys_limit;
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	phys_addr_t retval = mem->defpool.end;
+	struct io_tlb_pool *pool;
+	rcu_read_lock();
+	list_for_each_entry_rcu(pool, &mem->pools, node) {
+		if (pool->end > retval)
+			retval = pool->end;
+	}
+	rcu_read_unlock();
+	return retval - 1;
 #else
 	return io_tlb_default_mem.defpool.end - 1;
 #endif
