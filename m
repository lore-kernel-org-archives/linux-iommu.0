Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83D714BF85
	for <iommu@lists.linux.dev>; Fri,  3 May 2024 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714731964; cv=none; b=DppcWou5Kj3tAUiQEb9ZECLJi9lOiQwcxMeZTXGa5JVr++DSynnT/rsktU+2YzhuVTn5j5n7NbLjrZ98lwCpbJkUPztzD3IgCSWX6v9sck7rMhl3rVlCqV6H+ifWbiccxwFgXZS2XKpwzPPNlXT6mQi+QfensP349UQa8u8kdkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714731964; c=relaxed/simple;
	bh=goxkfurL8ChNBrBicc4FrHAYHXUEE+XF7YllI91MZY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTLOduGv5rHiuTLjX/E0VnD2W2wC02QJMhkZoAN1+uLsKkWiKi0GSMsAAkYM3DJ69RFDrcPEg0bHnLrf+oF/PwyKJpizI2g8pHj9yN80bwUZO8AL7IDY5+J69IEu88QySHMoW9cZPmnrWINNO50dc37n+v3IBmq8o31V/cmo/y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=xZzkDhD+; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="xZzkDhD+"
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 6182C1C0B69;
	Fri,  3 May 2024 12:26:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1714731961;
	bh=goxkfurL8ChNBrBicc4FrHAYHXUEE+XF7YllI91MZY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xZzkDhD+YGHMlvu8/+Rsfbqg08ropbC/JmXBWTqDAT5h7Oq12j7SMn20vC3u98/yE
	 2iE+FlM2A5V7njgRABLrrEP6z6kG7cfwA6jQD94vLGEYXT+ZiwcWNA3/kFyv11eAMu
	 a/w3D1r6/tecQMntxo5jbPfx44ibU0ZroXsz5nOKPkoY7T0fGlzqER4nODg1t5M6zM
	 owdCjn6S9nq5ApmprwluFmTubFzBCBPAs8GB+VJlea5Vc4sZc6XY7QcR+4oWrcko8k
	 cAxQKCjHfZvsckdkX71LTjztOWXnNqzwZl+AHo2qTfpU5sXMS0Sq6DTevTXGz/Tagg
	 Q6xjdPvXkSiqg==
Date: Fri, 3 May 2024 12:26:00 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Klara Modin <klarasmodin@gmail.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com, jgg@ziepe.ca,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v8 07/15] iommu/amd: Setup GCR3 table in advance if
 domain is SVA capable
Message-ID: <ZjS7uFRQ7_o1HUjl@8bytes.org>
References: <20240418103400.6229-1-vasant.hegde@amd.com>
 <20240418103400.6229-8-vasant.hegde@amd.com>
 <333e6eb6-361c-4afb-8107-2573324bf689@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <333e6eb6-361c-4afb-8107-2573324bf689@gmail.com>

Vasant,

On Thu, May 02, 2024 at 03:16:18PM +0200, Klara Modin wrote:
> This change seems to interact poorly with the amdgpu driver. It fails to
> initialize properly (monitors go to sleep).

Can you have a look please? We need to resolve this otherwise I have to
exclude the x86/amd branch from next, as I can not send code with known
regressions upstream.

Regards,

	Joerg
