Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC860497B9A
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817641; cv=none; b=By5ybzsoBi6uhSiAPZDDTh/wN7H1EsBSediz9OxMOeU8E2xAc9K5UhIN/C9NGS2DBQCF3to4/oLp4GuK63xJ3oaoE1Ik3Z/p4oR9ZPRVPQTQ7BSAB+8N8+5lb3Ay7nNPoPiOD54TT2f9di960LV7YTNOHWbNR/mdQDMW86L63p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817641; c=relaxed/simple;
	bh=tsVU21nxAD5GAzHrBR7QE3ds3Y9VaK8s6sj4rTQ/imc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qebWM676FN+VP+PDyMcPvmqvdjIrQaylz2LbjGNkuk+2AykUe3+fTe/Srhy/RvY1p/zgpN7XzBu1/Z4OsQyAf6RV1rPbcT6WPDx3U36J6YkSXet6pphD7z+5d9w4y4u0SZBKF09CQhpHSxIcE7RHfUjIwZ/GebNmqIdMu1Lmspk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLz0GjdT; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLz0GjdT"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48b042c0759so1505392f8f.2
        for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 08:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791817638; x=1792422438; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tsVU21nxAD5GAzHrBR7QE3ds3Y9VaK8s6sj4rTQ/imc=;
        b=kLz0GjdTgutj+6PmrV8Aq58HBC7gsgb8rBuUE8aVdfP2svQBnDk18ck0pAZbLisbv0
         3Mm5abyao1mq7eS/QOwAAL4YCzs0NawqyjBR4PFvTt4qhc3F5mMBPhpwPsk/4NZsxIlP
         SCx5X1PBK4ggU5epnmwVbRBr87AGs6v60WqmhuGz0zm4GwhAeRLkm0ECmjC/JcqU3ZlX
         83+aMSDIWhzrEfcwJbGRhTHWArudFDeUPih9caGDsIGrE6n4rA1K5rV7mLJJcD76UY8v
         LpjHt+fF+yQZzEcDx96B4UkYnSpc+6tS4NlCPchprivtTaEu55OCi5fT1x8F2Z4nDJv4
         /X7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791817638; x=1792422438;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tsVU21nxAD5GAzHrBR7QE3ds3Y9VaK8s6sj4rTQ/imc=;
        b=PXDkUMl6s2GE6U5E1qIAvj9FSJqdh00CNhH9WuEqIdb4LUiu5Ge3aSs4MhAjAt6Fuf
         mW2+TEcNrcd0t57P/QgMOC/42zwB0jwS5SYvb8u04WHtZMUVs4E/x3eHh3dB6bh1Anqc
         +rgC0cA6GrsOfTpKhOQPNlOMC1aKcmJzH4rKfSceaMEoaPRBUeFuodjVEbaEpzPEoj8d
         IxdV41VKL1i6fwl/mMej+YYKnGRH4LWprRwQvsQMj1QoVzARy8j5W7EhJ+5auM1U8tqa
         1pXsKmPHzeiMfElG6m/fru5rGembEU+JBMaH2OG+pPcDZBxE2DC2U3knyxFQ0vNGazgI
         ft0Q==
X-Forwarded-Encrypted: i=1; AKwUvBxuFHcCglm2u6PlVqFHLdHzA+xC0JXDpwDV5+g2zZDm724nKFEnPAbiO58vF8xNNOw1tGv9NA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJbd+JLRWxJmrReRQTji9/4zoqHEOxyyose4AXhD/6FG4B2WJ6R
	f7Wuo5Oiir1PTBo0FmP058LnrVY2zUyyFLxD0sbxYurnrqK1GX2RVldj
