Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E5515852E
	for <iommu@lists.linux.dev>; Wed, 18 Dec 2024 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734510802; cv=none; b=UiU5rv8oTL/eQAb3PEjFF3CCZzoWESO5+Gu+0MwNFuKpTrXGvZjV2COAMxA2d+BFmepcah7dyKsobSJrOLCvhZuQQEmNtICqe7fXgjdHYMD+rgrCfbfF+zm27iGlhKUwbR57TckoZ0wZRU3qWVgx8+iKJaoOg6YjuoSzPxvoa5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734510802; c=relaxed/simple;
	bh=SnXrVVcZicUpc/vldSOmA4Er3YIKiqZz/uXkr2nSFV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abhO/osmqMHwfAfOpmAVyv3uDkqbCY2Ly3kSQufH2iDg38MnpkQb+zzdbfFidyQ8R0hgfK5kqtwVCzRNi8ytWaq7ck/Cy6aOe5XNlZVqytblxDPqfh6CjpsiUrQDdDNFYSfsJvh39KcCxor9t7x4DDblMQb0Hxh4ZkKQDtHD28w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=DpYdvIsE; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="DpYdvIsE"
Received: from 8bytes.org (p54921e31.dip0.t-ipconnect.de [84.146.30.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D548F2C1E66;
	Wed, 18 Dec 2024 09:33:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1734510798;
	bh=SnXrVVcZicUpc/vldSOmA4Er3YIKiqZz/uXkr2nSFV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DpYdvIsE5/rFS4guUUOBuRAgp5vukDkiJn1CimvBFDFs/VA7+OkmUv4+yTLWJ5FRe
	 Damw0ekNjs4c1ckhcY45ERDEfk9frwaCeCPS1jVZ5nMrJEUcWYq/VXfSgnNsJ9mIH1
	 v9NpXifSGgKn3sNBr615xyf7e6W0Ig/3X0WoqtfVj5t4sOQLTmbzW9KzHdxA3Zgjnr
	 u5BSOy/plsYe7PINGnLuQJsYfwYULPM/stRGD9qZlwYGQlsiQMEEP3hmf0oFVJh1LB
	 mO0e/jWHj1xXm3pIkgonXftKsrDqAUfv1LQ51uB65lHDbwDM+Clqzx4IGlBOyJ/54E
	 KDFaVbHo3zhgw==
Date: Wed, 18 Dec 2024 09:33:16 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, tjeznach@rivosinc.com,
	samuel.holland@sifive.com, will@kernel.org, robin.murphy@arm.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Subject: Re: [PATCH v2 0/1] iommu/riscv: Add platform msi support
Message-ID: <Z2KIzNl3Mf0aL8IP@8bytes.org>
References: <20241112133504.491984-3-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112133504.491984-3-ajones@ventanamicro.com>

On Tue, Nov 12, 2024 at 02:35:05PM +0100, Andrew Jones wrote:
> Andrew Jones (1):
>   iommu/riscv: Add support for platform msi
> 
>  drivers/iommu/riscv/iommu-platform.c | 102 ++++++++++++++++++++++-----
>  1 file changed, 84 insertions(+), 18 deletions(-)

Applied, thanks.
