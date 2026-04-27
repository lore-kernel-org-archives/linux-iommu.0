Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBCE313558
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777290634; cv=none; b=MKrMfCHOvphSUUIupmS53PkFDUPEtgWB6zlmWU+0nkhVLCm8X+YViIuYBKV8+as5HuyXO70r7Z9G8OwXkLWFkHhT96gOyOzTdkOya8UM+uRpIovA5E9mMnTlYWhTGfRM2J5dRyfKg0dgRxiVCVUijJq0+PCK3VnKG8QtqbMTHWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777290634; c=relaxed/simple;
	bh=1Vy5Pn7lTLLk/c4ZaJOMMpDSSyOaYf3t2PONR5rBogw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoA1jBAJS6xMcvsEyJFXn46NGZE0jeFIXDnp61aXIWYpgrWTm5+cIdrM9aOrBHD2EXn67auFbYJ6Mfrm35Eb2m14OGuA8drAJDZ82x4DBgAectnuvYNzSipBfxASzSxtDD7vopcV0mfbEzk3O/5Mojh0y5BRxrEL1JmL85u3YyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=2G/n7rBG; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="2G/n7rBG"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1105B2009F6;
	Mon, 27 Apr 2026 13:50:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1777290626;
	bh=1Vy5Pn7lTLLk/c4ZaJOMMpDSSyOaYf3t2PONR5rBogw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2G/n7rBG427EGcYH9lBWDpldifiMqNpQ6EiPlPRJY5bevv2ElJ+wWWqKRBgTfyNo2
	 SW1mKOQNCPmQuL7oCW8xQsfLsEvA0mgaXnjUjyxG7wcCf8PdlcK07POjy72QLWkO7/
	 ix0xUt10I8qQXbrTOuGzZUZ8dTSbJRnHzp5X7MgRqCgIoQH/pZF5LtppSxgVBwRKyt
	 ec0N3fG/QMBkvD9xOKjSu/0U3vvgMgRBZ6kaYw+hh5bHN5qSLINMX5n2clMU34j5u9
	 PI+cghjwaAepHICHLOAVA7uQFaG6cTRB+m8pCm0+ToVJ7pzeuat928qwG0zBokVsuw
	 uJdcdR2suV8sA==
Date: Mon, 27 Apr 2026 13:50:23 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com, 
	suravee.suthikulpanit@amd.com, bp@alien8.de, Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH 0/2] iommu/amd: Use MAX buffer size when SNP is enabled
 on Family 0x19
Message-ID: <tnfenccbp2uqfpc7kwx5tcejbzzmb2xwkzzfcrsjflg6xldyyd@oiwirkvt73ty>
References: <20260420084204.12263-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420084204.12263-1-vasant.hegde@amd.com>

On Mon, Apr 20, 2026 at 08:42:02AM +0000, Vasant Hegde wrote:
> Vasant Hegde (2):
>   iommu/amd: Use maximum Event log buffer size when SNP is enabled on Family 0x19
>   iommu/amd: Use maximum PPR log buffer size when SNP is enabled on Family 0x19

Applied to fixes, thanks Vasant.
