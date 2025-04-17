Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116C4347B4
	for <iommu@lists.linux.dev>; Thu, 17 Apr 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900378; cv=none; b=CNooXWQG5az1xuc3wDM+GIkc1hCDlphR2f0fSJoT+PE3Hw2Vl8WQNKqFzqCHJ1CTl6RtkV/DipTcUsObBbCPAsA3/HU+Le0rMpiUbDalg2TQiXCeJr6iUp4gKAhS+rr3LS2nSaNHWjTM98YMR5uzq0gtqyQg7CGcJ0VWeVigkao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900378; c=relaxed/simple;
	bh=Q+mwj/32JuAHr63URsZEX8BOgZe7uZgNegyO6iLCpxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izTg62Y7cAKrfx3mxZ0Us+OTIVZTzvP6mFvNeaD3Xu9p4mKs7ILNcoO4EWytquhq7CAN1GmLbnh09fC5DZLD7Jh3cQtH1p8aBoyoLCleo1GHPBl02y1cZ7QVzTh4EUudpTDptAUNyKZ6ua0hiBf6HsS1bxHcevnYMqoQjpgqSRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=1Zg4cd7M; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="1Zg4cd7M"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 88463485A8;
	Thu, 17 Apr 2025 16:32:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1744900376;
	bh=Q+mwj/32JuAHr63URsZEX8BOgZe7uZgNegyO6iLCpxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1Zg4cd7MxwEdWaonBkKbZ8IizWLchUrGZSIFOk0sieuDy4nHgapkB672p67b0/oao
	 Vv/kl6eXUjaWmnlpAw/5jT9+YUY+a0CbtCGfX4bZWy+mr+mjGSWjxo2H66a+aWYQ2r
	 5DmtIWZnLMl9Z6PIeTiLgfZNSkpoKZXmnAQtFgVTPMzuNh5SoRYt+hmFNpE//ziG+V
	 +a/O3u5vUYWgh6WyYxJjjtXEC3uS8TXl3XBu9mM/wdQqrfD0cTMmlAkOcbr+UL7Ivj
	 u2KCydHWmfFAV0DXkiE8tFJ/FASNCTq7rFSMPWTlkOjker13cqoC7r+PlrZy4Pv2zE
	 E+KlFh2Tlx5JQ==
Date: Thu, 17 Apr 2025 16:32:53 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Rolf Eike Beer <eb@emlix.com>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Bert Karwatzki <spasswolf@web.de>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCHv2 0/6] make vendor specific subdirectory inclusion
 conditional
Message-ID: <aAERFUJj_6NuxAv3@8bytes.org>
References: <12652899.O9o76ZdvQC@devpool47.emlix.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12652899.O9o76ZdvQC@devpool47.emlix.com>

On Thu, Mar 20, 2025 at 10:01:45AM +0100, Rolf Eike Beer wrote:
> Changes in v2:
> - clean up subdirectory Makefiles to use obj-y now
> - add arm/arm-smmu-v3 and iommufd patches

This conflicts with the core branch, can you please rebase once I pushed
the updated tree?

Thanks,

	Joerg
