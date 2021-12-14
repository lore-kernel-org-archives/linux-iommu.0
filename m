Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED88DC433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 15:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94ADB814B5;
	Tue, 14 Dec 2021 15:14:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qddgNkuadrKY; Tue, 14 Dec 2021 15:14:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6FF7681452;
	Tue, 14 Dec 2021 15:14:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 153F0C006E;
	Tue, 14 Dec 2021 15:14:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59BC8C0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 14:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47E2281468
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 14:38:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YI1KXZo3vHV8 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 14:38:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A724481467
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 14:38:34 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id m24so13673674pls.10
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 06:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=R4NvS2jKJuj6HSBgH45i5FwQuCehWvgVUBxINrvhBWY=;
 b=GOrcD4BmPPCvB9InDaocP5JXrZvS55QPHn1oMIJngrl4K7kJOcg9M+7vSV/bfyml6r
 IGBOP+PcFOu20UPNiHymPfTVGc9kr3Yz86bsFSsSAyM/PXyDzyaOH11olTZHD4rZZ0fP
 MMpiarUSyE9MsPIhmuvQ6nl8aYEVn07PraTQjKS5Fp/apXNHC1Y5fRIxcAPj/jFVgMJ0
 CZmioE0R5dWEG1SScDLLvTu0JW1rZXFv9TsjAqLl/bJcpV6bq6fBWL2O/C8owVrdPosx
 VbzPg/9y6EUBAMs8DERVchvg+cYIQnre6n7DGD78lukKQBH2+EsxnhguwHMgGiPWEIDX
 G4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=R4NvS2jKJuj6HSBgH45i5FwQuCehWvgVUBxINrvhBWY=;
 b=FuzCpYBeo9vT8pH6ZhB2cCkPZCEIZddkWbFtXAn+IzRmxfWcxkdomQF6f92MtT9JT5
 o3pUnSkTBGjTgp+6SAD+NvHB0GjFuMdZGpKpLIDiIgYIjyD0ve4wHYLHjYJN5ASE3d66
 Cx1UgdLmMtJtmYPIxyHkAjTl6IdQ130OefvRj48+AHAK7kRcO3N4dAhDq7IMUs+hVH2X
 gxuJxjzCpWs6C1XPiZROXDjTU1Edco6NbXhori8gY2CO8VXXedNGUdkNeVqNNunYi0XX
 qdJFM4HHKDWDmpqT7lhPMHhU3KzNOhpjXflJ774lAcV3LKs8Mq22Pff1ek2wQ0vvz250
 7gMQ==
X-Gm-Message-State: AOAM5330tBNzRrwACf5SabScHGcMBT6xKwI6dcpETNgrSJzA7GKL0hxv
 q2ry3kis8X/HivYXg1kViRk=
X-Google-Smtp-Source: ABdhPJxQakCbY/pX/9j8kiCCq9EdRhXPHFP5tma5M2y+j3afCy5n5EXVWgIlpMhJmrgFUQoGQznkcQ==
X-Received: by 2002:a17:902:e544:b0:144:e3fa:3c2e with SMTP id
 n4-20020a170902e54400b00144e3fa3c2emr6596816plf.17.1639492714139; 
 Tue, 14 Dec 2021 06:38:34 -0800 (PST)
Received: from odroid ([114.29.23.242])
 by smtp.gmail.com with ESMTPSA id s16sm64466pfu.109.2021.12.14.06.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Dec 2021 06:38:33 -0800 (PST)
Date: Tue, 14 Dec 2021 14:38:22 +0000
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
Message-ID: <20211214143822.GA1063445@odroid>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
X-Mailman-Approved-At: Tue, 14 Dec 2021 15:14:01 +0000
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

On Tue, Dec 14, 2021 at 01:57:22PM +0100, Vlastimil Babka wrote:
> On 12/1/21 19:14, Vlastimil Babka wrote:
> > Folks from non-slab subsystems are Cc'd only to patches affecting them, and
> > this cover letter.
> > 
> > Series also available in git, based on 5.16-rc3:
> > https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-struct_slab-v2r2
> 
> Pushed a new branch slab-struct-slab-v3r3 with accumulated fixes and small tweaks
> and a new patch from Hyeonggon Yoo on top. To avoid too much spam, here's a range diff:
> 

Hello Vlastimil, Thank you for nice work.
I'm going to review and test new version soon in free time.

Btw, I gave you some review and test tags and seems to be missing in new
series. Did I do review/test process wrongly? It's first time to review
patches so please let me know if I did it wrongly.

--
Thank you.
Hyeonggon.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
