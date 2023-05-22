Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB1614A98
	for <iommu@lists.linux.dev>; Mon, 22 May 2023 15:24:16 +0000 (UTC)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B6549248072;
	Mon, 22 May 2023 17:24:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1684769055;
	bh=ptyW7oCx/HCiX20PieqrlaUejHk1DbuuffHff0LY8CE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dqooSWknRU1uMkmjiI7s7Tgiclq+xv4JVB2sL0S23XYozi+DU6Yc7A2mhhIozqvZf
	 aeAhXLoI0o7VdF/vQdcBhu/bZz2jWxs/LpbFzmBUCe5GFuA9PUpW6OYJX+CgUy4gf2
	 uQBZwDdPl1nbVYB3Z0XWkYd2OJio58H7/lfouFfXAj8y9S7tV/rmNbDEPIpWGBK38P
	 8QhCjCpkZDep5UmMU33cHVfhF0y3gTH+ay7enYUsPus5ocn02SPYhkxgHROqf8HOJH
	 g7JDTW4BFDS7963K97bJks8DPwpiS0bxscGdpeIOO/r/bb9kWukkg0gNQ7HPVIkHxI
	 SQknXJEW9ta0Q==
Date: Mon, 22 May 2023 17:24:14 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: amd: Fix up merge conflict resolution
Message-ID: <ZGuJHu1hWBaM-8em@8bytes.org>
References: <20230420192013.733331-1-jsnitsel@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420192013.733331-1-jsnitsel@redhat.com>

On Thu, Apr 20, 2023 at 12:20:13PM -0700, Jerry Snitselaar wrote:
>  drivers/iommu/amd/amd_iommu.h | 3 ---
>  1 file changed, 3 deletions(-)

Applied for 6.4, thanks.
s
