Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA4614C5B0
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 08:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981930; cv=none; b=haek45+xs7Z1hETnghix/txogGZKwD7FWGK6uWKkzR5r+4VBfN353ulU2g3rcY8HrJHb5QD7AlV8aAN7Gu2MJc7LPXC8kbzFkMhpg8ZG9jUhlPptlRdNsqI2d7DTuZM7KpZQVyRFwX8M2ARUasO2Ic/KihWEzZ+81FacY+/kPJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981930; c=relaxed/simple;
	bh=D+BR6qKnUIt1PewnClQsaTKBLChvNYz7nqoVWNT9rI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTNlVaas5VhV2ahu1qRlxI6mkDucxa/Vskiute4PDFwKmMeFAPh1Wxjxm2wyNxQn1nM89wIh/SVmWhr4/NKfanQe0zG0tm5KXualJn2EAfttgMe9xFYm+vQqzjo2LLEWXLnByDfv6JakUwTJku/a3e9fRFY6Qsj4KhCW+wpEuQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=V4Fg/7S7; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="V4Fg/7S7"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DB0852A01B8;
	Tue, 15 Oct 2024 10:45:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1728981927;
	bh=D+BR6qKnUIt1PewnClQsaTKBLChvNYz7nqoVWNT9rI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4Fg/7S75u13xbFUWueOtUAII5UeW+2GhqOn05VAx5KSrYv4O2ZvQ9AyqLWcePjRf
	 VzNveEFZ7KxcvLZmBoUjcDivO0QMP6K3Y9vU9slm+KR2L7WcM9pUMvhqL7ci63ZxsY
	 IA9CkAAzA06aET77ZrsaWedTTFah+DZ5zANzOESubXHEJQp8TUvkzEGbHhAG8o5zIj
	 cfg/8Jb+L+Hk7YEj4CdaUl0xAr+Wdrmsc4NGglNogQd70HDey5c8KApc0zL+4/qeKu
	 t4b3wJl7wNC8Y0PY6EcFzAwNjU/7KjTFGgb+zrvJ8ejfJh7C1yYNPo1P8j2bCSDpPU
	 JSe7VB3mcqAog==
Date: Tue, 15 Oct 2024 10:45:26 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v2 10/10] iommu/amd: Improve amd_iommu_release_device()
Message-ID: <Zw4rptARDg1Ptqkc@8bytes.org>
References: <20240910065812.6091-1-vasant.hegde@amd.com>
 <20240910065812.6091-11-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910065812.6091-11-vasant.hegde@amd.com>

On Tue, Sep 10, 2024 at 06:58:12AM +0000, Vasant Hegde wrote:
> No need to have separate amd_iommu_uninit_device() just to check
> dev_data and call detach domain. Hence move these checks to
> amd_iommu_release_device() itself.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 32 +++++++++++++-------------------
>  1 file changed, 13 insertions(+), 19 deletions(-)

Reviewed-by: Joerg Roedel <jroedel@suse.de>
