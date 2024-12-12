Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6020723EA6A
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020770; cv=none; b=Wul7zXlHiDYRy7LWL2dnlWn+IgMaYkEFJD6BHbQSgeotbIsZAbQ1vbxZLy1wBLuFPjQWBkdPk8WUj0E2VOXOtVmrQWY2XW59rw8UPLfmiGT6R9bml18t0teeFxbCn8LPSqPtKnNX1MhIHKZYFvJA6oVQzC9+OG1l3EDjeB1Wv2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020770; c=relaxed/simple;
	bh=Xp5JrddSBs5Q+K9hrJ7xzi5PnxULx5JCdXJ4Nwg/nMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYQCQ0xCmnsJSDo15H5bYPrZOAFPdzIMc0+RrB3FcirRzqwtevCVhlx0cOBO3XxOpMG8WA2+7I6q4KRYeQGXn7XfrND0abjywRIW3QF27MlV8eiObUPHjyHT851xlClZTjANruYCXC79Ydj6a3SkxgvE3APzSKBLn/ox7pXZSNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=mFBkNUV5; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="mFBkNUV5"
Received: from 8bytes.org (p54921e31.dip0.t-ipconnect.de [84.146.30.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E58F92C1F60;
	Thu, 12 Dec 2024 17:26:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1734020767;
	bh=Xp5JrddSBs5Q+K9hrJ7xzi5PnxULx5JCdXJ4Nwg/nMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFBkNUV5Ee8Dn1kQuqvi5q/23w+2frZIxInZl3Wp60aLDYi43ybQiSCM06z8nhxXT
	 ozJT+ZhUe31o3XKO74gSWIigQZPZiK5zzCvHAe0n4cAzYFIKMRgkr50j8sKMI9CNy2
	 ih9fANumpq/3yFVgqs/KoOjvQc0Qp25PKDFva9LSsQ7jrV+ogmgEaRt7huUo2RRKei
	 x11ZUVEf5RlfT1Bo8tv1S13WTTmicHBHl8yinPsYKwKY96AvcS3SEIGGlUzZ9EMbTG
	 v4gdsY7BCLnv1f5hhI70pzAPnFYikPUtJ9PCl/CrJgCg4Kasdi4yL8FO+XftDb/9xg
	 Wj0H7MhxXjWGA==
Date: Thu, 12 Dec 2024 17:26:05 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Fix for 6.13-rc
Message-ID: <Z1sOndzI5_VxdxXe@8bytes.org>
References: <20241212095025.GA18975@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212095025.GA18975@willie-the-truck>

On Thu, Dec 12, 2024 at 09:50:26AM +0000, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-fixes

Pulled, thanks Will.
