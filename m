Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEC4382388;
	Tue,  2 Jun 2026 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432499; cv=none; b=tt/sBlKYHovf2Fo0G8nl0Ssm2tiyy6eNMdAYCDDSQK/9y85e62Z2LfHGalSA/fhWFDo130F9gLlH+IoziyHg/ePX0BdrWxRlGenZYWKRgLwb1hNNyingdC9cO6xpBUcHQnINdqqudgPSAyiih6HH+WIqPeNT1nHqsn1qMnUhOb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432499; c=relaxed/simple;
	bh=FGM8HsWAGCmF6WvKlNdMGdobCEuqhcarK8sbhAZX178=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rk/mkjeY0ayXOnhhnwqnIUFSS3dDrBoD5ADVBCtLiV7FYNga1jRutFwAXrdj28azot6/i9mj2FptDRF5OSdTkEt85j2yZvlx30gJO+it5yJ8GzmiRT77bCdMCPNAafGVH0comvcENTHNEZcuwHBboQVOJQZ/3wtfqYPWhhubFoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0FR/QHe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0FR/QHe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906BD1F0089B;
	Tue,  2 Jun 2026 20:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780432498;
	bh=y2IHE5pMykaTeYcvGS0rFrLAbhk0p3IMHxukKe6uT1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F0FR/QHeLseNKlGVuavBp0GaFCTZ+GQriOINrSs19ScKcyP8yEjBAqDjv/Hf3/NYH
	 w1vAeX+iX0ghefMjolRI9ER7xuPjQ+AcsvBH0bVniajKUEPRsvRci8kknk90ry3Li0
	 e0rMLTHnFDuzo2uGol9pm35bgCKfipTh/ZnUlViYByu7lO1bkx8Ddk2aK1wQfwizkb
	 7zBYCIwPk9MDF+SjgbSy6IlX9gVLtiQL+jEKVxqpMQj5nS08UGHFjUGE/A53j5AhIT
	 fhGycZTk2C2dmUEJ3VyAwRJRnTKwE3EG9Q93SWeNBbILySgHbk213Xbe3CkoliSzft
	 RXkZxx8c3oQVA==
From: Will Deacon <will@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: arm-smmu: Add compatible for Qualcomm Nord SoC
Date: Tue,  2 Jun 2026 21:34:39 +0100
Message-ID: <178041465050.4028495.1386428522122562328.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519013950.873105-1-shengchao.guo@oss.qualcomm.com>
References: <20260519013950.873105-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 19 May 2026 09:39:50 +0800, Shawn Guo wrote:
> Document Applications Processor Subsystem (APSS) SMMU on Qualcomm
> Nord SoC.
> 
> 

Applied to iommu (arm/smmu/bindings), thanks!

[1/1] dt-bindings: arm-smmu: Add compatible for Qualcomm Nord SoC
      https://git.kernel.org/iommu/c/2a5b7d11ee28

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
