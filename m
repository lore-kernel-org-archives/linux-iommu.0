Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C3C33CEA9
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719661; cv=none; b=Jwza8GmS2pxTLf7rfq2ccQ6B2Nonr4bB577rOwmXNVyoia2hSH2wDIFRL3MJzBqYaFrl76V9DOW5hDTAEroaXnps4S8jnxfhZd7Iy03ZNKn6DzEh28r4iDTYu1FwUUX5gTl6GyIDJxfBPWle2fwNc6azpahpoN7AzlGXp/oXCEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719661; c=relaxed/simple;
	bh=e4T35VNlQjT4yqGwiGvGk0dwu/9CLYOxKafixrrvTew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVisaVhoBdEcIv5AQv2ZtpaQJ6nE5XsNARRtl0IIwZlYtdz49xKGUgAfC09tmARH80ljmGFK42QAzLeKQFKYo7mKbImo2nJM6pQLWRbfllaB6Pu9CzrdjhKjLDAXWWO2HPW6IVSJ9n4NjU7/3s5UFkOhqbiNo+tePBOrDqnDUDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MfTKWUJp; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MfTKWUJp"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7a72874af1so231296266b.3
        for <iommu@lists.linux.dev>; Tue, 06 Jan 2026 09:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767719658; x=1768324458; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WXlvJG9FK5UUD3fcZ9qJ2guvXJiAhk3kEUMV4nJofUY=;
        b=MfTKWUJpch2zyDfGjX8cstp92uLYSjhTOkEh3oY+5gJcyIEV8Nn/Njgvo+sRv3+29G
         WjYBea6PZYNz+kslCqLeKUZL3E2FC4FX4uWEE8NWx+OQFrZCr3wQxmPVSMKS3YADsSpH
         keiInUSc6hHu6aB7shRkJLyWYDNCUzZy9mtbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767719658; x=1768324458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXlvJG9FK5UUD3fcZ9qJ2guvXJiAhk3kEUMV4nJofUY=;
        b=OcQkRTLk5TTBOMLN6A6DQVvd0jagkshw9b4g4VG+TRUGv6JUZg/EJ7B3QLXJNdArPy
         x4Y0VjYVywY5GUBwCSCgLU0jY6J9+ohiwgZGLW5kWUNtWgYnsclbwge1347NL5buDIMm
         RKKVx+Runve6hYzHlWd5nM61LewTlpfwBU07diCGG8Fhf8WtcRpANh3mBOjJnlA6hzIo
         kEoqL3dJhpQvDXtlMz8QjRGG3jtXUsY/V+EM4iRop5xQt/Ky1edOxznUje8WhXtJiSTF
         I9C3u/vKPxauZczVj+ex0Lu22ABq5XZ63nVBzw/1gIxH/MtrfNCGwCGGJxE2EaeL8YRP
         htPg==
X-Forwarded-Encrypted: i=1; AJvYcCXg28sM0aTK34+A3Ja/uL+zZGdjzCDu6OBazpaDj48Y/mDH59wTacfs6T1XSIk8mtyWRnbgfA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSvs5XB8rq+xP1sTwsrkEijxrJ9f8jd2tS8RCfUXb0saQ7VacJ
	hEbL+I/c7YoxJXEbq19C36xGrykJMqvfiNHZkfhxnkn4/H5HY4NLO70kRiyuKWQhZA==
X-Gm-Gg: AY/fxX7vOqGAotshsuRLzK6PCyKVjP+sqcSpJpx9Vo4ytw2RqntusFaTf9LkZvBAiu+
	qZd78sh9fqSnqJKrOwixFeLj9PY5Gn1iscLHci8LKkUfq7R8OppLRrXiKhFY+Cr5qSA9Fr0rzYR
	p1EFNQeS9IqV3NmDQ/hyhi2gR6ao0Hlf5cKHGO9oPxs0DJUo6VsKfJQiuyo0yt2rEo3dnkLTcrb
	E2nKc2Jm4CRBUPA6LuVwy50gy3NupU9y44hjN5XbU+Dqs7eA5saSsuUkQ8KTvUro0j60qbnO8kq
	vcUpFSAFZWOPqAtGsn7SUBpV+EKNs133FnIE+UdDE1jcdVo0D3s9llkg2tZKmfg9V2uGGaCZxZ2
	PoTEi39MvMThN3JGGDch+YmHxk3OfWzTYQrHd1MhNxIsLTmlAdS1HUCHXr7l69p5BCDtqUEr8Ne
	hVc0SrDvDxzsLODxIsD72B
X-Google-Smtp-Source: AGHT+IE722evihuuwUcy6Q4PwCANc2+jPlRhxHzW5JOblV3Ggq8Yl4BedgAWZgXFlOOAVc6DpgPqcw==
X-Received: by 2002:a17:907:980e:b0:b72:d001:7653 with SMTP id a640c23a62f3a-b8426c5f9demr391134866b.19.1767719658324;
        Tue, 06 Jan 2026 09:14:18 -0800 (PST)
Received: from mitya-t14-2025 ([2a02:a31b:20c3:6680:43e9:5120:2208:3239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a27c0bfsm279941566b.22.2026.01.06.09.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 09:14:17 -0800 (PST)
Date: Tue, 6 Jan 2026 18:14:14 +0100
From: Dmytro Maluka <dmaluka@chromium.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH v2 0/5] iommu/vt-d: Ensure memory ordering in context &
 root entry updates
Message-ID: <aV1C5tG_SRMe1yvL@mitya-t14-2025>
References: <20251227175728.4358-1-dmaluka@chromium.org>
 <20260105181200.GH125261@ziepe.ca>
 <aVwI_SHHGPl0xndu@google.com>
 <20260105191410.GJ125261@ziepe.ca>
 <aVwZkFQ-iQ7OHMi2@google.com>
 <20260106001418.GK125261@ziepe.ca>
 <aV0TalseaDGW-1Jp@mitya-t14-2025>
 <20260106142301.GS125261@ziepe.ca>
 <aV0vM9ad-4QhCNaA@mitya-t14-2025>
 <20260106164518.GA340082@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106164518.GA340082@ziepe.ca>

On Tue, Jan 06, 2026 at 12:45:18PM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 06, 2026 at 04:50:11PM +0100, Dmytro Maluka wrote:
> > So we'd better make sure that if it happens before the barrier (i.e.
> > when the device is not supposed to do DMA), the compiler (and thus
> > the CPU) doesn't set the present bit, so it stays non-present, so
> > the IOMMU will block this unexpected/malicious DMA?
> 
> It is true that any write to the dword containing the present bit
> (only!) should probably use WRITE_ONCE.

Yeah, I agree that for other dwords within an entry it isn't necessary.

So, when it comes to the actual code, it's not like the Intel IOMMU
driver has lots of WRITE_ONCE spread all over the code. It's only in
pasid_set_bits() and pasid_clear_entry(). Though, since pasid_set_bits()
is used for setting any bits, as a result, WRITE_ONCE is also done for
dwords that don't need it, but that doesn't hurt either.
