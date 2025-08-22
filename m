Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C202E229D
	for <iommu@lists.linux.dev>; Fri, 22 Aug 2025 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845547; cv=none; b=csAf7n4zF+MUeJ9SzQMw1keihbDMQgMqnQ2a1mYGKIYOiOG+/ropliH7XUr8NNETbs+yIKhqR4X13b/rrP4d8LyRxwzaL5+M9Zi5WpEvs/Q3uW10mABH886x/UrVvJl1mfRSY80XILisn1Ne4X9VjDgU3f1zwIzIxaY6Bfhm5hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845547; c=relaxed/simple;
	bh=6AGDwX5cwNQJU6T7X/YiirWHQJlaXZeAFX5Fxe7kv6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXJGDRYL0IjG3+ty1aJ4wZe3ItlU+v9BlMPuAth7dVcOLKkO1yTLE8nNBR2an1mqoyAJlkfvDokQG1b58uexvNfqcDv4s1/zqzuV1JEb95Yrmsl+U7PcQEhF1IeqVE3TdfLAJxjU8HyFRqS0vXhXky81WJhieMRXs5UA8TBHJfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=JTD/8/cm; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="JTD/8/cm"
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 6FD4053666;
	Fri, 22 Aug 2025 08:52:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1755845544;
	bh=6AGDwX5cwNQJU6T7X/YiirWHQJlaXZeAFX5Fxe7kv6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JTD/8/cmH6EuS/2bKcpWduheMGC0bfPT6JtPlAQakAwLT1B0LOxQH8zSgx/ExATFo
	 ixNKfi2T8Q/VF1ucpFynoEFFGi1jdAloUyYvHf7+GRtHlXBwEPGK7eF6xXTQ7TXcGX
	 gp6oL3QBgp3pncKOsLaTR0LJYOOc69OH9AYtf9M2islAxb8sWx5kHWRZz7YBE1QT/6
	 dhYIsq6NiRdJNWzY9KdsSWjLweetWH15HfDtZ4asDLWclzB0SUbetETqcmmBYjExhN
	 ika+6R8PTa027PSlJeOvTYGep6zhBtOmb33DzvolCbJO4c5ePehVAVI+S/z4+iXfIS
	 Loez368DXbIjQ==
Date: Fri, 22 Aug 2025 08:52:23 +0200
From: Joerg Roedel <joro@8bytes.org>
To: XianLiang Huang <huangxianliang@lanxincomputing.com>
Cc: tjeznach@rivosinc.com, markus.elfring@web.de, will@kernel.org,
	robin.murphy@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iommu/riscv: prevent NULL deref in iova_to_phys
Message-ID: <aKgTp60ge-8GeulQ@8bytes.org>
References: <20250820072248.312-1-huangxianliang@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820072248.312-1-huangxianliang@lanxincomputing.com>

On Wed, Aug 20, 2025 at 03:22:48PM +0800, XianLiang Huang wrote:
>  drivers/iommu/riscv/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied for -rc, thanks.
