Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F554A6CEF
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788784528; cv=none; b=QQSoGCQI27BYgWYgdR+mnsOr4zEMOGjeLAYkiDIf//bI9WVEkjJM1x3mWOdrhn07sXCmcxwL8JbnF7Kexk6cZMUZJGcbF+f5UZz5pLtOTBw9Akn9K1mr5WHwzeW/+jy1++LPWtFHfqr7lReOQSI2Ahdg16LmgPbGrtvJ0zm6HVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788784528; c=relaxed/simple;
	bh=1cNPswN7JJF1hEN/8JK45QLPJaEGl/7/REtDmalhhHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyUVFAHkYowIY9PdgiB2buOEucTytQRpqTq4tT2haCC1SqLLJtu3D9Fz2XEIcl1Cmzx1ipn2ZMIpZ+J3DWFqQCgXM9QXrP4U1qhfeIY0tw5gcoXVbxI2H20u252zAC4srX1PKso3k/x+hR7xB4NMNtHQkNFhQDp6OnU/wEzBh0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af085a0015db8e28914752a6.dip0.t-ipconnect.de [IPv6:2003:f6:af08:5a00:15db:8e28:9147:52a6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8E03620A085;
	Mon,  7 Sep 2026 14:35:25 +0200 (CEST)
Date: Mon, 7 Sep 2026 14:35:24 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: fangyu.yu@linux.alibaba.com
Cc: tomasz.jeznach@linux.dev, will@kernel.org, robin.murphy@arm.com, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	baolu.lu@linux.intel.com, jroedel@suse.de, zong.li@sifive.com, 
	andrew.jones@oss.qualcomm.com, anup@brainfault.org, jgg@nvidia.com, jgg@ziepe.ca, 
	guoren@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/3] iommu/riscv: Fix command queue publishing races
Message-ID: <ap6veD4V8RGHL9zE@8bytes.org>
References: <20260901133920.14550-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901133920.14550-1-fangyu.yu@linux.alibaba.com>

On Tue, Sep 01, 2026 at 09:39:17PM +0800, fangyu.yu@linux.alibaba.com wrote:
> Changes in v2:
>     - Avoid reacquiring the command queue lock after waiting for space
>       times out.
>     - Link to v1:
>       https://lore.kernel.org/linux-riscv/20260817142728.61783-1-fangyu.yu@linux.alibaba.com/
> 
> Fangyu Yu (3):
>   iommu/riscv: Add command queue lock
>   iommu/riscv: Serialize command queue publishing
>   iommu/riscv: Avoid waiting on failed command enqueue
> 
>  drivers/iommu/riscv/iommu.c | 117 +++++++++++++++++++++---------------
>  drivers/iommu/riscv/iommu.h |   2 +
>  2 files changed, 72 insertions(+), 47 deletions(-)

Queued for -rc, thanks.
