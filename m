Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21E8219F2
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="AbZ6SLU3"
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id A5A5F15F8FB;
	Tue, 12 Dec 2023 10:28:12 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1702373292; bh=a1R8znDPERKpbzdxol/NMeaD5QrbDBEo3tdX50aZNJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AbZ6SLU3xnza6sfvA7U/POrVXxUf77pN2fSzktUQxFAJCSYQ9vX9xzdqVx5Exl+QJ
	 FwEmU9CEwrrzh+gdMpXqGDtmw22l/I4ocI/+r4uAWtauhKYExsm2ckZl7rAR7CkDhn
	 LCEEXdxrrnF/tVhZjsNpNRyRwqSLFCwCBRbMiFpANh6nIaOrldDqmX48IjdBbqdDkm
	 zqFFocBMcwYw9sEWJ5JtfaVpDE+IFo6hhjvZ6mVnh8cPo6JBZv+aHzyxS3GLNJtp8L
	 29tdUryzhAODYT4wXjPAPwfh1RESqAV1AGKFaog3wPEgZnokqykuUAyugx+NSHHmaC
	 x8pdqO/X4O1mQ==
Date: Tue, 12 Dec 2023 10:28:11 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, "open
 list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, open list
 <linux-kernel@vger.kernel.org>, Wangkefeng <wangkefeng.wang@huawei.com>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH RESEND] swiotlb: reduce area lock contention for
 non-primary IO TLB pools
Message-ID: <20231212102811.7e700dbd@meshulam.tesarici.cz>
In-Reply-To: <20231211174020.GA28041@lst.de>
References: <20231201121352.195-1-petrtesarik@huaweicloud.com>
	<20231211140111.5dbb74c0@meshulam.tesarici.cz>
	<20231211174020.GA28041@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Dec 2023 18:40:20 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Mon, Dec 11, 2023 at 02:01:11PM +0100, Petr Tesa=C5=99=C3=ADk wrote:
> > Hi Christoph,
> >=20
> > just a friendly ping about the following patch. Does it need more time
> > to review, or has it gone lost? =20
>=20
> I've just been a bit too busy.  I'll do a run on dma-related things
> this week.

No problem. Thank you for quick status update!

Petr T
