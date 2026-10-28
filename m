Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793209470;
	b=rwr9r3DT9Is/VTNRG7dunvFPq7m6DT5aSSInm8JPU2nI26j41LRGF0886IjPcfZ5Ge+V
	 2GaLLRLrOGbnPTSnA/7085PkBdcpSZQIVs5E0/DSvYBie8GwovLm1OkaxJf+3qOy93YHp
	 dJgN4IA2kD37UiWaGJwXWKnkQv/d2ziHKyJK3mxzUz4glXCi5jwsRTjnGRX8yLRj6IEc9
	 cuxBy7eifHrzUNn1u9l3gJWpAi0TWDFk8laZ0itk0G4XxOnUra/uA3PP+1iFYkcPuYMRr
	 u4Y2KQH1HNhrAggAm4ik4SI6Elf4DrvuF7y2/XjaFc+nXNfm9cB/9DZmyj5CoifoxJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793209470;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=s56cw49H74YOeay3n+CLmJxr96H3PjfrjsaPdtr6E80=;
	b=1mP8uKF22hpTYIfE2wd6S86JdhjEVN4MgtaHWLcwkVVVafDtndtwm84+/EbrR71taNIa
	 FUU0WuMU8cdnIqbWkrVJEpPMCxHJ+ISboeArF4dltXr4L7FxkQcHwoHqCH43k8ox5Fypz
	 Hyb6FARjlySrI2BomFCIxz2WhAu9PR5Ujl8vzqPjltLWtNYCNsE6+FERwzxtYVGlID/sE
	 kGR8cyb7ZESdTFO3t08NdYu6E4teoFIzXFCJBqnIOQ9JE/RNXl03rkrf0PGzeBtC/6RPt
	 LmsFxi6QVk7k6OhnWB0g+vWZY6J2GHcr9J/SzDIpVMY3lOnbgGmL8gF2jZAR3D+Y4XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=Gxumziso;
	arc=none smtp.remote-ip=209.85.222.48
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751D1606A323
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 17:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 751D1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=Gxumziso
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-99059bdcdeaso390701241.2
        for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 10:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793209469; x=1793814269; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s56cw49H74YOeay3n+CLmJxr96H3PjfrjsaPdtr6E80=;
        b=Gxumziso31HnQN2AJZ8r/zNT26JeM9ws+ItmXhIQ+gdN6jFa7QgVwwNHIo4RkY9y8g
         NLg7Z8G+rb8sVNVmpp9UqAQhYv/OENBk4Cy+Kbwfkv9kGZjDR88RDBkKRhr2Di8n+rNh
         xhqASRiyt4n4KfXCvF6UZNytnIuGPD0+fd24W3nDwQExeNmvV82U0A6zuOlZBmyyOARm
         e/hzUmisD86etwwaUTdo4CuC4tWDmLC7/asx0xm/qnCyVHkty1ZltkAfabO54j9vVOXl
         Io6VubXHgVq2FpXWUPcUwfxhAk69psdJxTCss2jYEdS/WR1Trn0upseDgnlBfRpEX0T9
         79GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793209469; x=1793814269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=s56cw49H74YOeay3n+CLmJxr96H3PjfrjsaPdtr6E80=;
        b=CfQIrIohO5+sFcheTtwY2IdTJ9A5JMgmsulUPdm0ilimUw8sjBzvY4o5xVtU3nh7Kl
         gfX3xC5yQRBYX19NWyvMRVxA5o5ZcupXXvz9ActdgjgpyCC3JCVwJy1/eUwkz8CVTz8b
         ToZ1MgkhJ6W7JA5KVw+7kEcN1qhiqBGHv3RRww0PF379R1x0WiMqMiCpTtI0Zj3RC83R
         ckzv4Jh451XQ9/ID8RUXimN4trerYb/AlHFfcrR/Rbc5QsjbxyjggZZ8N8QdAgnUHrVP
         jh6zDaNPLaAU4IGvGtj17HddSnXvh0kAVwav+3c+9OUBu4+JSViInww09HWCajhy+eDa
         ezbg==
X-Forwarded-Encrypted: i=1; AKwUvBxHEP3biEz0GkwDgkkdpgI4O6lBoy5uey0faFmNSkcOqCQgQaXXRB5rkCs5tZo7urOcd+DZ+w==@lists.linux.dev
X-Gm-Message-State: AFq9FYIP/13zC9cLFEk/rYYjVtFC5ONNs+TF9N0rDpzS48bOM7R6FvMb
	ACRP+Odf58HYU5auuE6CfX+zqKUDpA26PEQFGGYcKuCwY40uYBmIl/N3NnfjwV1UQd8=
