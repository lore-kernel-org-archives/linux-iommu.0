Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF177C433F5
	for <iommu@archiver.kernel.org>; Mon, 20 Dec 2021 00:25:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5DD7960B9B;
	Mon, 20 Dec 2021 00:25:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0rair3YimM1W; Mon, 20 Dec 2021 00:25:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3A13460B72;
	Mon, 20 Dec 2021 00:25:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06EB6C001E;
	Mon, 20 Dec 2021 00:25:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12175C0012
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 00:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DDA5E416FE
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 00:24:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.cz header.b="EFlINYyd";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.cz header.b="en4PMr7J"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nscyjRLdUjkP for <iommu@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 00:24:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 61D3A416FB
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 00:24:56 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED29B2113A;
 Mon, 20 Dec 2021 00:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639959892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QS/OCdCcmeiC9lIu10Q6seQIOyuScTvbNIZyhMByFhM=;
 b=EFlINYyd/0dwFEmGFLZJLMASlucVauTDQ5SZ12dNfQ6r31naTaptiEwTVbyOfxPXpCB2cT
 ljvPQE3G4g1tnbRcINtU1YQtlSxy1/U6VoQT1ofUjs0fEIc2xRhwT6WL5cD9PbkZJ35Dj6
 NzwUpPjWlTGet3+basc0unwNwWyigwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639959893;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QS/OCdCcmeiC9lIu10Q6seQIOyuScTvbNIZyhMByFhM=;
 b=en4PMr7JQnpVhR/Yj5DceOur/mcdk1eiP1XwqtDuloUzTdwsT7JJTZLi1UAwmw3RS7NXzU
 ZjrRD/TsdRhwADDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E3BB133A7;
 Mon, 20 Dec 2021 00:24:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lRYvGlTNv2HrZwAAMHmgww
 (envelope-from <vbabka@suse.cz>); Mon, 20 Dec 2021 00:24:52 +0000
Message-ID: <b94c2530-0f17-11c4-e3ef-effc6b7f0d33@suse.cz>
Date: Mon, 20 Dec 2021 01:24:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Roman Gushchin <guro@fb.com>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
 <Ybk+0LKrsAJatILE@carbon.dhcp.thefacebook.com>
From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
In-Reply-To: <Ybk+0LKrsAJatILE@carbon.dhcp.thefacebook.com>
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

On 12/15/21 02:03, Roman Gushchin wrote:
> On Tue, Dec 14, 2021 at 01:57:22PM +0100, Vlastimil Babka wrote:
>> On 12/1/21 19:14, Vlastimil Babka wrote:
>> > Folks from non-slab subsystems are Cc'd only to patches affecting them, and
>> > this cover letter.
>> > 
>> > Series also available in git, based on 5.16-rc3:
>> > https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-struct_slab-v2r2
>> 
>> Pushed a new branch slab-struct-slab-v3r3 with accumulated fixes and small tweaks
>> and a new patch from Hyeonggon Yoo on top. To avoid too much spam, here's a range diff:
> 
> Hi Vlastimil!
> 
> I've started to review this patchset (btw, a really nice work, I like
> the resulting code way more). Because I'm looking at v3 and I don't have
> the whole v2 in my mailbox, here is what I've now:

Thanks a lot, Roman!

> * mm: add virt_to_folio() and folio_address()
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> * mm/slab: Dissolve slab_map_pages() in its caller
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> * mm/slub: Make object_err() static
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> * mm: Split slab into its own type
> 1) Shouldn't SLAB_MATCH() macro use struct folio instead of struct page for the
> comparison?

Folio doesn't have define most of the fields, and matching some to page and
others to folio seems like unnecessary complication. Maybe as part of the
final struct page cleanup when the slab fields are gone from struct page,
the rest could all be in folio - I'll check once we get there.

> 2) page_slab() is used only in kasan and only in one place, so maybe it's better
> to not introduce it as a generic helper?

Yeah that's the case after the series, but as part of the incremental steps,
page_slab() gets used in many places. I'll consider removing it on top though.

> Other than that
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> * mm: Add account_slab() and unaccount_slab()
> 1) maybe change the title to convert/replace instead of add?

Done.

> 2) maybe move later changes to memcg_alloc_page_obj_cgroups() to this patch?

Maybe possible, but that would distort the series more than I'd like to at
this rc6 time.

> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> * mm: Convert virt_to_cache() to use struct slab
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> * mm: Convert __ksize() to struct slab
> It looks like certain parts of __ksize() can be merged between slab, slub and slob?
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> * mm: Use struct slab in kmem_obj_info()
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> 
> I'll try to finish reviewing the patchset until the  end of the week.
> 
> Thanks!
> 
> Roman

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
