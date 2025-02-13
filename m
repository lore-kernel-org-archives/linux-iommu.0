Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B51820A5DC
	for <iommu@lists.linux.dev>; Thu, 13 Feb 2025 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739436945; cv=none; b=Yx+jHG6JPdQlw/Uzv7vsdzD4eIJRJ8p5fapcCCxS92xVslWzPUNMljhJTf92fT+Tpd8U1P3/RNpRMUfKtTrzuEye7x9TSB7aQ20dzrKG48pDNXYDbUROT7IRU/xOS/q9A6fN9+vxAf3fo/LLAYc572FvDTiL2fJ/lCryDpgT2ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739436945; c=relaxed/simple;
	bh=l0geTxDlQteuQqauKvsshWGcclhOIB4qO6Um2LY9Biw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJ2dez4E1iJPNTQY9uEP/TsDA2KBM1Foxa8IWVJDaqouPxLgf5nHA6c+Bh1L7C6aXymeoG99A3TWZZinmO9pSnmELSl6hv/LFW1cZv0UKRyxbwfOOPVliaEl9aLRjVyHnKYJQ41c7gXLRrLxs79O05xqdpn3pe/9O9dTL7lS0g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ajQAG182; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ajQAG182; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ajQAG182";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ajQAG182"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B4A52295F;
	Thu, 13 Feb 2025 08:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739436941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dvp+2zva3b1OzC9c49Z/oXKVc7Zk8EYxQY79anNSCaA=;
	b=ajQAG1827NLagTbTwYjbfqQpSVsCL9eywPM/N7ZN63lNQYOI5o/irGXlYPnLcGmryG1TwU
	Bt2mljd+T16zbOo+h8qZA30lhYwzIjATaCPxa4HAPErBPIKbco6haDbLyPcmWJDhQAWtX7
	UadBSlkpVPO2nglFEQoSN1iI2SoVrfQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ajQAG182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739436941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dvp+2zva3b1OzC9c49Z/oXKVc7Zk8EYxQY79anNSCaA=;
	b=ajQAG1827NLagTbTwYjbfqQpSVsCL9eywPM/N7ZN63lNQYOI5o/irGXlYPnLcGmryG1TwU
	Bt2mljd+T16zbOo+h8qZA30lhYwzIjATaCPxa4HAPErBPIKbco6haDbLyPcmWJDhQAWtX7
	UadBSlkpVPO2nglFEQoSN1iI2SoVrfQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2402137DB;
	Thu, 13 Feb 2025 08:55:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8W7qLYyzrWcCdgAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 13 Feb 2025 08:55:40 +0000
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
Subject: [PATCH v2 0/2] xen/swiotlb: two fixes
Date: Thu, 13 Feb 2025 09:55:36 +0100
Message-ID: <20250213085538.17060-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3B4A52295F
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Patch 1 removes an unneeded alignment requirement, which resulted in
exhausting the SWIOTLB with normal use cases.

Patch 2 allows to allocate larger continuous regions by reallocating
the frame list if needed.

Changes in V2:
- drop former patch 2 for now in order to avoid more lengthy discussion
- new patch 2

Juergen Gross (2):
  xen/swiotlb: relax alignment requirements
  x86/xen: allow larger contiguous memory regions in PV guests

 arch/x86/xen/mmu_pv.c     | 71 ++++++++++++++++++++++++++++++++++-----
 drivers/xen/swiotlb-xen.c | 20 ++++++-----
 2 files changed, 74 insertions(+), 17 deletions(-)

-- 
2.43.0

