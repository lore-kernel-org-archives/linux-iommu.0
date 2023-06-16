Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21081879
	for <iommu@lists.linux.dev>; Fri, 16 Jun 2023 14:35:00 +0000 (UTC)
Received: from 8bytes.org (p200300c27725a60086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7725:a600:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 58EE6226A72;
	Fri, 16 Jun 2023 16:34:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1686926099;
	bh=TvGZ4/ABg5ZygwVJmct/CzPrK3yw+aA2H3bHkJLEJ/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h29o7ImEMq7HJuEOuRnyJWZn2MHm2oVSuNC+27oxqZ65LTZRctXeZ9D1apzfHFZsJ
	 9dnpwO6eBY7UpmoqJnfj1fratWHmp9qIg9VvNO2QOCv3OX9FFLdnim7gxvGEH/vAi7
	 Sfj5MI9rKmLU+2acd65ImCsDE9qiJhXJbf/11l2Zdry7DcLL1F+Zt9AEbnIyvUb3/e
	 BZ8psqoDI9VQMXgofA7FfZlOJBbB37WnGih+9eOaRGylgtYVGSopD00Vm9g4AOO3Uw
	 59WG6vmAynPGN0pLvhP/dnroRHnRxxibGix52ViAw1Pwnd+g1NHGjK6bcCweCLdkKn
	 ajcMT9iwPAO8w==
Date: Fri, 16 Jun 2023 16:34:58 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH 1/2] iommu/amd: Use BIT/BIT_ULL macro to define bit fields
Message-ID: <ZIxzElwRFr39X_bZ@8bytes.org>
References: <20230609090631.6052-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609090631.6052-1-vasant.hegde@amd.com>

On Fri, Jun 09, 2023 at 09:06:30AM +0000, Vasant Hegde wrote:
> Make use of BIT macro when defining bitfields which makes it easy to read.
> 
> No functional change intended.
> 
> Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 76 ++++++++++++++---------------
>  1 file changed, 38 insertions(+), 38 deletions(-)

Applied both, thanks.

