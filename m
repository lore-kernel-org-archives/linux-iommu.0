Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9181ACEDA
	for <iommu@lists.linux.dev>; Fri,  4 Jul 2025 08:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751617994; cv=none; b=gC+tT60yRIIla1Ivs9m6Re93wCTNQzmIJNfX20e9BDTYY/6vQvc3HVu3fne7jfijx6DDymDuge1hFaK4IUoxp8MejAnQj2ykQKSBr250+ODwMz002izIX77VH0Wm4WJOA4w+KW9qlqnMC0Pz8QIuK+RFrGeqVKSks7PRdVmX0bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751617994; c=relaxed/simple;
	bh=1Wb4ZmTEJsSifboKDjUkFOYzbSZxSp7Cj7bjm5Uh7PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcHptVdt4aWeeJp+d2AYrMUzgV8d1s4BoltVt1ch18jOPj3rI452AZnJKHZLGYOADITwNcGTLEe/1mpnj+U0mwU9kCToVJ1kAXRJs3ana8kx78CIxjzj+siKFHYhJPC6evy4dNMNrMWks6OAhSKX76uUunC0oRjnChpCyLJsrQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=CNnwCTPp; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="CNnwCTPp"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C85A94D68A;
	Fri,  4 Jul 2025 10:33:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1751617990;
	bh=1Wb4ZmTEJsSifboKDjUkFOYzbSZxSp7Cj7bjm5Uh7PE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CNnwCTPpeQ3dIUBs3CEaEcBZC9ZSCczy9UgnBvT7RwXD1li0Fl8Ns8E8bRwMZ8hb1
	 aQVU10Jcq3V0vKhxLAUFoQ/yGL8ptcDaFIb/hDqL4JajHDN/IFDoi5rKadoCQLbTve
	 5yD2txFQ7Rj6wyMYHK60tT7rAsOkkrOg4a0bZ0yWrS2x/2rZnS8fqRG1daeQysxkNa
	 sA7BKstvqe0xAnCjwwsPwYDyOvyh35vX+heZDh0EsJcrm1lBRiJCc4HWcHEGxzz5x8
	 b+xhiH7C2xJu2YcPBLrbFndAWwFjAANtkqudWJB4wt42MxtqZjuB/cL2+mzE5olZKY
	 gC4UcxuJ7rqcg==
Date: Fri, 4 Jul 2025 10:33:09 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, yong.wu@mediatek.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] iommu/mediatek-v1: Tidy up probe_finalize
Message-ID: <aGeRxYJrd48SIlJF@8bytes.org>
References: <7c78149504900bc6c98a9c48f4418934b72d89ac.1751036478.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c78149504900bc6c98a9c48f4418934b72d89ac.1751036478.git.robin.murphy@arm.com>

On Fri, Jun 27, 2025 at 04:07:10PM +0100, Robin Murphy wrote:
>  drivers/iommu/mtk_iommu_v1.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Applied, thanks Robin.
