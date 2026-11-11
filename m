Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378059;
	b=OH3W0SJ23QLthvBPPk7VIrZbSHNtbl8SMs8uLWxhxCGK5xlmGrrCGdX6kq946p7XVAig
	 0eoAyvQowG3tPYA/+dbquf57XtlnSrScrMD6rGxaUJeGJBaKTmkiIN7AaGCHx+ZeJB8s4
	 97Jtg8fdzwepoBN2YNOtZMuqGYoWSJx8ZBp2+01Y/ZOlu2QwJIYCY0fndvFIAffZLToub
	 uuQohuH7qaWgZhXodQsidPgHkrCaR3mXVPLGazEdcOebw6dfNBcYRjXXn6fGoVEOBdKIg
	 GRCo7XSHrGIoaeW4DNyUxuUo/D878CNDgO40R+Z1VwxoT5cJXoz8xJe+MteoQvhp3jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Up8Sxm5Z/vJlw6/f/g9Tue73jy4SQVTZi+t46heonUg=;
	b=HfI5QPHn0je8bXGr0tjYFcqt/8TifiU/BMgqG+K5XzhPr1xTqLC5dZX/moYfwmPA3Q/8
	 opO8shIujyC7dRpr0YTdj0a/40CAVfuc+bi16gBlr0CnP/Fdqj7gWbCaT1e/x0vwYJC8k
	 pIY+uasMa/WzTsjuAwtVgJfqsVY2IhlflplkudZyao7zNuaxUyc7N+eG4gSVLbE1QvYMr
	 5tZXWSLuPqHKo5v+r0xnkV9xjDCkROyOg59NFdoF1m5wU3HTbXv2NifAc7HThJ2I12XAt
	 gl8E99IiZCjZm1woGBdT0feO9TBeXyntM8ZdOm1joc7cL8tMx/nNGK4TL2y+MwL2gIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Bf8p7vqY;
	arc=none smtp.remote-ip=209.85.218.70
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C27F606A330
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 06:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C27F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Bf8p7vqY
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c504bdea834so111001766b.1
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 22:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794378056; x=1794982856; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Up8Sxm5Z/vJlw6/f/g9Tue73jy4SQVTZi+t46heonUg=;
        b=Bf8p7vqYrn3ACSZJ2/JIJLNvTULKhNicSqf72jOS7xFDbhslgE7qRdB9puHnb5QxYi
         3gRywfhqaallED+6oWl21H3yp0jqYZpbMWlGC2wcS63QbDshI1JYoBxjdI3GxmXlNUjL
         95M1ssTP8re/rOc1QK2rb8X29HJy2wv+9/rNcKLBnT/hCC2WKgLFCONyUcDGMlIsQBQK
         cQ8802kiRSt216PQitYpp6c56YY7puMH6gEemcqIuFz1x2f4F2oPlWe6/a4tmuciBmiT
         lQ9zbyCmLsnUxtp3rDsySFbb5Ldx/zpmZxlP6Zl2u7j9y9bofKdp42eoB7vomhjEQ5GV
         r/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794378056; x=1794982856;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Up8Sxm5Z/vJlw6/f/g9Tue73jy4SQVTZi+t46heonUg=;
        b=cKQOFZNns/CLcZK8+IpYTXX2A461NiNAQIz3VBsnMCv5HirmXzIl8WFDnDzds1FcA4
         4VK+Pya6l6OIEKdRAJUPKyHu5ge/8E19Aiob1RdAAOl+sXz2nsGoiNcWNSt4HVZ50Fab
         4U+E3Q+bFAiNvkNhN1sB1//Aum4bNSkEo9yEjymmnZ+ioX59SwoqVV9loLkhQcNM2spn
         9FXTfgHBrgcYMD0LgANDzV2qSTr57stMsLdm/L8L9U3eY7ddloEf7H1LWO/f1mioJNtJ
         pYFNU6wrRGvj80wH+FTJgDQ1ajUoS1KawXdBIje/nuDlK1co5l2SK9DB/5j6WJNGD2/R
         ZpMA==
X-Forwarded-Encrypted: i=1; AL+hErGet1YG5jVLCBeBfUsUOJLq1/HaKVb5Qtxf1XtpwrFIS0ODC7VokqCE6c0OQ16syFCdfsl/dg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8qBDpOYAaU+4+0ygGIUwoiz69X0OniAovkXOaYWuLr7kRjGxkd
	b6K3QVOOgooP9V40tOjLCwBm24x0of+CsWfHYpn3m1HULdmmc/cADOG7g0+VLMmIhwQXJFXIBPr
	xmFAxWS7RV8n31+jBLg==
X-Received: from ejcuu11-n1.prod.google.com ([2002:a17:907:c60b:10b0:c3f:fb8f:67f3])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3e8b:b0:c31:8c48:e18b with SMTP id a640c23a62f3a-c5066aa85bemr101254666b.14.1794378056032;
 Tue, 10 Nov 2026 22:20:56 -0800 (PST)
Date: Wed, 11 Nov 2026 06:20:55 +0000
In-Reply-To: <179432062803.2329176.7220119921541924936.b4-review@b4>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com> <20261110050202.529473-4-tarunsahu@google.com>
 <179432062803.2329176.7220119921541924936.b4-review@b4>
