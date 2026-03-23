Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118A03AE18C
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274058; cv=none; b=e+2VhPNxfB33t3Mq8UPNgBCjDNnPmItHS9uu8nSuoDu0JN350lGA9/toZmLRjQwadisuIUNQgh39SqccDVX9VnJjkkX4fBOdckRcXAcyeEheO+iMxW3jVa+2prYcqp0eezWeUiQwqejte1jE6+S48BYdCzaRcqmBZa+mVgV377E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274058; c=relaxed/simple;
	bh=j8+NLnpYEVro6v3X3zB3ByVB1aVEdc+kKTmLiXnpYfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEPKX/4X+Ls3LKyByiK76Z72XPBet3/1rrC6g/2PpQTY+NlFnD4uJBN2vAmseUZp9MY7pasbQpy/ohjyiz47LUwNtH2x6wGOZhIGI5hxsGIHrOhK1k+YTV7aEXrE34xcCToA8QzJY2yCWVvVEle0Sdp2a7u87qnl2VZfakufJrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Br4mWQIq; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Br4mWQIq"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cfbfdabf3fso14549985a.3
        for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 06:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774274056; x=1774878856; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cp9nHZf7NvuTaD3ZnAARZsLypmpLx61M2YmeLJUPLk8=;
        b=Br4mWQIqAvFnsI9MxeClgif0mm10EIJc8EMYbFZ0+7A8/6pFtI5Yqhe9ZYg6duv4m0
         SesVcq28IeoMBuBvNE99CYZcKCXptt9pEHRqh/eMRrcv9RqHFF/C6kaHakD0NVqDyxuF
         FNw1zWO5govc8J9gNDpSsm3wqDpMiDI2Ef3qwApN0AFTojYGcdMaQoBHj9R7M+fHGAIU
         5d9Zq3/3zx99ITNS+3fRWu3UXV4F+9gKKR982K0p5CozCgJNHbb+izU37PxVYBb7hNQ5
         a4YEkkAM4Fa10m1j2TCNdvaloYGyEJ38sL1zicuwYKpWcTl/2pjGUW0qf/v2lzuPSWjh
         cyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774274056; x=1774878856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cp9nHZf7NvuTaD3ZnAARZsLypmpLx61M2YmeLJUPLk8=;
        b=a+U+cRd6u1/JpwTvWXp6OXY1k/zo1YeBh2W+MfAsmRgLiJrL2eCqeiy9Hby0FmStIu
         wj9uQ5vmAMaEPTE5jkOQUv6BEnQ8g+GolSoMWOqzxIp/K/qW+YYeh9qMCIwEDtX7mFiK
         8ToZih3ks5REd78hkrCpJS+/LcCrBFB82rGElmM4w2bKQUVdwtoZwrdkmKJtk2w9/56n
         E8qte2fFTYPQKMwzSd6H5oUhEFYPTnZfuDG2NxXwL6ML7pdL9tzv2izw2/J/yfYglixj
         SwtdjYRCbhPEAGCp/CM91cFDgAq2rVUHkk0xexoNOonTyLfm6hHtdOiFt7qBbe5nd6+x
         sbOA==
X-Forwarded-Encrypted: i=1; AJvYcCU8kaKaq4K22wepixWy2C4hc6+YmPdbzMwbuHdZR0fB0KpYXKaEGGkrDnySIG0A13uWu5UNdg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDdwrO2q4DlQNyKF9bz5aH92mJGuq+yE+FeT2V5LGuPK7ynO3v
	PyDfjKFLJo55/NHQC1DHrrsJNJFW0ST05Ammi0AcH/pCYOr5+dWyz4AEI1LmMqKAU/w=
X-Gm-Gg: ATEYQzwSdjGpLEEj1GJothAcEq46EawgumtiIowh2o5VWz1p6Ii/962TatS8fbpa8oF
	DiQEbdgEhb+yJq4KKWil8DiT+sgfVwc7tt3tKRCGtsj3sicOAXPHF9ead6DYlB5lyMh+f99ZZgd
	qU8/wPD9kLnFySl1+RQy9iLus+jEoaVm5llJGnYFewYIYhkvQZNKwScIlWOGmsSoRjCAU2piZpm
	+tLh1uqX+PviuOEjur6orNR2dly0Ei1Zu54kEuPPId4lJNE48GhGKrdXz/tdij8EvB6z2r1N2Gp
	81b+8QstymIElbzlG9moQSoZ99tozPeKBdIsfNAfzcpVTzpqe7o/909p0fabPBrLVoGeYX1UO/Z
	u3L39iiNTTmUzxTMqQzGf48unbX7bsQOVRhcCzBFfls/y5hSGFJ2016R/35XGMNFZqC9U/QAnmc
	+p1uHOrZovPWw8EpI8jr7woIdzl7FxMnSauuvAUKIX7guQZW7DScrD/oBTPYjitNm66enWnQ==
X-Received: by 2002:ac8:5cc7:0:b0:509:2ef7:704c with SMTP id d75a77b69052e-50b375d5d24mr169439891cf.72.1774274055870;
        Mon, 23 Mar 2026 06:54:15 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c8534f9ccsm89564136d6.39.2026.03.23.06.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 06:54:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w4fjS-000000004Z9-0f4n;
	Mon, 23 Mar 2026 10:54:14 -0300
Date: Mon, 23 Mar 2026 10:54:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Joerg Roedel <jroedel@suse.de>, Bjorn Helgaas <bhelgaas@google.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	peter.griffin@linaro.org, andre.draszik@linaro.org,
	willmcvicker@google.com, jyescas@google.com,
	kernel-team@android.com, stable@vger.kernel.org
Subject: Re: [PATCH] iommu: Fix bypass of IOMMU readiness check for
 multi-IOMMU devices
Message-ID: <20260323135414.GA8437@ziepe.ca>
References: <20260323-iommu-ready-check-v1-1-5f6fef8f9f59@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-iommu-ready-check-v1-1-5f6fef8f9f59@linaro.org>

On Mon, Mar 23, 2026 at 01:09:27PM +0000, Tudor Ambarus wrote:
> Commit da33e87bd2bf ("iommu: Handle yet another race around
> registration") introduced a readiness check in `iommu_fwspec_init()` to
> prevent client drivers from configuring their IOMMUs before
> `bus_iommu_probe()` has completed.
> 
> To optimize the replay path, the readiness check was conditionally
> gated behind `!dev->iommu`:
>     if (!dev->iommu && !READ_ONCE(iommu->ready))
>         return -EPROBE_DEFER;
> 
> However, this assumption breaks down for devices that map to multiple
> IOMMU instances.

?? We don't directly support "multiple IOMMU instances". There is only
one dev->iommu.

AFAIK if some drivers need to support multiple different instances of
the same IOMMU driver they must deal with this fully internally and
present to the core a "single instance" view.

So, your explanation doesn't make sense to me. If dev->iommu is set
then the driver must be ready, including any multi-instances it has.

If it is not ready then this is really an iommu driver bug, not a core
bug?

Jason
