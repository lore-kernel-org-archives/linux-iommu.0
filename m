Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BBA13210D
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 06:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726469277; cv=none; b=tzVE16ptY/nyoKbEAV6C+VI7baFNE/5JBzUDkV6xnb/o2ByFI839/DP7LWIag2tKW5dxeXMkIog1O+ImtYyzIlSukXbzLMjDTEfq6WhHEVELas4KsbZl8USZoh+KWQbUMYqFqqvYJP7T2ErQQpLVwrNACDWWooaZfuEppmS84Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726469277; c=relaxed/simple;
	bh=gN9GLop4WYjXfwHQg5BiASXjjFAGynTxNa8D4JejoL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tp8zF0GyO1bX0QyzxNhzz+gl8SNRmbtcR9bgVkArVquFq/PtGolgZuvDsmYQMDJem/nxja4uw7jPWxmhWhBEool6bAFXS00YojeRIhp4cAn0W45EjSBP3UlD/M8AEgDEmf7LSXRCM1PQodsnQmCRteXOqefivnDzjgZsAiqODZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nm/7Sdsm; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nm/7Sdsm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nm/7Sdsm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nm/7Sdsm"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 25E6D1F86B;
	Mon, 16 Sep 2024 06:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726469271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jDdjkbnsAiMFhfKjybazY963Vvy5Vm1vHgzynokF26w=;
	b=nm/7SdsmLB716zqUjTRDXTuZ6Y+A2VHtxwQP70gWcmcCondbkBMHOQ2T+pXsYcjbHIQS6r
	qF+Wi+NSFdatZV/TsWdhlwTZb/6MaeHSV1xoZD5EdPQjHu6Z4fV/QEYAe1HxqCCZkJfmKY
	mmtRjtTfSr3rzXmfeEgUAenBhx0rQNo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726469271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jDdjkbnsAiMFhfKjybazY963Vvy5Vm1vHgzynokF26w=;
	b=nm/7SdsmLB716zqUjTRDXTuZ6Y+A2VHtxwQP70gWcmcCondbkBMHOQ2T+pXsYcjbHIQS6r
	qF+Wi+NSFdatZV/TsWdhlwTZb/6MaeHSV1xoZD5EdPQjHu6Z4fV/QEYAe1HxqCCZkJfmKY
	mmtRjtTfSr3rzXmfeEgUAenBhx0rQNo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D85E6139CE;
	Mon, 16 Sep 2024 06:47:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6jRUM5bU52Z/IAAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 16 Sep 2024 06:47:50 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v2 0/2] xen/swiotlb: fix 2 issues in xen-swiotlb
Date: Mon, 16 Sep 2024 08:47:46 +0200
Message-ID: <20240916064748.18071-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Fix 2 issues in xen-swiotlb:

- buffers need to be aligned properly
- wrong buffer size if XEN_PAGE_SIZE < PAGE_SIZE

Changes in V2:
- added patch 2

Juergen Gross (2):
  xen/swiotlb: add alignment check for dma buffers
  xen/swiotlb: fix allocated size

 drivers/xen/swiotlb-xen.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.43.0

