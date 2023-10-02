Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9EF383
	for <iommu@lists.linux.dev>; Mon,  2 Oct 2023 06:32:52 +0000 (UTC)
Received: from 8bytes.org (pd9fe9df8.dip0.t-ipconnect.de [217.254.157.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 48C9F1A21F6;
	Mon,  2 Oct 2023 08:32:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1696228365;
	bh=0mgBQ7iK2Tmq88snsz5A2r6dRBpW+WPmXEqqyGni29U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=firfSTz1T87Lqd//NFu38Pa1dNmZxcv2kwqRL2Z7toZsxwI+XKGVvCc9nlwePlQFe
	 KbVqOasjXph+TDQJGOaQpgxVpWxNuICPM30bhSJ54qKnmxAetEWqrkatGFwbQdrY5p
	 V6UGoAIy+7Kwe9DDNEwfKO9P/8Xr8E/FDKYQsrmlzdADBe0LH0V1lqo2J+vG8KyJia
	 nDg+FsqHMbLs4r3Ee3gxTynQSaEKRqQwwfoEvFzIIYtdaYqI7yUrRSegt6I9yqww0+
	 P1ZzEVOFufQNEEUHxHBozkHkvTDMfUig2nibvj1QhtQx9k737/UAbiYO9v0SxQ4tnP
	 7JlPIBgOkOsLg==
Date: Mon, 2 Oct 2023 08:32:44 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com, jgg@ziepe.ca
Subject: Re: [PATCH v3 0/5] iommu/amd: SVA Support (part 2) - deprecate
 iommu_v2 module
Message-ID: <ZRpkDHZrfnFIjQ6v@8bytes.org>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921093140.6162-1-vasant.hegde@amd.com>

Hi Vasant,

On Thu, Sep 21, 2023 at 09:31:35AM +0000, Vasant Hegde wrote:
> Vasant Hegde (5):
>   iommu/amd: Remove iommu_v2 module
>   iommu/amd: Remove PPR support
>   iommu/amd: Remove amd_iommu_device_info()
>   iommu/amd: Remove unused EXPORT_SYMBOLS
>   Revert "iommu: Fix false ownership failure on AMD systems with PASID activated"

Alright, since this causes no regressions for Radeon, can you please
re-send with all Acks/Review tags? I will put it into the IOMMU tree
then.

Regards,

	Joerg
