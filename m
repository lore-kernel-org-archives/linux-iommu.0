Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793209635;
	b=ECr5DOC64R/xN+StBwWGtpIIT5YOEfdlfp+rXzbDlnfvyJwq2HW5+SYC+pXSqPNhWoZz
	 1KmK/2h/9p7x2GBeDF9UTy+WmANFwKB8NGOCPWB9c4FZyB241X9lfmvASzS7BYFMZSn9H
	 v/I+G26gwsfQduTRRcAtMiy5whdZt+O7kjyiuFiNZB1leml2G1m4OWd5v/L20gI+6Fkv4
	 OWdrBAp0Ontlhvs1Cq4jEVO3Yq3mtMEbDrc/Doc45sDK37Y3qZCvR3sGnHreot3tQKPYJ
	 rCeW232Se5XQjzfkikKJpbYXMlYXNMgirbL6073KwMoj/tRmGC8qJLN/vDXZkMkbI4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793209635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=tOxsbn2WzdX0v59D7Zs82WgtkG4cFGkj3ewz31Uolyw=;
	b=Xx84I7XgPC0Wwi+pT9TML7K0m53tEzxp6YMbMZBoBFX0PmIJvPZ0YBkzcgHalBdx6heZ
	 u4k0P7dqmUUqZ8NHZ//3GeubwIMF/Z2OSkUwuNqB/1gTEelixtHwEn47HwqgwxC1T0vWz
	 t5NIuzOWHBITRltOkxZttnOEZtn+m/TT/4+w2H0I5xB1VvMTgjme/6IbriMCf+TMkIYRD
	 CiCnbQFrbJTQOIolKgn05Zm7OywPB9vcV//FOl9c295G1T+YQtO4NHOr7xm3/0vbvKQ9e
	 YYfZ4hQubPsSUtm83A3AEnKUd2K3HY19Y9zf5wu4rwxqk/10GoR0X5IwPZ8nc7uO/Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=KKm6AlbJ;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB1C606A326
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 17:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BB1C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=KKm6AlbJ
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eac3b6b2ceso325965e0c.2
        for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 10:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793209634; x=1793814434; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tOxsbn2WzdX0v59D7Zs82WgtkG4cFGkj3ewz31Uolyw=;
        b=KKm6AlbJtQ4gXsfMPh40KGS1GVUvnA54CTOq35+e4vTPtWwpYaYrbk6NVmXmWn3aPK
         4WP6BxgcCzs9J08JdwC4PRuOqqE6SkouYcH6Ify5hHBSULSDw5ESt/3mmJIvccWY7Qhv
         Ql0/VymBauYua2y5pHdPZYHyAxXZKAAWv1dGkz1+iNE0y1YgyrZW9rExqp/EnHgpgcvF
         xcZXmA9DxNIHuR0Nd4R4U5DoYnc8DIK7lQ4oApi32/UGHunrTsw4w4LavtoMxGb5R4m3
         7Cls6mkDotzpRyaS2NpcjZQLsLTxXW+pk3YbpG36pf+q+wmn/3OaARTP+BeQ6FqEPmwm
         A7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793209634; x=1793814434;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tOxsbn2WzdX0v59D7Zs82WgtkG4cFGkj3ewz31Uolyw=;
        b=cxBYVWuCUNC0Fa1tgPLQOdn9TjGPIF55g8EjOAAHS8TxpkjlATR1XuTzJjYXEhtzSm
         lWaNyrhKien60AkDjDrwr/yQzAOUgxu5C8fe9TKclvITyhgE5S+k8ZX6uqKrLIL+eXql
         5yMHY+RI3ngHmLG/mQLDBPJISraDh1JmwTKsEa5pJhrN/wyMz8Mma2pqyYMPWiVtFiMR
         K4jSoDNv9PUAVaGg3tI6ZvIoXzpgNYYJhAx0MwCjbjg+gOOMpA2jfpP7aJSzJ0V//ck5
         3KO3+EFoAtdjSDal53Q2vlA7UDbUedeWGnbnMiWaxcKtPX85JmMOuCccsV5T5ThQB+xM
         Xvdw==
X-Forwarded-Encrypted: i=1; AKwUvBxkr8xGLGtnCOX7ncAQt/d+6P6UjLNo3D6qUsb+UXwn5bjLUwt8BrIOfbtl2/w+pmQ/zTk1AQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIfr9RMfYHjOJ3OONaVM6FGqfyWn/sqc+aa5gT6PO6+XsS4N9M6
	6+WObN6RHgOjSDq1NHH7KtNHtfXq5fRAH4Zlt7y6/xriPANjP6AAV/xRDtoJEChuINA=
