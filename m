Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3728134D8
	for <iommu@lists.linux.dev>; Fri, 23 Jun 2023 21:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1HkDEW7AxSHLZvHADInYpWBN1+Bsf50V6Er9x8KFaJk=;
  b=BfrIEUyQFLrGM984hWuTDVJ9BMp+YgtR3JEATuk5EkoZBafGGqyDRXjy
   GAn3Um4ZVQx9UGrkJUHaG/3M/yr6kZYJ19tAksbvEPhtIVa8nQg5SsDSO
   jtf7phSjQezrORoUWJ63Ez5TVQ12NuIb2JdR80iGNsvJm0dJOPwU7L6oG
   U=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,153,1684792800"; 
   d="scan'208";a="59686171"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 23:15:12 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: keescook@chromium.org,
	kernel-janitors@vger.kernel.org,
	Krishna Reddy <vdumpa@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/26] iommu/tegra: gart: use array_size
Date: Fri, 23 Jun 2023 23:14:44 +0200
Message-Id: <20230623211457.102544-14-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230623211457.102544-1-Julia.Lawall@inria.fr>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use array_size to protect against multiplication overflows.

The changes were done using the following Coccinelle semantic patch:

// <smpl>
@@
    expression E1, E2;
    constant C1, C2;
    identifier alloc = {vmalloc,vzalloc};
@@
    
(
      alloc(C1 * C2,...)
|
      alloc(
-           (E1) * (E2)
+           array_size(E1, E2)
      ,...)
)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/iommu/tegra-gart.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index a482ff838b53..def222da83f1 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -348,8 +348,8 @@ struct gart_device *tegra_gart_probe(struct device *dev, struct tegra_mc *mc)
 	if (err)
 		goto remove_sysfs;
 
-	gart->savedata = vmalloc(resource_size(res) / GART_PAGE_SIZE *
-				 sizeof(u32));
+	gart->savedata = vmalloc(array_size(resource_size(res) / GART_PAGE_SIZE,
+					    sizeof(u32)));
 	if (!gart->savedata) {
 		err = -ENOMEM;
 		goto unregister_iommu;

