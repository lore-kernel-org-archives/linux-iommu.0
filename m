Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122429;
	b=Ty8EonjrMaaRhug/x9vRAYKM7lIM9t+OqczGpESUWx2EVE1zJgrJuT2wPi1uL6gmPbCF
	 XakVBr9WEPxIbldNt7CDpJWO/H4LN17QKT8mTlUWLd6JfetiztYxjpb63DJcPtK+DMsHq
	 AfG6d4FVEZ+cZ4PfxRJGZzHMc8ZuL+6mnCZ5j+AoTQPDlVnMnX62z/W3aW7QX4auzxwAG
	 XR7v5DPGjLOTXhT6yPZ6ZGsiTsunyuFOCF1kmtruxeg371Uft/O4wMIpBflgFR2AW7jR3
	 axhevu+MKQ0RlHFbE77QKbazCnvXWS/9Q/3rmqqnoByuOLXeqnh2kgegdCQ4lAIKXiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Glhm1d7B/bXe7XSf6a+44KZYpto2vUedcbuSuK5V4mM=;
	b=F7IaHy5fM82/1bZxVYGoPvIi82gjwH7zoKeghDJGmP34ByyV//OBhQcBz9AKu8kRY0mk
	 34adOnubFQfohE24VqO9pte+qloZ4c7VDesB9DrQFTjN7B5WfeNcqm6cGcOtfaplMUywy
	 whuFWSSOcYgkHXtPGQWDa35Z3Oh08s20kR/h6DnwlOHOAoE8hXYDxOiMAsqbZrqBsUjOb
	 oCquGkc8aEbU/AiyhZ5jhwOtwRnjdej76arDk2JMXitIJLZ7QmD26LIv/vJxAbA/r1JIr
	 xKzNdtil3BvBgGPDvVgGmzmJGtezvRx0UTmt6KTTRE5AexjqAW7Ce1/hRVjjVkg/u2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Lqq6YJPG;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F10606A31F
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 17:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3F10606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Lqq6YJPG
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ea94541adbso188385ad.2
        for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 10:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793122428; x=1793727228; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Glhm1d7B/bXe7XSf6a+44KZYpto2vUedcbuSuK5V4mM=;
        b=Lqq6YJPGw1nlMUaIu3xI5agiT0LzgP0B0KOx9FHXJzGsrL1xTNmyRdxUKpZ4oAf9yO
         h+zesyZovC2RlWtvw8Hje6D9FBqBIpY5lEMOnpJC/NWtYMlFM+iqkJrrdEhVPaw67UnB
         LheggtrVftDlF2ZaVxoMqi21sQ5/C+DcH/cnUN3Yq+PUuADh8UT7l3oQ/r/QJqZx5wzh
         5cOCbSl5Km8DvRgFNU5RLbndpr8GAR2HkEGTijJ5ccGa8Q73XFqz2K5Vl8RWvvPaps2D
         ILw6GjToISq07tk0h7/5AGdSW0hJAzxTGmcA0VbIq8tGTCZeX2A2w2ZnBLnjl8d+RmcJ
         J3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793122428; x=1793727228;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Glhm1d7B/bXe7XSf6a+44KZYpto2vUedcbuSuK5V4mM=;
        b=zF1dERWuWfuAgtFV2blQEOpGTSxJNJDAwR6VbJ/cj9c4XGFKXo61ZOHas5OzBb4veB
         AbGnAAxxfJOXfGCIrvtdtBqJN4B1SQp9m9XZybyrtLP/nxdXe0DI9/B0g2C96/Gf2eqt
         Pl2gTLr6dnxmKdl5ev2HtIpZ3ZTj2LwUBv67w2BSsUziF2+RAAp4dEOrRyz2fCESneDB
         ADprFHSqojMOgxwTf9CxutK/3akNB69QPcPCtDCFVFyROoz7mzjN8yysH/Fz4abVQ6Da
         /m3HEdgmKXIF3i9vHwIhFzwyjP9LYRiO1LYEYXQ3phtAlS62N+xozhihh4yM1KiGxRJ9
         w+vA==
X-Forwarded-Encrypted: i=1; AKwUvBxW69BcqQYyVGC0FBYrsNXQoSlyODfyIIl0+7zE6s2u7/3yaMD/3iSZmDRtXy8XJD6FFYOiDw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKI5NJ5Q7dc7YuJmMmEp0+nTyIIKiUVuoPg3mEdQiShpZKPxehN
	9QZcS+3tjzGzSF4sFb9LnjUJZtMLrnv6xOraE0dTvuhOsfu9PZ0AgB7lauCB3B0ziQ==
