Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0513B14B1
	for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185399; cv=none; b=HNNGxo6MTUIW6u5zaOU4rQORFt7zA9sgeuApbdUGXrMUqK264ccvkDmpjwvVKzdzQmxcq8wFRDMdrIR9IUPbt3tCyMwmnOAdy8MjWeqnoPPBaG5R75VVzca33rZ4ihUi02wUzEL5pMN5X2kx3Ulgucb+HBknXz4toeTs//O5bgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185399; c=relaxed/simple;
	bh=wPMW9s0uIZQy8ipFqXmd9+biKUeSwPXSECsVixU9xmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyMccyw7So328vADxlVaLsAEDgJSHn3aWNM4KUA+u7LLF6hbfVqj1CLl9uDrOMXqnVJfJFe7FPpCSe9cx9kTlsUrBWfUDLfZ9cONvQ2grDP7JffUzW+NdmT6scbRts7pyKaWyF/97tKXwfWIZG1rqOZZ9vq5IsfPP/DAfDAYFlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C59541C0F90;
	Thu, 11 Jun 2026 15:43:16 +0200 (CEST)
Date: Thu, 11 Jun 2026 15:43:15 +0200
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/apple-dart: correct CONFIG_PCIE_APPLE macro name
 in comment
Message-ID: <aiq7YZlMhw4divmN@8bytes.org>
References: <20260609195605.149650-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609195605.149650-1-enelsonmoore@gmail.com>

On Tue, Jun 09, 2026 at 12:56:04PM -0700, Ethan Nelson-Moore wrote:
>  drivers/iommu/apple-dart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
