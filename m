Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657902F2A
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 16:04:45 +0000 (UTC)
Received: from 8bytes.org (p549ad69d.dip0.t-ipconnect.de [84.154.214.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 010DD2623AE;
	Fri, 13 Jan 2023 17:04:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1673625884;
	bh=/Pv+OzTRjnZG58dVl9bIa9qTfn5kGKlOr8a1LpQ/Z4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T6tevYy+A2V4j6lFshBew+Iki+rII4cuoEHdwqvkUEKhxsg184WSpufMQAKse/mFZ
	 IpWggsUujVBj87cyJi30Xa1rYkk4f5OoJV3FX1uTSmQwXZzISWxl1Fuxdz75qQInEA
	 bua3klS9XbOvgNx4h/j8rGNnPL/MxAG2fqeMNHQDtRmSsNdwZsYT6L30rHT/p9Tsx9
	 Nv6nSes9DpiF6lkLISgutTffm4Px252efxk56OGnLYf/IInE5OA/xaRN5aKZ7bUKZe
	 n2PpB24ploEsWoFLGPHTBScN+O4OhJLN4qgNBc+edNgOCwCf+LcpBt6wmfWYySKAq+
	 7jbWPbfZBi0SA==
Date: Fri, 13 Jan 2023 17:04:42 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	Matt Fagnani <matt.fagnani@bell.net>
Subject: Re: [PATCH] iommu/amd: Fix error handling for pdev_pri_ats_enable()
Message-ID: <Y8GBGll8LG+ILMts@8bytes.org>
References: <20230111121503.5931-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111121503.5931-1-vasant.hegde@amd.com>

On Wed, Jan 11, 2023 at 12:15:03PM +0000, Vasant Hegde wrote:
>  drivers/iommu/amd/iommu.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Applied, thanks.
