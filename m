Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12A279F5
	for <iommu@lists.linux.dev>; Fri,  1 Dec 2023 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yVkOS/DH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bk2dZbMW"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DA5151FD66;
	Fri,  1 Dec 2023 09:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701422249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KI6n0l2M6RINtXQBgd987hu016XL0f967I+M87+XwxM=;
	b=yVkOS/DH0LpcxAQvYe/ypP009MgElX0atOAM3RjI44rYq3eiQg5hpsYgjOILlU5SXafXK9
	Rzex6ysI/U3FQBLvdc+y1RgRLrHhtvHITLdyzsij3GI85G2uiptrK16ZBzFVXL4bc48Le3
	Vgz8uSVe806r+6sj5cWWvdirt7yHQzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701422249;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KI6n0l2M6RINtXQBgd987hu016XL0f967I+M87+XwxM=;
	b=bk2dZbMWMMJUBIevgy9Ugb57hqQ6mMhR/4JWpVP6CQJP2elRTH7mLHCVttxOms6Iq27Vhp
	OJcfW8XAgajzR7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 736C41369E;
	Fri,  1 Dec 2023 09:17:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7L4KGamkaWXkTAAAD6G6ig
	(envelope-from <jroedel@suse.de>); Fri, 01 Dec 2023 09:17:29 +0000
Date: Fri, 1 Dec 2023 10:17:27 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Thierry Reding <treding@nvidia.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Rob Herring <robh@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: Fix printk arg in of_iommu_get_resv_regions()
Message-ID: <ZWmkp84a1lhdSfKD@suse.de>
References: <20231108062226.928985-1-danielmentz@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231108062226.928985-1-danielmentz@google.com>
X-Spam-Flag: NO
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [0.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 BAYES_HAM(-0.00)[30.48%];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[lists.linux.dev,nvidia.com,gmail.com,kernel.org,arm.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 0.20

On Tue, Nov 07, 2023 at 10:22:26PM -0800, Daniel Mentz wrote:
>  drivers/iommu/of_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

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

