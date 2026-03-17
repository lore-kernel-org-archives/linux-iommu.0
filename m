Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4EF3C1979
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773750074; cv=none; b=Qjjn+ZHWnKVD8WttmuHEMIPehln3nOcfUmh0lovjQF/ds4gUYAJWDkqizCdeACiRrR7md5mbnuxQkRBK+1BoQv5XpRRigv0JMSZLlSWE5PaemPh+U9IHyHKogcEfvC78yleDxfP/nvHW3ZXHNNdxSPgcNY4B4myrRr8gdOdsumA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773750074; c=relaxed/simple;
	bh=ZLNca8NF7UKms7rrN3KKbFTqbdPs5R1MlXH5THiXRDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkuz5lGHjDQHCOYqUxpmU6NPfFAL0Jv5R8v1mmYLJMZMMrEh0AYBYAoL5bI/F68zRrPbC9WKa42thSL0S5BvkbqqD9f2N5lKG50lMhEEUSQuk35V+th8s1z+XcgR7gesXl5qLTTGLtPTjvd7GGvIl4QOv90vRtkXw030TWzEYvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=nwuj3Cuj; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="nwuj3Cuj"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 12E581A52C5;
	Tue, 17 Mar 2026 13:21:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1773750072;
	bh=ZLNca8NF7UKms7rrN3KKbFTqbdPs5R1MlXH5THiXRDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwuj3CujibP/5NF4tXYq5pMihcOhLfXkVMlc0nxmsnx9GlK+htpZIk71xjt8xMXWw
	 o8Wo6KCiwhIKzVE/XeMWP5uDkjMtFyjVvvzrfIFGoCLxdakupl2yC0slaLaDrzi0Tb
	 dbPQc0rKphbyjPUBwG1vbqPb89nnGTmc07yVc0LxmAy4c+BBX5L3ouIKeGi7t3YXDt
	 /B5mXa1KfFtHBorlooXC3SBHrgVRK5bxv196do6dXIsZNW29XtmaHyEwFYXAkdJj/9
	 qMJLs0bDG1TFZxWBzsz5ZEJsjkFsumioAiC4PAm1mM99HWJHbtrJZgvjZDWq6wx0RY
	 YwLJBu+vqMH8A==
Date: Tue, 17 Mar 2026 13:21:10 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Guanghui Feng <guanghuifeng@linux.alibaba.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] [PULL REQUEST] iommu/vt-d: Fixes for v7.0-rc
Message-ID: <pcwvq44z5v4smukknmvxspvgghbeagmsbfpssgfph5zkqr5ifw@3egkrekry72f>
References: <20260316071640.347227-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316071640.347227-1-baolu.lu@linux.intel.com>

On Mon, Mar 16, 2026 at 03:16:38PM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> The following fixes have been queued for v7.0-rc. They aim to fix the
> following issues.
> 
> - Abort all pending requests on dev_tlb_inv timeout to avoid hardlockup
> - Limit IOPF handling to PRI-capable device to avoid SVA attach failure
> 
> These patches have been reviewed and tested and are ready for merge.
> Please consider them for v7.0-rc.
> 
> Best regards,
> baolu
> 
> Guanghui Feng (1):
>   iommu/vt-d: Fix intel iommu iotlb sync hardlockup and retry
> 
> Lu Baolu (1):
>   iommu/vt-d: Only handle IOPF for SVA when PRI is supported
> 
>  drivers/iommu/intel/dmar.c |  3 +--
>  drivers/iommu/intel/svm.c  | 12 ++++++++----
>  2 files changed, 9 insertions(+), 6 deletions(-)

Applied for -rc, thanks Baolu.
