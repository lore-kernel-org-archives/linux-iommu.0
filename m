Return-Path: <SRS0=rqG6=XB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19931C00307
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 15:58:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE66A2173E
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 15:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE66A2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A128D186F;
	Fri,  6 Sep 2019 15:58:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5259E175C
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 15:58:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
	[209.85.160.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E1AC5823
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 15:58:55 +0000 (UTC)
Received: by mail-qt1-f196.google.com with SMTP id b2so7579254qtq.5
	for <iommu@lists.linux-foundation.org>;
	Fri, 06 Sep 2019 08:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=7auWns/CTnLbzbVxcfsLhjzFCtCS8/hOZ420FTFpzQQ=;
	b=JVcVkJFZufknOs1ljHnNMfNZa2eC/Ko2rp3r88WVgSMP7nKNj5xFFUJ+lvKz8c7dpg
	4PpCZGOp74dIdM2vXPzHmb2LGhc0MqR7WP/O6BV3iNgbCsIm6BhH7CdxxCnWdAysk3Fu
	bZADFrsU29jELQ1Q08m/EZ/naHBZ3rDOqSDsFjj5nsJKiaYHysrJnca1is6Nmc0TeWC5
	6JLzT24HhIBiS6cb/vP7gWMFzJ4R0yiHGMZoQHn8XlFrMvIdR81K4dqH5jlQoa2JdtOV
	NwzEXLJHjPcihR/qpm5RKBru38YyJEgf9xlb0+J1VLZb+zk7Qi5/trRUXbjWU3USJhxW
	YK6w==
X-Gm-Message-State: APjAAAW8gHwysoD7xSSJCWF36YyHbFsHvftJmYE++lMJuEVii1RSDXUQ
	/XSvAR4bjTTIkov3HgvAX2ogJ3nQC9/pUC0zsMc=
X-Google-Smtp-Source: APXvYqwq+7xHbY917VB85V/NY5F1YjF8CbB5+I8o7pGnKxj+SP6ugGUW2leXjZAH+AchzM9rBGkpsGai69cSD+Ma62s=
X-Received: by 2002:ad4:4529:: with SMTP id l9mr1355846qvu.45.1567785534799;
	Fri, 06 Sep 2019 08:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190906151551.1192788-1-arnd@arndb.de>
	<20150686-f14c-389b-7345-699cee191116@ti.com>
In-Reply-To: <20150686-f14c-389b-7345-699cee191116@ti.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 6 Sep 2019 17:58:38 +0200
Message-ID: <CAK8P3a3ByLmeQirVNEumSMGhzs7XFRZujudE81WQhvhLEZprdw@mail.gmail.com>
Subject: Re: [PATCH] iommu: omap: mark pm functions __maybe_unused
To: Suman Anna <s-anna@ti.com>
Cc: Joerg Roedel <jroedel@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Tero Kristo <t-kristo@ti.com>,
	"open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
	Will Deacon <will@kernel.org>
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

On Fri, Sep 6, 2019 at 5:24 PM Suman Anna <s-anna@ti.com> wrote:
>
> Hi Arnd,
>
> On 9/6/19 10:15 AM, Arnd Bergmann wrote:
> > The runtime_pm functions are unused when CONFIG_PM is disabled:
> >
> > drivers/iommu/omap-iommu.c:1022:12: error: unused function 'omap_iommu_runtime_suspend' [-Werror,-Wunused-function]
> > static int omap_iommu_runtime_suspend(struct device *dev)
> > drivers/iommu/omap-iommu.c:1064:12: error: unused function 'omap_iommu_runtime_resume' [-Werror,-Wunused-function]
> > static int omap_iommu_runtime_resume(struct device *dev)
> >
> > Mark them as __maybe_unused to let gcc silently drop them
> > instead of warning.
>
> Curious, what defconfig is this? OMAP drivers won't be functional in
> general without pm_runtime, so CONFIG_PM is mandatory. But from just a
> CONFIG_PM option point of view, agree with the patch.

I did some randconfig builds for testing the stuff I merged for 5.4.
I don't think there are any defconfigs without CONFIG_PM.

      Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
