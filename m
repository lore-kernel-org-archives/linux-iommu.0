Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28BA1E8323
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 07:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744355116; cv=none; b=DlqKuWXgm2lATo+GyWhpd/c+ynaOE1GyeuO5UCNmeTGOAC3Zm4Ap9P/IwgYt0ergFg5FIBCYMR1QTsyPmpnguWvNbd4XWj2tgpvOjzfBqm43hgiCEA6WWRvTuW0cxp72a7q+lgVxRxM0zHzOMWK44zq9Q3X4B3xQUuAsEwZSrNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744355116; c=relaxed/simple;
	bh=IJpnPnrvmdznAnhYExSv88kU9YA6wC83pHo7gVmH7Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgU1J5BAMGLqLuZeU0dHHpM/x9htIvF7rJFFZNYaQ94s0ESds366peTSQnlLZJ785VI9ywVyIzpJ+XmSNXrGtDfy8h12hPURWhC3q+u5tAmoBYP+s3U10tFd8q7TN2nD9rdnNfGuRxS2A+R7i4/ZZIFt2RGa+RUOuaq37ZdD1Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=XC8TlY7V; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="XC8TlY7V"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7F48646242;
	Fri, 11 Apr 2025 09:05:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1744355113;
	bh=IJpnPnrvmdznAnhYExSv88kU9YA6wC83pHo7gVmH7Yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XC8TlY7VHL4h/Gk42QEUy7wNI37WnG1ayWehUJT1oXAQO7zuPUJcZHnd3KitfhNc9
	 Cu0l0g/rac8KBalO7wi+NLzNwEDHMlbTQPJsDwvK4WV51VjbfuSOO6MpeHmxz7PRU9
	 xur8fnu+/JmtzIScEpOFVQfV9s/dlC5pILxJP5l4oAR+kQRLftGv391SfERlHuifky
	 5aiOj2t8KcVrjGL099UjMtxzxnzNVhGSsvhG+6UBVHNIGHta2d1fPFbldaSC75AZEf
	 DYXZ4LxdhGGLv3vw4AitJHoTLOYRSfZCVKoRT3AD4nAjSmoqxUJAkN7JD55lw7+Dis
	 wdnlzXXNe7bdA==
Date: Fri, 11 Apr 2025 09:05:12 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] iommu: fix crash in report_iommu_fault()
Message-ID: <Z_i_KGB-ew95szQ0@8bytes.org>
References: <20250408213342.285955-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408213342.285955-1-pchelkin@ispras.ru>

On Wed, Apr 09, 2025 at 12:33:41AM +0300, Fedor Pchelkin wrote:
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 6aa63a4ec947 ("iommu: Sort out domain user data")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Applied, thanks.
