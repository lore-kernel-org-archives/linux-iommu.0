Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35335B5B6
	for <iommu@lists.linux.dev>; Mon,  6 May 2024 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714983801; cv=none; b=eaOYg1sX5w+/oCDqm4UQ10wTBWnBFLdYAJ3GJhJ3tHsr8zvwk1AB9YiyKw4STYjku6KWbKUt6eH6JLjcBtJMEdlkzEiJKp2oGKRE8SySwwsDDnk83sdT+nzEJPlJHboJmzHUJ2TaOkLf2bUpE1ORb9NFBPpi5g/nwKh1ZUNZUc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714983801; c=relaxed/simple;
	bh=q1nZDaEPVinL88fi40DVRyO2u6t+WrB+WenWw1HX9/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbpmwNIdQfdyNZk7sv1cU4D3aKfQru86HoJmfGEkwrRn6NllJX1Rw1PIskyHorPYMMw/b9GQo8RTTh0YVtHMYuNghHaCmvTbHthx1/mh1JxhBNXzebJ+iGBf0wMtU8TnFLiN9K78d/HJu11CpRcveR68eMbQls7tsQfIv6Rd77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=fmTAInWa; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="fmTAInWa"
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 6ACB01C277D;
	Mon,  6 May 2024 10:23:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1714983798;
	bh=q1nZDaEPVinL88fi40DVRyO2u6t+WrB+WenWw1HX9/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fmTAInWaa/M/lPD06OYxph8zQRa9pJJWnORHeRs2hJUfn/KtxK8p5QFVWAoxyxGO9
	 6PL3TfrWVNUYTiPGIKA+wzfswZ27YMnMKRzTx0uIER7q/2lSnxj68udUH0AB4k7FuM
	 8AOUjdoQzxglWG085u+BkKaI/u/RdL0dBm31cfmyfhn6Ec7CcHR96mLo33NRcAMDH7
	 GlqsIgRo7FfjWHiPV2+/nJ1y9ffMcGd7IBIGDi/3y5elA3n5sWNY7KlP93tArPsX9U
	 xlCWNsMjv0vKtG66cYBoTYQMDe3dvvsaxjFesLRENPBTVezmleh68I0zWjY0WuFgew
	 vZudbVmKvXZKA==
Date: Mon, 6 May 2024 10:23:17 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1][PULL REQUEST] iommu/vt-d: Fixes for intel iommu
Message-ID: <ZjiTdTy0Ndil4hMK@8bytes.org>
References: <20240503133602.78992-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503133602.78992-1-baolu.lu@linux.intel.com>

On Fri, May 03, 2024 at 09:36:01PM +0800, Lu Baolu wrote:
> Lu Baolu (1):
>   iommu/vt-d: Decouple igfx_off from graphic identity mapping

Applied, thanks.
