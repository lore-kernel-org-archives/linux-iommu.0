Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762549;
	b=Awv1rkPndkM0HUl8S8zaRRKhj2DPG1GVcAg84d1IoZIXm08jYmwji/iUfxkt4in+F8YP
	 O1jdFzi5DvCNXwo8zXvlSfjCh4CvzzEZW93gUsbtYun+nM+3VkiKJj7/W+t26NgeLor8Q
	 m0H5t0E/ms7PoYHqf1exjJFG0SdZeVluzsBJoTydof+flgKqvwhLNJxozpvV9U9tRHdi/
	 mlzT6f4g+DlUsHCtgKS018EKZcBmUoeJi2qkzWuyibq8xVIlSDJQMfgiV6J+wJ9tXeXIL
	 K1H3JsAu9iJxG1Eqx5lH/vMqiXjJn5br3E+uAiTvmnuQb0sv5eqF5AxnPW9POhqGuYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9CmvWQCO9ciSR83HG89op2Z5oG5Iu+ZEx0weEptYBic=;
	b=q9AeIUz3tzPHXrCY7MF7DVYIKlpki+UzdE09eklnd+aRadHg97Aj7u6oRE9UIAx0nBpS
	 utAV5mZeVaIxPq9zTvTqQjsE6RVAZNTBkAW27oRQyYMZP5v3eikqqfzmeeyfzJPFPpLs5
	 PCw1+9PNTYrip5nQeVTD/e/wr7poQMpt30Xe1oBJkzp0gZjKK7qoL71u/eY6Mo86ey7A8
	 FMURwXW0Gp2zB0w/IAVoH///umGNYIvBFzmUl3chVrU/091prsfFHcYlIP0kFM2L4cuH5
	 A3/uuxzrroRHpmUwNZ8u2eTtXLAy1O4+pX85GII6/hhHw2588n6ZCoYQcuJN63WKnIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=naW1q8+J;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039D3606A31A
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 13:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 039D3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=naW1q8+J
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f259cdc86so79154785a.3
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 06:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792762548; x=1793367348; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9CmvWQCO9ciSR83HG89op2Z5oG5Iu+ZEx0weEptYBic=;
        b=naW1q8+J4VAIZpOspmaT9vOoLubxRaH7bx8Lz4o3fieFMYeIA4DAwObCXtL37qNVqa
         g33JwP2uxOi2uTJn8ErfMW53DKYLm+/uFL4hRZbDkyalaEOSzcMLjMef2+p7Pqu0dUNa
         SN9+jWrP11psqWNJDkQ4tbYYwNifdfq+bECc5cbcsTPD7zkLtbKAaQuIMIwRwavWlJCy
         rtSzDXcLaIEpRN+326OzxjQz9s6trt4w9wkN3rDCpN0CQuXmSCt3bS9IX620gmYPCLqK
         GTpNBYwOSlOEln/zDWtkfAweXtLmm8mm3meFxedcCwIentaI2TJbgkJy2TXVxUP6xVTV
         icJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792762548; x=1793367348;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9CmvWQCO9ciSR83HG89op2Z5oG5Iu+ZEx0weEptYBic=;
        b=ZMnh9U+2kt5gIkkqAdHJ3FWQ7dUM4p/AUMMrAOyl7eVRCvfKIQXAsvwIkcS37Tw3Qp
         Eau0BFy/na6mMDXbKeqlWoK/QEqiXqSuS7ef4CqWWLJhoZsjejTmPkRWZ2vKxIkC8pWN
         CuBoID+YNwUhlqsFaLNH4eSB14F40nvBrDpoJKRt0MJS6zXbnBfJmVa/S48LG4y6C+I/
         GXkE+U7lE5Lflz1eLB6a2iVC6+q8NqWKOChTgMR6l0QrwKlW+fg3qrk6wriva9XVAGy7
         urjRY02vnHJ0Zohg9lOV76dZPZEourZ3SoSuPHsYMZXOTY9HoXLI8MFjlqwbF6OfHFVK
         PZvg==
