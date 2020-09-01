Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BC4C433E2
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 03:42:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 768AB20693
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 03:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWrOGraZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768AB20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 367D086650;
	Tue,  1 Sep 2020 03:42:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tuPVvvgW8O99; Tue,  1 Sep 2020 03:42:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8F74086654;
	Tue,  1 Sep 2020 03:42:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B6A0C088B;
	Tue,  1 Sep 2020 03:42:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F411EC0052
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 03:42:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E11CD86654
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 03:42:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bl6yCfQJE+Yv for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 03:42:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D789C86650
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 03:42:11 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id m6so5701342wrn.0
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 20:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gEP+l6VmZ2AQhT9y6MxnJyCmEVijpcWpEhbN/rykvcE=;
 b=CWrOGraZ3/zNXixoJEwLA3hwBYU2PWVJEJ6ylxVJux52OFGXCCNEGTUhC6mkNsNKpA
 i1TXATaF9rTSGwMaVqrUu1Zz/Y1O9y1drCGCIQXqHRHg9tOaU+j7fvsU/CuvZxVlMMw5
 jVxSR6ue24PPOYOWBejC9MloKJqqT/iDlRnzo7+6cRlhm0s17nQW9Gh2F7FrU9ZfvUxp
 kAj8AgciZRjeU/IJPsUe/joigfP+Mc6xw8KC+pdmtDdlV3fkmAR0oIVELnk2GPlk1ru0
 iqtKfLijhcQEQ37e9PwlNuKupuMgl1u6xVjd2ZRO3vozd8LXzB4Mr45MwWeEmJ4j6Osg
 kkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gEP+l6VmZ2AQhT9y6MxnJyCmEVijpcWpEhbN/rykvcE=;
 b=E1INYBPPqgFtEMq+xsxbLbEpfDdgcrtgyOfw9aO0k9eq5JGB8EyP1YaKZgCAcTkH9G
 4LpvARWScDB7+3Z5CjUTLIRlaM4ujC3Whh8hGqBhFP9rGbcJx0vXAGpN9TWc1b5zg0/b
 2AJvpXCNacacijK7nq/eIMECTifIlmuAvqoTvu7FADttYNkmlWHPIKWGF5u1UM0fvgBM
 6dH30KdcOE1sQZCzfw+9zaP/66LaPnkWxBzfpg5FPZSIjy9HFI9LnFi3tvuwsEID0goS
 w2915co26zFtbsJrWwV2HthymjQc5XN34Pw2YjjUad85RMghhi8rC6hEIwKzBC6RFNsF
 3Cgg==
X-Gm-Message-State: AOAM5339oB8k7tpwtl53vWggEShSCf9XvtwOPzZ4afalQOK2oGRZ5t7e
 kLLDN4sbwILSRvRS/2IaCB42jctjm8+DPvNpDxA=
X-Google-Smtp-Source: ABdhPJyAYV0Dm0qLaL1mXbuG+PPAW1SP8BjwTCx+mqZtIG0Clr3g+Jy+4HR4m6cw7nu44h9gRxaSIWDuskrjmVwm3j8=
X-Received: by 2002:adf:e6c7:: with SMTP id y7mr4030589wrm.147.1598931729990; 
 Mon, 31 Aug 2020 20:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200814024114.1177553-2-robdclark@gmail.com> <20200901023517.GA54956@uller>
In-Reply-To: <20200901023517.GA54956@uller>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 31 Aug 2020 20:42:57 -0700
Message-ID: <CAF6AEGsx5mmUCuNApP692L-rS3wEbn4UqJBXuSr-38MAcVfoBw@mail.gmail.com>
Subject: Re: [PATCH 01/19] drm/msm: remove dangling submitqueue references
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Clark <robdclark@chromium.org>,
 open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Will Deacon <will@kernel.org>, David Airlie <airlied@linux.ie>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Stephen Boyd <swboyd@chromium.org>, Sean Paul <sean@poorly.run>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

On Mon, Aug 31, 2020 at 7:35 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Fri 14 Aug 02:40 UTC 2020, Rob Clark wrote:
>
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Currently it doesn't matter, since we free the ctx immediately.  But
> > when we start refcnt'ing the ctx, we don't want old dangling list
> > entries to hang around.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/msm/msm_submitqueue.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
> > index a1d94be7883a..90c9d84e6155 100644
> > --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> > +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
> > @@ -49,8 +49,10 @@ void msm_submitqueue_close(struct msm_file_private *ctx)
> >        * No lock needed in close and there won't
> >        * be any more user ioctls coming our way
> >        */
> > -     list_for_each_entry_safe(entry, tmp, &ctx->submitqueues, node)
> > +     list_for_each_entry_safe(entry, tmp, &ctx->submitqueues, node) {
> > +             list_del(&entry->node);
>
> If you refcount ctx, what does that do for the entries in the submit
> queue?
>
> "entry" here is kref'ed, but you're popping it off the list regardless
> of the put ends up freeing the object or not - which afaict would mean
> leaking the object.
>

What ends up happening is the submit has reference to submit-queue,
which has reference to the ctx.. the submitqueue could be alive still
pending in-flight submits (in a later patch), but dead from the PoV of
userspace interface.

We aren't relying (or at least aren't in the end, and I *think* I
didn't miss anything in the middle) relying on ctx->submitqueues list
to clean anything up in the end, just track what is still a valid
submitqueue from userspace PoV

BR,
-R

>
> On the other hand, with the current implementation an object with higher
> refcount with adjacent objects of single refcount would end up with
> dangling pointers after the put. So in itself this change seems like a
> net gain, but I'm wondering about the plan described in the commit
> message.
>
> Regards,
> Bjorn
>
> >               msm_submitqueue_put(entry);
> > +     }
> >  }
> >
> >  int msm_submitqueue_create(struct drm_device *drm, struct msm_file_private *ctx,
> > --
> > 2.26.2
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
