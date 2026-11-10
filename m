Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323545;
	b=tTgyGxjeHmlMSfQCsEfIsZ+uktUdeE1u3gVP2kpoSvvnv0b0uVyo9n6tL7dSjdZ7AGIA
	 BllXiU5TBDBawtxM7VBAdG8Zm3x/1o7oJ5D0wTsoAXD2fw/gcA9+VR3fKojP9F40cQjC/
	 rWhxky6Lsr1bfzueP6qh/g5Kw0gnW20AKPUKscREdPpVddK64LTZFJhrshEIUMoOYfTJ6
	 DCGU4yWqfED9vVrqgGbm8lAk2jvqv7jGSrkBfaozrKUAJFlTrSTJ3XYQmkZ7nf3gjcYBo
	 8OxDTwXBCDrBzf8t7G8c5CLiDXf7c7IjVOOXVwZW5P6KuB2wwqWQrJgxlLW5MhZEdxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=KpEwWty65XIKqwE7JeJ6p16oyvStp8N2eZzOQMIZadI=;
	b=2uY4cuOuwC49gljTOpKST1RyVjGrn4ldNikscAIJ/Lhbq060SAv3EJxmgDSI5WOlbFif
	 zIilwwOzh2xrwtGXmgB2MBmy7luxYoiJAsWb/fB3eS0dhF1pJ+5CTl9jjxF0AYfiAEgqf
	 v9XNj0Zhm44S567gY7UasAWzbBnwmCBMv7dKetnScF8BnpD62jLCFMZ98pqf5Cat8DNZJ
	 5zqPvXtxFqpw4SX5Rb/9ujpcE4+DCpD0MUl4iaPgXJwcdn7OsKwjzEYZrF7G8kNpm9zUL
	 YfRNJNeB3wefVTQliVG+R9gh00Gg0edzgsfLHLGOudaW/5k6KHdn13lKzC7U9JUP9hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=fErt2oxi;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF4560A2606
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 15:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DF4560A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=fErt2oxi
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eabf243d05so658407e0c.2
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 07:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794323544; x=1794928344; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KpEwWty65XIKqwE7JeJ6p16oyvStp8N2eZzOQMIZadI=;
        b=fErt2oxix7FuW8mrPMI+TDmW/sfPxkkilbiGuCcI8IlTozvOOvoRjCOXP7IlWeS3ma
         xGKoQ2ztNQ0+YQI24R4VJJXZTewVjwwbJu8E1Qk3EpW5fA4fyPVKXro9zG9I/ymFC4c3
         Cz6SnI50jpmwBH0SfxvuAKpTsSdMD4hkV8ZewWVE2f389sx6gK5xnZPfMCFafk5VEnFz
         +xukaEN+ycBXZRBW71cPIOrtXJQBQjJGykRsOZd5NUOYQxRJBxDu/ZHdzJtCVmeZc7Jo
         lj8W9rl+i+MalLueuhhYZCgKsewajLwicgz55ksyTHWgaFvSxx5O8TLvKnw6F39wMSsk
         DGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323544; x=1794928344;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KpEwWty65XIKqwE7JeJ6p16oyvStp8N2eZzOQMIZadI=;
        b=dbiOXnH5nzlav/Ivke+QmGjTbsMmthuO6OhC4ncAUfH58F64su1Et6RglwJ10Bvajk
         TkcEzM8A7+XAuu8BmuSC3Gn2hogHDw3Q5NoJ2vwR8POVFYMsLIUSR4GhU5GcCIzqV5I/
         B8HG52UifEC1hF5pALFbGwMBPKzAUqPlXx6UjnzI3mTK2Dgd4QRZXhjYHK9QX8UubsLu
         maABfuLqnbU/J8Z1YRAqKl/EZN2WuBZS19TZJfNvXjPHxxv4EkecxsKD0yvZeVaPXoLY
         bs6ydsseml4oc8cI9LLiJLECWNmYQvmDZ29/0haUV98S06Es6srR7g8y94gNA2Ul08ey
         uwlA==
X-Forwarded-Encrypted: i=1; AL+hErGpHXQFRPdGo2Ep1wCgPl62YKXJhQkjoh2dX2flyPguUC8Yh34oLxKG9/E+uadLViUw5kgGSA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8vjUIITklwTnhKXo9E1fg4lbJCQNDKIMOpSBs0U4bhch/nkGsG
	kpfa9lr2Tq0XbBrXW1aueE8TNXbKlSsiiK3jeCRRkYmX1WP2wjlApXwxkycxB/RTYOE=
