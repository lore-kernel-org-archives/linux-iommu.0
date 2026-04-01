Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBF339A046
	for <iommu@lists.linux.dev>; Wed,  1 Apr 2026 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029690; cv=none; b=JCeP6DcBetujewXI4j4VDAcezIcK/XuMHhHG2/U2vg68qNUDbR6Phio1Rjc/59sFoIpnQk6reE5HeMXarvpLHa2gjsdI2wEUfzNAQBdXOz90WIyl2bfj02BeNdYCkWVG6mIs6DmK9b75kWMd01N7OkjUMXf9A6tj742QKD7DvcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029690; c=relaxed/simple;
	bh=9wQuwZMaLezRKGrY+1Y3P15ok2J70F8ST08Fqnvz+gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ffb3eJ0HCS1Uh0wgGufETM7xueXD1R0Wh340x4Rqyg0+av7G3S5AmCGLD/RWlcxBWZvwiXklbrOfafo1NTZLcy0dH87GdqKy/as6pefMS5HZ67GOC56tOyc3h6Bu0nDabVTi2cf0f/wm2xOJjYrSHv500X2IKAKvBroxaekN90M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=nTaV4Yrf; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="nTaV4Yrf"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D17CB1A738A;
	Wed,  1 Apr 2026 09:48:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1775029687;
	bh=9wQuwZMaLezRKGrY+1Y3P15ok2J70F8ST08Fqnvz+gE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nTaV4YrfzDuTHF0qFf5QhQnZBAc0/lS07zyNrhg5edu1jmTcP+sYNEH2oEPjjp8jF
	 Cwh+r8NrtcEmYN1Z5BZ1BKwRAxzqT+bx2nWQfd0S0JQKynRIa/8PvcDXCLVVakIzW2
	 7AM6z2g2slLwXppkmJpIT5isoYPx9zOL7KKgzNO2mK+K8Zs542OZHOWbNmh8+sFotR
	 mZjyN4JZqWl1IDXDRnP8iTrRfsahcaQ0HNcoD5ZHaixgVYFd036tsBQ91exqZSVwbj
	 4f5Beqo/bOfiZQXnoz31XqUIPwlEauVwLLhVpRDt4ntnkwISEftwo8uAnvlhwk5x3q
	 7XU6HStrqf2uQ==
Date: Wed, 1 Apr 2026 09:48:05 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: Ethan Tidmore <ethantidmore06@gmail.com>, 
	Tomasz Jeznach <tjeznach@rivosinc.com>, Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Robin Murphy <robin.murphy@arm.com>, Alexandre Ghiti <alex@ghiti.fr>, 
	Yaxing Guo <guoyaxing@bosc.ac.cn>, iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/riscv: Fix signedness bug
Message-ID: <qxks6fv44ji3uphxitxapazddf22a3my7bu35vryo5cz4uloww@pjo74saj3krw>
References: <20260319182644.1082740-1-ethantidmore06@gmail.com>
 <gbresi4jgjmt3cydjftumy7f3afrk2ondap4mx6xfjmrtdnvsq@fpv4htqzdcvz>
 <uhhd56nw64kofhkgkipzhofwhv6vqbh3lrklzyliyysmvxs4fw@nkhiijvf65q5>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uhhd56nw64kofhkgkipzhofwhv6vqbh3lrklzyliyysmvxs4fw@nkhiijvf65q5>

On Sat, Mar 28, 2026 at 11:23:32AM -0500, Andrew Jones wrote:
> On Fri, Mar 27, 2026 at 09:35:05AM +0100, Joerg Roedel wrote:
> > On Thu, Mar 19, 2026 at 01:26:44PM -0500, Ethan Tidmore wrote:
> > >  drivers/iommu/riscv/iommu-platform.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > Applied, thanks.
> 
> There's a v2 of this patch with the fixes tag fixed
> 
> https://lore.kernel.org/all/20260326175738.750060-1-ethantidmore06@gmail.com/

I updated the Fixes tag when applying. So it should be fine, but please double-check.

-Joerg
