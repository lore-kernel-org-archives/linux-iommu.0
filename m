Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723EE145B1F
	for <iommu@lists.linux.dev>; Thu,  3 Oct 2024 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962621; cv=none; b=XIGFLWprPt6MzX5i0RQQAPDp2PibYPXeTbRYGDlD+TltKM2ykLFTCWWGrR/xn4nPz+zlJ+NIvTiVo/eSZYQ3YhcSVabZSPJbKZKxIStlWnnp/Pty1Bu+IlcTWN6eNH2cbqW13TjR/EVglMDPVf03gaUB31kry5mLbUvuB4rQgVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962621; c=relaxed/simple;
	bh=oKcjYtaHEPTRj+7CRpP5G980TAaVih1dYRjGdvPPRjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGZSvSsjoWTyHEoWHFNsX6hvTYW2jEpdv6PDNRJyU8cIsyGX+aqcbk7rw4O+N9tspNT/lOKXdP2e9DLwwOnbpx58HsCBJnYmvOjIRZ36/H0oPgZbqf4NIKlOuN1KBkUmytg2kJACNEG3mr4mCYEL+/3oZaTThMKdYjdD0s65x4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=W1YspHgb; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="W1YspHgb"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a9a7bea3cfso64811285a.1
        for <iommu@lists.linux.dev>; Thu, 03 Oct 2024 06:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727962619; x=1728567419; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tP7tolVS+NskbYnx6Ke2dpQNeCMyn7tnciZU6uuI/aM=;
        b=W1YspHgbdxEeU1Gv7IvhKho6oij6lyrEidk0+UYgLcmLqjxKlWVY/xE4CQ3Urocdo5
         Kj3kMwhp2f0vgbKqUXhMZS0ZhzM4nySq3WgUPlWXZJWrOKMIqtnyU7N0FYDJhThGwqTL
         /iSUC8pOk9ZGjzMnLXxyVUp6/NOnrU2ri7BrqUYjo77dHNRA0JNDmNpBQBc5wFe62jOm
         IwECheTMDpQ6FRZxq4xnGdm0IJl4XPuudB8sPFmPm/HURYjliRV2L/jhICdYyI5O5m4P
         SV1cACjLzB1+AmBYKPNUadnD3R6shMSx42IY+iE8fzZq325sOiS7H9yWKRBDedN7ri4Z
         qy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727962619; x=1728567419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tP7tolVS+NskbYnx6Ke2dpQNeCMyn7tnciZU6uuI/aM=;
        b=OT2VuU+FYXGzbXU7Ms1j4QP3YBaxKvf0iXfKJwkbI+GDL0p46RgRf/NChBjM6/eZLX
         x9VtZNWVEhEKX+Zclqc1XOEdMw7cgfwbpfTe9/yxV1i1MT75GWIVMhV7ISV58EgUD0Lk
         Q/NN7sRZkc4cpr3K/D17asDurlpPAcgDt0EDLVYKi80cmhXTj2XHtwgizQIqm2CDkawH
         RE7/Hul1sMPLrkca48XIctnprmK8bk7o67h/cnnTGh2fYKAw5tX9CZadD6UaY69e+fYx
         kNb1OBG0z6EtQuCfNN9GWaCWhaaSpIjhWH/d1C4R++a65icDsl28xoe6evEv2+VXC0kC
         HBnw==
X-Forwarded-Encrypted: i=1; AJvYcCUTg4vUjKyRrAoqRnaXkPgsm+0WbKnkfNhiKU2PJuZlJMFhE62HGxCRJv6czaN9MVeDoEdPxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YweRR2VaV9b2oeuWt5fUfSJfEI2OlhOn0XuH/dmCZMaz1AosT1F
	BMuygfvF9XZgu/N5c2sScOpqxLpI48xNqL4PxshhxJIqejNMYCnuZfgvzqp2rq8=
X-Google-Smtp-Source: AGHT+IExX5PZU6X//DLAfhUc+pV/DvO3M0gA3yCG/nuBqNATFkOVsDt5pX3W468d8vfh0nt7guWskA==
X-Received: by 2002:a05:6214:3a8a:b0:6cb:4eb9:d279 with SMTP id 6a1803df08f44-6cb819d867dmr105528216d6.21.1727962619279;
        Thu, 03 Oct 2024 06:36:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb9359c01esm6550426d6.2.2024.10.03.06.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 06:36:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1swM0o-00ASYX-0T;
	Thu, 03 Oct 2024 10:36:58 -0300
Date: Thu, 3 Oct 2024 10:36:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Gowans <jgowans@amazon.com>
Cc: linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
	iommu@lists.linux.dev, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Alexander Graf <graf@amazon.de>, anthony.yznaga@oracle.com,
	steven.sistare@oracle.com, nh-open-source@amazon.com,
	"Saenz Julienne, Nicolas" <nsaenz@amazon.es>
Subject: Re: [RFC PATCH 12/13] iommufd, guestmemfs: Ensure persistent file
 used for persistent DMA
Message-ID: <20241003133658.GC2456194@ziepe.ca>
References: <20240916113102.710522-1-jgowans@amazon.com>
 <20240916113102.710522-13-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916113102.710522-13-jgowans@amazon.com>

On Mon, Sep 16, 2024 at 01:31:01PM +0200, James Gowans wrote:

> +#ifdef CONFIG_GUESTMEMFS_FS
> +		struct vm_area_struct *vma;
> +		struct mm_struct *mm = current->mm;
> +
> +		mmap_read_lock(mm);
> +		vma = find_vma_intersection(current->mm,
> +				 cmd->user_va, cmd->user_va + cmd->length);
> +		if (!vma || !is_guestmemfs_file(vma->vm_file)) {
> +			mmap_read_unlock(mm);
> +			return -EFAULT;
> +		}
> +		mmap_read_unlock(mm);
> +#else

Any kind of FD interaction needs to go through the new FD path that
Steve is building:

https://lore.kernel.org/linux-iommu/1727190338-385692-1-git-send-email-steven.sistare@oracle.com

I'm expecting multiple kinds of fds to fall into that pattern,
including memfs, guestmemfd, and dmabuf. guestmemfd can just be one
more..

Jason
