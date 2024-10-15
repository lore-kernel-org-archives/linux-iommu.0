Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F3C18A6A8
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982240; cv=none; b=Y2XTjaLWElhceqJuyjH968Iys/Qhjnbrfa/QABrK/pB9zcr8po7AVLLgSCd+GE3PEbuTGhutSvhj5QMrwInSLTEstt5MCVuabCXVH7sMcuo4S0UBw8viLpj8WOcLIRVq4k0p1wtNje8a/hR7lhBdfpC2RmJ42eYSI6cfhZNHFRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982240; c=relaxed/simple;
	bh=O4+wEG/X9xbfhukqS6DHHrV3rRut28DqQfj0gz0kqus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brIptFhxsKivoKjhHaLaDcp/cl6qGGmqMsanBb4WyAomOkBV9M4Zl7C+wdYdZ5RhWY76ZTU/+4G62Xg85Op3efAUKzyKe7+mVouQ8tEEl3dm4HsTvhGAydN5h53rWRxWT8SMrDEQ6qTJkc0ZH+FKYdY3xf8XgUq1TqF9x7RhgrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=OkhIVplw; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="OkhIVplw"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A4E842A01B8;
	Tue, 15 Oct 2024 10:50:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1728982237;
	bh=O4+wEG/X9xbfhukqS6DHHrV3rRut28DqQfj0gz0kqus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OkhIVplw2EPEWkpN2AX8orxgpWlon1PjyqdW4jrvqn+tpEfcC5r++4e5j8xPKMFL5
	 0o1Ur0m6qhtQk+AHw1L1u/eWGBlUSecUMolC2VJhZqVxs+ZJQcWipnqgvvpzHYngBJ
	 7UNbr8Q0F+oNR0o75QukuMadhitMrplp1ElOwSGAsFtqb+6/1RezN5xp0V3401jRyC
	 7jNalyIgAGt/JTr+JJ/nilC9YHJc/BuvoIFdYVmVqG4qkD/taXOiORAbKibndroOTX
	 HiW2XHURYBYraGpyjPwOy1G1XI115tcLW3jz06nk7NOr59xzGSzR79zZ27mX064/x5
	 M1zVsFKGWMotg==
Date: Tue, 15 Oct 2024 10:50:36 +0200
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
Subject: Re: [PATCH v9 0/7] Linux RISC-V IOMMU Support
Message-ID: <Zw4s3BHQZ6x4d79-@8bytes.org>
References: <cover.1728579958.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728579958.git.tjeznach@rivosinc.com>

On Thu, Oct 10, 2024 at 12:48:03PM -0700, Tomasz Jeznach wrote:
> This patch series introduces support for RISC-V IOMMU architected
> hardware into the Linux kernel.

Thanks Tomasz. I plan to merge this driver into the IOMMU tree if no
further objections are raised in this thread by Friday.

Regards,

	Joerg

