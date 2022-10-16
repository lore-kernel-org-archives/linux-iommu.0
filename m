Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485C023A1
	for <iommu@lists.linux.dev>; Sun, 16 Oct 2022 16:23:53 +0000 (UTC)
Received: from g550jk.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl [31.151.115.246])
	by mail.z3ntu.xyz (Postfix) with ESMTPSA id 832B9C78D1;
	Sun, 16 Oct 2022 16:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
	t=1665936963; bh=qcJsUZQCMIkMA+JI/065x3bdEKFPd1nhWP6lAckCliQ=;
	h=From:To:Cc:Subject:Date;
	b=fZSqRL36AXjOysJRApODEXSxa1GxJf3JVkvPVBlZK62jPoO7Fjp8/vCKHZqvOmGYc
	 tttg8yE+C5x0bNPth6Qwy0OfN8dTBEdWizztn9cSmR1yzY6sPSYJjX+68ck4lKM3e7
	 Cz5jsQ/qptuhHGLLIxtbHLHFsbWiG94oYWAGDhhw=
From: Luca Weiss <luca@z3ntu.xyz>
To: linux-arm-msm@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Luca Weiss <luca@z3ntu.xyz>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Robin Murphy <robin.murphy@arm.com>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] MDSS support for MSM8953
Date: Sun, 16 Oct 2022 18:15:50 +0200
Message-Id: <20221016161554.673006-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds the APPS IOMMU and the MDSS block for display that is
found on msm8953 SoCs.

Luca Weiss (1):
  dt-bindings: qcom-iommu: Add Qualcomm MSM8953 compatible

Vladimir Lypak (2):
  arm64: dts: qcom: msm8953: add APPS IOMMU
  arm64: dts: qcom: msm8953: add MDSS

 .../devicetree/bindings/iommu/qcom,iommu.txt  |   1 +
 arch/arm64/boot/dts/qcom/msm8953.dtsi         | 244 ++++++++++++++++++
 2 files changed, 245 insertions(+)

-- 
2.38.0

