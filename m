Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E2F199941
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664839; cv=none; b=ND/QV8Xblt9MTw/4wAYurex3wFyt5bGAhsSqFMNxi6e1oNpm1BkhpLFPnIGr/Tewjl9LRoRRro64IT191qq8DYECGbzfjF/QuQejqwePXpfOgj5vLi00GIY88ep0PXu0jEH2uB5/3lmZfUzicQ8/7UINCbuLeIU+BUnYYPNFQ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664839; c=relaxed/simple;
	bh=FovhsR+vkuZ2u0LTmZX5Esb+40u2qW79fou6tVONlWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmasjbqYY+OZF1eSSEcBgOZtb5rV0X3xNrlOLLQ70+nXizlCTGoNo6CUO0bOqudw1kjS2HH3wKN5UPeWJw1TSFci41lfIm6wmXOgjbai7YJttoZdYii+QKID6hJWvVF2mfsRgokqLL8SjuzDTao/8cFXXt7r1AwXBzf9GzNXJyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=h0/yTBsu; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="h0/yTBsu"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b11692cbcfso131513285a.0
        for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 09:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728664837; x=1729269637; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0cJUEoNM9ligxsOvROQt2dGxSz7v+QPY1FgP+hf/i+w=;
        b=h0/yTBsutmrKj+9n2yvYjzodNqnnVksYUN2dM1a2Le/R6mij1xwr/Q1xDrZiTUOQLP
         Y0Pg4T0RT8I1KlZPDOSG1hcODuJ3hebfpPWidx3189sKbgJqdoV9x73MywJ1XoEIVNXV
         qAYjPrKDlegGKKCwkxn82TeyhyYibrmigRpOjW3GcTCS/GZ4wghOmINzIfl9d9iP4uFZ
         enaVBG82Vh2EHqBuBJhkLTtla5tCdhmFHb2JrkACHzQJQa1URkLfbiFmrPdXk+H7Ix9R
         g3FapWZabJdtqPJGp19JEPkZzVpArF7YMuVihBr7gjw69rn+gr9Ocop/YGG+OI8+cwW3
         f/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728664837; x=1729269637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cJUEoNM9ligxsOvROQt2dGxSz7v+QPY1FgP+hf/i+w=;
        b=qOEWe4Q7kISyfkE0Mk94bHpkQb7gAEbif4if88pSZmtdyFfdFd82HNQgdq4OdhWwVM
         Qnj7Zwd9Sc9jhRs4D7AzcVh61cOJAAbEvPZsbLFsHDRkXGHak868qQ9ajGlDXaGv0qTw
         rLUeEM9vmNXgTaXLmB8v1WhtYiHrIx1JaQOHwptLXYnGgetmPTSniZwg74VdJdJZY0T7
         BAsMpiPMS/iEGXMYHIOmz1bkCh1tN8axT0trxwVx21G82jvSeN14xaVh74pdjw3U3zfD
         TgioVO6cPTIKOhi4Ht58g5WN1eyPCMD1BlZKuP7rPHO977didB7d+ZKKzX4PVhbE4Cbx
         8VgA==
X-Forwarded-Encrypted: i=1; AJvYcCUJT0o2me0iQj4/n4+Q0r4/Z/mUs35Q3pWLqC+vLEOadFFMAUeCYBcaU4J9Uwf9ELzL/nmJCg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/XMcV5hSyT9TKWwRKTYmwU9OrnNZwmvS0LxWmkLzBABzblGlb
	7hC8Q7h8UhTV5WkPQaf6Vgr2/FGJWr44nIPWTKFtOvFi0+Cd8ta+7tg7TJZ2VBU=
X-Google-Smtp-Source: AGHT+IH6xJT0BhkFOSN3WJgaX87Y9gajn6VFuFp/MvVWlU/6es9ypp3mLVGeW7zMzGaDR2abx274ow==
X-Received: by 2002:a05:620a:2a02:b0:7a9:aba6:d024 with SMTP id af79cd13be357-7b11a3ad022mr535467185a.43.1728664836983;
        Fri, 11 Oct 2024 09:40:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46042789a5csm16697851cf.20.2024.10.11.09.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 09:40:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1szIgr-007gne-CY;
	Fri, 11 Oct 2024 13:40:33 -0300
Date: Fri, 11 Oct 2024 13:40:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joel Granados <joel.granados@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Klaus Jensen <its@irrelevant.dk>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v3 0/5] iommu: Enable user space IOPFs in non-PASID and
 non-svm cases
Message-ID: <20241011164033.GA1825128@ziepe.ca>
References: <20241009-jag-iopfv8-v3-0-bd4271df5b2b@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009-jag-iopfv8-v3-0-bd4271df5b2b@kernel.org>

On Wed, Oct 09, 2024 at 09:28:08AM +0200, Joel Granados wrote:

> Changes in v3:
> - Adjust wording in cover letter
> - Include "_iommu_" in the prq Intel function names to be more in line
>   with functions in iommu.h file
> - Rebase on top of 6.12-rc2
> - Update my ID in e-mail, git author and my Signed-off-by.
> - Link to v2: https://lore.kernel.org/r/20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com

You didn't include any tags from the prior version?

Jason
