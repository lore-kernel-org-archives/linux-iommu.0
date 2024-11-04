Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088541B21BA
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 12:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730721693; cv=none; b=r+YhbP/clYdGUGR48XufVPPU7bTkU8oUJALdm22FynAUvHbBstvgN/+ipC1nJ7TyBGgjLaN7Y3xn927DadYC/FRi89+qN/O4BIWiKHkm2rA2V8OoW/ozDHSA+d09g7r2V5ZEh1BANrtcBpzsYODq4Bfjgj2+B+FKIslP7yR16P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730721693; c=relaxed/simple;
	bh=VMet+ZKZMbB9kRXIqGRAeZC8WyYNEBBksEcEjpKHNt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVWXyVPUHwPNCCBHr2EhTC5mh600pWAPFyIwEslXRzZcvcO/CBx0qpiscS7LiRf813WXrMm37Fo0BbGxadYYQMNSlOCL6LyKb1wSB6qgzksTueud9B6Sj2FCOs3JIUZhZm02TBs5wxZ5rK6Wu2gTFV4lPlaGnvxXXkKkaEfRNvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h9CU9OFB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9CU9OFB"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20ca4877690so171225ad.1
        for <iommu@lists.linux.dev>; Mon, 04 Nov 2024 04:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730721691; x=1731326491; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aBZ849UhGXAQ20Maj+3fLLaqA5Ylq1njMJ91T1YRFLU=;
        b=h9CU9OFBTYJUrd59XclW/Zw0HYQ1l3iiKKn4Y5mtG3jIjdQ94vgbmRMnWHZrCGm6UC
         7NRt8gEBo+dqocGR5CIF+TdKhXAJHi1uUI/IFYGgRsowiquyg4DsiDpDNXiw+N7ZhBBa
         KlD8KdRZ3LT5+Nen9UchUruYqTO+EntUTLbXHNXMINM/VW5hH78OcgquSOPF8WoGBb6F
         wQ7uKTIwZXFJ9PrYvrGOy5471vG8wwBxCmWPCWSTFnOQyw60uflmt9pXQekSYKiBqwSj
         X7deKwwyzMxyVqFNvG/pROy50Rhbn4RG6W2yx8mB1hoFfy8iyukg6v7uhKRn49Qb12KK
         MwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730721691; x=1731326491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBZ849UhGXAQ20Maj+3fLLaqA5Ylq1njMJ91T1YRFLU=;
        b=i1A33JFYRXStKUkve9G+Im381iWtkTi6JobUfd8iq+yHAGjkOCIif5+p0svB6rxh30
         jWuDB+En9NMP8TJOAESO3Y3XFlFZbrTm8dAcIEFRMZwktSgFvX/L9Brlg4qWOrNbWfEm
         W4YDc2JZA8gQNa/C9y9aW/dzHPWV9fTGz8XN8no0XHOr6wevSogHozQjfM7vE3V7Sg7A
         OfuIrXaH4w/B93g/RJ7sjlo/rrwomGYBkXsa4jWIsCOtZtY1UvGxzkWxJUUntnuGFfaY
         q/pDvFkFftdaTTmgRKrHEYlcNGgxl5F/YizjlaNrM4xh5sAYB8yPwj3TtdYjCaXqhJoS
         cncg==
X-Forwarded-Encrypted: i=1; AJvYcCUgWUv2QMazp9y+Psk6Nel7k1WBoI2EkrwGJlETPIWN9137GxIBDClfcgZC3yv9GQY0+R2Huw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwizVRNLs6ok0+HkATZYlLx+jX3bJJehlgd7g9LCtkesds77NAv
	yzevuIUZPw8PwuTpewUULiRLKuHXoneKWUs1C2vE73KYt0yRXtRfaZx1+5f6xg==
X-Gm-Gg: ASbGncss8v0w6COr5EvZ+/eWgVT+3e353Crhy7IivdkPyRjNukD33BB6T73uqZkAqOZ
	hJ/JBp/T+Ukizqxh0qICQslOYBjfw/bx6B6Wfz+Jb7lvjjESlH8CiQ+Cf8O29BEbh9vin5x55X0
	ma7eOluSk5xu11S+/zIbyvcSZFwWm74H8/C/03hpM1DusnLqVfCRZAaheJIfafSNoH7iu+LK9Z5
	tVdVepjvSbnpbl7DnrRRZdFCwTY+2TSh1UYKYPy4sOH3HwwZqSZUxGny7XyJnjSgqqa9mRjTMzZ
	IDToj59cJ6E=
