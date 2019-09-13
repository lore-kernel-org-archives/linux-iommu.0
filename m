Return-Path: <SRS0=dyvA=XI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1C9C49ED7
	for <iommu@archiver.kernel.org>; Fri, 13 Sep 2019 22:44:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A0D2089F
	for <iommu@archiver.kernel.org>; Fri, 13 Sep 2019 22:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LDBYFek1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A0D2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7C101D83;
	Fri, 13 Sep 2019 22:44:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0F61AD4A
	for <iommu@lists.linux-foundation.org>;
	Fri, 13 Sep 2019 22:44:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
	[209.85.166.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 855C081A
	for <iommu@lists.linux-foundation.org>;
	Fri, 13 Sep 2019 22:44:29 +0000 (UTC)
Received: by mail-io1-f65.google.com with SMTP id r26so65955238ioh.8
	for <iommu@lists.linux-foundation.org>;
	Fri, 13 Sep 2019 15:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=iZvFCpWMi0dDeMT1aWsD1WV44I02N4our5N95iPWEjI=;
	b=LDBYFek1n3fYD1r8PdyfPdcnTh9MaOT71Jj5+kCVcQRn4sBsJs5zvLnwi+5E0cjLMf
	72n4nCQwMJf7+QSaU2DgfLEmqi8G7Gu7KtCf7RflIUvS/cpVcLkwld2mfM81otbO/AVm
	8Zkx8v6Qm34iUfeSGrR/st1V+2bVnm3ZGMb9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=iZvFCpWMi0dDeMT1aWsD1WV44I02N4our5N95iPWEjI=;
	b=dki4f1if3kisk/DLNgHrfIKJVDbeRdX2e0rP1EOMq+zPbGYeARos8Sw20AM0arU26v
	h7gbpetGNDPDY/yZCwMzhCr08zLP7Yfd1QVVOKJYiKxC4qLhrmYmWpAZPQ3wzPjPp6io
	2EJSLbxmAA1JnWcZ0jq4OkeLimivAjc+2ExlisqknXebX1OTcgE+HdA9c1S7VDedEtUI
	Ef+flDYDO8N6EfWH9YDwc4Ux9avChqdhamP0ZJGSFbYQjsXU7Lvpr3If2UHoBoNccS6N
	Qq10l5G7xEyKnX5aRieMc1XEonGIeDtSbO2FrXMsea6r6HCg5JtPCZBaaUzRG1VT1QvE
	MHsg==
X-Gm-Message-State: APjAAAVHLORjSP0cW+nwiX+KkaN8bopQlpX9+8ngZoihhgCVb0nb7vCk
	ClxShyS+xua4WjNvOT9LM7AjmAVFqsI=
X-Google-Smtp-Source: APXvYqxCNQ0Mlv7ZzCzZrA8MMHMEue9UT/QRvD6DPj46rYbNeGqrWlX//KlIB8azIeFn4FLr/bg0Jg==
X-Received: by 2002:a6b:b8c3:: with SMTP id i186mr2729469iof.194.1568414667801;
	Fri, 13 Sep 2019 15:44:27 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com.
	[209.85.166.47])
	by smtp.gmail.com with ESMTPSA id i2sm7258297iom.68.2019.09.13.15.44.24
	for <iommu@lists.linux-foundation.org>
	(version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
	Fri, 13 Sep 2019 15:44:26 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id r8so41118998iol.10
	for <iommu@lists.linux-foundation.org>;
	Fri, 13 Sep 2019 15:44:24 -0700 (PDT)
X-Received: by 2002:a05:6638:155:: with SMTP id
	y21mr1214254jao.112.1568414664348; 
	Fri, 13 Sep 2019 15:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <2762ffd4c196dc91d62e10eb8b753f256ea9b629.1568375317.git.robin.murphy@arm.com>
In-Reply-To: <2762ffd4c196dc91d62e10eb8b753f256ea9b629.1568375317.git.robin.murphy@arm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 13 Sep 2019 15:44:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XPi+DCwg2DWbZkXQGTpxWy=vWa1LQR=zHZr93WKjCmzA@mail.gmail.com>
Message-ID: <CAD=FV=XPi+DCwg2DWbZkXQGTpxWy=vWa1LQR=zHZr93WKjCmzA@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Report USF more clearly
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi,

On Fri, Sep 13, 2019 at 4:48 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Although CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT is a welcome tool
> for smoking out inadequate firmware, the failure mode is non-obvious
> and can be confusing for end users. Add some special-case reporting of
> Unidentified Stream Faults to help clarify this particular symptom.
>
> CC: Douglas Anderson <dianders@chromium.org>

nit that I believe that "Cc" (lowercase 2nd c) is correct.

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu.c | 5 +++++
>  drivers/iommu/arm-smmu.h | 2 ++
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index b7cf24402a94..76ac8c180695 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -499,6 +499,11 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
>         dev_err_ratelimited(smmu->dev,
>                 "\tGFSR 0x%08x, GFSYNR0 0x%08x, GFSYNR1 0x%08x, GFSYNR2 0x%08x\n",
>                 gfsr, gfsynr0, gfsynr1, gfsynr2);
> +       if (IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT) &&
> +           (gfsr & sGFSR_USF))
> +               dev_err_ratelimited(smmu->dev,
> +                       "Stream ID %hu may not be described by firmware, try booting with \"arm-smmu.disable_bypass=0\"\n",
> +                       (u16)gfsynr1);

In general it seems like a sane idea to surface an error like this.  I
guess a few nits:

1. "By firmware" might be a bit misleading.  In most cases I'm aware
of the problem is in the device tree that was bundled together with
the kernel.  If there are actually cases where firmware has baked in a
device tree and it got this wrong then we might want to spend time
figuring out what to do about it.

2. Presumably booting with "arm-smmu.disable_bypass=0" is in most
cases the least desirable option available.  I always consider kernel
command line parameters as something of a last resort for
configuration and would only be something that and end user might do
if they were given a kernel compiled by someone else (like if someone
where taking a prebuilt Linux distro and trying to install it onto a
generic PC).  Are you seeing cases where this is happening?  If people
are compiling their own kernel I'd argue that telling them to set
"CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT" to "no" is much better
than trying to jam a command line option on.  Command line options
don't scale well.

3. Any chance you could make it more obvious that this change is
undesirable and a last resort?  AKA:

"Stream ID x blocked for security reasons; allow anyway by booting
with arm-smmu.disable_bypass=0"

-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
