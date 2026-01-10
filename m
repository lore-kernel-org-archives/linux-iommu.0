Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E976B4315F
	for <iommu@lists.linux.dev>; Sat, 10 Jan 2026 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768040291; cv=none; b=AHZaaMnh5gutUZoj1A/aJNVtnrwvOnHTs1ahFjUrCUqCzssoM3xOiEs8qwsGn5sIXM2LqSBR4wAh7PvPQaTdQ3GMUwvtVC67QigKHYP7sbxv5P3d1+3sBCzq/xxxZyDVCI0Zv8LTfZwjgmbFIbaN4BYEf3QKOF51ksn4quurOJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768040291; c=relaxed/simple;
	bh=wx5TdJbq6vkyS3FJ9sPE3elz2kcwj2YLr3cYFkBPNtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fc/CHFh2l1TjkCfsishuH6MqjQGIcfEbCmJbZmRrUmTJ7v0hfFZFhqcPeK9HFyNHjOMprDVsfWehSwKoGoMI3mpPI+qncDCvKsVyrTgYL7h0Fb7IYdemcHCg3ffyu6jc+Rrn80JmU0vrqKAN8fsDoKUQoJp8vpMCxDvmqhWo0fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=zrM6D+bY; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="zrM6D+bY"
Received: from 8bytes.org (p200300f6af1d9600dfc71246d978d903.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:dfc7:1246:d978:d903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id BC11D5EEB5;
	Sat, 10 Jan 2026 11:18:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1768040288;
	bh=wx5TdJbq6vkyS3FJ9sPE3elz2kcwj2YLr3cYFkBPNtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zrM6D+bYsZJjzO6wNoVjtmenlCsCUpEqSNwHUdkMSHMN4zikFKKpI2rjyFpztD7mr
	 iZENFNW8q3q+4MLDJdSdzS/oF5Glb/b0fCQRpJRAgggiWHhMklyKIpiBvh9Ow7dzN2
	 QAOzTVAofgPucCw9z4puVooPlyKiGdIgw87EnUBtm0sFL4fWvpjNbzetwz/szXdoJ0
	 GMLMskmBsHwIyFmmlzyDZvJlhOTzhjJfys+SFV/wUSbvuUVHfw8Z8FZN0piUm1Qf07
	 7vFsdom9xnekn2n4qO/AS+ZYAluL3kQ4Ocy8g13rnaaDbHHqURCjFUmcH/YuwWswYL
	 hinEVBDaiqiTQ==
Date: Sat, 10 Jan 2026 11:18:05 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: will@kernel.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com, 
	iommu@lists.linux.dev, dan.carpenter@linaro.org, lkp@intel.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Drop incorrect NULL check for iommu in
 alloc_irq_table()
Message-ID: <fceys57cwfk7wifmyt4f44wshqopfzxcrwh4ib2aypy2xfc5tw@dvzn73t3y2bk>
References: <20251222171009.44670-1-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222171009.44670-1-rakuram.e96@gmail.com>

On Mon, Dec 22, 2025 at 10:40:08PM +0530, Rakuram Eswaran wrote:
>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
