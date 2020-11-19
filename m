Return-Path: <SRS0=wYjh=EZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C67DC56201
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 19:34:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD0922201
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 19:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BNEHy/43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD0922201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3EAED2746F;
	Thu, 19 Nov 2020 19:34:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g4mZvXsCJCzi; Thu, 19 Nov 2020 19:34:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E9251203FC;
	Thu, 19 Nov 2020 19:34:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3DB9C163C;
	Thu, 19 Nov 2020 19:34:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38A51C0891
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 19:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 293078749C
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 19:34:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Z6yQDlP-yDN for <iommu@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 19:34:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 648B487498
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 19:34:37 +0000 (UTC)
Received: by mail-oi1-f195.google.com with SMTP id j15so2297401oih.4
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 11:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ini9fyEBuHieS2TeRenH8PBPd1ECjmGWhL22ljl8/DA=;
 b=BNEHy/43LYzlP4L5fYi9Rcak3Zh9nsqiweTIIqGxTizitmAgjX/HpVKn5+gJ+VcMqQ
 EZv3buIWPOvbbXlkEMKU8lEUzYz5Kuh/zuFT+6SQqWYU5PNyxv4JDgHUOQNvEnKyztyf
 Luvuu8EcBTrXjuCi0zpz5SM7+xqrqETHkqQjuSk0z0aIPRK1rQDzRqQP9Bwg9JthIRTa
 gNxrW1uvZi0YUiy/4hUskZfwmUNojZAA5VfKJ9kwaTRRX35Fa+eiOXMp1FFcjN/EBzh0
 7eRhodQGqhGACZIY5zBHL2XK/yDehcxySVvHAJGXfjJpWSDjKJZqcPauNJkLEEEbxR1t
 4/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ini9fyEBuHieS2TeRenH8PBPd1ECjmGWhL22ljl8/DA=;
 b=cRFPhblSDCsrKrBwVIyTHnoLUKSrPeJSbfKpI2+d7LsYFLneeT8QI8IDEpgh/o+Q0U
 X7dINC91QHuz8be3wQHkV75HAg/aGk6hVgckGONTRKmTjMj1FH0bOirkcQIkT14p1W3D
 6cSVxRGoCdUF11iFMWl4K8lAn9BFTOWPso6sFfhhXVQpLtp/9r+C/NbaVUnbX2jW0D/E
 rSICKLS/upv23nSMdxld5RkFJprNL0+r4sEFLw5PPICE42wcJaXUQDQScEUEQiSwNyKe
 0YFTQHU0haTtLVpFAgZnVU2doqTH7cVQXH9YvlPSZSm4z3MVqGeoqI35MLdjBT/jrghC
 R8Lg==
X-Gm-Message-State: AOAM531rScR2/JQI4okqOQuspbcQL+uknvmaj5I4yqka9x9Jk84lYaJR
 6v8qb1WcJ1awBBuaMdxKOEbI6yes8D/NM3WBhC9UVA==
X-Google-Smtp-Source: ABdhPJw+yUD5lftmKr7oFPOZJ7k7sTngPRGZsXcSNFFYd0zIa6SCobdVOlJwKO/uyOUO+XMpr/9zwwjPldoIXVyO1Dk=
X-Received: by 2002:aca:c3d6:: with SMTP id t205mr4059105oif.10.1605814476585; 
 Thu, 19 Nov 2020 11:34:36 -0800 (PST)
MIME-Version: 1.0
References: <20201119174149.3860883-1-thierry.reding@gmail.com>
In-Reply-To: <20201119174149.3860883-1-thierry.reding@gmail.com>
From: John Stultz <john.stultz@linaro.org>
Date: Thu, 19 Nov 2020 11:34:24 -0800
Message-ID: <CALAqxLUPXZ1qCU9KEt=0wACSzPyF4SRraiqcPh1kFwPHED2kRQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module"
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Jon Hunter <jonathanh@nvidia.com>
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

On Thu, Nov 19, 2020 at 9:41 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> Commit d0511b5496c0 ("firmware: QCOM_SCM: Allow qcom_scm driver to be
> loadable as a permenent module") causes the ARM SMMU driver to be built
> as a loadable module when using the Aarch64 default configuration. This
> in turn causes problems because if the loadable module is not shipped
> in an initial ramdisk, then the deferred probe timeout mechanism will
> cause all SMMU masters to probe without SMMU support and fall back to
> just plain DMA ops (not IOMMU-backed).
>
> Once the system has mounted the rootfs, the ARM SMMU driver will then
> be loaded, but since the ARM SMMU driver faults by default, this causes
> a slew of SMMU faults for the SMMU masters that have already been set
> up with plain DMA ops and cause these devices to malfunction.
>
> Revert that commit to unbreak things while we look for an alternative
> solution.
>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Acked-by: John Stultz <john.stultz@linaro.org>

Thanks for sending this Thierry, and sorry again for the troubles.

thanks
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
