Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834773BC674
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749491; cv=none; b=NbCEVq1Y6SDeQITcbjfmEVGTzvSgZpm9naXVOnyfIyunsPWw0btyXGWwB4KoK5UGU/Bmk6DsJRJHb8cN0EmCeq71Xklm/ffSAWVQt/EWrQ+OESLQRCzp4yGMNZM+cNgjEsovUmDMXYvoImBb6nFUtdwLFaaTTyjoE8VBMTrwr74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749491; c=relaxed/simple;
	bh=Utd6oJ1tj+m9Jqdz7mT53RoWT6GNYXeD2+o7QCiiQkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gncHcS1xZn8UPRA/yvEJ+KXkPIDnBvj4e7Iw9SWs3SP1c/JJa4TpQFsD08vpmRBGZlt6kpknXrU58tH5D9YjAr0Lx9BsVzae1JXEDv9eSrQNN0dmw/jmq2AYIPYU/8it/1U4XG23vlqCl2bRRc5OjcrqMlXWs6YdQTqkB4qXt8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=oB0y0qE+; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="oB0y0qE+"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1FC241A3FD6;
	Tue, 17 Mar 2026 13:11:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1773749483;
	bh=Utd6oJ1tj+m9Jqdz7mT53RoWT6GNYXeD2+o7QCiiQkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oB0y0qE+SCdnlDpM2y+Mn8a/rTEGxabKolC/EhFVeCZyJUvyfE9DU7/L/gU9FvvvL
	 7Lu6zzQt+Iq4lnjuDhlxb7UCzDtC98tYiRc0nAbYhaegU2a2b9uoGgRC5kevSq97kX
	 uKPjTJ0ciJ6HgChiAJ0m0EYVxWP+OW7fy1ntJnfb8xDL6L/l18S7OFChno+9TRBAAj
	 mCoL2AyPyZjjUjDIPkBzVxfk+y2YOawcBjkwaQWReOsBp2ZRmn6VpYkDznBtMRjZJr
	 NMG2px4vUe+RfmH40cuH9TzBcL8JTzEvRdmiGNpJUoIrmoHKCLUaO1twqJcViY1lJ7
	 ld15RUhU2VaOw==
Date: Tue, 17 Mar 2026 13:11:22 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: fangyu.yu@linux.alibaba.com
Cc: tjeznach@rivosinc.com, will@kernel.org, robin.murphy@arm.com, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	baolu.lu@linux.intel.com, zong.li@sifive.com, andrew.jones@oss.qualcomm.com, 
	guoren@kernel.org, ajones@ventanamicro.com, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/riscv: Add IOTINVAL after updating DDT/PDT
 entries
Message-ID: <5woghxzq2ovb7z7bybqwkckmpjua7proqqket5vacw6kp225nc@mee7c3zchkir>
References: <20260122143224.25146-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122143224.25146-1-fangyu.yu@linux.alibaba.com>

On Thu, Jan 22, 2026 at 10:32:24PM +0800, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> Add riscv_iommu_iodir_iotinval() to perform required TLB and context cache
> invalidations after updating DDT or PDT entries, as mandated by the RISC-V
> IOMMU specification (Section 6.3.1 and 6.3.2).
> 
> Fixes: 488ffbf18171 ("iommu/riscv: Paging domain support")
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> 
> ---
>     Changes in v2:
>     - Reworked the patch formatting (per Drew).
>     - Fixed the call site of riscv_iommu_iodir_iotinval() (per Drew).
>     - Moved riscv_iommu_cmd_inval_vma() out of the conditional blocks to avoid
>       duplication (per Guoren).
>     - Dropped the #if 0-guarded code (per Guoren).
>     - Updated the Fixes: tag (per Drew).
>     - Link to v1:
>       https://lore.kernel.org/linux-riscv/20260108134855.91341-1-fangyu.yu@linux.alibaba.com/
> ---
>  drivers/iommu/riscv/iommu.c | 70 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)

Applied, thanks.
