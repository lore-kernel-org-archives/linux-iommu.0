Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F28306B00;
	Mon, 10 Nov 2025 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774539; cv=none; b=K2wvJmsgFskRjAUi2/8/Jrqz6+9lBCVZ51gm7jYu3uXvOseHWfZPmvrqsOLvi+w8LWAX9ew4OiHl37jDXX3nt6aAFBvIjimD3UE9LVS6GrbRI+S6a8jI+eN6y9hSHi4XQVV+bdcpK2KyFyMZbVdBJZkfDNfeByHWF8bCuH/9pn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774539; c=relaxed/simple;
	bh=SNEWfGWtz9L7IEsYxYZpjMWPSLVHPgbfQEK+3vF7bLI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ssLqgAorK1nq7Jk5EDo2gNS2nAEyyghQ19wLloSi1N7xfACeOlnFgnWzI+WcbawVOX3AvdRtUmpGkqc92Enp5fFux0GRSiJsgXCT65Q04Fi+m/YIkr5/Xl+UA6jFx0RHmqK9P/kd6iY8orNuTiNlbvNvyMvfnwx3l1TRCqyRo48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgzK6Y7m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgzK6Y7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581DBC19422;
	Mon, 10 Nov 2025 11:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762774538;
	bh=SNEWfGWtz9L7IEsYxYZpjMWPSLVHPgbfQEK+3vF7bLI=;
	h=Date:From:To:Cc:Subject:From;
	b=lgzK6Y7m7FuPWjrrfDTmAjUmV1GcMU34NORO+zUK5vjlLHU6WqPVwqqugk5HI11qV
	 IpvYyL1zWvduHHS5F7yPtR1f+/dvrapkxZCCJ0rE9MZeIzJkPwRc7AHhHWBYtnM/+u
	 Wg6vIdpyMFTha2mky5f00aw3Rff9NG8VUabw/kQ6btHY28wyrycD1BZBoniqF5GEEu
	 Vw7aVGrmowuEgwz8HDSkKydu666hT1FKYbPvDvi8PtoaLD2kSPwt6sBaglDbmG9Gg3
	 66dQ/4Orb20VEUEQkX3hw8x1lSzViqfOzKwbEZSYPzB5vEsC6OVsmT7k8B0UbgiQi7
	 TzbemqVkX/nzA==
Date: Mon, 10 Nov 2025 20:35:31 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] iommufd/iommufd_private.h: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <aRHOAwpATIE0oajj@kspp>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declaration to the end of the corresponding
structure. Notice that struct iommufd_vevent is a flexible
structure, this is a structure that contains a flexible-array
member.

Fix the following warning:

drivers/iommu/iommufd/iommufd_private.h:621:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/iommu/iommufd/iommufd_private.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 627f9b78483a..85d0843ed07b 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -614,7 +614,6 @@ struct iommufd_veventq {
 	struct iommufd_eventq common;
 	struct iommufd_viommu *viommu;
 	struct list_head node; /* for iommufd_viommu::veventqs */
-	struct iommufd_vevent lost_events_header;
 
 	enum iommu_veventq_type type;
 	unsigned int depth;
@@ -622,6 +621,9 @@ struct iommufd_veventq {
 	/* Use common.lock for protection */
 	u32 num_events;
 	u32 sequence;
+
+	/* Must be last as it ends in a flexible-array member. */
+	struct iommufd_vevent lost_events_header;
 };
 
 static inline struct iommufd_veventq *
-- 
2.43.0

