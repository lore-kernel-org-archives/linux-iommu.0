Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320637;
	b=qGEdqTGFvPLXYx26kMdq9aigNihUii7Kv5kNdsGLWbBi+63EOYdBKscFv2PjHS0qh9JW
	 Of2+iMb1q0gvhjTKWlmwpQQ40skQyoHHGqUSUe/tydI/qN4E7XoMHq6rlhQERACnamLc4
	 +ZEP5ETokBxeGhrPQGnfceukW6i4L7Ir0jcAvVWoLkj1gQpJESug8LH+CkC53XbvOSSmx
	 g4MqylhmOKDgSu1hcayEWk8WVl2t9haOeUNibnRkoq0g5VnI3U8vz2RUzo2gDOFKVi3xB
	 2lrdHpVNwaIq5rU9Z9zA0txATkUi1q9RcoHuEujgYoFetnmh5aRb3YTe9HI5navAlKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Kh3fWHtVs9ElLDXrVfG1M2iBA/DoCWf9txtZMpxB3YI=;
	b=EyVthhrtBtwNS54DERAmsMuaTy/ebkMXJyNS/F0xolkg7CJ8M10ZS2JPYtNNyKW2JCww
	 05Ek+VoSA1UbOaQQLfgZIfloDVB53kZw3yL+6HxlnDRBjblv7pcZqRukAM9pF1Q65JE7P
	 Zxj0C/0apig0ft+Jt2twEUAodzb3e2zkFmVfyT5AmLLCDi5wMG+qyjrDpq5O8kd3AV3oi
	 lfO27izqmkAaAOZKQUPci3qrHzaScYbl8z2eIbqyflCNbGbMSW7Uxhy9WT4o9Yq3GjGdp
	 kTkOwaevFKEOMSXAXFXWyJULVsVdUExd/ICtVQyQShspgl280cupeuYMkmwqI7avMhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=CX5CcdHT;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DEC606A335
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 14:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49DEC606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=CX5CcdHT
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-97ccbba8e86so542628241.3
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 06:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794320635; x=1794925435; darn=lists.linux.dev;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Kh3fWHtVs9ElLDXrVfG1M2iBA/DoCWf9txtZMpxB3YI=;
        b=CX5CcdHT+XoMHkqPnDf5Wnn5d3deTW2kXaMrnnDenVCQJB4jklhJseLM63Ad71XQCb
         Eqr27L4g05P3jBxePPnvOQy8yoK3QGzeo/jRoMvsmPbe1c2fUtFbNLdfjN0jd6YV7Gv3
         9pAf0J9ISMINWuJxx53ib56+GDq9tReqFqMwM7PY/JFctsCwHyqH9Y0h0V4tOD3IXpZg
         1Dxhn2630GABf49LvsHu7e0C9PfHJCdMInuPFYAR4ratF3iEEornY7i4A9XArult4XXL
         R8mGRJ8OS53P86CVu91Vh+ZJGAd+zTSqC83lvGHo3IgskMNvJGgQFD5IxGWfbGzAGsJX
         r9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320635; x=1794925435;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kh3fWHtVs9ElLDXrVfG1M2iBA/DoCWf9txtZMpxB3YI=;
        b=EiKxUnB1NAipZLOQVJz2kS55h01SXPunuDE0EeUGecvE/XBitooBD8ArImMaVuujRN
         9EXBwQIllOt2dkdlzdvGqaO4wgnjnz7a1jTUKK1V9Yc7GuDZ4zojU7LgxHHQWetEXltB
         AqJNa+AC8zj/0V1D4dZFCvZZHDEAArEcJWN2qWvgoSjTXxAYY3OcS1fOsOAWiGD4zUJw
         13U1wBg7QR7z6A3xF+nvqYZm0xsDniLU0nx+y3SuVuXn9nNsTEzbXPxR/av+nIS6Q/5P
         gOzBDBuY6y2q9kPxqEY2bAOd5++2s3GBmYDZiajEXJ0x4+n5si7jL0DGiuSnGxjIwPUT
         N9Mw==
X-Forwarded-Encrypted: i=1; AL+hErEFLzvGE/RUL1/H8UnJ7ndxIWMwy2IVGofbwYeoDtOpJjKCsUUfzrtgdXUlio9sHjqVYY5vgw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+3MSyzYL0znrFSGsWRzjHcuceZxtzCbYdLdf3DFx9rfp2+jQXk
	v8Or4Midp2fMAnmWdSBKkuw5aRJW4srBu55z5PDeRMYk2EIe7LvxeqJArL+SEMdhDOQ=
