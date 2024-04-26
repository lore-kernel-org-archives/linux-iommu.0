Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B45C140E30
	for <iommu@lists.linux.dev>; Fri, 26 Apr 2024 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714125888; cv=none; b=hQHLHpC/+7tmD4goYYg6/owgQon6BbE8HoNMfS/abi/qR8WU557XTHZmHV6qLZxFIg9VHY/EK/6SAyIGLtikbg3OekDPA+I7/SxpRfPVRwsXyzGpKmsvHWYw9hP/N8c/ZsdTAUXD4BHEiytECXWbR0HxCkjg8htY/12vtB/xGRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714125888; c=relaxed/simple;
	bh=3z6mQi6GC+f1IGF9aeVW5DUx4MzUimUyjOar6Mh0Dao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDPqmLGaB3W2sj8c6Io9l/84twGwq97T1wdYFllKo+6raiy2ONScEcluKO9Gwyz2HW+NY86O7PfemNK9ZW12wVQXoyUK84Lv2TV6ze/O3PMj6QutgbedK1I3yTVNiV5PfPtUwETBHvL5ZN/c9/fbrXMxxvDhf31PwFcYSHX4oAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=mAH2oxQm; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="mAH2oxQm"
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 231DF1C7E6B;
	Fri, 26 Apr 2024 12:04:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1714125885;
	bh=3z6mQi6GC+f1IGF9aeVW5DUx4MzUimUyjOar6Mh0Dao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mAH2oxQmZCWS96T4wKiV4DrP+x23sWH3VlGoX35OgPr6X375kvdU2eEdSkDxZcu8R
	 FWfvlhpvfrV5a2nq91RfWPvWjr6t5e/OcbrstM/GBsFAQsqKotyYJTs7kOjU20cY0s
	 jT0wnvcrujiibu8en7p3BfH8XqKeR054QvLHsMw97s2OUCQPV7EYk7uF6/fDJXd0AM
	 LweHx2BUAXY0TYVF1AWXuDaKLNKcC8VQ7dvou/CYNeGCrMfkJUBSJcjOqXrGRUvq5V
	 Y+6CO46RkxhhMW/YOR0lunMLYyIwUMvbSj6jJGKjTviJFyfWQ+5H/G5U88kO/Vd0R/
	 ZFDdDRW5eNWwg==
Date: Fri, 26 Apr 2024 12:04:44 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Thanh Le <thanh.le.xv@renesas.com>
Subject: Re: [PATCH] dt-bindings: iommu: renesas,ipmmu-vmsa: add r8a779h0
 support
Message-ID: <Zit8PF5EBUmAjuaC@8bytes.org>
References: <13643259be4e8a8e30632de622ad7c685dbb7c61.1713526852.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13643259be4e8a8e30632de622ad7c685dbb7c61.1713526852.git.geert+renesas@glider.be>

On Fri, Apr 19, 2024 at 01:42:11PM +0200, Geert Uytterhoeven wrote:
> From: Thanh Le <thanh.le.xv@renesas.com>
> 
> Document support for the I/O Memory Management Unit (IPMMU) on the
> Renesas R-Car V4M (R8A779H0) SoC.
> 
> Signed-off-by: Thanh Le <thanh.le.xv@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thanks.

