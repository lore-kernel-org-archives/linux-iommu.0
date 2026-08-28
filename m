Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18AD451996
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787921663; cv=none; b=Zh1RReMgZPPR+qoTZe3XDcE5yhuhRsMhqjecvFYqBGsBzBJAKWSNS/zg2lgNrglIySeiGvp7xrNSIGbzytUMGJtVD62NHjenA3D1gZfTC9j6aK6rHVZdxG6IkgUET3+okX2VH4XxwIFdhQH3bWQhRkgOOBqUtrPbd9GPcoUXTIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787921663; c=relaxed/simple;
	bh=oK0J178nG2/SnhSd8NbdANj5bxRiyctq80z3lFJEcFk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MZEj5nQKfVMtifI4l/+S7k+da5q0efkVIlo2sT/e5IDqKaACsIU3dmU5QegCkqtY3trPES7A7VuHWx+RzkUtuv/Ql0A5u2/vpNdrZjHLiOAhSZCiv4ehUDoF2pEPIRccyd8vFayc4TOYMcvJOmzxR7XH36DH3pRdlnQ8ZlrN5rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBue3Vtx; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBue3Vtx"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-496bbcf7d1eso7100305e9.0
        for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 05:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787921660; x=1788526460; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RAMHtBFkdmGbuLyv/P0Pos4ZoeExbNjIBs0ygiScewk=;
        b=cBue3VtxJq59mr5b8+tXCARDSTyzMobkb/06YU1STDs6Z+5tEsedHULEeymsUGnrLG
         5/BfXGjrhmBmq/ZTAJINtn+rGhZrOjC1qVSm+U14fS1KZGRdBtQxKQRMqRxSXDUUkFem
         3Mx+xIRUw5V0wX3oRLXJIdrYmWBjz2ggXvUtiiFP9AggODvySA0g43maUvEN+kSS5WL/
         +Nl1QCtMvhoM790pnHuAnVnL66AbP5ajWDFPWUI3Iho4nqQjbfeFW2wx1ewYlO4amHSP
         RWtC1aCmt+o10qmTJbhryNQxT5lDd5aOx4yh/o4blrxeHslkJbkRU9TNm+oa9UMTcWlk
         mCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787921660; x=1788526460;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RAMHtBFkdmGbuLyv/P0Pos4ZoeExbNjIBs0ygiScewk=;
        b=e3ZH2gx5El3CE9ivmzmrE5/IXVofQ4enIEJZ78jCoD34RaidpdOU+xlsmlAQ5hRBCk
         9+zDJ+HVVwvBSj77O2PseVnUU8cXPB+Bt9UehCysd+f4F4HZLHftt1oIoV57n7O5/UoV
         Nm23G0fNHmf35zHz9cfF1w95qtqwjXdMpAQyJXcrdVOW/LGbFIl+UbNEtK4l5/UCEpFE
         y4neoxChpCym6v+Q9CQujMirJtjsJaRoU5pNtPU0so6p0HV7XboXDwvKX4tYQobrgL0J
         rFUVvowbb/i3gaALu1js0dEVuPDp+5oFMhYBI+194pCNoXU/iTIigNrmKHhMIu9MsTWG
         dg4A==
X-Forwarded-Encrypted: i=1; AHgh+RojEiWhM7C+ABje8VEyeisa3rGneAvs/HxP2LMN2XjVTu0B1nLvOcLkTyqFGeOnPNi0RpSPsQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mxlaiF4P30T27eloEW6aEoPQ7Q5NJT37RyN0U9awPH5ww99F98
	QSV+DXBlVr5Vl80DK+rcYVYe8pWzBg43s7KhZ0jI9gbIuUIIB85pUctPWoxQWYj6I/ED68Nq/7s
	2QQW4hjMHXnvh4w==
X-Received: from wmbe18.prod.google.com ([2002:a05:600c:5912:b0:495:5edc:795b])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b6b:b0:49b:c8e:8e6 with SMTP id 5b1f17b1804b1-49b91bd99b7mr113262645e9.0.1787921659759;
 Fri, 28 Aug 2026 05:54:19 -0700 (PDT)
Date: Fri, 28 Aug 2026 12:53:38 +0000
In-Reply-To: <20260828125409.1921538-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260828125409.1921538-1-smostafa@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828125409.1921538-4-smostafa@google.com>
Subject: [PATCH 3/7] iommu/arm-smmu-v3-iommufd: Fix error path in arm_vsmmu_cache_invalidate()
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

arm_vsmmu_cache_invalidate() issues commands in batch size.
However, if arm_vsmmu_convert_user_cmd() fails, it will return to the
user that it processed "cur - cmds" which may be part of a batch not
issued yet.

Fix this by calculating the returned entry_num solely based on the
"last" that tracks the last batch that was successfully issued.

Also, fix the number of commands for early failing condition.

Fixes: d68beb276ba2 ("iommu/arm-smmu-v3: Support IOMMU_HWPT_INVALIDATE using a VIOMMU object")
Reported-by: Sashiko <>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 25982bdbcbd9..91776c555f0e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -379,10 +379,13 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 	int ret;
 
 	cmds = kzalloc_objs(*cmds, array->entry_num);
-	if (!cmds)
+	if (!cmds) {
+		array->entry_num = 0;
 		return -ENOMEM;
+	}
 	cur = cmds;
 	end = cmds + array->entry_num;
+	last = cmds;
 
 	static_assert(sizeof(*cmds) == 2 * sizeof(u64));
 	ret = iommu_copy_struct_from_full_user_array(
@@ -391,7 +394,6 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 	if (ret)
 		goto out;
 
-	last = cmds;
 	while (cur != end) {
 		ret = arm_vsmmu_convert_user_cmd(vsmmu, cur);
 		if (ret)
@@ -405,14 +407,12 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 		/* FIXME always uses the main cmdq rather than trying to group by type */
 		ret = __arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, &last->cmd,
 						    cur - last, true);
-		if (ret) {
-			cur--;
+		if (ret)
 			goto out;
-		}
 		last = cur;
 	}
 out:
-	array->entry_num = cur - cmds;
+	array->entry_num = last - cmds;
 	kfree(cmds);
 	return ret;
 }
-- 
2.55.0.897.gb25b4bd76c-goog