Message-ID: <9huzy0azq46w.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 03/19] kho, memfd_luo: Reference struct kho_vmalloc via
 serialized pointer
From: tarunsahu@google.com
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org, 
	kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Pasha Tatashin <pasha.tatashin@soleen.com> writes:

>> Subsystems preserving vmalloc allocations currently embed struct
>> kho_vmalloc directly by value in their serialized structures or device
>> tree properties. For example, struct memfd_luo_ser embeds struct
>> kho_vmalloc folios, and test_kho writes the structure directly into the
>> folios_info FDT property.
>> 
>> Embedding struct kho_vmalloc directly couples the containing layout's
>> field offsets and size to struct kho_vmalloc. Any modification to struct
>> kho_vmalloc shifts subsequent fields in the containing structure and
>> breaks the handover ABI across kexec.
>> 
>> Convert callers to hold a DECLARE_KHOSER_PTR pointer to struct
>> kho_vmalloc instead of embedding it by value. In memfd_luo, allocate the
>> main structure and struct kho_vmalloc in the same preserved folio, placing
>> struct kho_vmalloc in the remaining 8-byte-aligned space, and bump the
>> compatibility string to memfd-v3. In test_kho, place struct kho_vmalloc
>> in the remaining space of the FDT folio, store the serialized pointer in
>> the folios_info property, and bump the compatibility string to
>> kho-test-v2.
>> 
>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>>
>> diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
>> index 6f12f5037ea5..bee75a7006e8 100644
>> --- a/include/linux/kho/abi/kexec_handover.h
>> +++ b/include/linux/kho/abi/kexec_handover.h
>> @@ -11,6 +11,8 @@
>>  #define _LINUX_KHO_ABI_KEXEC_HANDOVER_H
>>  
>>  #include <linux/bits.h>
>> +#include <linux/build_bug.h>
>> +#include <linux/kconfig.h>
>>  #include <linux/log2.h>
>>  #include <linux/math.h>
>>  #include <linux/types.h>
>> @@ -177,6 +179,10 @@ struct kho_vmalloc {
>>  	unsigned short order;
>>  };
>>  
>> +static_assert(sizeof(struct kho_vmalloc) == 16);
>> +static_assert(!IS_ENABLED(CONFIG_64BIT) ||
>> +	      __alignof__(struct kho_vmalloc) == 8);
>> +
>>  /**
>>   * DOC: KHO persistent memory tracker
>>   *
>> diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
>> index 376a724a1d8c..7b49dd6d7e2a 100644
>> --- a/include/linux/kho/abi/memfd.h
>> +++ b/include/linux/kho/abi/memfd.h
>> @@ -81,7 +81,7 @@ static_assert(!IS_ENABLED(CONFIG_64BIT) ||
>>   *             to directly use them in the ABI.
>>   * @flags:     Flags for the file. Unused flag bits must be set to 0.
>>   * @nr_folios: Number of folios in the folios array.
>> - * @folios:    KHO vmalloc descriptor pointing to the array of
>> + * @folios:    Pointer to KHO vmalloc descriptor for the array of
>>   *             struct memfd_luo_folio_ser.
>>   */
>>  struct memfd_luo_ser {
>> @@ -90,14 +90,14 @@ struct memfd_luo_ser {
>>  	u32 seals;
>>  	u32 flags;
>>  	u64 nr_folios;
>> -	struct kho_vmalloc folios;
>> +	DECLARE_KHOSER_PTR(folios, struct kho_vmalloc *);
>>  };
>>  
>> -static_assert(sizeof(struct memfd_luo_ser) == 48);
>> +static_assert(sizeof(struct memfd_luo_ser) == 40);
>>  static_assert(!IS_ENABLED(CONFIG_64BIT) ||
>>  	      __alignof__(struct memfd_luo_ser) == 8);
>>  
>>  /* The compatibility string for memfd file handler */
>> -#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v2"
>> +#define MEMFD_LUO_FH_COMPATIBLE	"memfd-v3"
>>  
>>  #endif /* _LINUX_KHO_ABI_MEMFD_H */
>> diff --git a/lib/test_kho.c b/lib/test_kho.c
>> index aa6a0956bb8b..cd0f183ff68e 100644
>> --- a/lib/test_kho.c
>> +++ b/lib/test_kho.c
>> @@ -25,7 +25,7 @@
>>  
>>  #define KHO_TEST_MAGIC	0x4b484f21	/* KHO! */
>>  #define KHO_TEST_FDT	"kho_test"
>> -#define KHO_TEST_COMPAT "kho-test-v1"
>> +#define KHO_TEST_COMPAT "kho-test-v2"
>>  
>>  static long max_mem = (PAGE_SIZE << MAX_PAGE_ORDER) * 2;
>>  module_param(max_mem, long, 0644);
>> @@ -34,7 +34,7 @@ struct kho_test_state {
>>  	unsigned int nr_folios;
>>  	struct folio **folios;
>>  	phys_addr_t *folios_info;
>> -	struct kho_vmalloc folios_info_phys;
>> +	DECLARE_KHOSER_PTR(folios_info_phys, struct kho_vmalloc *);
>>  	int nr_folios_preserved;
>>  	struct folio *fdt;
>>  	__wsum csum;
>> @@ -47,13 +47,13 @@ static void kho_test_unpreserve_data(struct kho_test_state *state)
>>  	for (int i = 0; i < state->nr_folios_preserved; i++)
>>  		kho_unpreserve_folio(state->folios[i]);
>>  
>> -	kho_unpreserve_vmalloc(&state->folios_info_phys);
>> +	if (KHOSER_LOAD_PTR(state->folios_info_phys))
>> +		kho_unpreserve_vmalloc(KHOSER_LOAD_PTR(state->folios_info_phys));
>>  	vfree(state->folios_info);
>>  }
>>  
>>  static int kho_test_preserve_data(struct kho_test_state *state)
>>  {
>> -	struct kho_vmalloc folios_info_phys;
>>  	phys_addr_t *folios_info;
>>  	int err;
>>  
>> @@ -61,11 +61,10 @@ static int kho_test_preserve_data(struct kho_test_state *state)
>>  	if (!folios_info)
>>  		return -ENOMEM;
>>  
>> -	err = kho_preserve_vmalloc(folios_info, &folios_info_phys);
>> +	err = kho_preserve_vmalloc(folios_info, KHOSER_LOAD_PTR(state->folios_info_phys));
>>  	if (err)
>>  		goto err_free_info;
>>  
>> -	state->folios_info_phys = folios_info_phys;
>>  	state->folios_info = folios_info;
>>  
>>  	for (int i = 0; i < state->nr_folios; i++) {
>> @@ -123,14 +122,19 @@ static int kho_test_prepare_fdt(struct kho_test_state *state, ssize_t fdt_size)
>>  
>>  static int kho_test_preserve(struct kho_test_state *state)
>>  {
>> -	ssize_t fdt_size;
>> +	struct kho_vmalloc *folios_vmalloc;
>> +	ssize_t fdt_size, alloc_size;
>>  	int err;
>>  
>>  	fdt_size = state->nr_folios * sizeof(phys_addr_t) + PAGE_SIZE;
>> -	state->fdt = folio_alloc(GFP_KERNEL, get_order(fdt_size));
>> +	alloc_size = fdt_size + sizeof(struct kho_vmalloc);
>> +	state->fdt = folio_alloc(GFP_KERNEL, get_order(alloc_size));
>>  	if (!state->fdt)
>>  		return -ENOMEM;
>>  
>> +	folios_vmalloc = folio_address(state->fdt) + fdt_size;
>> +	KHOSER_STORE_PTR(state->folios_info_phys, folios_vmalloc);
>> +
>>  	err = kho_preserve_folio(state->fdt);
>>  	if (err)
>>  		goto err_free_fdt;
>> @@ -234,7 +238,8 @@ static int kho_test_save(void)
>>  
>>  static int kho_test_restore_data(const void *fdt, int node)
>>  {
>> -	const struct kho_vmalloc *folios_info_phys;
>> +	const DECLARE_KHOSER_PTR(*folios_info_phys, struct kho_vmalloc *);
>> +	const struct kho_vmalloc *folios_vmalloc;
>>  	const unsigned int *nr_folios;
>>  	phys_addr_t *folios_info;
>>  	const __wsum *old_csum;
>> @@ -255,7 +260,11 @@ static int kho_test_restore_data(const void *fdt, int node)
>>  	if (!folios_info_phys || len != sizeof(*folios_info_phys))
>>  		return -EINVAL;
>>  
>> -	folios_info = kho_restore_vmalloc(folios_info_phys);
>> +	folios_vmalloc = KHOSER_LOAD_PTR(*folios_info_phys);
>> +	if (!folios_vmalloc)
>> +		return -EINVAL;
>> +
>> +	folios_info = kho_restore_vmalloc(folios_vmalloc);
>>  	if (!folios_info)
>>  		return -EINVAL;
>
> Why do we need DECLARE_KHOSER_PTR() in test_kho.c at all?
>
I tried to keep the kho_vmalloc reference after kho_ser_hdr to be
same at every places. But Now I realized it is completely unnecessary.

> DECLARE_KHOSER_PTR() makes sense in shared ABI structs like struct 
> memfd_luo_ser where both kernels reference the same struct field and get 
> type checking between KHOSER_STORE_PTR() and KHOSER_LOAD_PTR().
>
> Here, struct kho_test_state is purely local to the saving kernel and the 
> handover ABI is just the "folios_info" FDT property carrying a u64 
> physical address. Having two unrelated DECLARE_KHOSER_PTR() declarations 
> doesn't buy any cross-kernel type safety
>
> Can we drop DECLARE_KHOSER_PTR() here, keep a plain pointer in struct 
> kho_test_state, serialize a u64 phys addr into the "folios_info" FDT 
> property, and read it back as const u64 * + phys_to_virt() like the rest 
> of the KHO FDT code?

Yes,Agree. I will update it. Thanks!

~Tarun
>
> -- 
> Pasha
