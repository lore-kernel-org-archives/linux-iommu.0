Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04A61427D
	for <iommu@lists.linux.dev>; Mon, 22 May 2023 15:34:07 +0000 (UTC)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 97E16248089;
	Mon, 22 May 2023 17:34:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1684769646;
	bh=CqRGYxF+fh6efzNEL/NQp4ZF01hULy05sXQWA1uYbuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4SKTEpzMhWMUBZyMqfU/SBvMLjZrnslN1/V0M4Y75M5M1gNW2Z+hVL3HdRDPsiqJ
	 dghw7c728o3g7FEaPbvZEFn2AooZlhAMnWG2xSPgTruLwImjBl8QwYKQuubStn/I5u
	 LDoaEiRNdPh8ehja84Il1QkYZUz26D5A6m+vacC5IK4H5p4Zqdjd4OI+GckaYmekMU
	 95Yzgs1Lw2nLl4qBkkgtTInl3jbG44PpP8YdAeOqc3oUCHzCyhFK0ABtO0LhyPY+Tc
	 C3yv8PW+g1xXX8D25ogOX0TIvcEHDPxlQ3r0Hxj2H8GXZMuZdOePSf3OBCzcpoGw9O
	 FMjtgGBDCDwWw==
Date: Mon, 22 May 2023 17:34:05 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jon Pan-Doh <pandoh@google.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Nadav Amit <namit@vmware.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sudheer Dantuluri <dantuluris@google.com>,
	Gary Zibrat <gzibrat@google.com>
Subject: Re: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
Message-ID: <ZGuLbTdF0WAwhMB3@8bytes.org>
References: <20230426203256.237116-1-pandoh@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426203256.237116-1-pandoh@google.com>

On Wed, Apr 26, 2023 at 01:32:56PM -0700, Jon Pan-Doh wrote:
>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied for 6.4, thanks.
