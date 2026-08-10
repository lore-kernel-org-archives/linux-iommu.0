Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAB038889D
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348628; cv=none; b=ck71GVlOwtBE0K3koAsLPqbItZDTicl5v2S3fsui9xINj4+sXFLZX9rhvXTNm2ggnrSbM2MUkXF2qTssWftqB8SDoevrNucSO/lvPFmRiedfCNTTafiLof/IMB73DxPwVwWUyiohbhFReHqO39HPA3ihZMgU8B1XcYPznkjriL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348628; c=relaxed/simple;
	bh=EX7kpA77A51ew2KBPi5qvLmpl+wsaHl+gk3AMBbp9zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=St9+a3fiFypmbi/3T6JNohfPNcV4BPFGB4s/MbEkhTYKiyC9kXXan33oNq62XAic+RDDnjijdbzUlZf23OCMSBRRbYhxqJAOw212PAcLPgWYY6W4ZPPkwfHepRaOKoK9PgPkcei+ymwTSRPICk2Eny/I6cyMoYkAEPYIVlSFUps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B0250206A2E;
	Mon, 10 Aug 2026 09:57:05 +0200 (CEST)
Date: Mon, 10 Aug 2026 09:57:04 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	robin.murphy@arm.com, will@kernel.org, nicolinc@nvidia.com, jgg@ziepe.ca
Subject: Re: [PATCH v2] iommu/dma: Restore locking around msi_page_list
Message-ID: <anmERISaYEawMwha@8bytes.org>
References: <20260730132323.1428473-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730132323.1428473-1-andrew.jones@oss.qualcomm.com>

On Thu, Jul 30, 2026 at 03:23:23PM +0200, Andrew Jones wrote:
>  drivers/iommu/dma-iommu.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied, thanks.
