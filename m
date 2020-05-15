Return-Path: <SRS0=PRYs=65=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AE5C433E0
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 19:06:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E66BE20727
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 19:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bMZEoYev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66BE20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7491A87201;
	Fri, 15 May 2020 19:06:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YkoXRygL0J7i; Fri, 15 May 2020 19:06:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D459B87BED;
	Fri, 15 May 2020 19:06:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C52BAC0859;
	Fri, 15 May 2020 19:06:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DA30C016F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 19:05:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5200D227C4
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 19:05:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Em0fN38cAtO8 for <iommu@lists.linux-foundation.org>;
 Fri, 15 May 2020 19:05:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-vs1-f67.google.com (mail-vs1-f67.google.com
 [209.85.217.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 9C0B1204A3
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 19:05:54 +0000 (UTC)
Received: by mail-vs1-f67.google.com with SMTP id g2so1886064vsb.4
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 12:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ILTNxRMhVaU1ppwKtb504YY35g+lEq0QuWy+iVUE2z8=;
 b=bMZEoYevT52u61nJD5we/u1JaG8jzU7khHbEmIItRoRo9c67denAC2dZI5n/GtGcte
 O6CuOaJk4AYaDQX4yq+aRjJIGv63nxepgB4RHH9gODQ+rlXq7MTS7sE4DkPKkJ4+uXL+
 cADO8rOPfT+7ANv5baePtF9UpQd+3uCS40EDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ILTNxRMhVaU1ppwKtb504YY35g+lEq0QuWy+iVUE2z8=;
 b=XDb8CxLI0iLHTvViwVx95NKVFS6jjUGKSRzmeecv/apbMiTdp8WgnMco8YAN0BpMMG
 tqlZOIVA7yR4dkpC37n4OgOK7/wA7Je6p2Tb8wvhqx4GkRycTs2E0vfq60R0B+8Z5WIC
 PWl+2HbrRgPTXfoLOBh2Ewq4saYgzokx8wHdxNLJ4+sR9Ea8eTUVViC9lloBHQfDsIQe
 CqTm5TZ3ia4gCcb3NwEpHbJIIWnWtxK5NDcVgYfxxGRDUDAnPhNY//AksLhR9Js0lh2J
 r7oMnK+gGQ71ChoV59YaBm6jgkhko2x6jSDM/NcFpg6BpgPgDaSt5BwVh6Y89T2DBg5E
 EgOQ==
X-Gm-Message-State: AOAM5303PzdZn/5tVNnk+yN4Lb2QC7gnoaFAf+qY2GLURhc/KoXU7Gqv
 +jFeFXHKkfV48bm4HohbNv7oNcIW5C0=
X-Google-Smtp-Source: ABdhPJyP9oVnl0bThzSM098yzemqxYtmLB/MWLW7SWuvowTIK2kwcuUTN3iPvoNd9USz8P5ix3bSaQ==
X-Received: by 2002:a67:2e45:: with SMTP id u66mr3922050vsu.178.1589569553175; 
 Fri, 15 May 2020 12:05:53 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com.
 [209.85.217.43])
 by smtp.gmail.com with ESMTPSA id s130sm807802vka.17.2020.05.15.12.05.51
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 12:05:52 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id g2so1885997vsb.4
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 12:05:51 -0700 (PDT)
X-Received: by 2002:a67:bd07:: with SMTP id y7mr3909984vsq.109.1589569551204; 
 Fri, 15 May 2020 12:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <1588329036-18732-1-git-send-email-smasetty@codeaurora.org>
 <1588329036-18732-2-git-send-email-smasetty@codeaurora.org>
In-Reply-To: <1588329036-18732-2-git-send-email-smasetty@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 15 May 2020 12:05:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WXv9DYf7LWoFBvro=7Bzeb1_0bXAvRH-suzxnrCu+V2A@mail.gmail.com>
Message-ID: <CAD=FV=WXv9DYf7LWoFBvro=7Bzeb1_0bXAvRH-suzxnrCu+V2A@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: arm-smmu: Add sc7180 compatible string
To: Sharat Masetty <smasetty@codeaurora.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Matthias Kaehlcke <mka@chromium.org>, dri-devel@freedesktop.org,
 freedreno <freedreno@lists.freedesktop.org>
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

Hi,

On Fri, May 1, 2020 at 3:30 AM Sharat Masetty <smasetty@codeaurora.org> wrote:
>
> This patch simply adds a new compatible string for SC7180 platform.
>
> Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 6515dbe..986098b 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -28,6 +28,7 @@ properties:
>            - enum:
>                - qcom,msm8996-smmu-v2
>                - qcom,msm8998-smmu-v2
> +              - qcom,sc7180-smmu-v2
>                - qcom,sdm845-smmu-v2
>            - const: qcom,smmu-v2

Is anything blocking this patch from landing now?

-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
