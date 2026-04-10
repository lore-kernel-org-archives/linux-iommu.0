Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948B63B0AD8
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775856014; cv=none; b=RSavPMxReh8jVKCbfi5r4t+vxhwl0p6YyYa3gwpVDoAwy0g30uckYeIZFgIO2BGYyhcWzfkxmy8H0/vxyMPmOV87h1sr0/DC3o7fjPs157uiM5C8sg/zrAtyFCrkQfflcY5mv78+VJ/4tMP2XiwYFciHRXq8AUmQ9bKxG3sm2K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775856014; c=relaxed/simple;
	bh=bAVf5dziE3n9sMUb+IutPPzrT6D982ys03QGEKYquEE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngGtxS6YKGOoya7v1rLEd96LYqUKMHJpSpdeGKsVrEoFAH05j+lluguumtTEi7BeDb0E9cx1HkvigP9qC2zZcJGm7yKkck29OoqlVAzziFekrVSxka2nvacvaX2GU4C0ApzB8TtaL6mr+y1l52sWH7FWIUSAx6hbdAASSLg5K/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dcpvis6n; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dcpvis6n"
Received: from localhost (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 94EAE20B710C;
	Fri, 10 Apr 2026 14:20:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 94EAE20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775856012;
	bh=MdhjHpfFjc1U9e8MiYKfNb0CNIP/5xNS0qbh2SHRykM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dcpvis6njZvEzwYUNWHkXH77KiSj7W9FbWK8UhHxKuG4CWdsTK/9RiMrLxhYVMhGI
	 QobzR1OZRIwavppHDCBN6f6mW/KhR2COah+/YB88W/U8n2AMBjmbHiFSCRNAHotFFM
	 yXF15uvxWt6UQNna2/UkD2tnphMtGKgrYwp2XGr0=
Date: Fri, 10 Apr 2026 14:20:10 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, skhawaja@google.com, pasha.tatashin@soleen.com, Will
 Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V3 04/10] iommufd: Add an ioctl IOMMU_IOAS_GET_PA to
 query PA from IOVA
Message-ID: <20260410142010.00006811@linux.microsoft.com>
In-Reply-To: <20260409182624.GN3357077@nvidia.com>
References: <20260403051146.10210-1-jacob.pan@linux.microsoft.com>
	<20260403051146.10210-5-jacob.pan@linux.microsoft.com>
	<20260409182624.GN3357077@nvidia.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jason,

On Thu, 9 Apr 2026 15:26:24 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Apr 02, 2026 at 10:11:40PM -0700, Jacob Pan wrote:
> > +	*paddr = iommu_iova_to_phys(area->storage_domain, iova);
> > +	if (!*paddr) {
> > +		rc = -EINVAL;
> > +		goto unlock_exit;
> > +	}
> > +
> > +	tmp_length = PAGE_SIZE;
> > +	tmp_paddr = *paddr;  
> 
> shashiko also points out that the length is too long if IOVA is
> unaligned. We adjust the phys for unaligned IOVA but not the length:
> 
> @@ -879,7 +879,7 @@ int iopt_get_phys(struct io_pagetable *iopt,
> unsigned long iova, u64 *paddr, goto unlock_exit;
>         }
>  
> -       tmp_length = PAGE_SIZE;
> +       tmp_length = PAGE_SIZE - offset_in_page(iova);
Will fix and add an unaligned iova in selftest
vfio_iommufd_noiommu_test.

Thanks,

Jacob
