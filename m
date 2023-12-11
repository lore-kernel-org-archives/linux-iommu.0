Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA4048790
	for <iommu@lists.linux.dev>; Mon, 11 Dec 2023 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="h8+L31Ti"
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E50E01A3EBC;
	Mon, 11 Dec 2023 15:22:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1702304522;
	bh=IkGeRoV4YK3/w+vDOMHedoYysVVERefkq3baaHIOGpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8+L31TinSHv4eBKtTIQ/Kw0WZsDpYPHepdvhPSwXg6wvf2lZh0YgGlFfHKGaYILy
	 XoyqTIFugqoVLunbKHHksRxpTmrCFT+h0BNTpAcobKiv0Q5puXpE5u6g0L5iXYC0V4
	 RwtWbP9TwupnUv/S2YfUfK0Eh9Txp79POYJyyc4QhdRBBBW29QEe8S1wzhz1glAB+y
	 A7hsxzmaVGbNWs7TnJvFiU6ZFQisoJUbPKBAjz8wcoXkqKwCagxikQZrez6NQTJe31
	 HopSIh/qrIv2FLzQRt3podYDoRbi7r+MenhTD/3UeaWIB7lW+QBPGyoKc1dCG8HQjF
	 Kx51tG08UXUCA==
Date: Mon, 11 Dec 2023 15:22:00 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	mlevitsk@redhat.com, seanjc@google.com, vasant.hegde@amd.com,
	jon.grimm@amd.com, santosh.shukla@amd.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH] iommu/amd: Do not flush IRTE when only updating isRun
 and destination fields
Message-ID: <ZXcbCLKJbM7Udpcy@8bytes.org>
References: <20231017144236.8287-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017144236.8287-1-suravee.suthikulpanit@amd.com>

On Tue, Oct 17, 2023 at 09:42:36AM -0500, Suravee Suthikulpanit wrote:
>  drivers/iommu/amd/iommu.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)

Applied, thanks.

