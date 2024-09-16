Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A13513211A
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 06:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726469285; cv=none; b=aOh8SLZsRso26no2ZAcz0D1FiKsImogNqVeWA9SArAQuUu3CQ5Ujz+AW8akHPKuXSI27FadRFTOqgXMmaUyr2YUHB9iPbL/DMC1pr+EY1DFvrJ5/K8qI6MEqj9b0q1TeyAskKwb/06Y639DRVFsa6MSITSc6Nq7pzWdwwppY/8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726469285; c=relaxed/simple;
	bh=X+nYOOl5O5QuNHliXvszJubXKCo0cFjDXSRuni1z0Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CcHtMPzXbMeBh4q4Yt1VyXDAZYH44oIvcYF0A2rNYlqEm/jZtAA9R2e4tJF0yzJ9zNl3rTYv2TiDqsOfziRk7nT9JEbqGZ4oF3RNEYRN5Nryu/wdajghDc8AKdcicKAEPgmT/2ohe84ZZvJDAeDolrh0CF+ukOSDaBpRtxk3zUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7837C21BEC;
	Mon, 16 Sep 2024 06:48:02 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39020139CE;
	Mon, 16 Sep 2024 06:48:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DrJuDKLU52aOIAAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 16 Sep 2024 06:48:02 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	Jan Beulich <jbeulich@suse.com>
Subject: [PATCH v2 2/2] xen/swiotlb: fix allocated size
Date: Mon, 16 Sep 2024 08:47:48 +0200
Message-ID: <20240916064748.18071-3-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240916064748.18071-1-jgross@suse.com>
References: <20240916064748.18071-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 7837C21BEC
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

The allocated size in xen_swiotlb_alloc_coherent() and
xen_swiotlb_free_coherent() is calculated wrong for the case of
XEN_PAGE_SIZE not matching PAGE_SIZE. Fix that.

Fixes: 7250f422da04 ("xen-swiotlb: use actually allocated size on check physical continuous")
Reported-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
---
 drivers/xen/swiotlb-xen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index ddf5b1df632e..faa2fb7c74ae 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -147,7 +147,7 @@ xen_swiotlb_alloc_coherent(struct device *dev, size_t size,
 	void *ret;
 
 	/* Align the allocation to the Xen page size */
-	size = 1UL << (order + XEN_PAGE_SHIFT);
+	size = ALIGN(size, XEN_PAGE_SIZE);
 
 	ret = (void *)__get_free_pages(flags, get_order(size));
 	if (!ret)
@@ -179,7 +179,7 @@ xen_swiotlb_free_coherent(struct device *dev, size_t size, void *vaddr,
 	int order = get_order(size);
 
 	/* Convert the size to actually allocated. */
-	size = 1UL << (order + XEN_PAGE_SHIFT);
+	size = ALIGN(size, XEN_PAGE_SIZE);
 
 	if (WARN_ON_ONCE(dma_handle + size - 1 > dev->coherent_dma_mask) ||
 	    WARN_ON_ONCE(range_straddles_page_boundary(phys, size)))
-- 
2.43.0

