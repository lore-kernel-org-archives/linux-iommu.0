Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEF5125CE
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 11:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vGNBq7rB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XKSEKTZ4"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E6FF01F88E;
	Thu,  5 Oct 2023 11:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1696503687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7NjnAGUAmem/kqOMgVtFmu0AGdXvG/f+8Nh1NHfQyLU=;
	b=vGNBq7rBxWcCqtWjExzPmjqa/TSh3EUe6CGNetLtP3UHmNbie6H07wdNIaKT1Qjf/vmp76
	qrZZqmuoiHZ8Q4GLq9AiS0hpHxioWKoiKKi/RYIydlfBRpGfiEg84aSBzQxGsFbvv2Tijh
	SheD31iTgCNNcpz0v/oyTLXjJ8qEnys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1696503687;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7NjnAGUAmem/kqOMgVtFmu0AGdXvG/f+8Nh1NHfQyLU=;
	b=XKSEKTZ4n40WHUCBZgL1GHMxEUaHRddk9m8e617O5UQdT5VgBNEs/O99/WY0gg1FJsjeI6
	lubq7NMc0dWjDvDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D10413438;
	Thu,  5 Oct 2023 11:01:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id MfhVIYeXHmUFNwAAMHmgww
	(envelope-from <jroedel@suse.de>); Thu, 05 Oct 2023 11:01:27 +0000
Date: Thu, 5 Oct 2023 13:01:26 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH] s390/pci: Fix reset of IOMMU software counters
Message-ID: <ZR6XhkCzYMJRTT06@suse.de>
References: <20231004-dma_iommu_fix-v1-1-129777cd8232@linux.ibm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231004-dma_iommu_fix-v1-1-129777cd8232@linux.ibm.com>

On Wed, Oct 04, 2023 at 10:56:12AM +0200, Niklas Schnelle wrote:
>  arch/s390/include/asm/pci.h |  4 ----
>  arch/s390/pci/pci.c         | 13 ++++++++++---
>  2 files changed, 10 insertions(+), 7 deletions(-)

Applied, thanks.

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Frankenstraße 146
90461 Nürnberg
Germany

(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman

