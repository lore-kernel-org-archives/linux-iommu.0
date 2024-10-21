Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0101CF7C2
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 06:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729492438; cv=none; b=jUnYWie3y0vcgHxDZCKEtbj45XCfyoV8i9cd6S11bezH/BlghrGDGKlliHFuUn/qJmMTZSUOgvkGRXF4TMbv0KQVDJoI5Bgb5s1/MYlmNy0bE0nIlMBI6L215KVZ0btNsNOC0cFsQxIIPSKhm1OVRyE3FyU/KC/iQ29ewt0Dxho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729492438; c=relaxed/simple;
	bh=VnZhfURSf4/s6FkF55ibqKGNKXCrW2VXSwrYWAdIqF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuhhUzJNbu9LIkCkBCd+bPX4jCbkWtIyqqI/ak6fbOMtKdY8whaZws1rKz/n7kKbvOgwVQXm6k1cu6xQBsHwJzS1bF50flO9ajJdLXFoJSXOgykqi/D8IG6c5fE1kyfd3W9J5BrTg4SCv6YMSj76YRJ8RNhwurc98d15mhk9WEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2MRLtpJb; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2MRLtpJb"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a3b3f4b599so862605ab.0
        for <iommu@lists.linux.dev>; Sun, 20 Oct 2024 23:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729492435; x=1730097235; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IYlKczC1/dyP+HrKUMxFfRQJnXk8La51dM2ObUf2XbU=;
        b=2MRLtpJbab8shwR6UR/JPd7DLIpEPvYJ/dbrsC4zD0CrQ9+ke/1gSHjnslBfFU0Joj
         cHhzxBC1cWWWrGVDgbPKfSbwsPHKW+5zSvajjv1SfTvQUrqWo5hT2/CVbBQWU00+fy1D
         7QfOz5LV8nb4bXY53n+glc9BC2mRS+Ve9ZWLkbtBybQ7lfqz9cU4eLJXo5wnC0k/AeMs
         f5MdpNDW9qNG9AARopt4VJee0PnhuQy4vJPHS4MCTxxX+i3Gcl5lZax8uJVvCjroL1zq
         Wse7Zst5Kab+5cuis2c1rW2+i0kexUwBpTN7gRZ3rm7Dmo4nPMiGBvNWqvgli96cut4w
         hO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729492435; x=1730097235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYlKczC1/dyP+HrKUMxFfRQJnXk8La51dM2ObUf2XbU=;
        b=RFZ2ji5JDCuzVJG4TsGUodji4AlpZUnnyLm0BFrPYPRq0tMuQe1wf96iXZKWVaAOlq
         xai7/x8/UIRNrH8iFbCqcJ6We0iCYyJiHIxhY+9gfCSfc7tDKrjB30d/eU4qVJjaJ4YP
         fRiXIGJA7vpw2oe+Ch0mB5xWLYvqCmH23IDkDTEoRiZ1tS6V5X8mf5AUQeL3KGdrtLng
         Mh4RFZ93LBof5adYnhGj72d/MMLns3rh8KEVpxMSQDmtN/5C59g5k4Zb/Q+mWtleaMKG
         8tTvHqWilqTriEzdJI2pFDD+SLr9XE5T3g9ActemlltPNSEloalGKH03QvpsyKgiJy8S
         ar6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW68lDDfl2nabQtcVPjFC1SC1cBER3NoBgXK+HLlOlEDMvwAxW/c1SNUdRE2bx1rAN+jAyeDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwECSZFik0yNuWGN4d8+PrZ44GzBum1KPagIxuDBvYmmBsSzNs
	T118MLwkGHSL/GbIegfaiYBoLgyMRlJVTL0CWBqQ4x5cGM2Zc5poZ1z/Nv9ANA==
X-Google-Smtp-Source: AGHT+IGi1lYdH/OaSnqAjT4EAhNryurUPEYBHWZSYLb2MXdzP4cvhvgTRyKNN0s+j0nEIHEZjRHr2A==
X-Received: by 2002:a05:6e02:12c5:b0:3a0:a3cd:f23d with SMTP id e9e14a558f8ab-3a3fa383ca2mr7402425ab.5.1729492435267;
        Sun, 20 Oct 2024 23:33:55 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f3318sm18935345ad.251.2024.10.20.23.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 23:33:54 -0700 (PDT)
Date: Mon, 21 Oct 2024 06:33:47 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 0/3] iommu/arm-smmu-v3: Parse out event records
Message-ID: <ZxX1yxNBujmtYGL-@google.com>
References: <20241018180022.807928-1-praan@google.com>
 <ZxMPVdRQzt//LBqG@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxMPVdRQzt//LBqG@Asurada-Nvidia>

On Fri, Oct 18, 2024 at 06:45:57PM -0700, Nicolin Chen wrote:
> On Fri, Oct 18, 2024 at 06:00:19PM +0000, Pranjal Shrivastava wrote:
>  
> > As requested by Nicolin, some sample logs powered by QEMU:
> > 
> > [   85.410290] arm-smmu-v3 arm-smmu-v3.0.auto: Unexpected event received: F_PERMISSION
> > [   85.410290]  master: 0000:00:01.0 sid: 0x00000008.0x00000
> 
> Thanks!
> 
> Should we print "sid.ssid:" v.s. "sid:"?

Ack. I like the idea. Btw, a sample of the longest log would be:

[   85.410290] arm-smmu-v3 arm-smmu-v3.0.auto: Unexpected event received: F_PERMISSION
[   85.410290]  master: 0000:00:01.0 sid.ssid: 0x00000008.0x00000
[   85.410290]  iova = 0xffffc0d0 ipa = 0x0
[   85.410290]  Unpriv | Data | Write | S2 | Stage 1 translation table fetch | TTD Write
[   85.410290]  STAG = 0x0 Stall = 0x0

(Note: I've hacked something manually to print the longest strings)

> 
> Nicolin

Thanks,
Pranjal
