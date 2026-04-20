Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BAF17DE36
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776725782; cv=none; b=IssaNx7Eu6gU7cg0g9pxd3bhwpJczRU4KO7dNoV7ZarL79mpcOsYhsS/buDTa5R0q70NBVD3q3m4TgUCCpOXHpPnVNy0DP5cmfTzkB+aRC4OiOJLFrMUArN1nos8oleINpItXRNuyFriQ+05HJGGzXi8WPhUHIc21aAjmWwXaTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776725782; c=relaxed/simple;
	bh=HxETj+r6/c62h5v/ZQo9q8wwwtXio08jZSnj3FSr8os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9+iEyngu2ovbIqP1uno4ZgP+qLks5Yrqe0eUGejBYjhWb6WV0Ink4GatQims5BlKXxh9CRyHu5XtWxhgIj9QLdHX/Z4XS/w0uisZYEVL7R9blJFpmT4z7NxnCceTVEIn0gzl7/LznCeiD/JffrklbdlIZh+JUncyhK5UzHM8S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=O5FrTZ38; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="O5FrTZ38"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-479e7e88fb5so417767b6e.3
        for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 15:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776725780; x=1777330580; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HxETj+r6/c62h5v/ZQo9q8wwwtXio08jZSnj3FSr8os=;
        b=O5FrTZ38+NLyLVgQ6BReXKWlDNJ3yYl1qEZyl4cb3pQR2BqUiSzOoCS84yTzF6FMdc
         dOtlXXkMFstZmzOXh36il2wOFHt/lapcVXSe84Fg5iSLZz3o9obvy7mf0dWILOTliux1
         ilo5//1fF9edHY3w5ibRG4Cz6AxM5XPgv1+UI44fTk4HiX8yB++JofeAdsdqe8Ia9CN6
         exW7WpbJm5BSpUdv73v3RHSIx4frEPE/fYml+Oq9TZK5nt+TaM+T3rwTCH1SVgYBJexW
         u81u7nzzPZeRibk/3E9XgDUs4DZAL2tl8OjZfbRFkJeXtz+pKZgTINap05DQJ50HhSUH
         9/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776725780; x=1777330580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxETj+r6/c62h5v/ZQo9q8wwwtXio08jZSnj3FSr8os=;
        b=as7bat1HrhfSK+Qnu1Njwwkwz582vWWpOKZsnxwAwkOZSxRzZCqUq5/VulalXg4wrP
         GVRZBMIfHADPQWbdwtTKuMDgEym9+YJOl6IvZLUhcoAMPm0bTy2FA+bK7ykjwyNqxkXu
         o0hv8CFchTyDkRW5wwXtBhgLk9D8clrWOrzToygs+d8TwTKgk92nVhRJi4k/ozPDIzKP
         b6+0iLi+xVeglwOK+FN/bJWN8c5xA+6vNH71XGNimN/HKAFVdpnWvs9mApDfMMwXeF8a
         fvuyBGCiek/F5jQZW1l4CU4PT8KwTDgpTVhsW05gDben42Rv1lcB2n8WZyTbhqKEwdrs
         ecsg==
X-Forwarded-Encrypted: i=1; AFNElJ9FV9t/qEmtZo15NtSifL/QGrN6FIFriOF7CTri61fWtQzQv3AfFOh8Sx3TFIWsck/w/nQBYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YztT5/8d7PIEd6yU4hsioQaQiGa417ELA886lKM1tOfAq8bF7+k
	SIlhXJIgYtyiOSWPDiwPTlmYUuWbSs9qOLUhQcicDnNaXRI5USoU3L58BuMOkGuwnxk=
X-Gm-Gg: AeBDietb8uXZpDTPawbE0P6NS3qEQy8KmK9h3vN1wUbAUfZ0YzvbKCns/qbRaeEMpIk
	WueZRJIVsYz7kFOBEW5rjY/dwBWtvyPlDarxOmujl+N3Ma7ju2h9CfKWhXxScXD0iyz9fa9CxBZ
	SbZMC+uLh8eo9T91BDmlv4ZX4rJDvyy99k+JEzQGWcUKFJT6v6sMEIpEFrR/KdVRDcBAWWJ8WJM
	7W+L178zZrZvSG2Pwdw8O3j8ngScTJX7jhiHmT/FhmWzR+rfYEz8o/8iopUtcG0gXiUYKFwoN0/
	D1k89EgqX4q6ivvNa0I6yLbm5ZPOolHYXyNxEURfGcDP+iVOvpgjtiTegPD/PjN+A+vyEClDMeM
	69bneNqBVv2iroL9gg5XsPCeQoq72GiLEsMC8G4gN9Z7rQ3/R7FoshCL0SHZRomtGVo+JQe2BfC
	kNtIQYtPiL
X-Received: by 2002:a05:6808:448a:b0:479:d2d3:a399 with SMTP id 5614622812f47-479d2d3bdb0mr3331712b6e.15.1776725780355;
        Mon, 20 Apr 2026 15:56:20 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4799fc19273sm7702863b6e.0.2026.04.20.15.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 15:56:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wExXO-0000000F7qQ-3pLG;
	Mon, 20 Apr 2026 19:56:18 -0300
Date: Mon, 20 Apr 2026 19:56:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	ekansh.gupta@oss.qualcomm.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Srinivas Kandagatla <srini@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bharath Kumar <quic_bkumar@quicinc.com>,
	Chenna Kesava Raju <quic_chennak@quicinc.com>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Subject: Re: [PATCH 1/3] drivers: base: Add generic context device bus
Message-ID: <20260420225618.GP2577880@ziepe.ca>
References: <20260414-computebus-v1-0-4d904d40926a@oss.qualcomm.com>
 <20260414-computebus-v1-1-4d904d40926a@oss.qualcomm.com>
 <2026041418-volley-composer-6363@gregkh>
 <c4f21420-c299-f161-2bf7-c9b79ca15037@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4f21420-c299-f161-2bf7-c9b79ca15037@oss.qualcomm.com>

On Wed, Apr 15, 2026 at 11:04:26PM +0530, Vishnu Reddy wrote:
> Looks like the device have specific iommu configuration (via
> of_dma_configure()), then using the auxbus or faux bus types does not have
> the bus notifier calls to iommu_release_device(). Please correct me if I
> misunderstood?

I think the general feeling is the open coding of_dma_configure()
calls in host1x are not desirable, it should only ever be called from
bus code.

If you need to create struct device instances bound to the iommu
somehow this needs to be much robustly designed than wrappering the
host1x stuff in a new bus.

Jason
