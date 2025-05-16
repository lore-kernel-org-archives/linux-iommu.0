Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D271361
	for <iommu@lists.linux.dev>; Fri, 16 May 2025 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747378128; cv=none; b=hwIn9umgyJB6WzV1h6AE+ocE1R2rxKKStVpNWDxxLaQMRFvt4+SIHJ3tJUQL3Na2sXv92+I5AdvnxbnHsFdDw77UcNZ4fgqRcKaL3dq9cZ6/o+kPOD0g6fl6IlQAjCXIvdMobeIc0tHyLfsxzrYuRNcPrc6ZCkuR5grhMMrrDHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747378128; c=relaxed/simple;
	bh=SO8A0OpVPjVPuSkE8b4uXXALn9apsujGifLuxQX4T3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYURmwFkObcp9f7EN27o7YTtNpRNJClylRul7W33gdpcw9+vju/cxUZaWkcryiFXqiz8VcnRPBxTczNFEPArjsrog75jg/ugLv1wKEttz2ri33jsYerZr69wOyJdtmx6YwWSO55EReAUqlUaEc4MEaG5bSr6MjT71ae3459dzWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=waQVIW2Q; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="waQVIW2Q"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 287F44B65F;
	Fri, 16 May 2025 08:48:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1747378124;
	bh=SO8A0OpVPjVPuSkE8b4uXXALn9apsujGifLuxQX4T3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=waQVIW2QdDd+3A0ai60OoOhUI68m8+c+MrF0IFqHJX9Txh2rYX+FuOcxxf5PSXBiI
	 EkG4Og5kCUQLDEN3gIEWtRLrEJJweLh5K2pw/bwvtVRNB3jlrfM6wznii9itrvtjkP
	 wI/aJjFbIDnCMedyCKJry3xZ1SYDd5CUCKCz8VtZ3uOPFl9IS8rDsaxEb1/cfiDLJD
	 l1YOqYtmNIAExinIXzr9nPAe2myod2ZnjdaxRW7H9RRPatn2K49/wn1VcOccoJK3RL
	 oI1Nak3fVc0COPVbCADpbLUu0BR2n9fj73t5GxoheRTXtjDBWpWWp0K6LxBaFOyLmc
	 ubAysFbgv84hQ==
Date: Fri, 16 May 2025 08:48:43 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, will@kernel.org,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <Vasant.Hegde@amd.com>,
	Paul Blinzer <Paul.Blinzer@amd.com>, iommu@lists.linux.dev
Subject: Re: [PATCH v3] iommu/amd: Allow matching ACPI HID devices without
 matching UIDs
Message-ID: <aCbfy9c5kFa1pPsy@8bytes.org>
References: <20250512173129.1274275-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512173129.1274275-1-superm1@kernel.org>

On Mon, May 12, 2025 at 12:30:32PM -0500, Mario Limonciello wrote:
>  drivers/iommu/amd/iommu.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)

Applied, thanks.
