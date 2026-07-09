Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853553C552B;
	Thu,  9 Jul 2026 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783627119; cv=none; b=izQ47GAhusQK/1tXESc0wgU9Mr9eUm90snCNz0DqqfrWquvewmmuRPSImE7nvwxMVi7RTGjd2rnYKUiAez2HXiNO/7gQEljCjOVSCPd97L2oRlrogjdYZ4WrzCelYlUVhIxevlj4m/n4V6/3EMoazldLcdd+N+OypO9kiAsXLfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783627119; c=relaxed/simple;
	bh=5pNf2xZzAqCooI9pNGi+wOiXa/COYR39H9LRGaTEOJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnP1bkukvMlodecQnxWbpYMKOSU6D6kWFcgrDjIOmOJ85kPutdm56/Z89zE0DaD3QFi+GCNBlZCj52tBDnuVJhKkIr2YAMt18ryluvRj7J7rMe8CtfV7lvInoqrdb/xI/TyOMm0OMr5b92ZH76T8g9bxZb9wbdvdxY2rWA5OWqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8nlg64/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8nlg64/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1132E1F00A3D;
	Thu,  9 Jul 2026 19:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783627118;
	bh=iPPvVf5D6y7d2MiVXSZ4GbJUHiKcCLQ7l0EG1noZUrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F8nlg64/CXSfLg2k/fPfmxhVFU6K15rQyra/FtKctpRCgGcJnz8nG5XDc+HRZ/qUg
	 BNjHhr6U3IuUGkXKgjhRxCPlxQqTYdu3LAPCL7kPGuFUSGvTRyOUgQ1XA1KppPqAIJ
	 EEs6RvVwF34kPXRZ43ihElTDeus1LzzsvaX9+6Parxbteh7Dny3/AhbbFiE9y+kuM9
	 U60wTrE4e2UosxuFUCjMHUkJ8ILrjwT6e9wK1x7Y7ILtOQ7KAKJ7MlGB5zye0csev8
	 9cEcRFs+JaZIZc4fs4ZmjBX6Sdvbodg3+PrsmkJjS1BwIz65yvPC5PgtN4IpW+KAFx
	 PRnjzsrTBzR1g==
From: Tycho Andersen <tycho@kernel.org>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joerg.roedel@amd.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Tycho Andersen (AMD)" <tycho@kernel.org>
Subject: [PATCH v1 2/2] iommu/amd: Fix nested domain leak
Date: Thu,  9 Jul 2026 13:57:36 -0600
Message-ID: <20260709195736.3070536-3-tycho@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709195736.3070536-1-tycho@kernel.org>
References: <20260709195736.3070536-1-tycho@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Tycho Andersen (AMD)" <tycho@kernel.org>

A couple of runs of different AI tools have generated something like the
following bug report:

    In nested_domain_free(), when refcount_dec_and_test() returns false
    (other nested domains still reference the same gdom_info), the function
    returns without calling kfree(ndom), leaking the nested_domain
    structure. This problem wasn't introduced by this patch, but exists in
    the code from commit 757d2b1fdf5b that the patch modifies. Each
    nested_domain (ndom) is allocated individually in
    amd_iommu_alloc_domain_nested() via kzalloc_obj(*ndom). The .free
    callback is the sole point responsible for freeing this domain. When
    the refcount is > 0, only the xa_unlock_irqrestore is performed and the
    function returns, leaving ndom permanently allocated. This leak occurs
    every time a nested domain sharing a gDomID is destroyed while other
    domains still use that gDomID.

There is a similar leak later in this function in the WARN_ON() test when
the mapping is already NULL. Switch to a RAII-based cleanup for ndom, since
it should always be freed in this function.

Fixes: 757d2b1fdf5b ("iommu/amd: Introduce gDomID-to-hDomID Mapping and handle parent domain invalidation")
Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
---
 drivers/iommu/amd/nested.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index 5c9405223f91..63b53b29e029 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -263,7 +263,7 @@ static void nested_domain_free(struct iommu_domain *dom)
 {
 	unsigned long irqflags;
 	struct guest_domain_mapping_info *curr;
-	struct nested_domain *ndom = to_ndomain(dom);
+	struct nested_domain *ndom __free(kfree) = to_ndomain(dom);
 	struct amd_iommu_viommu *aviommu = ndom->viommu;
 
 	xa_lock_irqsave(&aviommu->gdomid_array, irqflags);
@@ -290,7 +290,6 @@ static void nested_domain_free(struct iommu_domain *dom)
 
 	amd_iommu_pdom_id_free(ndom->gdom_info->hdom_id);
 	kfree(curr);
-	kfree(ndom);
 }
 
 static const struct iommu_domain_ops nested_domain_ops = {
-- 
2.55.0

