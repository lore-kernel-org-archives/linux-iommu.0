Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323301;
	b=L0OEVIo6upd9sNtMcHswNrjKMW6BpUwSIfVysxkngQ9tgbldswwgC4/TX4CS6QUNgP1n
	 2dPVu7PjxPz8VRpbneiILCiCl8b/QO7lLn/rCPpW2j0IfuD9V7z+TVJQAT1zGJ66F/GW9
	 rxGLowZgBqGWmfU1Se+uqMmRPaD9moZ8xDh30KORioIyektL/VPhKpms8zF4+uTJdwsTk
	 Lc/DHi9Wx9GAWevP9MJDz1jwrUqzl5nskNS4R6HL/oJt5GPJGkY1fHZZgWq6ehLLjYtQP
	 Xa6qE6yUc1G18N+t6pxJeFHVgGp8XiChxcIomOW2EYjLc2MRNlpJPInPLespZA+9SMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=WKAEhFQ+Dah3DMHVjGDEQ1FI4504gN8wbhTTvAQenls=;
	b=2rcXxycPZOxOWGcYlNkcDgyvM/tM1oRiXk1bg2zvMf68AYM5fA3zT4kuzwZwzBSyf1l/
	 B/JUZk/ZePTpL3JTClc8Cd3Fj53zy8gHbcqJeKYazP2sYT62DY+ciWNHdCIRMx6KmbLv7
	 ZGHbXgcazYKFPC/z1O1Cbg8OcH+7WpDJ5u1nIyRnpPqEsaDrVP5zxI9MmxztvJDeF+iLN
	 GjuVnYAxRO6tubNF30ZhU3EEvRuA11Rba4qNcEmwJT7CMHEcK+HWOaczOd9GyYsuLzBir
	 z9UIZbKsZhg7yJt5JwTWqA8eQSDtFcfT0LZrSKXjuvYxreZp3JN75rDR5NY6LzpMwLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=RJIHR6vY;
	arc=none smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8165B60A2603
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 15:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8165B60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=RJIHR6vY
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9908c849564so582038241.3
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 07:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794323300; x=1794928100; darn=lists.linux.dev;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WKAEhFQ+Dah3DMHVjGDEQ1FI4504gN8wbhTTvAQenls=;
        b=RJIHR6vYQK9u4BNw99+gUVSKOihYtxgoSHW/pnHg4ACrJ/OqlV2s2u/TjsXk2xI07g
         DPqz7XNLNSxo54Njab4cmEpvHm9WTp7MRVwKekTOZswi6Q2Oxynn1PRavfXPWh19FoFn
         vaeYttQkg0os4wqhmo7Lnot0ceLOlEMbZpKcLmHs+Ol36Kb535eyyr6ITT0OtVRQpOdi
         KrW10pw7+qysnHruXVBZbySKT2ze3bO2K0o6FAbY0gXIv3XRYRFxOqRfV9Yvpmdeym6M
         AaT1mVLrLxz0gz9ws2N2qvzGZagw7rKy3RXIwy/1D5ZaXsIKDY5xQnRhv68SKR+rgjVq
         5d0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323300; x=1794928100;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WKAEhFQ+Dah3DMHVjGDEQ1FI4504gN8wbhTTvAQenls=;
        b=X9vFkH7DGm/XgeapSoP6BE1tl5Qxzn9eq8Y18a2PwmM74/PVRajMpF90XAseCn53iG
         HoeKbIFJ9VJBv/lvOhK7UJ18dKH+6AMscDlQsQ+exNtDlCGFPKhd8eFb5G/RlxJhA7yn
         PlkjYhDDBwdR6z58QBDBQPc4wNco/VFDKak8mY+huGs6lVb8TeryIqJXb1BCcozB47F7
         Zi+4Cu/qG6N4tREd8E4OBW5e0B1bzuG8BUG+VzFj8Sgty3qjOlPXJt3MDAkLHqCwS1/m
         BWzu6abzQAKqFxyvd2IW1SRUM2t2XFL5rfG0zpRVApqP5BJlRXg593zU15twy6eDXnh6
         ylpg==
