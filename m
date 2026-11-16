Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794803663;
	b=IWPL2x3mpe++Ru7bxUXWhV6NRdRhVbnqQzNAzLjy/xVbVWrfFUA6AhB2XrUNBCBNWL51
	 03ned8VGH7oPcWQPsOdbfDv+bhbOAIoC2zrahdI5oqAMnHATda4xFHepwQiBlTd0Ek0ln
	 AeLHvPhQF/1zAvGuFi9LuRZB3ysT9w7xBSoyM6SAojzSCpghvEZ3ygcvrHcjX1zOO6e2q
	 KHnEjCjAb7/LIzpS3AHTbhUAc2PYn4jIcTXZ+THbElj7PbJFObilhiMtgp0WtB+8VqNGs
	 BLUJIpbykAb0vl+Qo1ykn30sjDiGYZsBrSil05/uyX66+KL3VFDXTiwS2LIMPeHP7zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794803663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=0RTPkBSn8aHOwll0NIb+MH6Rxh2TXo2nlFC6RRntyeU=;
	b=LmlzPqG2zvpnO/JIbnTljPMUDSVv/LfczYrx33VOxR1OfYe72ibk/2fgGgcO/nFSz3+3
	 vKBPEXyGmJles1zTpbGAqQDBqvmI9p+LbInyc1z32hz2dVcY7v9PCZGyhMfzP7Cr3O3CT
	 zZWVqLeTlSMQwgtszrjCHLJORiJ1KJ0gmuUUKiywLIhhWCShH0D8U6mHtcoRjJh369iqa
	 QQFEfhx45pFVSywssQ3A4bYP5XPNezMhov7EFc2WdONqRqZ1Dpk6WGRiXf98KV29J9Xe4
	 E2zeJL8TGAgDG3PPz1zzvGHbt3k6RMc7UPjcbCToMvFbD4F2C0RTPT90iw6X5h4Qerw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b="or/AlSf9";
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EBA606A329
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 04:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17EBA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=or/AlSf9
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b3b4bcbfc9so3268139c88.1
        for <iommu@lists.linux.dev>; Sun, 15 Nov 2026 20:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794803662; x=1795408462; darn=lists.linux.dev;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0RTPkBSn8aHOwll0NIb+MH6Rxh2TXo2nlFC6RRntyeU=;
        b=or/AlSf9ID4PF+8qGNAByt+9leWavjQqMUqA4Z9mYViTJaSQxSjQzezRt8M+zlIye5
         IPTUjLqWNBpwmPCBomO39L5vvj9o4sKC4CKSexCkB8IiLxc6ouLv6Xf/rg/EPWX5j3Zk
         HK06YBEOYxtjDirteBgNqXxCv4a/KxzBK8G/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794803662; x=1795408462;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0RTPkBSn8aHOwll0NIb+MH6Rxh2TXo2nlFC6RRntyeU=;
        b=LzOcTqXfrMkD1G4DMZiHMVQqz87pTbfSWl1sZgI678Ck0DvjUFUgCtGcGNgHNFy+3m
         3C4NMk9BHq6ZJRxx9TKcCSE6CiVIoxttMOGs/RJ5XSfrEbjFPxhioAVpDxiDDgstkvJ6
         whvWVCzv3T9nnQNf3RLRpjGS/Hes1BFXiC2U48gkidqJqLEOnbm0DWnk6ZmuMeTVE9p9
         4cXHEEq88JP0wvxuj3iKScI5rj7pMMikWNV8F/fgmq6/P7tKmKXyUzRs7EZcA0MVOt/9
         2gWlGcSyLH5q70B6KlqvE2fdybeHh+heMbl8tDnRe7MJ32kHa76sKOdZrrkc7uFqTqCF
         zw0w==
X-Forwarded-Encrypted: i=1; AL+hErGWwUQ0eCCIp5MMt7PIjGvvqvj3lC+mux6WkBnAMhaFTVTVk1yAS3+bN17cTw3hVkaGC04KIA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+RVPSkm2oSdw0xjG+H6eFO0A2afZ+7BYacuv4LJrBSmlTum++X
	Z0kgMOp1eY2q06Zimr3ndhDh3EU7ViLKDn1ymKBuSRpI6roeL+MyJb4ceKlxra9Dw4s=
