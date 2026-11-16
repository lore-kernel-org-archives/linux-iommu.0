Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794852205;
	b=eV9N2rAhrcWZVYbQ3h8fo3+a9OSlTyoUxpu0WntvHMF8W2rGBn0FPRYr1XdRBmqzHu1n
	 068iTfAob01AnZhTBnuiRxzfYT0t8NFCN5FIFeq7WCBtjVI1IhEW+jCgYQKTfNAd9tbeN
	 YJqVHuAL6IpSnOTVUB4La1yGW6Q49COHv5y+KkSnanIjmDiltQ2KoX2LNAZaP+vTa+LIW
	 tyCDoPTskW5JrhcheANGtUzXHUgUJBy1U1/EMjMDr4j2VAnX1h9KqdhgL93vrcFzUbjbe
	 HYvzHMrAZEG5ZjBUVcWboMrogV5GL026obyVt2dBm3CEbsFdkrX+BbUMug7yVE2cVAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794852205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UsEi7nj+gIWpohML70hey3/GRg+ovwcWW0/uBKwbaX0=;
	b=o57ppHHZDcS+CmTdsNp2RhW8nmUV/K49IjsxeXe5HMwYHlVsOMk0fDocM2gVtz9AEHVP
	 qxfz8mFyZhc9pBnjfUq89L0TRuK+q+YdZR7DDmFmfWvEVl508E4pCZVxUnM940MEQxwdl
	 MxWG5rG95R7bdFIxJeephv2jsDsv+6aGbBSkFYXyfQ6FRVy721Z8THEqFTEkXLdyrk67f
	 4sy6LUtsQ8ko+yEwq/w1lq0A7tTTgHnnVeCIMDr+eAMLj5jq/mETt1RtsaK1trs4erGHJ
	 9HBRSiryLpTlhQM3Qvh3bwVFzxFfxs1i2lKHKcWKOjlsRzsf9cP3A/cKt7vDGnAPxVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aaV+UYWS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297E3606A32C
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 18:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 297E3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aaV+UYWS
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4d581da0aaso453781266b.2
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 10:03:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794852203; cv=none;
        d=google.com; s=arc-20260327;
        b=dYfHoN9s8ekV0fLkSj7c60Ot6wacN3PnMv7Z95D7bD8NKR7sCgKA4VqNK2QywJVzKJ
         yE/nJzpk8NHuStZeaCBxrq+GcCnqkVuOoyjKGJbRDObnLPOwl8NWG0QFZzKthcse5yvf
         F8ovnWi0PIporaYLFA+Zg2i9+MTGFctMq8D9oQZWlgW7duNZ5UCrbUj6mdE6ZYLm3sP5
         9/7qRd0bEzmyTJNjF0XCso+pkQLZy+R8mFImuGJ4t6OwWOn/dqJFpOM92k2Gt0wPNHOB
         OqLA6ip4rkhqaMacqDNcV08QbKPYxxXYeV5FUFjEUCPeBYb+IOGI5fsX3obM02S/W+zV
         4h6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UsEi7nj+gIWpohML70hey3/GRg+ovwcWW0/uBKwbaX0=;
        fh=WfG3yuARZzau9+9ue8iLKHlmzJEBXDFJK7rFYbsmRTc=;
        b=CMgog3pCs7KOQRC18mCFlQ4Nb1aDbot012C0lu0NskIFLc5VG/t2YEAM36ucYaQUMW
         gdzq38YE2IzaiOIwlTjT+3m9zSJrZKtgPo1rsdpg4ingaTf3Ak7t0WcmxTdJgN4YecWh
         jJzRuDMX8BGN6XzcpsCj2Cukh5g1M2vO5kFVS82NitmmFocX72k+3Evy9yAd/km9QaJZ
         /SkDslvF+rFFITSTI9qe9QIJ6LshXDJS1cf6414AXkneVu+TcegPo8xG36BSmCJgmdRM
         To6PbGhklREhjRkMRqF08kXp1/BUNpn7NZrC72Y6Z3J5YLhCl++u1Qugdcn1Dl9rq8qU
         fGKA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794852203; x=1795457003; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UsEi7nj+gIWpohML70hey3/GRg+ovwcWW0/uBKwbaX0=;
        b=aaV+UYWS7xgsYrzXhweOalD15d6Vkmw1PtpW0TcJwF+uc8f7y7h4HtuPjso7dluJdG
         jXhu5qaU6r11UG9hdZIRty2nxabvUiR6ZUwvq9JyZqhMQ+JFLHySAQiB9+jG73pbknFt
         AD3z8T/KFwuKUYdR2P4LOGCplsTA7nffVzgqjEYO/xTOQF/iHvhv8H6y5wb9dStdEAd5
         TbPfeF1KRtqB1sXkdPd59R1YHV532HYMCmioz6OF39V00TXsGlIEl7UxLhsTDyJwVkLa
         /eUsaMJ6SNA8KPVWIdzAYHOBZ70EbSnmZMYAVL3MpPXgGa3pPatcPtuDMgkn/ohDJCqU
         5S7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794852203; x=1795457003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UsEi7nj+gIWpohML70hey3/GRg+ovwcWW0/uBKwbaX0=;
        b=zcZjX4NjqiEQzFM3n8lQAb96/gtNgQyXmnu/N2MBjCw/phqQwPqO0udBH2WGL5jLG/
         mFbnC8Qmv744ctlbmGovDU1L+ZJ4M9WjOq9WACqne/htwX7/OcDmOYUCi3BtzO3cxzpo
         0jlvdrAKK036TrnRJGXArKscdgtmVK36Ou2YdLKuMvmVNrd0qgI89mB2Z1uiU+D2u9Jj
         TIGsXGjCGww6xz1/qY7nAf0ObqSuT9YKG2BobgrY4cuCLSriWvLZ4JSrAI+1IB3C4RJF
         o35cfS6YPaLHkApHfbGA3LdX2LwZMSxGD6Nyp3CTNkHr6gXsGLJa6WCG1mqP1X8vmlLj
         7OzA==
