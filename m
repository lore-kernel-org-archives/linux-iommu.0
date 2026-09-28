Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595B646EC98
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583994; cv=none; b=LqrTF7X281ZYMLrR0OD8c6CqjhPIHZxuMtPyeUh7i1/OTZcyrtCxB+wd0a5HeSTpYMj68AKPvZhT98eNgNJr5tn8fGDobyAdC5barjYwy3VgldNIFBklYeyIWJHZQ8l06NE9nnFtYeZYhmUnIeHt1Av7/cnGORSdugfaUw0Y1Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583994; c=relaxed/simple;
	bh=n9KEbkTpkmfSdne6cTn6r3DBh1DbzmHKhMyccZB4gVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUv/uSmGs+v2h90BtCXej2b0M1clI2+yI/R9aKZHv5PCJ5JadX6rfc83h9uWghIaQpShUK2dDUNEOIWEfgV9w04/BEukRPykfR7kToC8uRlZFJlD08+ZQ76K0PDLJs312mC7cvpwBSPGp6swrWmi43eJb6r+H/wbtPJqZc3RU0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00db6de583eafb82e4.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:db6d:e583:eafb:82e4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DEF5D1C7759;
	Mon, 28 Sep 2026 10:18:14 +0200 (CEST)
Date: Mon, 28 Sep 2026 10:18:12 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Guanghui Feng <guanghuifeng@linux.alibaba.com>, 
	Zhenzhong Duan <zhenzhong.duan@intel.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9][PULL REQUEST] Intel IOMMU updates for v7.4
Message-ID: <aroiryQoEh92LOGy@8bytes.org>
References: <20260928032722.2868623-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928032722.2868623-1-baolu.lu@linux.intel.com>

On Mon, Sep 28, 2026 at 11:27:13AM +0800, Lu Baolu wrote:
> Guanghui Feng (1):
>   iommu/vt-d: Fix IQE handling to cover all descriptors in submission
>     range
> 
> Lu Baolu (7):
>   iommu/vt-d: Avoid out-of-range shift in qi_desc_dev_iotlb_pasid()
>   iommu/vt-d: Do not ignore context table copy failures
>   iommu/vt-d: Handle DID reservation errors when copying context tables
>   iommu/vt-d: Reserve scalable-mode DIDs from PASID entries during copy
>   iommu/vt-d: Use old domain parameter when attaching the blocking
>     domain
>   iommu/vt-d: Fix iopf refcount leak in nested attach
>   iommu/vt-d: Drop old iopf ref only after attach succeeds
> 
> Zhenzhong Duan (1):
>   iommu/vt-d: Fix page table level calculation in compute_vasz_lg2_ss()

Applied, thanks Baolu.