X-Forwarded-Encrypted: i=1; AKwUvBwlCWIcKI7FVj+XX90iBaRj75lN3H9SySBo4o54hKumTRZC9IBFBn72HiAk5nC3pAYzspHOQQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJR/bFTr8gTCrNlyW6VyiRdZ9esdIb2aYWbxRjNvUUAJHSJHkb3
	7Viqp+Bk15jms5JXNmcahSm9gc83OH4yCu5k1w61cVb5wI8Yk60nFcL6NQPSqa52GBk=
X-Gm-Gg: AYBFou3qUJ+KZJLjc3CEnQBuQswgiQn/ZQ6lobJzvkcUPQPdHHdmlk/GLUZY4zRyu8A
	Wyh3WqQspWtFk5ENIveHvygmhySsZWIjEvpLggX3YJqI75mNPP3gWF950eyKX2B9GMTTl2SAvm4
	YGBnT54TCJTBE8eF1Jw47u3yrwgBHXzO//zmFo+zt9uiiOWibcnDGpxFK4QnwuL1ByWr3s+KOeb
	8hcpa98POGfKIbrDkYjuQB0i0dEmIwOAg/HCW/CKGA1k5RMyHmhSX753p6nSSxgZEVhsZ3xGCQo
	PYIzOdEfbryj7lnjT/EFNtrmEikzYnw3Rb4JMgReLA9jxxZRSZWS875+oOZYE6dnxqLh8/lgUrc
	vuLIDbVXwHsPDW19L2Bsh4noNWwV8oiLITxIwLRf98lseoyANkU90++nCXjwruyjEvQtoidMEx8
	8lECpWPFp8U5IfOIF9Z4z5cHQ/tS4wS6zyZBygIk0rMqtAzu/qdRpfrm5sDmfvykPYvIP+b0zYm
	boMXYzkINoeJpvySNW/oL2TtgF5GmaX3lIHG8WgrE5YOELQzXsQ3Za2apIeCQ3sAxvqGh9qJTv2
	Tl7qBTTQS0UAoI4yMpPyjjOIqrA6ZGj+6o11s+g=
X-Received: by 2002:a05:620a:45a7:b0:93e:6723:9de8 with SMTP id af79cd13be357-93f6f823981mr398926785a.59.1792762547650;
        Fri, 23 Oct 2026 06:35:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94047b4f603sm17521885a.40.2026.10.23.06.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:35:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKFQw-0000000Gghx-2aEb;
	Fri, 23 Oct 2026 10:35:46 -0300
Date: Fri, 23 Oct 2026 10:35:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Tomasz Jeznach <tomasz.jeznach@linux.dev>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>,
	Zong Li <zong.li@sifive.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] iommu/riscv: Keep page table pages when IOTLB
 invalidation fails
Message-ID: <20261023133546.GK3381610@ziepe.ca>
References: <20261020053435.1179054-4-oss.patchbox@gmail.com>
 <20261020053435.1179054-5-oss.patchbox@gmail.com>
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
In-Reply-To: <20261020053435.1179054-5-oss.patchbox@gmail.com>

On Tue, Oct 20, 2026 at 01:34:23AM -0400, Yuho Choi wrote:
> riscv_iommu_iotlb_sync() frees the page table pages on gather->freelist
> right after riscv_iommu_iotlb_inval(), which does not report whether the
> invalidation commands could be queued or whether IOFENCE.C completed.
> If either fails, the pages go back to the page allocator while the IOMMU
> may still hold cached entries pointing to them, and whatever their next
> owner writes there can then be walked as page table entries.

Invalidation is not allowed to fail. Drivers always have to free the
pages.

The system is irrecoverably broken if the iommu driver blows up so
much it cannot invalidate.

Jason
