Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9F22702BE
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 14:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754410; cv=none; b=YFnYkEvC9J1GdhjT9wQwvBESJM7NKJ8+yrqOOtJ2gxD/b6iMKU3C1IRuKYCDJJkgUT2U5UuTMYOIEueNjEkM9C0swGnL7euKLpG5uyfD7zDEx6Jo+uHgUExFE/uqbHKLPwfZRCuspBd+BiFzsB+B4NgR7uU0DiqkJsZwOdq2KVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754410; c=relaxed/simple;
	bh=XSRTflYJlO9ufw6eKV6i1+wRhdzV3taMrYfr1kX97SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+NUg1AS/3vQcyVNdUHsf4mTF6QlMOUQrMhYB7KczlcUmTqrZDPalEyvtdBl8lPLQGp+naRij6KEUC4q9kVyVQUlWBF0VzWNJuD4LDlOo4RpeYD5iTdWgjiHpCIdiinndrHBAfPGj7Z8YtBvprH8y5bz/CZgi7fpOXv2fBRX6Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cNnUcvCn; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cNnUcvCn"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0a5aa0f84so192121985a.1
        for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 06:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740754407; x=1741359207; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XSRTflYJlO9ufw6eKV6i1+wRhdzV3taMrYfr1kX97SQ=;
        b=cNnUcvCnRZC6TnZ2BF4F9zeapoDH3zYy1lkui7UNJihN+wnhvVigsixqIErojyZi1+
         pHE5DbxcZFbGLnT0e0Yjvgz1vMIiaGoMWcu+xeARmWvtE1HiK6iyzEreK6frc1sPr5aN
         p37YNbR5NCA9VH/xSENs/W8tpZZABnO7JZSjg4qYHbfvq+TxLP+/n7iE5MFIL7O6IL8s
         p+oKd0nLuuq0YycwntgPBwNbjUgbajErzRbh56moV0FRFMjT+tqC8jNBFx+raRGSEqiZ
         vKV7eE/mY9AXXr/om9XgcMgmIXzapWUVze6j72Q036AsTg0OCtmmwHJTVRqE0C1V2sz+
         Rhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740754407; x=1741359207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSRTflYJlO9ufw6eKV6i1+wRhdzV3taMrYfr1kX97SQ=;
        b=QeDVBGDHzzmFNRcj8xIRj5FQ9orUtx7EyPc7dcGbhRR27uyOszxIoYE3pbOAKey0An
         4PiaC7x4hv8xKCnU0yLqVnHS7sSBpmVLXN7tctYc8GHD4NH95blDFwfnJL7X4CRJBUPf
         N1vHNhwMwrsn+1BM0S1qKwMv1SXox/Oy2Klo4WdGJnVui3ZxNJtXztlSvKzMuZXugZct
         SkneqxS7Mw5ry00SZLveVCZI2g0bDMIVTJ9FAbN0iEAgrxxw7M4O27Cx55Y9dBHCHu6x
         yKJYvm2rbDE1Un+XrkJd44rkn/SHzdldNfmUtfWtSoecYj5vIXnWjawBXob0ggr7B+8f
         lR4g==
X-Forwarded-Encrypted: i=1; AJvYcCXIYX6oknIZZB9bOHXijZVHHs8TKtB6sxBeLznGu2lNLpOaOyoZJXZh0qw67uK3+4X9aRppZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwkbHeTIpRrZM9SlFDYIhNfDG8J1MtXVYKssm3S5Prna0TI9yd
	+wd74iB7cOkhyA5jIvIxEQQNRM2vwu4NCjs0LLk2woKIhfS9BGyhWyWpZf//7uo=
X-Gm-Gg: ASbGncvX+b/hlAiCFrKEKDTDNuq2WY0QB4B54X3WLqFtaG1ezxnNApADEO87DYD1dAL
	OmwamtUQEEFkUGNzL75OVistzra3tADjysrqzSfnAQuL06i3aZiUfBVwwGn++qQkDdK1S6tc4bR
	X6UIAZDGpbAAQDPcXTMVWrXBuZDu55JIV1q5ewkvSUXGaox8beXTYy3ay9WKy+xx4C4jnHQ7CHR
	fgKN7T2Y+2FVhqGiW5W8AdV/X6nEWdILU+I682Q+2XaSiyLx55wlBpafgZcLd9ge15ggz6SpdKO
	yNz2NkHlSmA8mQ0raUGYgsRREP1VPU65WyUELW/F7d+OIDUnSom1cQ1E0biTv4gkJx0uoQnovSM
	=
X-Google-Smtp-Source: AGHT+IGk3CeR8TzEwSP2lRQTLBbATO8V8fiGviRPoAOAw1TFjW1bPmufjtonpFmz2n+TrN3pRkeuPg==
X-Received: by 2002:a05:620a:3d96:b0:7c3:9c48:bf4d with SMTP id af79cd13be357-7c39c48bfb1mr346586385a.1.1740754407651;
        Fri, 28 Feb 2025 06:53:27 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fef4638sm256646585a.25.2025.02.28.06.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:53:27 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1to1jx-00000000Rdk-40J0;
	Fri, 28 Feb 2025 10:53:25 -0400
Date: Fri, 28 Feb 2025 10:53:25 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
Message-ID: <20250228145325.GK5011@ziepe.ca>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <b630b6c0-a25c-4230-8abd-a48b7dc27216@amd.com>
 <BN9PR11MB5276B090C61D1F059538AF7B8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <cc4cf4ae-2d29-4747-b655-df841661b82a@amd.com>
 <26fa08c1-4a3c-44a6-aba6-a35a0f308bc8@linux.intel.com>
 <BN9PR11MB5276D09A00E44AE7D220D7C18CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D09A00E44AE7D220D7C18CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Feb 28, 2025 at 06:15:32AM +0000, Tian, Kevin wrote:

> scenarios. Probably good for prototype development but no
> real value given it loses all perf benefit from ATS or even worse
> perf compared to no ats due to double walking.

ARM's docs noted they expect about the same IO performance between #3
and #4 methods. Both are walking tables to validate the TA. The main
value of ATS here is not for performance but it supports a non-present
result.

So I thik given the choice we should prefer #3 over #4.

You must switch to #4 for CXL/etc/etc.

Jason
