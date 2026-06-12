Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0743ED3D1
	for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270618; cv=none; b=ROXQGJyO3mbcbkGm04VSTX68AMsWuUjfA39Uh6bkE01aB3WdZc+V8lg8SiWvz+ZeoAblAVte358c5XmKMPiomNUyViPmMps04b+9gub8GhmrILjLp/KAkUrHVT0c5iQWrB/iQAcpSTRWqF/VBOOLHiCZ6Ssvv11lFX6bb7+k5E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270618; c=relaxed/simple;
	bh=ymj3l/2JIgoOdkVk6Tdoen8Gd4mhI3bOz15imdwNjQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmJEtWEXUDTJG6njC5AdprW3KEZ+FWYcKv94zZgOGE7A5GjR4yFr6Q1kEdhCh04iIp7UJbGl7N8F/hCqbRtaAKTmmY/15IAoUsOdmHQ/sRA466rXis41fL6y6ZEu0wU7TJQHpylIA9Zzj5T0cJAKwGJ0EUISq4KUwIY3Bz+qRJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 415F11C55E8;
	Fri, 12 Jun 2026 15:23:36 +0200 (CEST)
Date: Fri, 12 Jun 2026 15:23:35 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"hch@lst.de" <hch@lst.de>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IFvlpJbpg6jpgq7ku7ZdIFJlOiBb?=
 =?utf-8?Q?PATCH=5D_iommu=2Fdma-iommu?= =?utf-8?Q?=3A?= Fix wrong scatterlist
 length assignment in P2PDMA path
Message-ID: <aiwISt6sfVqvk5qy@8bytes.org>
References: <20260530112852.2321-1-lirongqing@baidu.com>
 <c666e384-b365-4891-a01d-736948b995bc@deltatee.com>
 <5e2f30a4121e4672ab309460630d011b@baidu.com>
 <c441256c-e4f6-427f-9f25-7570c991a420@deltatee.com>
 <20260611115938.GF1066031@ziepe.ca>
 <f9d9a6b67cf84073a7dc453c277dcd9f@baidu.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9d9a6b67cf84073a7dc453c277dcd9f@baidu.com>

On Thu, Jun 11, 2026 at 12:21:27PM +0000, Li,Rongqing wrote:
> I think there is no need to resend.

Applied.
