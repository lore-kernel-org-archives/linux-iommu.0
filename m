Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5758740E8D6
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823376; cv=none; b=kDRRHr6Ue3zReojXSAmkiFvrj0sBd8vRiDMYUDGL7WA95r6+zSAIW6ue8LQR9ueL+iDlA2FtrpjZKZ44ROLjys6oGs7X5DhYgfGXupAu/Os+YLkq6Gp5hpfPv1mViB3/CqffiGNvGc/J/fYOgz1CV1PG0dPP0uNqLqSLUByMHVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823376; c=relaxed/simple;
	bh=QWPvsZn8DT0/Vu+hfGGOncPmT+V2i9T+xJS7wbHqZDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLkMmLs4M6ftATvfpGelnr9tHVsa/v6N/JUACVJDEK69tJaFRi3olTYrOfz4K4AQC6ZxvJjFmsVNJp+nBWk5dZ4X3TuzVlJ5+W6p+bAGmcuHRT4B0gqe1OFh8wAxtAYTQPcNpzEMvUKF/X4yPZH0zwxLvJKfRI5MCUSja4rtSCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=G8i1/krY; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G8i1/krY"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92c7a0a701aso213896185a.3
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 05:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1782823374; x=1783428174; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DQO+LwB4rlmVUEVrQLIA/Kr74YcNiyTBCzOFtX1NQKY=;
        b=G8i1/krYVPPMFnQ6esAqfdvGZWbrb/S9jEw3Lw8w7ABgbyNPVsCmJJu2s2VBb8PBqO
         8O7jEKIFIVETzpQjLQt9hYiBjydUNN0dqcPx7V4PANcBW1QnpieUvB1+VK6D1DaLbgNE
         04HVXRn5XNZr0JIP0rnW5uMnok7IaTU9YRSQ2ZO8LxyhNDIbvcEyiXVHBgL37OiCGN/w
         AKvPrHN6t48+7K63128hNIH06WQM9dd/BMHJ09MLB9Jx0ksTtNUHXBiZ/uudK27LQRyc
         aFxmRqhO4DITMbOl0AgMAeNfphuYTkom7ih5a37BUz6KV1+/gKSR8v017VARtaWPmt3q
         tiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823374; x=1783428174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQO+LwB4rlmVUEVrQLIA/Kr74YcNiyTBCzOFtX1NQKY=;
        b=KWMlHPOBLHzOn7hBlareJwkh7muexy5kDURUJOFzZiDk4U9CSq5hqlAQ2W9t1bA/Za
         GxmUOUORJPFyOyoq0aaVHRAu8tHbpcihPF7NObFhBs22jHzojgLfQJm9LD/Q8/OzG7aS
         qgf0JOQSsARPRGaakAN85WgbBE2LYG1Vx+qiAuqj1OBHH1griKnjp/J7nXhr3rLfOsFi
         zKfjDRdtqcRXhD9JUHV7fsiGYvgMgqfvXb6kLv5Bp9av9FpXSz5E/t/sdXRx6XNOUzfg
         Ap86t6fbo+5eCZWOjEvRTxeuK2Mn2MiiZuzfABWNRwthrCNE6f/gBXYN3/JLdA7ajMMd
         w5jg==
X-Forwarded-Encrypted: i=1; AFNElJ9F3IXdaXRWwcP9rUkFsaA2zVRODZXEtZq2Zj73oSJoX2jYMOdP6aJNeeIKrueBKR2vVvSwBg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywf0kYLJHoU0qcxveCzeSaWniC9S695oIw9HWZrlYqLQ5k4s7js
	2ovfzMvZfAS6bwM7Byt/Y9aC2tsOR8vmwSLG8Ie2yg9Tx6HD9GWY0wSWvvzsWxHA8q4=
