Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C5037DE8D;
	Fri,  2 Oct 2026 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959621; cv=none; b=ND5tI3MhwhQLRMv+HtoQ5zbFTxchDq0mToJU6aSAINqnah9AE/NpkGOpQj+KjtMpXjo/F7evZOyklXT+/ao2Au9Ewi7Lx8cP1VjKxpZMHvuFChS7gUcdn4ifSqQRi2VI8dnXs0kzIoy1ueAf+ydJTxg7xJXad1Hc7CRT8PYeHV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959621; c=relaxed/simple;
	bh=Ak9YuvUZ4Q42MkX93DtuSJR5MmuDUyFag5+CHZ/hCHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OYWcQklFZsQYZPWfG8SN4jyDwpfgzy56yKuI+bHignPKJZhpSk4Ym7AG8pKxiHZXjnlNnWrguWbTEs9VtIhy2s42WpMjtA16EOdQlOzMJxqGzVV0wZsx56xATUPVUJf1d3pPIsYZTTdexUD8Lfaa2xj1XBgLy9ytrzY8oOlsaEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAFy5SyA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAFy5SyA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030971F000FF;
	Fri,  2 Oct 2026 16:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790959620;
	bh=3kes/itfXouN+8b8QKCcHWhQnNlQ4qwwFi3DP2N4wKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DAFy5SyAedvDBHPiCtmx+Lv1F1yUT3VlWcf2SpPsTYH2g/Ir8NpIKV1eQnA+JQwCW
	 vFFSTgOvIHsPX5KD5xsZmU2IhQ4p3+cWGmoLJWtDRF3rB7cQuNYMAe9fpFzRfY76qb
	 xUSCSW6rJtQWSG0gJtCx/h66lUQq3BSVzj0okY0Ll3sUISBEGzGHFjQTPptd6V4QiB
	 FvUfB2YgBA1FMVlUFNCIu49ket3TIdIYeGxZ/UDd8/nQKNYBGTf4luQUCA4/tGRYVa
	 m7K4oBaPZxU+C386dbovGdErUHiXfqZcclDp7vHdv0ll/qwt0fOPoRxUcDWWxJHbM9
	 SWa+poyK8uGmA==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>
Cc: catalin.marinas@arm.com,
	mark.rutland@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Pranjal Shrivastava <praan@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	willmcvicker@google.com,
	jyescas@google.com
Subject: Re: [PATCH v2 0/2] Add arm-smmu-v3 support for Laguna SMMU silicon erratum workaround
Date: Fri,  2 Oct 2026 17:46:38 +0100
Message-ID: <179095464942.2068396.10273315598059135297.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911-arm-smmu-v3-instcfg-override-v2-0-5804e4f400b5@linaro.org>
References: <20260911-arm-smmu-v3-instcfg-override-v2-0-5804e4f400b5@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 11 Sep 2026 21:21:04 +0000, Peter Griffin wrote:
> The Google Tensor G5 SoC (Laguna) has a silicon erratum with the SMMU
> integration where the AxPROT[2] signal is always 1, which makes all
> transactions appear as instructions.
> 
> As a software workaround we make use of the INSTCFG override feature to
> force all incoming traffic to data.
> 
> [...]

Applied first patch to iommu (arm/smmu/bindings), thanks!

[1/2] dt-bindings: iommu: arm,smmu-v3: Add arm,instdata-override property
      https://git.kernel.org/iommu/c/87098700b3cb

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
