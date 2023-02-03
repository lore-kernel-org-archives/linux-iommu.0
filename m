Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007B71C29
	for <iommu@lists.linux.dev>; Fri,  3 Feb 2023 10:09:09 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 01227224229;
	Fri,  3 Feb 2023 11:09:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1675418949;
	bh=r7SUvotyKx+16U7BwV0SMEXtayu+LZo5dUy9kGZBOk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zFy88Pw/b8pcN+C7wfOt1ncN6kxKcSTC0r2zQi5Ifiw/fsj20guu2rf1yGsftqCV3
	 MtEfDkOH0+3VizvABjXywfoM7C+jrIr0D98RFd9C5GIWk0edtWEtZpsSCByCMtAGQz
	 MidlyJnP1JdvpOwecpZyVM7STX4djyHjPakWXwu+3FMO/pI6dBrOT1yQujDOy40F3H
	 HsLbkPNiC79N/cfy95B4v9uGXzPGBx+cE56KhR/jmj2Q5dn+vaGDlMQOzSn0y/QgyY
	 smjeYkGuQ9kp6Dd5QB2O9cTA8b/fGUNfXUJ4qF0oWJPG7L6XH3vW3sGFwYdccPC1dv
	 gxBGrHI2U3jWg==
Date: Fri, 3 Feb 2023 11:09:07 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: kan.liang@linux.intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] [PULL REQUEST] Intel IOMMU updates for Linux v6.3
Message-ID: <Y9zdQ2bBWi3qxCFI@8bytes.org>
References: <20230131073740.378984-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131073740.378984-1-baolu.lu@linux.intel.com>

On Tue, Jan 31, 2023 at 03:37:28PM +0800, Lu Baolu wrote:
> This includes patches queued for v6.3. It includes:
> 
>  - Add Intel IOMMU performance monitoring support
>  - Set No Execute Enable bit in PASID table entry
>  - Cleanups
> 
> The whole series is based on v6.2-rc6 and also available at:
> https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.3

Applied, thanks Baolu.
