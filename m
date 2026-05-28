Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E558033D6CA
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 07:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779953411; cv=none; b=G+GzfSIbYX400BnbLxwe1bYGl+UseZXBiozgyW6/wmd+rOs9Sv26iOSCTXtzAqqHjaWZOZFs/2HC2CjLrI+7wCVkpzC6Nr473WOiv/eYimcCMYk/GiAiwtv+hTOpIQ7o/+SSQAYdrJTyBUdjZuC22hQTzC6Pspz/qEk1zyJV/JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779953411; c=relaxed/simple;
	bh=F/Vax+KP+dfMXToqIHYJn1xk9lZhF3ezmRoNKlq/fHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdLoC9w4uOaPpRztwXFpB4hZhxXfYl4BG5V7MBeQuleu+WaPKzht8RQBT0n8/pujV06bD0+RiEYh+WdcaSla5CYUdKJIgcWM76gBWzYf4So05CrOp+fD57ROEeXmz3OBlCKCVtMm2pRvRerNOHZAtm+s2BX2ItUs3KloUYR+BBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc5001a5b4667a2accba1.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:1a5b:4667:a2ac:cba1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9037B1C5BA7;
	Thu, 28 May 2026 09:30:07 +0200 (CEST)
Date: Thu, 28 May 2026 09:30:06 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: vsi: avoid -Wformat-security warning
Message-ID: <ahfu7oObdUegF6y_@8bytes.org>
References: <20260519203658.1341889-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519203658.1341889-1-arnd@kernel.org>

On Tue, May 19, 2026 at 10:36:51PM +0200, Arnd Bergmann wrote:
>  drivers/iommu/vsi-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.
