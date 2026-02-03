Received: from mail.sig21.net (mail.sig21.net [217.197.84.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705CC2D94AF
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.197.84.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770119377; cv=none; b=sfEs9G07OxfV0rPBPTvm2iyuNjPjKCtlJ9PQE4hOmflMCd1UwbLe51k0k6czjKYlLH6fa9ezpcK0CVql6icjsCQ6RXZS+EE+HdVF2To4VEmxEBRfm21DwH5ZAM4jqQPw90jcNCpPBEI7AkhZCUm6FtOVnd6b91FBiSuuuraSnQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770119377; c=relaxed/simple;
	bh=zyjPn86MP0jeyGhNhY/sQ5tNYI1Yjng/Q8VYfA8jYkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhIWc3xF7E5K1mr8dhPOAM9Jqo+fTj5DcXeCe3N1I1gr5wBMK9+GPeWkBnzdLZpEcUbuMiHf4z4xWVXClq9Q/2FCErfd06xqsKGZhOb2oh+h17t/O7pIIGc4Z3A0E5Pg8Ort6vkfaVtQzP2fQv319Ir6L/LzY5H8FT0W53DhBwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sig21.net; spf=pass smtp.mailfrom=sig21.net; arc=none smtp.client-ip=217.197.84.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sig21.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sig21.net
Received: from localhorst ([127.0.0.1])
	 by mail.sig21.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	 (Exim 4.94.2)
	(envelope-from <js@sig21.net>)
	 id 1vnEuS-0003en-T1 ; Tue, 03 Feb 2026 12:49:32 +0100
Received: from js by abc.local with local (Exim 4.99.1)
	(envelope-from <js@sig21.net>)
	id 1vnEuS-000000004LT-1hYR;
	Tue, 03 Feb 2026 12:49:32 +0100
Date: Tue, 3 Feb 2026 12:49:32 +0100
From: Johannes Stezenbach <js@sig21.net>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: Re: AMD IOMMU issue with hibernate on Asrock X600
Message-ID: <aYHgzBOyYlG12p5W@sig21.net>
References: <aXeAOtGQUdlNZF6V@sig21.net>
 <52664ef0-268b-4ffa-a8f5-d2126f95450d@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52664ef0-268b-4ffa-a8f5-d2126f95450d@amd.com>

Hi Vasant,

On Tue, Feb 03, 2026 at 10:58:42AM +0530, Vasant Hegde wrote:
> On 1/26/2026 8:24 PM, Johannes Stezenbach wrote:
> > hibernate on Asrock Deskmini X600 with Ryzen 7 8700G hangs for
> > about one minute before the power is turned off. It happens with
> > older kernels but also still with 6.19.0-rc6-00200-gc072629f05d7.
> > Sometimes it also hangs for about half a minute after resume from
> > hibernate.
> 
> IIUC habernate hangs for sometime , but eventually succeeds. is that correct?

Correct. There is a ~30 sec timeout in iommu_ga_log_enable()
(MMIO_STATUS_TIMEOUT=2000000 * udelay(10)). But eventually
hibernate succeeds.

> Also resume path eventually succeeds. is that correct?

correct


Thanks,
Johannes
