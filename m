Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB571B0117;
	Thu,  4 Jul 2024 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102753; cv=none; b=qOPnRAKSH7Iwg7Gwt0GMvUOFHuUA/iXLeQ7z3aQpV18y9fPlhWnbCilJRmi77Nz57uk2Cu3RSacvzYBCSsbeg4erUtr69AzbA+RUagIAGnwLcu/wW3ZspmYf0qxBtuXHKGwzfUT1pZXt5b36/ZNh1slIBNZbVdEDevErbFld3zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102753; c=relaxed/simple;
	bh=xLWtU+r6HtS/s4pQFfOXx/75eJPmoXke//X9ptIbVgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMzUvYVHrxu83yg5Ym+ROq0w5wXN5bswg0reUerdloSpkhS5M3zZMXBZ46MvPVtBUoPolm+Gw6CzgXEMUHeXWj7kO1P6IS3uSlMSS75qe/yGoGLCkEFUJe/G+cOQ0hyJKrteVZMPvosINn3zpvDEQF8bMqCydx8jIq1a5vH9IcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTnJGl8c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTnJGl8c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B15C4AF0A;
	Thu,  4 Jul 2024 14:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720102752;
	bh=xLWtU+r6HtS/s4pQFfOXx/75eJPmoXke//X9ptIbVgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YTnJGl8c5wfv8pFoMx0MPfIwGiKoZPbKD9Rxv9Todv2zmcHUk2WYqqi7EakObJvTP
	 cuwrJlEwzbj3DkhkX8Xi+2NzeibWQKN8c+0IH1D3hxc7Yz1yuB9d6T2v3Sz4dbYOby
	 0yfPkR9n3aOcy/SrV100v6zbkL4uCKvmWuT2t0f5Zn0tDL7fHVkBbJB0Q9NT0WRGXN
	 SQRmpkDyjP1+VO59dk0xESwKID/YGFse6f1iWhdUgMpk4polojrY4V43zXglekKKl/
	 r+KDoafLXqWOs0tUzdZfuyLOCxTRseSv5aC/kJ+3ib4lJ6xiGDYz/MPCKp123TO063
	 N6AEkbxwqt25g==
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/10] IOMMUFD: Deliver IO page faults to user space
Date: Thu,  4 Jul 2024 15:18:57 +0100
Message-Id: <172009718026.360360.18220408964887632139.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240702063444.105814-1-baolu.lu@linux.intel.com>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 02 Jul 2024 14:34:34 +0800, Lu Baolu wrote:
> This series implements the functionality of delivering IO page faults to
> user space through the IOMMUFD framework. One feasible use case is the
> nested translation. Nested translation is a hardware feature that
> supports two-stage translation tables for IOMMU. The second-stage
> translation table is managed by the host VMM, while the first-stage
> translation table is owned by user space. This allows user space to
> control the IOMMU mappings for its devices.
> 
> [...]

Applied first four to iommu (iommufd/attach-handles), thanks!

[01/10] iommu: Introduce domain attachment handle
        https://git.kernel.org/iommu/c/14678219cf40
[02/10] iommu: Remove sva handle list
        https://git.kernel.org/iommu/c/3e7f57d1ef3f
[03/10] iommu: Add attach handle to struct iopf_group
        https://git.kernel.org/iommu/c/06cdcc32d657
[04/10] iommu: Extend domain attach group with handle support
        https://git.kernel.org/iommu/c/8519e689834a

Jason -- feel free to use this branch as a base on which you can take
the iommufd parts.

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
