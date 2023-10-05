Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF34125DB
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z5u0HT7p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HkgOmrpB"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 33A6D2184B;
	Thu,  5 Oct 2023 11:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1696503609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVckpoAkU0LArSg46tupASASn0hOJ1u6rqRfo8SDMGk=;
	b=z5u0HT7p2ULosTD4YFpvA3iSJdaCjRYD9CaDyAMxvEO7IpdOGh90CvzFtUAw0c0QnChnLy
	R0Pqo3SoH815bcg/Tma8BEyBNeWQ7LCQ+HfKPMdpIYdn3w+fKFWDGszAuBb7aeU9G0vZah
	NyCszQ5J8IasqdlXXDc7RAu0/uDmWmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1696503609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVckpoAkU0LArSg46tupASASn0hOJ1u6rqRfo8SDMGk=;
	b=HkgOmrpBrq9SNOUwUONDvxrbEDT1H/kPgg7JzaHjipaiLWbnyKk5BvVVp8oHlN4YO6u1Bn
	stt5mtUQTn0LAbCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CCF5B13438;
	Thu,  5 Oct 2023 11:00:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id BCPKMDiXHmUcNgAAMHmgww
	(envelope-from <jroedel@suse.de>); Thu, 05 Oct 2023 11:00:08 +0000
Date: Thu, 5 Oct 2023 13:00:07 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] iommu: Do not use IOMMU_DOMAIN_DMA if CONFIG_IOMMU_DMA
 is not enabled
Message-ID: <ZR6XN4PJ4C6VU9Xq@suse.de>
References: <0-v1-20700abdf239+19c-iommu_no_dma_iommu_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0-v1-20700abdf239+19c-iommu_no_dma_iommu_jgg@nvidia.com>

On Tue, Oct 03, 2023 at 01:52:36PM -0300, Jason Gunthorpe wrote:
>  drivers/iommu/iommu.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Applied, thanks.

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Frankenstraße 146
90461 Nürnberg
Germany

(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman

