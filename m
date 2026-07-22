Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92371442B0E;
	Wed, 22 Jul 2026 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756406; cv=none; b=sDlfvQyJPyHnYlSPv0oTt5lrmWdHDsSbSvcGc04UEOvH8GthEpK7vYDkGKxIF9+sN8JnLMTJUDhMr6cM1krEMkXcYJ+K35Yk6Q1M4cY+AKrCy8FRoUpLECHKfmcjRxpycELQ+yVujdAxaV885NVTBpyqztlc/lq5NhbjB6+7k8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756406; c=relaxed/simple;
	bh=/T10fwFcswnv4wXG25SyhHCxP9YXE7aQuqnILjAFjvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHgX/MDjys+6ZSHoWTW13CuBxtxYIKdR25gcWtDb6pEpByNlOLimqjcavgzj1bJGFXDGWTjGEvwNvvY8m4G27EwIBUa5prrjKAdTLQgtY0+7CdC4ceXGJ/56fb5CooQodS/9ECRn/IdnUcn+vTID97f11kUR73VwZRUyfnRoZ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1Dfi8Yy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1Dfi8Yy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7948E1F00A3F;
	Wed, 22 Jul 2026 21:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784756401;
	bh=yWtHuqnTqW9SLdraO93l+DGah0VpZgdlob2IbGFczGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S1Dfi8YyEl6vyEKr83gS8maBJDojpNuLsez2F6xCXFPd9wfppENt0wP+Oor03fqkQ
	 DgfrQMtlorzPtISyAqKmWwSuY8DXHp9xZdfonj/SYO9fzbml6TO/+O2g0/Nqxv22lE
	 rumzQUoJmozPC9BkIW7g5Jl7Y+BBQ5gsgO8lDhsceTWV9mkP+TxIU7H4K7ThvYNrXR
	 mT4bpemgptfKJgvpdsta6a20PRK0TZC/1GDiF4dsK6FDnDCRtvtFtCj+16E50hbRco
	 kcIFATpABOo0hUdhuKunynEgrlMqEDaBxDRryANaSg6wZEvq66e+cJxH3Ig3g028wo
	 3kDh+kVEkIqdQ==
From: Will Deacon <will@kernel.org>
To: robin.clark@oss.qualcomm.com,
	robin.murphy@arm.com,
	joro@8bytes.org,
	jroedel@suse.de,
	Haoxiang Li <haoxiang_li2024@163.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/qcom: Remove sysfs device on probe failure path
Date: Wed, 22 Jul 2026 22:39:22 +0100
Message-ID: <178472514942.2872651.16544710591935905775.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623071245.1985938-1-haoxiang_li2024@163.com>
References: <20260623071245.1985938-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 23 Jun 2026 15:12:45 +0800, Haoxiang Li wrote:
> In qcom_iommu_device_probe(), if iommu_device_register()
> fails, the sysfs device created by iommu_device_sysfs_add()
> is not released. Add a goto label to do the cleanup.
> 
> 

Applied to iommu (arm/smmu/updates), thanks!

[1/1] iommu/qcom: Remove sysfs device on probe failure path
      https://git.kernel.org/iommu/c/c579f18e7959

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
