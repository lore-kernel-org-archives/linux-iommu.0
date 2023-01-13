Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E752115
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 19:25:19 +0000 (UTC)
Received: from 8bytes.org (p549ad69d.dip0.t-ipconnect.de [84.154.214.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9957C262301;
	Fri, 13 Jan 2023 20:25:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1673637918;
	bh=OOMwhlODJraoUTMYaJtXY8wPuDUiRiD49d+hBmL2wjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZJCr/fRYyf+jHpqB+cpID9ZYQgUC3rzMABlX9suE9O8yxv25lppyz98P9O1NmZr0c
	 IvflLusRjnS9oKmBK9TtZ6qc86lfAPI/eNrbLcsXxJWufsq7MnbXnFcbASsnAN3vX5
	 rpQ5Jum+pOnO10JmcllvIu23XHuOjhf6nlBmLDv8NeFc6yj7S5skTU8N05xXSH41dN
	 Lbxs9ytSCq1hGJXSq9GedIofZCw0jINwvWnhhaNWKUzfLCr6K/kx6M2jc5OvHh4Hwp
	 P+ZYK+0ZQLpXXvVBZrtGPjZ1sn2msA7JtMkO8q6W/MSAJRil9dVoetgjxrT4YsxbDu
	 sekbdeTkcQyFg==
Date: Fri, 13 Jan 2023 20:25:17 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Sven Peter <sven@svenpeter.dev>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Remove ipmmu_utlb_disable()
Message-ID: <Y8GwHQLKnXyqa3Ty@8bytes.org>
References: <20230113185640.8050-1-joro@8bytes.org>
 <Y8GtFcNq2jugBpI3@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8GtFcNq2jugBpI3@ziepe.ca>

On Fri, Jan 13, 2023 at 03:12:21PM -0400, Jason Gunthorpe wrote:
> I'm surprised the 0-day bot didn't notice?

Well, I think 0-day does not spend that much time on iommu patch-sets,
especially doing randconfigs or allyes/modconfigs.

In general it is a good idea to at least compile-test every file that is
changed in a patch-set before sending it out and not rely on 0-day bot
for that.

Regards,

	Joerg