X-Gm-Gg: AYBFou1XjdnzmGUDKsw8qWgdldnQ6yJnqNxG+KhoVYb50t4dpgLV4Su9tZx42c8/TUc
	NPSta9RZ1c9ymclJ4F+BeDHqPCm6ruaH+uhcurRtRuopjL7opEwb5UXXMmfTVYCuQiSl7Vccwcd
	ZOiTKh3Uon0XfVwUxLTxjJBxTJnlVWwx9zxRSu4y/FXyq+orxhvnK2misGARhzJVgN5dO71G/dV
	qz+nDcJrQm2regOnKyrDlmF5RDjlLwjvknKtw2AFAtLYEmIW3wZe5XiasT4rFORfTz0yfSEzTWV
	RxCWX386qnfbAY8Lq9iA7D6nOqSuMyJJf4XiiWIni+0dPO4sn4bfpBSlPMFrWbzDbTzEEo1bciD
	eD8BMdbyd1bLYas7PlKYux0fSorzPZqBhmhbjsyX7rh1QXHA3pDFLcETzcKPZWVWtqmC+ree6sR
	g7SmKK0DB9obdEUtxh8PmjfJidqBbrMTdzwysaZAh5ZY9a2PqxCgYRQkDK4cAj9soYNmFq8Fm5s
	2XZrxuAJ7wqPro9K5EWHCyyHHFxXJZckZkoLz4Da4niBeLz4u3FGOBn+v1La+255IRcbn9YCme0
	VzjaPDKRz0um3BdMT4mgZVjrunKZIY3eQc2lPX4gTdsa2VOHrL+8tXUESkfxpY0I9Q==
X-Received: by 2002:a17:903:3d0d:b0:2e9:5507:b52e with SMTP id d9443c01a7336-2eb005a6905mr454945ad.50.1793122427469;
        Tue, 27 Oct 2026 10:33:47 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bddae0sm12585675ad.35.2026.10.27.10.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 10:33:44 -0700 (PDT)
Date: Tue, 27 Oct 2026 17:33:41 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>,
	joro@8bytes.org, Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <auDgdUb3y_ricEq9@google.com>
References: <atl7peoVHdP5hz7z@google.com>
 <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com>
 <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com>
 <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
 <at-8vkVpN2SF3XgB@google.com>
 <auDPd6tjzACQVszf@google.com>
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
In-Reply-To: <auDPd6tjzACQVszf@google.com>

On 2026-10-27 12:21 PM, Pasha Tatashin wrote:

> My main requirement is that DECLARE_KHO_SER() in include/linux/kho/abi/ 
> must be enforced by the compiler rather than being just a bare 
> static_assert() that someone could forget to add. Since kho/abi/ headers 
> contain both versioned structs and unversioned sub-structs, it must be 
> mandatory to declare versioned structs in kho/abi/ with their 
> static_assert size check before the kho_ser_*() helpers can be used on 
> them.
> 
> So, how about adding enum names like this, that are going to be required 
> in accessor functions later:
> 
> #define DECLARE_KHO_SER(name, payload_size, nr_feats)             \
>     static_assert(sizeof(struct name) == (payload_size),          \
>                   "struct " #name " size mismatch");              \
>     enum {                                                        \
>         __KHO_SER_SIZE_##name = (payload_size),                   \
>         __KHO_SER_NR_FEATS_##name = (nr_feats),                   \
>     }

Sounds good. Since you're also on board with splitting required
and optional features [1], this would take both counts:

#define DECLARE_KHO_SER(name, payload_size, nr_required, nr_optional) \
    static_assert(sizeof(struct name) == (payload_size),              \
                  "struct " #name " size mismatch");                  \
    enum {                                                            \
        __KHO_SER_SIZE_##name = (payload_size),                       \
        __KHO_SER_NR_REQUIRED_##name = (nr_required),                 \
        __KHO_SER_NR_OPTIONAL_##name = (nr_optional),                 \
    }

  DECLARE_KHO_SER(memfd_luo_ser, 16, MEMFD_LUO_NR_REQUIRED, MEMFD_LUO_NR_OPTIONAL);

The incoming path can also use __KHO_SER_NR_OPTIONAL_##name to validate
the incoming header only contains required features that it knows how to
handle:

#define kho_ser_validate(hdr, name) \
    __kho_ser_validate(hdr, __KHO_SER_NR_REQUIRED_##name)

> > Plus helpers that allocate and initialize the header and return the
> > payload as a typed pointer. Both the outgoing and incoming paths find
> > the payload the same way, by computing its offset from the header,
> > rather than through a struct with a fixed payload offset:
> > 
> >   /* outgoing */
> >   hdr = kho_ser_alloc(luo_memfd_ser, LUO_MEMFD_NR_FEATS);
> >   ser = kho_ser_payload(hdr, luo_memfd_ser);
> > 
> >   /* incoming */
> >   hdr = phys_to_virt(args->serialized_data);
> >   ser = kho_ser_payload(hdr, luo_memfd_ser);
> 
> These would become, where without enum, the init would fail:
> 
> #define kho_ser_init(buf, name)                                     \
>       __kho_ser_init(buf, __KHO_SER_SIZE_##name,                    \
>                           __KHO_SER_NR_FEATS_##name)
> 
> And payload can also check the existance of DECLARE_KHO_SER, using 
> (expr1, expr2):
> 
> #define kho_ser_payload(hdr, name)                                  \
>       ((void)__KHO_SER_SIZE_##name,                                 \
>        (struct name *)__kho_ser_payload(hdr))
> 
> We can also add an optional kho_ser_alloc(name) to allocate, init, and 
> preserve.

+1
