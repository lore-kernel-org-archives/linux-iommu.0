Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12923115B5
	for <iommu@lists.linux.dev>; Tue,  4 Nov 2025 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762251466; cv=none; b=JkSMqwcVvNaLn2rXbxuOs7j0JXfU8Hj7wpnYSnai8S3PAfqQZQ6bckH0PujFjN9qKvUa1E2m1uRLCLUBt2NldeixPwESYLINIpqetXfUcGqDx++wNTE4GSQVo9qIAAgYgDebKB/X6mB7u1c0czzy0bOYAHfDnNUTXQ0ZTJuYGaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762251466; c=relaxed/simple;
	bh=XhzvhWY4z4E6C405niX0EnBfTMi66BtzgeSasy+8cY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZ3ZdlDgN8PR0bAnpNLOVMFEK+uxWJNV2kmW5c1b45dCgBIJ4VjIvLIq89+7xwQ2l4o5wbuywXKCvnQu8IHKu9a0ysfJVRp+3EP70lBaV0oZR6rnJsx9cWs25xznpgW6DZDlHifA2Vvv1sOty+l71ASQe9sF5zpUHNRLYNh8WvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=jm4A72rn; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="jm4A72rn"
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5514E5A5D7;
	Tue,  4 Nov 2025 11:08:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1762250911;
	bh=XhzvhWY4z4E6C405niX0EnBfTMi66BtzgeSasy+8cY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jm4A72rnY9VQnOuUxB05iARNIBBwK2NdnXMbp5zPXHSI8reF2F+Pk4KQZ3Cud1IUD
	 dF1rb2kss1UKOOlm3eR7ZH54LNNTcWHYGD8GHbcGRlvaCitOy31onzfGuBoW7gfZLW
	 dMSRo47bDG7JQTqdx0ivXByMkLnajZdaU6MWg79WlGoKdLZ6tXt/mI8aTCUZ85sSWJ
	 kzt5bgcYSHJO/sgT2DdKqhsR+zfY202PBxtr1TeaiPSFZxpo/FIhtI+Gc8v3P6UpQR
	 ncgQkKgn8e0C5Q3dC8AkhdU7t0yfZPLP2H1JtuF9QBihA12Vw7QGuzXm1R1odqnlpd
	 7MABcrGt5Ee6w==
Date: Tue, 4 Nov 2025 11:08:29 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Songtang Liu <liusongtang@bytedance.com>
Cc: will@kernel.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com, 
	vasant.hegde@amd.com, dheerajkumar.srivastava@amd.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/amd: Fix potential out-of-bounds read in
 iommu_mmio_show
Message-ID: <bnwect65iw3jf44fszo6fm4fauyoextyk45pquxur23n25pmsx@owfja7cr2xzl>
References: <CAA=HWd1wtM3QkqLkLC0-GtMNykB22jkd5rSYj=PchKFVT2m+Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA=HWd1wtM3QkqLkLC0-GtMNykB22jkd5rSYj=PchKFVT2m+Vg@mail.gmail.com>

On Thu, Oct 30, 2025 at 10:55:25PM -0700, Songtang Liu wrote:
> Changes in v2:
>  - Add Reviewed-by and Tested-by tags from Dheeraj Kumar Srivastava
> ---

Git ignored everything below the above line for the commit message. Put the
changelog after the commit message next time. 

> 
> In iommu_mmio_write(), it validates the user-provided offset with the
> check: `iommu->dbg_mmio_offset > iommu->mmio_phys_end - 4`.
> This assumes a 4-byte access. However, the corresponding
> show handler, iommu_mmio_show(), uses readq() to perform an 8-byte
> (64-bit) read.
> 
> If a user provides an offset equal to `mmio_phys_end - 4`, the check
> passes, and will lead to a 4-byte out-of-bounds read.
> 
> Fix this by adjusting the boundary check to use sizeof(u64), which
> corresponds to the size of the readq() operation.
> 
> Fixes: 7a4ee419e8c1 ("iommu/amd: Add debugfs support to dump IOMMU
> MMIO registers")
> Signed-off-by: Songtang Liu <liusongtang@bytedance.com>
> Reviewed-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> ---
>  drivers/iommu/amd/debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, but next time please use 'git send-email' to send patches. This one is
malformatted both in the commit message and in the patch itself.
> 
> diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
> index 10fa217a71199..20b04996441d6 100644
> --- a/drivers/iommu/amd/debugfs.c
> +++ b/drivers/iommu/amd/debugfs.c
> @@ -37,7 +37,7 @@ static ssize_t iommu_mmio_write(struct file *filp,
> const char __user *ubuf,

Weird line-break.

>  	if (ret)
>  		return ret;
> 
> -	if (iommu->dbg_mmio_offset > iommu->mmio_phys_end - 4) {
> +	if (iommu->dbg_mmio_offset > iommu->mmio_phys_end - sizeof(u64)) {
>  		iommu->dbg_mmio_offset = -1;
>  		return  -EINVAL;
>  	}
> -- 
> 2.39.5
