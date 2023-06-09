Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC2F134C2
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 12:47:45 +0000 (UTC)
Received: from 8bytes.org (p4ff2bfbf.dip0.t-ipconnect.de [79.242.191.191])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id AD86D224B97;
	Fri,  9 Jun 2023 14:47:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1686314858;
	bh=YjGOnPYrTFPIBGBxwiHuHXw9n3uaZhsC76vfavl7xs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=clA3Vb++35ioHDrkwWIlWTS+/dcZ/UDPUgvfHMWkHZ5LStS8FfPrzRmtZROK6z3Ws
	 og88wDpTGAsZDXF3aeszN56sMi+YMGfkM/r4ZVmhmmXZDUmooGS7ZjoR24QA5Qh3AV
	 6K5OVHVjTHV5KLjz7ofumxPL4cKAunZM0a4N1umSAjYftvpJcb6/2avSHOZS89w8I/
	 C6dIT26zCErLU4tujCU2svbdbGKOI4ly3Hc7n6IWvszV71/aI/NOaYymN949NO3tmH
	 zWsSGBzbgdxRs/FFt/gaoZq4iCad2ZeHy5aqbVuhX4LaTe7MBxtIcA348cV7YJqLu4
	 FO3oILGDJoXAw==
Date: Fri, 9 Jun 2023 14:47:37 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com,
	boris.ostrovsky@oracle.com, jon.grimm@amd.com,
	santosh.shukla@amd.com, vasant.hegde@amd.com,
	kishon.vijayabraham@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 0/5] iommu/amd: AVIC Interrupt Remapping Improvements
Message-ID: <ZIMfaVIoKlL-t8Sf@8bytes.org>
References: <20230530141137.14376-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530141137.14376-1-suravee.suthikulpanit@amd.com>

On Tue, May 30, 2023 at 10:11:32AM -0400, Suravee Suthikulpanit wrote:
> Suravee Suthikulpanit (4):
>   iommu/amd: Remove the unused struct amd_ir_data.ref
>   iommu/amd: Introduce Disable IRTE Caching Support
>   iommu/amd: Do not Invalidate IRT when IRTE caching is disabled
>   iommu/amd: Improving Interrupt Remapping Table Invalidation
> 
>  .../admin-guide/kernel-parameters.txt         |  1 +
>  drivers/iommu/amd/amd_iommu_types.h           |  7 +-
>  drivers/iommu/amd/init.c                      | 38 +++++++-
>  drivers/iommu/amd/iommu.c                     | 97 ++++++++++---------
>  4 files changed, 94 insertions(+), 49 deletions(-)

Applied, thanks.