X-Gm-Gg: AYBFou1hxJGvAcUml/OQ+nfQPob4L1csn8MK9fZH4/sY2F+tKO7BsgxA0cd6eLzHbDK
	JL9IQs0vqUu7oXfQV24cuLWhyUICZbFPBy04oqYdaAoxkpNZf6XHYahM80ZMVMdJFl03k3u0hMM
	ts07rMr4N0FDjDHIrfJxjCod8Sg7/nHwBGW2UK/YxwWiVugT8Xwm3HlXdMzEYb+aZNr5Ujo+rFG
	YXiBOMnp6IOdshQjMVMR+F0HaDuFsrgUqncClm+VMPPT/zwCaBilQSB/Gv7d0XPSQc+yyzqrwkw
	7FCbGEBiJj5uM0MwcIAdra+H+gJwNcUIuG8lNbYUJKgZVJc5cv3RQOfVe93stYKMQgwAOvb928N
	FTLIBkgZBd6UyV03vFeJIRCjn7s0HpDN+GZLPe0HdKGCAqpHm34e9/xUCCFUvaCQnFdUxPMHgMp
	408fgnHU/el5wA1f/NHMmNrM+F5lfnEYEW8G48kuN5v/J0AKhSKJTL3ELt/6V7zbGL+ep84fHm1
	ohGXRlRmpiQ8GsT8GRM8HkJbXcN4NfAhqZUzdzFXICzYgGttoE3n7Th1IZXQ+c6Z8Vm0AARbgiB
	6W8xpjRmJ3s7xwcOEdZ070x42S7hReK0SM0TgdkId/E6ypGxdJJXrJRqUZFHhQu/iTnASG9pXds
	7yrsT/VclNzDmfiEsuVVjklu6IdxGlmVAmGUw5f+vvEzPIbs=
X-Received: by 2002:a05:6102:6050:b0:7cc:2cef:b341 with SMTP id ada2fe7eead31-7d301ac2767mr622566137.4.1794320634935;
        Tue, 10 Nov 2026 06:23:54 -0800 (PST)
Received: from soleen.c.googlers.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200838f0sm1837111241.9.2026.11.10.06.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:23:54 -0800 (PST)
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
Subject: Re: [PATCH v4 03/19] kho, memfd_luo: Reference struct kho_vmalloc
 via serialized pointer
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
In-Reply-To: <20261110050202.529473-4-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-4-tarunsahu@google.com>
Date: Tue, 10 Nov 2026 09:23:48 -0500
Message-Id: <179432062803.2329176.7220119921541924936.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7477;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=3MeQeXkemHu+Wr0/oMRB7Xn+2Je8r4E7OMIYcRodeqI=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq8yj5YKX9YmXwBRUiJpQxd2lEuERo2IgfqwM0l
 IVRH3L/L9qJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCavMo+QAKCRC7dyhM23N6
 3qK5D/9g7VLq2y8fSOMG0PAMp3BX67/XRkPN7ey3PFRx5aKMUM07RMgQmzWBgUvl2Q6gNiQzkn6
 PzGX64l/U3Obis7LYoXZVjFyU/Y1E3VsLm3pidkNnIIr4W6pd8fWOLQ1uNuf7+Y+ZNq3oJq7nS1
 4k2nRqLY7pzJAH9m8n6ub9XYCpLh3WeltCRtRINtCyceucFzMTRCUUdV2RUap7fL6Wumu3QX5eS
 8i1d0l/SPxERlsryDD5cCykkv2QXhHkfilL/BhVrMdy39RdMo4gj/FfTT94+11QgULuudAtccqO
 U5L/QQpjwNg9nTNZkz1PQTXGK0J2aU/renYZpknMh5BplqfPCYnmTetLfrBpsDzfgey8RLF8V/Y
 Eoh+ESh7BADOSLIg69tXGp+wnSKKHwkjEOC7OQCOwY9QDGPzUzCgkpdGdmzDoNKre2SpcvdIZAR
 CcygD2hatCPKtp7iIAcav0qx3mKfHiW2V//Tu09m5IEQ7l7pd0mWhE4svcffc3miVXPGWhYrqmd
 PVunIgq+xYFl+QWB7LvoZyaTxHcY3mbTkzsfJUXKDzZ/cqAhA8jR6w9agPlhIgaeGMrDR2m2MQg
 C6Ovc0HMEbvS0tj7Rg3+WW5boGrxb4k26c6jkEz95OlytA/VPaKEpi+/upamWNVJg+P9KkVBlDM
 /j4Qa87px1Kor9Q==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

