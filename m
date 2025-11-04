Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE102951A7;
	Tue,  4 Nov 2025 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246303; cv=none; b=szM6HsgtD3Yx6fftI2QydDOFSBwprU4SLz+mxzVwPXdJti8h6sI6abUevUv4ti/iBawHknfLR9zCoFvTCLhzrzjGibReJ9OGwISS3hXFDyEj2HIGSb2kX47fYv0lulalITZYyqnH8a/MR7p8ZUdr7x/DAoYjtv80Eh8LaNb5cnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246303; c=relaxed/simple;
	bh=eSPbfUhqhg4ACELWn76cYsuGxPgVYiIt7seUfEZq8uQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SNsnpMfCP8hLsur8/wf6aEcZVxw0/XEF+Qs3Onmtb+DStzla4Bx8J3gPsio6sQv1xokKb/AJaykPSWa0l4PT5afMJruRqcaNYkC4eJPViTWjYZrLt53x8ykt5Be07I1SctriI5275CIBZXwDxOxxJXtup+ymnn2913TFBVWwvBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lJ2BTl0j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lJ2BTl0j"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A48hM2O1538308;
	Tue, 4 Nov 2025 08:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Shu5iXGOh6M
	z3xavbR5acveN2DN+xpWF20uo9kboPvE=; b=lJ2BTl0jITqoLKAUUOxJOFdxbDL
	P7Mx0pxvp8BIlrl4dsgLRm/wkEXK3hKO7wuz66vC3wpYSOXx/ap/X1jIvL9TpVdN
	meMDAjg34mB4NO8tgkj9eLn3sSCMxPzZDQlCcRmxYiJWdDx6JyygrnqCv3M9aUEy
	8qDqGvi25c0wA2+Lvkgmg1eknoOq3I+sLT++rCf6H8psAC6qMHobvV/UmsRSvmKJ
	LHO50qT6f+7gjc57OJ25L07B5yvbSQF7jNc18W4do0HZuLLQjNEGjuiEbS/zqTzM
	vpAb20K2/Y8zvEeILZD170A4CPByMdzcNpB/n07I7YRMIEJkWT02eK88EBQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6xjqtrwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:31 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A48pR7j016325;
	Tue, 4 Nov 2025 08:51:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a5b9m551n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:28 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A48pQUd016290;
	Tue, 4 Nov 2025 08:51:27 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-charante-hyd.qualcomm.com [10.213.97.134])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 5A48pRGC016409
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 08:51:27 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 389980)
	id 05AF25F4; Tue,  4 Nov 2025 14:21:26 +0530 (+0530)
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
To: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, saravanak@google.com,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: [PATCH 6/6] of: use correct iommu-map parsing logic from of_iommu layer
Date: Tue,  4 Nov 2025 14:21:05 +0530
Message-Id: <b1ad7bee26fc87c1b73ac18d2284ad2e10b4b4d5.1762235099.git.charan.kalla@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1762235099.git.charan.kalla@oss.qualcomm.com>
References: <cover.1762235099.git.charan.kalla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6y6x3-m2YWocG4MPXXKbU3GdR2zXwdb6
X-Proofpoint-ORIG-GUID: 6y6x3-m2YWocG4MPXXKbU3GdR2zXwdb6
X-Authority-Analysis: v=2.4 cv=criWUl4i c=1 sm=1 tr=0 ts=6909be93 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=BWPSM1Px-4UC32KkbhQA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA3MSBTYWx0ZWRfX3JbM2EbuudhD
 6W0WzU8FsFapNsiex2wzU/0UZaAooHpXSClU6/t5Izi2abn8j8eYixUbZCX2JTSoGmlNJFwu+nh
 gcweQ10cr5n9Y5C3NplAuqzPdYLI4IgFHz2ujlYkjXt2lhCFdef/XsX42ZEGkOgyQ61Wp7zJBKX
 nahkxdkKwDqHTNhdM2rNdAO+2PGXBlrmuwNG+080juc9wVy6iyCLGlH80tbnuwzije4EZeyJF2u
 GHMaHPQFOuZfDrGRZCe9HSQh7FGb4R+moNEqYlsaeR9fboGIDgtQEaUp3tWvoqJ9BX2oyp6yWzK
 hcwg8vU2Wn5N3/SHA7S2W70EVbH+mv0g+Jm6Tv5+swNY2lTIeg5Sgn8q6NWSE5FPrb3gFIxC3CK
 qTOV4gfVbBv/bNWv94wkV/Pq5pib8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040071

Use of_map_id_or_funcid() that takes #iommu-cells into account, while
keeping the compatibility with the existing DTs, which assume single
argument. A callback function is used to get the of_phandle arguments,
that contains iommu controller and its cells, and is called into the
vendor specific driver through of_iommu_xlate().

When 'args_count' passed in of_phandle_args is '1', it is expected that
of_map_id_or_funcid() fills the translated id into the of_phandle
arguments which then called into of_iommu_xlate().

When 'args_count' > 1, as it is complex to establish a defined relation
between the input id and output, of_iommu layer handles through the
below relation:
For platform devices, 'rid' defined in the iommu-map tuple indicates a
function, through a bit position, which is compared against passed input
'id' that represents a bitmap of functions represented by the device.

For others, 'rid' is compared against the input 'id' as an integer value.