X-Gm-Gg: AYBFou03NTnVUobqYINTA4FZK6ZkWsuwWFyUyPBbetR78huvzfLrRneYASmONOXoaR0
	FiC6xxNxk5BbTVDQ6Cr6oa0lw4UlCoUdrzGOAVCesZHzJPWkGjWn1Pp+dNQMB/tJ2iCbfwUez4t
	gO0lQOz4RvxkOS6a9erdmO7pqoBviE4izKDVA5rmSxc7UqUlLPugP2WHVWl7Y506vf+8Dc5/guH
	87GLCkvJ6MPi/P8kROctM2RwioHfPkAhaPwyTnn+K4P2iI+XQQ+phlIzqPuznzI8g55V431vTB3
	9QrcMiUS/Nyx8qUJVDyWZ9BXKmOGw7PsEkCBVNtTA8rgNDp7yJoEivuFs9LUjC812udNgPaVrNk
	A2RF+KvVGrB6k4p0NRgpoY7KSGowHh53Rqa0svjyh3tAz7x/VJe1ievKF6VsRySr4UM4m0WAet6
	sCw+pj5EFlhZMscSsFmeyDi4Pd8qHVd6V9DW0bSDvDV+atRoMnoBOQBmd9p2H3sn9M7wyatVTI+
	sOPbbQor9qr/2OKLC01OX95FaMOBpXpBGgAvseg2DE45FMbjMyaAKEkIuI/+eH3otgWOSKDxoih
	euKz3n0GVd1DYnIDwiYtJGAzUvawrasCq87YCCkFNnRsMmyrDYXSpQWkHr3PwBz9ach+6zyBtot
	65RTXQ94OVejmkcr1+a6tkEEEPL/E
X-Received: by 2002:a05:6122:5313:b0:5ea:a0f0:192f with SMTP id 71dfb90a1353d-5ee0d0cd07bmr947867e0c.10.1794323544266;
        Tue, 10 Nov 2026 07:12:24 -0800 (PST)
Received: from localhost (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c45a110sm2039560e0c.2.2026.11.10.07.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 07:12:23 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 10:12:22 -0500
Message-Id: <DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI
 compatibility
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>,
 <seanjc@google.com>, <jgg@nvidia.com>, <loganodell@google.com>,
 <arnd@arndb.de>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <oupton@kernel.org>, <alex@shazbot.org>,
 <gle.com@google.com>, <pbonzini@redhat.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <kevin.tian@intel.com>, <joro@8bytes.org>
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-6-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-6-tarunsahu@google.com>

On Tue Nov 10, 2026 at 12:01 AM EST, Tarun Sahu wrote:

> +/**
> + * DECLARE_KHO_SER - Register a serialized payload structure with KHO.
> + * @name:         Structure tag name (e.g. luo_ser).
> + * @payload_size: Compile-time expected size of struct @name in bytes.
> + * @nr_required:  Total number of defined required features.
> + * @nr_optional:  Total number of defined optional features.
> + *
> + * Size and 8-byte alignment are asserted under CONFIG_64BIT: KHO and LU=
O are
> + * 64-bit only, while !CONFIG_KEXEC_HANDOVER stubs pull ABI headers into
> + * 32-bit builds where u64 has 4-byte or 2-byte alignment.
> + */
> +#define DECLARE_KHO_SER(name, payload_size, nr_required, nr_optional)	\
> +	static_assert(!IS_ENABLED(CONFIG_64BIT) ||			\
> +		      sizeof(struct name) =3D=3D (payload_size),		\
> +		      "struct " #name " size mismatch");		\
> +	static_assert(!IS_ENABLED(CONFIG_64BIT) ||			\
> +		      __alignof__(struct name) =3D=3D 8,			\
> +		      "struct " #name " must be 8-byte aligned");	\
> +	extern struct kho_ser_hdr __kho_ser_hdr_##name;			\

Remove this extern.

> +	enum {								\
> +		__KHO_SER_SIZE_##name =3D (payload_size),			\
> +		__KHO_SER_NR_REQUIRED_##name =3D (nr_required),		\
> +		__KHO_SER_NR_OPTIONAL_##name =3D (nr_optional),		\
> +	}
> +
> +/**
> + * DECLARE_KHO_SER_HDR - Declare a feature header variable, field, or pa=
rameter.
> + * @name: Structure tag name registered with DECLARE_KHO_SER().
> + * @decl: Declarator (e.g. *fhdr, **out_fhdr, or * inside DECLARE_KHOSER=
_PTR).
> + *
> + * Declares @decl with type struct kho_ser_hdr while checking at compile=
 time
> + * that @name was registered with DECLARE_KHO_SER(), documenting which
> + * serialized payload structure a feature header pointer belongs to.
> + */
> +#define DECLARE_KHO_SER_HDR(name, decl)	typeof(__kho_ser_hdr_##name) dec=
l

Remove DECLARE_KHO_SER_HDR, use kho_ser_hdr directly.

--=20
Pasha

