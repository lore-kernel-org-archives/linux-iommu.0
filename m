Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24827B
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 09:21:32 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 16BDB20912;
	Thu, 16 Feb 2023 09:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1676539285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8/q+D2I3d++jqbi1a6RTFtbUHtbIMLzjwLyuzz6anM=;
	b=uDWWxsm/GPQvceoQ9nO/zGcCTR/EnW+w6Yl2Xmv2B/SJMJ63oVv39e5uMxPQZDBaxCAwgC
	h38oUjrPIRmK76g2ghARmaYZruuSDIqEnxQIH0sa2WPKld6F82I8ZhDfyaeP4Z15iD230t
	IdoyZWrQ3tmgti9CU4PT55PnQ+bQ3tw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1676539285;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8/q+D2I3d++jqbi1a6RTFtbUHtbIMLzjwLyuzz6anM=;
	b=wEpPmMnFDJmDIyJZ2nbv9qQqwhPs3DeQOTI4vYeAwb6/B/JgSRB4owgAO6lZWQv3dwGfGw
	rga4lp68W7OhJJBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF4BC13484;
	Thu, 16 Feb 2023 09:21:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id gRZWLZT17WMrJgAAMHmgww
	(envelope-from <jroedel@suse.de>); Thu, 16 Feb 2023 09:21:24 +0000
Date: Thu, 16 Feb 2023 10:21:23 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Bharat Bhushan <bharat.bhushan@nxp.com>,
	Eric Auger <eric.auger@redhat.com>, Olof Johansson <olof@lixom.net>,
	Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
	Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] iommu: Fix error unwind in iommu_group_alloc()
Message-ID: <Y+31kzOEk0TNhLK9@suse.de>
References: <0-v1-8f616bee028d+8b-iommu_group_alloc_leak_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-8f616bee028d+8b-iommu_group_alloc_leak_jgg@nvidia.com>

On Wed, Feb 15, 2023 at 09:21:16PM -0400, Jason Gunthorpe wrote:
> If either iommu_group_grate_file() fails then then the iommu_group
> is leaked.
> 
> Destroy it on these error paths.
> 
> Found by kselftest/iommu/iommufd_fail_nth
> 
> Fixes: bc7d12b91bd3 ("iommu: Implement reserved_regions iommu-group sysfs file")
> Fixes: c52c72d3dee8 ("iommu: Add sysfs attribyte for domain type")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Applied, thanks.