When matched, of_iommu_xlate() is used to call into vendor specific
iommu driver.

Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
---
 drivers/iommu/of_iommu.c | 59 +++++++++++++++++++++++++++++++++-------
 drivers/of/base.c        |  4 +--
 include/linux/of.h       | 15 ++++++++++
 3 files changed, 66 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 6b989a62def2..9575e37ad844 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -16,6 +16,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/fsl/mc.h>
+#include <linux/platform_device.h>
 
 #include "iommu-priv.h"
 
@@ -41,22 +42,60 @@ static int of_iommu_xlate(struct device *dev,
 	return ret;
 }
 
+/**
+ * of_iommu_map_xlate - Translate IOMMU mapping and release node reference.
+ *
+ * @id: bitmap for function id parsing(platform devices) or base id.
+ * @id_base: checked against @id
+ * @arg: Device to configure.
+ * @iommu_spec: IOMMU specifier from device tree.
+ *
+ * Wrapper function that calls of_iommu_xlate() to configure the IOMMU
+ * mapping for a device, then releases the device tree node reference.
+ * This is used as a callback function for of_map_id_or_funcid().
+ *
+ * When the cell_count > 1, the relation between input id(@id) and the
+ * output specifier is complex to define, like linear case when cell_count = 1,
+ * Handle such cases where linear relation can't be established between
+ * the @id and the output with the below relation:
+ * a) For platform devices, @id_base represents the function id, which is
+ * compared against the input @id, all maintained in bitmap relation.
+ * b) For other devices, it performs exact ID matching.
+ *
+ * Return: 0 on success, -EAGAIN if ID doesn't match
+ * and standard negative error code on failure.
+ */
+static int of_iommu_map_xlate(u32 id, u32 id_base,
+			void *arg, struct of_phandle_args *iommu_spec)
+{
+	struct device *dev = arg;
+	int ret;
+
+	if (iommu_spec->args_count > 1) {
+		if (dev_is_platform(dev)) {     /* case a. */
+			if (!(BIT(id_base - 1) & id))
+				return -EAGAIN;
+		} else if (id_base != id) {     /* case b. */
+			return -EAGAIN;
+		}
+
+	}
+
+	ret = of_iommu_xlate(dev, iommu_spec);
+	of_node_put(iommu_spec->np);
+	return ret;
+}
+
 static int of_iommu_configure_dev_id(struct device_node *master_np,
 				     struct device *dev,
 				     const u32 *id)
 {
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
-	int err;
 
-	err = of_map_id(master_np, *id, "iommu-map",
-			 "iommu-map-mask", &iommu_spec.np,
-			 iommu_spec.args);
-	if (err)
-		return err;
-
-	err = of_iommu_xlate(dev, &iommu_spec);
-	of_node_put(iommu_spec.np);
-	return err;
+	return of_map_id_or_funcid(master_np, *id, "iommu-map",
+			"iommu-map-mask", &iommu_spec.np,
+			 iommu_spec.args, dev, &iommu_spec,
+			 of_iommu_map_xlate);
 }
 
 static int of_iommu_configure_dev(struct device_node *master_np,
diff --git a/drivers/of/base.c b/drivers/of/base.c
index cd221c003dd5..b5554c0b0bc5 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2181,7 +2181,7 @@ static int of_map_id_cell_count(const __be32 *map, const char *map_name,
  * @id: input id that is given for translation.
  * @arg: argument passed to the @fn.
  * @pargs: filled by the contents of @map and pass to the @fn.
- * @fn: Callback function that operated on @dev and @fn.
+ * @fn: Callback function that operates on @arg.
  *
  * The function populates the phandle args structure with the node and
  * specifier cells, then invokes the callback function. The callback is
@@ -2233,7 +2233,7 @@ static int of_map_id_untranslated(const __be32 *map, u32 cell_count, u32 id,
  *
  * Return: 0 on success or a standard error code on failure.
  */
-static int of_map_id_or_funcid(const struct device_node *np, u32 id,
+int of_map_id_or_funcid(const struct device_node *np, u32 id,
 		const char *map_name, const char *map_mask_name,
 		struct device_node **target, u32 *id_out,
 		void *arg, struct of_phandle_args *pargs,
diff --git a/include/linux/of.h b/include/linux/of.h
index f8d976205ff4..7935ff5ac09e 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -410,6 +410,12 @@ extern int of_phandle_iterator_args(struct of_phandle_iterator *it,
 extern int of_alias_get_id(const struct device_node *np, const char *stem);
 extern int of_alias_get_highest_id(const char *stem);
 
+extern int of_map_id_or_funcid(const struct device_node *np, u32 id,
+	       const char *map_name, const char *map_mask_name,
+	       struct device_node **target, u32 *id_out,
+	       void *arg, struct of_phandle_args *pargs,
+	       of_map_id_cb fn);
+
 bool of_machine_compatible_match(const char *const *compats);
 
 /**
@@ -909,6 +915,15 @@ static inline int of_map_id(const struct device_node *np, u32 id,
 	return -EINVAL;
 }
 
+static inline int of_map_id_or_funcid(const struct device_node *np, u32 id,
+	       const char *map_name, const char *map_mask_name,
+	       struct device_node **target, u32 *id_out,
+	       void *arg, struct of_phandle_args *pargs,
+	       of_map_id_cb fn)
+{
+	return -EINVAL;
+}
+
 static inline phys_addr_t of_dma_get_max_cpu_address(struct device_node *np)
 {
 	return PHYS_ADDR_MAX;
-- 
2.34.1

