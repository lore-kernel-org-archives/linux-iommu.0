Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8F81386B4
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 06:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506218; cv=none; b=ffCdv9s3P+ZIRiLHEE0EZ7YZG2UoQk0rKtuj3yNGjEMNyhBkqqYwsbnvBzDgqEKb4WPB9/mu9ZZ532F6NhnuxjL9ZJJNlAA1JHrI7aYswVsUUAAOP65HhKM3CJe81/YmwRq3BYsn+y7IcZv6daBoBETdZ2FuV4OIDHdDmWAicsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506218; c=relaxed/simple;
	bh=A72kLY51Bpg+5otSirYm6AN3gn+A7uMf3c/GkxF0rUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRRdb+ZDyPVt6O9m+no6li4QSVvSRVcQ02jlbx2bxIdgM4co6NQOJR48EyaS1wA3vvdDS/e8kYBCiK7Nqe9zGu6dBrfJKWtOXrdWgwUa8FjOCILzZXnOJU62uNPmjVVMMnFWSBCLsQ55R+CRpYQwiFk2vxJu2VWFFNxgykOxh/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7525968AFE; Tue,  9 Jul 2024 08:23:33 +0200 (CEST)
Date: Tue, 9 Jul 2024 08:23:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yicong Yang <yangyicong@huawei.com>
Cc: chenxiang66@hisilicon.com, hch@lst.de, iommu@lists.linux.dev,
	baohua@kernel.org, jonathan.cameron@huawei.com,
	prime.zeng@huawei.com, linuxarm@huawei.com,
	yangyicong@hisilicon.com
Subject: Re: [PATCH v2] dma-mapping: benchmark: Don't starve others when
 doing the test
Message-ID: <20240709062333.GA16797@lst.de>
References: <20240620092855.54581-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620092855.54581-1-yangyicong@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to the dma-mapping tree for 6.11.