X-Gm-Gg: AYBFou03P+VOnfAACsnSC9EYCRR2ABv7NLwrIcaz2sqPoBQSlJKqtwLfluEIogO5msP
	WZLT/Q6LeDczv6/DBOBQNwk1KxALhhbu9R66dvt99jRbfjAEDF0mr3352wlKCsLZlu32cYmubL7
	GjEyBLBaD1+VppnNlbgNj9EpPvo2CscEoXhX6pm3kMwNDgh8M+IcrY83Zb5U0xNbrrd1+qHxO/U
	ne32BlR0p3ObRLowZBoJvb5FULHxu4/ZXYW9+N+I0FUeatoGYsFlS/TupMpxrAL7qCOaNKtRLIH
	o7hprrOwkca8nAvJ9KwSJlI/PDIxgcJ2nR8fo2m4hWnkeSDf0x/ROTiW3aZt5y5Tf8KRDpJaS0O
	OHOrHI8vcfHk74wQC/QKXSWiLrn/WG7kG5LLTvuYXt6DtKj9JLtKNR/HM1107CuPQIceeFwtlis
	c22KReqYMENSSLbM7FGU284PuB1Vd+hFLKEJhKbExnpia267WuUcGfXd8T1drQQCif1Yb5fHfQz
	3AiGpHvxI0/PrhgRNX26ADrt2icGdKUnQCJ6DvFaEyodScXGhikt1IVGHMUz2MrtIGH0Q2eJ7lE
	baAwSV4W7pq0wU2zWJHN5dHRqqM9R1rnspXTd5cLJUhpzw==
X-Received: by 2002:a05:6000:29ce:b0:48c:6fa4:fc89 with SMTP id ffacd0b85a97d-48dbaadb050mr12203015f8f.12.1791817637606;
        Mon, 12 Oct 2026 08:07:17 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48ddaefa06esm3451088f8f.20.2026.10.12.08.07.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2026 08:07:16 -0700 (PDT)
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
	Ackerley Tng <ackerleytng@google.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
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
Date: Mon, 12 Oct 2026 15:07:15 +0000
Message-ID: <20261012150715.25132-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAEvNRgF1hMz+4ivH6WhsEOLTJGOegYO9AYK6OByYysPp_nVJ=g@mail.gmail.com>
References: <20260720111259.122911-1-dwmw2@infradead.org> <20261006183235.16576-1-griffoul@gmail.com> <yq5ald8680t2.fsf@kernel.org> <20261012095800.50250-1-griffoul@gmail.com> <CAEvNRgF1hMz+4ivH6WhsEOLTJGOegYO9AYK6OByYysPp_nVJ=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ackerley Tng <ackerleytng@google.com> writes:

> Wait, is there some magic done to make struct pages represent different
> frames, as in PFNs? In your model, the struct page <=> PFN mapping
> doesn't stay constant?

No, our memory has no struct page: it is a carve-out hidden from the
host with memmap=. I meant the mapping from guest_memfd file offset to
PFN. The PFNs never change, only which file and offset they back.

> Do multiple VMs map the same physical memory at the same time, or is it
> a move like below?

Mostly moves: a page has one owner at a time. There is also a share,
where a parent keeps a range and gives a child a view of it, so two VMs
can map the same frames for a while.

> I'm thinking that if guest_memfd wraps your provider, then your provider
> can issue a revocation to guest_memfd (ctrl-f for
> kvm_gmem_provider_revoke in [1]) on the move source guest_memfd inode,
> then wait for an allocation request from the move target guest_memfd
> inode.

For the guest, this series works the same way: the provider revokes the
range on the source, and the target's next guest fault asks the provider
for the frame. Devices are different, because a device may not support
faults. So the provider also revokes the range on the target once it
owns the frames, and iommufd maps them right away. In other words, a
revoke means that the frames behind a range changed, whether they went
away or arrived.

> guest_memfd is going to support preservation [2]. Tarun's series just
> preserves memory from guest_memfd's default provider (buddy allocator)
> now. For your provider, I imagine the preservation flow would preserve
> whatever metadata in guest_memfd (like the attributes in the maple tree)
> and then go on to notify the provider to preserve some range of PFNs (or
> folios). Your provider would then basically do nothing, since those PFNs
> already survive a live update.

Yes, that would work for us, as long as guest_memfd does not also have
to save the offset to PFN layout: the provider keeps it across the
update, and guest_memfd can ask again afterwards.

Thanks,
Fred
