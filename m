Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714A6288529
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750092585; cv=none; b=hGKs2C0E54Ivw6EXsqVUInj4xhyTGVLxQYWkcbigLoA44TTYzKMFDb1YndFJjJLX5ZI/HljU5kpBqwsw7X0PPg505o+Z6z/nHrOIhy2jTd9i/wJm2zkVAz9ftTjRZ+2nrjKLdcKlkeQFzMvU/bQ34eXCeehLQOYa0emagPahHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750092585; c=relaxed/simple;
	bh=wbAqs2QPNshQFNfnQJ3Nsx3pqJB0co+3divXRM+3D9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkRtbnJml8JK+ca1mCUj/55fRQ+JoN5mxdDCbV4NSunUIZyGmMlLPHtNUn42Tonud/T8ICrux2eKDKGm+zJVJ0wAHQC0KyeN7NC8QaQoY7Md6IUYhpVMwkMUEPPBTEliVdGVDBZIcMZYNICWMKXE/pt9gyvsTk2DRDViwaXmD5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mb6Ff4lq; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mb6Ff4lq"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d3da67de87so71398585a.3
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 09:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750092582; x=1750697382; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9JkdL6Mk2e/49VSWyYi+MjdDg5JZvsaiQoJd8x2e2l8=;
        b=mb6Ff4lqRIo4115X6uZ78rzIa2jYTQxyo6BLrZjeduJhZtf/U9Tagfgg7g2+IemZci
         KjNG39N/k6aQfJx9dFn6Evz1tfgmP44haULFb/vDRFzEsp/L2L96Sm8Gz5sqZ1e3Pr4F
         tqVXudahGGtyQDoVP6yExSHsejRs8YJPW2GLAN//TOuH1D7D3SUs7yeudxP+Gxmo7w2f
         ujdvVrj4ktQxtQaiFfEXLas82a05TOB973W2zULtjRqHE8gBwjAPIHy6YFEFHhryoBXW
         epTiW4vi5i2Sp/IaY4Vor62GBvPWGEkcfDoDiVUgnsyFC/GPZpaL9J/Kixc7tLCdF2Xo
         KVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750092582; x=1750697382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JkdL6Mk2e/49VSWyYi+MjdDg5JZvsaiQoJd8x2e2l8=;
        b=Thl+1xvwHy+m82c9T+l0JFprqkLKS+KQhAq4odOt0lHJ/4SlYOczpN3/W8e69yM/iK
         gYv7gOUSTgKxj/sJRAWNuZgQEfPXrcJIUvsnAzMbWjHIlTtjtlgNnPN7stMFgQ11A+Fk
         ltUN9/GLV48NBBEVQ0zE2GuCX0Vnm7+ed2YtGaANz33RzLu4V9l3LkbsPcpIY5YsCWb2
         BkY8sKpKJPhvXxiVYm+mo4bqIP3bORYNzFTwVpNSIq75H5tqRM9ciouTNs6LAgbES2EC
         sjP0/qYJJLnXivEfFbswpLq1pujZJbsRyBNKeBBCpggNqO/vUsCehzlDH56c+/Pkz3Gq
         wndA==
X-Forwarded-Encrypted: i=1; AJvYcCVCIzgmxJWr57qdixsYkfZFldcNyzIdhvbQqOICfzt+JSOxZiWX+4rEduTE8Yygz9g8++wKSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9ccvajO8T/915C+6MPjI3jW/VUNu6m0PwSohqwo2Rl9F5NanW
	v6iI7LW/jhR9Hpc40MgD29xw/4k8AncXco2MgnQcRc4535vTMQptuOCE/hETZ/LV83hAdQkNP/5
	DnnmU
X-Gm-Gg: ASbGncsXkDhy0TTnUizjZwvDhG1UKX/ebLO/Qw/itemSPjnsnLTUL+scdcgC6ikOPP/
	Ekc5usoqdv0RCsKuCXvUdQDlGrn2A/2TjTzHCEmPfoLBkv2SMLWbU5eG6ZXg8qdj2wdDud8he7q
	Rjveq4Q6aTb8d78DH5xPhshMrX5fURrtZ0jFR5dOQWquRGsofs4GWdYkEEg2yfzSDOJ4mV2wPs8
	w773NfqlCHe/JeNXFTnzNvqs4jFqcRGmyi/KJdRYovc6bHTccDpwJ1R3whUsqFqLHWsckDBH+0n
	BGBp8ZW4stKd9mt57n4JXx43H2Jp8rWVYrF+pdmqFChHqOyyWwlk/9DCwlpE91aX9fzS44aPaAl
	psUAmtZJVukSalHgzIfVtZRWB1ElkkR7mTT8Jhw==
X-Google-Smtp-Source: AGHT+IH7LW8HsfFZHHGu9OtydHNIM8xqpwob8vEfETKl1+Ftq+mpH3z1NlGNTqm4xT5IAWMHRxxaXw==
X-Received: by 2002:a05:620a:2990:b0:7d3:9109:4472 with SMTP id af79cd13be357-7d3c6cda074mr1763524185a.37.1750092582358;
        Mon, 16 Jun 2025 09:49:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8dfe954sm549843385a.31.2025.06.16.09.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 09:49:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uRD1h-00000005lad-1ENt;
	Mon, 16 Jun 2025 13:49:41 -0300
Date: Mon, 16 Jun 2025 13:49:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Message-ID: <20250616164941.GA1373692@ziepe.ca>
References: <20250610065146.1321816-1-aneesh.kumar@kernel.org>
 <BN9PR11MB527606182417BB7A35349F598C74A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250612172645.GA1011960@ziepe.ca>
 <BN9PR11MB5276B467ADCC57BC6571CA458C77A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250613124202.GD1130869@ziepe.ca>
 <yq5abjqotim7.fsf@kernel.org>
 <BN9PR11MB527633CA2F698E83E12BFBD68C70A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527633CA2F698E83E12BFBD68C70A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Mon, Jun 16, 2025 at 05:37:58AM +0000, Tian, Kevin wrote:

> the expected destruction flow from userspace is to IOMMU_DESTROY
> the vdevice object before closing the vfio cdev fd which unbinds the
> idevice.
> 
> now we are discussing how to handle a malfunction userspace which
> violates that flow: let it be or add a tomestone state, after extending
> unbind to destroy the vdevice...

Right, to be clear the concern is

close(vfio_cdev)
ioctl(DESTROY, vdevice_id);
close(iommufd)

Which is a possibile sequence for userspace/syzkaller to trigger.

My position has historically been that DESTROY should not destroy some
random unrelated object eg because a parallel thread did an allocation
and re-used the kernel deleted ID. ID's that belong to userspace have
to be retained right up until DESTROY.

Thus we've historically avoided creating scenarios where IDs owned by
userspace are destroyed by the kernel.

Given we can say the above is illegal use of the API we could leave
behind a tombstone in the xarray. The goal would be to prevent lookup
of the object (since it is destroyed) and prevent reallocation of the
ID.

For instance a simple thing would be to drop in XA_ZERO_ENTRY, this
will reserve the ID and fail all future operations. The userspace will
get a failure on DESTROY so they know they did something wrong. The fd
close will clean up the reserved ID.

We just need to make some decision about the above sequence.

Jason
