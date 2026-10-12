Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D016C4A43E8
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820136; cv=none; b=kO/yukuxHKPr5AMcExtrphMo1z5qdTZo5r8sO0V5n0i4Hlh8PMfN5Gyj7dtevMf3sj2/h5M/mE/WVWiEVNvCzFQ7yOSE91Rxz5Ud1Yzzlrr9iwxOV+GVCldDYUj8v5kAzewQEANtHQnsp1zgXO7fTfL0qyt5rw5YLoe7ox/PFZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820136; c=relaxed/simple;
	bh=IBQngc9E6IMptShoUCo5yKbFcmdbP8vVNx4ur1yYVnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwOuBDMR2TsSNxvy4xVJ/YXQXg+B2zKZEbhX6bUCW9WyuHxwKE3bcxoucVwkrzEM0DwK1iYb7XILfqjsbznZEBUxpM+pum/oOlG18adVZ2SjmZx0RIrRn/H3s5QRi55qjJe/VV0sC4PkG5ZJvI+NhLS7dHbNuI4TNTdqy5VF4D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpG+hJCU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpG+hJCU"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a17baef589so16559155e9.0
        for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 08:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791820133; x=1792424933; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bz+XxQbQvV9Rkz3jiplflbfyEnwSo6hWkWyEVkUNcs8=;
        b=mpG+hJCUjrbWIaiYVQq+5bdCE71KZUyOf3cOUZYKEoEOzp/9NInw4grz3Z66Ty1Ddq
         qu47Npicdc2p5ejHmmQlKulCYi0UUumaDxQ9ku9SCk+JiEkAnJhcQCjVIqCLnCVWgIf4
         1qjOBJ5wXDIxRFMODos5hYjmcOwA11L5GNUuqK01wPgxkdUjVg7I3RrsrQkxATRjskXS
         Up7Q5a/wNThgb5o01OJ8gcdJmF/pMdy5XPHQBf5YZXxY7oPg8AF+lThsiAkDAhXjlJ3P
         lxLjhGn/WIJCgZiWhfIOQVHbUl1cZkLb0ukjxMt4L747H2oJQFa6b8ac6CvVP8CGs+Yg
         vhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791820133; x=1792424933;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bz+XxQbQvV9Rkz3jiplflbfyEnwSo6hWkWyEVkUNcs8=;
        b=YkI4MBTPWikYAmv2CtiEHMqcooTgc0IqMOjeb5bb69k/t2dTekzxnj6UHBb1Zul0EF
         yMf7dlqPx0aC1D26lODV3dzwTwKrlqtFJMT+EXVfMb+H+wL2ZBQGiD8bCsuzrYIPl27Y
         tC6CCONpd/SL4x0/M6kHhrW0WpfJyakPvuo9To8JNbK/5vRbmECkiex/jh3AxPx22qpa
         fbJr2OLP6LY2UEyUDHC3TbYR/UPpT/q9qoV71dzGSXCd62u/w/IdOFlkFBITYkSnpdip
         AsEjB/AcL8PH+m0lEq15tJbXYYDWZlwjs8UIYhyyMb5iWVzeCOSyM/agpiyee28R7U07
         lrgg==
X-Forwarded-Encrypted: i=1; AKwUvByBZh654BRv+9Y4gGJB9m0wQzUk8BL4jPkWKLcE+nETj+YDkg79uJs77keHAwV9UXd0vVM9OQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJhWv6SRfGwO2i2zttS67+UVRNzifxxCaDj8hZz7xbJbH5jlJmi
	qp4gKYZStSREGkgAbPQnG/4Dter2mgKqf4vH0/UeeX/oaTRx/9PddvEq
X-Gm-Gg: AYBFou0gZPQfqsfXnc2Wi70FdF2kOu8nZuezfPWgiEbFMy4zI4iw381PV3DAcUV1pmz
	4F16fWlJujA0SUFmvRmrX04QfXtIXHAmXqKJgAEvHq5VxugLNNVjbhaI7ev+J4eEIjrt6NoWXRW
	HVddb4WS/tIOnvYUyc562bFO9323ZgM2u7JiCrLJhhsDGgxn960JYGymn9boDfwkJ39CEE5nij8
	52Qta2SRLpSWVsxcgdm8ZVJrK6pNDS/nA4SQ+FC0LFpkNfjA8m+J2sFZVz2UzDj0CRsaxwJw7NS
	pS6qE6hzeJ+IUlTdVAHu9uVh1C+SACHZ6OChgS7PkgwOE5BvVKDzMEH2sA/+1Jjr2l9qC5hmLFe
	yO8AC4o1dwixZXoQOogD+a2MVHly241bjoc7omH2Ak8EGZHP1QkpAwLSGzOmQlKVSna/O54FKDg
	MmrssDejYjT8hrqvuAXT4dIRbSBd9CZl415ntijhYo7pA3QFVmJNTov2y4POn0ZtL35cGl5kYlE
	hCojzox+KG1mtSOOmzWm9ActgxSSrnSB96pGgrV9Je+XClGPWNGHkS1Boent9M6v3cX1VJ7nQ//
	XKcTy17IjvUv1OvNbcKRxGZU+N26KObbXpA=
X-Received: by 2002:a05:600c:699b:b0:4a0:4a8:d444 with SMTP id 5b1f17b1804b1-4a18e4af334mr195124235e9.33.1791820132890;
        Mon, 12 Oct 2026 08:48:52 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a193f2c992sm210228205e9.5.2026.10.12.08.48.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2026 08:48:52 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 0/9] mm: Memory providers for guest_memfd and iommufd
Date: Mon, 12 Oct 2026 15:48:50 +0000
Message-ID: <20261012154850.96716-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <0ae3d92ef99c264cfd76d3c1ddef357e96c98d93.camel@infradead.org>
References: <20260720111259.122911-1-dwmw2@infradead.org> <20261006183235.16576-1-griffoul@gmail.com> <yq5ald8680t2.fsf@kernel.org> <20261012095800.50250-1-griffoul@gmail.com> <CAEvNRgF1hMz+4ivH6WhsEOLTJGOegYO9AYK6OByYysPp_nVJ=g@mail.gmail.com> <20261012150715.25132-1-griffoul@gmail.com> <0ae3d92ef99c264cfd76d3c1ddef357e96c98d93.camel@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 2026-10-12 at 16:13 +0100, David Woodhouse wrote:
> On Mon, 2026-10-12 at 15:07 +0000, Fred Griffoul wrote:
> >  Devices are different, because a device may not support
> > faults. So the provider also revokes the range on the target once it
> > owns the frames, and iommufd maps them right away. In other words, a
> > revoke means that the frames behind a range changed, whether they went
> > away or arrived.
>
> That would map to the IOMMUFD 'REPLACE' operation that hitlessly
> replaces a PTE, but does anyone actually need that?

No, not on the target. Before the move the child has nothing mapped
in that range, so when the frames arrive iommufd just maps them. That
is a plain map, not a REPLACE.

> As I said, assume that the "crappy devices can't take faults and need a
> scratch patch" issue is dealt with *elsewhere* and not relevant to the
> guest_memfd/memprovider work. That's purely a quirk on a given IOAS
> within iommufd.

Agreed. The replace is only needed on the source, where the frames go
away and a device that cannot fault must see the scratch page instead.
With that quirk on the IOAS, iommufd does it, and the provider does not
need to know about it.

Thanks,
Fred