X-Gm-Gg: AYBFou3yGlNAcL5ALrU1mpVvwZdQ7Nvu7HOTKg2E2TXSsEmnCRoh0Ir+6qoHcijhVRl
	zA73jaoFfTYa0mbv1igEs5S5j6Jq0ENvh97AhBMruKTDrc6Fr+E7lFNorVny6XZpKgQjlk+GlV0
	7YmRgMgdoe0VJAtYU4vKhUbcO88gaBF4MLYJsLvL09uDKkldHV6GySs55ZvGvJLOALXCgfTgY83
	n1qrNryo3Z0ry5eo5tmIR8fhL1jfx2zJCp3LcRvO87szANtWWaWGetLhj5buXzAs2WKn5Zxi3CF
	zhzsyWd9qtVmfDF1Tdu+Tu+XCrCM+miXR0p9cR0oILUof/L06s6nJc5YNmClVPfI2MKChwzFE2F
	ul+ZFLa3SSJ+b3xrMLYxAWh+G32N5sK+kmgRenRs8/ofRYpxpFews3OCvOxgd+vlZcaejyQ7x5H
	5D9Jiyvlrr9CpjlcA9haVjB+ID5+BQUkOESkvR6Nig3JhgVQca1d+g7zmpk7n3+YZDYFHg+i1Zq
	9m8bV+dgB+s/qXCYuVZh1wi5m+ABivb94l0zOF0EnGyPzK3F49OeS+I78g3QIHcrjkPb8g6BsqW
	atyNRqlrBvixb1zV/wjtLxPuTNReXqMyfagHmgPIpVkAe7Hjk7k+wSNXGIEf49z1K5A2pIPBX22
	8hRdpAsya0IboNxKmntj7j4sX4qi9yeVMtqlznWtayndCoCHseM5Sgw==
X-Received: by 2002:a05:6122:2896:b0:5ea:fae8:e69e with SMTP id 71dfb90a1353d-5ec4cc4f065mr1774474e0c.11.1793209634129;
        Wed, 28 Oct 2026 10:47:14 -0700 (PDT)
Received: from google.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec57e4e556sm445088e0c.5.2026.10.28.10.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:47:13 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:47:12 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>, 
	joro@8bytes.org, Mike Rapoport <rppt@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, oupton@kernel.org, 
	kevin.tian@intel.com, alex@shazbot.org, dwmw2@infradead.org, pbonzini@redhat.com, 
	seanjc@google.com, will@kernel.org, Alexander Graf <graf@amazon.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <auI02M-pZO_aQ4jn@google.com>
References: <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com>
 <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com>
 <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
 <at-8vkVpN2SF3XgB@google.com>
 <2vxz8q3hoicx.fsf@kernel.org>
 <CALzav=eG5j2n5omO2Mxqw8xA4sZLduxdbBYFcnHpPn0PDpt9Hg@mail.gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=eG5j2n5omO2Mxqw8xA4sZLduxdbBYFcnHpPn0PDpt9Hg@mail.gmail.com>

On 10-28 10:24, David Matlack wrote:
> On Wed, Oct 28, 2026 at 10:17 AM Pratyush Yadav <pratyush@kernel.org> wrote:
> >
> > On Mon, Oct 26 2026, David Matlack wrote:
> >
> > > On 2026-10-25 04:38 PM, Pasha Tatashin wrote:
> > >> On Fri, Oct 23, 2026 at 9:50 AM David Matlack <dmatlack@google.com> wrote:
> > >
> > [...]
> > >> The reason I care about keeping the header compact is that we are
> > >> defining a foundational kernel ABI and want to use this header across
> > >> almost every serialized data structure so we can evolve them later
> > >> without breaking compatibility. While some top-level structs are on
> > >> sparse folios today, other serialized structs are tightly packed, and
> > >> we are looking to add KHO slab support in the future where tightly
> > >> packed allocations will be common.
> > >
> > > My intuition is we will have a small number of headers per preserved
> > > file and per preserved FLB. One for the top-level struct and then
> > > optionally a few more for sub-structs like arch-specific data. That is
> > > why I am less worried 8 bytes per header, even if we fix the folio
> > > problem.
> > >
> > > Maybe where our visions differ is when there are collections of
> > > serialized structs, like KHO blocks. For collections I don't think the
> > > elements will each have their own headers. Otherwise the elements could
> > > be different sizes.
> >
> > kho_block today doesn't store entry_size in the serialized payload. It
> > relies on its caller to do so. With extensible structures, this can get
> > messy. Sure, the owner of the kho_block_set can track the size somewhere
> > in its payload, but perhaps we should store the size in
> > kho_block_header_ser to begin with?
> 
> +1000
> 
> KHO block should track the entry size automatically and not rely on
> the caller. Otherwise every caller is going to have to store the entry
> size in the struct that owns the KHO block, like I had to do in the
> PCI v10 series :(

I am fine with updating this as part of the versioning change so that we 
do not have to do it twice.

Tarun, could you pelase include entry size change into the next version as 
well?

Thanks,
Pasha

> 
> > Anyway, not a problem this series needs to solve, but something we
> > should eventually do.
