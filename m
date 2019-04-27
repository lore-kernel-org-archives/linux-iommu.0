Return-Path: <SRS0=j+PZ=S5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D8DC43219
	for <iommu@archiver.kernel.org>; Sat, 27 Apr 2019 14:24:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5289C208CA
	for <iommu@archiver.kernel.org>; Sat, 27 Apr 2019 14:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="bW95RIN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5289C208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E722D1A0B;
	Sat, 27 Apr 2019 14:23:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 55B0419A3
	for <iommu@lists.linux-foundation.org>;
	Sat, 27 Apr 2019 14:20:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B67DA875
	for <iommu@lists.linux-foundation.org>;
	Sat, 27 Apr 2019 14:20:47 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id p21so5747027wmc.0
	for <iommu@lists.linux-foundation.org>;
	Sat, 27 Apr 2019 07:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=6ZKbcpKE+jjnLBwFYXkMrxjdfDETR3PC8ZYm15vMqpw=;
	b=bW95RIN1825L7mXuK9ObhaHyQ4/IZFGjnXDYYIQ4GRq818wpB6A1rZLT9cG1nT4PY8
	GCuN37x11Fp68+DmxG+0WgI5FuCjuqfGflKtE5XTUMuztiIG8Ub6Me6JvLQp9BHkwZcq
	a73Kz9iv4JTcFV239YY5nzYRMXDzQwrrKEHBW6F6yps1biLJUgRwBZrOJIENpEZQ3Wxz
	ieUpHaSxwnQpy+3IZ2oLs+/EVp+/LVG5vAThTD8PejxKY9yeeqYYdWiNMeO5K833HfN2
	1Jw02EfoIxtjGpk7KKhLQ1B1heLQPKME8XKgiFz/Zkh0d/y49s9xdNlh5rWqot4XnP6g
	zxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=6ZKbcpKE+jjnLBwFYXkMrxjdfDETR3PC8ZYm15vMqpw=;
	b=lil76XcwpOBos7+h1EehUy2gdMCmaGJrCzyYs/MBuIEUpPGcUY7B3cr6dYa/ASOtEV
	bV7n0cw8FfDe49tg7mrZ/w1SlbOEblg8CofCyWGWpxA5Ai/d3B4XoS68oo427wfNpPya
	TJ2xzjjS82alE0ivM9IKPKT4KlMTbUF0TgV2I3MEgO/DVGs5pFIZfEMEqbvh8rGuuvdt
	bdjx0qQ1JKh59w+qbLcgk+ZY6rKF3Lzj64SDCWjNImfMxcgKH3vt9mK6JAzLQ3IbrCRf
	AJglx+gndaatXX/849tYc/f6duKiv9FzbeQX9jy0MyAtMUfjmR9Q4pyy7D41O/N3t79g
	zCtQ==
X-Gm-Message-State: APjAAAX8YxfeCDEgrPlLQ7W4cR8OxNgNVkxSn+r4wEZ3/a6vkeDK02YE
	4zZRYo7dyK6quJkvF+ebsiVGPXXchXea0VCKyrUL+A==
X-Google-Smtp-Source: APXvYqwzW141/RnAEFxzXCAYJxdQ5vvdZVBOEKJsY/gBgWOt2nmEvGhjXJKbo4/pJHqjJw0+u9p92wNTGyoTFMGfxZg=
X-Received: by 2002:a1c:c142:: with SMTP id r63mr12099950wmf.97.1556374846121; 
	Sat, 27 Apr 2019 07:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190424165051.13614-1-tmurphy@arista.com>
	<20190426140429.GG24576@8bytes.org>
In-Reply-To: <20190426140429.GG24576@8bytes.org>
Date: Sat, 27 Apr 2019 15:20:35 +0100
Message-ID:
 <CAPL0++6_Hyozhf+eA2LM=t_Vuq8HaDzcczAUm0S4=DAw4jmMpA@mail.gmail.com>
Subject: Re: [PATCH v1] iommu/amd: flush not present cache in iommu_map_page
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Tom Murphy <murphyt7@tcd.ie>
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
From: Tom Murphy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Murphy <tmurphy@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190427142035.nSjDfx07-wQsDxtsQg1BYzOun0UWSJYeCGKEgY0WcAU@z>

> The iommu_map_page function is called once per physical page that is
> mapped, so in the worst case for every 4k mapping established. So it is
> not the right place to put this check in.

Ah, you're right, that was careless of me.

> From a quick glance this check belongs into the map_sg() and the
> amd_iommu_map() function, but without the dom->updated check.
>
> Besides, to really support systems with np-cache in a way that doesn't
> destroy all performance, the driver also needs range-flushes for IOTLBs.

I am working on another patch to improve the intel iotlb flushing in
the iommu ops patch which should cover this too.

> Currently it can only flush a 4k page of the full address space of a
> domain. But that doesn't mean we shouldn't fix the missing flushes now.
>
> So please re-send the patch with the check at the two places I pointed
> out above.

will do
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
