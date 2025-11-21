Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB243299950
	for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 23:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763768155; cv=none; b=gj9FxzVB2/bkhKLSQuF0AaYO0w9F2m6tyLDeBTWjbMuvgYVgvUYPA0467L8WePIkLT/q7Y1woULLgO3D/lFsG15lHQVNYCB0Cn1IZ8zOqnX+WpbWmRaXmoEmq4VpynAXFV/asZG2G4nieRtxjGoDxNsE+W+QKhhF4BJCxpp8308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763768155; c=relaxed/simple;
	bh=ZIKkMjQ5byam2kBpHOWaWCeEfS0EnddLlBVtwgj/LaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0G00SY4cmnJ7lgiSfCXJUzr5Y+nB3IX+RFAlQH7B4XMNJV1MDxpE9LPXYtylQtO5FAqTD91NJAXetv/OMgHnD0hC73gRe5lBZmNjT5W4hxX+rSCPhZ/Bcfadr2sCugLSLd91RW8+3UPQm3nuvtdOMNgsVePVtr4yeHugmHMZYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JXAwlEGR; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JXAwlEGR"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ee1879e6d9so30444991cf.1
        for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 15:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763768147; x=1764372947; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JbW3/sONqxixSsA0BLfTyZim/TwfutVjhBk5sAO/3O4=;
        b=JXAwlEGRESGLFMfMA2XcRVTld9DCbqUeDAk1iwDXPDeJxGxATppoGdGvJjZZ0RHJQi
         EPx2VHWerAB6y2KoAA73unymulE2t3WMVW3holyHM4cKwOy1Mv4dAB17IMMdEhuq1v8a
         I6D0oE6P9bVyF5IwahUObLA5Q8/6NjexrRcPO6r6czP2viwt3AzH+xrgz8x1xm65qYtN
         3Pj+uXWZ23eAiiQl/RcuS1VFwd6BrPtlsOErxLVqRLRb+CaCG1vJqjaeSkUWPNUxn8z6
         EsW0RkoKfYektyD3G+StXiMT+b7au0XDgI9XsiVeiTkU6dccFYW52NI4pTE37f0urEiw
         BrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763768147; x=1764372947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbW3/sONqxixSsA0BLfTyZim/TwfutVjhBk5sAO/3O4=;
        b=wFuQwYH5vN+seRjPnKsQm4B2iKHJcQqh5sjpeJ4ecAxHghwse65q3dq93UBWOb4uXT
         Z5Yq67lh1slAhFeZWfrR28jTL28f/2OLn8TmWwr7qCy9Gw/+GrNnXqXJA+AeCzH2k4FF
         T8B38dwrPUThlvfaiP3RCWvH7cqUjywrNZ6RRV7jfcmsrJHAUfC3Qrw2qeBIGIzqYLYS
         fg2hFZ8+pqKbkJhh4RP/fGkBmRJPhzA+pYQvgi37q9BBOg4zBetHd8twGeYnNn/ZFI0l
         mSnteV2hvEhj2RjlOBrnQupW6wj/D/Med4m+WwH92V8knh8A35rq9d0qitlDzmyYzLZu
         JBRg==
X-Forwarded-Encrypted: i=1; AJvYcCWn6n5QUJcBmVAJoG81jDPp2G5c3FIthoh7cZFel4Ee3nvlmCN96UT8JEDwVmu2wtnEWHlM/A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzop6KK+PZfaUaV9zQ1sNsrHJomUsfocx49BYXgZ5uQnmy+5er3
	hvV92YLm1JQuhxoIR8NVTGYULaouqucRUSmm3xQR93qHJhq+E/CHrOPlP5wCPfoUk84=
X-Gm-Gg: ASbGncsfps9KDNCCznEHXfujJ/+GSXir4Sl71qBb819SxSuq5vV9rltwYiw0HFTDXNu
	epQabxv/dQLanRI59d6cGRDGhSRJFpkPmJ/JhamEtwO5RCpGCZTuJ14/nLWPuxXELT88e0U3y3J
	BFRt3RgGDMwZVmKPpr0T++sjpTSjoAyhWsZuq2MR6+Sd0OI13nMh+m78uh15bJO7a0sbUfF7Ge1
	A7pU+umeKFal3bsVTqPeoEAu1LbqFiVzy223w2ZGMrE/ZaUEAoZ1cViMbjk42FXwb0W10rmJl/i
	V99SmxLLeIZrlyQbtMwa31RWU7soVeEkvhmwcoyVukfpr2OkAGdqGTp4bolKkZbVgtK8HgxjbU/
	HN5PisgYxbI7vBjHX2TgjIe8Ia3Bww3cgo4WSMQn32xugw6k089OGwqF5gXSoCZD5VDOhWSCv0o
	bOV+9OtmtnsbEp7JiMYKNkBv1ROcIXlto+1/6TqG/DSMfvML0COWcT7XVt
X-Google-Smtp-Source: AGHT+IHAgZb6cWOpFsRzOf05vRyMCQqUNUfh+Djg/nFpMJErQPOjCq7BzfzVrRR8QE9gGUyLmyT7qw==
X-Received: by 2002:a05:622a:4d:b0:4ed:68b:c73b with SMTP id d75a77b69052e-4ee58a7f137mr62412831cf.20.1763768146814;
        Fri, 21 Nov 2025 15:35:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e54c9d0sm47151386d6.26.2025.11.21.15.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 15:35:46 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vMafJ-00000001bdi-3fWH;
	Fri, 21 Nov 2025 19:35:45 -0400
Date: Fri, 21 Nov 2025 19:35:45 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, kevin.tian@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, vasant.hegde@amd.com
Subject: Re: [RFC PATCH] iommu/amd: Add control register in `struct
 iommu_hw_info_amd`
Message-ID: <20251121233545.GJ233636@ziepe.ca>
References: <20251029095846.4486-1-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029095846.4486-1-sarunkod@amd.com>

On Wed, Oct 29, 2025 at 03:28:46PM +0530, Sairaj Kodilkar wrote:
> When user does IOMMU_GET_HW_INFO ioctl, read the IOMMU control
> register (MMIO offset 0x0018) and return it as part of
> `struct iommu_hw_info_amd`.
> 
> Userspace can use this information to determine the features
> supported by the underlying host kernel.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> ---
> 
> The patch exposes the control register to the user space so that QEMU
> can determine the list of features enabled by the host IOMMU driver
> when there are passthrough devices. QEMU can use this information to
> selectively enable the guest feature. One example of such feature is
> enabling upto 2048 MSIs for passthrough devices. QEMU must not enable
> this feature for passthrough devices when host IOMMU driver has not
> enabled it.

Please document in the uapi header what bits are meaningful and
userspace can safely access..

You are OK that a 0 register means the kernel is old?

Jason
