Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CF4EBE
	for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749601417; cv=none; b=NWvFKWLFTUCleBUh/TtIpkJfv5TRdni+IJuJkYbHWOdeLGAVC0Es5FKjX6aQIKmntvsXeFqpNMBwve1jkhxIn8DHvQc43p0f02Qtc9R4dR9MSqlkQ5qk5iZUWXzq+7+Kc91MFwh5pUNvXKuS6WPqPdASsqpC44I63xfMJCLLcUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749601417; c=relaxed/simple;
	bh=dvK1RdwWb1CQsf+37pV/ByhW/qenOogBXreLlC1KfCU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eMCzUFRSXyaLWKVkyrI8ypsQTWYgkqyScX6CYecg7jk4C/w/FX2EHN10F7mFefxrkYrNoLoPl9mN9YJMRNDcFLz6s4xUQ+OKp8xfBi9nf+4E35+iR+o/id+bs1e7LwATMJ84HcFnSrB4UotKeZfOxUE9+H2TrlPTYJLLauRZkwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id D4FCD1612BD;
	Wed, 11 Jun 2025 00:23:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 291AF20025;
	Wed, 11 Jun 2025 00:23:26 +0000 (UTC)
Date: Tue, 10 Jun 2025 20:24:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, iommu@lists.linux.dev
Subject: [RFC][PATCH] iommu/dma: Do not call swiotlb tracepoint when not
 defined
Message-ID: <20250610202457.5a599336@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 291AF20025
X-Stat-Signature: uhqfc8ahmknazqw9ayr1uzuucf59k9iu
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/XhJVWvkRYvxlRf7t2Kf7y9hhbGWBZiCY=
X-HE-Tag: 1749601406-69543
X-HE-Meta: U2FsdGVkX1/fhFxzNrLk0/RbXv5SL2V3zCR9XcPPGui/aa1Hd6CqiYX7ePU1Dfryo9c3OvaDu4suarjYO+masLYrUWq+YsxFaiVWcuS0rQxXu9DJi8SVFs8+DFB/fhqsDLxlwDi572uX+Kt8iQWULL0EghBlP2Y13oPCK4oAgjOLBvuBJzLX75AeG8UHMwil4zCVfhxTMZwbDrE7VkIX9dvW+0z+J+Zz18snl+xYjqN+ZiDsvP/goWvQRxdb43U3ciffdBn6Jp3GfwGTSQx6FdEtdMHe5xGsPKA78kJLQ+xtY26onCezWc4bJflBj16tTE994bqS3Z9qbPzpuWpHh3nXMOWH+IPwKr5YlRKKsety72Uc2+Wpa0sww86I+kVMi2ew9gt8jkqqrzkrjoQg/QJ7RFWTTUfGprsJR9SsqTM=


I'm working on code that will warn when a tracepoint is defined but not
used. As the TRACE_EVENT() logic still creates all the code regardless if
something calls the trace_<event>() function. It wastes around 5K per trace
event (less for tracepoints).

But it seems that the code in drivers/iommu/dma-iommu.c does the opposite.
It calls the trace_swiotlb_bounced() tracepoint without it being defined.
The tracepoint is defined in kernel/dma/swiotlb.c when CONFIG_SWIOTLB is
defined, but this code exists when that config is not defined.

This now fails with my work because I have all the callers reference the
tracepoint that they will call.

Thanks to the kernel test robot, it found this:

  https://lore.kernel.org/all/202506091015.7zd87kI7-lkp@intel.com/

Currently, I made this patch and it makes it build. But I don't like the
patch. It's in the middle of a function that has a lot of things called
swiotlb which seems like the #ifdef should be around much more than the
tracepoint hook that has no tracepoint attached to it.

Hopefully someone else can make a proper patch. I will be pushing my work
to linux-next during this cycle.

Not-signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ea2ef53bd4fe..7c0ada27e66f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1153,8 +1153,9 @@ static phys_addr_t iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 		return (phys_addr_t)DMA_MAPPING_ERROR;
 	}
 
+#ifdef CONFIG_SWIOTLB
 	trace_swiotlb_bounced(dev, phys, size);
-
+#endif
 	phys = swiotlb_tbl_map_single(dev, phys, size, iova_mask(iovad), dir,
 			attrs);
 
