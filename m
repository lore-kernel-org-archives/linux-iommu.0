Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7561411C8
	for <iommu@lists.linux.dev>; Mon,  6 May 2024 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714983961; cv=none; b=nr8D5FDeJskvk4FMDlrSwPEFOddbG/UIThDwKWKSUqMyTlau037KYw5fn1hMiA1CyMooIW98HlLOyn/zNUjn0L/sy07zFqHp1j4xUTTiJzfXjJrXaRvY8iAxBuBbQyLX2V5UMHc9rv+65imQPnHUjc4dLHMGVLisiDD2bHDAh2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714983961; c=relaxed/simple;
	bh=R/777TqSQRkGXrThutmvBL44+F61/iPOqyaEwV55HIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDIgfA+sbk4hryYcSEToA6KAiMQwOHaY3oX91B8xHPxOGUDYrhnWRW/iRpOH41E4OMaa+kGrx4pQFl01EnoiBw8dlaAllqUDYu3A+iZzWCA6IZGKazmLdVINmgaudAE3UR9ETlfbs8MPCjgBgnMQIEH0uUk0NGs/v4DFS1GeqBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=u0cNBCTO; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="u0cNBCTO"
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D80DD1C0B67;
	Mon,  6 May 2024 10:25:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1714983957;
	bh=R/777TqSQRkGXrThutmvBL44+F61/iPOqyaEwV55HIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u0cNBCTOHtACDGaMwGpCz/FPzF+CEo7d++jntauPIW6LHTOK5uv4POhgJaDpEbn69
	 pSo+2+LESpSdF6RFS5ake0TIFyMiwrpMtezh6/8jDD15h6JUGK8AEHubZgJpjcFpo4
	 1GXdRh5wdHX2F5fr/VYZFgVDYokI6xbtV2/T7orEKCy5bmFRI/XZBZ+tWATfA59bQO
	 URJI/lOD+SEdC1g3XepKVSZJbB9h74+THo4sfA93c+ve5DK+xlgdi1MNWmrcyC9Cmm
	 RVyumwBa9kWumChpDA6ScOrjOGgsj+fTdf9qNX9sxrcGGTd4/jhLI7jMlMlZxJB2zK
	 00pvOLhUNouQA==
Date: Mon, 6 May 2024 10:25:56 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	Klara Modin <klarasmodin@gmail.com>
Subject: Re: [PATCH] iommu/amd: Enable Guest Translation after reading IOMMU
 feature register
Message-ID: <ZjiUFP7JF9fU88u1@8bytes.org>
References: <20240506082039.7575-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506082039.7575-1-vasant.hegde@amd.com>

On Mon, May 06, 2024 at 08:20:39AM +0000, Vasant Hegde wrote:
> Commit 8e0179733172 ("iommu/amd: Enable Guest Translation before
> registering devices") moved IOMMU Guest Translation (GT) enablement to
> early init path. It does feature check based on Global EFR value (got from
> ACPI IVRS table). Later it adjusts EFR value based on IOMMU feature
> register (late_iommu_features_init()).
> 
> It seems in some systems BIOS doesn't set gloabl EFR value properly.
> This is causing mismatch. Hence move IOMMU GT enablement after
> late_iommu_features_init() so that it does check based on IOMMU EFR
> value.
> 
> Link: https://lore.kernel.org/linux-iommu/333e6eb6-361c-4afb-8107-2573324bf689@gmail.com/
> Fixes: 8e0179733172 ("iommu/amd: Enable Guest Translation before registering devices")
> Reported-by: Klara Modin <klarasmodin@gmail.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Tested-by: Klara Modin <klarasmodin@gmail.com>
> ---
>  drivers/iommu/amd/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Wow, that was quick. Applied now, thanks!

