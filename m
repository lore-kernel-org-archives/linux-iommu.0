Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D10A47DD6D
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 07:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531763; cv=none; b=ir32crlKcw6oyYhyDvnBYWLgGL52ZnC3zgURbYp3JVpOMzLGqfopJGs+0MVap+vNXyjD6VokaFs3IW+YFp7g+b//jXQs0X3Gp2WPRWsRIS2pDAayuxdiA24l13TFA4Arsx/LIALW8LOXPLmiXpBMHRbjPG8v6dT0gmlQ8deaWZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531763; c=relaxed/simple;
	bh=ttTgc0TBMKNpVqPimza+iyOXZq5xcMS9RuWdrtdHnws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGd5b3xFtMPbL0mD6P5zxiPx+NvyPK+9bwZrQ96lN7J1Tau1BQHeCbd8lV5BAAxcozbNMsNL9aEUs5A86S8yfBlLoOvZl6U602m+HZ85YYTapawl3rwrD/EeMCyrgfTZzKOKzLUf0aIfikrg8aZ9Rz1WVdc3S7at9Y1gl8UBTY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00448550d0471e54ea.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:4485:50d0:471e:54ea])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5DA2F1C77A3;
	Fri,  9 Oct 2026 09:34:38 +0200 (CEST)
Date: Fri, 9 Oct 2026 09:34:37 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Make iommu-dma helpers private
Message-ID: <asiY-QQGSya10kOU@8bytes.org>
References: <ddcc6f8487366211af0d81ad9af2376ec29d8460.1790596307.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddcc6f8487366211af0d81ad9af2376ec29d8460.1790596307.git.robin.murphy@arm.com>

On Mon, Sep 28, 2026 at 12:51:47PM +0100, Robin Murphy wrote:
>  drivers/iommu/dma-iommu.c  | 1 +
>  drivers/iommu/iommu-priv.h | 4 ++++
>  include/linux/iommu.h      | 2 --
>  3 files changed, 5 insertions(+), 2 deletions(-)

Applied, thanks.
