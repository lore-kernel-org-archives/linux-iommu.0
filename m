Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C672154BEE
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719317347; cv=none; b=p5nw/5mycXP6exM20498m41Y7IsrG0b32LIb9zImovD/QyiICTsDXmnlb+O6BkcJ8Pdz6v80JWh3OXrN7SZ6rvx83li076ZQ4Q/Ou7DlVIyn88cg0dalmVHxTNlU1Woky5ZxNO8Irlzt7zXkoGAS/W6P2OomjAPKAa6kXmiucRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719317347; c=relaxed/simple;
	bh=qUelESUOXHpYySXjuMemGWRUtTTMk7BYbZLHwZoA7pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Anq46/9qy9jzuuxOyQnfgh3IxZr96BRnM1LC2YIYnogvMW0lvP5VEhuUPiWa6gTrd5Iu8IR9CJe3rRqFCe76S7hpVUPz0OLQywR6LARpPtJpwKnxgOOBCyy8G8YYX/bOHg3bXHE7A0lgvly5KAgE29HPCqPdioCvWClIFJwnXJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=cNjwSIAG; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="cNjwSIAG"
Received: from 8bytes.org (p200300f6af01e500c6341f51fa179db0.dip0.t-ipconnect.de [IPv6:2003:f6:af01:e500:c634:1f51:fa17:9db0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 105CF1C8886;
	Tue, 25 Jun 2024 14:09:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1719317345;
	bh=qUelESUOXHpYySXjuMemGWRUtTTMk7BYbZLHwZoA7pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cNjwSIAGaganB1e3E9EAV3mTy/Y21PmJ1Q8p3ctlqkNawS36Zv7jiO95Hd+VYCH4f
	 prGqkDNFXW5MUyRxPE1B7jluMj2n/RAQBPbCPV/QFfXTtyd4i8+E/AeLC5t0qV7xdt
	 rzU4f72qd1CBWJYy/98GOTfP60Zsj80TCbgB5Qj88ZjinC4g8aw9VFCQpAO4VgJiXY
	 rD+VmTv0oroFxc0HO0OkOegjcToq+OrvnhV6Pd4302vOmuW11UwZOTCzbyYHuegLRj
	 2gglY8GzertkFMac7188vkiZxbgIrti1XpOy0KkVQPj+c3mdJFTv4Hn2i04RmNeFi0
	 I3IQ+dTzNV1YA==
Date: Tue, 25 Jun 2024 14:09:03 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	=?utf-8?B?QsWCYcW8ZWogU3pjenlnaWXFgg==?= <spaz16@wp.pl>
Subject: Re: [PATCH rc] iommu/amd: Fix GT feature enablement again
Message-ID: <ZnqzXyCU8bn32j4-@8bytes.org>
References: <20240621101533.20216-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621101533.20216-1-vasant.hegde@amd.com>

On Fri, Jun 21, 2024 at 10:15:33AM +0000, Vasant Hegde wrote:
>  drivers/iommu/amd/init.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.
