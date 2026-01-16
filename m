Received: from sosiego.soundray.org (sosiego.soundray.org [116.203.207.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A8532E698
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.207.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768565383; cv=none; b=KWbsVCORZovRiaV5aG2a6/9Uv2As/3VUxJPQXwAxPK4WGs75pWESiDm/U30HWqvxO4rbvhtJMmtSYvIxr/NrDfysX4ZqCltqB+wtputQjhq/YnJ7f67oeenHme9kLer+ukEGJSg7Fm3gwIAnpN1dfReUOdYbdmhesCjJxCQ1yXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768565383; c=relaxed/simple;
	bh=fZpNl6qLmku+wDFFbX6PIZ6rmp6961Cg6/l5UNO/3aI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qmvDFVLukCE31pN/MUagDT2ZC6A/LJ4Sv0689YOWWqL0Skj1aHeM6+5P/XHzBmy/whI6E8v8fupqiVz+XTWSmEt8qmjDjYqGL/5qXR9Fsfti24FuFqLUWpg/EuVFHoLi+8JyA+rfnsJs55OkROk8IJ80vfuZ+Uodog/TnVOoxvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schreibt.jetzt; spf=pass smtp.mailfrom=schreibt.jetzt; dkim=pass (1024-bit key) header.d=schreibt.jetzt header.i=@schreibt.jetzt header.b=VaIjciaP; arc=none smtp.client-ip=116.203.207.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schreibt.jetzt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schreibt.jetzt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schreibt.jetzt header.i=@schreibt.jetzt header.b="VaIjciaP"
From: Linus Heckemann <linus@schreibt.jetzt>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schreibt.jetzt;
	s=sosiego; t=1768564835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fZpNl6qLmku+wDFFbX6PIZ6rmp6961Cg6/l5UNO/3aI=;
	b=VaIjciaP4wD7UHRzhPtd6F8AOMWXAvojghwS0p4Fk5ELCMWzlfPxkTCV/c/93kpZwPcOpR
	WCRg22Djr5wa9hnCC9EPeM8f9PLzaaK5Y3M8knoeuAnWG/rY2XcozJ+D+aO6IxE6oIjmQo
	0xgKjXdsMswvqqK+eNGQf+FQ+I6vXOA=
To: Jason Gunthorpe <jgg@nvidia.com>, Min Ma <min.ma@amd.com>, Lizhi Hou
 <lizhi.hou@amd.com>, dri-devel@lists.freedesktop.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: amdxdna breaks suspend (was: Re: [PATCH v5 2/8] iommu: Remove
 IOMMU_DEV_FEAT_SVA)
In-Reply-To: <20251230011916.GB23056@nvidia.com>
References: <20250418080130.1844424-1-baolu.lu@linux.intel.com>
 <20250418080130.1844424-3-baolu.lu@linux.intel.com>
 <ygaqzsib7bc.fsf@localhost> <20251230011916.GB23056@nvidia.com>
Date: Fri, 16 Jan 2026 13:00:34 +0100
Message-ID: <yga3445n4wt.fsf@localhost>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Thu, Dec 25, 2025 at 10:05:59PM +0100, Linus Heckemann wrote:
>> It appears the code removed here was not in fact entirely dead; my 2024
>> gpd win mini ("G1617-01", with a Ryzen 8840U) fails to suspend
>> correctly, and I bisected the issue to this commit.
>
> The only behavior change this patch had that could be relavent to a
> Ryzen was in drivers/accel/amdxdna/aie2_pci.c - are you using this
> driver?
>
> Prior to this patch amdxdna would have failed to load in configs
> without an iommu as iommu_dev_enable_feature() would have
> failed. After this patch it will load successfully.
>
> If so then that driver presmuably doesn't have working power
> management in your system.

You're right, blacklisting the amdxdna driver fixes suspend, thanks for
the pointer!

@Min Ma, Lizhi Hou, dri-devel: do you have any insight into why this
might be happening?

Cheers

Linus H
