Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119212;
	b=AUUVO+Kj/7FK5DDHFRa2R0tqcC/06kyRQ9U1sGEKWERKEmLa5wQrwiRe6XnH6tM3s6Ry
	 5v+moe+f3hl9AH0w3pZNxT9QqvkeCBibc2+sH3zoOqP6tf0ssJWS9D+kZSl2YwspK+eNB
	 NM6n/8dyfQp0oJ3KQpWQf9fdYNI/Ii7AqRGP1w1GkQECW7a0rHFuZ0tMjKJHdfnZRAeSo
	 tsCnRjBxhY5j5JnvusKiNgG1NixWW6fNa3kEthIX0GGUx0LrRAqMA/vPUBQxe8UxrwjGr
	 e0pWjA/PojlFS5M+LxRe0gwlgx+RyzrtWha885Lh3gbPX+JnN9XBDVx3LlQl/ESlbsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=gbXuStreYRF1M4k9Su5zd2++RJBOLVmoBCN1Uwl3TZ0=;
	b=kNspUm3kDE1LidSmzVqvavlzAGuNaDtIA1ErcPwKpd1vbQpy70/IpuR/e1fzb71C5I5x
	 7DLmzlyqvLPZkxNstzSKNMBCfIJkXBsw1Ijutev3sl7bjqHgWfBPQBDXd9LKJBFbRRUdT
	 U12Kl+9S3AxmNyv9NfaYVc8iy2eD+I341fL7ar+ezjT8k2gdldrbTyqYujrZFCzN0T/A0
	 dQSHWy9WQK/weMohnze/CF+1AW2ipBgG8WiYBMKJeCB5guqUGfkyScmazus0gR6pvbPgl
	 7eZrJZfZXuN1/VuLEg/m0Cmb2g++ysWix92XwddptdWlJX4jr1e2igsQvyYluyDHjbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=Xv1IGTwO;
	arc=none smtp.remote-ip=209.85.222.48
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B044606A31A
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 16:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B044606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=Xv1IGTwO
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9905d61449cso57364241.0
        for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 09:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793119206; x=1793724006; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gbXuStreYRF1M4k9Su5zd2++RJBOLVmoBCN1Uwl3TZ0=;
        b=Xv1IGTwOx7zDwjKN0Wy7F7V5RdbA0N+BOGqKP/NJmwX5gM8EOIWB7aErIjEP3fH8aj
         gT0e6ZKlSaD46GhyDDJV9sI0sxFx5OdIxdJtM/oTBQfWyBXOofMMgky0usJQ1jtyrpZM
         Nzkhid2r2UxX6RR7OTxRRpF6CZzM6ldAXQI0Oq04SGTSojU4AwkfncIYuzFYm9JLR11y
         OLJR4Kx18gUvW1/C3RIL6TFY6IgiUDaABWl4ay/5F80k630RpiAVR0vQiBg0uUi7WABY
         JcZZRW1QhGoSK1WVEzj1wbDLuvWlhfm+wWhuHTQEOo/YZoy5NwqlsIFS0h+to5mKPER7
         Qrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119206; x=1793724006;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gbXuStreYRF1M4k9Su5zd2++RJBOLVmoBCN1Uwl3TZ0=;
        b=vUO7g+qpt7nHYUQspel46A05qde9GCA0JD3Ob9RO1o70Zv9Ij7KJqvO82LoMeOmBHK
         gbeB41468v8Y3riTil7D6M4Xm+XU24Fk/M9JR9UnVZLssyJldO5wFc6ruDeXNV1tu6Ad
         F2ucL6eCRdmaUGrBCdeLJT4HIeCH/mlii57CRFc3n3NuITjzT+CRh0Q9x/RDYGTanqkW
         e5jNY1xdp3b9QiRnbv6Em8jujTdFOZcUdv59FVOuf9zRW2yYMsWL/voAcjl0aFUXkx27
         CSMxasMZFArbynWIhkSYEv6xakoi4URfLoDXM1XQ6xLc+fJwN1X4ilSWXenM4yUaWA0f
         NYgg==
X-Forwarded-Encrypted: i=1; AKwUvBzj4xxdFpcgOb9hacEDko9HDbvA8HYBP3xpXaMsHk/sRJ2WN2DD87J3IPf5ppo+2GcwVF1Z3Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYKo9bztFuJ6xMda+au2wjQZkrIDTmwjrebv72M5zXXK0oXAPtGP
	k6XVx/8HPqljK9mMXle+MeijTjBAI0szZdvT0AvaBE5buaEJX3cp03f695aAWCh4mYg=
