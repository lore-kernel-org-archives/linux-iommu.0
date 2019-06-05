Return-Path: <SRS0=DEPd=UE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E80C28CC5
	for <iommu@archiver.kernel.org>; Wed,  5 Jun 2019 14:17:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDA520883
	for <iommu@archiver.kernel.org>; Wed,  5 Jun 2019 14:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvxtMTCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDA520883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0BA47CBA;
	Wed,  5 Jun 2019 14:17:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 31E3FCAF
	for <iommu@lists.linux-foundation.org>;
	Wed,  5 Jun 2019 14:17:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
	[209.85.208.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A59074C3
	for <iommu@lists.linux-foundation.org>;
	Wed,  5 Jun 2019 14:17:07 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id h10so5978962edi.13
	for <iommu@lists.linux-foundation.org>;
	Wed, 05 Jun 2019 07:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=DYFO74imdmleJLw5lYkuA6kO6lk6BDNzHYqBpZMjZ8s=;
	b=kvxtMTCZdYLS36jfstozpuwwHILmf0b2bvAMNZXohkogm+c2hPkV+4Z95BmSa+Iqxh
	ZVGQ9C767Mwx8Ubqg7OXp4cc5CZA5jSH642GgtyyWORUHyEr1yHfT+o5w1ktS+0B1E2k
	VE4Q8MtKaqiEo8ZAclw5warQKFbLbRryMg6MMwGAZdzZ0/aXkoolO6+F5v/FVE8PgoRz
	wjDdu3SfUhW1O6EVCML5GIKEDN1vkOd1YFIkqUl0szkdzv18oI0Pfv/hKcA64SRN4QKq
	RO1JzS9ecXpXP+8nLy05iP+IsEluRraqXvXeKhUhfZOANq+Kntu5MISL4uAXjrVMgbTe
	+6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=DYFO74imdmleJLw5lYkuA6kO6lk6BDNzHYqBpZMjZ8s=;
	b=atjNBLaSzAdp1fBwde7bBJCb9Xh/mUdWgu5bu1/Xxiu05nBpzUhkq7cXqLQWDSFRU8
	zV1Y3JmzC6csgCVCRuLth1JEnymf9swfJt9GvxemLevMJn/aNVxO7ir/J9TJ5QXFsv2X
	a6xLLWCu5uORldLjl6gyw07699lrQKke6Xb2O2i3MgSGFtXl1qW+yk7zjTUh3kRhHjY/
	kS3M7UL3yBPmxFOpzBn758bqVqXMLntIL4+ghcp6D56vv5YHovUNEMOiuT87HTSLfboM
	4ft5LVml/eKR94oG4zXmH8zDM3oHTAcqhy/syce8wR4PHU0xwHxA3J2KgPcES+RsIG+z
	9RSw==
X-Gm-Message-State: APjAAAUq+cZ04My/Ln963HuKn85EzQXNfW7wEOk8ZFqVau8ATW6FuxYa
	BsdkPq1WPLO8I9jx/DRH+05Uh1q9bJGzPovr7LM=
X-Google-Smtp-Source: APXvYqz++haK8phyFHbXw+7xx+j+S+xiNW3yfgGMolbWak16tppAeVvpIviRn0GFGAEATK3z185Rfr0/uCa7tvr7S5E=
X-Received: by 2002:a17:906:2ada:: with SMTP id
	m26mr8080786eje.265.1559744226214; 
	Wed, 05 Jun 2019 07:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181201165348.24140-1-robdclark@gmail.com>
	<CAL_JsqJmPqis46Un91QyhXgdrVtfATMP_hTp6wSeSAfc8MLFfw@mail.gmail.com>
	<CAF6AEGs9Nsft8ofZkGz_yWBPBC+prh8dBSkJ4PJr8yk2c5FMdQ@mail.gmail.com>
	<CAF6AEGt-dhbQS5zZCNVTLT57OiUwO0RiP5bawTSu2RKZ-7W-aw@mail.gmail.com>
	<CAAFQd5BdrJFL5LKK8O5NPDKWfFgkTX_JU-jU3giEz33tj-jwCA@mail.gmail.com>
	<CAF6AEGtj+kyXqKeJK2-0e1jw_A4wz-yBEyv5zhf5Vfoi2_p2CA@mail.gmail.com>
	<CAAFQd5Dmr+xyd4dyc_44vJFpNpwK6+MgG+ensoey59HgbxXV6g@mail.gmail.com>
	<CGME20190605125734epcas1p43b15cc8c556d917ca71b561791861cec@epcas1p4.samsung.com>
	<CAF6AEGuj=QmEWZVzHMtoDgO0M0t-W9+tay5F4AKYThZqy=nkdA@mail.gmail.com>
	<95d6e963-7f30-1d9c-99d7-0f6cc1589997@samsung.com>
In-Reply-To: <95d6e963-7f30-1d9c-99d7-0f6cc1589997@samsung.com>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 5 Jun 2019 07:16:51 -0700
Message-ID: <CAF6AEGtb1t4oRXCVvZq_cq1vZCJhgok-Ha+FXrruOOCq4APY_Q@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH] of/device: add blacklist for iommu dma_ops
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
	freedreno <freedreno@lists.freedesktop.org>,
	Will Deacon <will.deacon@arm.com>, Doug Anderson <dianders@chromium.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Rob Herring <robh+dt@kernel.org>, Sean Paul <seanpaul@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, Christoph Hellwig <hch@lst.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
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

On Wed, Jun 5, 2019 at 6:18 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Rob,
>
> On 2019-06-05 14:57, Rob Clark wrote:
> > On Tue, Jun 4, 2019 at 11:58 PM Tomasz Figa <tfiga@chromium.org> wrote:
> >> But first of all, I remember Marek already submitted some patches long
> >> ago that extended struct driver with some flag that means that the
> >> driver doesn't want the IOMMU to be attached before probe. Why
> >> wouldn't that work? Sounds like a perfect opt-out solution.
> > Actually, yeah.. we should do that.  That is the simplest solution.
>
> Tomasz has very good memory. It took me a while to find that old patches:
>
> https://patchwork.kernel.org/patch/4677251/
> https://patchwork.kernel.org/patch/4677941/
> https://patchwork.kernel.org/patch/4677401/
>
> It looks that my idea was a bit ahead of its time ;)
>

if I re-spin this, was their a reason not to just use bitfields, ie:

-    bool suppress_bind_attrs;    /* disables bind/unbind via sysfs */
+    bool suppress_bind_attrs : 1;    /* disables bind/unbind via sysfs */
+    bool has_own_iommu_manager : 1;  /* driver explictly manages IOMMU */

That seems like it would have been a bit less churn and a bit nicer
looking (IMO at least)

BR,
-R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
