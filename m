Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C80D42CB1E
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414744; cv=none; b=FRFCTjP5SJYBUcIywHUPUC4nLcl4KMm0EoBX0SaUoXKrfLtT6lqA5wgpNtI80PUxdrXHRiPTsMDEko+CtmVH80PqteU80QijhO/n90RGvBLUaA3di1rgxBmYhGtm+I6hU32a9tbRvkXPpiHer1tDFCnQ9cpkIPMufpAURVtkDHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414744; c=relaxed/simple;
	bh=cx99CMBtKJleTGc+M9nO5LgeXFsRNzuuxYPM/wbQR80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/NPwz5MTT0HilWYSfK+eEDFiBKGjJEQoNSrRB18myg2N0FqDsaEWLH85CQYFVzP92b5sZ7ZgAO3sfUj+mVR4orvqELio/vL3SAjH192U4r306q44duUb0pvhrdBMFcZSo3THX/+OeX9S8N8l4ErZS9FgGEoOMS7Hju62oVdUhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc50014f63e0f2a030593.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:14f6:3e0f:2a03:593])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 69212240A56;
	Thu, 30 Jul 2026 14:32:15 +0200 (CEST)
Date: Thu, 30 Jul 2026 14:32:14 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	vasant.hegde@amd.com, jon.grimm@amd.com, frank.gorishek@amd.com, 
	thomas.lendacky@amd.com, santosh.shukla@amd.com
Subject: Re: [PATCH v2 0/4] iommu/amd: IVMD handling cleanup and ivmd= boot
 override
Message-ID: <amtEIEgstKmFfFVl@8bytes.org>
References: <20260424092213.16976-1-suravee.suthikulpanit@amd.com>
 <dad0efa4-1422-4178-ad57-82a6ff91db79@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dad0efa4-1422-4178-ad57-82a6ff91db79@amd.com>

Hi Suravee,

On Mon, Jul 20, 2026 at 05:01:56PM +0700, Suthikulpanit, Suravee wrote:
> Are there any other concerns on this series?

There are some valid checkpatch warnings, can you please fix them and send a v3?

Thanks,

	Joerg
