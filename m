Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07DF161311
	for <iommu@lists.linux.dev>; Wed, 18 Dec 2024 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734510869; cv=none; b=U2/hI6DbeC2RXDFX0ITXpKI4vzuZ8vT+cCEsNm0hQFJkege/HxA3huJq8KQv49ryHJ8gWAePwjHJT3WnXj+kMD3uEEF4Kb4h/ZX0drM+Xqib+49zkUvrHjALrXUovlQp7nvngsKFjwMXoZmfWcSm26ZUjn00UN+zDpP3CFamTjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734510869; c=relaxed/simple;
	bh=AXgiAqf8zCy4z4l+ZTo7yj4JmZDdaTu2SLMSWq8tnIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psMubOyhd++1b5e+lw0zZZTT57JPeDlBXHGCOmXxly5RVlb+loUf3Vh4/u3Y+p11vBUAeca2dM6V84KtJQWRGdWL17nm9yjdJZ/0VPUUWKo3Uh56y2diQk+0+r+OyodBpcZ3fIwth3005+OVifbbeQ3xUzkGLCZKc75WuRdcQeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=L/PhBiQX; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="L/PhBiQX"
Received: from 8bytes.org (p54921e31.dip0.t-ipconnect.de [84.146.30.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E881F2C1E66;
	Wed, 18 Dec 2024 09:34:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1734510867;
	bh=AXgiAqf8zCy4z4l+ZTo7yj4JmZDdaTu2SLMSWq8tnIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/PhBiQXCXvUKtQdIm9SMrOIEG/IPm44+d3XGhPbvXnJbzybv53AcIZwyf5SkhHuR
	 SXxBQukR52ioyiEwII+nyrYUhTxEHkzgjodjMVZ8iYc8HdTGW/efqBbcv7PqObKH54
	 kg0vTaoZECbO0HI+AlSTo6Bal7djOaqV+svGcDuFEgVuwAr54TiWk4ZZl/vU3WuN5E
	 oUDwqenELP4tflBZycWNPIfrPW4ruT7LtRcZPyy5AN5WbzcbogyWo8qFgqkxt8Tdt+
	 8NHubypRIuLmUBGw5BGckHCYHHy6ruqajXfLd/xwdoXYRsupbHfFkTejD7Kz8CWMG6
	 aUOmSPjK4elDQ==
Date: Wed, 18 Dec 2024 09:34:25 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Kees Bakker <kees@ijzerbout.nl>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	Tian Kevin <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iommu: Avoid use of NULL after WARN_ON_ONCE
Message-ID: <Z2KJEUdGD_DFq_Xl@8bytes.org>
References: <20241115190316.28A6B18DFF2@bout3.ijzerbout.nl>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115190316.28A6B18DFF2@bout3.ijzerbout.nl>

On Fri, Nov 15, 2024 at 07:46:25PM +0100, Kees Bakker wrote:
> There is a WARN_ON_ONCE to catch an unlikely situation when
> domain_remove_dev_pasid can't find the `pasid`. In case it nevertheless
> happens we must avoid using a NULL pointer.
> 
> Signed-off-by: Kees Bakker <kees@ijzerbout.nl>
> ---
>  drivers/iommu/intel/iommu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

This patch is Intel VT-d specific, please use the 'iommu/vt-d:' prefix
in the subject line.
