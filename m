Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC339901C
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698427; cv=none; b=M3hzqyck8U8oC53WuGfB3Xg78kpv0h9/34inPOFZa4AKnePJU6eFQ9AKkyQmuNhrQ+muTSvzpx3up5NE5ygFgch0Ve9aPgUsIMOpBwMTo7+I0a04hNL4aHKIxRpqHxFCEjkeKg0Ze1C/cn3HbmJID6EgSD6s/Py6CLqCqX2R0jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698427; c=relaxed/simple;
	bh=1T+8gtW07YW1Q2hsQQ/eNWlwxVUQfk7M7+0pK1hZj3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyb5meiyH1Q7pF0CsYwfZCrAXrTmUI4PkBD8w2FqbViAgwayt9gCY+9/LNhWHKdu+hTV3dSKiGwwUfgFXziMkKmXdm1pd4IJGSewS7dhQ9ZXQq9RHPy8Hwe+G9ranOQcU9l+6jzbV0Qt65ChqQyrus3EsDF0R9ElrzxHJNdOV1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fsqY3tmR; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fsqY3tmR"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-132cccd3d77so255c88.1
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 11:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778698426; x=1779303226; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F5FAcCWafjYrA9kZBinQj9N8tnqNIZ+FA0Q4wW5bFp4=;
        b=fsqY3tmRp9JaLE1nGjI5ozFmmqnPtNQXOZROiPtNQzg0tBBvgBNNEI9coWMyFnlQrr
         19eceAZC0RsSpCTequ+y7O+ZKsT1wjL2973lI5FVVeYuQNpPFyO5l8sUhUW4LvA0feA2
         VUANOauG9grPY2u4+HFlRmcBZFATGIbyp98+fwQQZL4rrtBVLsX4PYW0IoT7EtS+xgeC
         SnQBGkqqoTKaPZEjtN1uWursIqmdTO7FQ4krKmS8r3ICecusnj++KPBllOk8as2TUJSs
         ejFSiNLlMbsZw+WpG2jLmARzu48rUjxBB7M7swB56g5UOLyKVrIM/vxevRhsY96332W0
         kE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778698426; x=1779303226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5FAcCWafjYrA9kZBinQj9N8tnqNIZ+FA0Q4wW5bFp4=;
        b=dSCCnO3gdYVNtp1BnNW+ZdxbWU84nEvVY0MIshcdORplqZOUNVpc0wih582HlfK59f
         7nnTvBYYMNbxKXfnfr2uDNLHTCCYO0FUC/tnIh5XHFtTGiF9FHrLSLe1bELEfLWrBJx7
         T/ZabTyEoMua92iIUTFyeDZ0WWkdwIsl9bssoqZP8OHJKTYArZqahdIW2MCitPsGUbN8
         87PgWt344Y1y6oDvP9HzHrsu1L71d4ufrnOJ63xPelAwe9yvYBYAtgWhOdeJULCuiLKK
         ObYErLnW94JHqaQgyPHxH4rEwTRlgIcenzndOyvUJFv7pG+Hmo83pM2+3RkRz1Irq+EQ
         fiHw==
X-Gm-Message-State: AOJu0YxiXL8QOVP4UqAMgIgsjUcBU0e2ZBsR14YGTiUJMuZFmYVLZ/Ju
	R4+UIq/+Ks5a4jJV4Zw6jCC24xOHkrOmoW7AwAc4Xp7hhEoDhsieYgYMRmpVmwmNug==
X-Gm-Gg: Acq92OH/Rck58tTv1GDuioV7FNowW2grzJTkWqFZJSwTLKxhIiErSC+N6Iu8jDskgH8
	Sef2NRCTh6G6DckkjIjj6QFy8AFyJ72LV1IhjOqmn2WiaO0lNOUr1ao+b4HG3EM0x9bjA6jHnDd
	HReeDZnvJxpvrI3H5ImAn5+Lf4WbkMBnrrA3sloURMbH7R4eTec3d5pGZ8KNT2AEMNk0u3cnL1r
	g4WXOu76FuNlo5ZG9qtob9rQ9+SdpLijKP0IYW1v4L4HJj49YYII0KQqzgYqqv8q31Pdw7htO8q
	3vSDD5f95G126qak1PuPdUkGrrb2vWmlYHC5JMSF053unwoYtTIoQEvnhS2TvVGKoSNzPn0Ja1Q
	nH1LYJW94O1AihwLDZ23C4669BmEJc7qFYs1tEeia+WNztcr5PR+vO+2IHE7wAfWbAVCxcwn9wl
	Ff13LfqRcc6F5/HKzmOODiTWyed1KwwyW0Ib9LpsQVZJVEqtJfPuU+QG6zDeEc9zjZCXOfJBrdu
	DxDraaM
