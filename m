Return-Path: <SRS0=hyWy=5E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B54AC4332D
	for <iommu@archiver.kernel.org>; Thu, 19 Mar 2020 15:25:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4647520658
	for <iommu@archiver.kernel.org>; Thu, 19 Mar 2020 15:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xSWwcU1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4647520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0B7DA87EA8;
	Thu, 19 Mar 2020 15:25:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TTJN+Ib6oJUu; Thu, 19 Mar 2020 15:25:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 717B087E97;
	Thu, 19 Mar 2020 15:25:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66337C18DA;
	Thu, 19 Mar 2020 15:25:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59F92C07FF
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 15:25:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 490CD8828E
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 15:25:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r-5Uv+Y1tPx3 for <iommu@lists.linux-foundation.org>;
 Thu, 19 Mar 2020 15:25:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C590788281
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 15:25:01 +0000 (UTC)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com
 [209.85.219.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 78AE720B1F
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 15:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584631501;
 bh=Xe4RFKD4eyCqTEXb3Z+do6asys5ScQi6UXuiuAOgDbQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=xSWwcU1AMk7ym1mW+VY0swBRzWGykIEwrZhaFWQj7TnDZf57zcrjMrORElE+tPq65
 3E/VlLLQYO2HSwLz4GCtDNq4gFBijpiSwVpfbAfgc/5kP7O2a3S5W0lhI+8U0Wu+Wm
 67tKixILlz4DBLB0tJZjpH8Di4WrzZBbiHn3T7+Y=
Received: by mail-yb1-f177.google.com with SMTP id q11so475529ybm.6
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 08:25:01 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1YIwtT/jgZ2DRASz1TSHtzG0hOA1eoi5iKVEG6OXfLxxuliHUE
 QJBqwmXwKPksZs4at68p/xeNRsPUZV1nV5jqOA==
X-Google-Smtp-Source: ADFU+vt6KNn3hMjhQ+yFcZFxiLcwKK2nQbVMZf+iW6Y4/QRvUWdyjDQmDvq9gH8i3wNmX645jChl/2rD0UuU1RoVe0Q=
X-Received: by 2002:a25:3612:: with SMTP id d18mr6134924yba.472.1584631500676; 
 Thu, 19 Mar 2020 08:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200224223129.1068-1-robh@kernel.org>
 <20200318221926.GA10097@willie-the-truck>
In-Reply-To: <20200318221926.GA10097@willie-the-truck>
From: Rob Herring <robh@kernel.org>
Date: Thu, 19 Mar 2020 09:24:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLJukKY0h1GVd_fZLC=JUw4bwi_GyxF1GHYPiA_Q1pRFA@mail.gmail.com>
Message-ID: <CAL_JsqLJukKY0h1GVd_fZLC=JUw4bwi_GyxF1GHYPiA_Q1pRFA@mail.gmail.com>
Subject: Re: [PATCH v3] iommu/arm-smmu-v3: Add SMMUv3.2 range invalidation
 support
To: Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
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

On Wed, Mar 18, 2020 at 4:19 PM Will Deacon <will@kernel.org> wrote:
>
> Hi Rob,
>
> On Mon, Feb 24, 2020 at 04:31:29PM -0600, Rob Herring wrote:
> > Arm SMMUv3.2 adds support for TLB range invalidate operations.
> > Support for range invalidate is determined by the RIL bit in the IDR3
> > register.
> >
> > The range invalidate is in units of the leaf page size and operates on
> > 1-32 chunks of a power of 2 multiple pages. First, we determine from the
> > size what power of 2 multiple we can use. Then we calculate how many
> > chunks (1-31) of the power of 2 size for the range on the iteration. On
> > each iteration, we move up in size by at least 5 bits.
> >
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v3:
> > - Use inv_range local instead of modifying granule
> > - Simplify the TG calculation
> > - Use shift instead of divide by power of 2.
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 69 +++++++++++++++++++++++++++++++++++--
> >  1 file changed, 67 insertions(+), 2 deletions(-)
>
> I've queued this one, but I had to resolve some conflicts with the command
> queue batching changes, so please can you take a quick look at my
> resolution?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=for-joerg/arm-smmu/updates

Thanks, LGTM.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