X-Forwarded-Encrypted: i=1; AL+hErEbScfLk9rrXpYbC6TtbW/7cCj8DtSQRT3/xNzxo4olpYu8LWFPd1xT6pp4k/yfr8U5ujeLXw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+L92mKORPiZwuE5fpjT7qu+HIUgMn6IPNqKubdHW/ox5XLJWh7
	cp9rKqSDCgLg8VDmEnbAt9mii15AZsmbUHFOJeMXaqUa+hcTtnqnCz2P0JMzkEEERRQ=
X-Gm-Gg: AYBFou2Q9vBzgp8/dCzrnZ8r6Do4AoFZGzXmeqthyGbOplQka9LPeu9Kj1hPL91OIyc
	t5h9KKvM2SeqBzAkPNDrcM7JDWQp4PXWrH7lScsg1m9r95fzTJF5yBf92bxw4+Jn4TTveonj/Xp
	rcmGnCgSgn6JeGHsh2wHEma+RKf/sn4fLI1oDE2QHdA9YwOrzbnwh+nuLAhVEw6DETx5hq805SB
	w4TKqnANUAIXqWaLl9iCyruf46fpHsZuASHx+B9t5DFhpjAQd8n6KVckYBd7c61sHIzDVxAzmry
	UZfaSpi8ecikNwJRoo0iScTV+pAxSASewkWn5rKWjHIkTtyvdkK1a08GXstMtiXAE/HhUc8+Yc7
	9nP1X+ZLMWmjn3sMHhScxItnwqhLYBxD2cUuDmOtcs6YkXesqqcSd9Z/+sDqM1V+QS2CWi6kDQl
	bn/GZwLwHjxdXCfGpr6+mYr8kGy06R7Ur87KmfcVEC/41tnkS5UHMIdn2wwx+wGbb3439Ghe1lF
	fWBnyChENNtMWaWyum+XfHRJCUngtnGB3XzbRtKrtLV8BrZm5P9gVwFZ6rbVjKoSE2Sty1/lSp/
	Jw8D0CFk2z9bu/2l6ntT/BN1ogj8l1eA3ND9WGACGtc+4WrujFMpBf0ffjfVX+TYLMgXBhNzMzG
	vJkI9FEqLtGUttz/e5OxbGfP5sI8l37ZctFXH8gVJlXwB
X-Received: by 2002:a05:6122:468c:b0:5da:a74:d6a4 with SMTP id 71dfb90a1353d-5ee0d1254cdmr983516e0c.15.1794323299946;
        Tue, 10 Nov 2026 07:08:19 -0800 (PST)
Received: from soleen.c.googlers.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c1fffe63asm1965122241.4.2026.11.10.07.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:08:18 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 06/19] kho: kexec_metadata: Add the feature header
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, 
 will@kernel.org, David Matlack <dmatlack@google.com>, 
 Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, 
 loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, 
 baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>, 
 oupton@kernel.org, alex@shazbot.org, gle.com@google.com, 
 pbonzini@redhat.com, Andrew Morton <akpm@linux-foundation.org>, 
 kevin.tian@intel.com, joro@8bytes.org, kvmarm@lists.linux.dev, 
 linux-pci@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
 kexec@lists.infradead.org, kvm@vger.kernel.org, iommu@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, skhawaja@google.com, sagis@google.com, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261110050202.529473-7-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-7-tarunsahu@google.com>
Date: Tue, 10 Nov 2026 10:08:12 -0500
Message-Id: <179432329215.2329176.14453669404153142360.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3169;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=QPKh6oqVuep5a0uq5kk2HJ+pkn4UzCARnNzVJdUZk/E=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq8zNhLa8G7KPQhtpqNqIaC7iUSrItiw95IH4+W
 4FZp+mLRNmJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCavMzYQAKCRC7dyhM23N6
 3ixyD/9hSlVPu6pn+Usl6EKxRh1wkp2nNTAGfSwd0T80brdKlRNG7a8mQqhUQi1H7cXmovyHBUq
 ES73eQCtV9EEqD3V+9mhbM/vQ3DNxapFoBftgUpOKocv/TyzS+fnYCCd+V4qkZp6JbEE04DX5ph
 RXIIzYY1cOoM3lIFUa3WAKuQ5IlLTqUrcCnmCGDDA2ABc3Dn4YGxVfA+j1TEgs3i5/pZ3Jg6vPm
 2w2Rki59ZZh1OvjNwqaQcNxFUaUzOua2A1T1C5uWqXUw29+H364g+FPC9TsTFighlf5Dm5nInFm
 sy05T7yV7PmS1d4eRFn5VjWQo2hboOwrVmB5E3sLTnbZ+oXkY0TgWbPqKYlXfKYQ1RF1dttkf3y
 L666oJVxxNOxQuWbB80WyaaQp1G11CUhLjsRBaxuJqYWD3LuhT6NKGc7rkKJ+4Y1QHbv77qrsL0
 xU62OLvV+UYlxbDgjPM1r4q1njY/2zmio3uMBSt4oubrAmtiUMAW6J6dY86mFHlcm8xgbSUbn5B
 HOb83UbLMhoMCV4Zf4R9ofmr8Zb5PO+Ieg4+UAv33DElEYGHzsZJuh7rv0KDrtHn6JA4zqY3vNY
 KpfJSWU9gzyoa94bAOMSWiRRC/83AeXcMfiQw7G8I+bNVH6Sm/Q6RfvqXkiiTkw9BXIWwqNbXQH
 2NBA/068NaYZqOw==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

