Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16271FC0EA
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779953460; cv=none; b=cqGNXhnlUAMB6u5S01oKNDoq5PFeAUjl8crvZbxK5hU2qOaOdNtSb32y/0XLaposHVSLu5hRIVAEJ9QvsT0pToPXXoIwwcMmlF0XgXylMWjUFrMm0yGaBAEskzvr8VLvEhA8AiwrEwKAWvdRxcr5Kva0+zjYIQajmnsm31S5cXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779953460; c=relaxed/simple;
	bh=wzbzU0m+jgpeahwNhnCrVR9dF9CLCogNtR6aO034mgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWPsQb3vTmvCmKXckmss2Mjb0vjelSpdFU1kaMWLli0wK1UQVYCGqT+VyzCYzbLtmreQGnTHMFAza18vtZuXCEkfH0cOHYgE7K3J2Hmlb7YjU33d0TlWhmHINIPgXQ35TohQg2nEEaAGza78ZVTG46r/WvJjJMA3/U24ESUxaBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc5001a5b4667a2accba1.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:1a5b:4667:a2ac:cba1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id EFC661C5BA7;
	Thu, 28 May 2026 09:30:57 +0200 (CEST)
Date: Thu, 28 May 2026 09:30:56 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Dan Carpenter <error27@gmail.com>
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu/vsi: Use list_for_each_entry()
Message-ID: <ahfvITtPxTmJoS1n@8bytes.org>
References: <ag1N99H-xnmSh-hc@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag1N99H-xnmSh-hc@stanley.mountain>

On Wed, May 20, 2026 at 09:00:23AM +0300, Dan Carpenter wrote:
>  drivers/iommu/vsi-iommu.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Applied, thanks.
