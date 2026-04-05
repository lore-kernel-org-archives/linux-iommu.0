Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81B1382F3E
	for <iommu@lists.linux.dev>; Sun,  5 Apr 2026 22:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775429383; cv=none; b=Irsey0XNvnkm2y9y3WmlbsD7p3XaygaDlfHm1Ze9aEwZ7hcjuidk6rUacJzeX5sl/pJ2xTrpeAIdi6e/MsPNNYRbhow6VrFzJjG3Heg4J0NUpWADhWE1mlrXhFsVo/yG+wj82mOoW5/FN1u1tJ+QzGCfBr1bXXYS5UZnDjpf7f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775429383; c=relaxed/simple;
	bh=zzMy5NtaL7AD5tUyCQ9LrBMAHeKvVDbZmilsbp1EV5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDjb2yS3eUneTJUzlyue9xzi0tHM5rcTV1VgSdHzn4n3UCwbfY179W36Xsq/hJi/kaNbPecWRVYrevzwK+21m9N7Z+eXwjpHLai0xVsL8+rHPqBZuT6Byq3JvR3wnXHk/a6PXgldoYe+wuEUNgm8O/jj0vR5UTSGWDSxRp6kd/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FUXqqE+V; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FUXqqE+V"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9c1da7ac63so594225866b.0
        for <iommu@lists.linux.dev>; Sun, 05 Apr 2026 15:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775429380; x=1776034180; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzjlDiAhhtCwD9FkXK7yFaosCzkOtMCSogVYlSJljQY=;
        b=FUXqqE+ViWM+NjmskvBF6c4oofZ5iLvbVD9AhU9L7Wk7AuVZUVMOmrs14zIfgXyPli
         9Xtv5w7HJGBAGsX8Tm9uHyZEpTheSb82NZy4+JrDL2LUYlePhXujwIKo5nlMXeu6a87X
         fY4PckdyCQ1CQEFKes4tNXdP8SBxavoI3XbXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775429380; x=1776034180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jzjlDiAhhtCwD9FkXK7yFaosCzkOtMCSogVYlSJljQY=;
        b=Xl0fnce9cK3TkzA8uAbsDcLAc496jkZRm9hLDUejz5E0RUgmSwO9nxJ8ynpsdfjTTt
         TTKq5P8wX1svVBx82Q1eZVRsJnU55NjS3ZxMuDl1HVJO03VrKGSKZ0oGdz+7QngzHb0b
         +4lyBiW+bWjydNjBcY3ia2gm1KQQO9S0ujyH9JBrpzTdJZoT69hsR9Ad9GT0CHqAY2ui
         0DpReD3oA3+9vU/S/+Bev1AJKvmVWvQEkZU+SmK4IDIvH3/9HHHOt5UyMtJdHCzwC9Xm
         iTggDDNfON6YM3WkXYxGovb8XqeeBGFx9S+PeXVZmVMNLh4fpI+qU+dFkT44/iOyfHBf
         FsIw==
X-Forwarded-Encrypted: i=1; AJvYcCWj6T9w98uGYvUN2keMoEoJTJPyZCx4C+bViZ+PWfEuWIDMwJXN1Oa3EF9rFAqaZsRctrcwTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhvPx6+QZL2z+sKlX5Y1opZ+dH7jh0tg889D8gDPOs58C5TlI7
	jPpdGthZjUkIgezzb4dLeyVpvmmBLjlkb8JnlnfJHiZGqN0EbrwfzBBm6ZS//M9GzjjmeQsm5e6
	Eul2yNlx/
X-Gm-Gg: AeBDiesd6XezBVa2CtjYrFeNANCoFe1E0tpOdixsHR/fLmthddWT/2ru9WtdYvTofvf
	rI6ewpxNKdCxV9TlTi0T5j9ILpWvXadrtiVkOTqFcxFf4FKKUZDu13Fif5D300egAD32k3ydaIW
	FnG7UI5wdq155+OsA6pYaYMsnDHwaRc4vl4yJfnUxp4YRhrxYucusz4VOURWjD/WuLqVcyxIaDb
	Lk9PCzzdkzyoKj2Ur9CFfBCobQetQCOAJWOkNBFFdHVd3/drv3ppxW5ulhnqEbdiTsz+qgr1Bkk
	STWUENm2X0tyGYAVD0qOsR1lSpyllEnnLVXfR/OodZiziuUn1bkz6PC2es3ID4hUdPYX5R9GxSr
	uWHY4ZVxn3enW7XFApCpLSh+T4GCnXLCiGtxfe9n9D7EcDv50Uf3qRlb2/F7faPhumZKZR8wyQl
	gKAdRXcIHbpeNHtJFAKlUa85hNGazOjsUlD4Sd9EgkJrFu9UUd3vku0u618W//uA==
