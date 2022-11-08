Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866482F39
	for <iommu@lists.linux.dev>; Tue,  8 Nov 2022 04:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D60BC433D6;
	Tue,  8 Nov 2022 04:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667882191;
	bh=9xpt49gT45y/+nP1FfaBQXR9URrzOWIJn66IA+DB+sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HjCBJUeBgGz2ODaX1HRfOnfsBtvMUnH2fl3S2+1qoij+ELta2STas35VnJ0cZE8On
	 /AmM2XQk8QBDzICPthsipx1OgPsvRb1+Zsnshrz+QPQQZzUHMDPIHG0cyMPpf4Zt8+
	 pHH5uDOjqMiX6XnDCeYBW9OgN7f06gEwrCuoLUZ2CFJMv/xhJuQ8QR67eaIWUYMyWQ
	 PUkq/n+3z4fDK7h0d4r9MD/CkgCMB5mwk9P4n6/0C0CkvChi3Xg3yrLHklhmZ0EueJ
	 hvjAQEc/TNEwIVg4OAHp4gOA3ywFvJKY9ED4T7vYB2wU2VFnqCi0+JqqZWpFIVzLWs
	 zRYGIPwHBb/Yw==
From: Bjorn Andersson <andersson@kernel.org>
To: krzysztof.kozlowski+dt@linaro.org,
	robdclark@gmail.com,
	will@kernel.org,
	robh+dt@kernel.org,
	joro@8bytes.org,
	konrad.dybcio@somainline.org,
	dmitry.baryshkov@linaro.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	quic_saipraka@quicinc.com,
	devicetree@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	vkoul@kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [RFC PATCH v2 01/11] arm64: dts: qcom: msm8996: change order of SMMU clocks on this platform
Date: Mon,  7 Nov 2022 22:36:25 -0600
Message-Id: <166788218325.625965.13235761598838044244.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221102184420.534094-2-dmitry.baryshkov@linaro.org>
References: <20221102184420.534094-1-dmitry.baryshkov@linaro.org> <20221102184420.534094-2-dmitry.baryshkov@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 2 Nov 2022 21:44:10 +0300, Dmitry Baryshkov wrote:
> Change order of SMMU clocks to match the schema.
> 
> 

Applied, thanks!

[01/11] arm64: dts: qcom: msm8996: change order of SMMU clocks on this platform
        commit: d6e636787d462c047a424dd442b68a249edde2a7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
