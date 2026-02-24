Received: from mail.sig21.net (mail.sig21.net [217.197.84.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5CF369982
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.197.84.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924318; cv=none; b=X85bIqZ5Mr9cZso+NxbObZz+DK3PJa+D61vwmP6qBR2a5m7zzZapYvBEbER3js/UsP4EgpscBCksLKM3VQE5BzL2QJGljHZcDACyqlaUltAM+ys9mTxTa+xy0WPUUjjpk4lgr5/D6rItBlrCTa31Z4DwPK+LpOCuAspbf0JAE5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924318; c=relaxed/simple;
	bh=CtDV1Rhc5JibuVr+H561CXehI59B2Ma+bCj7TQhNQVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xrpof4VVGrcgFKC7H8FN/SWH54ZutEixR9vBoxiWAR0V+kXUKiTGv2RjzuKQ+V+7fR+va9fCtQtj5EFnMrnZldXdlPF8Ovc3dGxZVsBcjKIVbyMKw6kAm0oYmN1UnopjRKI0sns4MrhPyaqpqeBD5N5EUyOufLN4X2w1/BUIvNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sig21.net; spf=pass smtp.mailfrom=sig21.net; arc=none smtp.client-ip=217.197.84.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sig21.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sig21.net
Received: from localhorst ([127.0.0.1])
	 by mail.sig21.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	 (Exim 4.94.2)
	(envelope-from <js@sig21.net>)
	 id 1vuoSH-0007iK-Sg ; Tue, 24 Feb 2026 10:11:45 +0100
Received: from js by abc.local with local (Exim 4.99.1)
	(envelope-from <js@sig21.net>)
	id 1vuoSB-000000000ek-2dKL;
	Tue, 24 Feb 2026 10:11:39 +0100
Date: Tue, 24 Feb 2026 10:11:39 +0100
From: Johannes Stezenbach <js@sig21.net>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: AMD IOMMU issue with hibernate on Asrock X600
Message-ID: <aZ1rSxy_za5f51bV@sig21.net>
References: <aXnXX0P-XsEFPlJd@sig21.net>
 <52148f32-2348-42d8-95e0-49b30c29da1c@amd.com>
 <aYHerYcZ-5FOguKY@sig21.net>
 <aYNi4yYA2_Cu359Z@sig21.net>
 <aYSjoRjnR3N3D8lD@sig21.net>
 <49856fda-3f65-4fc9-a75d-84b29526f3fc@amd.com>
 <aZoVhnX77mGUsV3y@sig21.net>
 <cf136d02-986f-402c-81d9-8971229abe9e@amd.com>
 <aZwZMwZ0FOa3dXwm@sig21.net>
 <b152dda3-e929-4ec3-a034-2057ff3c3c81@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b152dda3-e929-4ec3-a034-2057ff3c3c81@amd.com>

On Tue, Feb 24, 2026 at 02:26:01PM +0530, Vasant Hegde wrote:
> On 2/23/2026 2:39 PM, Johannes Stezenbach wrote:
> > [  271.070351][ T5153] PM: hibernation: hibernation entry
...
> > [  302.420499][ T5153]  do_syscall_64+0x7f/0xf20
> 
> Is this hunk from suspend path?

As it says, it is hibernation entry.

BR,
Johannes
