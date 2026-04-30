Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0353290DB
	for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567587; cv=none; b=qgQTV7K5URiLijoHNB5jUPJuziogAfztbJ4oSzoSOx9NCQSol5y0zZGPF3UT08qzKq8yOvZDoCb1TsVbZp+8PH/p1QQj/mti8KF2EaWB57AbOK4zL1ADaNBpfgVvQT/OWdLalLER5RN+xbnycbF9+oAnUmfNoE08Vw5ARc8BRWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567587; c=relaxed/simple;
	bh=KkFAJcN56DdQ7LkM/e3q+BhecPH3iZWC64JcXBWs4MU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GM5a2lt95DeoN+P9iZf7QTs20U5/wkKbDPY42U5CgXQXkCZBzcGmmwiSjx9YTNtCsrd7jH/S0GfsrSfwPpK4cAYeM5MYyu1ajMzUcBKUUv52qfCSba4ObjvEJtwpVkm6jML3ZD1Ffmz3BwVo0XGdXWmEIXIK1ppjxPrl93JF+ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mxSKAux+; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mxSKAux+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=tY
	VXjXirmIZR6ZQ1E8Pp2rDSwH80Wsd508YTDXQA1gI=; b=mxSKAux+VowD81jPvF
	oC/9AUlsMcakNJ7xs19RLjcAQ/f7AqLKohf/7DnQRph+7/J7jfjydJTA0Gu3quXE
	QTJODTzgH+C25SZV/h6o5AhpMjMdQaoP2XDwTkXQE0AtoI8NAu2jU2Q5E4h8czxt
	gj9L4nyZeJePP8IR/d6R/ikLU=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDHWJ46h_NpWWQZCg--.13259S4;
	Fri, 01 May 2026 00:45:48 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 2/2] iommu/arm-smmu-v3: Use FIELD_MODIFY()
Date: Fri,  1 May 2026 00:45:45 +0800
Message-Id: <20260430164545.49637-3-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430164545.49637-1-18255117159@163.com>
References: <20260430164545.49637-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHWJ46h_NpWWQZCg--.13259S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW7uFyUWw4kXF45WryrtFb_yoW8Gr18pa
	yUGryY9rnrJ3Z3Ca9rXF47Z3s0g3Z5Ka48Kr45W39Yqr10k34UWrs3Kwn5Krs7CryxGF17
	uws2q3y5GF1UCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi3fHbUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xxI62nzhzwEWwAA3q

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index ddae0b07c76b..b62e91e4781d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -330,8 +330,7 @@ static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
 	case CMDQ_OP_TLBI_NH_VAA:
 	case CMDQ_OP_TLBI_NH_ALL:
 	case CMDQ_OP_TLBI_NH_ASID:
-		cmd->cmd[0] &= ~CMDQ_TLBI_0_VMID;
-		cmd->cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, vsmmu->vmid);
+		FIELD_MODIFY(CMDQ_TLBI_0_VMID, &cmd->cmd[0], vsmmu->vmid);
 		break;
 	case CMDQ_OP_ATC_INV:
 	case CMDQ_OP_CFGI_CD:
@@ -340,8 +339,7 @@ static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
 
 		if (arm_vsmmu_vsid_to_sid(vsmmu, vsid, &sid))
 			return -EIO;
-		cmd->cmd[0] &= ~CMDQ_CFGI_0_SID;
-		cmd->cmd[0] |= FIELD_PREP(CMDQ_CFGI_0_SID, sid);
+		FIELD_MODIFY(CMDQ_CFGI_0_SID, &cmd->cmd[0], sid);
 		break;
 	}
 	default:
-- 
2.34.1