X-Gm-Gg: AYBFou3m186h9toTcqQiGXmJRPl9Bij8+l7kfvHIsykf8KJ2wms+AWwSACiPblS2BmL
	bncO+F2mo2R7VE75jBZvMfmPjhrDkhJJxs9I4o+tx6adiyGiCMaoyI2FgZin7He8lQ4ILsLv2IQ
	K8OkZP5psZkyZLNSrA4M8bNGqg1BCPww9OYSJzYultfwt9hnMovlvfwL79E3rzN3xK3J8Nngvem
	XJIfBh4U1/MV/GGW6g1GcDNvjveUc0aI7+qSe/oy+rTSrulj4eAP8tYsO4KYdNtfm8dyB1km/9n
	ssoK4//4Q4RQHWXkF8V0OeW1rWitsHxMD9V41xOZEzJdWpTgv/T1DMyW7STd8Glfy+QpGu5rVHk
	g8/fdQVOGx5jwc7zfEsR+ceV4GI8IQZoLNmEvo+vAPFlNglj+CXrRl5JRVdBoI3MPy0DCmx84QS
	IWXj6nHcN2wz/zegvN4qSqTnyXoZYitFskIvy5fKdYCIOsq6WqIXqqB0zZbVcQ5TFiLeg034Yfl
	v4ueWtbfHgcDN/ztNnT0xD20OiuraxjzYa147vrLLKYv67FuN3FMGBFSQDgu1GtMw9QVALVC6GY
	RxZiVqr3QXu/Eqfd8tZGVgVvDGQsZXn9AZUn5GxxCUgavdy1kPG0sraiovfKDcgZw5Ro8m14Wpr
	FI0quuTcOws3MPK1yq0NFkPfkUpeXqUSZi1jqkI3Op9hj/TP+6AA=
X-Received: by 2002:a05:6102:5048:b0:7bf:74c1:b606 with SMTP id ada2fe7eead31-7ce5ce4227dmr3243460137.34.1793119205875;
        Tue, 27 Oct 2026 09:40:05 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9912da2d9d1sm442866241.7.2026.10.27.09.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:40:05 -0700 (PDT)
Date: Tue, 27 Oct 2026 12:40:04 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>,
	joro@8bytes.org, Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <auDT5MjXYq3lcQjE@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-4-tarunsahu@google.com>
 <atlQ_Er0Ig7CCSxv@google.com>
 <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
 <9huzzew0el59.fsf@tarunix.c.googlers.com>
 <at_CncIPYCxOVkLo@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <at_CncIPYCxOVkLo@google.com>

On 10-26 21:14, David Matlack wrote:
> On 2026-10-26 11:50 AM, tarunsahu@google.com wrote:
> > Right, Required bit should be source kernel payload property to tell
> > target kernel that the payload must be handled to correctly deserialize
> > the data. It should be source kernel (userspace) responsiblity to make
> > sure it understand the target kernel before doing liveupdate.
> > 
> > Saying this, During deserialization, target kernel's required bit is not
> > necessary. So I propose the following truth table.
> > 
> > Source hdr  Target supported[i]  Action
> > ----------  -------------------  ----------------------------------
> > 00          0 or 1               Accept: feature absent in payload
> > 01          0                    Accept: ignore the feature data
> > 01          1                    Accept: use the feature data
> > 11          0                    Reject: -EOPNOTSUPP
> > 11          1                    Accept: use the feature data
> > 10          0 or 1               Reject: -EINVAL (invalid encoding)
> 
> Yes, this matches what I had in mind for the semantics.
> 
> To be explicit: the source kernel should set the bits for each Live
> Update based on what is actually preserved, rather than generating the
> header from a static per-kernel array. E.g. memfd would only mark a
> feature present for memfds that actually use it. That's what allows
> rollback to an older kernel as long as nothing being preserved depends
> on the new feature.
> 
> But looking at this again, I think the required bit is redundant. Whether
> a feature can be safely ignored is a property of the feature itself, not
> of any particular file. Every file that has a feature present will have
> the same required bit for it. The only thing that actually varies per
> file is whether the feature is present.
> 
> The required bit still has to be conveyed to the target somehow, since
> the kernel that needs it is the one that doesn't know about the feature.
> But it can be conveyed by the feature's number rather than an extra bit:
> split the flag space into required features and optional features, and
> assign each feature to one of them when it is defined. This is similar
> to the required_flags and optional_flags approach in struct pci_ser [1].
> 
> Keeping the same header shape as discussed with Pasha:
> 
> struct kho_ser_hdr {
>     __u32 size;           /* Size of header + payload in bytes */
>     __u16 nr_required;    /* Number of required feature bits */
>     __u16 nr_optional;    /* Number of optional feature bits */
>     __u64 flags[];        /* Required bits, followed by optional bits */
> };
> 
> Required feature N is bit N of flags[], and optional feature N is bit
> nr_required + N (using nr_required from the incoming header). The length
> of flags[] is DIV_ROUND_UP(nr_required + nr_optional, 64). Both spaces
> are numbered contiguously, so there are no gaps, and up to 64 features
> still fit in a 16-byte header.
> 
> Each bit just means the feature is present, so the truth table becomes:
> 
> Source bit       Target supports  Action
> ---------------  ---------------  ------------------------------
> Not set          -                Accept: feature absent
> Optional set     No               Accept: ignore the feature data
> Optional set     Yes              Accept: use the feature data
> Required set     No               Reject: -EOPNOTSUPP
> Required set     Yes              Accept: use the feature data
> 

I like this proposal. I bet most features are going to be either 
optional or required, and even if we ever have a magical 
sometimes-optional feature, it can have its own required flag. So, no 
need to pay double the cost on every flag.

Just need to make sure that optional features always start from 0, in 
their own enum, so the offset can be computed correctly in the incoming 
kernel.

Pasha
