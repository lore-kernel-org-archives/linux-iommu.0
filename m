Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794787807;
	b=JVtuz+J48ccWqqssw2XNLrNtOa+DMBY6vJCx1ONrZp7LkOp6RwHgAQf3EGwbjqf+s4fr
	 Ukz82IN5ePIbKexAOKCXcEbIUBt91QaN4NSam0UDlPM54g4fVGTUmQghuSOijKFmZ7hQb
	 lXj9WIJ5WG2vbCYOkgDZWOVcf8cabzPQuggCfB043mBX6dDwzIv0RLxtmwqsmpHsOjKHM
	 jio6a8CleSikAZ6/r4p3D2+Bg1HrGzwluGOhHlunSjrCxHbEuNS91lrRBqewHSnpkzwxX
	 sCuqzNZghhWW75HPgQtpJHcL1C7BLcTIj4X91dzOh7tfmuBIyStHtseVd/0zP6tZyUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794787807;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spamd-Result:X-Spam-Score;
	bh=M0cqlp1i06c+tntu+li2oID/iQtjHHGL32EXXheEnU0=;
	b=ex3mRP3Vu/hQYcXqdl7UCr6Ju2AohCbBdO4TpzSCbch/JOjaCkFrFM//wtvpG3d4mLtH
	 H4J1K4Ee5MN47naz+gQ6ICJ7liFoQe8wAzeupAMIJuyfCjo/6w4qDzqEBiR0duHCqvi4x
	 AGMQ3y/+a+vBGUatiSxXkX5kYk4ad/OJ2yYTJvL07VDTCPFgz7ER/8ic3lH2N7cU1wigS
	 dYONYEHdkdj8f1idvUCyh3Nm0mzAIUAwzVYtC4lj9Oo41VyArSP57DyFmMOxoZzyh4kkA
	 H833Bh9fqJuTdoUhxCTbxe9eUEL2+xQBNVfXmlV57Gc7Ykh+8L5+jWFxW4pQg7uvZ3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=BPSHEmHc;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=BPSHEmHc;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C49606A32C
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 00:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41C49606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=BPSHEmHc;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=BPSHEmHc
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0B7621DC1;
	Mon, 16 Nov 2026 00:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794787797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0cqlp1i06c+tntu+li2oID/iQtjHHGL32EXXheEnU0=;
	b=BPSHEmHcOkGQsCVEP0emGmJNQ2shVpO3ZqmsmFLbn9ThnpDbRf5GUce6DiKI3P+KcHA+P4
	44glA6C3HR6vhWFYIijY+Q2eOj5cOAYWaoa5deyNbxme1KALuiNGydS0a5R60br7bMinxL
	U4Q9DZ+PmeDIuZgsF8JI+nylh0wRawU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=BPSHEmHc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794787797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0cqlp1i06c+tntu+li2oID/iQtjHHGL32EXXheEnU0=;
	b=BPSHEmHcOkGQsCVEP0emGmJNQ2shVpO3ZqmsmFLbn9ThnpDbRf5GUce6DiKI3P+KcHA+P4
	44glA6C3HR6vhWFYIijY+Q2eOj5cOAYWaoa5deyNbxme1KALuiNGydS0a5R60br7bMinxL
	U4Q9DZ+PmeDIuZgsF8JI+nylh0wRawU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3ECE11334C;
	Mon, 16 Nov 2026 00:09:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e4RMBNVJ+mrecgAAD6G6ig
	(envelope-from <ailiop@suse.com>); Mon, 16 Nov 2026 00:09:57 +0000
Date: Mon, 16 Nov 2026 01:09:56 +0100
From: Anthony Iliopoulos <ailiop@suse.com>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-debug: Avoid uninitialized hash traversal in mapping
 dumps
Message-ID: <E9412813-7A76-46D0-94E5-0537E9FF5DB8@suse.com>
References: <20261115082505.2012573-2-thnkslprpt@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115082505.2012573-2-thnkslprpt@gmail.com>
X-Rspamd-Queue-Id: C0B7621DC1
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: -13.51

On Sun, Nov 15, 2026 at 10:25:06AM +0200, Avi Weiss wrote:
> Booting with dma_debug=off causes dma_debug_init() to return before
> initializing the hash buckets. The debugfs dump file is registered
> independently, so reading it traverses an uninitialized list and
> triggers a NULL pointer dereference in dump_show(). The
> debug_dma_dump_mappings() helper has the same unchecked traversal.

So the debug_dma_dump_mappings() issue seems preexisting (the risk was
there since its introduction in commit ac26c18bd35d, given that it
doesn't check if dma_debug has been initialized), and it is not related
to decoupling the debugfs init.

> Skip both dump paths until dma_debug_initialized is set. Check the
> initialization state rather than global_disable so that mappings
> recorded before DMA debugging disables itself at runtime remain
> available.

I suppose this makes sense for debug_dma_dump_mappings, but I am not
sure we need this for dump_show. See my next comment.

> With CONFIG_DMA_API_DEBUG=y and CONFIG_DEBUG_FS=y, reading the dump
> with dma_debug=off triggers an oops in the unpatched kernel. The
> patched kernel returns an empty dump, while dumping with DMA debugging
> enabled still returns mapping information.
> 
> Fixes: 173735c346c4 ("dma-debug: fix debugfs initialization order")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> ---
>  kernel/dma/debug.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 36c1f7cbb2ae..2f487246d8ce 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -543,6 +543,9 @@ void debug_dma_dump_mappings(struct device *dev)
>  	int idx;
>  	phys_addr_t cln;
>  
> +	if (!dma_debug_initialized)
> +		return;
> +
>  	for (idx = 0; idx < HASH_SIZE; idx++) {
>  		struct hash_bucket *bucket = &dma_entry_hash[idx];
>  		struct dma_debug_entry *entry;
> @@ -576,6 +579,9 @@ static int dump_show(struct seq_file *seq, void *v)
>  	int idx;
>  	phys_addr_t cln;
>  
> +	if (!dma_debug_initialized)
> +		return 0;
> +

I think it makes better sense to skip creating debugfs files altogether
when debugging is disabled, which was also the case before 15b28bbcd567.

>  	for (idx = 0; idx < HASH_SIZE; idx++) {
>  		struct hash_bucket *bucket = &dma_entry_hash[idx];
>  		struct dma_debug_entry *entry;
> 
> base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
> -- 
> 2.43.0
> 

Regards,
Anthony