> The kexec metadata subtree currently uses a monolithic u32 version field
> to identify the metadata structure layout. Any change to the structure,
> even an optional additive field, requires incrementing the version and
> breaks compatibility between adjacent kernels.
> 
> Replace the u32 version field in struct kho_kexec_metadata with
> struct kho_ser_hdr using DECLARE_KHO_SER. Later fields can be appended
> under new feature indices without breaking compatibility across kexec.
> Also make the 3-byte padding hole between previous_release and kexec_count
> explicit as reserved[3].
> 
> During deserialization, validate the blob size against the header size
> and reject unknown required features. A legacy v1 metadata blob is
> ignored with a warning.
> 
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>
> diff --git a/include/linux/kho/abi/kexec_metadata.h b/include/linux/kho/abi/kexec_metadata.h
> index e9e3f7e38a7c..316b3e5ad01b 100644
> --- a/include/linux/kho/abi/kexec_metadata.h
> +++ b/include/linux/kho/abi/kexec_metadata.h
> @@ -18,28 +18,31 @@
>  #ifndef _LINUX_KHO_ABI_KEXEC_METADATA_H
>  #define _LINUX_KHO_ABI_KEXEC_METADATA_H
>  
> +#include <linux/build_bug.h>
> +#include <linux/kho/abi/feature.h>
>  #include <linux/types.h>
>  #include <linux/utsname.h>
>  
> -#define KHO_KEXEC_METADATA_VERSION 1
> -
>  /**
>   * struct kho_kexec_metadata - Kexec metadata passed between kernels
> - * @version: ABI version of this struct (must be first field)
>   * @previous_release: Kernel version string that initiated the kexec
> + * @reserved: Reserved for structure alignment; must be zero
>   * @kexec_count: Number of kexec boots since last cold boot
>   *
> - * This structure is preserved across kexec and allows the new kernel to
> + * This structure is preserved across kexec and allows the target kernel to
>   * identify which kernel it was booted from and how many kexec reboots
> - * have occurred.
> + * have occurred. Preceded by &struct kho_ser_hdr.
>   *
>   * __NEW_UTS_LEN is part of uABI, so it safe to use it in here.
>   */
>  struct kho_kexec_metadata {
> -	u32 version;
>  	char previous_release[__NEW_UTS_LEN + 1];
> +	u8 reserved[3];
>  	u32 kexec_count;
> -} __packed;
> +} __aligned(8);

Why __packed was not removed in the first commit? __aligned(8) should 
not be needed, given that it must follow DECLARE_KHO_SER which is 8-byte 
aligned.

> +
> +/* Register kho_kexec_metadata with KHO serialization accessors */
here and in all other places, please remove this comment.

> +DECLARE_KHO_SER(kho_kexec_metadata, 72, 0, 0);
>  
>  #define KHO_METADATA_NODE_NAME "kexec-metadata"
>  
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 6f1f55fe3181..2edd772bb6d3 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1740,6 +1740,7 @@ static __init int kho_out_fdt_setup(void)
>  
>  static void __init kho_in_kexec_metadata(void)
>  {
> +	DECLARE_KHO_SER_HDR(kho_kexec_metadata, *fhdr);

Please don't do this, use kho_ser_hdr directly.

-- 
Pasha

