Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9D7A95E
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764079851; cv=none; b=dUsjoks1XDkhJtWu415oh8Zl4z5SK6ngPDzq/li/XqCTlN8x3pXXa9g4F0iSEoh5S1SroozV5mtLBbPKgixuQCCXTs7NfKL0JS8vlESeZQXtHau/oj9uKj7RV5cOJqIx0LAUgc+jV9xnq9oYwC7GPDYBjk+j9Fv/2RoKTORTT3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764079851; c=relaxed/simple;
	bh=DaE6T0zxmcl0luyUOTESARfKNWvPKrzFIO8i5mwTF/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1Gu4s2YTcSSUzkZEPNqKvU5o51FR7SPbL4v8Lr54d6Cnly/SoJtIVPJw/hb4CMSO1Hfdr9ZrIfs4569eKTrHH+MK3Zq/neB+bskX7lW17CzXdng+7Dv+5ucBj4DEUlhXoG61S6rO3tvn/pf+1GCgVi5FixBLgvcnkozSgn2Aic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=SBcItfeB; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="SBcItfeB"
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1DED45C40D;
	Tue, 25 Nov 2025 15:10:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1764079848;
	bh=DaE6T0zxmcl0luyUOTESARfKNWvPKrzFIO8i5mwTF/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SBcItfeB3p+IVNFHL5mLfxijJNUsnmoMyHEdg1Er7IzH8UKcEiGPkyQfEk6TKkEBU
	 vL+q7pQ0vxnlkBUeONqNcPifaI6VoztjELqTpy3VnDvYhpZbJfVTjJ0nmwFz7CS9IW
	 qf7USbFhUMGOczwry45btpAec1pH87tQM5vFGNtPq3+NGZNhSM9lrfzB8+aLjYvpZA
	 JGatPKRN89m9q5YMTggvBm+dZeh+9OFEWcXkkkOwTzDm8xHZmdFt1X0dSAVgIrWgh9
	 zXvrKyUngWWAV3l2uNf4EqyzkmgcxF9sefh+eYBDb+7nyFhKzpa+Y7e8t+zrXegWTO
	 XpcyCYyNjBqGg==
Date: Tue, 25 Nov 2025 15:10:46 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: suravee.suthikulpanit@amd.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Propagate the error code returned by
 __modify_irte_ga() in modify_irte_ga()
Message-ID: <rl2w22cx26vca3gi3c64axt2enez6qcna2w4qpfbfjeopjygst@ttvuj6gdgb7v>
References: <20251120154725.435-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120154725.435-1-guojinhui.liam@bytedance.com>

On Thu, Nov 20, 2025 at 11:47:25PM +0800, Jinhui Guo wrote:
> The return type of __modify_irte_ga() is int, but modify_irte_ga()
> treats it as a bool. Casting the int to bool discards the error code.
> 
> To fix the issue, change the type of ret to int in modify_irte_ga().
> 
> Fixes: 57cdb720eaa5 ("iommu/amd: Do not flush IRTE when only updating isRun and destination fields")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> ---
>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
