Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7C4C433F5
	for <iommu@archiver.kernel.org>; Mon, 20 Dec 2021 01:43:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FDC160B9B;
	Mon, 20 Dec 2021 01:43:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JYi5a01RIhFw; Mon, 20 Dec 2021 01:43:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 527AD6058C;
	Mon, 20 Dec 2021 01:43:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DB83C002F;
	Mon, 20 Dec 2021 01:43:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEDFCC0012
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 01:42:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C839182CFD
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 01:42:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pUkc5DGx_Bgm for <iommu@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 01:42:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0481182B84
 for <iommu@lists.linux-foundation.org>; Mon, 20 Dec 2021 01:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=k7fHWgKrjS6NSIvn5a4Jtgxmp/WhT9Wz1heA+PvFHEU=; b=fbUn3fvK/C4lIcfXkF1dhfDZp+
 0ZelBeFgnQYcFnt0EOTirvxdbva/ddh2SL+FntgltRD3RE987l95C52xyYhhRfbE2xb17KwOfKlFs
 5hOrS2+3DKFsP3AzTTFXGdtnAfDlAGiCbxuyVX733jeZZ+d0DD58EAaIyKmbheLpfRjDtShOeT6am
 hg7mxrzy3tJ/5EM0XQThsZ+qE0Zv7Dl2ydMZ44Ueicge/g2XjDjlE+5Q0yijLnkgOFaSa51eA1ivu
 3KHkjCK1aKheaU9DVEJ4MCzqGgtQ+Ndgh2oKwtYQK2wpphRgppBrz+kxZNRgm1Zd6KP6yXdmRMLqn
 IlqHXmWA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mz7gr-001BXA-DH; Mon, 20 Dec 2021 01:42:13 +0000
Date: Mon, 20 Dec 2021 01:42:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
Message-ID: <Yb/fdYbLunsVYRqQ@casper.infradead.org>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
 <Ybk+0LKrsAJatILE@carbon.dhcp.thefacebook.com>
 <Ybp8a5JNndgCLy2w@carbon.dhcp.thefacebook.com>
 <86617be0-8aa8-67d2-08bd-1e06c3d12785@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <86617be0-8aa8-67d2-08bd-1e06c3d12785@suse.cz>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@kernel.org>,
 linux-mm@kvack.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Christoph Lameter <cl@linux.com>,
 Will Deacon <will@kernel.org>, Julia Lawall <julia.lawall@inria.fr>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, x86@kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, kasan-dev@googlegroups.com,
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

On Mon, Dec 20, 2021 at 01:47:54AM +0100, Vlastimil Babka wrote:
> > * mm/slub: Convert print_page_info() to print_slab_info()
> > Do we really need to explicitly convert slab_folio()'s result to (struct folio *)?
> 
> Unfortunately yes, as long as folio_flags() don't take const struct folio *,
> which will need some yak shaving.

In case anyone's interested ...

folio_flags calls VM_BUG_ON_PGFLAGS() which would need its second
argument to be const.

That means dump_page() needs to take a const struct page, which
means __dump_page() needs its argument to be const.

That calls ...

is_migrate_cma_page()
page_mapping()
page_mapcount()
page_ref_count()
page_to_pgoff()
page_to_pfn()
hpage_pincount_available()
head_compound_mapcount()
head_compound_pincount()
compound_order()
PageKsm()
PageAnon()
PageCompound()

... and at that point, I ran out of motivation to track down some parts
of this tarbaby that could be fixed.  I did do:

    mm: constify page_count and page_ref_count
    mm: constify get_pfnblock_flags_mask and get_pfnblock_migratetype
    mm: make compound_head const-preserving
    mm/page_owner: constify dump_page_owner

so some of those are already done.  But a lot of them just need to be
done at the same time.  For example, page_mapping() calls
folio_mapping() which calls folio_test_slab() which calls folio_flags(),
so dump_page() and page_mapping() need to be done at the same time.

One bit that could be broken off easily (I think ...) is PageTransTail()
PageTail(), PageCompound(), PageHuge(), page_to_pgoff() and
page_to_index().  One wrinkle is needed a temporary
TESTPAGEFLAGS_FALSE_CONST.  But I haven't tried it yet.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
