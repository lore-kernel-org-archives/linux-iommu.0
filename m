Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F2FC433EF
	for <iommu@archiver.kernel.org>; Sat, 25 Dec 2021 09:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6E6D81C67;
	Sat, 25 Dec 2021 09:17:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EBEnVcw-oQKH; Sat, 25 Dec 2021 09:17:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 77A8681A0D;
	Sat, 25 Dec 2021 09:17:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EB5EC002F;
	Sat, 25 Dec 2021 09:17:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31545C0012
 for <iommu@lists.linux-foundation.org>; Sat, 25 Dec 2021 09:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06B6C60BB8
 for <iommu@lists.linux-foundation.org>; Sat, 25 Dec 2021 09:17:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tmn-B8a8LaXC for <iommu@lists.linux-foundation.org>;
 Sat, 25 Dec 2021 09:17:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 48F5E60BB7
 for <iommu@lists.linux-foundation.org>; Sat, 25 Dec 2021 09:17:06 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id n16so8018493plc.2
 for <iommu@lists.linux-foundation.org>; Sat, 25 Dec 2021 01:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=j8TrOsw0QgcOPU1it/XtIDhHHO12dds110STZzwzYD0=;
 b=nOfcDm4R5YmmsgOzRMD28sPCqa+TwQDAQHfEwt3dW/ogm2rgFf/ajmkB4ScNuPhyO8
 vYbJwRK0IZSKimBi3gea8Oje+/59Z+0N6771bKnQRHOPYgG0nV5O3ZG7v8mbs1axOAGL
 G+qJ4RNKx03TigPLiGc18Rfr8Tekoumv1fh6eY6ElmMFViRIArxRcUUDaxqriuwSKbep
 aHEYUZxo1aUj7I0wrJ0eHssFN6dTHiyDQT0tqulG//pf997KhiOJDjAnKMwINw04gyQ1
 7SPueCO4+F38JtWp128b+dPBIVb22KtU1MqSpIOk9k85uyu5uIhMGcIwIXKUCBRmUlek
 2Anw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=j8TrOsw0QgcOPU1it/XtIDhHHO12dds110STZzwzYD0=;
 b=0Kw1zv4ZkMsj2/K6eWAQNVAME6JfXE/agZh6Gc032v7KCdeZs3uJ6+s5TLuWbFVqEJ
 AT2VzmrK5KdQsmLeciqEwILcpJEN8q1BHxG3CkXIFVp5feopB+tXfS4bUJwxErAp19HP
 1/9ESeg5OGBfvX3xqKYaL0u9YSqA52a0Kd+G2esLTgTEhIAJ0msJj3oLI7XxJYlaV5KA
 4L/FtS781nzTmCBeAc5A0AR0r33uP0a5OMlti0fj65cjiFcmIDAJZMkzK7y5gCAo2gQ1
 xYn9rduRCOdavaeqoMJqH0JNQAP6ERQgxcEPYkM9g+f9hVc3/Tx+JbT26f9t8wjh7BhR
 JK6w==
X-Gm-Message-State: AOAM532O3Cqurm8Gs2ZSSzZAxW2DmZBUF1cYBLAGxvqF4VI0o/NKh3gz
 kM57kYZUVjVAUSO71sPViC4=
X-Google-Smtp-Source: ABdhPJz9jlowVnaWF5WFDxgb4hC4jKXBJ9R7DZT7d9Gt8MbbdXuDlBdTHBahWN62xgb0xOPaqu1h7Q==
X-Received: by 2002:a17:903:2303:b0:149:50d1:19d0 with SMTP id
 d3-20020a170903230300b0014950d119d0mr9507103plh.86.1640423825603; 
 Sat, 25 Dec 2021 01:17:05 -0800 (PST)
Received: from ip-172-31-30-232.ap-northeast-1.compute.internal
 (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
 by smtp.gmail.com with ESMTPSA id t10sm11886406pfg.105.2021.12.25.01.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Dec 2021 01:17:05 -0800 (PST)
Date: Sat, 25 Dec 2021 09:16:55 +0000
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
Message-ID: <Ycbhh5n8TBODWHR+@ip-172-31-30-232.ap-northeast-1.compute.internal>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
 <f3a83708-3f3c-a634-7bee-dcfcaaa7f36e@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f3a83708-3f3c-a634-7bee-dcfcaaa7f36e@suse.cz>
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

On Wed, Dec 22, 2021 at 05:56:50PM +0100, Vlastimil Babka wrote:
> On 12/14/21 13:57, Vlastimil Babka wrote:
> > On 12/1/21 19:14, Vlastimil Babka wrote:
> >> Folks from non-slab subsystems are Cc'd only to patches affecting them, and
> >> this cover letter.
> >>
> >> Series also available in git, based on 5.16-rc3:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-struct_slab-v2r2
> > 
> > Pushed a new branch slab-struct-slab-v3r3 with accumulated fixes and small tweaks
> > and a new patch from Hyeonggon Yoo on top. To avoid too much spam, here's a range diff:
> 
> Hi, I've pushed another update branch slab-struct_slab-v4r1, and also to
> -next. I've shortened git commit log lines to make checkpatch happier,
> so no range-diff as it would be too long. I believe it would be useless
> spam to post the whole series now, shortly before xmas, so I will do it
> at rc8 time, to hopefully collect remaining reviews. But if anyone wants
> a mailed version, I can do that.

Hello Vlastimil, Merry Christmas!
This is part 2 of reviewing/testing patches.

# mm/kasan: Convert to struct folio and struct slab
I'm not familiar with kasan yet but kasan runs well on my machine and
kasan's bug report functionality too works fine.
Tested-by: Hyeongogn Yoo <42.hyeyoo@gmail.com>

# mm: Convert struct page to struct slab in functions used by other subsystems
I'm not familiar with kasan, but to ask:
Does ____kasan_slab_free detect invalid free if someone frees
an object that is not allocated from slab?

@@ -341,7 +341,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
-       if (unlikely(nearest_obj(cache, virt_to_head_page(object), object) !=
+       if (unlikely(nearest_obj(cache, virt_to_slab(object), object) !=
            object)) {
                kasan_report_invalid_free(tagged_object, ip);
                return true;

I'm asking this because virt_to_slab() will return NULL if folio_test_slab()
returns false. That will cause NULL pointer dereference in nearest_obj.
I don't think this change is intended.

This makes me think some of virt_to_head_page() -> virt_to_slab()
conversion need to be reviewed with caution.

# mm/slab: Finish struct page to struct slab conversion
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

# mm/slab: Convert most struct page to struct slab by spatch
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

I'll come back with part 3 :)
Enjoy your Christmas!
Hyeonggon

> Changes in v4:
> - rebase to 5.16-rc6 to avoid a conflict with mainline
> - collect acks/reviews/tested-by from Johannes, Roman, Hyeonggon Yoo -
> thanks!
> - in patch "mm/slub: Convert detached_freelist to use a struct slab"
> renamed free_nonslab_page() to free_large_kmalloc() and use folio there,
> as suggested by Roman
> - in "mm/memcg: Convert slab objcgs from struct page to struct slab"
> change one caller of slab_objcgs_check() to slab_objcgs() as suggested
> by Johannes, realize the other caller should be also changed, and remove
> slab_objcgs_check() completely.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
