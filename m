Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFABF1EDA11
	for <iommu@lists.linux.dev>; Tue, 11 Feb 2025 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260209; cv=none; b=eeRrvPulstnO9+6U91YC7LdVf/v1Y3KLb8GEiNsLkx21R7643CKnCmuR/P2aus4PvT3sqEjqAHk+pnoStYzUdf0r68uayZG7joUMNVTcdB7FCWiMMzIYwUwLsc5bFwW/Q/1gBlf8mESJ4ZRrJbIWoxBcbFVDFm6Kra9o4lGGI9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260209; c=relaxed/simple;
	bh=pQuzXlGuC3USSo95T3so9kQFIFKraf4/1A90aeMQ8+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ym39rlT9SoKyW5yFlk2046r3DJGtLahPho1sUzIkulR9KqeNrLwstzRiOb56jELhNODvdOv0j5ygMweBSaGVTG6tdzEeZbhNlwxe5mQmMP+VbKt/tdr2IoVTTE7z7AmopIiKX9b6Wemb4ciJM/q2SGtccv66xdWwsnBr+7hETLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=WERcCIv5; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="WERcCIv5"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 6D0FB413DC;
	Tue, 11 Feb 2025 08:50:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1739260206;
	bh=pQuzXlGuC3USSo95T3so9kQFIFKraf4/1A90aeMQ8+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WERcCIv502YbKYPZBgUa0UXpSW6CXbEv2MSHm8amX93b1Q7WndHZedpb4rTYziGaw
	 j1jHOdCapZNV55BMT1/bMyyhAnWY2AcR/NHtSehlnzMckKZaRQH4y8vZA8IaAZn+Z/
	 FcOV/3wcCNfTxvasZwiToD1S2u8MxXbySulNvSD+iptwcWz05z1my9N/kh0QldcbZy
	 OYL+2yltjiV5vJlgujFo66S9MYW8hZDK+4YacyYsKpooM+PzkWdXzO40iLxbmbbCvT
	 qrtpjVocugYKADQVsrhYXbb0n89/urHVcuzUFOwfnJvk0ZJUH4YOhv8+SoXFgr0frm
	 C/ijPB3AaYO8A==
Date: Tue, 11 Feb 2025 08:50:05 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1][PULL REQUEST] iommu/vt-d: Fixes for v6.14-rc
Message-ID: <Z6sBLb3uaacyP6ii@8bytes.org>
References: <20250211005512.985563-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211005512.985563-1-baolu.lu@linux.intel.com>

On Tue, Feb 11, 2025 at 08:55:11AM +0800, Lu Baolu wrote:
> Lu Baolu (1):
>   iommu/vt-d: Make intel_iommu_drain_pasid_prq() cover faults for RID

Applied, thanks Baolu.
