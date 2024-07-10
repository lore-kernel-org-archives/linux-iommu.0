Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA3918FC89
	for <iommu@lists.linux.dev>; Wed, 10 Jul 2024 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611140; cv=none; b=GKwwv5sUC0eKUDYP6G6o44Y793gahwtPvypcjCwgC3yc7VGukG21YzaiCRDz8AmsCZZ297WfoahUXbkTXRkiyaLooSSkGZg1rr+k5QQ08uGNN7iTupY7JYrhCtGuC2zDuCR9ZXcg35IF2wid9F0fO4HMGwT9fmNMZol+Kvi8qQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611140; c=relaxed/simple;
	bh=moHes3pnqVk61P66RkEXxoLuJdZ/zT/x933Dj0tPO7U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FX4oqD3Bp5CEaVf2cnSzj7aYxuKSBb17lteUIgheNuOwS2ba7WtTWJ6HoiB3U+Ndksyiv5Ay3Ri3SLWjwuu6uNu93xOTQJN0RE/KgQu+3uWzEY5zVgdN59dqg5HUgqJd2e5UWgfA3FyzX5auKzOa7RkedGIYqhDQkWZca8rXWec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=A0mA/v5z; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="A0mA/v5z"
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 4C74C1E33D1;
	Wed, 10 Jul 2024 13:32:10 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1720611130; bh=moHes3pnqVk61P66RkEXxoLuJdZ/zT/x933Dj0tPO7U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A0mA/v5z1/FWOl7Z7VV+oN9LRRUp/ACb0HMAtlO3u6hH/6Ph52DVNy502vk3QXxmj
	 l0OSQsKlqu9YVZ7Ve4lEGWsekGte9uAxFm7HdlLz7Y1/hFqPF5IU0Tq/f4PsU5IvvP
	 KNRWuK1Oo8yoNKxRQuz4N9v8QyCi2oAUyUQiz4WeloiEPGZuReLfHnyo2rJbk3QA8U
	 b9bW3haJadDoGY8DZZDYzUKfC/yT2gNj5vmHdsCM7W4cvIH63qehWF0o1ojwsHNkQg
	 /d9V7wTWwF99wHnal5hC0MrnwV10x7Kl7dVvGyx5olfAA+QqSKovJKAlyTuR5jbWzS
	 QV/dvdSNN15kQ==
Date: Wed, 10 Jul 2024 13:32:05 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: mhkelley58@gmail.com, mhklinux@outlook.com, robin.murphy@arm.com,
 joro@8bytes.org, will@kernel.org, jgross@suse.com, sstabellini@kernel.org,
 oleksandr_tyshchenko@epam.com, m.szyprowski@samsung.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 1/1] swiotlb: Reduce swiotlb pool lookups
Message-ID: <20240710133205.63858e7a@mordecai.tesarici.cz>
In-Reply-To: <20240710055520.GA25305@lst.de>
References: <20240708194100.1531-1-mhklinux@outlook.com>
	<20240709111013.6103d3f0@mordecai.tesarici.cz>
	<20240709111812.GB4421@lst.de>
	<20240709210818.28116c53@meshulam.tesarici.cz>
	<20240710055520.GA25305@lst.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jul 2024 07:55:20 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Tue, Jul 09, 2024 at 09:08:18PM +0200, Petr Tesa=C5=99=C3=ADk wrote:
> > I'm confused. If you're not a big fan, why are we effectively adding
> > them to more places now than before the patch? =20
>=20
> Because I didn't want to second guess the patch author too much.

Fair enough. I don't have any relevant test cases either, so when/if
somebody encounters an issue, let them change it then.

Thanks!
Petr T
