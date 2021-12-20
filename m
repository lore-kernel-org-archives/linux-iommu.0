Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7CDC433EF
	for <iommu@archiver.kernel.org>; Mon, 20 Dec 2021 00:48:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B80D660BBA;
	Mon, 20 Dec 2021 00:48:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bLKxfMrh6yZ7; Mon, 20 Dec 2021 00:48:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9970B60B9B;
	Mon, 20 Dec 2021 00:48:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E1AEC001E;
	Mon, 20 Dec 2021 00:48:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0C03C0012
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 00:47:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A96560BB9
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 00:47:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b8v_qZdH_ehr for <iommu@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 00:47:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C2A3060B9B
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 00:47:58 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0BED61F395;
 Mon, 20 Dec 2021 00:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639961275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GljbjGESLyxg+ngLc7mhGY1oQBxex2sK+C5XSkEFVyI=;
 b=bXsxoOzcRRIip4e3u7ZMJHBHCqpqGoHvghX+Qod90rITqgkPX6WlwwmBkBzLIQgnPM3M7l
 siGEY6tKIftLy8gm6P7tCtEhJhPH5+N420SWQ7CGJk78g/87i2iR5inofquN9kpBkcJNuF
 Zi+LVig8LSExmO4XED1Ps1yp2oNnfR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639961275;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GljbjGESLyxg+ngLc7mhGY1oQBxex2sK+C5XSkEFVyI=;
 b=d+lrN53wSmcr6AJTW2rR1oZX3qGUcCXsDSsgdtTCVT7nNW2HNB8UytrIeq4FK+FkuQdmV5
 dAxQM4ms+6JZ/yCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66B78133A7;
 Mon, 20 Dec 2021 00:47:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yFyaF7rSv2HcbQAAMHmgww
 (envelope-from <vbabka@suse.cz>); Mon, 20 Dec 2021 00:47:54 +0000
Message-ID: <86617be0-8aa8-67d2-08bd-1e06c3d12785@suse.cz>
Date: Mon, 20 Dec 2021 01:47:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
Content-Language: en-US
To: Roman Gushchin <guro@fb.com>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
 <Ybk+0LKrsAJatILE@carbon.dhcp.thefacebook.com>
 <Ybp8a5JNndgCLy2w@carbon.dhcp.thefacebook.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Ybp8a5JNndgCLy2w@carbon.dhcp.thefacebook.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@kernel.org>,
 linux-mm@kvack.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com,
 "H. Peter Anvin" <hpa@zytor.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Christoph Lameter <cl@linux.com>, Will Deacon <will@kernel.org>,
 Julia Lawall <julia.lawall@inria.fr>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, x86@kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Vladimir Davydov <vdavydov.dev@gmail.com>,
 David Rientjes <rientjes@google.com>, Nitin Gupta <ngupta@vflare.org>,
 Marco Elver <elver@google.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, cgroups@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 patches@lists.linux.dev, Pekka Enberg <penberg@kernel.org>,
 Minchan Kim <minchan@kernel.org>, iommu@lists.linux-foundation.org,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 12/16/21 00:38, Roman Gushchin wrote:
> Part 2:
> 
> * mm: Convert check_heap_object() to use struct slab
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> * mm/slub: Convert detached_freelist to use a struct slab
> How about to convert free_nonslab_page() to free_nonslab_folio()?
> And maybe rename it to something like free_large_kmalloc()?
> If I'm not missing something, large kmallocs is the only way how we can end up
> there with a !slab folio/page.

Good point, thanks! But did at as part of the following patch, where it fits
logically better.

> * mm/slub: Convert kfree() to use a struct slab
> Reviewed-by: Roman Gushchin <guro@fb.com>

Didn't add your tag because of the addition of free_large_kmalloc() change.

> * mm/slub: Convert __slab_lock() and __slab_unlock() to struct slab
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> * mm/slub: Convert print_page_info() to print_slab_info()
> Do we really need to explicitly convert slab_folio()'s result to (struct folio *)?

Unfortunately yes, as long as folio_flags() don't take const struct folio *,
which will need some yak shaving.

> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> * mm/slub: Convert alloc_slab_page() to return a struct slab
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> * mm/slub: Convert __free_slab() to use struct slab
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> * mm/slub: Convert pfmemalloc_match() to take a struct slab
> Cool! Removing pfmemalloc_unsafe() is really nice.
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> * mm/slub: Convert most struct page to struct slab by spatch
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> * mm/slub: Finish struct page to struct slab conversion
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> * mm/slab: Convert kmem_getpages() and kmem_freepages() to struct slab
> Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks again!

> * mm/slab: Convert most struct page to struct slab by spatch
> 
> Another patch with the same title? Rebase error?
> 
> * mm/slab: Finish struct page to struct slab conversion
> 
> And this one too?
> 
> 
> Thanks!
> 
> Roman

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