X-Forwarded-Encrypted: i=1; AL+hErGOsEs7LQ3V9vGlrjFahUgJs5oK5g6Rj267sYDs/S60VVSplEz7OJuDHwhpTngLvP/mfqOT0Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z9dcH8/62sRQlkTp6dLUFrLlx++kN/1VKusaJN3Di55Xeim7ISj
	jqshRdPf53nBpum4e5Znlh2N3F58dg2P+KBcb0u35EbgYU/PGbKO0hX+soRNX2IRk5pu8qVS/Qj
	0IDtRQKNqLB0J25ZtrqSYmuZ+rFRdegKWVSRiSgga
X-Gm-Gg: AYBFou28mQ51XPcCPkEyu70mcCaHbMdfLTLz5pk4v1ynduki2h+YR3RfvnByXxbxek5
	fJbYsChyfoLJyizHu66HttRrETJ++4zQ/0EaW2eGw/qNMxK2G4eHBuf7q/B0dKChiRuABXhkenE
	gii6+ifYboKWhui057DlEUVLqNkrylhpiz4o5b2eCTYVsKNg4D1NrqtHkeI6wyQb0z4kZkjM03k
	yvuFkqX6R/2csa7TXlHIp5I/1WmrChaWFQQY3xWSSH2dJtrmN/uE2NMVJCStHb8UDNPQIPbyTZK
	MqXfdBH8lsLzDbc5H00rn40Evnm2KQsbukjqy9d+gCrzrqGUrAgrHk353hh5AhAoUGKO/LoA72U
	07LF7A97p5ezt3m6tkImgMZzuKJJcpT/UIyzlPz9I7oIPeISZNBTg4PKD6Rw=
X-Received: by 2002:a17:907:ea92:b0:c49:cdc8:10cf with SMTP id
 a640c23a62f3a-c50963df2ccmr868161066b.40.1794852203026; Mon, 16 Nov 2026
 10:03:23 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261111192411.4133780-1-dmatlack@google.com> <avYjFfqr3T/U7lvn@devgpu015.cco6.facebook.com>
 <DMTK99TDM9AM.SAM3Z4COP9WS@google.com> <20261115231946.GB1239159@nvidia.com>
In-Reply-To: <20261115231946.GB1239159@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Nov 2026 10:02:56 -0800
X-Gm-Features: AclHuK98Rk-099iLtslJwrWtAxHkQR-ncmpykOH17KTcOCuNGBfykDUUL8uCEbE
Message-ID: <CALzav=efnA_ABCZVicX0QeTmHknaEbMeWOy8cS+zHYVhm5z+iw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] vfio: selftests: Add peer-to-peer DMA selftest
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Mastro <amastro@fb.com>, dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Matt Evans <mattev@meta.com>, 
	Matt Evans <matt@ozlabs.org>, Mina Almasry <almasrymina@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 3:19=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Nov 12, 2026 at 01:47:03PM -0800, David Matlack wrote:
> > On Thu Nov 12, 2026 at 12:35 PM PST, Alex Mastro wrote:
> > > Hey David,
> > >
> > > On Wed, Nov 11, 2026 at 07:24:04PM +0000, David Matlack wrote:
> > >
> > >>     Is requiring userspace to re-issue IOMMU_IOAS_MAP_FILE the expec=
ted
> > >>     uAPI behavior?
>
> Yes. Even if we wanted to the locking is doesn't allow trying to do it
> automatically.
>
> > The way I designed the P2P selftest support requires 2 things:
> >
> >  (A) initiator: A device that has a VFIO selftests driver.
> >  (B) target: A device that can provide a memory BAR (vfio_pci_find_mem_=
bar()).
> >
> > So far I haven't found a single device that can do both. But you are
> > right that theoretically a single device could satisfy both
> > requirements.
>
> mlx5 can do both

Looks like GPUs and NVMe can do both as well.

How would we implement vfio_pci_find_mem_bar() for mlx5? BTW for the
target device, by "a memory BAR" I meant "a region of a memory BAR
that behaves like normal RAM". Sorry that was not clear.