> Subsystems preserving vmalloc allocations currently embed struct
> kho_vmalloc directly by value in their serialized structures or device
> tree properties. For example, struct memfd_luo_ser embeds struct
> kho_vmalloc folios, and test_kho writes the structure directly into the
> folios_info FDT property.
> 
> Embedding struct kho_vmalloc directly couples the containing layout's
> field offsets and size to struct kho_vmalloc. Any modification to struct
> kho_vmalloc shifts subsequent fields in the containing structure and
> breaks the handover ABI across kexec.
> 
> Convert callers to hold a DECLARE_KHOSER_PTR pointer to struct
> kho_vmalloc instead of embedding it by value. In memfd_luo, allocate the
> main structure and struct kho_vmalloc in the same preserved folio, placing
> struct kho_vmalloc in the remaining 8-byte-aligned space, and bump the
> compatibility string to memfd-v3. In test_kho, place struct kho_vmalloc
> in the remaining space of the FDT folio, store the serialized pointer in
> the folios_info property, and bump the compatibility string to
> kho-test-v2.
> 
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>
> diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
> index 6f12f5037ea5..bee75a7006e8 100644
> --- a/include/linux/kho/abi/kexec_handover.h
> +++ b/include/linux/kho/abi/kexec_handover.h
> @@ -11,6 +11,8 @@
>  #define _LINUX_KHO_ABI_KEXEC_HANDOVER_H
>  
>  #include <linux/bits.h>
> +#include <linux/build_bug.h>
> +#include <linux/kconfig.h>
>  #include <linux/log2.h>
>  #include <linux/math.h>
>  #include <linux/types.h>
> @@ -177,6 +179,10 @@ struct kho_vmalloc {
>  	unsigned short order;
>  };
>  
> +static_assert(sizeof(struct kho_vmalloc) == 16);
> +static_assert(!IS_ENABLED(CONFIG_64BIT) ||
> +	      __alignof__(struct kho_vmalloc) == 8);
> +
>  /**
>   * DOC: KHO persistent memory tracker
>   *
> diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
> index 376a724a1d8c..7b49dd6d7e2a 100644
> --- a/include/linux/kho/abi/memfd.h
> +++ b/include/linux/kho/abi/memfd.h
> @@ -81,7 +81,7 @@ static_assert(!IS_ENABLED(CONFIG_64BIT) ||
>   *             to directly use them in the ABI.
>   * @flags:     Flags for the file. Unused flag bits must be set to 0.
>   * @nr_folios: Number of folios in the folios array.
> - * @folios:    KHO vmalloc descriptor pointing to the array of
> + * @folios:    Pointer to KHO vmalloc descriptor for the array of
>   *             struct memfd_luo_folio_ser.
>   */
>  struct memfd_luo_ser {
> @@ -90,14 +90,14 @@ struct memfd_luo_ser {
>  	u32 seals;
>  	u32 flags;
>  	u64 nr_folios;
> -	struct kho_vmalloc folios;
> +	DECLARE_KHOSER_PTR(folios, struct kho_vmalloc *);
>  };
>  
> -static_assert(sizeof(struct memfd_luo_ser) == 48);
> +static_assert(sizeof(struct memfd_luo_ser) == 40);
>  static_assert(!IS_ENABLED(CONFIG_64BIT) ||
>  	      __alignof__(struct memfd_luo_ser) == 8);
>  
>  /* The compatibility string for memfd file handler */
> -#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v2"
> +#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v3"
>  
>  #endif /* _LINUX_KHO_ABI_MEMFD_H */
> diff --git a/lib/test_kho.c b/lib/test_kho.c
> index aa6a0956bb8b..cd0f183ff68e 100644
> --- a/lib/test_kho.c
> +++ b/lib/test_kho.c
> @@ -25,7 +25,7 @@
>  
>  #define KHO_TEST_MAGIC	0x4b484f21	/* KHO! */
>  #define KHO_TEST_FDT	"kho_test"
> -#define KHO_TEST_COMPAT "kho-test-v1"
> +#define KHO_TEST_COMPAT "kho-test-v2"
>  
>  static long max_mem = (PAGE_SIZE << MAX_PAGE_ORDER) * 2;
>  module_param(max_mem, long, 0644);
> @@ -34,7 +34,7 @@ struct kho_test_state {
>  	unsigned int nr_folios;
>  	struct folio **folios;
>  	phys_addr_t *folios_info;
> -	struct kho_vmalloc folios_info_phys;
> +	DECLARE_KHOSER_PTR(folios_info_phys, struct kho_vmalloc *);
>  	int nr_folios_preserved;
>  	struct folio *fdt;
>  	__wsum csum;
> @@ -47,13 +47,13 @@ static void kho_test_unpreserve_data(struct kho_test_state *state)
>  	for (int i = 0; i < state->nr_folios_preserved; i++)
>  		kho_unpreserve_folio(state->folios[i]);
>  
> -	kho_unpreserve_vmalloc(&state->folios_info_phys);
> +	if (KHOSER_LOAD_PTR(state->folios_info_phys))
> +		kho_unpreserve_vmalloc(KHOSER_LOAD_PTR(state->folios_info_phys));
>  	vfree(state->folios_info);
>  }
>  
>  static int kho_test_preserve_data(struct kho_test_state *state)
>  {
> -	struct kho_vmalloc folios_info_phys;
>  	phys_addr_t *folios_info;
>  	int err;
>  
> @@ -61,11 +61,10 @@ static int kho_test_preserve_data(struct kho_test_state *state)
>  	if (!folios_info)
>  		return -ENOMEM;
>  
> -	err = kho_preserve_vmalloc(folios_info, &folios_info_phys);
> +	err = kho_preserve_vmalloc(folios_info, KHOSER_LOAD_PTR(state->folios_info_phys));
>  	if (err)
>  		goto err_free_info;
>  
> -	state->folios_info_phys = folios_info_phys;
>  	state->folios_info = folios_info;
>  
>  	for (int i = 0; i < state->nr_folios; i++) {
> @@ -123,14 +122,19 @@ static int kho_test_prepare_fdt(struct kho_test_state *state, ssize_t fdt_size)
>  
>  static int kho_test_preserve(struct kho_test_state *state)
>  {
> -	ssize_t fdt_size;
> +	struct kho_vmalloc *folios_vmalloc;
> +	ssize_t fdt_size, alloc_size;
>  	int err;
>  
>  	fdt_size = state->nr_folios * sizeof(phys_addr_t) + PAGE_SIZE;
> -	state->fdt = folio_alloc(GFP_KERNEL, get_order(fdt_size));
> +	alloc_size = fdt_size + sizeof(struct kho_vmalloc);
> +	state->fdt = folio_alloc(GFP_KERNEL, get_order(alloc_size));
>  	if (!state->fdt)
>  		return -ENOMEM;
>  
> +	folios_vmalloc = folio_address(state->fdt) + fdt_size;
> +	KHOSER_STORE_PTR(state->folios_info_phys, folios_vmalloc);
> +
>  	err = kho_preserve_folio(state->fdt);
>  	if (err)
>  		goto err_free_fdt;
> @@ -234,7 +238,8 @@ static int kho_test_save(void)
>  
>  static int kho_test_restore_data(const void *fdt, int node)
>  {
> -	const struct kho_vmalloc *folios_info_phys;
> +	const DECLARE_KHOSER_PTR(*folios_info_phys, struct kho_vmalloc *);
> +	const struct kho_vmalloc *folios_vmalloc;
>  	const unsigned int *nr_folios;
>  	phys_addr_t *folios_info;
>  	const __wsum *old_csum;
> @@ -255,7 +260,11 @@ static int kho_test_restore_data(const void *fdt, int node)
>  	if (!folios_info_phys || len != sizeof(*folios_info_phys))
>  		return -EINVAL;
>  
> -	folios_info = kho_restore_vmalloc(folios_info_phys);
> +	folios_vmalloc = KHOSER_LOAD_PTR(*folios_info_phys);
> +	if (!folios_vmalloc)
> +		return -EINVAL;
> +
> +	folios_info = kho_restore_vmalloc(folios_vmalloc);
>  	if (!folios_info)
>  		return -EINVAL;

Why do we need DECLARE_KHOSER_PTR() in test_kho.c at all?

DECLARE_KHOSER_PTR() makes sense in shared ABI structs like struct 
memfd_luo_ser where both kernels reference the same struct field and get 
type checking between KHOSER_STORE_PTR() and KHOSER_LOAD_PTR().

Here, struct kho_test_state is purely local to the saving kernel and the 
handover ABI is just the "folios_info" FDT property carrying a u64 
physical address. Having two unrelated DECLARE_KHOSER_PTR() declarations 
doesn't buy any cross-kernel type safety

Can we drop DECLARE_KHOSER_PTR() here, keep a plain pointer in struct 
kho_test_state, serialize a u64 phys addr into the "folios_info" FDT 
property, and read it back as const u64 * + phys_to_virt() like the rest 
of the KHO FDT code?

-- 
Pasha

