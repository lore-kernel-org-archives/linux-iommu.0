Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880A538F8E;
	Mon, 18 Sep 2023 11:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857E7C433C7;
	Mon, 18 Sep 2023 11:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695035149;
	bh=HqsMws0S5nYHBfNxFRC4VwWzZrM1nY/Eb3cwT5rJn5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CqCdEj7iTIHgp5d6BjvnkSieRxktCUrr9FV+8xBI5NBYv+AE+zFcTSKYOA+Hk7d+A
	 /u3Xp9DmUSAbiAT77855XQ7sIP4QQKDhZ7krIEF8r1ZMCAKqUzY8P4+D7/unRxs0xF
	 dD7naM3PuFGatTKQzpk2ZJFkZ8bhpfgLux+3KcC1C2Pa+sDWK4eB0S131tYzw+I4LD
	 YFwOom+MS7yPM1o/4/LuT+PQOaTsZeeQBCxoTmghQyoRzRebrzS8CKig8sGGkxqTfO
	 Z8vay8j09Q8CrmAzNF8wHRcMLFzTjJlkKg53+iVc+4l3wuBcl8hPlIxMc+jBMA2x0d
	 Owi/2GGz7b94g==
From: Will Deacon <will@kernel.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Andy Gross <agross@kernel.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Alexey Minnekhanov <alexeymin@postmarketos.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 00/14] Clean up RPM bus clocks remnants
Date: Mon, 18 Sep 2023 12:05:19 +0100
Message-Id: <169502865701.264764.7151801488936699892.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
References: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 12 Sep 2023 15:31:38 +0200, Konrad Dybcio wrote:
> After the recent cleanups ([1], [2]) some in-tree abusers that directly
> accessed the RPM bus clocks, effectively circumventing and working
> against the efforts of the interconnect framework, were found.
> 
> Patches 1-5 drop deprecated references and the rest attempt to stop
> direct bus clock abuses.
> 
> [...]

Applied SMMU bindings fix to will (for-joerg/arm-smmu/fixes), thanks!

[04/14] dt-bindings: arm-smmu: Fix SDM630 clocks description
        https://git.kernel.org/will/c/938ba2f252a5

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
