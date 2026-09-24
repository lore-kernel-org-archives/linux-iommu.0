Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D90366055
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248922; cv=none; b=sSO/xUpHsSuexJ/BcaqDEXBJI46Y0dNVIzIQJOKqI+RUcS6HRsJA77E/gNx4riTIygOdj6mCONTip+ECl3s9tOSI4PNNbaZpZLcFXQL3uv+ClZTRKEXxTjh8a4u55ZTQrqwCXDj0+0dMBtndjk62NiNfw1QvwC20vOSJYeylN54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248922; c=relaxed/simple;
	bh=4CsvsoUNXcas1CN5rdn1b4OuRZBIHjBhJ5TmPdEi3E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5IwTeraQQfP0QFuM7bO/cuUTDqm8Fw6rFfAdh681Q2LIouQfkQsdgYtQJbG2LEV/WL0+uMR3uf5ODoYMx7d80x3jbcA1DeW8sKW7w4mDP3L7fqLiVIUGhCd5qCijqlzcs8VXzwyJaOlZQpdAGLqTFzQkvew0vmTIusIT9qems8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00e4ccc4fdbbd66590.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:e4cc:c4fd:bbd6:6590])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 245AC1C7465;
	Thu, 24 Sep 2026 13:22:00 +0200 (CEST)
Date: Thu, 24 Sep 2026 13:21:58 +0200
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Rong Zhang <i@rong.moe>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Huang Rui <ray.huang@amd.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Sairaj Kodilkar <sarunkod@amd.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] iommu/amd: Do not request ACS when IOMMU is not
 going to be initialized
Message-ID: <arUHxhPeIo0HJWEp@8bytes.org>
References: <20260823-amd-iommu-fix-acs-v3-0-dd768e09d771@rong.moe>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823-amd-iommu-fix-acs-v3-0-dd768e09d771@rong.moe>

On Sun, Aug 23, 2026 at 06:20:14AM +0800, Rong Zhang wrote:
> Rong Zhang (3):
>       iommu/amd: Do not request ACS when IOMMU is not going to be initialized
>       iommu/amd: Disallow implicit START_STATE => IVRS_DETECTED transition
>       iommu/amd: Remove ad-hoc checks that are never true

Applied, thanks.
