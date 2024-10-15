Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAA41F81B4;
	Tue, 15 Oct 2024 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729026509; cv=none; b=LvGzWXY1kAEI6p2YyBDvfd3ZlImTnh/no1WpoSoK+4v4AGSlrnknnmpd98UppMEA1BJKtbibttJS3a0iBrQc6eEsUhH5FAY6XmsxfiHz/KSRXPNAYDLzgxvm/nffh5ZlOJZAnEKd1GJuJbh5GyhqTcCVIz58kDYcAGLKrmoHV+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729026509; c=relaxed/simple;
	bh=tqc98oCXjjgogVbSf+kBTliiaZcV6ujdQ8boBNvzsao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lOyCWEA0kRSWUZczT37yv4NIlkfGToxkezk+xxXoLubyT8dzmh39Qe2hrXoxYbWc9pXtY6Fv9y8WuOL1o8xOK/P3T46SIY5dwBk3NGJ3bXPuGO6XxPYIN+foIytGq4wc9n/BZw/yEn87hxzGC+/Qe9PH2Zsjj6nBRfXjaRUH4BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpbhhzxu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpbhhzxu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27DA3C4CED0;
	Tue, 15 Oct 2024 21:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729026509;
	bh=tqc98oCXjjgogVbSf+kBTliiaZcV6ujdQ8boBNvzsao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lpbhhzxux6XnUYlulO7EpfE+tZDxCzVKUFbhlfoFiwUma2dvJBt0GtZ5j1/XPFCtM
	 leYufQQkKiiXE+R+g5TAuvv+w7GV4gjyWOXsTic4R2JfkXOtynQCcsjj0f8aq/COUI
	 V+xUY53FZyyhcNxszIah4a5i2LwU8+Zmu2WMLtqwvlUno2FHHQFEJaJSaT/Jw2yWst
	 hJ792nkWgjkFqvtZij2IjdtZ4A55UPR3eIkjq4z66Y3wIjz+tTybBRyPhqhIjvnTQx
	 8oB91lftBT2zj1FBvFOBJ5pWTi1eOu/tkxKun7Fych87drBEzsuIG/9wD6JchG1jCL
	 4MS/GXb4vKy2A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F5DD1F9D4;
	Tue, 15 Oct 2024 21:08:29 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Tue, 15 Oct 2024 23:08:12 +0200
Subject: [PATCH v4 2/5] iommu/vt-d: Remove the pasid present check in
 prq_event_thread
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-jag-iopfv8-v4-2-b696ca89ba29@kernel.org>
References: <20241015-jag-iopfv8-v4-0-b696ca89ba29@kernel.org>
In-Reply-To: <20241015-jag-iopfv8-v4-0-b696ca89ba29@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Joel Granados <joel.granados@kernel.org>, 
 Klaus Jensen <k.jensen@samsung.com>, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.15-dev-00a43
X-Developer-Signature: v=1; a=openpgp-sha256; l=1401;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=+oNZzPhrzkopeFgZ30BXEZ9R6agu9ZZzREmxGT2WjQY=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGcO2cmajgnthS6pVr55LiI+nlD0yq1pvSdVa
 tuYyusu4OCd6okBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJnDtnJAAoJELqXzVK3
 lkFPiwsL/A+ykb7ivI8vGLSWZhvUGhvzj3lwa8z9g4dLyB2MHh6gck/cxCQ/2nNC/fZhJjaMwyy
 hLB0bzaPDOILLS2Z7yiea+gNtGFn2Mu7QGEGQg/vBcLSaaf0GrVWIONP/gJv9LdKda8XKL/6+1N
 LI6TiUTrwv1M9jJ74AGBLcGgKcLaupzKa3o1xwJGZ0NRmmI5Vlk7ikQVqVA4DOUKB2if5YjYhBY
 +e9GTubmHVf87H8CtmYFYQ0014E+yR7Hju2Dn6NVowrQ150CFVUI7jad3l1urNp8UNowkF6MzqB
 ATD5Hz3/MDYgvY37gHiFGqEBanF+HE+ddI2kT4eTXkTrIODMkdQlTO3A5Gl21sIkAz2bVLHyLT5
 q1kvI5z0X1giJr5GFGKgpYeEIoTdwEwyJuxuhyiDPLOiu4JmlKULePBXyzwrERAriTyc5T5AxWb
 y3RMlQIcJqzs++i/LRbCzQZdnRy9DasbC7+Wspt9/NBhZTYjZEi9bzBqM15Nh78De8kc+JWaKX6
 7A=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

From: Klaus Jensen <k.jensen@samsung.com>

PASID is not strictly needed when handling a PRQ event; remove the check
for the pasid present bit in the request. This change was not included
in the creation of prq.c to emphasize the change in capability checks
when handing PRQ events.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 drivers/iommu/intel/prq.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
index d4f18eb46475..3c50c848893f 100644
--- a/drivers/iommu/intel/prq.c
+++ b/drivers/iommu/intel/prq.c
@@ -223,18 +223,12 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		req = &iommu->prq[head / sizeof(*req)];
 		address = (u64)req->addr << VTD_PAGE_SHIFT;
 
-		if (unlikely(!req->pasid_present)) {
-			pr_err("IOMMU: %s: Page request without PASID\n",
-			       iommu->name);
-bad_req:
-			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
-			goto prq_advance;
-		}
-
 		if (unlikely(!is_canonical_address(address))) {
 			pr_err("IOMMU: %s: Address is not canonical\n",
 			       iommu->name);
-			goto bad_req;
+bad_req:
+			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
+			goto prq_advance;
 		}
 
 		if (unlikely(req->pm_req && (req->rd_req | req->wr_req))) {

-- 
2.43.0


