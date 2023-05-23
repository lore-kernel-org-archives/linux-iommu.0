Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979341D2B1
	for <iommu@lists.linux.dev>; Tue, 23 May 2023 06:31:04 +0000 (UTC)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4F0242480E1;
	Tue, 23 May 2023 08:31:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1684823463;
	bh=eHzQvI5QUqoz/Lj0lFCmplzcxBOdggkDnxBKLyCSgZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ht1I1ooxYWysJaxa7r+omLTUJfWAbnxloIVNPRdVoQcXQoR4Qs6RqQsXACfv/Leys
	 IAGnIxD1vYjEXYzVXA/Au2GRfQkA+aOd4aOXo9LXjtH0lZNDstpSWw9aQ6X+eK2sAA
	 9Qu+OXm1VbuD0OtEqgpt0zBuZFk0f3fUivh/8K+M6VIH4S/9Wvz7w6V1oyogAoDPfF
	 dXAnwcbXJCSepegU16GkWsKZsVtI90RO9A1n7R4W/EgEQXTfGB0M+LdURRGWkMetoh
	 yZCoXy9JidJKE6gpwrZ79Pu28Ceieq749gRa5qIw/JuU62tjYCHk1/5JRIwEWLDW8P
	 pMPgccG9T4f9Q==
Date: Tue, 23 May 2023 08:31:02 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	Jerry Snitselaar <jsnitsel@redhat.com>, Stable@vger.kernel.org
Subject: Re: [PATCH] iommu/amd/pgtbl_v2: Fix domain max address
Message-ID: <ZGxdpiW47H3vAoL4@8bytes.org>
References: <20230518054351.9626-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518054351.9626-1-vasant.hegde@amd.com>

On Thu, May 18, 2023 at 05:43:51AM +0000, Vasant Hegde wrote:
> IOMMU v2 page table supports 4 level (47 bit) or 5 level (56 bit) virtual
> address space. Current code assumes it can support 64bit IOVA address
> space. If IOVA allocator allocates virtual address > 47/56 bit (depending
> on page table level) then it will do wrong mapping and cause invalid
> translation.
> 
> Hence adjust aperture size to use max address supported by the page table.
> 
> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Fixes: aaac38f61487 ("iommu/amd: Initial support for AMD IOMMU v2 page table")
> Cc: <Stable@vger.kernel.org>  # v6.0+
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Applied for 6.4, thanks Vasant.
