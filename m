Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F41C1CC16F
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981705; cv=none; b=XZBfWiPGyXcPFG47NXHVB2alIj4aR7uTyNfs6EKKcbdCnHsQDzmhWjf+ffLejg466OnygGVDpXfpVgYis4UFQpwi1geR51QV3t53Us+AUiIoTtJu8MAj1EvBz8Bj7CRK7D3agMK8/rgTo5/pNokntm7vAEZGRi30UA7prfycK3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981705; c=relaxed/simple;
	bh=A4hA9TqnlJFeiNzorYDdwXmAmVxiSeSF/fxvEZ+bo6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6AFXbAJJKG6WW6Y2qVemNkN8zRJozGwCURpBqHUsS08UuCPBYsg5eV9Jv34cRLweUlZ71R4Di/UeAoTNXQS6i83J7aWAupsCUPQ03sTjZLNC8FnhC5rqmhj8L5id8uU/VaDrCAqeadLk8RxW4OjYNEyNe3y8hKWY2Gx4dbJWHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=7qWINRtx; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="7qWINRtx"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7CC472A6C15;
	Tue, 15 Oct 2024 10:41:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1728981702;
	bh=A4hA9TqnlJFeiNzorYDdwXmAmVxiSeSF/fxvEZ+bo6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=7qWINRtx3QHRRPI39vJTFTpoF+kqtFWQHpe2g1sbBZsRqjQ5yop2kJEV9xPWmdQ6H
	 HWifWjyUY2DcasN53SG/EaRrEZV5U4jnO8CMuii6OcRDsSN8Qjv4RkRrA5W26vebZk
	 mepItwXUEt3gKSpthPsMUe+9u+GnpkPNfwlCXABQSw5Ixy4K/+wxBkyoAuAZkQr2e5
	 EuXbjs530zubRBP+lcvHkTGdFRIOdcez6lCERhxn3uvNOtQYEBH0q+gU0QTeE21lz4
	 DWqBG8p+ex8Ituy8sxfYQIVscp8KLXOmTBo8S9uIRoFzCThE67N4p1199SaE6e/noA
	 IbewFkvlQmNoQ==
Date: Tue, 15 Oct 2024 10:41:41 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v2 07/10] iommu/amd: Rearrange attach device code
Message-ID: <Zw4qxfP7ppcysSzm@8bytes.org>
References: <20240910065812.6091-1-vasant.hegde@amd.com>
 <20240910065812.6091-8-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910065812.6091-8-vasant.hegde@amd.com>

On Tue, Sep 10, 2024 at 06:58:09AM +0000, Vasant Hegde wrote:
> attach_device() is just holding lock and calling do_attach(). There is
> not need to have another function. Just move do_attach() code to
> attach_device(). Similary move do_detach() code to detach_device().
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 85 +++++++++++++++------------------------
>  1 file changed, 33 insertions(+), 52 deletions(-)

Reviewed-by: Joerg Roedel <jroedel@suse.de>
