Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA1137DE8D;
	Fri,  2 Oct 2026 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959611; cv=none; b=NKjzZfqkJf/ZE+/ud/H/QX9njLUdKziL9IxNlXeqbgFmNeU+jru/CUqQHurd90uW0XMLMTMjw7lh4GFtZAwliHKckHKNcJ8vhroqGVIqT951SgGbh57UL9lEFbARmUL4btR7F2xpUQIUMTb8WgBrmeU+ZsRzLJrVzdFLrwGB2Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959611; c=relaxed/simple;
	bh=6cg+lcCuAXFBL/G+Ow/2cm9Jj4ZO8hTglEeqlPbP+jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsQk+cgcHTm11PTZC4Y6pqA4NiPCaHaTxeSE+nisvPm42qFNDToUxMbDRGR1Cf2NsDlKm0GOqqFfUlhC5IAXVqHpMF4B3tliC5fbtDT5rJuCYe8zrf12OWFg0P7GfuSgbZ8p4voc5BTaZNZt3fu2+JqrWGUuj0ACLWiUn8Pw9m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbY6Q7sw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbY6Q7sw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5751F000FF;
	Fri,  2 Oct 2026 16:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790959610;
	bh=zjleGJ012fVIUizu+B+4yp+yZfnLWc86v1x3Uze5e9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FbY6Q7swcBGXHERBYi/rjqaoowyPWWj8QKiIbZ9bqRZwGy1kzg8F59oCJxiST0Hqo
	 9ymkPB4zuc8/ZU2rA6N6TzX0urFAwRlChTzAPiQNeLLKtUFsHJTlKjdPgbNSEzWK+u
	 HcPdLAKf//UVXffcgZ2bizZuPp/7DI7yVIjLf/Z0ODjd5LS7QSwq2umTByQsmXtEsM
	 rLrbvmO2prQzU47PGy3n3MW6Z0IKqFHrq0jHDtE/YNB/hQ3ti3Ud40/6mHjktgsgrC
	 0gCTqTocESF5/bNE+jj8YD0+RocgvoKBoMFCzfvRitatSOZuwR3AjACFP83y+YvwN5
	 ENJPYZq/qyEyQ==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: catalin.marinas@arm.com,
	mark.rutland@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	aiqun.yu@oss.qualcomm.com,
	tingwei.zhang@oss.qualcomm.com,
	trilok.soni@oss.qualcomm.com,
	yijie.yang@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm-smmu: Document GPU SMMU on Qualcomm Maili SoC
Date: Fri,  2 Oct 2026 17:46:36 +0100
Message-ID: <179095600013.2119816.14349217332489680081.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260830-maili-gpu-smmu-v1-1-253e1108ce82@oss.qualcomm.com>
References: <20260830-maili-gpu-smmu-v1-1-253e1108ce82@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 30 Aug 2026 19:44:03 -0700, Jingyi Wang wrote:
> Document GPU SMMU which uses "hlos" vote clock on Qualcomm Maili SoC.
> 
> 

Applied to iommu (arm/smmu/bindings), thanks!

[1/1] dt-bindings: arm-smmu: Document GPU SMMU on Qualcomm Maili SoC
      https://git.kernel.org/iommu/c/991ded609472

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
