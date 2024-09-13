Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B480674076
	for <iommu@lists.linux.dev>; Fri, 13 Sep 2024 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726239424; cv=none; b=LBYYK9zYBNfmRoYZq7sMXiPF9ISd4r6bVxlWp0vZ1lcEF3jF0NSgXMYR9/WSw4C1NHfsndF+G6eIWlXp6h1dl8FXVvxsTGGXpT9jq2HplPsqMsY8l5qVZDOBvXw6WR1JX0wY7zSj3KGbX9mBOx0Bd6m9tfQZoA7TtMwJOSwlTs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726239424; c=relaxed/simple;
	bh=u0oqinYA3P1PM3z6qIR5L+Du3AcQ6m6F7ZK3431VRk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UB86aLieA2bC4SeMU8V4gWesYnz29PeKIz/mJm2wXHWhaV1+a/Y5q/7RbrdhHUNeLzPYMnrAFO0L5jSD+z4lHa1l7Xa/cG2UAa/balBcKts8todnEotvFol7kh7rYOwsHJ2oQFjL/BkjFpH5zylN0+1S83e0Q/XWtFuYUtYVVbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Hd3d3OBG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Hd3d3OBG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Hd3d3OBG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Hd3d3OBG"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 04A941FD10;
	Fri, 13 Sep 2024 14:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726239421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MHWoAUv4ldqATPzGpmkCnxdPYx6ziXNFVp80sHhmRlM=;
	b=Hd3d3OBG+MS0uDJ5W/ZkTD7/0ekjKu8fMqihMMXxT1pOwq2AMisqIk/5nplvH8GkPhfY7+
	sj/YhjwnkfJxzp471M7j66qePv6D7hA6ewX0dk/3emRmcqtRShZnNktCfcgu3NFP8EXMNh
	6dvfKiXur1eVe+PQo/GBv2lJaUCuvgo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726239421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MHWoAUv4ldqATPzGpmkCnxdPYx6ziXNFVp80sHhmRlM=;
	b=Hd3d3OBG+MS0uDJ5W/ZkTD7/0ekjKu8fMqihMMXxT1pOwq2AMisqIk/5nplvH8GkPhfY7+
	sj/YhjwnkfJxzp471M7j66qePv6D7hA6ewX0dk/3emRmcqtRShZnNktCfcgu3NFP8EXMNh
	6dvfKiXur1eVe+PQo/GBv2lJaUCuvgo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C06C513999;
	Fri, 13 Sep 2024 14:57:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q+FxLbxS5GZ5QwAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 13 Sep 2024 14:57:00 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH] xen/swiotlb: add alignment check for dma buffers
Date: Fri, 13 Sep 2024 16:56:55 +0200
Message-ID: <20240913145655.10076-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

When checking a memory buffer to be consecutive in machine memory,
the alignment needs to be checked, too. Failing to do so might result
in DMA memory not being aligned according to its requested size,
leading to error messages like:

  4xxx 0000:2b:00.0: enabling device (0140 -> 0142)
  4xxx 0000:2b:00.0: Ring address not aligned
  4xxx 0000:2b:00.0: Failed to initialise service qat_crypto
  4xxx 0000:2b:00.0: Resetting device qat_dev0
  4xxx: probe of 0000:2b:00.0 failed with error -14

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/swiotlb-xen.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 35155258a7e2..11f4b1195324 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -78,9 +78,15 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
 {
 	unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
 	unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
+	unsigned int order = get_order(size);
 
 	next_bfn = pfn_to_bfn(xen_pfn);
 
+	/* If buffer is physically aligned, ensure DMA alignment. */
+	if (IS_ALIGNED(p, 1UL << (order + PAGE_SHIFT)) &&
+	    !IS_ALIGNED(next_bfn, 1UL << order))
+		return 1;
+
 	for (i = 1; i < nr_pages; i++)
 		if (pfn_to_bfn(++xen_pfn) != ++next_bfn)
 			return 1;
-- 
2.43.0

