Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412FCC433F5
	for <iommu@archiver.kernel.org>; Mon,  3 Jan 2022 17:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C6C5E40146;
	Mon,  3 Jan 2022 17:56:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CtqHa8owPAeL; Mon,  3 Jan 2022 17:56:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 46E65400C1;
	Mon,  3 Jan 2022 17:56:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F09DC0030;
	Mon,  3 Jan 2022 17:56:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26149C001E
 for <iommu@lists.linux-foundation.org>; Mon,  3 Jan 2022 17:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 051E8812E4
 for <iommu@lists.linux-foundation.org>; Mon,  3 Jan 2022 17:56:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.cz header.b="RhtzrMx8";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.cz header.b="t8qwh7PK"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7qL1s7twhWUZ for <iommu@lists.linux-foundation.org>;
 Mon,  3 Jan 2022 17:56:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A52080D8C
 for <iommu@lists.linux-foundation.org>; Mon,  3 Jan 2022 17:56:25 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CFB7D21108;
 Mon,  3 Jan 2022 17:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641232582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWXmfQBKbsotJ+DKTiOu/dBjpnMA9AO60pYklnpK268=;
 b=RhtzrMx8l25Gp/dHfXaSGxIrVaiGPT1oHmkDlXhSWyOvA3XmL4u7MKmkETxcTTsnSdyvu2
 2jQ+42aJxQsIJcy8XiqzBTF5lvvMOIEw62rvN/I2Cv3SEGwEYtC0RgDlqOLKfcdrrpJrAI
 TwUGB6+/291CiiyPqlt5NX4O2jOPKt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641232582;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWXmfQBKbsotJ+DKTiOu/dBjpnMA9AO60pYklnpK268=;
 b=t8qwh7PKelubXDsAPcP//m32DqwLxiSz3osyPqIC0+7efv+uVAzzP9TnLLkkHY3hH0TlrX
 HpPoN6SxQtgI3lBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40BC413B0C;
 Mon,  3 Jan 2022 17:56:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Wx1+DsY402GiJQAAMHmgww
 (envelope-from <vbabka@suse.cz>); Mon, 03 Jan 2022 17:56:22 +0000
Message-ID: <d3f0e9ef-7d21-8de6-5b15-116f39c2aca3@suse.cz>
Date: Mon, 3 Jan 2022 18:56:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
 <f3a83708-3f3c-a634-7bee-dcfcaaa7f36e@suse.cz>
 <YcxFDuPXlTwrPSPk@ip-172-31-30-232.ap-northeast-1.compute.internal>
From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
In-Reply-To: <YcxFDuPXlTwrPSPk@ip-172-31-30-232.ap-northeast-1.compute.internal>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@kernel.org>,
 linux-mm@kvack.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com,
 "H. Peter Anvin" <hpa@zytor.com>, Christoph Lameter <cl@linux.com>,
 Will Deacon <will@kernel.org>, Julia Lawall <julia.lawall@inria.fr>,
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
 David Woodhouse <dwmw2@infradead.org>, Roman Gushchin <guro@fb.com>
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

On 12/29/21 12:22, Hyeonggon Yoo wrote:
> On Wed, Dec 22, 2021 at 05:56:50PM +0100, Vlastimil Babka wrote:
>> On 12/14/21 13:57, Vlastimil Babka wrote:
>> > On 12/1/21 19:14, Vlastimil Babka wrote:
>> >> Folks from non-slab subsystems are Cc'd only to patches affecting them, and
>> >> this cover letter.
>> >>
>> >> Series also available in git, based on 5.16-rc3:
>> >> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-struct_slab-v2r2
>> > 
>> > Pushed a new branch slab-struct-slab-v3r3 with accumulated fixes and small tweaks
>> > and a new patch from Hyeonggon Yoo on top. To avoid too much spam, here's a range diff:
>> 
>> Hi, I've pushed another update branch slab-struct_slab-v4r1, and also to
>> -next. I've shortened git commit log lines to make checkpatch happier,
>> so no range-diff as it would be too long. I believe it would be useless
>> spam to post the whole series now, shortly before xmas, so I will do it
>> at rc8 time, to hopefully collect remaining reviews. But if anyone wants
>> a mailed version, I can do that.
>>
> 
> Hello Matthew and Vlastimil.
> it's part 3 of review.
> 
> # mm: Convert struct page to struct slab in functions used by other subsystems
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> 
> # mm/slub: Convert most struct page to struct slab by spatch
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> with a question below.
> 
> -static int check_slab(struct kmem_cache *s, struct page *page)
> +static int check_slab(struct kmem_cache *s, struct slab *slab)
>  {
>         int maxobj;
>  
> -       if (!PageSlab(page)) {
> -               slab_err(s, page, "Not a valid slab page");
> +       if (!folio_test_slab(slab_folio(slab))) {
> +               slab_err(s, slab, "Not a valid slab page");
>                 return 0;
>         }
> 
> Can't we guarantee that struct slab * always points to a slab?

Normally, yes.

> for struct page * it can be !PageSlab(page) because struct page *
> can be other than slab. but struct slab * can only be slab
> unlike struct page. code will be simpler if we guarantee that
> struct slab * always points to a slab (or NULL).

That's what the code does indeed. But check_slab() is called as part of
various consistency checks, so there we on purpose question all assumptions
in order to find a bug (e.g. memory corruption) - such as a page that's
still on the list of slabs while it was already freed and reused and thus
e.g. lacks the slab page flag.

But it's nice how using struct slab makes such a check immediately stand out
as suspicious, right?

> # mm/slub: Convert pfmemalloc_match() to take a struct slab
> It's confusing to me because the original pfmemalloc_match() is removed
> and pfmemalloc_match_unsafe() was renamed to pfmemalloc_match() and
> converted to use slab_test_pfmemalloc() helper.
> 
> But I agree with the resulting code. so:
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> 
> # mm/slub: Convert alloc_slab_page() to return a struct slab
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> 
> # mm/slub: Convert print_page_info() to print_slab_info()
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> I hope to review rest of patches in a week.

Thanks for your reviews/tests!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
