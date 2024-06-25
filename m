Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9527F1494CB
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 12:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719317160; cv=none; b=ETnZhCg6bOALIWVE5uVTaQK/ZkxMybwlyCQvViNsQXy9Gl3F5i/dLHgMF3uS2Xrb7ga4OHsuPdm3m8zqOsBFFThNA9R7LeKM6bb/vOlZBo0+GtwUg19G04pZx52aPS4FRAJ5siKYCveGnKevYtEscR1XfNkz74SeVPWTxarSsiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719317160; c=relaxed/simple;
	bh=IA7enUnUyBTKua/fvBGvrCZF/D/ahE7RIyVb9K6ScV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmSVYP702ASpSVCYWUAsg3SpqkQ82GKcyvA3khEeXOnlRztPZfIK16L1eXt8a3N6m24c8dqUl+btiX5W7ejflW4iNkvvuiA2BWX7YWUAgH948q/cbYKKDmNjQvT42yFDvKF6TR8Li4mAlItckV1lsb7CRfh7913NYeJr9atucOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=DZFMqJH6; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="DZFMqJH6"
Received: from 8bytes.org (p200300f6af01e500c6341f51fa179db0.dip0.t-ipconnect.de [IPv6:2003:f6:af01:e500:c634:1f51:fa17:9db0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 81E091C8886;
	Tue, 25 Jun 2024 14:05:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1719317157;
	bh=IA7enUnUyBTKua/fvBGvrCZF/D/ahE7RIyVb9K6ScV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZFMqJH6ZEeQieho7qSY9lfZPqwU2WKYAxD22uyiMMk8edb+tsiA6dXSxjYd5kC4E
	 wW153dp1V0psA4jiHkrU0cdsh7vSMZ7maQkwB9CtAv3/Ul99d+jYumTtZuQs24P37c
	 3T1XZoKZINXyg0BpHK/8xizTQmM/dTedxKMCis3dFtOBicY2bd7ob9FWuX6ugruGpN
	 MY7xWtV/72ufksgP9Q/N8TADp9SUUMD2tqqjQY5vb82fGt9CDtiKdbQqMSOrNxAAkL
	 UT7LpQ0aMdPRQLZAUwExMn5irfXlLTzNsDX/Qq79HsyuY2kG074/TkBnnpPeStAB4Z
	 LzNXpFEt8SK2A==
Date: Tue, 25 Jun 2024 14:05:56 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	FahHean Lee <fahhean.lee@amd.com>,
	Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
	Sairaj Arun Kodilkar <sairaj.arunkodilkar@amd.com>
Subject: Re: [PATCH rc] iommu/amd: Invalidate cache before removing device
 from domain list
Message-ID: <ZnqypCyRNmNvP6n9@8bytes.org>
References: <20240620060552.13984-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620060552.13984-1-vasant.hegde@amd.com>

On Thu, Jun 20, 2024 at 06:05:52AM +0000, Vasant Hegde wrote:
>  drivers/iommu/amd/iommu.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.
