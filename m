Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE7932A3C9
	for <iommu@lists.linux.dev>; Wed, 28 Jan 2026 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619054; cv=none; b=Bnz9fg57mrYroB6lDP+Ju7wa9xsbonU0zAsHgic2NRhqeHJSG0/TP2AX1IvI49DHJ2IS7fFTHRddFEGnIrQ4R9rrJulBnKz+xdTVzD0umKEXdyfDfLv/7+DHKI+xXylTLrSpccVyTCL34ZHFaK10uejEVMeEm4D+wodlAtb90iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619054; c=relaxed/simple;
	bh=g/j9LTlQfTH7KFaARxmuo2L1rFRpHk6DEaMjs+jPdW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Is3z2PUel/bwf87tSkzAJAT6QA5sSfjZK9cAE3lLCclVooZv56N9BXz7an1bgvOs2wi8qCWDhofqKUbbXoeLTo6lroF/WBVnSJv/qKpocCWhmJvS3HPkEEODJlr2qTaoB0TP3xgAk0E/xl++tStuc7ZMB90m17O3aEslEc2v8iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GAsgIoP9; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GAsgIoP9"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5014e1312c6so45203431cf.2
        for <iommu@lists.linux.dev>; Wed, 28 Jan 2026 08:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769619051; x=1770223851; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g/j9LTlQfTH7KFaARxmuo2L1rFRpHk6DEaMjs+jPdW0=;
        b=GAsgIoP9Q74pSoe8rIfTsKU9q0iTUQuuvGJI89VdTQVIV2I0f/q8tEgwztJzh99RGH
         O3qkSEkrNlzNshS6hAu+f+14lWCNdrty34cfeVXH+azLRqFPZVbzCCKXiXvfHWLyNzzz
         B4RZf2+937g0uEmLBVr0vqpho+kEe04y4al4maEIZGSckChT8x4wHjCoN1oJzOfONmLc
         /GfJoATGBJSWS7ngwCdmoPHiRkNgeml7H3G6LcZeSWr+0IKwJKF4sIvCc21cEfqDHu5R
         5+Rw9SIXTwSWmZ18FmYqpCoVGkNkUZD3tGlUi0So3QwbSSCwZlbitzW9FUKvsHxS1iPM
         b2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769619051; x=1770223851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/j9LTlQfTH7KFaARxmuo2L1rFRpHk6DEaMjs+jPdW0=;
        b=UMxawMuW/W0LjuX7R2Cp2wgahWDAfjh/ZS/wd3j4KmgpSZUk6tMrlvTN8TXfd3nAGZ
         uYkFDvnY20erPHPY2bxWHnMal4TpfhQcL+LVyF1XndXkOwZtjqSyAKd3zmsEuTR3ZeGp
         /7lzEBvwwvH8Tplkev5VUFBeQfw3kiG+36SPPPfhfl0W7vmaggpDNmXvYB8DEXuYgqY7
         MQjmksM1aL9nLCc1sVhlW3sBtQNEP0nx1bguCdMnj42AgWohM5cZfryutNHgVmgX4gzw
         Hi/VNMFCTqT80OKEHBL/S6TwLWEaR62uDP7CtVbLZ9uGStAMUuFVjAUhFWbqZmOIMw7Z
         dRvw==
X-Gm-Message-State: AOJu0YzHcYqciLqcSohvNQhrlFhoi8wncLFkps7vqqbAloTguQtjBgcO
	1s2LZEeF5vdvBVYcOzeBfRoG2v/svbe34XsJ2FbbUearPSRnWgYGou1MjQGv9jeS3KM=
X-Gm-Gg: AZuq6aLu6rpa5WFO63jKWnU3MAplLNNTj85FXtvIwuOl3KiNYldM+22XcD81lDofnq6
	V62PX/ffG19AYIb0vlQ/d0sZMFDMzmWoIdaso+pTor8sXYzixIiWs7EwDP6wHRRZWQj72r/2jfH
	lcf4Xb+eurjSc9+txQ+altvfHZdq/dEYCf9u6nbWuRTtWNQanNDxIfTmPPXUQ0XrkaPLKYAKyIs
	AduUKgZ0HZ381TGQCdhJuw5YQ7MK6mWfnaFi+YiFvKfqatY3VmQbVlxF/FVRY7quD1cDVfBwx5k
	IuPGyEJbPXZ6FO5sjYsdCVyek5NP7EDzUDq+3foDH4MgjqDQC7juypRYeKWqfMzwJ8dEUdPkS2y
	5r5BCEiVmsKFohCgIQ8Qx2sYl/W63kiXJYcWK9w7qXnSDYKnyQ36U2zfXdOi4nj6Poja1Fvrik0
	2ty+2jxdmRktR6NVahCGI4TQ+92ofo+DZYCXIVmh8I5IbRBp8v2dGHCuXaAntuo55KAXc=
X-Received: by 2002:ac8:5d44:0:b0:4ee:49b8:fb4b with SMTP id d75a77b69052e-5032fa0a86bmr84616651cf.66.1769619051441;
        Wed, 28 Jan 2026 08:50:51 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d375b635sm20306666d6.40.2026.01.28.08.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 08:50:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vl8kk-00000009KaX-1t2f;
	Wed, 28 Jan 2026 12:50:50 -0400
Date: Wed, 28 Jan 2026 12:50:50 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: syzbot <syzbot+a0c841e02f328005bbcc@syzkaller.appspotmail.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	syzkaller-bugs@googlegroups.com, will@kernel.org
Subject: Re: [syzbot] [iommu?] KMSAN: uninit-value in iopt_pages_unfill_xarray
Message-ID: <20260128165050.GO1641016@ziepe.ca>
References: <6975b1f4.a00a0220.33ccc7.001f.GAE@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6975b1f4.a00a0220.33ccc7.001f.GAE@google.com>

#syz dup: KMSAN: uninit-value in pfn_reader_next
