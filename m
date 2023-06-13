Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4250B2915
	for <iommu@lists.linux.dev>; Tue, 13 Jun 2023 09:46:34 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 471731F38A;
	Tue, 13 Jun 2023 09:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1686649592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nOjdZHy7SkZ5nNR/rFz4YNlsYGMEyS2W9tpviTJyj3o=;
	b=DlSwloEpACBSDI+q0fl2oK/zZmthjDQChc8LU6CNu52QPGkMZjv59Q3lo/kA3qewoyLmhj
	tgfSydA6q7STuEiKjnHhG2vk1Dj5HCFukioHwEspQffucZR5SpCGRUAw2btHztGjz3oVu6
	Px9lsB1SPecKsrubMnqpIVet8ZbBImE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1686649592;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nOjdZHy7SkZ5nNR/rFz4YNlsYGMEyS2W9tpviTJyj3o=;
	b=9ImWj0dl6xm/UL0I1+WAa/E/PotfKxEtqSQ1oCHh8BQa2oVQCBSCvKkcOECXM5aFpEK8lt
	CRdAJAWs4xmxNtCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF84C13345;
	Tue, 13 Jun 2023 09:46:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id sdbfOfc6iGTDXQAAMHmgww
	(envelope-from <vbabka@suse.cz>); Tue, 13 Jun 2023 09:46:31 +0000
Message-ID: <5faed13c-43f2-66ef-c42c-7d7bebb224d8@suse.cz>
Date: Tue, 13 Jun 2023 11:46:31 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v7 01/17] mm/slab: Decouple ARCH_KMALLOC_MINALIGN from
 ARCH_DMA_MINALIGN
To: Catalin Marinas <catalin.marinas@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Ard Biesheuvel <ardb@kernel.org>,
 Isaac Manjarres <isaacmanjarres@google.com>,
 Saravana Kannan <saravanak@google.com>, Alasdair Kergon <agk@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>,
 Mark Brown <broonie@kernel.org>, Mike Snitzer <snitzer@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>, linux-mm@kvack.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20230612153201.554742-1-catalin.marinas@arm.com>
 <20230612153201.554742-2-catalin.marinas@arm.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230612153201.554742-2-catalin.marinas@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/23 17:31, Catalin Marinas wrote:
> In preparation for supporting a kmalloc() minimum alignment smaller than
> the arch DMA alignment, decouple the two definitions. This requires that
> either the kmalloc() caches are aligned to a (run-time) cache-line size
> or the DMA API bounces unaligned kmalloc() allocations. Subsequent
> patches will implement both options.
> 
> After this patch, ARCH_DMA_MINALIGN is expected to be used in static
> alignment annotations and defined by an architecture to be the maximum
> alignment for all supported configurations/SoCs in a single Image.
> Architectures opting in to a smaller ARCH_KMALLOC_MINALIGN will need to
> define its value in the arch headers.
> 
> Since ARCH_DMA_MINALIGN is now always defined, adjust the #ifdef in
> dma_get_cache_alignment() so that there is no change for architectures
> not requiring a minimum DMA alignment.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Tested-by: Isaac J. Manjarres <isaacmanjarres@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

