Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E374717F5
	for <iommu@lists.linux.dev>; Tue,  6 Sep 2022 18:44:03 +0000 (UTC)
Received: from g550jk.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl [31.151.115.246])
	by mail.z3ntu.xyz (Postfix) with ESMTPSA id A58D8C7044;
	Tue,  6 Sep 2022 18:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
	t=1662489315; bh=sCt7XNGXeGMjmtAHtkSmYHqy8bJlFQumVe0mQA/VKns=;
	h=From:To:Cc:Subject:Date;
	b=oxGQ+UZVKsOFDXuMUiUHAN8PJ065thJuAa3kZhpkS2AmcpGB5eyP4HBxov54T+s9R
	 S54/TG4Z/5jaR/HBCyEipKxsJkwsJ35mrZ4uHotqxSIxrpO7PwUzdc9t8+CcNfgyCP
	 YHsvsTc4M9kxnuYHdpiylnpkrm5HNDnvXp2rxNKI=
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
Subject: [PATCH v3 0/3] MDSS support for MSM8953
Date: Tue,  6 Sep 2022 20:33:31 +0200
Message-Id: <20220906183334.203787-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.37.3
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
 arch/arm64/boot/dts/qcom/msm8953.dtsi         | 246 ++++++++++++++++++
 2 files changed, 247 insertions(+)

-- 
2.37.3

