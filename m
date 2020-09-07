Return-Path: <SRS0=ylBP=CQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FFDC433E2
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 15:57:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 223CB2087D
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 15:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HRPbf6EH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223CB2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BB9888665F;
	Mon,  7 Sep 2020 15:57:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5tV87me3Swvg; Mon,  7 Sep 2020 15:57:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D8D70863D5;
	Mon,  7 Sep 2020 15:57:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9A49C0859;
	Mon,  7 Sep 2020 15:57:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A173C0051
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 15:57:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 801B385FA6
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 15:57:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vFGXhPAnk8I2 for <iommu@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 15:57:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4E52D85087
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 15:57:13 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id k25so4082154ljk.0
 for <iommu@lists.linux-foundation.org>; Mon, 07 Sep 2020 08:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vMIZm3cLWzkFGrMWJF6j0H4AX6C1QhXOuWzVwrWqKpY=;
 b=HRPbf6EH510r+2KlPVReiUcrftnFS0aP625viCQTJRsfVSmCUeXpX9YLl5oJ/P11C1
 P/i75fqE+eNcG9e5kUCp2ekc6Rx+s9nM14yqI/WFc9wQAYiF4Kl/0WvXRIaJ2Q77GYQl
 Gyq3DbMZQO06yCPUXd/n75dvU2QX9PybQVSSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vMIZm3cLWzkFGrMWJF6j0H4AX6C1QhXOuWzVwrWqKpY=;
 b=I0JcCnmU+l96Ew5Uy739oWarb7RWMSlOpCjAX5FLekUOxnFBuomzjk6rjTJ/FQTo9P
 iy9m9OIhq0Q3vcchkyMkeo/S7Ul3EcOZZJmV3liqtKgAFoxoZoatsbpXgu0r0nkhrdOm
 twxgwyjmMBI/xMLf2VGA+J+v+fVVjYlj+twTbnmOyVmjspVmcMrMyzBjcGsR15QnlEAr
 qCtpAWrPH/ys5debsf7yGyU04ccdaE3R04M1dsoaRMCvnxjZl1+qpMRs7yMdMVP18B7O
 O8SfAo4fGA2JJ9aGV3VzWZzYUNQJfsTHN43VDBYFXPu9SjXNZuevI5VMMG3JPaEZmAYi
 YPJw==
X-Gm-Message-State: AOAM531bM30Q9K0OOkZWZ6OzXwsxzZkaJsgP9/u29ObJjG/XgquuC+dV
 lJ6ncbXMGljlrely+U2nfJr9gruSuySrEg==
X-Google-Smtp-Source: ABdhPJw4zf8dtejP4vDVV+F0t+K4y6aQYG2jeLr1vIJo1zo7UH3/esfedwA2gqkqzofv98jisQ4EHA==
X-Received: by 2002:a2e:874e:: with SMTP id q14mr4675936ljj.320.1599494230875; 
 Mon, 07 Sep 2020 08:57:10 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com.
 [209.85.208.177])
 by smtp.gmail.com with ESMTPSA id v12sm7104186ljc.43.2020.09.07.08.57.10
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 08:57:10 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id u4so15768105ljd.10
 for <iommu@lists.linux-foundation.org>; Mon, 07 Sep 2020 08:57:10 -0700 (PDT)
X-Received: by 2002:a5d:660f:: with SMTP id n15mr17487462wru.103.1599493898026; 
 Mon, 07 Sep 2020 08:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200904133512eucas1p204efa4e252ceb5fb50715239705f9965@eucas1p2.samsung.com>
 <20200904131711.12950-1-m.szyprowski@samsung.com>
 <20200904131711.12950-31-m.szyprowski@samsung.com>
 <CAAFQd5AZDzG6i00gcAZKM9ZV1tATWufL=+xXUAmgrbTPt8W6Gw@mail.gmail.com>
 <bdd3503f-d4f1-a1af-d10d-d75a1037ac5a@samsung.com>
In-Reply-To: <bdd3503f-d4f1-a1af-d10d-d75a1037ac5a@samsung.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 7 Sep 2020 17:51:26 +0200
X-Gmail-Original-Message-ID: <CAAFQd5Dp4qBVN1H0LfJ8h49pwGe+7MnCKZnmS4-6yxzii_Ct8A@mail.gmail.com>
Message-ID: <CAAFQd5Dp4qBVN1H0LfJ8h49pwGe+7MnCKZnmS4-6yxzii_Ct8A@mail.gmail.com>
Subject: Re: [PATCH v10 30/30] videobuf2: use sgtable-based scatterlist
 wrappers
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, linaro-mm-sig@lists.linaro.org,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
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

