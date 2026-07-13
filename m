Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1A325B082;
	Mon, 13 Jul 2026 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957686; cv=none; b=IzTK02QJCtVRY8i68Ny4kVj4FiwfQpJ34YnlkDngtWSh5s+9V3XiHZCH3lI4Nak6FSxWAzRU+gKZMAbfGOKDsLrRvCPHtxewnLXtNtqk6WLBkdDjIyOANBUZvZYImP+sc5YFQ5lHyIO57ceKm9M4IIBdD+n91DnzbAW256qHYPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957686; c=relaxed/simple;
	bh=OTiNKg7qY+VAJiPAwpdOvEX9lyoLKmoQ/QMlhBOMVis=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=TeW9jtdxHCJBCmCoJqzh9n9F6H0DY5Jk4bze6ez08J8p3QyYtJfWaz2aruO6qu+bo7kJOOv5a2WFiX+bTpBq89M57JTmKwOAEJZhc0bDhW2w3pZzEW05WvBvhdQPHkhOT7CF1D6CH6al3ThpBHDknVDNrY97ATYSTT7NuzYvDzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=hv0pS+ZG; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="hv0pS+ZG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=W1w1ePKgDYB2lpVoeLFdxZ25A9hhTtFrH1TtOpQR8ys=; b=hv0pS+ZGDht8vWwDXS7EoH7f89
	MwWpWlFh1F5N5VkNN05Tf8vQO1pAM5dQxCSGlPAL8pkAtLF7w6RGe6F5soQj5O+PM8ACK3DmveJCf
	SQj6dXBDHufzbXgAilf7LKLtI0uxJVSCku1A1CeilfDOYqee3jsokHROhw2n9EGR89tLMEE8yG8ry
	l+8/zGDyDWJwjTi0I7Brp7VnhjGunNrLD3+U3E7I3PMzx1R01XYMiePIuuybctrDFttSSBMYio7Sw
	EpTxEUWG6G4x9ENHaUeljDJObiIuDKv/WwGTcCdVQB/Av/4+C2JEcSjcrV/6V0MdQxYRNUZPIMIDe
	C1Ej503w==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wjIsv-00000005lEg-31Gx;
	Mon, 13 Jul 2026 09:47:58 -0600
Message-ID: <afac9e15-0a20-45a6-a537-d868a63435fc@deltatee.com>
Date: Mon, 13 Jul 2026 09:47:46 -0600
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
 Li RongQing <lirongqing@baidu.com>
References: <CGME20260713083036eucas1p12b33a500ff4fef0b5d8db94f694bdb24@eucas1p1.samsung.com>
 <20260713083022.1110993-1-m.szyprowski@samsung.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260713083022.1110993-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: m.szyprowski@samsung.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, leon@kernel.org, robin.murphy@arm.com, baolu.lu@linux.intel.com, mcgrof@kernel.org, bhelgaas@google.com, hch@lst.de, lirongqing@baidu.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] dma-direct: Improve readability of the
 dma_direct_map_sg() for P2PDMA case
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-07-13 02:30, Marek Szyprowski wrote:
> Improve readability of the sg_dma_len assignment in the P2PDMA cases by
> removing duplicated code, which was a direct result of the d0d08f4bd7f6
> ("dma-direct: Fix missing sg_dma_len assignment in P2PDMA bus mappings")
> fix. No functional change.
> 
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Link: https://lore.kernel.org/all/20260604071856.GA245424@unreal/
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Looks good to me, thanks.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
