Return-Path: <SRS0=MJs7=WM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB18FC3A59C
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 14:31:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B423E20644
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 14:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOAKvEhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B423E20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 763EAE89;
	Fri, 16 Aug 2019 14:31:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 25B53E85
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 14:31:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9816987B
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 14:31:50 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id z23so4252277wmf.2
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 07:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=2KH9X7wXKLaNgHTDRuB2BCoTUIbuMO+ioBBw7HzU1JY=;
	b=aOAKvEhf4eJTxcKSld4tT+33ybgVN17T/bYorvBedFN3143JLOiZGmSFFZmUYjnl2R
	ZmjW7kD/tqSTxSJekD045oAnsHHGE/wzxd3ibBgHSbBD4G7ailmdun7QlU0roREL2N42
	puNiR5ETw9wQOVpe6Mqo+x1oUp13MVT9P6m1jnGzwcPxVoe/dl2ds8g+wH5hhvtdRPid
	6OPErwSecc0kXng21CIP03S6DK1Hw73vanv14N8c4S3nZ+j9DR7q/0QqTBczWN0MsIhz
	x4vLhJPhZtg6XPzAQB5+8f8EtApLxjhTH7R06QpYALGd6QyBD3lQpkcUSmLWFu3Jzd3K
	Mx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=2KH9X7wXKLaNgHTDRuB2BCoTUIbuMO+ioBBw7HzU1JY=;
	b=HzE2O7UacPVDK8V3qJ1G4bqzLpnUFjoS1lFWpXqj6TyGBv1TsYHAlHKRUSd/hamFYC
	PU3e6K4JrbSIAwSJeG6Bj+otldjef/VghHZM95oFYqdDGssN7oTT0gw6BogwTVbGooc0
	/y8LkVW3ouF1Jvm9tDECzwjBn9b0KtBeEtXxjx9E19aqmrBb3k4Lj85iqlRwyHCuazho
	uMpHzobX3sKLArKoGJoUznHpNkNdZfNqQpZEiDMbxRueeU2P/UHfCRd3FmKxYnvFTUzK
	ZtpjtiZCTCZZf6K1V+MwD7v7Ve/RMASMzRffwt/eud+zXLubfScvRNu9oCrmVtzXlm9B
	GbGQ==
X-Gm-Message-State: APjAAAXXNS0d049tSgnzHIi1O1B6y2hZFxX/G+uYj0gtXKNdzBDWGhZK
	3o4hRuJptCLN9+KiZ64RjAc=
X-Google-Smtp-Source: APXvYqwUeQsO1Tir1acCeUF+pqGoRTuIizGwVTqI59KMXv4bOZjBPRpPwKZbNL/kgP0dRGGiI+zGDQ==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr7978852wmc.6.1565965909230;
	Fri, 16 Aug 2019 07:31:49 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
	by smtp.googlemail.com with ESMTPSA id
	k124sm10940860wmk.47.2019.08.16.07.31.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 16 Aug 2019 07:31:48 -0700 (PDT)
Date: Fri, 16 Aug 2019 16:31:46 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: bskeggs@redhat.com, airlied@linux.ie, hch@lst.de,
	m.szyprowski@samsung.com, robin.murphy@arm.com,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: DMA-API: cacheline tracking ENOMEM, dma-debug disabled due to
	nouveau ?
Message-ID: <20190816143146.GB30445@Red>
References: <20190814145033.GA11190@Red>
	<20190814174927.GT7444@phenom.ffwll.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190814174927.GT7444@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Wed, Aug 14, 2019 at 07:49:27PM +0200, Daniel Vetter wrote:
> On Wed, Aug 14, 2019 at 04:50:33PM +0200, Corentin Labbe wrote:
> > Hello
> > 
> > Since lot of release (at least since 4.19), I hit the following error message:
> > DMA-API: cacheline tracking ENOMEM, dma-debug disabled
> > 
> > After hitting that, I try to check who is creating so many DMA mapping and see:
> > cat /sys/kernel/debug/dma-api/dump | cut -d' ' -f2 | sort | uniq -c
> >       6 ahci
> >     257 e1000e
> >       6 ehci-pci
> >    5891 nouveau
> >      24 uhci_hcd
> > 
> > Does nouveau having this high number of DMA mapping is normal ?
> 
> Yeah seems perfectly fine for a gpu.

Note that it never go down and when I terminate my X session, it stays the same.
So without any "real" GPU work, does it is still normal to have so many active mapping ?

For example, when doing some transfer, the ahci mapping number changes and then always go down to 6.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
