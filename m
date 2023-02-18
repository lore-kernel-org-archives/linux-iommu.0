Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FE27F3
	for <iommu@lists.linux.dev>; Sat, 18 Feb 2023 14:42:13 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 72C472227E2;
	Sat, 18 Feb 2023 15:42:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1676731325;
	bh=HCA55ziqxgReQhWgfeGA8FFY3pXGff+YrqY7Inxy7xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=36vu1P1ibxqBWXP+dsibngt8M3Tms5u7HUk7HBmatxG4pU0Lu5I33WS2SrUmTEqmZ
	 +EOI9RCsUONmvovKmpJ1MOEJjTmQc517l+cV8UUEPLE5fNUAOBraR+9MhKmGyQS8Gs
	 /zDdlgWXVzedF5jnZ7OeE9pQ7fb7dBgF7FkIWPrQYO1VyamLDoKnp/HGN1REUwfCTa
	 Pp8WkOe9uJhA1eC8ycJnWO7M0cymLVDRzkXOgSE6KFvbJy6SFlNgJ3hHBvRuL7hVP2
	 g7e3MdZiD0PJDTZkuW/SwRtbaKw8pd2LgyHdYyC4PSazfOmtiocCw65OSdNVFYrpbM
	 EgNaEVBwv5iZg==
Date: Sat, 18 Feb 2023 15:42:04 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, baolu.lu@linux.intel.com,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	will@kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Matt Fagnani <matt.fagnani@bell.net>
Subject: Re: [PATCH v3 1/3] iommu: Attach device group to old domain in error
 path
Message-ID: <Y/DilsJ9ItuWXhGU@8bytes.org>
References: <20230215052642.6016-1-vasant.hegde@amd.com>
 <0f6e2838-9d7f-dc2c-6e5b-0d02e239f032@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f6e2838-9d7f-dc2c-6e5b-0d02e239f032@amd.com>

On Fri, Feb 17, 2023 at 11:23:36AM +0530, Vasant Hegde wrote:
> Can you consider this patch for 6.2?

Queued to core branch for 6.2.
