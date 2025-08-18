Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7ED27B320
	for <iommu@lists.linux.dev>; Mon, 18 Aug 2025 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755533094; cv=none; b=qgmUDux23m5plk9RWjO405SSvWCt8iEmlauvnOSHyusQZ5PpPzTPNKvtu0SRp8HhKR0gG4Gka9gKOvSXdy92wE71a7FP/34uiUs8qIQJmy3IXZ6XLBVq9sX+s4BH7PcvPGQuoalYWemxPCpuaiuAt2iIZ7VcZ4t/hrerv46WDsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755533094; c=relaxed/simple;
	bh=+HE8A4JWz4VOW6rcIWSp8fVZhJmOl4vISHIqSSqtBOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCH3OPaATH1J1ycWH0mzse6ffMWmNcqdDnf/Zlj5/L+WV/FR3Rfjg1G0NqcBcpDmIE4u/LRGuK33Sza8/8NgU6bhUYAuznM9Q99KYjUqodZxauz15qkj4xMdsv6auUja8TafMS/+dQKS1wv6ebmh0sM+ozypVXVdRCbsdMUIzb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=ECCLMsux; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="ECCLMsux"
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C51AA4DB60;
	Mon, 18 Aug 2025 18:04:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1755533084;
	bh=+HE8A4JWz4VOW6rcIWSp8fVZhJmOl4vISHIqSSqtBOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ECCLMsuxisOpKzJ5tVcq7oXLflbwj4uXblrhPCtJkejg2SyM6AvXBuTiy/LWIObGA
	 B9W8O3uPaVaQkUmjGnwAs/Zd1tfQNf63Z27x4gGooOf1YJqXK9l45hjA+hPhp76eQd
	 +FaNC4LRhYWVXemV397o4NRtKa3jrxcSNCLGeHEHekp7pVSV3/hwPkMPA/h9zfSHaG
	 YX1luiMLzAnELjv4xZc0cft4SWOsFOxsXpud1lA07vLT0QaSSpy6YPqiXPGDFY5IAH
	 E1dJs69JJGd4fbOIzfu2vR3dasCos4I4HrjSg/TYuO6NwfnucS34fsMJPyEZxFxSLL
	 UM9Np4/SjqizQ==
Date: Mon, 18 Aug 2025 18:04:43 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: XianLiang Huang <huangxianliang@lanxincomputing.com>, 
	tjeznach@rivosinc.com, markus.elfring@web.de, will@kernel.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/riscv: prevent NULL deref in iova_to_phys
Message-ID: <44osnwyfiiqdqppu4q56bbzy6kl7xxe6mnxaujviydvm6tlutg@r5jujxv3pksp>
References: <20250815071244.13982-1-huangxianliang@lanxincomputing.com>
 <aJ8FbvCJEOj2XjT-@8bytes.org>
 <e87aa091-5c02-4cd6-9636-0cb6c0015768@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e87aa091-5c02-4cd6-9636-0cb6c0015768@arm.com>

On Fri, Aug 15, 2025 at 03:43:25PM +0100, Robin Murphy wrote:
> It's a valid PA on many systems of many architectures, but it's also been
> the "not mapped/error" value for the iova_to_phys operation all the way back
> to the very very first intel_iommu_iova_to_pfn() nearly 17 years ago, so hey
> :)

Right, the sins of the past finally haunt me ;)
