Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16854FD268;
	Fri,  2 Oct 2026 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959630; cv=none; b=S2WpoLluBY/PgP+n2EUFoqx54RrOXuFd2qJHlSQS2mgps/j2d+TFm+G+v+VutQ/NmDiOVQTcbdHntI99krBAKBaRmrZgmcMlTROUqfiGzy8KMyWaMyhh8bak2cVWzsflz4VJGtsk/PL+qV1cFZ+jySSUAne/8DCbMB2w95wgtzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959630; c=relaxed/simple;
	bh=F+JT8WGVoMG5xSL70f/yzHZ7HLufVait8gZbaFmuaVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lO3JXioRPiPtGHfKRk+A7aYjJ6Oe+/ntSNahkcUUX1RHlpzu9K4hKHZuMduEBHG7NvoeSy1sVC3G4T89Y+gdXVobBUCwNIBAJ8x9Lvfh8Ucv0u6YnbsY0B39BXzpKTX6QKioTCd12+bwLJmF4xMYrWgKSOkyecYPoad46UbIGyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5UtQKDq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5UtQKDq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243551F000FF;
	Fri,  2 Oct 2026 16:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790959628;
	bh=SeLwfRCuJ2UN3SfjLqcJwyf81UK0hgb0h02BI/TrZ0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k5UtQKDqr7Yb6uU7SSFWyiD+areNZeRmr0VKghEUUgZJTbt9jfUW8K/6NcMqQwHyo
	 7jgJnf5/xnOkRZLikx9eGy2PI4gt0K5QuJBPppBpPJyYakaFlTzWsupMhJTCS6xXTp
	 jqUSzC9FVgHh+bQ1cCLQG6nHU9jaKmW58fGfFnttV3yNAa9IS9iqP5vjO/fi94YZpJ
	 ppzgu8uXDFv7BaXJlMFLt4o79pxNTq/wuf1aG3NgrwUnGjl2dGKxnU/j/iV1wjZHjK
	 8QONTGvVdEbU56B9UtvTG4wSAjE7Oowb9NwTBZKZZevwATLQBOuXYl0XEkaD+BAKTz
	 z155qVMcqAB9w==
From: Will Deacon <will@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: catalin.marinas@arm.com,
	mark.rutland@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: Document Adreno SMMU for Nord SoC
Date: Fri,  2 Oct 2026 17:46:40 +0100
Message-ID: <179095635040.2123203.12001281676860626455.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902013858.130887-1-shengchao.guo@oss.qualcomm.com>
References: <20260902013858.130887-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 09:38:58 +0800, Shawn Guo wrote:
> Add specific compatible string to document the GPU SMMU present on
> Nord SoC, and constrain it to the single HLOS vote clock.
> 
> 

Applied to iommu (arm/smmu/bindings), thanks!

[1/1] dt-bindings: arm-smmu: Document Adreno SMMU for Nord SoC
      https://git.kernel.org/iommu/c/e9da5ec4a1d6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
