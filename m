Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC65C433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Dec 2021 07:36:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E400840294;
	Wed, 22 Dec 2021 07:36:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MXAgAgOnIY2F; Wed, 22 Dec 2021 07:36:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BD43340236;
	Wed, 22 Dec 2021 07:36:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91220C001E;
	Wed, 22 Dec 2021 07:36:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A0FAC0012
 for <iommu@lists.linux-foundation.org>; Wed, 22 Dec 2021 07:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 812A860EDC
 for <iommu@lists.linux-foundation.org>; Wed, 22 Dec 2021 07:36:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mDADiKAGGi3U for <iommu@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 07:36:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AE80560BA7
 for <iommu@lists.linux-foundation.org>; Wed, 22 Dec 2021 07:36:43 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id g22so1397885pgn.1
 for <iommu@lists.linux-foundation.org>; Tue, 21 Dec 2021 23:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=WrvvWhSLi37P9Hu9a/lN3dt16MiGegPkcEW+eWXvnco=;
 b=RKpi5mEKObOsMfFa2Hh3uM3GzsMIBcjoLEKD7cwnOeZVwpA/d0V88BawrYNtOMnFn7
 l9nLVd1NKaLq5pB3voPPj4Z2icjvncDwuZ1uCcPIm6/WMKIxRRSgNH/mDo7gCP9SqWkU
 gYLMtOZHpZ2bc7XcFtJFnIgGuT/WDzmxB2cJqJdB0KPkqVUD86hast7AId9I1sCheseV
 FXPC48nv7polwBlytcx80Ge2CfcadbncgdXZ3ZbZeK1wttQ3MYdrMcX33gMLD2b77cBe
 1XVNoWD64mGKqnHA2cr7yfFsOmBI796jO3rcUEeDFIAJ9d2aBQsqNJ50N2r74mkiVcl+
 IdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WrvvWhSLi37P9Hu9a/lN3dt16MiGegPkcEW+eWXvnco=;
 b=cfIouhEi370N2+XrPQBGB4MX/IvyzpVtoaKs9Zh58tD5Saki9CV1NmPkbyKdk6LwSS
 3q/Eo/Dwk2wrj/poguCKfqyciStzOxlnlpBBca29UoBtfH5d2vspT6oQvMvx6jEWb9ku
 2MHo4kH5B2bC/+XIlcBxQ78ZVeGBzSONoDM7W3vJlf+pG5ssXb15g0cyqTFhwbeFs+Ey
 TVP+bhhEyCs5I482+Ooei53dHzVK9A9pJPxo4t2/MVviI23iiSz4Wap/gSUNw78hJ61e
 gB3DIpuH3Th5hYoMD7HTPlvjGuEXHN72b3FAUIg7iXVL74wRQcV9NBCzMVnN3eXCbaaq
 LF3w==
X-Gm-Message-State: AOAM533xj1lmtDabmwjpFw+qos89kCSZAHvGHlvM1a3/Tn4Cwb82nJRe
 vlhVnpfJwUuLnUzWzjFuhjI=
X-Google-Smtp-Source: ABdhPJyHgWJMD56kcLvcfd7Dna83oWWhHn+FdUZZGPKlzE0fgc8M5z+y33KIsE262NlfnBnCmss6iQ==
X-Received: by 2002:a63:8f06:: with SMTP id n6mr1787692pgd.95.1640158602956;
 Tue, 21 Dec 2021 23:36:42 -0800 (PST)
