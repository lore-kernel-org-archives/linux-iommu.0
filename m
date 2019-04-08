Return-Path: <SRS0=6I1K=SK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE1FC10F14
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 20:09:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9C5C2148E
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 20:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHIoBzR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C5C2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 64E9EAF5;
	Mon,  8 Apr 2019 20:09:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AEE0EAE0
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 20:09:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C04FD7ED
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 20:09:19 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
	[209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 5891E21874
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 20:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554754159;
	bh=ZeEZb1pZ60/ju3r8ey+U+aCL1uve8ZoE5VVj6YTXkKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RHIoBzR/hmqXIub0rFs7OZZiZtzWbEh3HQiZfESsS90nalNFm2skb761XEBDUPego
	52dihXSVbbZghkSZZ0BtzaKJlqZoPDndfZGco1xyQjxn1/4WZJyhLoPr6UvmCBm/mg
	z/C5aly7A2m9qv9ZxKc6k91/gbFEyeszD+6QF7t0=
Received: by mail-qk1-f181.google.com with SMTP id g1so8834155qki.5
	for <iommu@lists.linux-foundation.org>;
	Mon, 08 Apr 2019 13:09:19 -0700 (PDT)
X-Gm-Message-State: APjAAAXz/TiHer8ib5kPJmebO+a5y27XnOgbX3akNC/tR2ArMVFaZRgm
	YEOcxX27AMZJB23Ywjtxkcs/++Bt0iOkQbUrOA==
X-Google-Smtp-Source: APXvYqxOjr0OFjB/wBPjDGtGO4BoLY0cK9Ay4jl8gbII/gNM/CbQKHyXwawPyafDOnZV7e2zPTaBCrwB7Clj34gPL/k=
X-Received: by 2002:a37:6441:: with SMTP id y62mr24011951qkb.158.1554754158515;
	Mon, 08 Apr 2019 13:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190401074730.12241-1-robh@kernel.org>
	<20190401074730.12241-3-robh@kernel.org>
	<CAKMK7uE7-XV3cZxS8GT_EDa7yojOLPQi+LqkF85h_0z_JL6gYw@mail.gmail.com>
	<155412649586.24691.809508732198367112@skylake-alporthouse-com>
	<8736n120jw.fsf@anholt.net>
In-Reply-To: <8736n120jw.fsf@anholt.net>
From: Rob Herring <robh@kernel.org>
Date: Mon, 8 Apr 2019 15:09:06 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+So-kadir8o8T-YNYkfOYD8vopAS3UWGbSdRVLjH_JGQ@mail.gmail.com>
Message-ID:
 <CAL_Jsq+So-kadir8o8T-YNYkfOYD8vopAS3UWGbSdRVLjH_JGQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm: Add a drm_gem_objects_lookup helper
To: Eric Anholt <eric@anholt.net>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	Sean Paul <sean@poorly.run>, Will Deacon <will.deacon@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Chris Wilson <chris@chris-wilson.co.uk>, David Airlie <airlied@linux.ie>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Daniel Vetter <daniel@ffwll.ch>,
	Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190408200906.Jih5uAUcOEXQlh5hUDy0t0X2E7N6R0C56cgaWwrvGWw@z>

On Mon, Apr 1, 2019 at 10:43 AM Eric Anholt <eric@anholt.net> wrote:
>
> Chris Wilson <chris@chris-wilson.co.uk> writes:
>
> > Quoting Daniel Vetter (2019-04-01 14:06:48)
> >> On Mon, Apr 1, 2019 at 9:47 AM Rob Herring <robh@kernel.org> wrote:
> >> > +{
> >> > +       int i, ret = 0;
> >> > +       struct drm_gem_object *obj;
> >> > +
> >> > +       spin_lock(&filp->table_lock);
> >> > +
> >> > +       for (i = 0; i < count; i++) {
> >> > +               /* Check if we currently have a reference on the object */
> >> > +               obj = idr_find(&filp->object_idr, handle[i]);
> >> > +               if (!obj) {
> >> > +                       ret = -ENOENT;
> >
> > Unwind previous drm_gem_object_get(), the caller has no idea how many
> > were processed before the error.
>
> I had the same thought, but the pattern we have is that you're loading
> into a refcounted struct that will free the BOs when you're done,
> anyway.

The real bug here is if allocation of the array fails. The BO array
may be NULL when the count is not. So this V3D cleanup hunk:

for (i = 0; i < exec->bo_count; i++)
  drm_gem_object_put_unlocked(&exec->bo[i]->base.base);
  kvfree(exec->bo);

Needs to be wrapped with 'if (exec->bo)'. We have a similar problem
with fence arrays too.

Thanks to Steven for noticing this copied code in panfrost.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
