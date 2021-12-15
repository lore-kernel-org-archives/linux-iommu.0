Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E49BC433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Dec 2021 03:48:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3B0034028D;
	Wed, 15 Dec 2021 03:48:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cdgnquhrsP5W; Wed, 15 Dec 2021 03:48:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D09664055E;
	Wed, 15 Dec 2021 03:48:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5392C002F;
	Wed, 15 Dec 2021 03:48:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D82A8C0012
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 03:47:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BF57060D6F
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 03:47:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nXqvtdfYII71 for <iommu@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 03:47:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D344660C2C
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 03:47:57 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id l10so8041405pgm.7
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 19:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=WX18AvwNcCC2p0SRhjMK6GhbrhT1JBIKs0M6zY3Lj7Q=;
 b=WPMmh69mSOiH8mgu7ySy0stRSmNQGrh1n9Iu5lufvirjG8da5krGccBikzmhxIsonV
 GbYy/0bHveh5UqULIOuHH20n1HJHPYTsvZW5BCUkJsJDXDgnV+nHa9RB4IBg2YWPJ/qe
 d5vdXmlTtFUjiF+1U4AFPGuBU6UXbON5hAccSzNXB5qEG8PdX3brb3YXmDMWwz1J8OgI
 UstG31izgnPdQHQofdMy4Pv5BBjgfkIxeFVKEuskD09VJSK12WfK1GTx0gXEl7PF3xsW
 1V9a83ysdKElKSmypE0spqdeA2uIe+86YAbXC1pKh4RUT89rp+4xvKASaUTEbBqH5mWU
 RuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WX18AvwNcCC2p0SRhjMK6GhbrhT1JBIKs0M6zY3Lj7Q=;
 b=hc0Ybx3s644raWwR2yMTgToNAG6xtTPxBCxww9v6x/rGf0dVx1JK5r41VNDzhmBOr0
 8t0WkubGBLTwEVGrwuZIDRGpmIqDAQVQjhIajN86Va0GSX8eyH3espALXzlM94wBblru
 Ny8NITuS4Z5hdfvTGZczW9XXrz0Gqbz954BfnS1tq1VLbK0lksCYo1VTM+1Fffu8X8QD
 C84j5Nm9O+bOQKNFKf/2FXtK0bMj7Pa3bqhu+HdETuKBVBAFl39jfz7ZgST9cMI8dolb
 yXYbXlT6J6FRrFBvzOENfE0uBVyWcnM3e71MM1YTsOSBTWraRCQo//0RYqXn89NIA+kW
 aW8Q==
X-Gm-Message-State: AOAM533/r1ShZYyHsNOCK5G/OKjhlenGDw492UlRBl0qLGWBGkQt7AKn
 5UWcAxYzrS0bweV7+pRcyVM=
X-Google-Smtp-Source: ABdhPJwH10ZHWDFi6cCdKP8OhQjj1dB7avN/b0cOOYyztSjA2GG31Cmv5mFdBR/aJtU91LzSkrUsRA==
X-Received: by 2002:a62:7a54:0:b0:494:6e78:994b with SMTP id
 v81-20020a627a54000000b004946e78994bmr7244240pfc.5.1639540077124; 
 Tue, 14 Dec 2021 19:47:57 -0800 (PST)
Received: from odroid ([114.29.23.242])
 by smtp.gmail.com with ESMTPSA id x11sm418405pjq.52.2021.12.14.19.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Dec 2021 19:47:56 -0800 (PST)
Date: Wed, 15 Dec 2021 03:47:46 +0000
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
Message-ID: <20211215034746.GA1097530@odroid>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
 <20211214143822.GA1063445@odroid>
 <87584294-b1bc-aabe-d86a-1a8b93a7f4d4@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87584294-b1bc-aabe-d86a-1a8b93a7f4d4@suse.cz>
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

On Tue, Dec 14, 2021 at 03:43:35PM +0100, Vlastimil Babka wrote:
> On 12/14/21 15:38, Hyeonggon Yoo wrote:
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
> >> 
> > 
> > Hello Vlastimil, Thank you for nice work.
> > I'm going to review and test new version soon in free time.
> 
> Thanks!
> 

You're welcome!

> > Btw, I gave you some review and test tags and seems to be missing in new
> > series. Did I do review/test process wrongly? It's first time to review
> > patches so please let me know if I did it wrongly.
> 
> You did right, sorry! I didn't include them as those were for patches that I
> was additionally changing after your review/test and the decision what is
> substantial change enough to need a new test/review is often fuzzy. 

Ah, Okay. review/test becomes invalid after some changing.
that's okay. I was just unfamiliar with the process. Thank you!

> So if you can recheck the new versions it would be great and then I will pick that
> up, thanks!

Okay. I'll new versions.

> 
> > --
> > Thank you.
> > Hyeonggon.
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