X-Gm-Gg: AYBFou2rgyGefsr9on8Rhoe5NYXXmcf9NFm1yKX77QWyMUJA//vaJvv0t3mU41Vi9pT
	Tb6zDa/N3cVH0Tz2QdGDz4vpDcOM76hituUcj/5fJopm+Tb94f72Lg3XQk1NdGnjT7H3esoXDjk
	QIipoAkryWle2Lpz1KwA6e1FrMs71Tpc9CQFNmNMHfqS/X41O6CJEtH/PtjONFfCcgtWHRnLtky
	IJeOrMFw2rBfvPw4PWBR86Ifg8E6X2BWKm/Lk230VVweJbEzEim15qjqT+I0hhBb6ykUgaZk8mn
	qt6D4S13UCXum2BtsUP73qKcjkRxUiRjIdGPUoFdZan0sivmES2a+U75UflGYnTQTzZqfjxBGH9
	lUffRViEIXdkzxl5296SOcuOeVSvuEaNaiHxp3BIaaMRUnyj2G3K3bS0ZyJRTM+ypqvFFZK9CZT
	AXfTObbv4v77XVIO0y6xnuRamRAAQVY8JhV0boj+fXWvC0oSCbDLiWnJpGDc/c4y9696qvhT+3P
	W0/5RdSb+puvLigglwljqPM5mbxaCUZfYzMkzPJH63/GVCTcMSoclZkHpLSiOAUA5SYjpeAW7mt
	RNtKjlv5XZqk6FOZQNTOl1NynUCiyVMDLqfBmPZfmzF3wAxRvoDqXQw0fuPEbcfB4gh8L+wHlfT
	ig43T3qc8xTJVlebNzI9b+7xwZRDS+vlNxSXsT8DPFx2cSo7vsZGARg8LgAwbfyxuzMlfMLQepy
	5FM7d55t2V3/fuQymu3H+VzbO8okZBaiMzEG5nWjlbiYDUmDI+n1Q6YEsg3uxBxAUl
X-Received: by 2002:a05:701b:4508:20b0:194:9e7a:3ba2 with SMTP id a92af1059eb24-1b50306c4d3mr9813315c88.2.1794803662025;
        Sun, 15 Nov 2026 20:34:22 -0800 (PST)
Received: from [172.18.0.2] ([172.56.232.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5329ec87bsm2576204c88.0.2026.11.15.20.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 20:34:21 -0800 (PST)
Date: Sun, 15 Nov 2026 20:34:13 -0800
From: Chris Down <chris@chrisdown.name>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org,
	will@kernel.org, David Matlack <dmatlack@google.com>,
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com,
	loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com,
	joro@8bytes.org, kvmarm@lists.linux.dev, linux-pci@vger.kernel.org,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, skhawaja@google.com, sagis@google.com,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/19] liveupdate: Add feature header to struct
	luo_flb_ser
In-Reply-To: <20261110050202.529473-15-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
	<20261110050202.529473-15-tarunsahu@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261115203413.eaa54fcba43adc22@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Tarun,

Tarun Sahu writes:
>+	for (u64 i = 0; i < fh->header_ser->count;
>+	     i++, fhdr = (void *)fhdr + fhdr->size) {
>+		struct luo_flb_ser *ser;
>+
>+		err = kho_ser_validate(fhdr, luo_flb_ser);
>+		if (err)
>+			return err;

I think there's a problem with returning this error as it is. For an
unknown required feature kho_ser_validate() returns -EOPNOTSUPP, but
callers of liveupdate_flb_get_incoming() already take -EOPNOTSUPP to mean
that live update is disabled. pci_liveupdate_flb_get_incoming() returns
NULL for it, so instead of panicking, PCI carries on as if nothing was
preserved, even though those devices may still be doing DMA.

 From a quick test with an outgoing kernel hacked to set an unknown
required bit on its luo_flb_ser entries, that is what happens after the
kexec, in that the PCI FLB is never retrieved and boot carries on.

Could you validate the entries once in luo_flb_setup_incoming() instead?
They are all written with the same header by luo_flb_serialize(), so
there's no need to check them on every lookup. Going by the code, a
failure there would panic through luo_restore_fail(), like a bad
luo_flb_header_ser already does. If the per-entry headers end up going
away as David suggested, then this check goes away with them, of course.

Thanks!

Chris
