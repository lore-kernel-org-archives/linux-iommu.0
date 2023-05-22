Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CDD14AAA
	for <iommu@lists.linux.dev>; Mon, 22 May 2023 15:30:49 +0000 (UTC)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 613D92434D7;
	Mon, 22 May 2023 17:30:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1684769448;
	bh=dORlFlQ9YG74GTi6oTCpk9eiByEQ4lPpF1W0CTe2AUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ra7qzltUFox0kJbkF3OIyb5A3m+tS0n0a3NyC9725qDPnxlxkpgalmGwhI4tLFK9v
	 I8ADUbn82I12/L4tm7L2GCM/apv5LBMzT277rO1Qze9xczmzRk7vodSXX//9SpXK8B
	 DHWEbn9B7C95vepZxM9VqZRirwfFxizE614KR7qceDXbiqfWZWvEcIkNbwrqydPacu
	 3aYS4fw3Xvc9VHbutX/kuAnPDVsdxCS+TEObu07iJ7wCnXHQHOFYZJ+fBd+p4F+GZE
	 PCn5Qhmukn9SPJRHfokcJMTG60kXFSNcA9lVnKBRfZW4ejWZ+gM59sTPQsREt9ZmZx
	 yCDUUuo7AF8Kg==
Date: Mon, 22 May 2023 17:30:47 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] iommu/ipmmu-vmsa: Allow PCIe devices
Message-ID: <ZGuKp2hPnkJ6hy6B@8bytes.org>
References: <20230426082511.3621484-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426082511.3621484-1-yoshihiro.shimoda.uh@renesas.com>

On Wed, Apr 26, 2023 at 05:25:11PM +0900, Yoshihiro Shimoda wrote:
> To allow PCIe devices, add a new condition whether the device is
> a PCI device or not in the ipmmu_device_is_allowed().

This needs more explanation on why PCI devices are safe to be allowed.
Without this context it looks just too dangerous.

Regards,

	Joerg

