Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C5115853A
	for <iommu@lists.linux.dev>; Mon,  6 Jan 2025 11:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736163761; cv=none; b=bfBC8NwxpYNEOeaRDyKlTjSQoi7b+DvGrehoODWNT7XnulVT2ihOcHAyzSytdAM5JjtOxv4ku33Sgk3SQizP4ZVLiFAMSpViDCzAiq7l3ZiQix54HFGYb6B5rbNryJcCrlSlnch0U7kJ4HG6OiqaTuFhLz2SH9xWOaQRIm0nEj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736163761; c=relaxed/simple;
	bh=IIp3GSDpNKHJV//amYxYQ7fB2aU2J5KkVirIi/Y9QTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HidTEj0de64rVHTAh9q+P3o3HXjY/sLLFzVzryKqPBIbxDFW2e2RjylN9kTzQeBJ/R1jaJ/OTYpJ//KFl9cw88dQC9yNRjAA1kbTd2aS3460Vb7BvsKMiLjD47rxERkeFiZiXFXvKOqG0WorFYfQshjzhyMUMvg47TKNlawy9xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=lk/5hgD9; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="lk/5hgD9"
Received: from 8bytes.org (p200300f6af348600d06e0009f19b6c7e.dip0.t-ipconnect.de [IPv6:2003:f6:af34:8600:d06e:9:f19b:6c7e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 52A752E0016;
	Mon,  6 Jan 2025 12:42:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1736163758;
	bh=IIp3GSDpNKHJV//amYxYQ7fB2aU2J5KkVirIi/Y9QTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lk/5hgD9a0e6k8r1VBOexWLyqG0a6du/oJPDy24bXKfEQqa7/fFiBlSRwntT053Pe
	 B5IGIK2nZkMIGMAwlLK1v+/D+IgBJIG9qYyfqGhYsqcEDZVD5xV4J1sNE4R5U0MFKv
	 e9xkY9S928hWTz9eshJqvuOC/7nkYNTADpGJM6618Qkq90JF17Vq1shw94lRTi87Nf
	 DwOwcDSJOLCShh1dN7syjMYLV+XXyI/OssVkHUMgRxlsOL/TJKv2qxVR7zVrqdc3ZQ
	 JCqd2r/xiUW0WaZah6NF/8OsI6b8zfk+adiTts5BwEAUFLEz86sjJxsh4BO7fHBggE
	 icfUkkmu9aHtA==
Date: Mon, 6 Jan 2025 12:42:37 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Gao Shiyuan <gaoshiyuan@baidu.com>
Cc: suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
	christophe.jaillet@wanadoo.fr, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/amd: remove return value of amd_iommu_detect
Message-ID: <Z3vBrbu4b15zIBPN@8bytes.org>
References: <20250103165808.80939-1-gaoshiyuan@baidu.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103165808.80939-1-gaoshiyuan@baidu.com>

On Sat, Jan 04, 2025 at 12:58:08AM +0800, Gao Shiyuan wrote:
> The return value of amd_iommu_detect is not used, so remove it and
> is consistent with other iommu detect functions.
> 
> Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> ---
>  drivers/iommu/amd/init.c  | 10 ++++------
>  include/linux/amd-iommu.h |  4 ++--
>  2 files changed, 6 insertions(+), 8 deletions(-)

Applied, thanks.
