Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003BF2C029C
	for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758267835; cv=none; b=rkC0uyIeZE5jic1jh96KXGfXugGWB8iK6GwUAQmzRxZ+yG8+pwwK54UGHVDFMUuq4uHOn0ni9IegP+NRqfpASOnAs3mseogDlATpNumG3M+bBUXJr2cdFQqP45nNJ45lkZ52OsO6r9nN8iKwtTiCj91ay4obD8iiGhV7XtjZhZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758267835; c=relaxed/simple;
	bh=ngVEa08Zw4uvvJ9jozdKjd9n4UaevEyIP5eDMRphSls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acgQyv1kRhcNI/VQuXl5m+XPnBXEL1nTzp28r7hMe7rZCByhwh9ZMNuJZpaZd6YAB2uKCIP+oYLfFe5Y0hSf3M0zfBFnogiElmrDvUzhFfsaeX/EVtF02cCA0F30bgy4LRjfl4HUUxe0tfa/h0GoBrKGE0Wf++2eQELGi/0vKog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=19xU5Xdl; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="19xU5Xdl"
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9DA1B55CA1;
	Fri, 19 Sep 2025 09:43:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1758267830;
	bh=ngVEa08Zw4uvvJ9jozdKjd9n4UaevEyIP5eDMRphSls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=19xU5XdloXvcTZA6G7CCdffPIr4hP2DwWKVIiE+qKd6Pf5uU+ekMDvhE6fmTLfAUm
	 gxNdeGaR8r+55l0HqGEYgKvyF1mo12ndnPE9NE2quay3KFuW/TvKwIMsrg/xIM13r/
	 GM7wMVYbMk9s46ZEqpRtyWZvzRHdGp7JJ1VgGSoxqsvEC1Z9uumP2ZOoziwGqcENSN
	 d/JgnAbuC3uCSrkdBZVJn6gr6XkEX+zt7WUtRiJ2h6WlTfzob05KIRp+7vJk/XwwQn
	 FnNYLSOR3bABbNWcYvdOLCpxJUEGMNr0n5El3t+gL3jdvC7UBRCjrs0x3V8ZIdd2h/
	 FAgTsovYI4xDw==
Date: Fri, 19 Sep 2025 09:43:49 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] [PULL REQUEST] Intel IOMMU updates for v6.18
Message-ID: <icg3bnupnbwm5pwfgpa6dz7opphsfzyi6dvpt5sfn75ydyrjah@zyjvpruwinjl>
References: <20250918050204.359508-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918050204.359508-1-baolu.lu@linux.intel.com>

On Thu, Sep 18, 2025 at 01:01:57PM +0800, Lu Baolu wrote:
> Lu Baolu (4):
>   iommu/vt-d: Remove LPIG from page group response descriptor
>   iommu/vt-d: PRS isn't usable if PDS isn't supported
>   iommu/vt-d: Removal of Advanced Fault Logging
>   iommu/vt-d: debugfs: Avoid dumping context command register
> 
> Seyediman Seyedarab (1):
>   iommu/vt-d: Replace snprintf with scnprintf in dmar_latency_snapshot()
> 
> Vineeth Pillai (Google) (1):
>   iommu/vt-d: debugfs: Fix legacy mode page table dump logic
> 
> Yury Norov (NVIDIA) (1):
>   iommu/vt-d: Drop unused cap_super_offset()
> 
>  drivers/iommu/intel/debugfs.c | 29 +++++++++++++++++------------
>  drivers/iommu/intel/iommu.c   |  2 +-
>  drivers/iommu/intel/iommu.h   |  4 ----
>  drivers/iommu/intel/perf.c    | 10 ++++------
>  drivers/iommu/intel/perf.h    |  5 ++---
>  drivers/iommu/intel/prq.c     |  7 ++-----
>  6 files changed, 26 insertions(+), 31 deletions(-)

Applied, thanks Baolu.
