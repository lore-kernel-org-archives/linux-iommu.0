Return-Path: <SRS0=n9pq=UC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ACDC282CE
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 10:48:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30950280C0
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 10:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOtgixTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30950280C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0C7FCBE4;
	Mon,  3 Jun 2019 10:48:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 48730B7A
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 10:48:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3980886E
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 10:48:08 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id a8so26289498edx.3
	for <iommu@lists.linux-foundation.org>;
	Mon, 03 Jun 2019 03:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=PF01dlpv29ID++sixBjMOxvgkyLI2Cq8HM7Er9/h30E=;
	b=AOtgixTyA8XuhW55qmbocWeiEVeMHAoKBQ4HukPhPbIkjOa1V8CwnN0TSQid8mmd5y
	UFSbeS4hduLLCATKmonkhWhD+lDBbCIwQ+lsHm/oyude9YwHLO3mxohpuy60qRI3+WKF
	Jey7JaIOGe7+E8KZ+CdffrMKMtEcxkY2iXy1GuTKw3E1ppbDwjZtDssln5Or/k24eTwC
	DZofnHyfJE0baAA9+ut4n8V39F3vaNu3VRrLxJdzelY6D4rPRQunyQRPNQadnuiP9kv5
	hQyubSnsKQRj9dkBj2jCZ1X45RdcCsEKrLUmb79Lfy1lpEiMCIH/w1v8mXtfBAO5xTk1
	d1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=PF01dlpv29ID++sixBjMOxvgkyLI2Cq8HM7Er9/h30E=;
	b=IpCVwMtyRaQOgbCS6y5pCbLTD4iUTa+GRV/SJkMhwNcgfOnvZAV4J9AlaX2j9ruqDV
	it1B9lpSGHdnVTEPkLiYco3+N8Gq1ROTrydImR7gaR+9c7ajMuQYdbvPi906wMWpxi1g
	h2FtPNETMWubcXGCGxoP0oqvRRKABxxjgX9ZjJHrazUlLbWd8Uk7uzJY+pOqoLv1AWlS
	QA38CA6u+aKna5aVtvDkatEi1VnaDICr4x9T84NgmNEH5gb/AFBuoCgst5CzDkZ+FUmC
	Bj/edFbQHpalQitCV1Ym6GcEy0F7n7Zf/AM5fyc9bM/QWYUABs2whvUZMMG/U+lFPjX9
	redg==
X-Gm-Message-State: APjAAAWpxyPulLh4Xg7no9p3oTYH+KJ6JggoUFy0+QQn/ZVB0wduoxky
	ahS1wDD3eVZ+Nhne4y4G0O95fiE70kzMUrD8WZQ=
X-Google-Smtp-Source: APXvYqxMk/T2HUSHdq5P1tGTtTjGP8FxUlFk5Orq2CPqufNlacM3m+UM5Foy4lwrIa28QXVQm0NtpOgt4uXbe99Xplw=
X-Received: by 2002:a50:bc15:: with SMTP id j21mr27411237edh.163.1559558886761;
	Mon, 03 Jun 2019 03:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181201165348.24140-1-robdclark@gmail.com>
	<CAL_JsqJmPqis46Un91QyhXgdrVtfATMP_hTp6wSeSAfc8MLFfw@mail.gmail.com>
	<CAF6AEGs9Nsft8ofZkGz_yWBPBC+prh8dBSkJ4PJr8yk2c5FMdQ@mail.gmail.com>
	<CAF6AEGt-dhbQS5zZCNVTLT57OiUwO0RiP5bawTSu2RKZ-7W-aw@mail.gmail.com>
	<CAAFQd5BdrJFL5LKK8O5NPDKWfFgkTX_JU-jU3giEz33tj-jwCA@mail.gmail.com>
In-Reply-To: <CAAFQd5BdrJFL5LKK8O5NPDKWfFgkTX_JU-jU3giEz33tj-jwCA@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 3 Jun 2019 03:47:53 -0700
Message-ID: <CAF6AEGtj+kyXqKeJK2-0e1jw_A4wz-yBEyv5zhf5Vfoi2_p2CA@mail.gmail.com>
Subject: Re: [PATCH] of/device: add blacklist for iommu dma_ops
To: Tomasz Figa <tfiga@chromium.org>
Cc: freedreno <freedreno@lists.freedesktop.org>,
	Daniel Vetter <daniel@ffwll.ch>, Frank Rowand <frowand.list@gmail.com>,
	devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>, Doug Anderson <dianders@chromium.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Rob Herring <robh+dt@kernel.org>, Sean Paul <seanpaul@chromium.org>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Sun, Jun 2, 2019 at 11:25 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> On Mon, Jun 3, 2019 at 4:40 AM Rob Clark <robdclark@gmail.com> wrote:
