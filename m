Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE066320A37
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763369214; cv=none; b=htPylYkWnBMD+GXgX3IoFpyHeKtvsWuIg1HnriycK5PkUm7c7VUXwPLJZW35407HK75PnXdzen+rN0HSqzkzqDOjiFSavN64tbdsoX6DbVQlUjKWR9wWe0uSlZmJId3D2C14gaq7ZoyHPZ+W86IXTn6sHCVLb69+TnvvyRawzes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763369214; c=relaxed/simple;
	bh=kMIwKzXEp7trBH1ojHbdVeNg2EBxfwb6Y2kZCX/93SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPVzr3NuKw3xmPeapnnUmF+AUQeqzgrdd2D91pFWmIA6UX2SYg76jiBdtn6nvDFiL4yRMDivysgN6Un136utE8wSwFE7DUOqYJd45L7e5Mbpoe4aJxXDyX9an3KG/fuJge+zfMKyWgDDJl4UqcUM4JOHbBx6D8PPPrB3klbA1vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=8ccfh/b3; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="8ccfh/b3"
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 10B585029E;
	Mon, 17 Nov 2025 09:46:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1763369205;
	bh=kMIwKzXEp7trBH1ojHbdVeNg2EBxfwb6Y2kZCX/93SE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=8ccfh/b3L3vHELkV+/a/dbQmLR/AWIWjnm+sXzarQ6IxhlZhxBLLOGr3QDJSEbHQI
	 ElQ9Z6/MJk4J9iCYpo1C034m/L/27SIiDrgK4SDgmUqe/UzkQDtedjrA0/91OpAJUR
	 aZVsF6uQTJ/m2kdUR5akrWBCsvb7qd1pZQXjOIyrZ40FdzNpDPPM7B4XzAE3YeLoTY
	 aBXA/pHPUE4ldrDwmXYHpa0he9iAK2S1C8fS0I0Y38jiidvi3sz6LA8qTWKeH6CMd6
	 1S8cr1/7ImM8X+7ZnQxT+TzRPqQEG37+vJ7UhBByGrf/zqbVDUUiPDZ/IDrEyKodpi
	 hQaPZpzKqkpUA==
Date: Mon, 17 Nov 2025 09:46:43 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux IOMMU <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] iommupt: Actually correct
 pt_test_sw_bit_{acquire_release}() parameter description
Message-ID: <bevcd6b7bjvr4l7zl4vxcadp7ipiijczljy4ed3527zm2el6x6@bs4gqsnobavd>
References: <20251107233316.7256-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107233316.7256-2-bagasdotme@gmail.com>

On Sat, Nov 08, 2025 at 06:33:17AM +0700, Bagas Sanjaya wrote:
> In review comment for v1 of genpt documentation fixes [1], Randy
> suggested that pt_test_sw_bit_acquire() parameters description
> should be written using "to read". Commit e4dfaf25df1210 ("iommupt:
> Describe @bitnr parameter"), however, misunderstood the review by
> instead using "to read" on @bitnr parameter on both
> pt_test_sw_bit_acquire() and pt_test_sw_bit_release().
> 
> Actually correct the description.
> 
> [1]: https://lore.kernel.org/linux-doc/9dba0eb7-6f32-41b7-b70b-12379364585f@infradead.org/
> 
> Fixes: e4dfaf25df1210 ("iommupt: Describe @bitnr parameter")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  drivers/iommu/generic_pt/pt_common.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
