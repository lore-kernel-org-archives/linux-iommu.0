Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DCA206F04
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 08:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458053; cv=none; b=JV6Wh6+yvNSLOLo4YA5LfNSncBCl4aZii86Obxf/se2OPOXF0PGdfbzTA9O9QAz57OnY3N29zgEdIlDdvxFkpvg39ASIdo5ZPhQWVQsZTOJHJ8wpVkpg4EjqVOTIaHwgnEah1osQYkbpZljGiVAo2tOsS6OSYsFA24AuIn4uleg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458053; c=relaxed/simple;
	bh=afrO0T/ZM6dp0ekqIQzS/F95Sh7sMAnbbqM3W3zTGuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cT0g4p+ypNebNZRqI+RginMLvbBfdRzHYIR6Z7HcrTT1ycYaY+AXe0e+hTRLfGGH8il0U2RQ3AJowKNmO0NK8Xra/uqLPnIDiIyyG2lyJV8WP+609wiuLZ3zlOyrdgvmUL4qKtIZFpZDvKn4RmtZnOUaciYmwoNX+oDr789awW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=MOyTSZBI; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="MOyTSZBI"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4A11846415;
	Thu, 20 Mar 2025 09:07:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1742458050;
	bh=afrO0T/ZM6dp0ekqIQzS/F95Sh7sMAnbbqM3W3zTGuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MOyTSZBItsYhkL/eK9uUi31Qc8cjascf93B/mHVdlD/HTGI0Ue9249kDjVPs2gtmi
	 rFBASG2I566odj4Az2WS4DoVyughlF47jOatJjPSYWdwWbzV3BiBy5On6xuDKHL1oY
	 pZTHf7i8a8AyU2eWmaNTkEuwDS8ABAPF5Aks6FWoPmQ0sufh2PUtT8AbBnsiR7P1iE
	 RCs8qBL345pxf4EkR0yL+46L6oK/CMTpKN4+IlM4InpfZQ9qY1X4iPs/txfmE49KsU
	 I5yQxQZ1LSiBXkrzuY0Wspl6F3W/abembLYTYTKwtnIQl/GRgmEgpjOz51L2WhN6CU
	 cx44r7amnTbYQ==
Date: Thu, 20 Mar 2025 09:07:29 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Rolf Eike Beer <eb@emlix.com>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH 4/4] iommu: make inclusion of riscv directory conditional
Message-ID: <Z9vMwUQ679SdSwhG@8bytes.org>
References: <2301497.iZASKD2KPV@devpool47.emlix.com>
 <3536592.QJadu78ljV@devpool47.emlix.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3536592.QJadu78ljV@devpool47.emlix.com>

On Tue, Mar 11, 2025 at 11:15:12AM +0100, Rolf Eike Beer wrote:
> Nothing in there is active if CONFIG_RISCV_IOMMU is not enabled, so the whole
> directory can depend on that switch as well.
> 
> Fixes: 5c0ebbd3c6c6 ("iommu/riscv: Add RISC-V IOMMU platform device driver")
> Signed-off-by: Rolf Eike Beer <eb@emlix.com>
> ---
>  drivers/iommu/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 41b00cdc8621..17133876f777 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -1,7 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-y += arm/ iommufd/ riscv/
> +obj-y += arm/ iommufd/
>  obj-$(CONFIG_AMD_IOMMU) += amd/
>  obj-$(CONFIG_INTEL_IOMMU) += intel/
> +obj-$(CONFIG_RISCV_IOMMU) += riscv/
>  obj-$(CONFIG_IOMMU_API) += iommu.o
>  obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>  obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o

This allows for some additional cleanups in the Makefiles of the
sub-directory, no? Same for the other patches in this series.

Regards,

	Joerg