On Mon, Sep 7, 2020 at 4:02 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Tomasz,
>
> On 07.09.2020 15:07, Tomasz Figa wrote:
> > On Fri, Sep 4, 2020 at 3:35 PM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> >> Use recently introduced common wrappers operating directly on the struct
> >> sg_table objects and scatterlist page iterators to make the code a bit
> >> more compact, robust, easier to follow and copy/paste safe.
> >>
> >> No functional change, because the code already properly did all the
> >> scatterlist related calls.
> >>
> >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> >> ---
> >>   .../common/videobuf2/videobuf2-dma-contig.c   | 34 ++++++++-----------
> >>   .../media/common/videobuf2/videobuf2-dma-sg.c | 32 +++++++----------
> >>   .../common/videobuf2/videobuf2-vmalloc.c      | 12 +++----
> >>   3 files changed, 31 insertions(+), 47 deletions(-)
> >>
> > Thanks for the patch! Please see my comments inline.
> >
> >> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> >> index ec3446cc45b8..1b242d844dde 100644
> >> --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> >> +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> >> @@ -58,10 +58,10 @@ static unsigned long vb2_dc_get_contiguous_size(struct sg_table *sgt)
> >>          unsigned int i;
> >>          unsigned long size = 0;
> >>
> >> -       for_each_sg(sgt->sgl, s, sgt->nents, i) {
> >> +       for_each_sgtable_dma_sg(sgt, s, i) {
> >>                  if (sg_dma_address(s) != expected)
> >>                          break;
> >> -               expected = sg_dma_address(s) + sg_dma_len(s);
> >> +               expected += sg_dma_len(s);
> >>                  size += sg_dma_len(s);
> >>          }
> >>          return size;
> >> @@ -103,8 +103,7 @@ static void vb2_dc_prepare(void *buf_priv)
> >>          if (!sgt)
> >>                  return;
> >>
> >> -       dma_sync_sg_for_device(buf->dev, sgt->sgl, sgt->orig_nents,
> >> -                              buf->dma_dir);
> >> +       dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
> >>   }
> >>
> >>   static void vb2_dc_finish(void *buf_priv)
> >> @@ -115,7 +114,7 @@ static void vb2_dc_finish(void *buf_priv)
> >>          if (!sgt)
> >>                  return;
> >>
> >> -       dma_sync_sg_for_cpu(buf->dev, sgt->sgl, sgt->orig_nents, buf->dma_dir);
> >> +       dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
> >>   }
> >>
> >>   /*********************************************/
> >> @@ -275,8 +274,8 @@ static void vb2_dc_dmabuf_ops_detach(struct dma_buf *dbuf,
> >>                   * memory locations do not require any explicit cache
> >>                   * maintenance prior or after being used by the device.
> >>                   */
> >> -               dma_unmap_sg_attrs(db_attach->dev, sgt->sgl, sgt->orig_nents,
> >> -                                  attach->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
> >> +               dma_unmap_sgtable(db_attach->dev, sgt, attach->dma_dir,
> >> +                                 DMA_ATTR_SKIP_CPU_SYNC);
> >>          sg_free_table(sgt);
> >>          kfree(attach);
> >>          db_attach->priv = NULL;
> >> @@ -301,8 +300,8 @@ static struct sg_table *vb2_dc_dmabuf_ops_map(
> >>
> >>          /* release any previous cache */
> >>          if (attach->dma_dir != DMA_NONE) {
> >> -               dma_unmap_sg_attrs(db_attach->dev, sgt->sgl, sgt->orig_nents,
> >> -                                  attach->dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
> >> +               dma_unmap_sgtable(db_attach->dev, sgt, attach->dma_dir,
> >> +                                 DMA_ATTR_SKIP_CPU_SYNC);
> >>                  attach->dma_dir = DMA_NONE;
> >>          }
> >>
> >> @@ -310,9 +309,8 @@ static struct sg_table *vb2_dc_dmabuf_ops_map(
> >>           * mapping to the client with new direction, no cache sync
> >>           * required see comment in vb2_dc_dmabuf_ops_detach()
> >>           */
> >> -       sgt->nents = dma_map_sg_attrs(db_attach->dev, sgt->sgl, sgt->orig_nents,
> >> -                                     dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
> >> -       if (!sgt->nents) {
> >> +       if (dma_map_sgtable(db_attach->dev, sgt, dma_dir,
> >> +                           DMA_ATTR_SKIP_CPU_SYNC)) {
> >>                  pr_err("failed to map scatterlist\n");
> >>                  mutex_unlock(lock);
> >>                  return ERR_PTR(-EIO);
> > As opposed to dma_map_sg_attrs(), dma_map_sgtable() now returns an
> > error code on its own. Is it expected to ignore it and return -EIO?
>
> Those errors are more or less propagated to userspace and -EIO has been
> already widely documented in V4L2 documentation as the error code for
> the most of the V4L2 ioctls. I don't want to change it. A possible
> -EINVAL returned from dma_map_sgtable() was just one of the 'generic'
> error codes, not very descriptive in that case. Probably the main
> problem here is that dma_map_sg() and friend doesn't return any error
> codes...

True for the alloc/get_*() callbacks, but the dmabuf_ops_map() ones
are used for the in-kernel DMA-buf exporter ops, called by DMA-buf
importers.

As a side note, returning user-facing error codes from deep internals
of vb2 and having the userspace rely on particular values sounds quite
fragile. For example, I see vb2_dc_attach_dmabuf() returning a return
value coming from dma_buf_attach() directly and __prepare_dmabuf()
propagating it back to __buf_prepare(), which can just return that
back to the userspace. I guess we might have to do some follow-up work
to clean it up.

Best regards,
Tomasz
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
