Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D292E5B3D;
	Thu, 22 Jan 2026 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101197; cv=none; b=I2Nykr2gMHDh2atSd60fUUN8Q+PHDDhgkUZNbDh1dO4nGYBreif9ggH8QcPqclwp+HRjJuGROzE1Ss9iLVZx386pu6M7K08zhwcrlvQpY1ue8pGcX0rSzLGkuCZ7SnFRJrSWFfW4X+zuNtpLGBnepO2ARfjaFggU4fMboWo3iG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101197; c=relaxed/simple;
	bh=fnj5f0mzOP3nCSR0nXkS9PzcpIrYNOAhr7vqfig/jcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jU+aBm/2otYUtAdEDfm+v2oGpTyG+4zI22lM+hSffGdqGb5CGNYdcjdD9UbxT5fUC2nGtXdq3igJ97cYm155f+89ZdVCtvssMpEv5YgrKkUce8531Hw/FYXDxrMeZZ2ZNYVZYXwxfULYYC7la7GZFWhui1HESUVa8VFay3pAuOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/mSaB/N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/mSaB/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E608C116C6;
	Thu, 22 Jan 2026 16:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769101197;
	bh=fnj5f0mzOP3nCSR0nXkS9PzcpIrYNOAhr7vqfig/jcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D/mSaB/NDq2jreN5kdch+CxtKuutzH5sGJhcWs4Iuwgska/79RFnyt2+QmqWuOzGj
	 gXH49QCP0UiMSu415Mm11bk6ywNiJ7DvUgjyJKtD5lGm1o9dzTHIfFfIwrF81pK4Fp
	 FIOM5sjK9z0/1ApyexIZkGEuctP9XMkB7OVAKpVketT29w/lydGM6WPFTcIdN89gKa
	 ZlfLq7d9bZ3zhooCGWOhKTCjyQef0+LHL0W7mB5nfskVQyFirlFZhE7SsbhxU6Q8OU
	 9f0PgWIgO/clpgh3X13HxqSdcZ5UskxXCMbnTHq2Kg73Fo1ljatyxXFx2PkPQOKf2O
	 Z9C0nbg45tr9Q==
From: Will Deacon <will@kernel.org>
To: bibek.patro@oss.qualcomm.com
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	charan.kalla@oss.qualcomm.com,
	dmitry.baryshkov@oss.qualcomm.com,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	konrad.dybcio@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robin.clark@oss.qualcomm.com,
	robin.murphy@arm.com
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Restore ACTLR settings for MDSS on sa8775p
Date: Thu, 22 Jan 2026 16:59:40 +0000
Message-ID: <176909187807.2987598.8685170214732571189.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260120151105.614792-1-bibek.patro@oss.qualcomm.com>
References: <20260120151105.614792-1-bibek.patro@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 20 Jan 2026 20:41:05 +0530, bibek.patro@oss.qualcomm.com wrote:
> The ACTLR configuration for the sa8775p MDSS client was inadvertently
> dropped while reworking the commit f91879fdf70b ("iommu/arm-smmu-qcom:
> Add actlr settings for mdss on Qualcomm platforms"). Without this
> entry, the sa8775p MDSS block does not receive the intended default
> ACTLR configuration.
> 
> Restore the missing compatible entry so that the platform receives the
> expected behavior.
> 
> [...]

Applied to iommu (arm/smmu/updates), thanks!

[1/1] iommu/arm-smmu-qcom: Restore ACTLR settings for MDSS on sa8775p
      https://git.kernel.org/iommu/c/14e9a138dd02

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