Received: from ip-172-31-30-232.ap-northeast-1.compute.internal
 (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
 by smtp.gmail.com with ESMTPSA id v4sm884943pjk.38.2021.12.21.23.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Dec 2021 23:36:42 -0800 (PST)
Date: Wed, 22 Dec 2021 07:36:33 +0000
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
Message-ID: <YcLVgdpyhZjtAatZ@ip-172-31-30-232.ap-northeast-1.compute.internal>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
 <YbtUmi5kkhmlXEB1@ip-172-31-30-232.ap-northeast-1.compute.internal>
 <38976607-b9f9-1bce-9db9-60c23da65d2e@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <38976607-b9f9-1bce-9db9-60c23da65d2e@suse.cz>
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

On Tue, Dec 21, 2021 at 12:58:14AM +0100, Vlastimil Babka wrote:
> On 12/16/21 16:00, Hyeonggon Yoo wrote:
> > On Tue, Dec 14, 2021 at 01:57:22PM +0100, Vlastimil Babka wrote:
> >> On 12/1/21 19:14, Vlastimil Babka wrote:
> >> > Folks from non-slab subsystems are Cc'd only to patches affecting them, and
> >> > this cover letter.
> >> > 
> >> > Series also available in git, based on 5.16-rc3:
> >> > https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-struct_slab-v2r2
> >> 
> >> Pushed a new branch slab-struct-slab-v3r3 with accumulated fixes and small tweaks
> >> and a new patch from Hyeonggon Yoo on top. To avoid too much spam, here's a range diff:
> > 
> > Reviewing the whole patch series takes longer than I thought.
> > I'll try to review and test rest of patches when I have time.
> > 
> > I added Tested-by if kernel builds okay and kselftests
> > does not break the kernel on my machine.
> > (with CONFIG_SLAB/SLUB/SLOB depending on the patch),
> 
> Thanks!
>

:)

> > Let me know me if you know better way to test a patch.
> 
> Testing on your machine is just fine.
>

Good!

> > # mm/slub: Define struct slab fields for CONFIG_SLUB_CPU_PARTIAL only when enabled
> > 
> > Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > 
> > Comment:
> > Works on both SLUB_CPU_PARTIAL and !SLUB_CPU_PARTIAL.
> > btw, do we need slabs_cpu_partial attribute when we don't use
> > cpu partials? (!SLUB_CPU_PARTIAL)
> 
> The sysfs attribute? Yeah we should be consistent to userspace expecting to
> read it (even with zeroes), regardless of config.
> 

I thought entirely disabling the attribute is simpler,
But okay If it should be exposed even if it's always zero.

> > # mm/slub: Simplify struct slab slabs field definition
> > Comment:
> > 
> > This is how struct page looks on the top of v3r3 branch:
> > struct page {
> > [...]
> >                 struct {        /* slab, slob and slub */
> >                         union {
> >                                 struct list_head slab_list;
> >                                 struct {        /* Partial pages */
> >                                         struct page *next;
> > #ifdef CONFIG_64BIT
> >                                         int pages;      /* Nr of pages left */
> > #else
> >                                         short int pages;
> > #endif
> >                                 };
> >                         };
> > [...]
> > 
> > It's not consistent with struct slab.
> 
> Hm right. But as we don't actually use the struct page version anymore, and
> it's not one of the fields checked by SLAB_MATCH(), we can ignore this.
>

Yeah this is not a big problem. just mentioned this because 
it looked weird and I didn't know when the patch "mm: Remove slab from struct page"
will come back.

> > I think this is because "mm: Remove slab from struct page" was dropped.
>
> That was just postponed until iommu changes are in. Matthew mentioned those
> might be merged too, so that final cleanup will happen too and take care of
> the discrepancy above, so no need for extra churn to address it speficially.
> 

Okay it seems no extra work needed until the iommu changes are in!

BTW, in the patch (that I sent) ("mm/slob: Remove unnecessary page_mapcount_reset()
function call"), it refers commit 4525180926f9  ("mm/sl*b: Differentiate struct slab fields by
sl*b implementations"). But the commit hash 4525180926f9 changed after the
tree has been changed.

It will be nice to write a script to handle situations like this.

> > Would you update some of patches?
> > 
> > # mm/sl*b: Differentiate struct slab fields by sl*b implementations
> > Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Works SL[AUO]B on my machine and makes code much better.
> > 
> > # mm/slob: Convert SLOB to use struct slab and struct folio
> > Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > It still works fine on SLOB.
> > 
> > # mm/slab: Convert kmem_getpages() and kmem_freepages() to struct slab
> > Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> >
> > # mm/slub: Convert __free_slab() to use struct slab
> > Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > 
> > Thanks,
> > Hyeonggon.
> 
> Thanks again,
> Vlastimil

Have a nice day, thanks!
Hyeonggon.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