> >
> > On Fri, May 10, 2019 at 7:35 AM Rob Clark <robdclark@gmail.com> wrote:
> > >
> > > On Tue, Dec 4, 2018 at 2:29 PM Rob Herring <robh+dt@kernel.org> wrote:
> > > >
> > > > On Sat, Dec 1, 2018 at 10:54 AM Rob Clark <robdclark@gmail.com> wrote:
> > > > >
> > > > > This solves a problem we see with drm/msm, caused by getting
> > > > > iommu_dma_ops while we attach our own domain and manage it directly at
> > > > > the iommu API level:
> > > > >
> > > > >   [0000000000000038] user address but active_mm is swapper
> > > > >   Internal error: Oops: 96000005 [#1] PREEMPT SMP
> > > > >   Modules linked in:
> > > > >   CPU: 7 PID: 70 Comm: kworker/7:1 Tainted: G        W         4.19.3 #90
> > > > >   Hardware name: xxx (DT)
> > > > >   Workqueue: events deferred_probe_work_func
> > > > >   pstate: 80c00009 (Nzcv daif +PAN +UAO)
> > > > >   pc : iommu_dma_map_sg+0x7c/0x2c8
> > > > >   lr : iommu_dma_map_sg+0x40/0x2c8
> > > > >   sp : ffffff80095eb4f0
> > > > >   x29: ffffff80095eb4f0 x28: 0000000000000000
> > > > >   x27: ffffffc0f9431578 x26: 0000000000000000
> > > > >   x25: 00000000ffffffff x24: 0000000000000003
> > > > >   x23: 0000000000000001 x22: ffffffc0fa9ac010
> > > > >   x21: 0000000000000000 x20: ffffffc0fab40980
> > > > >   x19: ffffffc0fab40980 x18: 0000000000000003
> > > > >   x17: 00000000000001c4 x16: 0000000000000007
> > > > >   x15: 000000000000000e x14: ffffffffffffffff
> > > > >   x13: ffff000000000000 x12: 0000000000000028
> > > > >   x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
> > > > >   x9 : 0000000000000000 x8 : ffffffc0fab409a0
> > > > >   x7 : 0000000000000000 x6 : 0000000000000002
> > > > >   x5 : 0000000100000000 x4 : 0000000000000000
> > > > >   x3 : 0000000000000001 x2 : 0000000000000002
> > > > >   x1 : ffffffc0f9431578 x0 : 0000000000000000
> > > > >   Process kworker/7:1 (pid: 70, stack limit = 0x0000000017d08ffb)
> > > > >   Call trace:
> > > > >    iommu_dma_map_sg+0x7c/0x2c8
> > > > >    __iommu_map_sg_attrs+0x70/0x84
> > > > >    get_pages+0x170/0x1e8
> > > > >    msm_gem_get_iova+0x8c/0x128
> > > > >    _msm_gem_kernel_new+0x6c/0xc8
> > > > >    msm_gem_kernel_new+0x4c/0x58
> > > > >    dsi_tx_buf_alloc_6g+0x4c/0x8c
> > > > >    msm_dsi_host_modeset_init+0xc8/0x108
> > > > >    msm_dsi_modeset_init+0x54/0x18c
> > > > >    _dpu_kms_drm_obj_init+0x430/0x474
> > > > >    dpu_kms_hw_init+0x5f8/0x6b4
> > > > >    msm_drm_bind+0x360/0x6c8
> > > > >    try_to_bring_up_master.part.7+0x28/0x70
> > > > >    component_master_add_with_match+0xe8/0x124
> > > > >    msm_pdev_probe+0x294/0x2b4
> > > > >    platform_drv_probe+0x58/0xa4
> > > > >    really_probe+0x150/0x294
> > > > >    driver_probe_device+0xac/0xe8
> > > > >    __device_attach_driver+0xa4/0xb4
> > > > >    bus_for_each_drv+0x98/0xc8
> > > > >    __device_attach+0xac/0x12c
> > > > >    device_initial_probe+0x24/0x30
> > > > >    bus_probe_device+0x38/0x98
> > > > >    deferred_probe_work_func+0x78/0xa4
> > > > >    process_one_work+0x24c/0x3dc
> > > > >    worker_thread+0x280/0x360
> > > > >    kthread+0x134/0x13c
> > > > >    ret_from_fork+0x10/0x18
> > > > >   Code: d2800004 91000725 6b17039f 5400048a (f9401f40)
> > > > >   ---[ end trace f22dda57f3648e2c ]---
> > > > >   Kernel panic - not syncing: Fatal exception
> > > > >   SMP: stopping secondary CPUs
> > > > >   Kernel Offset: disabled
> > > > >   CPU features: 0x0,22802a18
> > > > >   Memory Limit: none
> > > > >
> > > > > The problem is that when drm/msm does it's own iommu_attach_device(),
> > > > > now the domain returned by iommu_get_domain_for_dev() is drm/msm's
> > > > > domain, and it doesn't have domain->iova_cookie.
> > > > >
> > > > > We kind of avoided this problem prior to sdm845/dpu because the iommu
> > > > > was attached to the mdp node in dt, which is a child of the toplevel
> > > > > mdss node (which corresponds to the dev passed in dma_map_sg()).  But
> > > > > with sdm845, now the iommu is attached at the mdss level so we hit the
> > > > > iommu_dma_ops in dma_map_sg().
> > > > >
> > > > > But auto allocating/attaching a domain before the driver is probed was
> > > > > already a blocking problem for enabling per-context pagetables for the
> > > > > GPU.  This problem is also now solved with this patch.
> > > > >
> > > > > Fixes: 97890ba9289c dma-mapping: detect and configure IOMMU in of_dma_configure
> > > > > Tested-by: Douglas Anderson <dianders@chromium.org>
> > > > > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > > > > ---
> > > > > This is an alternative/replacement for [1].  What it lacks in elegance
> > > > > it makes up for in practicality ;-)
> > > > >
> > > > > [1] https://patchwork.freedesktop.org/patch/264930/
> > > > >
> > > > >  drivers/of/device.c | 22 ++++++++++++++++++++++
> > > > >  1 file changed, 22 insertions(+)
> > > > >
> > > > > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > > > > index 5957cd4fa262..15ffee00fb22 100644
> > > > > --- a/drivers/of/device.c
> > > > > +++ b/drivers/of/device.c
> > > > > @@ -72,6 +72,14 @@ int of_device_add(struct platform_device *ofdev)
> > > > >         return device_add(&ofdev->dev);
> > > > >  }
> > > > >
> > > > > +static const struct of_device_id iommu_blacklist[] = {
> > > > > +       { .compatible = "qcom,mdp4" },
> > > > > +       { .compatible = "qcom,mdss" },
> > > > > +       { .compatible = "qcom,sdm845-mdss" },
> > > > > +       { .compatible = "qcom,adreno" },
> > > > > +       {}
> > > > > +};
> > > >
> > > > Not completely clear to whether this is still needed or not, but this
> > > > really won't scale. Why can't the driver for these devices override
> > > > whatever has been setup by default?
> > > >
> > >
> > > fwiw, at the moment it is not needed, but it will become needed again
> > > to implement per-context pagetables (although I suppose for this we
> > > only need to blacklist qcom,adreno and not also the display nodes).
> >
> > So, another case I've come across, on the display side.. I'm working
> > on handling the case where bootloader enables display (and takes iommu
> > out of reset).. as soon as DMA domain gets attached we get iommu
> > faults, because bootloader has already configured display for scanout.
> > Unfortunately this all happens before actual driver is probed and has
> > a chance to intervene.
> >
> > It's rather unfortunate that we tried to be clever rather than just
> > making drivers call some function to opt-in to the hookup of dma iommu
> > ops :-(
>
> I think it still works for the 90% of cases and if 10% needs some
> explicit work in the drivers, that's better than requiring 100% of the
> drivers to do things manually.
>
> Adding Marek who had the same problem on Exynos.

I do wonder how many drivers need to iommu_map in their ->probe()?
I'm thinking moving the auto-hookup to after a successful probe(),
with some function a driver could call if they need mapping in probe,
might be a way to eventually get rid of the blacklist.  But I've no
idea how to find the subset of drivers that would be broken without a
dma_setup_iommu_stuff() call in their probe.

BR,
-R

> Best regards,
> Tomasz
>
> >
> > BR,
> > -R
> >
> > >
> > > The reason is that in the current state the core code creates the
> > > first domain before the driver has a chance to intervene and tell it
> > > not to.  And this results that driver ends up using a different
> > > context bank on the iommu than what the firmware expects.
> > >
> > > I guess the alternative is to put some property in DT.. but that
> > > doesn't really feel right.  I guess there aren't really many (or any?)
> > > other drivers that have this specific problem, so I don't really
> > > expect it to be a scaling problem.
> > >
> > > Yeah, it's a bit ugly, but I'll take a small ugly working hack, over
> > > elegant but non-working any day ;-)... but if someone has a better
> > > idea then I'm all ears.
> > >
> > > BR,
> > > -R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
