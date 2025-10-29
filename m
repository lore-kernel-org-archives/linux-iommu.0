Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC383161AA
	for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 08:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726611; cv=none; b=jAPkGmLLDxPkFbajgeTfs89emI4rwb0DY7Q0X11GUkzK01VLCKcA04Bj4opOxZ/U6sojKTXBS0gjO/PGgFQECZiVfefDKq9+FzCVmEiVa579u6I3BgCE/8HumbAXBxvH/OROLmMZNKv04PC2gNsA2OcurETEO1DqxtaLYnuEuVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726611; c=relaxed/simple;
	bh=GKd/6bLNLkfbD/elwJDJxg4Gp3b5rvvGHiDYKJ4jQJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwmO9MuZAbmlM7M2j3Lsim8anKPIFYzquDh11a8bc5qScRFYKk8fq4Ve7MTfkr8UstX3AnOeNfO6q4rpmneofCv0JhovanRoJdNDFlZiRGvP5aSMRWJiiOwSSUfcGyuWDck0255oBarRiiyM8CIqGcyMgL//YvmLjFnyOONA/pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=qQYLRPWQ; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="qQYLRPWQ"
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B7B8159DED;
	Wed, 29 Oct 2025 09:30:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1761726607;
	bh=GKd/6bLNLkfbD/elwJDJxg4Gp3b5rvvGHiDYKJ4jQJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qQYLRPWQMGXn+KnbmnS769dFuhVTQr9iW/KTeTiKKkIFkdrZifckMo9yH4+bXmaeo
	 YT2hQHLkPxezPEUHvrQzEsZX+jjBxzwRvoHxQEJAeDjCguujWdgj3S0WbjfaxMRskz
	 4/j3BRD6S7uI1ulfW+xjMaPTOgwEd3CC4s5aeQ3wpCzdB4CVJ26ubMCaAbzKGqVh3n
	 PPVFW62MmQGTjWgCA7FB0KC5AU9EMhsvnThC87W//OIBQ7Ad441ppO6ytDZ+6NxzS+
	 aMNvML021oFXe+/ot7T1SqY4UZa/meb5IGs0CSoyx9UNc+0W+1fNVxC+fgZRVdmcSZ
	 nC7uziJqMUDCQ==
Date: Wed, 29 Oct 2025 09:30:07 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>, 
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, suravee.suthikulpanit@amd.com, Santosh.Shukla@amd.com
Subject: Re: [PATCH] iommu/amd: Enhance "Completion-wait Time-out" error
 message
Message-ID: <5uof463yi5zq6y3rsjqdifktvqxe4ctb63koz4qgbwvjgiudlg@qtjxrrymt3mj>
References: <20251016150809.5465-1-dheerajkumar.srivastava@amd.com>
 <tgugv7ebuxtnp6ou5jnt7od7jmccsipblqityiinhkgratosu6@bxsr73hpiiny>
 <01c81b5e-d6a3-41fa-9758-37661e115483@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01c81b5e-d6a3-41fa-9758-37661e115483@amd.com>

On Tue, Oct 28, 2025 at 02:45:16PM +0530, Vasant Hegde wrote:
> We have debugfs support to extract entire command buffer. Also many cases once
> we hit completion wait timeout, buffer won't progress.. and we will hit
> completion wait repetitively. Hence in V2 he has removed printing entire command
> buffer.
> 
> Do you want to log entire buffer once to dmesg if amd_iommu_dump=1 ? (for first
> completion wait timeout event).

I think there is some value in printing the command buffer contents at the
point in time when the timeout happens. When it is read later from debug-fs,
the state of the command buffer might already be different, making debugging
harder.

Although dmesg is not the optimal place to dump this information, I also do not
see a better place.

Regards,

	Joerg
