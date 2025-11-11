Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F472586E8;
	Tue, 11 Nov 2025 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851691; cv=none; b=phaonOojzFG/FkwXWesmsKRcG3ytC07CFxFlmGC3PpI+Q2u9LLnxa31eok6mDr6uSfC8atKXX9gtfGuw3ZntjsdgSjTHTGBcbn5aEDKkwUloSPQgTD2X+8hffZjnHQ2OXKmvHqVxdEmVswMCCIWDmuJyz7+TZZOnCFJtnJQyUuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851691; c=relaxed/simple;
	bh=dq1fXebEfLPZ9JYiGMLa08Zj9icQgwOccT2MhXCSiyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oIQC4iACz4N9I4ieEIITZ0OM4/xL7WeUZVJ10vSxZPGyU/DOfT++MIAXqtDKYxu8ljxzPK7BeWv737dqSvLb4g1ns5g1oeDFp3DyaLPMRe15fPfIfJ998nx94OC9dVC4pwUrsH5n1UoPT6yO4hrnZEbLrfEkt2IxT8Ex/RpikCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKjaLazv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKjaLazv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F2CC16AAE;
	Tue, 11 Nov 2025 09:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762851690;
	bh=dq1fXebEfLPZ9JYiGMLa08Zj9icQgwOccT2MhXCSiyQ=;
	h=Date:From:To:Cc:Subject:From;
	b=YKjaLazvJ3FBnYh/zpz6t/RRw2xhLl0oI67wkDJBuqQqCAOEVlxsJEyftpxChxeAs
	 k0Sp1bJlp1NYNbhSUz70WztnTgGqxfGLBvmDYe+s0D8hCFogKzu8UVAqS4xTb7hxIE
	 bu9O9CM4yv84lbGispEB/b1JX5dNdMtEjTzqr34DiOQsD2ROK3ciFAMxaO0+b1PrcT
	 dqYW/8WObwZyy9mWQ9/whk5JlQ47+VZc+/sGsm7b5ioo+uTooEmwjzN3tLaVRU2/t1
	 u6JIKlpaylICigtBZc7dJ5Mzclb5yi8gecRCLwWA3m51dzCiFYKNXqivm/GWGNW4Ei
	 Npqxxdm0vuhZg==
Date: Tue, 11 Nov 2025 18:01:24 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH] iommufd/driver: Fix counter initialization for counted_by
 annotation
Message-ID: <aRL7ZFFqM5bRTd2D@kspp>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

One of the requirements for counted_by annotations is that the counter
member must be initialized before the first reference to the
flexible-array member.

Move the vevent->data_len = data_len; initialization to before the
first access to flexible array vevent->event_data.

Cc: stable@vger.kernel.org
Fixes: e8e1ef9b77a7 ("iommufd/viommu: Add iommufd_viommu_report_event helper")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/iommu/iommufd/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 6f1010da221c..21d4a35538f6 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -161,8 +161,8 @@ int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		vevent = &veventq->lost_events_header;
 		goto out_set_header;
 	}
-	memcpy(vevent->event_data, event_data, data_len);
 	vevent->data_len = data_len;
+	memcpy(vevent->event_data, event_data, data_len);
 	veventq->num_events++;
 
 out_set_header:
-- 
2.43.0

