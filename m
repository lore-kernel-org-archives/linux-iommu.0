Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966EE182CC
	for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 14:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1sXATaOQFUGiET/ojS3B/ZSG4Py8hHBuvNarEMw2KCM=;
  b=KSr4HdSZCErHO2NZAduGYuYcXD6gUFYTrhSuLZkHDtlEbDCReV+1qTH6
   N/LpPNb9lFET+P9TMPaAnaiy9H1tpVEMXMX1ed6lg38ZguvsDMgkw6YfQ
   6PqahJ+o3rvCXo9GjaocbTbqJbf4DpBod97Uyhx6lp6JPmc41SpqnKXVD
   g=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,162,1684792800"; 
   d="scan'208";a="114936335"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 16:43:52 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel-janitors@vger.kernel.org,
	keescook@chromium.org,
	christophe.jaillet@wanadoo.fr,
	kuba@kernel.org,
	Krishna Reddy <vdumpa@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/24] iommu/tegra: gart: use vmalloc_array and vcalloc
Date: Tue, 27 Jun 2023 16:43:28 +0200
Message-Id: <20230627144339.144478-14-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230627144339.144478-1-Julia.Lawall@inria.fr>
References: <20230627144339.144478-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use vmalloc_array and vcalloc to protect against
multiplication overflows.

The changes were done using the following Coccinelle
semantic patch:

// <smpl>
@initialize:ocaml@
@@

let rename alloc =
  match alloc with
    "vmalloc" -> "vmalloc_array"
  | "vzalloc" -> "vcalloc"
  | _ -> failwith "unknown"

@@
    size_t e1,e2;
    constant C1, C2;
    expression E1, E2, COUNT, x1, x2, x3;
    typedef u8;
    typedef __u8;
    type t = {u8,__u8,char,unsigned char};
    identifier alloc = {vmalloc,vzalloc};
    fresh identifier realloc = script:ocaml(alloc) { rename alloc };
@@

(
      alloc(x1*x2*x3)
|
      alloc(C1 * C2)
|
      alloc((sizeof(t)) * (COUNT), ...)
|
-     alloc((e1) * (e2))
+     realloc(e1, e2)
|
-     alloc((e1) * (COUNT))
+     realloc(COUNT, e1)
|
-     alloc((E1) * (E2))
+     realloc(E1, E2)
)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
v2: Use vmalloc_array and vcalloc instead of array_size.
This also leaves a multiplication of a constant by a sizeof
as is.  Two patches are thus dropped from the series.

 drivers/iommu/tegra-gart.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -u -p a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -348,8 +348,8 @@ struct gart_device *tegra_gart_probe(str
 	if (err)
 		goto remove_sysfs;
 
-	gart->savedata = vmalloc(resource_size(res) / GART_PAGE_SIZE *
-				 sizeof(u32));
+	gart->savedata = vmalloc_array(resource_size(res) / GART_PAGE_SIZE,
+				       sizeof(u32));
 	if (!gart->savedata) {
 		err = -ENOMEM;
 		goto unregister_iommu;