X-Gm-Gg: AYBFou2gP6v8Wt4rLkXL+0Mh+ZtDoudK5AVYSs6tAqBjaChrmPr5pIVEE6bg7yOJrbG
	GzbwXm+vkG71mb3eKFQRRvQEImQ2CY7EupMEA5G6PW2oYUN/k4mQw+4NTSNsNRHbUscmJrSHlYJ
	YG631CIUBQQlyAn3unIeeD0jURJvamIUk+kKwEOQDEI1VRzK5BkRMQUczjHFYSMIiZ2XNKFxFMr
	fZnds7hpd2FVzrQ6u+hGh463px8l7SOojGYkxR3O8o94SmUTxOr163asIqjG+UWjwWP3V2nGJBD
	jjwTgYQNnrVCdjSUh5StdqE/2ClJkVKCtMkkDS/um0HSqe07+rRG7CPGDP21OiCu0/NpbbGr5t2
	ywxKzwiJ1Lm4e+b5Jo1oQZDsuxv6miRuPFRi9RPN7uv8RT5mWnM4OoNCdpE3gN6Gn5u1wb5PwyZ
	4EsHkyx3V6fOqtVom5Q9aqm2xabOHL7f3C/AQ5klDjhiDjVX9ikP3axzit5ySB95q/3YkOT0+Cw
	E0wcFy1Ou4zY4kFAwp6Y/c954+5KnZGBCBjnYMXFMv3Nw1iWrPM63MfVry3tHTbvnlyLg86iRU+
	Z3X1lnsx9pQuOrvulkN7BrFKOoq8QotTqNbAMZx8NM6GLjRLRqPDA57QfefaWupE6DOsYBtF7xe
	+2O2PTHWKY2CYSyvkUHNcOUgKfCSaRg0q
X-Received: by 2002:a05:6102:3e8d:b0:7a5:7282:1994 with SMTP id ada2fe7eead31-7d03a50a85cmr1269510137.7.1793209468986;
        Wed, 28 Oct 2026 10:44:28 -0700 (PDT)
Received: from google.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99125931983sm6616412241.2.2026.10.28.10.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:44:28 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:44:27 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: David Matlack <dmatlack@google.com>, 
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
Message-ID: <auIvjVmWnsVPN_9g@google.com>
References: <atl7peoVHdP5hz7z@google.com>
 <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com>
 <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com>
 <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
 <at-8vkVpN2SF3XgB@google.com>
 <2vxz8q3hoicx.fsf@kernel.org>
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
In-Reply-To: <2vxz8q3hoicx.fsf@kernel.org>

On 10-28 18:17, Pratyush Yadav wrote:
> On Mon, Oct 26 2026, David Matlack wrote:
> 
> > On 2026-10-25 04:38 PM, Pasha Tatashin wrote:
> >> On Fri, Oct 23, 2026 at 9:50 AM David Matlack <dmatlack@google.com> wrote:
> >
> [...]
> >> The reason I care about keeping the header compact is that we are
> >> defining a foundational kernel ABI and want to use this header across
> >> almost every serialized data structure so we can evolve them later
> >> without breaking compatibility. While some top-level structs are on
> >> sparse folios today, other serialized structs are tightly packed, and
> >> we are looking to add KHO slab support in the future where tightly
> >> packed allocations will be common.
> >
> > My intuition is we will have a small number of headers per preserved
> > file and per preserved FLB. One for the top-level struct and then
> > optionally a few more for sub-structs like arch-specific data. That is
> > why I am less worried 8 bytes per header, even if we fix the folio
> > problem.
> >
> > Maybe where our visions differ is when there are collections of
> > serialized structs, like KHO blocks. For collections I don't think the
> > elements will each have their own headers. Otherwise the elements could
> > be different sizes.
> 
> kho_block today doesn't store entry_size in the serialized payload. It
> relies on its caller to do so. With extensible structures, this can get
> messy. Sure, the owner of the kho_block_set can track the size somewhere
> in its payload, but perhaps we should store the size in
> kho_block_header_ser to begin with?

I agree, and we will discuss versioned vs. owned serialized data 
structures separately. With this series, we establish a common 
framework: size/feature flags and accessors, and we update most of our 
serialized structs to include them. All "shared" structs (e.g., KHO, 
FLB, radix-tree, block_sets, etc.) should have their own versioning.

kho_block_header_ser should have this header. 

Pasha

> 
> Anyway, not a problem this series needs to solve, but something we
> should eventually do.
> 
> [...]
> 
> -- 
> Regards,
> Pratyush Yadav
