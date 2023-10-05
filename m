Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EAE125CE
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 11:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bl4j8oQc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cyjw7al1"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1055A215EE;
	Thu,  5 Oct 2023 11:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1696503860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6bLqGHNzgwz3FZhi9GSwSOazD0CyVn+8ftlvjFvvlQ=;
	b=Bl4j8oQcCcytRxGH0W3brCqw4t+UVOfyx23bb8kBHeAYfMOq2UoCeE37bDNUyJW2MxD/l0
	XAZpFwjqyrR0RAzNRgaTuWXSsU94ojDy9UsZWiNNrobaWef46FUO5VnyOLg/UZmDSMH+C3
	ceXZO3NNeZh8YFHvTdVzYmAyH9xOkOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1696503860;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6bLqGHNzgwz3FZhi9GSwSOazD0CyVn+8ftlvjFvvlQ=;
	b=cyjw7al1s+aOWPeJvj75ADQtP5xOQr78pFxrHy75WqnpYT3FlTtyTcXPIke6fNhYRIoxvl
	ovkq597LNIQPsoDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB2CB13438;
	Thu,  5 Oct 2023 11:04:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id kHBZLDOYHmWLOAAAMHmgww
	(envelope-from <jroedel@suse.de>); Thu, 05 Oct 2023 11:04:19 +0000
Date: Thu, 5 Oct 2023 13:04:18 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH v2] iommu: Fix return code in
 iommu_group_alloc_default_domain()
Message-ID: <ZR6YMmBQmLWZgBNW@suse.de>
References: <0-v2-ee2bae9af0f2+96-iommu_ga_err_ptr_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0-v2-ee2bae9af0f2+96-iommu_ga_err_ptr_jgg@nvidia.com>

On Wed, Oct 04, 2023 at 09:08:32AM -0300, Jason Gunthorpe wrote:
>  drivers/iommu/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

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

