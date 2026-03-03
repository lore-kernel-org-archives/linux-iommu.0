Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265BD48A2CD
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 19:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772565214; cv=none; b=C7IaAVbqk1mKX5lI6PxKi7aI9lDtMaZ7ZiOqUg49T1hbg6Qz38T1QFkKVJjxY/NNh6t7VKhY6cQGBL8279XJaD+fRk4uAarfO241e6hm7RRDmukQrJFV7nGjmRRzbeWrBrVMqS458F5NhMzT0I74iAiE0tRRc+KaYSnmECFUAys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772565214; c=relaxed/simple;
	bh=M6UzC8abs2yiivLc64lyWXlrxEfxIAUxFsVJ6CD4Ktk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1DVJXRjTQ6lLmZPegNpo0Puj86D9zOCFryLIFYaubf2gBFfGSFI+4k+r44uHLyGNsZTJcvSpSqSUZcmr/rHerMCutMgkMxgLDpXWXTlo1YiM8/jv6BGNCAyY5taR1S1x2KsXWnvVqhGJtopz97rR8+crrborGHyhIkLBOeT0EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=J5zYoIzU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="J5zYoIzU"
Received: from localhost (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id D6D9020B6F02;
	Tue,  3 Mar 2026 11:13:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D6D9020B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772565207;
	bh=3Iz81aK50x5DZQYgqCzVjHxCGTdFmkxXP8vnLYiwzY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J5zYoIzUntyDwoPF1Eoenw5OsNrQxDx4fUOzQvPZnlG+OZ4hol8QHy6JifhXu8zNm
	 4mJWAzSp0rRshpe1NYXB2OvWpsbaZcmdWi7vzozqTp+3tJGRVXs6dYUGEwCuCt7nji
	 AEJCvDHd2G8Q2BYiUSD08t0fK2Cada6IuksriLD8=
Date: Tue, 3 Mar 2026 11:13:25 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
 <joro@8bytes.org>, David Matlack <dmatlack@google.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 skhawaja@google.com, pasha.tatashin@soleen.com, Jean Philippe-Brucker
 <jean-philippe@linaro.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 00/11] iommufd: Enable noiommu mode for cdev
Message-ID: <20260303111325.000010a2@linux.microsoft.com>
In-Reply-To: <20260303003532.GA5933@nvidia.com>
References: <20260227175247.26103-1-jacob.pan@linux.microsoft.com>
	<20260303003532.GA5933@nvidia.com>
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

On Mon, 2 Mar 2026 20:35:32 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Feb 27, 2026 at 09:52:36AM -0800, Jacob Pan wrote:
> > VFIO's unsafe_noiommu_mode has long provided a way for userspace
> > drivers to operate on platforms lacking a hardware IOMMU. Today,
> > IOMMUFD also supports No-IOMMU mode for group-based devices under
> > vfio_compat mode. However, IOMMUFD's native character device (cdev)
> > does not yet support No-IOMMU mode, which is the purpose of this
> > patch.  
> 
> I browsed through this quickly and it looks OK to me, though I might
> suggest correcting that FIXME so that the get pa scans the domain for
> contiguous physical address. You can copy the loop from vfio probably.
> 
Thanks for the suggestion, I will add the following to v2 and update
selftest with hugepage to cover this.

--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -877,10 +877,19 @@ int iopt_get_phys(struct io_pagetable *iopt,
unsigned long iova, u64 *paddr, goto unlock_exit;
        }
        /*
-        * TBD: we can return contiguous IOVA length so that userspace
can
-        * keep searching for next physical address.
+        * Scan the domain for the contiguous physical address length
so that
+        * userspace search can be optimized for fewer ioctls.
         */
-       *length = PAGE_SIZE;
+       while (iova < iopt_area_last_iova(area)) {
+               u64 next_paddr =
iommu_iova_to_phys(area->storage_domain,
+                                                   iova + PAGE_SIZE);
+               if (!next_paddr || next_paddr != *paddr + PAGE_SIZE) {
+                       *length += PAGE_SIZE;
+                       break;
+               }
+               iova += PAGE_SIZE;
+               *paddr += PAGE_SIZE;
+       }
> Also the kbuild error needs fixing, I gave a suggestion for that in
> the thread.
will fix in v2.

Thanks again,

Jacob
