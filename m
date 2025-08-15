Received: from va-1-18.ptr.blmpb.com (va-1-18.ptr.blmpb.com [209.127.230.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6E61E3DFE
	for <iommu@lists.linux.dev>; Fri, 15 Aug 2025 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245291; cv=none; b=RTTI7EbR6uKt/uUBBgYyVyeopmKXHe+izJFnZVinBeq2xEVC4CWPhS3zdOYe/242WG0Qy5xCpCWcvpWY9Ms6UPpbD++uG7kcp/KeSLhxmC6HpYjPtgBN2hgXmoDx5Ud6XNN4vUyyCBUo9z0pzdV9XYzpEPAFDDK6oaCsEZTAkwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245291; c=relaxed/simple;
	bh=5nOrQy3XElJENfSC/LatOI56f9OxwJE4m2TuPasPCn0=;
	h=To:From:Mime-Version:Date:Message-Id:In-Reply-To:Subject:
	 Content-Type:Cc:References; b=ocCekB7a/WGs9ZcFKSDCihN6ChyyrN4XGj9SxUjElV24xGGX8jyXGvBGAmnx/kPJlOaUBBy+ISpbkq34tJTambEe0LcDcHRVjYIPFb91CFAoP7mFdfbP/K1B+NIH26jIbsww2A/uX2H2z6tMRNyUYqBEQbEyMHLsA8IrCow7/5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=JCHaOt79; arc=none smtp.client-ip=209.127.230.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="JCHaOt79"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1755244556;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=JFpwghLSkeHlDIyCqRaPY0QI7oFLO/bDk8iDSgor+H0=;
 b=JCHaOt79+FpJwMEF7MRFiVBmM7NRIVRO46N9vtxoUBQNCWKKuPHJnhr1vPpzS8NH/c0s/I
 33ez8lQ1GIkU3aGeRNvcisNTor4xcYX4/obXTRhXN9VeCXJMyi5nLH0EiAZAzWBNyHlD62
 GEwqxVMbCRlj3QDclzcpb+Mtdclvs4G7kFh7VICQThkE7567Bup+Wz4J2RVj6SASBmc6o6
 AoBpSQBCWEDINl1b4IkCjPCXKe5LRQRe4RihqqppIEokahkYW+w2P/V0WMKTz8xmxN8L0/
 3eK3aNopCH3jZs/7unM/Isv9V2FBhHK+KLSlUxon8ip2aLd+qxYrylKsjtF6uA==
To: <sunilvl@ventanamicro.com>
From: "XianLiang Huang" <huangxianliang@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1
Date: Fri, 15 Aug 2025 15:55:41 +0800
Message-Id: <20250815075541.29941-1-huangxianliang@lanxincomputing.com>
Received: from LeonHXL.localdomain ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Fri, 15 Aug 2025 15:55:53 +0800
In-Reply-To: <20250716104059.3539482-2-sunilvl@ventanamicro.com>
Subject: Re: [PATCH v5 1/3] ACPI: RISC-V: Add support for RIMT
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Cc: <ajones@ventanamicro.com>, <alex@ghiti.fr>, <anup@brainfault.org>, 
	<apatel@ventanamicro.com>, <atishp@rivosinc.com>, 
	<iommu@lists.linux.dev>, <joro@8bytes.org>, <lenb@kernel.org>, 
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>, <palmer@dabbelt.com>, 
	<paul.walmsley@sifive.com>, <rafael@kernel.org>, <robin.murphy@arm.com>, 
	<tjeznach@rivosinc.com>, <will@kernel.org>, 
	<huangxianliang@lanxincomputing.com>
X-Lms-Return-Path: <lba+2689ee80a+6efd27+lists.linux.dev+huangxianliang@lanxincomputing.com>
References: <20250716104059.3539482-2-sunilvl@ventanamicro.com>
X-Original-From: XianLiang Huang <huangxianliang@lanxincomputing.com>

Hi Sunil,

On Wed, 16 Jul 2025 16:10:57 +0530, Sunil V L wrote:
> +	parent = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table, map->dest_offset);
> +
> +	if (node->type == ACPI_RIMT_NODE_TYPE_PLAT_DEVICE ||
> +	    node->type == ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX) {
> +		*id_out = map->dest_offset;
> +		return parent;
> +	}

Why do we assign dest_offset to id_out? The dest_offset is the iommu offset, not
a valid deviceid required for platform device in rimt_plat_iommu_map?

Regards,
Xianliang
