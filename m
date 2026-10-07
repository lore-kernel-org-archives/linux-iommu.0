Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB10F46985D;
	Wed,  7 Oct 2026 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363711; cv=none; b=kB01lq1VweaS+ZAWpMhq+bqQ3SphjrLgL6LohVO+6vq5KIGTmD+gjzvrx1dvvDuMkwZrwfcQZwUSQJvBe4er6ergPY2xYmX3v3Lr+rzgBz07+5CFg7rKlp180pc6TShYLH9QAoE7fNznaXUYi+HDkAis7iFASbICVi6BPzTcbTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363711; c=relaxed/simple;
	bh=R4A2MlJ1q92uYLDOmySiqipN7jMQBj/38nBB7XYmanY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqm9nYms8aFRSVrwZTeAfeJWFYujnHrKiu/5sJewFuL7VVgDbaXO3+rK8d0NxpCtlepm1Y1npdmVbJANboGrewlaJ2O0LZj6IlkWsrDRFziagT3um373h+S8+EE1qC7esHapfY+F1PIYQLOVJIf2xBZSc7F8WhmwcFjfxPwUhcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsjKNZK2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsjKNZK2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1C71F00A06;
	Wed,  7 Oct 2026 09:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791363689;
	bh=7dJAIrAjhjxcyvz9oV+xoiaVLLnVm/pZD3w+TP4HzxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lsjKNZK2WBQ7sax84EecjI8cnKrPGrizIUN1kNyLVFPwJQhmjKmEBb44Qelpnhkx5
	 dLYREZtdPYRsdhQ0a+qdyB3O39spA9fvgMx3KTop3jf5xaRzsHFCFY8+hZtcBsZwAZ
	 6wXgW/O4PKRgzxdrBHqH9cqT5SpIp9j2ZQXQ3KHgvem70erGGG3kCDL4EV4vdKjSUz
	 58IYdv+mnHPhjNm1cnhZ+UbwPiJz5/8fmrC9DdMdwvTDl3sq9thr202AX3K6ae9NUJ
	 HMVkwk4OumMGjUGVkynHeN7IinIJdp7UStpySCvfbdlPR7WI0eCr76bipfWZyHEELk
	 HbvqEkYWEITYQ==
Date: Wed, 7 Oct 2026 10:01:23 +0100
From: Will Deacon <will@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>, joro@8bytes.org
Cc: catalin.marinas@arm.com, mark.rutland@arm.com, kernel-team@android.com,
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: Document Adreno SMMU for Nord
 SoC
Message-ID: <asYKYzDvNBLjnotz@willie-the-truck>
References: <20260902013858.130887-1-shengchao.guo@oss.qualcomm.com>
 <179095635040.2123203.12001281676860626455.b4-ty@kernel.org>
 <asW7Lay9i_hiuTcP@QCOM-aGQu4IUr3Y>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asW7Lay9i_hiuTcP@QCOM-aGQu4IUr3Y>

On Wed, Oct 07, 2026 at 11:23:25AM +0800, Shawn Guo wrote:
> On Fri, Oct 02, 2026 at 05:46:40PM +0100, Will Deacon wrote:
> > On Wed, 02 Sep 2026 09:38:58 +0800, Shawn Guo wrote:
> > > Add specific compatible string to document the GPU SMMU present on
> > > Nord SoC, and constrain it to the single HLOS vote clock.
> > > 
> > > 
> > 
> > Applied to iommu (arm/smmu/bindings), thanks!
> > 
> > [1/1] dt-bindings: arm-smmu: Document Adreno SMMU for Nord SoC
> >       https://git.kernel.org/iommu/c/e9da5ec4a1d6
> 
> Hi Will,
> 
> Could we get this into linux-next please?

I'm hoping Joerg can rebuild the 'next' branch soon, but it's LPC this
week so I know that everybody is busy.

Will
