Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E432F6922
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563614; cv=none; b=GuEIzAUFUMuFiR/GhVEycwH5J94NJAKwXnxEBvb0w2v3w3uVWPnnZ+hfaspSaWF+RUcfARD1O3ssgsku+lGV/QW/XPbc5txWdIZUOBXnfs7Y0Jt3cy9k65MZme3k+tjfzJyYMgrPCO1aFBuxYHGfvwj7E9I3G6xOo3jDQDpV4vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563614; c=relaxed/simple;
	bh=SOVoP9KTK/vXTMQpMODv1OW4774DKIrYmYxegCXSw8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNSTdlLRwx95z2I690cktdCjFgkU3/HnDqBp2aWEbmfwy3ja1CqUGq5vcsUxc8CfSDu6snP7JHTKipMHvm8q0ZzZVh2ZniZYSkmhRIsAa1joMzTgVIdXDWsbihgMLcfXcQxfOSyg5dcTFZUrbCWi10VfH6C80ZQIxhKa7/gGqUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=kmPaxvMv; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="kmPaxvMv"
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id ED6DC5995C;
	Mon, 27 Oct 2025 12:13:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1761563606;
	bh=SOVoP9KTK/vXTMQpMODv1OW4774DKIrYmYxegCXSw8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kmPaxvMvieffBTn+GbHIww3vQP2knKQneOpOH8Pz/mEks+9C9jzm8rPKyfiPgjiXv
	 Gg7WzzuhgeZ4DKY2IP48IJWIPc6SdowBXHx7m514hS6mm1rj5tvrn8OmCCLkMoA70e
	 7bevF9yCocm7d4oieq73CsPTToJP5g/LV5B0DeD/vhcBBxfOVAH6dAACpMeUTKxXJN
	 pbTjr/U++JhPwl6Ox9SRa+kmsocIDl7ApuC2RItJfx/XGI2yD8XPTLO0GYtbUtTWHk
	 JGf2/ghghSt6GlFaprOFjpyC00bRTtUfFaVoGSBBRwH/h7ykh3jawOhDt+bK22th0b
	 PJibVhelNWUXA==
Date: Mon, 27 Oct 2025 12:13:24 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Hou Wenlong <houwenlong.hwl@antgroup.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Ensure GA log notifier callbacks finish
 running before module unload
Message-ID: <blyxvyaotgjdp62yfvsoygonstgjxfwkhlqklpar5slnb7hcsj@re3vttz3yyu3>
References: <20250315031048.2374109-1-seanjc@google.com>
 <20250918130320.GA119526@k08j02272.eu95sqa>
 <aOVT4VlumG01X0Hk@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOVT4VlumG01X0Hk@google.com>

On Tue, Oct 07, 2025 at 10:54:41AM -0700, Sean Christopherson wrote:
> Huh.  I completely forgot to send (or even write?) the patch.  I'll send one
> shortly.

When you do, can you please add

	Vasant Hegde <vasant.hegde@amd.com> and
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

on Cc as well? Their reviews are important in moving this forward.

Thanks,

	Joerg
