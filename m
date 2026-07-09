Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6C53E8332
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584608; cv=none; b=eBBk/UulDX63Sdl7YJa0TLxQ9tp2KRY4byKT3vUYRu4A6QRr62FzFriCHpvpMgXGFhsMpAQK1IvxcL/EPVdAJFx9MNe2+hAVDj74nxmhId1RFsDxWMN/yPq2k0KA3XYvWPF3E5L59xGqn6z39/VF4g6N7dy43H5XxLzoai6/38I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584608; c=relaxed/simple;
	bh=jwFRFbQh3P+/0AQfUQeOSqc6NhCIsZQalLhcuGOpe4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3Vn9cCZtpa+/Xu1/kdGtix6I3ivPZnrXCUkkqBHvjUWjp9I9+te3B4ddG8JFpSNGWs/+y0IjwE9Yxfygo8yuk/gY55mPH0tXv0s7bRzenMSKQMzxh+fiyR8MxwOA3Djczly8Qxd6HqwIEk00ZlLvwlsBKcquyObxtAtWIS5vok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc500c39e96c98da8598f.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:c39e:96c9:8da8:598f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 6223A203552;
	Thu,  9 Jul 2026 10:10:05 +0200 (CEST)
Date: Thu, 9 Jul 2026 10:10:04 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iommu/riscv: Drop superflous zeros in pci_device_id
 array
Message-ID: <ak9XUKtze8-EfF5V@8bytes.org>
References: <20260522145943.774344-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260522145943.774344-2-u.kleine-koenig@baylibre.com>

On Fri, May 22, 2026 at 04:59:43PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
>  drivers/iommu/riscv/iommu-pci.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.
