Return-Path: <SRS0=m6Z5=YW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF73C47E49
	for <iommu@archiver.kernel.org>; Tue, 29 Oct 2019 07:42:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4492520717
	for <iommu@archiver.kernel.org>; Tue, 29 Oct 2019 07:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KOtAhmLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4492520717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 06B13E7F;
	Tue, 29 Oct 2019 07:42:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 93EFAAD0
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 22:38:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
	[209.85.166.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 25DD842D
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 22:38:16 +0000 (UTC)
Received: by mail-il1-f194.google.com with SMTP id s75so9658633ilc.3
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 15:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=1pqft6NUgSGPSsYgTI6KAW/EqfWsmOX+X7GP8nWIKRQ=;
	b=KOtAhmLxM5DZQvf2Ll3f33KbklGMeTG2PKDxS+jixVpbEYv/r2fkX8rWW/POBAh8EZ
	bhaa9F6E4wiUOAv7xzTF/OPYtmaoF81sAIOIN1D7uz2hMlzRn/GbsAID1pmlxlh0ULbu
	KCWrpiKfUYuFXj/u1i4vCnm4AsCswlKrH1PH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=1pqft6NUgSGPSsYgTI6KAW/EqfWsmOX+X7GP8nWIKRQ=;
	b=iM9yyEQKnry+MdhS9WCuHNqSqKpIw809CxfWLb6kykvrilY8g3HNJftLthQVFJiuyy
	BCQXgZD0B3UpHazpdWIW5DXPjLY+7RtDjT8AO/sBAumzrZ5bE3Go+25X2HBq5+U5eJfA
	fZz9EhWOmDFsp99LVrTXNmAom7iSLfawJacGmq/u9anRGbHs0qhgq7tkKd3Af8EDcF4+
	y2tGV8pAs27xQsLSBXr4GFsS+krXmUnr6SXp+aKTugceAyGkpIZ0LRRgpVMFYqfN4q8w
	kErpgXbJDMCLY3Nqqd+hSj2uE4krpRo4Z3yGRKeZVDyAcC6yDu60UKL6g11fpjjumVDO
	Pemw==
X-Gm-Message-State: APjAAAWWJ2f6MI9ie8Bo/RtkvGIm+tQc6SIttJcqOx3wfgt/hZx2meAo
	CkWvUdmjzjux8eQyoW/QNYhr4KVkw9yxdM1VB//OZg==
X-Google-Smtp-Source: APXvYqzOjbPZql47NIkJK7AmtptD85c0h2swAJ0981IFdP5pW7aIvp/4iQe9Q33o2yPDwnBDa7OGwzugpAmPA0ld6FE=
X-Received: by 2002:a92:6e0a:: with SMTP id j10mr5422292ilc.26.1572302295420; 
	Mon, 28 Oct 2019 15:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <418d8426-f299-1269-2b2e-f86677cf22c2@arm.com>
	<20191007204906.19571-1-robdclark@gmail.com>
	<20191028222042.GB8532@willie-the-truck>
In-Reply-To: <20191028222042.GB8532@willie-the-truck>
From: Rob Clark <robdclark@chromium.org>
Date: Mon, 28 Oct 2019 15:38:04 -0700
Message-ID: <CAJs_Fx7zRWsTPiAg0PFt+8nJPpHpzSkxW6XMMJwozVO6vyB78A@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/arm-smmu: fix "hang" when games exit
To: Will Deacon <will@kernel.org>
X-Mailman-Approved-At: Tue, 29 Oct 2019 07:42:33 +0000
Cc: freedreno <freedreno@lists.freedesktop.org>,
	iommu@lists.linux-foundation.org, open list <linux-kernel@vger.kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, "moderated list:ARM SMMU DRIVERS"
	<linux-arm-kernel@lists.infradead.org>
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

On Mon, Oct 28, 2019 at 3:20 PM Will Deacon <will@kernel.org> wrote:
>
> Hi Rob,
>
> On Mon, Oct 07, 2019 at 01:49:06PM -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > When games, browser, or anything using a lot of GPU buffers exits, there
> > can be many hundreds or thousands of buffers to unmap and free.  If the
> > GPU is otherwise suspended, this can cause arm-smmu to resume/suspend
> > for each buffer, resulting 5-10 seconds worth of reprogramming the
> > context bank (arm_smmu_write_context_bank()/arm_smmu_write_s2cr()/etc).
> > To the user it would appear that the system just locked up.
> >
> > A simple solution is to use pm_runtime_put_autosuspend() instead, so we
> > don't immediately suspend the SMMU device.
>
> Please can you reword the subject to be a bit more useful? The commit
> message is great, but the subject is a bit like "fix bug in code" to me.

yeah, not the best $subject, but I wasn't quite sure how to fit
something better in a reasonable # of chars.. maybe something like:
"iommu/arm-smmu: optimize unmap but avoiding toggling runpm state"?

BR,
-R


>
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> > v1: original
> > v2: unconditionally use autosuspend, rather than deciding based on what
> >     consumer does
> >
> >  drivers/iommu/arm-smmu.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 3f1d55fb43c4..b7b41f5001bc 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -289,7 +289,7 @@ static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
> >  static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
> >  {
> >       if (pm_runtime_enabled(smmu->dev))
> > -             pm_runtime_put(smmu->dev);
> > +             pm_runtime_put_autosuspend(smmu->dev);
> >  }
> >
> >  static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
> > @@ -1445,6 +1445,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >       /* Looks ok, so add the device to the domain */
> >       ret = arm_smmu_domain_add_master(smmu_domain, fwspec);
>
> Please can you put a comment here explaining what this is doing? An abridged
> version of the commit message is fine.
>
> > +     pm_runtime_set_autosuspend_delay(smmu->dev, 20);
> > +     pm_runtime_use_autosuspend(smmu->dev);
>
> Cheers,
>
> Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
