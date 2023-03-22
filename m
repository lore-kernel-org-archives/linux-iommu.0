Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D606FAA
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 13:55:02 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 89FB6242DBF;
	Wed, 22 Mar 2023 14:55:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1679493301;
	bh=1eQlaoYG4ol+rgIXVofrvo79LHCnB/WFMCikWJJn0Eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=5FqEMTFL72tm98VVUyK0rPRv7dMEwPrqnzMh3HXYKyYp8UMQbeGVCbVMHi7L6f8cq
	 wzmvW6Qg33vlc5mBxh4C06Z/kvfZKOa7Y7ChE67Sb3Hwc74Ao0Ucdij+OIo7PwsXTz
	 AwITCo3rYI7GmfMhnUSYx9m9+D6BpIwfKYxKCnPtemccwwoUF3gkszwiKnBoNe9evZ
	 +LgO0un/wQd1epGfV8jsrD2P1V5l7QOx4BIeD3+DikGQU+O6uBVuwyjmDpK4QtQP/N
	 5YWP6OdOIq9tJbHkAEv8t5+i5TQD/9f4wsD+02Xl1q5sc4e472EfhwingHJRHHUH1k
	 j/MydLsqmxkmw==
Date: Wed, 22 Mar 2023 14:55:00 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Rob Herring <robh@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Use of_property_present() for testing DT property
 presence
Message-ID: <ZBsItPDXGIWfPGNp@8bytes.org>
References: <20230310144709.1542910-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144709.1542910-1-robh@kernel.org>

On Fri, Mar 10, 2023 at 08:47:09AM -0600, Rob Herring wrote:
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 +-
>  drivers/iommu/ipmmu-vmsa.c            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