X-Gm-Gg: AfdE7cm9G++zi2NukjByQrFj1TqDDtWU5hWebmo61xhBGigiLb0sfxvgR3DlZTCiNma
	OyVXmKO+lLNueHntEjgp5P392LwC8NzGQIhmuQX2alMN7VI2Jw5FmQeT4oGboOOC5MN2rB5TDtR
	Crm+q4NauQvcR6/AZoSy6+w3fjGVE9TBtUGD2jzLJo8vLAqS+u3GzfSu8ovO4f7wfWW2AGr16Yw
	6RrggTNMZ+HgxtU/TxUx6mjNfNxnkM/B4c9JpMN49UWh/UEqXXP5JXADN+FZLYKtk/Dub7DyYPc
	jnrCfguxN09f5au4ODisOcoirchU/IvfIELWzvSG+vozDQCSOExzf1gH39kLMf6TJ5aT+T8itvn
	VjvSsuhwQnL1ATeftgf3JJze7AL9gy5IH755lS8O1YEo9cE8C4Z1rAp/dHQ1+YKEijAA3g07ccq
	8AZ5NLhCiKIocgoFsm6DjerHPu4bf3gdaUB92LIw76okyX9U4yK2V2+hSBGltu2wuYW7s=
X-Received: by 2002:a05:620a:8391:b0:92e:4867:95af with SMTP id af79cd13be357-92e62af0f9amr515174185a.73.1782823374078;
        Tue, 30 Jun 2026 05:42:54 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6234dc50sm226634685a.39.2026.06.30.05.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 05:42:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1weXng-00000001qgI-3Vni;
	Tue, 30 Jun 2026 09:42:52 -0300
Date: Tue, 30 Jun 2026 09:42:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Laight <david.laight.linux@gmail.com>
Cc: Pranjal Shrivastava <praan@google.com>, David Hu <xuehaohu@google.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	jmoroni@google.com, kpberry@google.com, chriscli@google.com,
	sashiko-bot@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
Message-ID: <20260630124252.GD7525@ziepe.ca>
References: <20260621222130.1667453-1-xuehaohu@google.com>
 <20260623015459.1153884-1-xuehaohu@google.com>
 <20260623094446.4a8fc2ed@pumpkin>
 <ajryxMaT5evDUxaq@google.com>
 <20260623235350.6540eaa2@pumpkin>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623235350.6540eaa2@pumpkin>

On Tue, Jun 23, 2026 at 11:53:50PM +0100, David Laight wrote:

> > If we restrict incoming dmabuf transfers to fit within VFS-centric 
> > limits (2GB), we impose unnecessary overhead on the RDMA stack, forcing
> > it to manage a significantly higher number of memory registrations. By 
> > cleanly splitting these massive contiguous device buffers into 
> > page-aligned SGL entries, we directly improve the efficiency of P2P 
> > transfers and memory registration.
> 
> But a divide by '4G - PAGE_SIZE' is also non-trivial and (I think affects
> a lot of io) when the quotient is always 1.
> Splitting into 2G chunks is a lot cheaper.

Doesn't matter this isn't fast path stuff. It is better to use fewer
SGL entries, IHMO.

> > Since this change doesn't seem to have a negative impact on standard file
> > I/O or break existing VFS constraints, I'm curious why we shouldn't 
> > support splitting these >4GB P2P transfers? Am I missing something?
> 
> I was only wondering whether it was needed...
> It does bring up the question of why the >4GB transfers even need splitting.
> But that is another question.

SGL can only store an unsigned int size, so any large physical range
has to be split down.

rdma now a days has code to process the sgl and restore back the > 4G
sizes since mode RDMA HW can accept that.

commit 486055f5e09df959ad4e3aa4ee75b5c91ddeec2e
Author: Michael Margolin <mrgolin@amazon.com>
Date:   Mon Feb 17 14:16:23 2025 +0000

    RDMA/core: Fix best page size finding when it can cross SG entries
    
So whatever this produces needs to be compatible with that to undo it.

Jason
