Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E449A1FCF74
	for <iommu@lists.linux.dev>; Tue, 11 Feb 2025 12:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739276945; cv=none; b=eBCVvRdg6xrlf8XAc/JBVN+CIaTOyPNnldwzB0V6C4AHolpSPjQbJG/C7ZKwxaOHHhMEkUF9mTGWJ+MwYJB/TylZCwJZxhEOcrUqWi5L3XoDnoo3n8Se6bnSfM2d+p5rTf3lS0ral2shp0AdFUSkY0B++UuMLtWNiSDyUDhVpiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739276945; c=relaxed/simple;
	bh=RcqBaJ+EL7CCfV/bFegfRimyJtpwi2rMY3RrvnBDwkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AFGK3hZTXMHH49cBe0DnsUbEZYM/NEvny/gjYK6hnYATrBxvuTeEgxmzjrgaiorwkaMQ6IKwLiN0MV+/YExl99JYddCkzwGP00CvHCjuX5m5jgXr3wTj0PHi4v47hfIonF6DwMbMMBDmZ/TaLG77X/ufZjdSOEd6AOLGSZ/JvAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mG5KJkJE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mG5KJkJE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mG5KJkJE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mG5KJkJE"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E68A937B3E;
	Tue, 11 Feb 2025 12:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739275475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zxuVAvyzkp6zq60Y3IIgw3a0N6EBZB0/ewpeFUtjxfE=;
	b=mG5KJkJEA9cENgXVVW1/b1jxBw55qBBByi9PqzfHzpewCvY3NEQwN486QwswigWR3z3MaO
	5RV9+Cpgb3JBOuZf7DOhtGxjiRbMQmmRdcShemoF4qnQwJsM6EDshp0HbF+ORTW7Gu3afx
	DdhHDp5aJLMzmzDwtMCbwbIAsgo2hUY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=mG5KJkJE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739275475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zxuVAvyzkp6zq60Y3IIgw3a0N6EBZB0/ewpeFUtjxfE=;
	b=mG5KJkJEA9cENgXVVW1/b1jxBw55qBBByi9PqzfHzpewCvY3NEQwN486QwswigWR3z3MaO
	5RV9+Cpgb3JBOuZf7DOhtGxjiRbMQmmRdcShemoF4qnQwJsM6EDshp0HbF+ORTW7Gu3afx
	DdhHDp5aJLMzmzDwtMCbwbIAsgo2hUY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7ECAB13782;
	Tue, 11 Feb 2025 12:04:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id njSKHdM8q2egGgAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 11 Feb 2025 12:04:35 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 0/2] xen/swiotlb: one fix and one optimization
Date: Tue, 11 Feb 2025 13:04:30 +0100
Message-ID: <20250211120432.29493-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E68A937B3E
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Patch 1 removes an unneeded alignment requirement, which resulted in
exhausting the SWIOTLB with normal use cases.

Patch 2 is an optimization to avoid destroying a contiguous region
without any need to do so.

There will be probably another patch following to allow larger
contiguous regions to be created, but this one isn't ready yet.

Juergen Gross (2):
  xen/swiotlb: relax alignment requirements
  xen/swiotlb: don't destroy contiguous region in all cases

 arch/x86/include/asm/xen/swiotlb-xen.h |  5 +++--
 arch/x86/xen/mmu_pv.c                  | 18 ++++++++++-----
 drivers/xen/swiotlb-xen.c              | 31 ++++++++++++++++----------
 3 files changed, 34 insertions(+), 20 deletions(-)

-- 
2.43.0

