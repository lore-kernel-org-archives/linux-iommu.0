Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C408E2D481A
	for <iommu@lists.linux.dev>; Fri, 15 Aug 2025 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251484; cv=none; b=MM5B5T7gLPAQf2tJ3JOhK5ebK046dRsAJrQb8D6fBMTCS31s/4vqlBYeaybg15XfBTo18bKPjLi7IQjkztm9CkUZsKPQA24sSFugSkag3SnZVEM985cwGvX92HSB4Gic8+abXgUjhHpVoqigBBHpc9gkTgpmVuH4TQ2VjrPJ3NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251484; c=relaxed/simple;
	bh=8W+Dskg81j0SnDppPxLgb3xnJaPPBbqZnhuDWeFxCt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQoisx88U41MznEx6B96lX17TUPHSO30Qmp8PIpMRXaVMND5D5Ch+hxc0pNmFxWKsFwU823VCCA17TlvW8vYW9PrP1UkFZj7xrEcmx+WqDHEwiEGj/k+1NQk+IuoIPUsOI2+cFRM37h/wB3SJTwi8b0wr8TUIxcW+P/EAmoHkOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=rYkJZSl5; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="rYkJZSl5"
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B60B552E19;
	Fri, 15 Aug 2025 11:51:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1755251476;
	bh=8W+Dskg81j0SnDppPxLgb3xnJaPPBbqZnhuDWeFxCt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rYkJZSl52dgMOLJE0yScG56WMpTjv59nrn4kDyKHKivQLGZwpesaMKqjSs/RsnEHz
	 Wx14SkI2ZkxI0WqcjnWUxX5L+Lj7qlVe+1MCna6b3w8XpJofLwNlU2AZ2B+vSWfWPO
	 xacFOMxalbA+1ckhnpsV/8h0WwnXusd2sUfrtok6UQAWz2/PCHFS+NbDaFVnBhJXqi
	 NnbfB991gQ/WmykwuaLfuza9Oy3h0VWNr6GXvmA8d+ieL0nTi0/ZENMobmwW2rXLJr
	 t1K+qmowo8+dLgheb9vkWmgwcCFiZwHEOGpECVW5PZq59FVjgEwjBAm0aVjxb+W32n
	 CeAfz3h2rYbNg==
Date: Fri, 15 Aug 2025 11:51:14 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Kees Cook <kees@kernel.org>
Cc: Simcha Kosman <simcha.kosman@cyberark.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Kim Phillips <kim.phillips@amd.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH RESEND] iommu/amd: Avoid stack buffer overflow from
 kernel cmdline
Message-ID: <aJ8DEnDyc61BT-1F@8bytes.org>
References: <20250804154023.work.970-kees@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804154023.work.970-kees@kernel.org>

On Mon, Aug 04, 2025 at 08:40:27AM -0700, Kees Cook wrote:
>  drivers/iommu/amd/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied for -rc, thanks Kees.
