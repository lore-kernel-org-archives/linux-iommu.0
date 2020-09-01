Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3435C433E2
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 05:50:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FAB72087D
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 05:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QfisIazd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FAB72087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6606687033;
	Tue,  1 Sep 2020 05:50:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mcQly-xdxSw5; Tue,  1 Sep 2020 05:50:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C585986FBC;
	Tue,  1 Sep 2020 05:50:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD158C088B;
	Tue,  1 Sep 2020 05:50:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D8F5C0052
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 05:50:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 05BC18702B
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 05:50:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1bHnBUMS7JOL for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 05:50:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 427AF86FBC
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 05:50:46 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id o16so77803pjr.2
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 22:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=iGwUze2oGaJp8e7svDfyTEoxtCcK4dtRTXC+KcGij48=;
 b=QfisIazdqtTMNcoNEj0SZAReR2Pmf9qYrfEfbMonwSdEIA+7Dm9UminlBVvpKsDzQz
 ooApTWc7bJW1z5pJvKoZRm84JVjAFwpEFPLHCpp1LiPVEqCmoZHUb2nULe4GROFMFwoh
 I54TqoMJB0ewdpQDbp9U7wOfPA+BzG4yfQ4f0X35RQOYiAwQVz1FxsJKxf/kh306qN8x
 RwjkLSOhYHvD0QWaRZtJMYYJmaBR7W6HDqzfjOXfTAtuGqCB3Pvhz/h2c8MGfBGJziP9
 SfadU0eVMulNjZHEoD1OQLXkTLzbtdQFdunvmu8vMx2ep20SGcptpomomxA8Vnr57aH1
 5osA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iGwUze2oGaJp8e7svDfyTEoxtCcK4dtRTXC+KcGij48=;
 b=bskboyIHZeV2Kayli9BdSah/wr6+yPsLtdCJ1us4wwA3ofn1nvZr3BCgXLjap14Y8y
 5YNGQS1H58nmJ034kxVmFe59usuoELmFsTw+8RVoutAZZqbi4S7j7yHC3hBxjseHf5ss
 joJiwJB+kUrvmW8LIG1I4haG6Olek7IBh9UhzCSej46nD5XGJDaI1tegHChVDXeqYqhn
 5jpfa67R0+eFB65HvIzYlTYQt86l+12j6704Fx3GI6dP1jR5fHbMjpbLNFGsb+lpoe5i
 PzNwz5aSG9StUJeQszZtNpjS4bkppXpPf20NSbilwE77TbuOybwlLnQkqTCNCqntBjdJ
 5OQA==
X-Gm-Message-State: AOAM530MqVXRLt+rK8NIrT6sEKvtZL2orsS03QCmw0AZ7KLdqt6u4Fwl
 N0WjXsEJY5vhlJ+dv4bnSx8BjClJguQcMg==
X-Google-Smtp-Source: ABdhPJxBeU18wZYbq6a0ep/R0bjilgWJcbebj3mDIgOZ/cwdY+tof6zfyzvZNJhxFh1hmNJtAPCKEQ==
X-Received: by 2002:a0c:ca87:: with SMTP id a7mr330935qvk.17.1598938949857;
 Mon, 31 Aug 2020 22:42:29 -0700 (PDT)
Received: from uller (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
 by smtp.gmail.com with ESMTPSA id o25sm346909qkm.42.2020.08.31.22.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 22:42:29 -0700 (PDT)
Date: Tue, 1 Sep 2020 05:42:27 +0000
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 01/19] drm/msm: remove dangling submitqueue references
Message-ID: <20200901054227.GB54956@uller>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200814024114.1177553-2-robdclark@gmail.com>
 <20200901023517.GA54956@uller>
 <CAF6AEGsx5mmUCuNApP692L-rS3wEbn4UqJBXuSr-38MAcVfoBw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF6AEGsx5mmUCuNApP692L-rS3wEbn4UqJBXuSr-38MAcVfoBw@mail.gmail.com>
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

On Tue 01 Sep 03:42 UTC 2020, Rob Clark wrote:

> On Mon, Aug 31, 2020 at 7:35 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Fri 14 Aug 02:40 UTC 2020, Rob Clark wrote:
> >
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > Currently it doesn't matter, since we free the ctx immediately.  But
> > > when we start refcnt'ing the ctx, we don't want old dangling list
> > > entries to hang around.
> > >
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > >  drivers/gpu/drm/msm/msm_submitqueue.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
> > > index a1d94be7883a..90c9d84e6155 100644
> > > --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> > > +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
> > > @@ -49,8 +49,10 @@ void msm_submitqueue_close(struct msm_file_private *ctx)
> > >        * No lock needed in close and there won't
> > >        * be any more user ioctls coming our way
> > >        */
> > > -     list_for_each_entry_safe(entry, tmp, &ctx->submitqueues, node)
> > > +     list_for_each_entry_safe(entry, tmp, &ctx->submitqueues, node) {
> > > +             list_del(&entry->node);
> >
> > If you refcount ctx, what does that do for the entries in the submit
> > queue?
> >
> > "entry" here is kref'ed, but you're popping it off the list regardless
> > of the put ends up freeing the object or not - which afaict would mean
> > leaking the object.
> >
> 
> What ends up happening is the submit has reference to submit-queue,
> which has reference to the ctx.. the submitqueue could be alive still
> pending in-flight submits (in a later patch), but dead from the PoV of
> userspace interface.
> 
> We aren't relying (or at least aren't in the end, and I *think* I
> didn't miss anything in the middle) relying on ctx->submitqueues list
> to clean anything up in the end, just track what is still a valid
> submitqueue from userspace PoV
> 

Looks reasonable, thanks for the explanation.

> BR,
> -R
> 
> >
> > On the other hand, with the current implementation an object with higher
> > refcount with adjacent objects of single refcount would end up with
> > dangling pointers after the put. So in itself this change seems like a
> > net gain, but I'm wondering about the plan described in the commit
> > message.
> >
> > Regards,
> > Bjorn
> >
> > >               msm_submitqueue_put(entry);
> > > +     }
> > >  }
> > >
> > >  int msm_submitqueue_create(struct drm_device *drm, struct msm_file_private *ctx,
> > > --
> > > 2.26.2
> > >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
