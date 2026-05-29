Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D3A3921E4;
	Fri, 29 May 2026 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076857; cv=none; b=I15IllzHtK+Zh/reSA6HhMY27AInpct+1U6g/877Hj6qr5AZhWSXAYVw4KOpAtONf+VvSttm311GrqPX/jJARDI9L+IL2wllpq6eozkExFFzW6Uxo0c7Lw6dFzYwA730g3z1/8rCAwcPa7x4Es76yvGr3CuCY6WXMlbF9JlIFFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076857; c=relaxed/simple;
	bh=4UXrMZTOtCPZJrTfaMV5rpb3skrpzx87ZtFP1tllMrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nI9WV747Udrh0U+utgETPeUewdGsHpgSaKg6JGu9MCSK5DER8cOF/mi4pJMsrSi4haXxnxBnABN9uZRRzoRmXfPJiTvWtiGfw9psqpxCdaq4TUklzHUuhpNiHdgvmLm9PUwYe5OMyRG5IH4Ls2ga+Ky7dBqDW9K12BVzYkTJqJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=qowQRPp+; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="qowQRPp+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=JmCG5c7ZdraaUuv5adtXfMR+L/IgQPNcJErvSgyx1bo=; b=qowQRPp+vmiLNlYsmQPNOAQ1Ec
	lVyVhrZDC21fF+NNodAjsFn5ZcLORaY/3O9HnWneNKzwlKVyzCaMqEFCD6YpXPQZaIlu/jkFjH4LU
	shW79nPyr9Vuw/7MBwOe7jTui9E+JApfeBCOZOzB/0c4IgXOM27YFzvxDtMlZzCjqKdwTDNuNkl69
	2eFDFVrKn1c0x7H1Zs+aT/uWRNeYVF0EFSVs9xxFHNH4kIJjw4llpUhFwnfvg9jGOo31b85YL9i3f
	8NX0teUlNxgLr0V+HO7co/tkX2+E9EsRUkLST/cvFeqX7TOsiiYr64h27lHtYCMwcOwp3EOh1cVgO
	yEyYoYPQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Sven =?UTF-8?B?UMO8c2NoZWw=?= <s.pueschel@pengutronix.de>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Simon Xue <xxm@rock-chips.com>, kernel@pengutronix.de,
 Sven =?UTF-8?B?UMO8c2NoZWw=?= <s.pueschel@pengutronix.de>
Subject: Re: [PATCH v2] iommu/rockchip: disable fetch dte time limit
Date: Fri, 29 May 2026 19:47:27 +0200
Message-ID: <5524351.eFTFzoEnKi@phil>
In-Reply-To: <20260428-spu-iommudtefix-v2-1-f592f579e508@pengutronix.de>
References: <20260428-spu-iommudtefix-v2-1-f592f579e508@pengutronix.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 28. April 2026, 18:05:31 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Sven P=C3=BCschel:
> From: Simon Xue <xxm@rock-chips.com>
>=20
> Disable the Bit 31 of the AUTO_GATING iommu register, as it causes
> hangups with the RGA3 (Raster Graphics Acceleration 3) peripheral.
> The RGA3 register description of the TRM already states that the bit
> must be set to 1. The vendor kernel sets the bit unconditionally to
> 1 to fix VOP (Video Output Processor) screen black issues. This patch
> squashes the 2 vendor kernel commits with the following commit messages:
>=20
> Master fetch data and cpu update page table may work in parallel, may
> have the following procedure:
>=20
> 	master                  cpu
> 	fetch dte               update page tabl
> 	        |                       |
> 	(make dte invalid)  <-  zap iotlb entry
> 	        |                       |
> 	fetch dte again
> 	(make dte invalid)  <-  zap iotlb entry
> 	        |                       |
> 	fetch dte again
> 	(make dte invalid)  <-  zap iotlb entry
> 	        |                       |
> 	fetch dte again
> 	(make iommu block)  <-  zap iotlb entry
>=20
> New iommu version has the above bug, if fetch dte consecutively four
> times, then it will be blocked. Fortunately, we can set bit 31 of
> register MMU_AUTO_GATING to 1 to make it work as old version which does
> not have this issue.
>=20
> This issue only appears on RV1126 so far, so make a workaround dedicated
> to "rockchip,rv1126" machine type.
>=20
> iommu/rockchip: fix vop blocked and screen black on RK356X and RK3588
>=20
> RK3568 and RK3588 has the same issue as RV1126/RV1109 that caused by
> dte fetch time limit, So we can set BIT(31) of register 0x24 default
> to 1 as a workaround.
>=20
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Signed-off-by: Sven P=C3=BCschel <s.pueschel@pengutronix.de>

Acked-by: Heiko Stuebner <heiko@sntech.de>

@Joerg: could we get this merged?

Thanks
Heiko


