Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D719C433FE
	for <iommu@archiver.kernel.org>; Mon, 27 Dec 2021 02:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ECA1D60E24;
	Mon, 27 Dec 2021 02:43:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f3pVp2odLS8S; Mon, 27 Dec 2021 02:43:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CC68D606FF;
	Mon, 27 Dec 2021 02:43:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1F84C002F;
	Mon, 27 Dec 2021 02:43:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A90E4C0012
 for <iommu@lists.linux-foundation.org>; Mon, 27 Dec 2021 02:43:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 909D7402DD
 for <iommu@lists.linux-foundation.org>; Mon, 27 Dec 2021 02:43:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IamKxz8fEt-r for <iommu@lists.linux-foundation.org>;
 Mon, 27 Dec 2021 02:43:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0E308402D4
 for <iommu@lists.linux-foundation.org>; Mon, 27 Dec 2021 02:43:25 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id c7so10489136plg.5
 for <iommu@lists.linux-foundation.org>; Sun, 26 Dec 2021 18:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=sbWmY9NIBHJbspqdt0/iFybWiUNO01ZpzPEk+bSzcIc=;
 b=b6Cjg8EDgami9tihXmahcFs5gZMUl0ofSM1Wj+YZ2Q6XRHsDdBRl90zeF1jbOOSz3+
 9SoQiZ4EdbCG+Jmg4MzA5/6shK8RZg8xrV2gqJVuZDyAYqtXwqlmry/aJAkQ4oiG8ngV
 7rpAaYsMSPY9gaW/AMeOV2RIDPlYhOIi7V3RAasnd56UnpIcH6qs4tNiIeLbz9RuGyMQ
 3rfi/aFyW60zG42gzOC8ll2ZU35Xujv3pg6CUtvkdcaI6VRRKTlNpdBWUeCpGeADhAXG
 JPgrgb5sX7zdu4h1uMAdv/6rtljcukOvJ4HPQR8PbQw3YwGslBNSSpCAuWszimU1l/o9
 DGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sbWmY9NIBHJbspqdt0/iFybWiUNO01ZpzPEk+bSzcIc=;
 b=OTwLWH2lANlOLUPhEqHrIzqzdwpXbTVYGW/VSkGoaOP51JV6YcIW8Iq/F/v3bpJ5KJ
 +rkQCtoe/D9FHCZABgFvOEdC/pxvdlIkI+iHnOObLouK0LxSTelayxuOY/P+98EYQXEi
 eM32M832KJO+V5Kbm/eFAZUgAPszZpTyt4lxbuDOlo8KSta2JlQyEvKR9ewhDGSGJhZ9
 nlg6NIyGvHlHnFTaYHKaAizgo90HfWxnxsnEt/uoEwjfvD4U/BWdQy7WsCtsBmlJ4TgY
 DSSgV4eZGP476x+u/nXYASxuVYCwPnVGYX66CrGyvcMFr7zR08ik61l+IctwpqotwlY0
 3vgg==
X-Gm-Message-State: AOAM530Ki8u3u8rpORa9BOjftbpAfwviKq98AuYoKlUnQS22WDDdb1Rj
 4pryJKkNHBNwRQP6qA2cOz0=
X-Google-Smtp-Source: ABdhPJzoUfrOYauzN001IpqeGAYX2bJEv5XyUjW2AwBsjkOMYSZ/zWgoYr+5IYLFDS8h7503Fgg4YQ==
X-Received: by 2002:a17:90b:33c6:: with SMTP id
 lk6mr18709354pjb.70.1640573005467; 
 Sun, 26 Dec 2021 18:43:25 -0800 (PST)
Received: from ip-172-31-30-232.ap-northeast-1.compute.internal
 (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
 by smtp.gmail.com with ESMTPSA id s35sm9767113pfw.193.2021.12.26.18.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Dec 2021 18:43:25 -0800 (PST)
Date: Mon, 27 Dec 2021 02:43:15 +0000
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
Message-ID: <YckoQ7tkLgFhJA7u@ip-172-31-30-232.ap-northeast-1.compute.internal>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
 <f3a83708-3f3c-a634-7bee-dcfcaaa7f36e@suse.cz>
 <Ycbhh5n8TBODWHR+@ip-172-31-30-232.ap-northeast-1.compute.internal>
 <Ycdak5J48i7CGkHU@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ycdak5J48i7CGkHU@casper.infradead.org>
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

On Sat, Dec 25, 2021 at 05:53:23PM +0000, Matthew Wilcox wrote:
> On Sat, Dec 25, 2021 at 09:16:55AM +0000, Hyeonggon Yoo wrote:
> > # mm: Convert struct page to struct slab in functions used by other subsystems
> > I'm not familiar with kasan, but to ask:
> > Does ____kasan_slab_free detect invalid free if someone frees
> > an object that is not allocated from slab?
> > 
> > @@ -341,7 +341,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
> > -       if (unlikely(nearest_obj(cache, virt_to_head_page(object), object) !=
> > +       if (unlikely(nearest_obj(cache, virt_to_slab(object), object) !=
> >             object)) {
> >                 kasan_report_invalid_free(tagged_object, ip);
> >                 return true;
> > 
> > I'm asking this because virt_to_slab() will return NULL if folio_test_slab()
> > returns false. That will cause NULL pointer dereference in nearest_obj.
> > I don't think this change is intended.
> 
> You need to track down how this could happen.  As far as I can tell,
> it's always called when we know the object is part of a slab.  That's
> where the cachep pointer is deduced from.

Thank you Matthew, you are right. I read the code too narrowly.
when we call kasan hooks, we know that the object is allocated from
the slab cache. (through cache_from_obj)

I'll review that patch again in part 3!

Thanks,
Hyeonggon
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
