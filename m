Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1862914F7C
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="BbcsUWWd"
Received: from 8bytes.org (p4ffe149c.dip0.t-ipconnect.de [79.254.20.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 328211A45BC;
	Mon, 16 Oct 2023 09:36:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1697441761;
	bh=nt+xCM+bbOr7Tl+Bpnd6YqrLyUak9Maws/2C4cwPfME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BbcsUWWdDSGJZOarRKA+DdgcrK7nsBYntbXu+2v9JvIca04ORkqddyNVHHvQL9c2c
	 VyuUAa6MoKYjL5ye6GpXPfi+dQHSg67kU0r30Sw01LaXt0CMvJ2RYteMfQQziyqmza
	 eHiRuu2snYzzjPSFMzUo+mQ5OMG0SuuIPT0HEnMGKgBP2KPNBTU26svreDEgP6sybs
	 tEcWYvpw5MPloCAcGmHwlzAJb7d+VlGVjcbne0lWPR0SHgYH+GSq37JL/tJ+tPXRPD
	 Q9EDnY3zukteFkPPW01LBut2lX7NTuocDSMVgyx+URMpCoTq91YicfKqTo/g4jfZW6
	 na9RKMqyYh3yg==
Date: Mon, 16 Oct 2023 09:36:00 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jingqi Liu <Jingqi.liu@intel.com>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] [PULL REQUEST] Intel IOMMU updates for Linux v6.7
Message-ID: <ZSzn4P4EcvZu0FBR@8bytes.org>
References: <20231016032830.101321-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016032830.101321-1-baolu.lu@linux.intel.com>

On Mon, Oct 16, 2023 at 11:28:26AM +0800, Lu Baolu wrote:
> Jiapeng Chong (1):
>   iommu/vt-d: Remove unused function
> 
> Jingqi Liu (3):
>   iommu/vt-d: debugfs: Dump entry pointing to huge page
>   iommu/vt-d: debugfs: Create/remove debugfs file per {device, pasid}
>   iommu/vt-d: debugfs: Support dumping a specified page table

Applied, thanks Baolu.

