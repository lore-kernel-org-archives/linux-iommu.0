Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0903FDBEB
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778868401; cv=none; b=A7JYfmut/cVzrlxXFX4NOK/Vkk2k+7kPH8EvaNMlrkba9rBeujKKVIGQPpt2IlxJoj9qWf3v+4xjVH3t8yADbbXVNhDxa/MfHh3+W9DReX9LlviOUdYF7wHtpcHZg9HvrkELz9yY1oeLTDeorsZkPQvAkZZbpP4BHCIeFXoJC+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778868401; c=relaxed/simple;
	bh=AXezpO4nEn/GLJQ6Sx9eEO7b4j2SxRLhdWMBUWakUTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRUUj5v46s0E+f7gLlyJ9nLjA5QTkUKT7E+nwhdggkhexlNx237kxQisVf+NzP9iTNupAc0yUH+aZgwj2+lvbZtjgl9nXncj7HOCGzvrmPvWK/TtU0lpnjgKcIL2tps+Hi+YgsnS7JA6ZICOHZBD8gEWotomMBfcgMcZyGEMscE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LmhP2e48; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LmhP2e48"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-90b2fcf90a0so5663185a.1
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778868399; x=1779473199; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rcOSrIvcAcDO9WkkqWoNEexjLGDP5koDwQkJhDioOAo=;
        b=LmhP2e48FKgqKjzi9OdZ0vHP6LMqpzUVQX6XSSfjvl4hqRO/qPCTVhj1QQU8TONqll
         CFQZYwB1i06GqBbrUuEKEfySvj4yx7RA9qNw+a4r/dFnqP86MydDWmdvjsuLOrhgK5h9
         kBqEvzLHb0ywxFI1xCZI8RUgFcU0eYoqQn4Ve1tzPZHAxh+A52AvOF4RhJavRFt6OOma
         kUmpA/cK2h17yIz7JRNGZr3kuCzcRZnQHF3n/QOfjJCzO4/zzZFp4ZOdAEYn4XRH5Qsw
         Cm+iUh2nB3l1psOMidT0KIaxiJNu3xr1ug6N9GEgfrrd3t4wHjM7oqB5HOkq3jqiEtmw
         l/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778868399; x=1779473199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcOSrIvcAcDO9WkkqWoNEexjLGDP5koDwQkJhDioOAo=;
        b=oGCAU8iIi/uguH68QaBhJVR6HzZTtCWETExgKQN3c8ot0EqvaBTKYRXcT6SgZW2odZ
         30AbKiu+5CFAE6Oyivb6YxF5OhJjpr9/Kii7hneAW/ntj71fpr5SGBtO1PgzU8bzwnFU
         4r4h28BqFE5ot1NQojY8NovdmSDVpsvSe0DgwMQ4Xzo6lBUVIswOnkzBO7P06Hcs9IiH
         JHkeKaNLhATUhdWQGt8ZgA+5RqVv3y6VouBIN/pj2bvvVbP2Lrx0892uM6zohT+9mcLH
         hNQpNNpfB1U1yF3HiXSVr+4VMmZ9JIv6VcbCVTJcGyOq8Zhi4ThBd5CyyfbN/6WYlvf2
         GZYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7GDOiLFuQwSP35wchQ/XC+w5MiqEqi3bUSoiWM+ATsAj+Ip0hw7I0qXgoBK15dgvr5V2v8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywjes182tK+z2D2s+FK4Hfs4tIsqmLxNudqClpmk0saxV8ujFxH
	EL56MQzSV69bebwftL0XaxItD7907BDAWMNzLIyj0mlu9gGcepeoV3DZwc6adzmMJEs=
X-Gm-Gg: Acq92OGxhAb3widnyjteCM43z6wgbS3pxodTDjCcx82vOOP2oAB7PgdM2Xqp+sGrLvk
	9kRrRpDX4m0tXh067Pq+E7QoOergYKI4RFG/+6tBV9aXyork3QNMz+Cm+acQp+OF17sU8/5OD5w
	uZh+tvz+NI1BKrF/x/RIehZD8I4gCkaibHaq+yGDNI4eRIIPs7Iorz3D8ZXIrXKtN2TrEStEysA
	b9ItJ/dBRCFsr5cYfdg0Ihvd9KpqIz8Zy23gt4XqM6uL2uzq+KhW2M/nbgpccVTzDnTlJwmhddl
	B0P3s9lKaQtrsEJQa5ZgIZ/FwkyEOfKJ48473ihb9REP4o/d1yb2DXif584tZMxYF4mudMYcGah
	yKGcyOzC5MWAVBb76N4qQQE3F9jV87olxmKChYoCK79G+lzI+pqfievcz9vlx95QyJyDqA7RSPb
	N7ji/ojpytallvzE9cS7Z1hYgZ/3fHjSx6F8AAK7TnQbzQ4jiyOVNbrmpMZXI1nKeIjgI0DA43k
	ujPTQ==
X-Received: by 2002:a05:620a:a092:b0:8ef:6b87:5c52 with SMTP id af79cd13be357-910b14f8cb0mr1004416585a.38.1778868399150;
        Fri, 15 May 2026 11:06:39 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c35cdb1sm58747396d6.46.2026.05.15.11.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 11:06:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNwvm-00000007s92-0MaY;
	Fri, 15 May 2026 15:06:38 -0300
Date: Fri, 15 May 2026 15:06:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
	stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	Kees Cook <kees@kernel.org>, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] iommu, debugobjects: avoid gcc-16.1 section
 mismatch warnings
Message-ID: <20260515180638.GH7702@ziepe.ca>
References: <20260513145425.1579430-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513145425.1579430-1-arnd@kernel.org>

On Wed, May 13, 2026 at 04:53:54PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-16 has gained some more advanced inter-procedual optimization
> techniques that enable it to inline the dummy_tlb_add_page() and
> dummy_tlb_flush() function pointers into a specialized version of
> __arm_v7s_unmap:
> 
> WARNING: modpost: vmlinux: section mismatch in reference: __arm_v7s_unmap+0x2cc (section: .text) -> dummy_tlb_add_page (section: .init.text)
> ERROR: modpost: Section mismatches detected.
> 
> From what I can tell, the transformation is correct, as this is only
> called when __arm_v7s_unmap() is called from arm_v7s_do_selftests(),
> which is also __init. Since __arm_v7s_unmap() however is not __init,
> gcc cannot inline the inner function calls directly.

The selftests should be moved into a kunit like was done for pgtable-arm:

commit 699b059962add22b2a324645b6ae2a607fc1a93e
Author: Mostafa Saleh <smostafa@google.com>
Date:   Mon Nov 3 12:33:50 2025 +0000

    iommu/io-pgtable-arm: Move selftests to a separate file
    
    Clean up the io-pgtable-arm library by moving the selftests out.
    Next the tests will be registered with kunit.
    

Then you won't have these section problems because the code will be in
another module :)

Jason
