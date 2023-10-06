Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FC279C3
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="nM3ymBM4"
Received: from 8bytes.org (p4ffe149c.dip0.t-ipconnect.de [79.254.20.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 36AC71A2E0B;
	Fri,  6 Oct 2023 16:02:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1696600951;
	bh=ROzxSeAMBVvMsdv372r+vJML6kpnVnp2s36U7S3xv7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nM3ymBM4MiLT95SdudUgk4a3CvPRlOKyAh1xG8lRNk4HNLT3qH2KkqCey2S7hR/jR
	 knmKIGLZiRfqF0CE2EV17gSDGYmeoAEfMC8V5MSBozCpYY9r6659UQa9fA/bA/ZIes
	 PwAcwYBBp67cZmkkLjwRNz9sPwmHHocpCUsIcO/mkLh+0LHWa1CEoDH++I+Vk9rPri
	 nQOTqHzZavvCkU/hEsbEzV+QRJesMzZ8+hyLWh9dOebtiV7a0cs8AaKpc4tC0jQ85x
	 0Xcch9nakWyKMeXZhH+zu///A9UfKmU6wf2ybOClnWqEUL1Jqp5tgEiDt/qZZUCJVk
	 4NWXyXsMQsGiw==
Date: Fri, 6 Oct 2023 16:02:30 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com, jgg@ziepe.ca
Subject: Re: [PATCH v4 0/5] iommu/amd: SVA Support (part 2) - deprecate
 iommu_v2 module
Message-ID: <ZSATdt1RnvUYXIZ2@8bytes.org>
References: <20231006095706.5694-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006095706.5694-1-vasant.hegde@amd.com>

On Fri, Oct 06, 2023 at 09:57:01AM +0000, Vasant Hegde wrote:
> Vasant Hegde (5):
>   iommu/amd: Remove iommu_v2 module
>   iommu/amd: Remove PPR support
>   iommu/amd: Remove amd_iommu_device_info()
>   iommu/amd: Remove unused EXPORT_SYMBOLS
>   Revert "iommu: Fix false ownership failure on AMD systems with PASID activated"

Applied, thanks.
