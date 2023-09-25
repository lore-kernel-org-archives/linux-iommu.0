Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E8C320D
	for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 09:35:45 +0000 (UTC)
Received: from 8bytes.org (pd9fe9df8.dip0.t-ipconnect.de [217.254.157.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 470061A21D7;
	Mon, 25 Sep 2023 11:35:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1695634544;
	bh=JzBWhwIWRMg4Tq8QQvrZiz3bg1CZWBEKQ3ri1lmLzbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UlJzvfuoeati0DEOxo47X00IY6J5Df3D0tzZQT0xzzT4G/LWABtqc5SteZNOwrozr
	 SBjq0+fAPRaTQsAHGwNnhX4S8R0E9TzR+oowMNfkopz17rxYbjCRFaE0C3fuNIATZE
	 Cmgh6x370laUS+CtdMjeVSMbw6w72EcdVcXk63NwKVEUeV47OXSjQGabtW17hCkGJ8
	 axIayGqSbyimKVBt9bAWN3OeWrzsU9FmyrNbZjnUIwSVhm5V5CoActapMaXHwSYE9R
	 5yRVL8jGCTwC7C/UwDDzZYFxBi3s7vgFbHDVCGk5zHDaBO6sPUxdLt/XhQ0tIzb/VR
	 I4ZV7/1hssu8g==
Date: Mon, 25 Sep 2023 11:35:43 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Fixes for 6.6-rc
Message-ID: <ZRFUb6n6vusG4FRE@8bytes.org>
References: <20230922162114.GC23332@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922162114.GC23332@willie-the-truck>

On Fri, Sep 22, 2023 at 05:21:14PM +0100, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-fixes

Pulled, thanks Will.
