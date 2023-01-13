Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9666B2F2A
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 16:02:52 +0000 (UTC)
Received: from 8bytes.org (p549ad69d.dip0.t-ipconnect.de [84.154.214.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 807A22623AE;
	Fri, 13 Jan 2023 17:02:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1673625771;
	bh=ecoTO5/Y2ozTieV/pdZvo2mFAg4tAADSVYyzSFXXNFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YjwQKECSv4bdJhAFRzfnq1DXnjZG9qlzQ8fHBAd152OGfa0X5ZfGohFjCijt2SA7H
	 Fx7fB8uQfoyLYCgCNMDlWad4sIWaRl00PTWdRmgtQSQ0JJ1CdHllz93E5v7XESiy6z
	 vo2MP5dD1mHXdqTsXmZ28l0Lveh76alZZG1WCpe70SmV6CbBllMCmfdpoDNFCncVY3
	 PCiMzgmcU8okrgwAj0zyG5rWKOeaTVHUC9VVw7OXyDSGjOR/mmcvIjSNLBHqZyaYvw
	 qDCwVZLyZOkTYl2ru9yuBVl9xVLg0REoLHqAdIdF6t0HNwPdSIMLXUmJVBD20i07xb
	 CfVtp/80zeIDQ==
Date: Fri, 13 Jan 2023 17:02:50 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH trivial] iommu/amd: Do not allocate io_pgtable_ops for
 passthrough domain
Message-ID: <Y8GAquhY3GVfOAEU@8bytes.org>
References: <20230105091728.42469-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105091728.42469-1-vasant.hegde@amd.com>

On Thu, Jan 05, 2023 at 09:17:28AM +0000, Vasant Hegde wrote:
>  drivers/iommu/amd/iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.
