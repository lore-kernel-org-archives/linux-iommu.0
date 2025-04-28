Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938B71DE882
	for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839915; cv=none; b=qJyZZ8JNmiOImbB2jfsFF2gqF7GwP2wscEydt6fcQxdDDmXFBRzoRvYKO+H5mfb2YWs4zfSfLobouLxSqpINxdo7FdMegKQteosa04A2/C+NgBeiTuSPd3A9MIC+fhg3yA+IgPzBOljoZeiatakLUuMeKgf9aSBuAsbMpkumsjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839915; c=relaxed/simple;
	bh=uXXYwLargQXr5lQAggHWErF37Aj/MM0G1vi5Q8ijK8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIwjLmjcmDEzzq3y2bLSCynCbQJyfB+KLSWFz50OFAgQfztC+WtlBvrWOKILLaJQeFXjB8e6a3RF7yBSN2ERSZJAJ4U8W6G2hvF3zycenXslh5ux4dLCNPQ/qjtmGoZ3sPJI1GPCl5ntb5VcS8HRQVt5nS8vkZ4klWZVUn+IjZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=OW1Yt9T6; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="OW1Yt9T6"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 66734470B7;
	Mon, 28 Apr 2025 13:31:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1745839911;
	bh=uXXYwLargQXr5lQAggHWErF37Aj/MM0G1vi5Q8ijK8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OW1Yt9T64529Pjpm8ieP+tS4ekmOIVx6Vf1awjBx/qzyBPObejKLUL/BpmzFQL9Fw
	 Q2lM15TXauiLhRGbay9Hc3ognfPJ3+jI8dXaOLY9oJfN2lpsEMsze14k5ToxBkR+nN
	 oMen62lo3LX+25ut/QcQr6/NkLAS/ghKSRoQE9Es6Y93NeJ91BLvhDjN/75ybPpV/N
	 MDH5+2bD4IAEX0noFuO5zfNPE6CoPIoiTXbDUnhixq98wxPNhwOMgjv7imuvHgOH8S
	 A3UjCJIEUPfB2bE3fZthTDxZDY442vtFwJ1Z6o8v4LoLD4yOum5kfvf6hLPpEJyKI6
	 h3OedCUM5E2dg==
Date: Mon, 28 Apr 2025 13:31:50 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] iommu: Handle yet another race around registration
Message-ID: <aA9nJgiSHuebk4m9@8bytes.org>
References: <88d54c1b48fed8279aa47d30f3d75173685bb26a.1745516488.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88d54c1b48fed8279aa47d30f3d75173685bb26a.1745516488.git.robin.murphy@arm.com>

On Thu, Apr 24, 2025 at 06:41:28PM +0100, Robin Murphy wrote:
>  drivers/iommu/iommu.c | 26 ++++++++++++++++++--------
>  include/linux/iommu.h |  2 ++
>  2 files changed, 20 insertions(+), 8 deletions(-)

Applied, thanks.
