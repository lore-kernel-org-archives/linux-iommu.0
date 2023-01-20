Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF48320FE
	for <iommu@lists.linux.dev>; Fri, 20 Jan 2023 12:33:49 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 62635262AD8;
	Fri, 20 Jan 2023 13:33:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1674218028;
	bh=csy5J+aBBw+ljg735Z0CMZzrwjNKIRCnav1RHwVR7pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SS/lHWPUxd357hY5g77/cL88CXuo5rW5HAXy01ZYFCiCspg4OQ4Zi1ghP5XUcI9V7
	 pglVypaf2zjVp/I3qzE6fGCwpVrxGK3LRkYSwol6wc1tgAVpipAgrVss9alNE2m+oi
	 D09wHKx6C18iLszIsAu/nuii6sJkG+6SsI6fo23sE/geMvgj56VOxiuHxAdrzaP8tA
	 aeZt8MyoGqSf9guVi3CN3ATvLTx+jbweSaqDCkOwrKshplVSd1vahVXJYVwO9hK/G6
	 niNYW/udaVz4r8b6q4PeJHP00NanLG2uB0rlyTOiJXceoQ2H4u2+hnLQY1+/C//Vef
	 6uOPKwvFEqnWQ==
Date: Fri, 20 Jan 2023 13:33:47 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, hch@lst.de, jgg@nvidia.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 0/8] iommu: The early demise of bus ops
Message-ID: <Y8qKK78BecPNpf+Q@8bytes.org>
References: <cover.1673978700.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673978700.git.robin.murphy@arm.com>

Hi Robin,

On Thu, Jan 19, 2023 at 07:18:18PM +0000, Robin Murphy wrote:
> This is sort of an RFC, in the sense that the patches are functionally
> ready but I don't expect that we necessarily want to merge all them
> right away; at this point it's more for the sake of visibility and
> checking if anyone strongly objects to the direction I'm taking. As such
> I've based these patches on 6.2-rc3 and made no effort to integrate them
> with the IOMMUFD-related work going on in parallel and/or already
> queued, even though there is some functional intersection and almost
> certain conflicts. If we reach a consensus that we would like any of
> this for 6.3 I'll rebase as appropriate.

Thanks for doing this, I like the direction this is taking! I see no
strict reason to wait with this, but also no strict reason to hurry it
in.

I would say we have another week for this to get ready to be merged into
6.3, which means having a version based on iommu/core with the reviews
addressed and enough relevant Reviewed-by's.

Regards,

	Joerg