X-Received: by 2002:a17:906:c38c:b0:b9c:12b0:2e38 with SMTP id a640c23a62f3a-b9c6742fc63mr376505966b.1.1775429379785;
        Sun, 05 Apr 2026 15:49:39 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c99fc14sm430799066b.19.2026.04.05.15.49.39
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 15:49:39 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9c3e2cf3c0so544388466b.1
        for <iommu@lists.linux.dev>; Sun, 05 Apr 2026 15:49:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5D7UGldeoFcFJFo+tjL390IanWBlSj4VItsyRj8DENj9A3rEmQE0teP92HVm50X36nzUDdA==@lists.linux.dev
X-Received: by 2002:a5d:5889:0:b0:43b:47ee:4586 with SMTP id
 ffacd0b85a97d-43d292d34e1mr14051064f8f.29.1775429026066; Sun, 05 Apr 2026
 15:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260404000644.522677-1-dianders@chromium.org> <2026040539-sponge-publisher-2b42@gregkh>
In-Reply-To: <2026040539-sponge-publisher-2b42@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Sun, 5 Apr 2026 15:43:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X6DRHV6k7G=p5Mno22na75G-69F-EzMkisSxMoxuvJcQ@mail.gmail.com>
X-Gm-Features: AQROBzBHjVedWun0AWH98b5RajBbraAAaRvLQSenEhaNEY8p1Czch8mAczvPiQQ
Message-ID: <CAD=FV=X6DRHV6k7G=p5Mno22na75G-69F-EzMkisSxMoxuvJcQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] driver core: Fix some race conditions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Saravana Kannan <saravanak@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>, Johan Hovold <johan@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Alexey Kardashevskiy <aik@ozlabs.ru>, Robin Murphy <robin.murphy@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Frank.Li@kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, alex@ghiti.fr, alexander.stein@ew.tq-group.com, 
	andre.przywara@arm.com, andrew@codeconstruct.com.au, andrew@lunn.ch, 
	andriy.shevchenko@linux.intel.com, aou@eecs.berkeley.edu, ardb@kernel.org, 
	bhelgaas@google.com, brgl@kernel.org, broonie@kernel.org, 
	catalin.marinas@arm.com, chleroy@kernel.org, davem@davemloft.net, 
	david@kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org, 
	driver-core@lists.linux.dev, gbatra@linux.ibm.com, 
	gregory.clement@bootlin.com, hkallweit1@gmail.com, iommu@lists.linux.dev, 
	jirislaby@kernel.org, joel@jms.id.au, joro@8bytes.org, kees@kernel.org, 
	kevin.brodsky@arm.com, kuba@kernel.org, lenb@kernel.org, lgirdwood@gmail.com, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-serial@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-usb@vger.kernel.org, linux@armlinux.org.uk, 
	linuxppc-dev@lists.ozlabs.org, m.szyprowski@samsung.com, maddy@linux.ibm.com, 
	mani@kernel.org, maz@kernel.org, miko.lenczewski@arm.com, mpe@ellerman.id.au, 
	netdev@vger.kernel.org, npiggin@gmail.com, osalvador@suse.de, 
	oupton@kernel.org, pabeni@redhat.com, palmer@dabbelt.com, 
	peter.ujfalusi@gmail.com, peterz@infradead.org, pjw@kernel.org, 
	robh@kernel.org, sebastian.hesselbarth@gmail.com, tglx@kernel.org, 
	tsbogend@alpha.franken.de, vgupta@kernel.org, vkoul@kernel.org, 
	will@kernel.org, willy@infradead.org, yangyicong@hisilicon.com, 
	yeoreum.yun@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 4, 2026 at 10:28=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Apr 03, 2026 at 05:04:54PM -0700, Douglas Anderson wrote:
> > NOTE: one potentially "controversial" choice I made in some patches
> > was to always reserve a flag ID even if a flag is only used under
> > certain CONFIG_ settings. This is a change from how things were
> > before. Keeping the numbering consistent and allowing easy
> > compile-testing of both CONFIG settings seemed worth it, especially
> > since it won't take up any extra space until we've added a lot more
> > flags.
>
> Nah, this is fine, I don't see any problems with this as the original
> code kind of was doing the same thing with the "hole" in the structure
> if those options were not enabled.
>
> > I only marked the first patch as a "Fix" since it is the only one
> > fixing observed problems. Other patches could be considered fixes too
> > if folks want.
> >
> > I tested the first patch in the series backported to kernel 6.6 on the
> > Pixel phone that was experiencing the race. I added extra printouts to
> > make sure that the problem was hitting / addressed. The rest of the
> > patches are tested with allmodconfig with arm32, arm64, ppc, and
> > x86. I boot tested on an arm64 Chromebook running mainline.
>
> I'm guessing your tests passed?  :)

Yup, all the tests that I've run have passed. I also threw in an
"allnoconfig" compile test just for good measure.


> Anyway, this looks great, unless there are any objections, other than
> the "needs to be undefined", which a follow-on patch can handle, I'll
> queue them up next week for 7.1-rc1.

Thanks. As per the other thread, I'm happy if you or Danilo want to
apply it, and I'm happy if you want to make minor fixups when
applying.

When I see the patches applied, I'll send a followup patch to address
the "needs to be undefined" comment, unless Danilo makes that change
himself when applying.

-Doug
