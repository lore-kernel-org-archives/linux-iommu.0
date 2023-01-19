Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AD7B425
	for <iommu@lists.linux.dev>; Thu, 19 Jan 2023 19:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99207C433F0;
	Thu, 19 Jan 2023 19:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674155363;
	bh=7x2R7zpWlcagxTzSnRmCFuKtnNpSdj7aLDNu2wlNP5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U8iari57TKeUx3a3SrNr6PVIBoGUfhgsl8GEJQpdEsozUR+nG/sgg7dS2umJplGqm
	 hBO/Wjg3FnqTUTjyOlJfZy+eW/kg7W8V9lXlxK4sO5BA5Hkqaa2GtV7FpgMjJ7J+NM
	 sVMPkfm8Ja5E+YBkppsGLz0KkQhSOTvkTBk+GSjJqxSeHz7WH3uDC1VVtvVu5T6QNd
	 feTmI2PG8N/KRjXg72zPhPo2BJitUT3czAMU4mL5S7ltjl2yRwVWa7f7LQ/48BIsRL
	 tRyTtXc6O1Tz7efN3a/1cv8f77qyNRmxGR4VAXeUG1COhURwL7Z4dAdwtqpjzXxEbO
	 WWFHTG7ztLhEQ==
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Joerg Roedel <joro@8bytes.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Select identity domain for sc8280xp MDSS
Date: Thu, 19 Jan 2023 19:08:41 +0000
Message-Id: <167415058811.2382458.12117024092165263386.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230113041104.4189152-1-quic_bjorande@quicinc.com>
References: <20230113041104.4189152-1-quic_bjorande@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 12 Jan 2023 20:11:04 -0800, Bjorn Andersson wrote:
> The Qualcomm display driver installs a translation domain once it has
> mapped a framebuffer. Use the identity domain for this device on
> SC8280XP as well, to avoid faults from EFI FB accessing the framebuffer
> while this is being set up.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-qcom: Select identity domain for sc8280xp MDSS
      https://git.kernel.org/will/c/1d6316e50572

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
