Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAAB1991AA;
	Mon,  9 Dec 2024 19:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772516; cv=none; b=rJGZgU/WP8BK9DGR/cITjsgJH/hq89yXp6X6ZnkC4JTI6A6gady8uUzN7kj1gFFG+T7lpdbU6b5hGADM3dHh7WOATqJN8CoNwkdEZ0GzS9J+vxufUdPQNJjyDOxZ2ohji5MFdflnKtpbGcb7JqfbM/tyM9fwHSHcNK7XMLWSALo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772516; c=relaxed/simple;
	bh=Ecr9Ga4tDbOcrE56razzN6OYgts0gggFDhJi6sp6Dpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qudbFn6R6RqPJU9CiLURXbzGgVe1/fzehZ3KiJVQEZXONXeOwQfJd/p4f4NQ2CJDhudHDHUSQfQcLIa8l+W7kJAHCq9hwOJtpKjoTfHEFQARnsNk5cdicLj0KjTnRkx1l4pUXBJzJMci6Tckx66ird67fMW9ket4tF9N1vkTdaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxqnPbwc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxqnPbwc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94382C4CEDF;
	Mon,  9 Dec 2024 19:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733772515;
	bh=Ecr9Ga4tDbOcrE56razzN6OYgts0gggFDhJi6sp6Dpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oxqnPbwcHnk1nnKa2cdfHb/TUVTqC3KfD9jnGxhAtIpKN0El9mihuiwLY5kfa+HDb
	 iYEx80Fcf/yxaggoPZ/XaW9bF3epWOjCI3dAP2K7JxP8ewUQaSRX4ueGu0aqKANIlY
	 Gu+yS3O509kYDFhUaG+hUU9ypG4PE5G9083Ta5Tjg0Y6bMU+TNwGwH/r5hkOI58Uyz
	 VJFiIKTutSmq8KfYbtBkZD/2iQDup//pIsn3zxuhJe1Dc87ovOTqiQdlfK93sRLJcP
	 cAdcNWbv+JwDQvmRzSwTDcXRTWMNhgY8df7DzNqUxXwJSgSD9k129kcMb4lqQnsJym
	 kSSYdSgo+PACg==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Melody Olvera <quic_molvera@quicinc.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] dt-bindings: arm-smmu: Document SM8750 SMMU
Date: Mon,  9 Dec 2024 19:28:25 +0000
Message-Id: <173377196863.3924800.3062631537742309660.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241204-sm8750_master_smmu-v2-1-9e73e3fc15f2@quicinc.com>
References: <20241204-sm8750_master_smmu-v2-1-9e73e3fc15f2@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 04 Dec 2024 14:27:25 -0800, Melody Olvera wrote:
> Document the SM8750 SMMU block.
> 
> 

Applied to will (for-joerg/arm-smmu/bindings), thanks!

[1/1] dt-bindings: arm-smmu: Document SM8750 SMMU
      https://git.kernel.org/will/c/2593988fd00e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
