Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B72152DF5;
	Tue,  7 May 2024 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093318; cv=none; b=g+uPPQrZrrfs6noo8KQFor8amrR+NszeKTZFkczLY44QnBXWon0oG9yU43OLJqlTkocf0iv5rCSVzda9w36NNycjMutbgVaAh38d7H/jUHV6nZWzNaBzGSxIq+sjz8lUR5HJcJJJuRobTxREwmfnyqAI6zYoTPns3/uKq7wfde0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093318; c=relaxed/simple;
	bh=urdxsMlEzLQBGVqSKnxrypj4fBHWfpgOgfIX92EUsvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NO1lnbqpSdjYthjM44+RPPNcD2ewJKtSsjsGVi03b8qEadEEKANlsdE+7FRMcrxn/23WOZU9oMKZywRGaeYGSCJlyN2H0Q0iTn3b8zxDsGJV4M1/OleFTGrRLJwf/BghFiZIDaaZuDB/q/AQq3pyHwJJU1N+sLo+YTnDLoqVaic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiVBOLbx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiVBOLbx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A89C4AF63;
	Tue,  7 May 2024 14:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715093318;
	bh=urdxsMlEzLQBGVqSKnxrypj4fBHWfpgOgfIX92EUsvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TiVBOLbxPUAIFbu38Cyv0TU+25GTrEESVMN3vjRSuUjR9aYs/eaWgKNGihOnzF8Fh
	 rHzd7knaeJG34ACNTajX4zEYFNCQsgt6pJKijjtMqRMp+Q5QJNVYY5qhvLj+AgSzYb
	 fzSl5VkfwfhAFYWAOAhy09KcJhQBK6l23XvPSnNtXF80w7cwq94EACPyIFdMvHTh5v
	 YFJA9VKOtfDHlRzQaFtmVd9l3EUTmXpaGKmOOhEwNxp/1j4WaeKBijog6QtAK730Xe
	 xbxNwmoDHTzlye3dnNu6Qx+kOZt237/19gXuDexIk3po7XZLE69DphaqSgR2oY4uzl
	 FDWLxxIVQigbQ==
Date: Tue, 7 May 2024 09:48:35 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Robin Murphy <robin.murphy@arm.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
	Joerg Roedel <joro@8bytes.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, linux@rivosinc.com,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>, Will Deacon <will@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: iommu: riscv: Add bindings for
 RISC-V IOMMU
Message-ID: <171508897177.213758.18021668060802877165.robh@kernel.org>
References: <cover.1714752293.git.tjeznach@rivosinc.com>
 <845127470ad85f9b4f690077968fe8c5d615c538.1714752293.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <845127470ad85f9b4f690077968fe8c5d615c538.1714752293.git.tjeznach@rivosinc.com>


On Fri, 03 May 2024 09:12:34 -0700, Tomasz Jeznach wrote:
> Add bindings for the RISC-V IOMMU device drivers.
> 
> Co-developed-by: Anup Patel <apatel@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>  .../bindings/iommu/riscv,iommu.yaml           | 147 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

