Return-Path: <SRS0=X07A=AC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E097C433E0
	for <iommu@archiver.kernel.org>; Sun, 21 Jun 2020 20:20:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B234C21532
	for <iommu@archiver.kernel.org>; Sun, 21 Jun 2020 20:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="p8GqvDhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B234C21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7704486AC8;
	Sun, 21 Jun 2020 20:20:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NR-ieZIp-_ve; Sun, 21 Jun 2020 20:20:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 72EAE868E4;
	Sun, 21 Jun 2020 20:20:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58B25C0891;
	Sun, 21 Jun 2020 20:20:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D0F5C016F
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 20:20:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1342A888FA
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 20:20:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x7bTd4GUjTM4 for <iommu@lists.linux-foundation.org>;
 Sun, 21 Jun 2020 20:20:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4D60B888F6
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 20:20:37 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id h10so7140750pgq.10
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 13:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=LAjnugIsc4VHWdbrPS4xRmq7Vwv6xC2kO9meZ+2Ku74=;
 b=p8GqvDhyZf83WoUCjI4UwDke37CtlmnLL40lIARH49jrrv9ugM7snEa4tgKiLAAwaK
 4irrYKWnEO29LpKeNCAeJ4382veELzBbpUlgd4qi7s1/cRGrNz+8zfoBAc431D/cEALq
 H4a9zUhVG9GkBxhgA+nb9lgX7sJ/7uN9wz908UptIF//PK6D+e1++k2833TGswatuPSM
 2hF+Mv9po41cWzhRpqyUP/jZg71colkoyG3xI6h/Xewn12XwcmhIDseu3Jen7PPTRUkD
 jxRcbwRHRX74QV6gM4Vwk5BGyGHDIIxI+SXT9k/FUKrkuT2Rt2P9HVRuy64WLsIN6/qs
 iVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=LAjnugIsc4VHWdbrPS4xRmq7Vwv6xC2kO9meZ+2Ku74=;
 b=ribzchbXZYsqtAS07l0CyT1Okp1a2OJvKxWfKSqkTvzmJPrOVpZPsBufVol8hlzZ7X
 oOkP/cTj53FlcKjQrkdMiTsYyIZXD61vDegiLRChzI/LPlESuUYylGu32CyLTxnzIQ27
 yEfVec++rxjwfoQn3F3wPqXZ68SwqZWx3ABGfJZ7KTSAkjJtGV1aGPdVQk8wtLGsV4yz
 Ek646eA0feVLQFTXD2Bg7bSi6ziyiFAUSYQFX2iR7urRJyANPft8fFwH6m6BVHypgYo0
 AS0H4w9Z6A3M65+fJKJloG/SC+1jDozrdJkTae07S19eq8Rne5aQq6dGGpUT4c1Hjr0S
 ofYQ==
X-Gm-Message-State: AOAM530cizFDSnj63l+IA+5qbMPKXajw2lwKl8HOScOCOLG1neMgguLB
 qSyfz43r/i4nUGzcHY3Mh6ALTg==
X-Google-Smtp-Source: ABdhPJy3uKqgOP8ckSCgjJ4/b1zv/v3fqBpHsf8qbfCQukftd+7CRc16PVTQ+oq0doNlQM2yw7fL6A==
X-Received: by 2002:a05:6a00:1592:: with SMTP id
 u18mr17298748pfk.26.1592770836678; 
 Sun, 21 Jun 2020 13:20:36 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id y3sm12039140pff.37.2020.06.21.13.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2020 13:20:36 -0700 (PDT)
Date: Sun, 21 Jun 2020 13:20:35 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] dma-pool: Fix too large DMA pools on medium systems
In-Reply-To: <c0889f5c-34ae-2314-6530-a9240e0901f2@roeck-us.net>
Message-ID: <alpine.DEB.2.22.394.2006211308500.195301@chino.kir.corp.google.com>
References: <20200608132217.29945-1-geert@linux-m68k.org>
 <20200620200936.GA106151@roeck-us.net>
 <CAMuHMdX3mBDm9iHk+jhbGfmo+dbix=3tp5z2ewyddWxM1tdqGQ@mail.gmail.com>
 <c0889f5c-34ae-2314-6530-a9240e0901f2@roeck-us.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Sun, 21 Jun 2020, Guenter Roeck wrote:

> >> This patch results in a boot failure in some of my powerpc boot tests,
> >> specifically those testing boots from mptsas1068 devices. Error message:
> >>
> >> mptsas 0000:00:02.0: enabling device (0000 -> 0002)
> >> mptbase: ioc0: Initiating bringup
> >> ioc0: LSISAS1068 A0: Capabilities={Initiator}
> >> mptbase: ioc0: ERROR - Unable to allocate Reply, Request, Chain Buffers!
> >> mptbase: ioc0: ERROR - didn't initialize properly! (-3)
> >> mptsas: probe of 0000:00:02.0 failed with error -3
> >>
> >> Configuration is bamboo:44x/bamboo_defconfig plus various added drivers.
> >> Qemu command line is
> >>
> >> qemu-system-ppc -kernel vmlinux -M bamboo \
> >>      -m 256 -no-reboot -snapshot -device mptsas1068,id=scsi \
> >>      -device scsi-hd,bus=scsi.0,drive=d0,wwn=0x5000c50015ea71ac -drive \
> >>      file=rootfs.ext2,format=raw,if=none,id=d0 \
> >>      --append "panic=-1 slub_debug=FZPUA root=/dev/sda  mem=256M console=ttyS0" \
> >>      -monitor none -nographic
> >>
> >> canyonlands_defconfig with sam460ex machine and otherwise similar command line
> >> fails as well.
> >>
> >> Reverting this patch fixes the problem.
> > 
> > This looks like the minimum value of 128 KiB is not sufficient, and the
> > bug is in the intention of 1d659236fb43c4d2 ("dma-pool: scale the
> > default DMA coherent pool size with memory capacity")?
> > Before, there was a single pool of (fixed) 256 KiB size, now there are
> > up to three coherent pools (DMA, DMA32, and kernel), albeit of smaller
> > size (128 KiB each).
> > 
> > Can you print the requested size in drivers/message/fusion/mptbase.c:
> > PrimeIocFifos()?
> 
> 172928 bytes
> 
> > Does replacing all SZ_128K by SZ_256K in my patch help?
> 
> Yes, it does.
> 

The new coherent pools should auto expand when they are close to being 
depleted but there's no guarantee that it can be done fast enough.  
Switching the min size to be the previous min size (256KB) seems like the 
best option and it matches what 
Documentation/admin-guide/kernel-parameters.txt still stays.

I'll also send a patch to point in the right direction when this happens.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
