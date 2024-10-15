Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DBC17335E
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981609; cv=none; b=Wik2MJVl4oqnrRZFUVqtDBFhxs7sH9b4/uE3R5HMuTQxkHBv4Zur0NIppy66NM/b+a/+xK0ULmlmylvp5evOS48PstQSVaSR8+cgCU8+jNvj9jZ7+L1YKzp8E/axSrTUEa/8lwoJQGqt8lru6flWRlGZzuMKElQ9kzimm3DmYPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981609; c=relaxed/simple;
	bh=orDkVn6Ioo6s2I6/8GUG6/9pGjgR/KWn3RBo3gGSjhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAToG03e7V5Ka4OiaCOgGMCmjELJPOSh+vFOYEga5WUfyqr0e6+PRY+g+XpTbCgbUa4lV3irWjCoJI74D2FTkYV71ObNv7ydGO81pNRcgoaN85PF/+S4BLzXtyH8O+wsXAcPOjQtUKXmRCMU0cP1Ww4bVW+xQdp442awg62I1B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=mLTwhNty; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="mLTwhNty"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 233042A6C15;
	Tue, 15 Oct 2024 10:40:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1728981607;
	bh=orDkVn6Ioo6s2I6/8GUG6/9pGjgR/KWn3RBo3gGSjhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mLTwhNty0io+sStntGBbb8VaybVuYspLQd1Gm8vc/Qk4ciIsMb4SvXu9i5nC94Knv
	 0aCXRsu1xfsxd1OQwcG2livkQTnbJeDQwedKoNB2rhmyXmlGrLqPFDK6hwpHkWksB7
	 8X/x05gqnyshj0PABuvMqA2RxLrQeZnU7NjL8IJpCdP/PhDsEkCEGPlGvhWsu0LGtX
	 Dk+3Sc8Uj+eqaiJ64dodBMNkS0yImLSnszVEfZHm4/3v9tHY/jb8M46IPv47eBOwDf
	 lDxgyHx+haVaKitbEMWFKVwkI3iQ5d3FpZyqcVtqY3cEvswGypEUsStWLzk/4SiWF/
	 bAKAcpEJfOcXQ==
Date: Tue, 15 Oct 2024 10:40:06 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v2 05/10] iommu/amd: Do not detach devices in domain free
 path
Message-ID: <Zw4qZlM-nCor59Mm@8bytes.org>
References: <20240910065812.6091-1-vasant.hegde@amd.com>
 <20240910065812.6091-6-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910065812.6091-6-vasant.hegde@amd.com>

On Tue, Sep 10, 2024 at 06:58:07AM +0000, Vasant Hegde wrote:
> All devices attached to a protection domain must be freed before
> calling domain free. Hence do not try to free devices in domain
> free path. Continue to throw warning if pdom->dev_list is not empty
> so that any potential issues can be fixed.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 26 +-------------------------
>  1 file changed, 1 insertion(+), 25 deletions(-)
 
Reviewed-by: Joerg Roedel <jroedel@suse.de>
