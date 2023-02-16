Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB0A7B
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 09:53:15 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 23A222218D1;
	Thu, 16 Feb 2023 10:47:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1676540836;
	bh=IWLxM5BXTLinsRNlBwzac2xA7Bwuk5b/hHmu7MqqICU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=INTgNSoPf4nDOsEStHX992gp0uB5C3W7xfSFDmaVvCOh2cNxLw3rwc7bPbEPyh+mb
	 lhPn3ysXM0wfSWsBqTHUHbmUfUf5cuz51JWfsUpqGEA/o88sFYc7XuuAwEkOGbcW0/
	 UkMI95PW42fdeEJeeFFx9qGhjO4ykrv6FYxfYweXD3W3/R0J1uX/Obp/0GQcIxQxZw
	 jclsWDSczFQ5qrMz2YegDsnD4tN+gHGjPDsAQGAUxiKg+FGIDBbi3LpDZul7ij5xWY
	 awJpIIKilZxjt5pjBg3V3MLnrmQPLd2RAU5AsNFmraboCz2xswyU/wLohVyu7O6QNb
	 anAMsh3AQHmnQ==
Date: Thu, 16 Feb 2023 10:47:14 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH] iommu/amd: Do not identity map v2 capable device when
 snp is enabled
Message-ID: <Y+37or/jktnlKUsp@8bytes.org>
References: <20230207091752.7656-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207091752.7656-1-vasant.hegde@amd.com>

Hi Vasant,

On Tue, Feb 07, 2023 at 09:17:52AM +0000, Vasant Hegde wrote:
>  drivers/iommu/amd/iommu.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Applied and fixed a checkpatch warning. Please use check-patch in the
future before submitting.

Regards,

	Joerg
