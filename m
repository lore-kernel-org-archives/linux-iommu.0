Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A691944B
	for <iommu@lists.linux.dev>; Tue, 19 Dec 2023 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="X947UtBL"
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C560A1A41B9;
	Tue, 19 Dec 2023 14:34:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1702992847;
	bh=pKeIoOVsIxB/5QJNK0ENbaC+d1It2tEeImGDEeU/FXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X947UtBLPGIdPVN+a4LNx48qkue9hCt9o23aN5ACX9u18uXZLrhgZSY4ZA9b/YDWD
	 vaAYqkgAIT6DbfJ0V2PZi+3NkUmUO8EvhEO85BbmxshO/MFo0heBdMcI1O8BifJDJX
	 OwryiwVmqarLLw0dRxxEZxJrcBA3Fcf3Ct3EC6fvuH9B11GW+kBZPLc3t/JK+kpEge
	 12t5edszZeLzZeOzTM1jih3KRYfhleix6Ax0KQ2vxoEiVLkbsLqitKgG6I7zTfKyc/
	 mNBiJAOqs9QDP3rwNmpd5Ptfk194BoKWdLI24SEH/bE8P32Y++xzmu5Q9TzSMQ80GG
	 mvTdckTKQjKMw==
Date: Tue, 19 Dec 2023 14:34:06 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] [PULL REQUEST] Intel IOMMU updates for Linux v6.8
Message-ID: <ZYGbzt3HGfpqhjLq@8bytes.org>
References: <20231218073445.142401-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218073445.142401-1-baolu.lu@linux.intel.com>

On Mon, Dec 18, 2023 at 03:34:41PM +0800, Lu Baolu wrote:
> Lu Baolu (4):
>   iommu/vt-d: Refactor device_to_iommu() to retrieve iommu directly
>   iommu/vt-d: Remove unused parameter of
>     intel_pasid_setup_pass_through()
>   iommu/vt-d: Remove unused vcmd interfaces
>   iommu/vt-d: Move inline helpers to header files

Applied, thanks.
