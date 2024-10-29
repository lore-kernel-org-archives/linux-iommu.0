Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FDE2038D7
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 08:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191386; cv=none; b=Z4hkAnvdH6qJKBarsKDhi/48fQnJoe+UEi7WSXJWdWIvJP9OqePOjJ5X21rZt1//df9wiZAJ3mAUX+uY7JjrQG/6yCJRzPijDQERl18kSf+If6YPkfdAfJB27gD/X4h3QvylHCo3v+/0nKJ49adbs+vJ/JU6P1Io+ysJflVjQNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191386; c=relaxed/simple;
	bh=3obJMxT/iLNG5zmbZLIIDYwv1bCDqT29YPV4LLHT0D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwtMuNR0AAIWnXJFP79E7cnoIHeDwHqdMOA/vKLq+acEtIBZ+0XlVJj4LL7GJrbeAMGpaqPl2hMY54NiIjXZ0fROZZuYhd50HdasLrmMkcHpnYQApIUFBNflXOhyQT+Fi0fLfDeKQ5HO9gEnm3N2DVwDR3PUx469rGIPNXqDPfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=DLdPx2b4; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="DLdPx2b4"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C9F922A8D55;
	Tue, 29 Oct 2024 09:42:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1730191377;
	bh=3obJMxT/iLNG5zmbZLIIDYwv1bCDqT29YPV4LLHT0D0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DLdPx2b4pXUOpdWcGGiZXG7u3OzXLN6XCbArTH3FfOyophisj9GPCdqyxU09urIbD
	 59hcffdqEwheqtSj3u1GTs2Qd+456uO9RnH6OQvFu7DgPzmlX2MgA8ImPV3W+hIAuK
	 7uMRhfbNmJ0AxIrWe+NaPCM+Q/uuCcMiSlfmQJqKNiiQYtRWn2nSO/yWhwWgpvoBDG
	 NxEU3qLL1UtEOuAnBr1ElB45c02hIG2ZlsnLEOeFem3W+eWn5HA5iMsGjhi0uPeQuV
	 gWgi7t1m9kHJEyy62z/4KMd55SOZ8BN+ZQuCFTsOryjHLi/JgOb4VS9tfWNw58y/t5
	 BrCJJnxD7LU7A==
Date: Tue, 29 Oct 2024 09:42:55 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Subject: Re: [PATCH v10 0/7] Linux RISC-V IOMMU Support
Message-ID: <ZyCgD__VeR4LJj_a@8bytes.org>
References: <cover.1729059707.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729059707.git.tjeznach@rivosinc.com>

On Tue, Oct 15, 2024 at 11:52:12PM -0700, Tomasz Jeznach wrote:
> Tomasz Jeznach (7):
>   dt-bindings: iommu: riscv: Add bindings for RISC-V IOMMU
>   iommu/riscv: Add RISC-V IOMMU platform device driver
>   iommu/riscv: Add RISC-V IOMMU PCIe device driver
>   iommu/riscv: Enable IOMMU registration and device probe.
>   iommu/riscv: Device directory management.
>   iommu/riscv: Command and fault queue support
>   iommu/riscv: Paging domain support

Applied, thanks.
