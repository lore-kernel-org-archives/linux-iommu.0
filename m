Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868FF34CEF
	for <iommu@lists.linux.dev>; Thu, 12 Oct 2023 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCKhJnv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDE5C433C7;
	Thu, 12 Oct 2023 18:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697134025;
	bh=SgvZasZs/o9IEmEaX/jHHf6GMTQphWVneAvbRIVc+/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OCKhJnv6qG7vkqFNJLZtuZ+Uj3YCNwok22p20YI1Cdks1sSnDO/Yb1tR7Z+Wj1n2M
	 8xOcPH5qnGpAX7Hn6AlLB2qdv958G0sqSx7jlvsKg3GZmluR6w9izWoteT8iBT8Bn5
	 tYuNsPZkn+V0yMc2BYUXOnylKPYpHBwC8mGotLpdwfldNrTq8cyaRDguOlTl43xGNP
	 XoVWXwGLbihMLfv5InORySAXMX5o6vuP5DMSgdIZLOAx5EseSQdY2WzUnn0j0Evn+U
	 Dm2stdlHztMfoZuZNvx/0sTzrUZ1rLvv2WMIkvD+60E72EH7lYbLw2L7ZGvl+zKtQK
	 Gc/2C7HmlTnzQ==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	iommu@lists.linux.dev,
	Elliot Berman <quic_eberman@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Richard Acayan <mailingradian@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rob Clark <robdclark@chromium.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Add SDM670 MDSS compatible
Date: Thu, 12 Oct 2023 19:06:46 +0100
Message-Id: <169711478345.626047.2024049635943461156.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230925234246.900351-3-mailingradian@gmail.com>
References: <20230925234246.900351-3-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 25 Sep 2023 19:42:48 -0400, Richard Acayan wrote:
> Add the compatible for the MDSS client on the Snapdragon 670 so it can
> be properly configured by the IOMMU driver.
> 
> Otherwise, there is an unhandled context fault.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-qcom: Add SDM670 MDSS compatible
      https://git.kernel.org/will/c/270a1470408e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
