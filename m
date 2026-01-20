Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B163D649D
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903421; cv=none; b=so2sUZ0kAb6OMrsddm0FXrWUEbPOzmkWtRLccMfGAq1qPNru/26ccMRxBOTgG/YkB03rQPkQ1pOyqRYWK0DSL7K9OTd1PNwkZdq0Be6mZZqvQtAlCtVlNA16A87Sd8DOvWf5yc5Mv/o6IG6dGTTXh73c4qx+WhxgGKPbhLeVuDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903421; c=relaxed/simple;
	bh=NVMF81HzzeWrT5ZOgWXgBYw+x9EzHEgPQEtBjKTGnLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=msBNfUj400sJhf7TvQ2SbfUzga4JUpaNBuZOR6a4Luy6qAzG/dnCCPYF56KkPQxzfQjYsKtSvDKTAqcYZ5Lgf4X009bJjFfzSDsjwp9y7G0NqDIK4mf7TekvdT9YQRmg3At/GMvYsrjJRmIeldqEVfG6tr55Dq2aprPEYjGoRRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hEXkOYV1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HHkROImJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hEXkOYV1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HHkROImJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hEXkOYV1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HHkROImJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hEXkOYV1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HHkROImJ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2E469337BD;
	Tue, 20 Jan 2026 10:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768903418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BDBllLctKFZetjaXyv/BTTP6OFh+6MGYMY0eaCmyg1Q=;
	b=hEXkOYV1RtmnkB8cNsN2HOGchSWMW/ICuvEEiEF4xa2fCKvA1UbHCoh/by8OGadXME9SWT
	EoRgOObDcpzlrxT21RMtktLh05pC5Wy2+3VtVicoyX5nMEOsRqFzPotZlNay/QWC8UNzVr
	nfJ+j9CC0nTvXWakfLhQDR/lT8L+0Lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768903418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BDBllLctKFZetjaXyv/BTTP6OFh+6MGYMY0eaCmyg1Q=;
	b=HHkROImJX6wDCZIqwN2so6Y8A0VswA56qN4eiKCApzB8n3UAjCxsoQTDJG8+JdvTuBSa2M
	MboyfSGX7qFz6hDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hEXkOYV1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HHkROImJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768903418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BDBllLctKFZetjaXyv/BTTP6OFh+6MGYMY0eaCmyg1Q=;
	b=hEXkOYV1RtmnkB8cNsN2HOGchSWMW/ICuvEEiEF4xa2fCKvA1UbHCoh/by8OGadXME9SWT
	EoRgOObDcpzlrxT21RMtktLh05pC5Wy2+3VtVicoyX5nMEOsRqFzPotZlNay/QWC8UNzVr
	nfJ+j9CC0nTvXWakfLhQDR/lT8L+0Lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768903418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BDBllLctKFZetjaXyv/BTTP6OFh+6MGYMY0eaCmyg1Q=;
	b=HHkROImJX6wDCZIqwN2so6Y8A0VswA56qN4eiKCApzB8n3UAjCxsoQTDJG8+JdvTuBSa2M
	MboyfSGX7qFz6hDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07CF23EA63;
	Tue, 20 Jan 2026 10:03:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O6GYAfpSb2lgUgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 20 Jan 2026 10:03:38 +0000
Message-ID: <d8d83bfc-7f23-4ab1-a589-db33d2d3824e@suse.cz>
Date: Tue, 20 Jan 2026 11:03:37 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/page_ext: Add page_ext_get_from_phys()
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 akpm@linux-foundation.org, surenb@google.com, mhocko@suse.com,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 xiaqinxin@huawei.com, baolu.lu@linux.intel.com, rdunlap@infradead.org
References: <20260120091926.670155-1-smostafa@google.com>
 <20260120091926.670155-2-smostafa@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20260120091926.670155-2-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 2E469337BD
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On 1/20/26 10:19, Mostafa Saleh wrote:
> The IOMMU code operates on physical addresses which can be outside
> of system RAM.
> 
> Add a new function page_ext_get_from_phys() to abstract the logic of
> checking the address and returning the page_ext.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/page_ext.h |  6 ++++++
>  mm/page_ext.c            | 23 +++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
> index 76c817162d2f..61e876e255e8 100644
> --- a/include/linux/page_ext.h
> +++ b/include/linux/page_ext.h
> @@ -93,6 +93,7 @@ static inline bool page_ext_iter_next_fast_possible(unsigned long next_pfn)
>  #endif
>  
>  extern struct page_ext *page_ext_get(const struct page *page);
> +extern struct page_ext *page_ext_from_phys(phys_addr_t phys);
>  extern void page_ext_put(struct page_ext *page_ext);
>  extern struct page_ext *page_ext_lookup(unsigned long pfn);
>  
> @@ -215,6 +216,11 @@ static inline struct page_ext *page_ext_get(const struct page *page)
>  	return NULL;
>  }
>  
> +static inline struct page_ext *page_ext_from_phys(phys_addr_t phys)
> +{
> +	return NULL;
> +}
> +
>  static inline void page_ext_put(struct page_ext *page_ext)
>  {
>  }
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 297e4cd8ce90..e2e92bd27ebd 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -538,6 +538,29 @@ struct page_ext *page_ext_get(const struct page *page)
>  	return page_ext;
>  }
>  
> +/**
> + * page_ext_from_phys() - Get the page_ext structure for a physical address.
> + * @phys: The physical address to query.
> + *
> + * This function safely gets the `struct page_ext` associated with a given
> + * physical address. It performs validation to ensure the address corresponds
> + * to a valid, online struct page before attempting to access it.
> + * It returns NULL for MMIO, ZONE_DEVICE, holes and offline memory.
> + *
> + * Return: NULL if no page_ext exists for this physical address.
> + * Context: Any context.  Caller may not sleep until they have called
> + * page_ext_put().
> + */
> +struct page_ext *page_ext_from_phys(phys_addr_t phys)
> +{
> +	struct page *page = pfn_to_online_page(__phys_to_pfn(phys));
> +
> +	if (!page)
> +		return NULL;
> +
> +	return page_ext_get(page);
> +}
> +
>  /**
>   * page_ext_put() - Working with page extended information is done.
>   * @page_ext: Page extended information received from page_ext_get().

