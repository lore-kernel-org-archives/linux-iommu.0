Return-Path: <SRS0=qNYd=BA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A506C433E5
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 08:39:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D6ED20709
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 08:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6ED20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2B58A88BC7;
	Tue, 21 Jul 2020 08:39:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j4tdFyCxwIyU; Tue, 21 Jul 2020 08:39:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6F55088B9C;
	Tue, 21 Jul 2020 08:39:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63B87C089F;
	Tue, 21 Jul 2020 08:39:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8F37C016F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 08:39:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A7669813F6
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 08:39:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yTjzzoWFXW+E for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jul 2020 08:39:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9DAE0806EF
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 08:39:53 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 080F5AC46;
 Tue, 21 Jul 2020 08:39:58 +0000 (UTC)
Message-ID: <550b30a86c0785049d24c945e2c6628d491cee3a.camel@suse.de>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Amit Pundir <amit.pundir@linaro.org>
Date: Tue, 21 Jul 2020 10:39:49 +0200
In-Reply-To: <CAMi1Hd35tRM=cnmzwX=SDgu-OoXi1Xj+twFkoULaVZBbTpe6sw@mail.gmail.com>
References: <20200708164936.9340-1-nsaenzjulienne@suse.de>
 <CAMi1Hd35tRM=cnmzwX=SDgu-OoXi1Xj+twFkoULaVZBbTpe6sw@mail.gmail.com>
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Cc: lkml <linux-kernel@vger.kernel.org>, jeremy.linton@arm.com,
 Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux-foundation.org,
 John Stultz <john.stultz@linaro.org>, linux-rpi-kernel@lists.infradead.org,
 David Rientjes <rientjes@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

Hi Amit,

On Tue, 2020-07-21 at 12:51 +0530, Amit Pundir wrote:
> On Wed, 8 Jul 2020 at 22:43, Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > There is no guarantee to CMA's placement, so allocating a zone
> > specific
> > atomic pool from CMA might return memory from a completely
> > different
> > memory zone. So stop using it.
> > 
> > Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to
> > map to gfp mask")
> 
> Hi Nicolas,
> 
> I see a boot regression with this commit d9765e41d8e9 "dma-pool:
> Do not allocate pool memory from CMA" on my Xiaomi Poco F1
> (Qcom sdm845) phone running v5.8-rc6. I can't boot past the
> bootloader splash screen with this patch.
> 
> Phone boots fine if I revert this patch. I carry only one out of tree
> dts patch https://lkml.org/lkml/2020/6/25/52. And since this is a
> stock
> phone, I don't have access to serial/dmesg logs until I boot to AOSP
> (adb) shell.
> 
> Any thoughts as to what might be going wrong here? I'd be happy to
> help debug things. For what it's worth, I don't see this regression
> on
> other two sdm845 devices (db845c and Pixel 3) I tested on.

Can you provide a boot log (even if without my patch) and the device-
tree files? It'd help a lot figuring things out.

Regards,
Nicolas

> Regards,
> Amit Pundir
> 
> > Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> > 
> > An more costly alternative would be adding an option to
> > dma_alloc_from_contiguous() so it fails when the allocation doesn't
> > fall
> > in a specific zone.
> > 
> >  kernel/dma/pool.c | 11 ++---------
> >  1 file changed, 2 insertions(+), 9 deletions(-)
> > 
> > diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> > index 8cfa01243ed2..4bc1c46ae6ef 100644
> > --- a/kernel/dma/pool.c
> > +++ b/kernel/dma/pool.c
> > @@ -6,7 +6,6 @@
> >  #include <linux/debugfs.h>
> >  #include <linux/dma-direct.h>
> >  #include <linux/dma-noncoherent.h>
> > -#include <linux/dma-contiguous.h>
> >  #include <linux/init.h>
> >  #include <linux/genalloc.h>
> >  #include <linux/set_memory.h>
> > @@ -69,12 +68,7 @@ static int atomic_pool_expand(struct gen_pool
> > *pool, size_t pool_size,
> > 
> >         do {
> >                 pool_size = 1 << (PAGE_SHIFT + order);
> > -
> > -               if (dev_get_cma_area(NULL))
> > -                       page = dma_alloc_from_contiguous(NULL, 1 <<
> > order,
> > -                                                        order,
> > false);
> > -               else
> > -                       page = alloc_pages(gfp, order);
> > +               page = alloc_pages(gfp, order);
> >         } while (!page && order-- > 0);
> >         if (!page)
> >                 goto out;
> > @@ -118,8 +112,7 @@ static int atomic_pool_expand(struct gen_pool
> > *pool, size_t pool_size,
> >         dma_common_free_remap(addr, pool_size);
> >  #endif
> >  free_page: __maybe_unused
> > -       if (!dma_release_from_contiguous(NULL, page, 1 << order))
> > -               __free_pages(page, order);
> > +       __free_pages(page, order);
> >  out:
> >         return ret;
> >  }
> > --
> > 2.27.0
> > 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
