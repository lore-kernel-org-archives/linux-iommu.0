Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC82C433EF
	for <iommu@archiver.kernel.org>; Sat, 25 Dec 2021 17:54:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC02D82611;
	Sat, 25 Dec 2021 17:54:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xd6NNQknhD0O; Sat, 25 Dec 2021 17:54:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BDDFD81C67;
	Sat, 25 Dec 2021 17:54:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90618C002F;
	Sat, 25 Dec 2021 17:54:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D4B6C0012
 for <iommu@lists.linux-foundation.org>; Sat, 25 Dec 2021 17:54:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4492A6070A
 for <iommu@lists.linux-foundation.org>; Sat, 25 Dec 2021 17:54:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a4m-LDC0vTgp for <iommu@lists.linux-foundation.org>;
 Sat, 25 Dec 2021 17:54:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B66096068D
 for <iommu@lists.linux-foundation.org>; Sat, 25 Dec 2021 17:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=DsB14TIFCiBAdP7rD7EHBmZ2vEchTQE1iQvq9NRvB9w=; b=P8eHkVObvPl/+oE4RPc6QOntRY
 /de/u2l0W5mC3WRBpFK4be27bPrWJfdkv1FuPLbMrayZv+0guT03DnIrQ/xL3ldKXn+hP73WRranJ
 BzynHSKSXf1ouyx0LrktgopeQyRdndjcLtl7c/XkqALfMs9N7wE6eV9QGeWSvaR3pq7XUuXx2IYyP
 iN7kRcmN7F4B5szTaLh5wURmvRCOqzWou5PnMz2K4MRAAWjoExqrZE1+3Ev5rn5sBWZqpj5Oq7sda
 DGBdHlvxWH9UnXyu0o4m5b7pRDFJ0SNAdOIkV/egmPglIrpj5BKAwgN6thX544+NOaU1tHVYkZSQs
 /2BQ/rBA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1n1BER-005yjd-Ai; Sat, 25 Dec 2021 17:53:23 +0000
Date: Sat, 25 Dec 2021 17:53:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
Message-ID: <Ycdak5J48i7CGkHU@casper.infradead.org>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
 <f3a83708-3f3c-a634-7bee-dcfcaaa7f36e@suse.cz>
 <Ycbhh5n8TBODWHR+@ip-172-31-30-232.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ycbhh5n8TBODWHR+@ip-172-31-30-232.ap-northeast-1.compute.internal>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@kernel.org>,
 linux-mm@kvack.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Christoph Lameter <cl@linux.com>, Will Deacon <will@kernel.org>,
 Julia Lawall <julia.lawall@inria.fr>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, x86@kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, kasan-dev@googlegroups.com,
 Ingo Molnar <mingo@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
 David Rientjes <rientjes@google.com>, Nitin Gupta <ngupta@vflare.org>,
 Vladimir Davydov <vdavydov.dev@gmail.com>, Marco Elver <elver@google.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 cgroups@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Dmitry Vyukov <dvyukov@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, patches@lists.linux.dev,
 Pekka Enberg <penberg@kernel.org>, Minchan Kim <minchan@kernel.org>,
 iommu@lists.linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>,
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

On Sat, Dec 25, 2021 at 09:16:55AM +0000, Hyeonggon Yoo wrote:
> # mm: Convert struct page to struct slab in functions used by other subsystems
> I'm not familiar with kasan, but to ask:
> Does ____kasan_slab_free detect invalid free if someone frees
> an object that is not allocated from slab?
> 
> @@ -341,7 +341,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
> -       if (unlikely(nearest_obj(cache, virt_to_head_page(object), object) !=
> +       if (unlikely(nearest_obj(cache, virt_to_slab(object), object) !=
>             object)) {
>                 kasan_report_invalid_free(tagged_object, ip);
>                 return true;
> 
> I'm asking this because virt_to_slab() will return NULL if folio_test_slab()
> returns false. That will cause NULL pointer dereference in nearest_obj.
> I don't think this change is intended.

You need to track down how this could happen.  As far as I can tell,
it's always called when we know the object is part of a slab.  That's
where the cachep pointer is deduced from.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