X-Google-Smtp-Source: AGHT+IH9N8cVhjwUeF7SpDXa4M8T9hV2JUOxyfIm3VNZdh9jllFT9vRCS00lpSDKOeoHLwlT1m6GKg==
X-Received: by 2002:a17:903:1ca:b0:20c:a5fb:7a0a with SMTP id d9443c01a7336-21134d2054fmr2537175ad.19.1730721690924;
        Mon, 04 Nov 2024 04:01:30 -0800 (PST)
Received: from google.com (146.254.240.35.bc.googleusercontent.com. [35.240.254.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2110572008dsm58319505ad.114.2024.11.04.04.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 04:01:30 -0800 (PST)
Date: Mon, 4 Nov 2024 12:01:21 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
	Will Deacon <will@kernel.org>, Joerg Roedel <jroedel@suse.de>,
	iommu@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Peiyang Wang <wangpeiyang1@huawei.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net-next] net: hns3: add IOMMU_SUPPORT dependency
Message-ID: <Zyi3kb_Q-0Fs9Ycw@google.com>
References: <20241104082129.3142694-1-arnd@kernel.org>
 <069c9838-b781-4012-934a-d2626fa78212@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <069c9838-b781-4012-934a-d2626fa78212@arm.com>

On Mon, Nov 04, 2024 at 10:29:28AM +0000, Robin Murphy wrote:
> On 2024-11-04 8:21 am, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The hns3 driver started filling iommu_iotlb_gather structures itself,
> > which requires CONFIG_IOMMU_SUPPORT is enabled:
> > 
> > drivers/net/ethernet/hisilicon/hns3/hns3_enet.c: In function 'hns3_dma_map_sync':
> > drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:395:14: error: 'struct iommu_iotlb_gather' has no member named 'start'
> >    395 |  iotlb_gather.start = iova;
> >        |              ^
> > drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:396:14: error: 'struct iommu_iotlb_gather' has no member named 'end'
> >    396 |  iotlb_gather.end = iova + granule - 1;
> >        |              ^
> > drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:397:14: error: 'struct iommu_iotlb_gather' has no member named 'pgsize'
> >    397 |  iotlb_gather.pgsize = granule;
> >        |              ^
> > 
> > Add a Kconfig dependency to make it build in random configurations.
> > 
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Joerg Roedel <jroedel@suse.de>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: iommu@lists.linux.dev
> > Fixes: f2c14899caba ("net: hns3: add sync command to sync io-pgtable")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > I noticed that no other driver does this, so it would be good to
> > have a confirmation from the iommu maintainers that this is how
> > the interface and the dependency is intended to be used.
> 
> WTF is that patch doing!? No, random device drivers should absolutely not be
> poking into IOMMU driver internals, this is egregiously wrong and the
> correct action is to drop it entirely.

+1. Device drivers shouldn't poke into IOMMU internals.

> 
> Thanks,
> Robin.

I see that the requirement in [1] is to somehow flush / sync the iotlb
right after dma mapping an address as a work around for a HW bug, right?

I'd like to point out that the dma_map* API take care of this if the
underlying iommu implements the `iotlb_sync_map` op (check iommu_map).

Thus, in case you require it and your iommu driver does NOT support
`iotlb_sync_map`, the right way would be to add this functionality to
*that* iommu driver instead of letting the device driver poke into IOMMU

Another thing worth noting is, we do have some quirks to address broken
hardware in the iommu drivers. For example, a broken pre-fetch command
for hisilicon HI161x in arm-smmu-v3 driver[2]. Such options can be added
to iommu drivers after discussion with the relevant stakeholders.

Thanks,
Praan

[1]
 https://lore.kernel.org/netdev/20241025092938.2912958-2-shaojijie@huawei.com/

[2]
 https://elixir.bootlin.com/linux/v6.11.6/source/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c#L81

> 
> > ---
> >   drivers/net/ethernet/hisilicon/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
> > index 65302c41bfb1..790efc8d2de6 100644
> > --- a/drivers/net/ethernet/hisilicon/Kconfig
> > +++ b/drivers/net/ethernet/hisilicon/Kconfig
> > @@ -91,6 +91,7 @@ config HNS_ENET
> >   config HNS3
> >   	tristate "Hisilicon Network Subsystem Support HNS3 (Framework)"
> >   	depends on PCI
> > +	depends on IOMMU_SUPPORT
> >   	select NET_DEVLINK
> >   	select PAGE_POOL
> >   	help
> 
> 