X-Received: by 2002:a05:7022:f9c:b0:130:c9cc:2919 with SMTP id a92af1059eb24-134cc1108bbmr38022c88.19.1778698425009;
        Wed, 13 May 2026 11:53:45 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8884752ccsm22785382eec.17.2026.05.13.11.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:53:44 -0700 (PDT)
Date: Wed, 13 May 2026 18:53:40 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joerg.roedel@amd.com>, Josua Mayer <josua@solid-run.com>, 
	Kevin Tian <kevin.tian@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	patches@lists.linux.dev, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH rc 5/5] iommupt: Fix the end_index calculation in
 __map_range_leaf()
Message-ID: <agTHzU3KYofnszp4@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <5-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>

On Tue, May 12, 2026 at 01:46:17PM -0300, Jason Gunthorpe wrote:
>Sashiko noticed a mismatch of units in this math: num_leaves is
>actually the number of leaf *entries* (so a 16-item contiguous leaf
>is one num_leaves), while index is in items. The mismatch in maths
>causes __map_range_leaf() to exit early instead of efficiently
>filling a larger range of contiguous PTEs.
>
>The early exit is caught by the functions above and then
>__map_range_leaf() is re-invoked, so there is no functional issue.
>
>Correct the misuse of units by adjusting num_leaves with the leaf
>size and avoid the performance cost of looping externally.
>
>There are also some mismatched types for num_leaves; simplify
>things to remove the duplicated calculations.
>
>Fixes: d6c65b0fd621 ("iommupt: Avoid rewalking during map")
>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>---
> drivers/iommu/generic_pt/iommu_pt.h | 20 +++++++++++++-------
> 1 file changed, 13 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
>index 4877b05291c9d4..dc91fb4e2f61cb 100644
>--- a/drivers/iommu/generic_pt/iommu_pt.h
>+++ b/drivers/iommu/generic_pt/iommu_pt.h
>@@ -534,10 +534,12 @@ static int __map_range_leaf(struct pt_range *range, void *arg,
> 	struct pt_state pts = pt_init(range, level, table);
> 	struct pt_iommu_map_args *map = arg;
> 	unsigned int leaf_pgsize_lg2 = map->leaf_pgsize_lg2;
>+	unsigned int leaves_avail;
> 	unsigned int start_index;
> 	pt_oaddr_t oa = map->oa;
>-	unsigned int num_leaves;
>+	pt_vaddr_t num_leaves;
> 	unsigned int orig_end;
>+	unsigned int step_lg2;
> 	pt_vaddr_t last_va;
> 	unsigned int step;
> 	bool need_contig;
>@@ -546,21 +548,25 @@ static int __map_range_leaf(struct pt_range *range, void *arg,
> 	PT_WARN_ON(map->leaf_level != level);
> 	PT_WARN_ON(!pt_can_have_leaf(&pts));
>
>-	step = log2_to_int_t(unsigned int,
>-			     leaf_pgsize_lg2 - pt_table_item_lg2sz(&pts));
>-	need_contig = leaf_pgsize_lg2 != pt_table_item_lg2sz(&pts);
>+	step_lg2 = leaf_pgsize_lg2 - pt_table_item_lg2sz(&pts);
>+	step = log2_to_int_t(unsigned int, step_lg2);
>+	need_contig = step_lg2 != 0;
>
> 	_pt_iter_first(&pts);
> 	start_index = pts.index;
> 	orig_end = pts.end_index;
>-	if (pts.index + map->num_leaves < pts.end_index) {
>+	leaves_avail =
>+		log2_div_t(unsigned int, pts.end_index - pts.index, step_lg2);
>+	if (map->num_leaves <= leaves_avail) {
> 		/* Need to stop in the middle of the table to change sizes */
>-		pts.end_index = pts.index + map->num_leaves;
>+		pts.end_index = pts.index + log2_mul(map->num_leaves, step_lg2);
> 		num_leaves = 0;
> 	} else {
>-		num_leaves = map->num_leaves - (pts.end_index - pts.index);
>+		num_leaves = map->num_leaves - leaves_avail;
> 	}
>
>+	PT_WARN_ON(
>+		log2_mod_t(unsigned int, pts.end_index - pts.index, step_lg2));
> 	do {
> 		pts.type = pt_load_entry_raw(&pts);
> 		if (pts.type != PT_ENTRY_EMPTY || need_contig) {
>-- 
>2.43.0
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

Thanks,
Sami
