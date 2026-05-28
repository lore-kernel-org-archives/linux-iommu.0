Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0182B32B13C
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954813; cv=none; b=Pw8hZwXoYTnjxxr3r2xzth5i7HuxrE7j7wIk8CEcVm3WA13TxKgncnzNSF5WCemQl4YdTK2qnKaalM3gkKgpuO0+TKRx7g2kyJuLFT0R51cISWKK7lGxlpY/gbfwdZxnux+RfYf16FoEYOB/Un6i8mym5LxwMEoXL2G+RAb1eXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954813; c=relaxed/simple;
	bh=aAbrhGMmfSsIYmlo3jR7irOv03+WpcmMF0fwySjYCvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UGML1+ANbqeXhIxJxYOth3BRtXbhCTrP11575xTZRZNU+gL2+hOWpVbmIDqdZApMV3IeTZbMy7UojMkgDzDBFgAHxsxMx0UVNnWnMHuWhaR74C+nnxNeDCY44zE+ioXGUkWcM0NEMHJEvHw0knrI0/g51xCd3MDmEiRfugN/m44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.fritz.box (p200300f6af4fc5001a5b4667a2accba1.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:1a5b:4667:a2ac:cba1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B67731C5A79;
	Thu, 28 May 2026 09:53:30 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Vasant Hegde <vasant.hegde@amd.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 0/2] Update IOMMU related MAINTAINER entries
Date: Thu, 28 May 2026 09:53:16 +0200
Message-ID: <20260528075318.607955-1-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

Update some IOMMU-related entries in the MAINTAINERS file to match the
changed reality.

Joerg Roedel (2):
  MAINTAINERS: Add Vasant Hegde to reviewers of AMD IOMMU
  MAINTAINERS: Add my employer to my entries

 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.53.0

