Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3493C1404
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773750422; cv=none; b=ZM/dz6jM1nVoa+NzypHEbmWYNtk8LmR3hqPTrI37/r1g4NXY9rs+rzY74Il7Wht0WEySq2tIx6ggUw9QidKpFDwWrgZEH2RQP62ChrzReUownRFfCQBbxyTC5eAjU3Xc8eYM04i4sPfJkfYmZsouGYOZohmJSskZ+pD95WVgv1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773750422; c=relaxed/simple;
	bh=Y6K0puXZFenOXG/yy30SJh9EbHLwAJBh5U56tMK4nJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yg9dIgUnIPjdW6PMotpKGGN+BItf2hdBX9XyjvBACNtX4bS4vJiVP5dJoUiT4CNQkr4gBrPDaNPwO8+4ZpMH14nbG3s5JXG9kEjr6dfYX94hH1gS33hxi9owW9gYq+Bjjil6AU3wQJf0+6PqaZ+WSiqbHG+CVUNgdszZssCdgyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=0R+cEUqw; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="0R+cEUqw"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B5CB01A52C5;
	Tue, 17 Mar 2026 13:26:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1773750418;
	bh=Y6K0puXZFenOXG/yy30SJh9EbHLwAJBh5U56tMK4nJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0R+cEUqw5p2ib6iC5U1p6dY1mgemMVuNZ2Gesn1cDUn91UmyHX81Rz2if817/mOvP
	 NgmNrJqabQ4bSgCgcBeBx/wW7vs3zDXNjPS2f7+/pQUL8surv3Ijrm0OQvq04j5WKv
	 1SqLy/5GpaPdt8Cv9qM+1NCKFSY3WG83h5V7CmvivBby20hCNuAxNJ08WMJ967v9jZ
	 yw9Bqt7u7dVHNfL3dviIr/6tZNgABCyGWB25iDCXGLtKv3BWCW+Vc6HaYIcaXloE4v
	 SFtHA0kEhmUMloll3P6jSnGn6yNkgz5u1/5RphlLG0mBMGEYUB9XxFANdJZYi8G/50
	 Bxg8zgy4bMMNg==
Date: Tue, 17 Mar 2026 13:26:57 +0100
From: Joerg Roedel <joro@8bytes.org>
To: lirongqing <lirongqing@baidu.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Add NUMA node affinity for IOMMU log buffers
Message-ID: <2fwnwibul7temcsqjyj73ibpqfp64ylhxe7wbkdmwgzilqr4a4@6zhpyakis2l3>
References: <20260211035839.1970-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211035839.1970-1-lirongqing@baidu.com>

On Tue, Feb 10, 2026 at 10:58:39PM -0500, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Currently, PPR Log and GA logs for AMD IOMMU are allocated using
> iommu_alloc_pages_sz(), which does not account for NUMA affinity. This can
> lead to remote memory access latencies if the memory is allocated on a
> different node than the IOMMU hardware.
> 
> Switch to iommu_alloc_pages_node_sz() to ensure that these data structures
> are allocated on the same NUMA node as the IOMMU device. If the node
> information is unavailable, it defaults to NUMA_NO_NODE.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/iommu/amd/init.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Applied, thanks.
