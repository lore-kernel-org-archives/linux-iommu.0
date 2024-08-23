Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78AD18E743
	for <iommu@lists.linux.dev>; Fri, 23 Aug 2024 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432100; cv=none; b=h/7oPpOPt4Y04Lqvh3Ryb5Ja1vWfu5TzMLsizu56iVelqqrEJjPVBGLn6LcKnOzM6D0QnpIxwk0VGy70bLt0a9aY+to2sF6cGlp1HcuNvAR23QKFrdIacv4VLnHha4FFfj1SjFU25HuCSWdPGxmRTMvzukPDCdOVuRosQX0S33k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432100; c=relaxed/simple;
	bh=CzprT1Ay7lI87sOU4gRurd6Tg+T5u/CgVsFwOU0hUXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ve3jgopmaWEvbvAOVMlBkObz2fbhGavdREEJfIbX1erPr9hlcrnehogpuxAQxwrGAg8jW73AcLsj08F8VtYC/hTN8VpSWrflEpVgYLbzsWuJBx2XvG9RcQRo+3J/2VITRF+e4kURiD2bxgAVBsr0oJTcGMIIq11mV1TBsboiRQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d97gjLNa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d97gjLNa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC11C4AF0B;
	Fri, 23 Aug 2024 16:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724432100;
	bh=CzprT1Ay7lI87sOU4gRurd6Tg+T5u/CgVsFwOU0hUXc=;
	h=From:To:Cc:Subject:Date:From;
	b=d97gjLNasmnJibWn+NOQ7u+psAKzEVreDtaVhKn0WoJi9aovxhhg2NIE2ybo7gTu2
	 bNzFnaY9gE55yF0h4lDpCvj9yrTW7HpXgGstLMVGOjG2WzKwApS0dGG0cDWJoLXx0l
	 VOhc9x9Dpw8/g56tRSonXoFmIpr/9JKbB1SeIwjCDz7K3B7YLjTzBeEbW3qKNf6KG/
	 T/b6o8ekr6lzkQaceT7CGciTrwVA5TQhYNU/a6wSIVNfrFDgSsRFfeG1DnoTUZOP8N
	 1hcm6yIw8a+cDC3JtBg8Xulbnecl4vNIxqqjugXQogYsWoXzL114jhWD2vuouleun1
	 JJZH8knIM55tA==
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux.dev
Cc: joro@8bytes.org,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Mostafa Saleh <smostafa@google.com>
Subject: [PATCH] MAINTAINERS: Add Jean-Philippe as SMMUv3 SVA reviewer
Date: Fri, 23 Aug 2024 17:54:54 +0100
Message-Id: <20240823165454.1064-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Jean-Philippe as a reviewer for the Arm SMMUv3 SVA support, since
he's been a consistent contributor to that code over the years and
understands the relevant parts of the architecture much better than me.

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f328373463b0..445cec2ae4ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1880,6 +1880,10 @@ F:	Documentation/devicetree/bindings/iommu/arm,smmu*
 F:	drivers/iommu/arm/
 F:	drivers/iommu/io-pgtable-arm*
 
+ARM SMMU SVA SUPPORT
+R:	Jean-Philippe Brucker <jean-philippe@linaro.org>
+F:	drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+
 ARM SUB-ARCHITECTURES
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.46.0.184.g6999bdac58-goog

