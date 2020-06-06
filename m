Return-Path: <SRS0=ipMx=7T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95BFC433DF
	for <iommu@archiver.kernel.org>; Sat,  6 Jun 2020 20:01:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D0FA20663
	for <iommu@archiver.kernel.org>; Sat,  6 Jun 2020 20:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bu5U9oAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0FA20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 008BE2050A;
	Sat,  6 Jun 2020 20:01:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DpFrMAsJ4YlB; Sat,  6 Jun 2020 20:01:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 324D62002C;
	Sat,  6 Jun 2020 20:01:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 231DFC088D;
	Sat,  6 Jun 2020 20:01:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6EB5C016E
 for <iommu@lists.linux-foundation.org>; Sat,  6 Jun 2020 20:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CDB1E8618D
 for <iommu@lists.linux-foundation.org>; Sat,  6 Jun 2020 20:01:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BXmxSjyxkYwf for <iommu@lists.linux-foundation.org>;
 Sat,  6 Jun 2020 20:01:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0C47E86153
 for <iommu@lists.linux-foundation.org>; Sat,  6 Jun 2020 20:01:42 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id m32so5003139ede.8
 for <iommu@lists.linux-foundation.org>; Sat, 06 Jun 2020 13:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gfDYgYWWxAJkhuooZJo8FujLn97cONbso3rrCXc9f20=;
 b=bu5U9oAZ2jARjpmZA6hTFVFeLL7tj7VWCyExyfPooRuVwhvPZbFCNsNmAQsbYUR+RH
 hufagq6aobUco9EOjt6bNN3QWktKTMnigHMAVxR/uihFRfqb2JkYCMfs9Pj5QZpb+IR7
 NiVLOTBGkCGPVtiK7llT82HhjMAXBlqc2gpYTbEEbDrJ0VWf5DQaVSlk1LzWVm1E/Xez
 bMOOZ/Hh/jcq+qEuqwF08Qo2rGg95xROkA93XMrV32GPRvPu7Q015Nb+i4bZAu2xrGnU
 J2fRR9lfLHVX3Zr90OFGlSvw6sJKvaTK1/k94Pf/NB6zyqbT55A0P8IKdKgiw51j+nWu
 eN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gfDYgYWWxAJkhuooZJo8FujLn97cONbso3rrCXc9f20=;
 b=IivoQlJ0wUwf11qy/ZbuIZxFubtZwy3Ph+0rihauk4FVNUSUkASlbqxnWDNM4EhPs8
 eoZomQpRvGLgc+Nu4tALHg0Mj7mRtC+w9W9b0vMhgnO3FBkTNCHFHQhlDLw3sc45zPqW
 2unh0SVBFR0f2Ae2JSvHTHSdn7cHarOYoJtad7um7t5EFKfvX6LZhJJt2apnydVUspQ9
 BQDgq/xHDB1etc5YCBKkQpJ7X2D7PocDxX8E1I/E6SE+ua0O+AGL2VmesLXxXDSl6mpw
 mWNrjtoS++V9ZjSAT84IsWfHZ8tx4BQpfUYZC6yZnirgWPAP6i9lQmEk2MX9oWL0PMeN
 Qvyg==
X-Gm-Message-State: AOAM5326MZO/aiUjf8WKxwswZbYlbWagpBVgVEkOMPLtM2TmqVBSLRQ5
 CNSDJeoCe/eYxkFJXDyt25c3+mlIno843dhvu+U=
X-Google-Smtp-Source: ABdhPJzuK37hwXZ07Js5fDY8Fkv33sx1ZVKV3+QYhH8xXee99VgutbGekCi2YmJBeYfXFRtNbl5FcVF45jO7Uu1jeU8=
X-Received: by 2002:a50:c017:: with SMTP id r23mr15868263edb.120.1591473700459; 
 Sat, 06 Jun 2020 13:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <5a663096b489b86472fe3bfbd5138c411d669bad.camel@perches.com>
In-Reply-To: <5a663096b489b86472fe3bfbd5138c411d669bad.camel@perches.com>
From: Rob Clark <robdclark@gmail.com>
Date: Sat, 6 Jun 2020 13:02:05 -0700
Message-ID: <CAF6AEGsqoei_uDQgNFdRF2ZA47YzWEvV7noVmjxLaa=VB-QL5A@mail.gmail.com>
Subject: Re: [Possible PATCH] iommu/qcom: Change CONFIG_BIG_ENDIAN to
 CONFIG_CPU_BIG_ENDIAN
To: Joe Perches <joe@perches.com>
Cc: Stephen Boyd <sboyd@kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Andy Gross <agross@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
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

On Sat, Jun 6, 2020 at 12:16 PM Joe Perches <joe@perches.com> wrote:
>
> CONFIG_BIG_ENDIAN does not exist as a Kconfig symbol.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>
> I don't have the hardware, so I can't tell if this is a
> correct change, but it is a logical one.

I'm not sure *anyone* has a working snapdragon big-endian setup these
days.. sboyd used to tinker with that ages ago.

But, SCTLR.E is the bit to set for big-endian, so this looks like the
right thing to do.

Reviewed-by: Rob Clark <robdclark@gmail.com>

> Found by a test script that looks for IS_ENABLED(FOO)
> where FOO must also exist in Kconfig files.
>
>  drivers/iommu/qcom_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> index c3e1fbd1988c..69e113471ecb 100644
> --- a/drivers/iommu/qcom_iommu.c
> +++ b/drivers/iommu/qcom_iommu.c
> @@ -304,7 +304,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
>                       ARM_SMMU_SCTLR_M | ARM_SMMU_SCTLR_S1_ASIDPNE |
>                       ARM_SMMU_SCTLR_CFCFG;
>
> -               if (IS_ENABLED(CONFIG_BIG_ENDIAN))
> +               if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
>                         reg |= ARM_SMMU_SCTLR_E;
>
>                 iommu_writel(ctx, ARM_SMMU_CB_SCTLR, reg);
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
