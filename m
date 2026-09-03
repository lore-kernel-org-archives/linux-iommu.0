Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D515B3A16BC
	for <iommu@lists.linux.dev>; Thu,  3 Sep 2026 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422933; cv=none; b=Cxex16HhtU+rNImwvw+zk/Rxa8mCVVYy+zGUnno4SxX21SBTmMrkyHvIYxiXvnZ+AgbyYJrLNEJQJoSj1h2CzHzT6yyQA+nPixmzqkecwBkmWC1WXbZ9kzppf+yugAMUSNZYfizEgfoFB3kBloGbyV+MZ1B4rAWmskYNDFepc4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422933; c=relaxed/simple;
	bh=YTXYR3HJ877QdAeG6YnuoEKdZssQR3Ei3AOpPYm8L/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrmcvZBNkuC21I3RsRhZ27epVYfneyazB1a0zuIh3YMo02VePsQEF9v0asiTN+QV3BMyX4ZrhOnmQ7MSTg6kXDDzSdbnKRO5gz55u8GlATZgBfV83e1r1PtShxBD1NUWNJ26exIBFa+ddVJIz6RfDWC0dOboWYIyq0f9ZoZg0n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ir4E3dVe; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ir4E3dVe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788422930; x=1819958930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YTXYR3HJ877QdAeG6YnuoEKdZssQR3Ei3AOpPYm8L/U=;
  b=Ir4E3dVeLHvo+CZgm0sZq/6oxygSa0KBB+8aqXlx1orX+fQVqZjeDcJR
   UBOfEq3qLuyumAk5GL90ayyTTERWc7GohrtFmgZEFfWmNjXh9To8nA4dL
   PIcGcNaFH6ustY9N7B0VkNq91RlD0PbXsrkkWW2OokVwiEIaFXr93lWOH
   C1s2VD5P66dffqwXGxl5v7MZ+tR3CdAxMUmuP31Toq9PeakfMrjh0OsSL
   pjdhBvM5OY4BtV2En8r7Woq0fJc0euYvhvZ5LDKs0yca12uYGsrDIkbyq
   aBN3paLXAMtT7S4mjPZtZGTIYUsZ1uis4PggElNyQ803bWeYdaaTZxXXM
   Q==;
X-CSE-ConnectionGUID: Y9WSLas1Q5iIl+BjGGfSWA==
X-CSE-MsgGUID: NTT1z6E0Qnyj4rJ5fBzdwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88036677"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88036677"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 01:08:50 -0700
X-CSE-ConnectionGUID: 6paLz0wmQBKE09vOAy1JTg==
X-CSE-MsgGUID: IwbFULBMTeyQCfCWutzFOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="299514253"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 01:08:48 -0700
Date: Thu, 3 Sep 2026 16:08:44 +0800
From: "Lai, Yi" <yi1.lai@intel.com>
To: Qinyun Tan <qinyuntan@linux.alibaba.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, yeeli <seven.yi.lee@gmail.com>,
	Xunlei Pang <xlpang@linux.alibaba.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, yi1.lai@inte.com
Subject: Re: [PATCH] iommufd/selftest: Return dmabuf fd from
 IOMMU_TEST_OP_DMABUF_GET again
Message-ID: <apkrDCjfzBobiwm/@ly-workstation>
References: <20260902085414.549830-1-qinyuntan@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902085414.549830-1-qinyuntan@linux.alibaba.com>

On Wed, Sep 02, 2026 at 04:54:14PM +0800, Qinyun Tan wrote:
> The selftest helper reads the new dmabuf fd from the ioctl return
> value:
> 
> 	*out_fd = ioctl(fd, IOMMU_TEST_CMD, &cmd);
> 
> Commit dba4254e216d ("iommufd/selftest: Fix dmabuf leak in
> iommufd_test_dmabuf_get()") fixed the dmabuf leak on dma_buf_fd()
> failure, but the applied version also changed the success path to
> return 0, so userspace no longer receives the fd.  Note the patch as
> posted on the list returned rc here; the change to return 0 appeared
> when it was applied:
> 
>   https://lore.kernel.org/all/20260707030635.221577-1-seven.yi.lee@gmail.com/
> 
> Every test using test_cmd_get_dmabuf() then operates on fd 0 instead
> of the dmabuf, and the dmabuf_simple and dmabuf_revoke selftests fail
> across all fixtures:
> 
>   # iommufd.c:1595:dmabuf_simple:Expected -1 (-1) ==
>     _test_ioctl_ioas_map_file(...) (0)
> 
> Keep the dma_buf_put() on failure but return the fd on success.
> 
> Fixes: dba4254e216d ("iommufd/selftest: Fix dmabuf leak in iommufd_test_dmabuf_get()")
> Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
> ---
>  drivers/iommu/iommufd/selftest.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> index ee706f18f7e91..f6da927461b57 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -2056,11 +2056,9 @@ static int iommufd_test_dmabuf_get(struct iommufd_ucmd *ucmd,
>  	}
>  
>  	rc = dma_buf_fd(dmabuf, open_flags);
> -	if (rc < 0) {
> +	if (rc < 0)
>  		dma_buf_put(dmabuf);
> -		return rc;
> -	}
> -	return 0;
> +	return rc;
>  
>  err_free:
>  	kfree(priv->memory);
> -- 
> 2.43.7
> 

Applied on upstream v7.3-rc1 kernel, issue was resolved.

Tested-by: Yi Lai <yi1.lai@intel.com>
