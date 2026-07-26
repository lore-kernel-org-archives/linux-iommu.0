Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD7035A933;
	Sun, 26 Jul 2026 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785078067; cv=none; b=mIffRXNBDsydsImQavh0OXRN3w/SP37E34ANo+JRqp5UfdujpgppIuCQGRhbqIxVp2APmiMZr/dQj+Eh9sQdKNg8QdS3VAhrtfQPXCjNYU4qfXFkr6ApB+AKHWEjc2BcGpglSxCHUOgw7TJ35R7K+24MralfcWcRXkRi08T79As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785078067; c=relaxed/simple;
	bh=59nyRT1IlqB9w4qqZgnpYb/20kk7Gme/Fc/+dO5D+u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B76DsS8QikRX5bCZbNrkhy4eFlcj7MrUhqZki0zlmX+15DIbtOPBKzXv/JrQAITvpKpPObrIwRJ6V3PooOoqu4f9CcfEcUekavmTzKtZktAZZfK6pn9lfx4aczftK2GgAlQejqvit5H1ikKUWxYF5ZO9GYEPtobRdF7e1UYaNKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIqV8LWp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIqV8LWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72771F000E9;
	Sun, 26 Jul 2026 15:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785078066;
	bh=clwj4q4UpGEUllT+fg+A2L+5IZtVPICovCdoYYNU72g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bIqV8LWpXI54aCZDK3wmSc+DET7supMiDRYgxkD3yDh3obNCLjEFaBCAtScs5jdvI
	 6FkXtNmkM8ihiO2KBsHOsrW5fgbbXwzqQKh26z2j+byicjYrohDxws6qLGu/qHs3iD
	 E/GHfGqLEVWmVnTJOohiCAI2kf+sz7UltmpicyFSOk2KJlT24FwJfzqVtThy1oEnFd
	 jtuS5K6JpquMbNnE0Ttnmg0tfns2w/pIQiF2DR2Z5r21DyrGUODAUftHcIwH7E4s+N
	 Um5+g468xpTqVlZmEC+VnsuY8FeDhZE3B3f6T5Wmfjfh6ryJNxbihfsXI00Nnphe21
	 YhlN5EqEXgRcw==
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jonathanh@nvidia.com,
	thierry.reding@kernel.org,
	nicolinc@nvidia.com,
	Ashish Mhetre <amhetre@nvidia.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iommu: Fix interrupt type in example
Date: Sun, 26 Jul 2026 16:00:50 +0100
Message-ID: <178507371894.3389438.5885986849124953777.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622065410.2780215-1-amhetre@nvidia.com>
References: <20260622065410.2780215-1-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 22 Jun 2026 06:54:09 +0000, Ashish Mhetre wrote:
> The CMDQV interrupt on Tegra264 is edge-triggered per the hardware
> interrupt documentation, but the binding example describes it as
> level-triggered. Correct the example to use IRQ_TYPE_EDGE_RISING so
> that it does not propagate the wrong trigger type.
> 
> 

Applied bindings update to iommu (arm/smmu/bindings), thanks!

[1/2] dt-bindings: iommu: Fix interrupt type in example
      https://git.kernel.org/iommu/c/20df8037968d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
