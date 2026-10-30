Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336364;
	b=e3oJQuFtGom8IeXqNzVbkkGr6T7BxpkK+PCzLY9F0JTxBfstRxGpFWSEkwAUM/AcFitL
	 iNvsk3FNnp0p5yWppPpUhhIFCepsROL28a0Zz3WfND19EM07CRtmQIfWCAUnHBmLmK4PO
	 MZCfCqiHrlTCPu2LWG+f/VJWU2kiESbFry4z5oDbSrohuyiG7KptBv+yESzFOcP+KJbOn
	 ad05eLiLz6GTKqk43rjzVrHRL0h+QIhH8s828V4AYzcBxyvucwmgzeLAs7yrhA3EXJUO9
	 YIl4urF2VtucC6rt8WrEvEwV4qK4ITEjFtkUJt5mivXUXCub5B0JhgaCglhfC37haSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336364;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=0zUjVWLF5PXtLzAudZi15itmOHipn0n12lIE9/19W1o=;
	b=s0CYXhKes6VVcj19JwhPtNwGIc8P9Bc5PEJBKKiMdrpfP5zPBPUgT4mdEx5LqWMGxMAY
	 FjI/kjx7l5KlN9r0P3t4Ba2kvXeHLbjxLLdZKC/0dOHrMdiGHc6HaxJifhd3BqvtRuuwA
	 nfthnIhALCf6i+IY4ttR94IR9kGqd4ACu4GI8Q6Uhw1cj/3oWzOg6FkNml0wAnjBpVULR
	 sBsus6ahMCZHAkCkSCFzeZG2Xg+bgjTPqPnoj5DlS3CA0GgFp3d4b8zK9n048qIvS2AVj
	 Hfxas20+ug1pqEcRhbkhpoW6NqYKwfgXN4bGLw4DrLg+Yyv/e2ABASA7B2qZ/OAqR2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=di8YMlMl;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5370C606A31D
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 04:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5370C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=di8YMlMl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1B82940E050A;
	Fri, 30 Oct 2026 04:59:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1tM-tdFSvD5Y; Fri, 30 Oct 2026 04:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1793336356; bh=0zUjVWLF5PXtLzAudZi15itmOHipn0n12lIE9/19W1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=di8YMlMlRdM6OXgt92tOrIG4JIdM4DzPtQv0gQADCrfCQs9s8BW1ysSE7sGUW5YzI
	 moMDij4boj03QFl52SF4IO/flfxoVgc5k8FQ6E+mDbkionBRwgYGQZ3JnTSkp6M4PN
	 WMdJVPCQpzHDXS61annpzAGKz6XAwzXgVE4KgGTOsCXTTDE924ApPsxRgxraSZ3Uth
	 ehg9yVEX9kHfRlV56Wz6+eYoz5ylCzmoR/yAPzVeUHII/KrOFrNCquZMVwqXVXbN19
	 cMKCJ9G1YLPzMyqDuG3Kfqz44oHCaO4vuoXLJkyUoZKLOFqX+V3yMLOKbrxMGK3h8i
	 rA1fqlcV4luHL8QCC64QAyfufgYFbp+oQnkbQ1x65T20knjoAUyRHeOY4Wz1pQHFMB
	 ll0mNTzdYsoJP354TXxbL8Vte/iPMD3cEAtJxzw58LwxpjeJpf0Mj1hlONVfDxgZxy
	 HalKtrtCSYljJLMORqeBlyuVUoaLx1cI5UCsaL2F7+IbkQaQmQcCKySTQYKIWiQkvK
	 +b8Fr2fZWtdW8RUMMX+E20x7GopN/wGgerQxMGYotM943RtXwS/kDoEjdL98ZRlIHI
	 N/4U4ozijhjmk5qPy0FehyBrcd1cOj8GyfJjWVt3yZwhQGVLzk6NNTiVoiYbjf9Fmq
	 oeQznu4wmLdChk7erkt68DIk=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A78140E04D6;
	Fri, 30 Oct 2026 04:59:03 +0000 (UTC)
Date: Thu, 29 Oct 2026 21:59:00 -0700
From: Borislav Petkov <bp@alien8.de>
To: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>,
	Ning Sun <ning.sun@intel.com>,
	Michal Camacho Romero <michal.camacho.romero@intel.com>,
	x86@kernel.org, iommu@lists.linux.dev,
	tboot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Mateusz Mowka <mateusz.mowka@intel.com>,
	Adam Pawlicki <adamx.pawlicki@intel.com>,
	Pawel Randzio <pawel.randzio@intel.com>
Subject: Re: [PATCH v7 1/2] x86/tboot: Add support for parsing DTPR table and
 disabling TPRs
Message-ID: <20261030045900.GIauQkFDfs6GnUks0B@fat_crate.local>
References: <cover.1793273244.git.michal.camacho.romero@linux.intel.com>
 <8549af9ea60b73e120be377877c26d929f1ad25e.1793273244.git.michal.camacho.romero@linux.intel.com>
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
In-Reply-To: <8549af9ea60b73e120be377877c26d929f1ad25e.1793273244.git.michal.camacho.romero@linux.intel.com>

On Thu, Oct 29, 2026 at 12:57:26PM +0100, Michal Camacho Romero wrote:
> Tested-by: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>

I sure hope you did test it... :-)

In any case, you don't need to add that tag to your own patch as that is
implied.

Reality tells a different story, unfortunately... :-/

> Signed-off-by: Michal Camacho Romero <michal.camacho.romero@intel.com>
> ---
>  arch/x86/kernel/tboot.c | 515 ++++++++++++++++++++++++++++++++++++++--
>  include/linux/tboot.h   |  28 ++-
>  2 files changed, 523 insertions(+), 20 deletions(-)

Below only stylistic issues we pay attention to in the tip tree. Pls have
a look at 

https://docs.kernel.org/process/maintainer-tip.html

and fix up coding style to adhere to the tip tree's standard.

> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
> index 46b8f1f16676e..47da21ad0f3e2 100644
> --- a/arch/x86/kernel/tboot.c
> +++ b/arch/x86/kernel/tboot.c
> @@ -18,6 +18,7 @@
>  #include <linux/mm.h>
>  #include <linux/tboot.h>
>  #include <linux/debugfs.h>
> +#include <acpi/actbl1.h>
>  
>  #include <asm/realmode.h>
>  #include <asm/processor.h>
> @@ -42,6 +43,15 @@ static struct tboot *tboot __read_mostly;
>  
>  static u8 tboot_uuid[16] __initdata = TBOOT_UUID;
>  
> +/* Global pointer to TXT HEAP base */
> +static void __iomem *txt_heap;
> +
> +/* Global pointer to the DTPR table */
> +static struct acpi_table_dtpr *dtpr;
> +
> +/* Number of active TPRs */
> +static s64 num_of_enabled_tprs;
> +
>  bool tboot_enabled(void)
>  {
>  	return tboot != NULL;
> @@ -223,6 +233,143 @@ static int tboot_setup_sleep(void)
>  
>  #endif
>  
> +static bool tboot_check_txt_heap_section_bounds(const u64 heap_end,
> +						void *heap_section,
> +						u64 *heap_section_size,
> +						const char *section_name)

Are those aligned on the opening brace? Check all our patches pls.

> +{
> +	if (!heap_section) {
> +		pr_err("%s section is NULL\n", section_name);
> +		return false;
> +	}
> +
> +	if (!heap_section_size) {
> +		pr_err("%s section size pointer is NULL\n", section_name);
> +		return false;
> +	}
> +
> +	*heap_section_size = 0;
> +
> +	if ((u64)heap_section > heap_end || heap_end - (u64)heap_section < 8) {
> +		pr_err("%s size field exceeds heap boundary\n", section_name);
> +		return false;
> +	}
> +
> +	/* Read the size of the current TXT Heap section */
> +	*heap_section_size = *(u64 __force *)heap_section;
> +
> +	if (*heap_section_size < 8) {
> +		pr_err("%s size is too small\n", section_name);
> +		return false;
> +	}
> +
> +	if (*heap_section_size > heap_end - (u64)heap_section) {
> +		pr_err("%s exceeds heap boundary\n", section_name);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static bool tboot_check_dtpr_size(const struct heap_ext_data_elt *elt)
> +{
> +	u64 dtpr_payload_size, dtpr_offset;
> +	u32 i, ref_tpr_cnt;
> +
> +	struct acpi_table_dtpr   *tmp_dtpr    = NULL;
> +	struct acpi_tpr_instance *tpr_inst    = NULL;
> +	struct acpi_tpr_aux_sr   *tpr_aux_srl = NULL;
> +
> +	if (!elt) {
> +		pr_err("DTPR element heap extension data is NULL\n");
> +		return false;
> +	}
> +
> +	tmp_dtpr          = (struct acpi_table_dtpr *)elt->data;
> +	dtpr_payload_size = elt->size - sizeof(*elt);
> +
> +	if (dtpr_payload_size < sizeof(struct acpi_table_dtpr)) {
> +		pr_err("DTPR element payload too small for a DTPR header\n");
> +		return false;
> +	}
> +
> +	if (tmp_dtpr->header.length != dtpr_payload_size) {
> +		pr_err("Mismatch between DTPR table length and payload size\n");
> +		return false;
> +	}
> +
> +	dtpr_offset = sizeof(struct acpi_table_dtpr);
> +
> +	if (dtpr_offset > dtpr_payload_size) {
> +		pr_err("TPR header exceeds table's declared size\n");
> +		return false;
> +	}
> +
> +	if (tmp_dtpr->ins_cnt < 1) {
> +		pr_err("DTPR table declares no TPR instances\n");
> +		return false;
> +	}
> +
> +	for (i = 0; i < tmp_dtpr->ins_cnt; i++) {
> +		/* prove this instance's header is in bounds before reading it */
> +		if (dtpr_offset + sizeof(struct acpi_tpr_instance) > dtpr_payload_size) {
> +			pr_err("TPR instance No.%u header exceeds DTPR table size\n", i);
> +			return false;
> +		}
> +
> +		/* iterate to the current TPR instance */
> +		tpr_inst = (struct acpi_tpr_instance *)((u8 *)tmp_dtpr + dtpr_offset);

This line is not iterating over anything.

Please check all your comments and tone them down.

> +
> +		if (tpr_inst->tpr_cnt < 2) {
> +			pr_err("TPR Instance %u has less than 2 TPRs, further DTPR processing interrupted.\n",
> +			       i);

Ugly linebreak.

Check the rest for more.

> +			return false;
> +		}
> +
> +		/* all instances must carry the same TPR count as the first */
> +		if (i == 0) {

		if (!i)

> +			ref_tpr_cnt = tpr_inst->tpr_cnt;
> +		} else if (tpr_inst->tpr_cnt != ref_tpr_cnt) {
> +			pr_err("TPR Instance %u has inconsistent TPR count: expected %u, found %u\n",
> +			       i, ref_tpr_cnt, tpr_inst->tpr_cnt);
> +			return false;
> +		}
> +
> +		/* iterate over each TPR instance */
> +		dtpr_offset += sizeof(struct acpi_tpr_instance) +
> +			       (u64)tpr_inst->tpr_cnt * sizeof(struct acpi_tpr_array);
> +
> +		/* verify TPR array size for this instance */
> +		if (dtpr_offset > dtpr_payload_size) {
> +			pr_err("TPR instance No.%u TPR entries exceed DTPR table size\n",
> +			       i);
> +			return false;
> +		}
> +	}
> +
> +	tpr_aux_srl = (struct acpi_tpr_aux_sr *)((u8 *)tmp_dtpr + dtpr_offset);
> +	dtpr_offset += sizeof(u32);
> +
> +	if (dtpr_offset > dtpr_payload_size) {
> +		pr_err("TPR SRL count field exceeds DTPR table size\n");
> +		return false;
> +	}
> +
> +	dtpr_offset += (u64)tpr_aux_srl->srl_cnt *
> +		       sizeof(struct acpi_tpr_serialize_request);
> +	if (dtpr_offset > dtpr_payload_size) {
> +		pr_err("TPR SRL entries exceed DTPR table size\n");
> +		return false;
> +	}
> +
> +	if (dtpr_offset < dtpr_payload_size) {
> +		pr_err("DTPR table is smaller than expected\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  void tboot_shutdown(u32 shutdown_type)
>  {
>  	void (*shutdown)(void);

...

> @@ -514,3 +663,331 @@ struct acpi_table_header *tboot_get_dmar_table(struct acpi_table_header *dmar_tb
>  
>  	return dmar_tbl;
>  }
> +
> +static struct acpi_table_dtpr *tboot_get_dtpr_table(void)
> +{
> +	void *heap_ptr, *config, *sinit_mle_end;
> +	struct sinit_mle_data *sinit_mle;
> +	struct heap_ext_data_elt *elt;
> +	u64 heap_end, heap_size, sinit_mle_size, heap_section_size;

The tip-tree preferred ordering of variable declarations at the
beginning of a function is reverse fir tree order::

	struct long_struct_name *descriptive_name;
	unsigned long foo, bar;
	unsigned int tmp;
	int ret;

The above is faster to parse than the reverse ordering::

	int ret;
	unsigned int tmp;
	unsigned long foo, bar;
	struct long_struct_name *descriptive_name;

And even more so than random ordering::

	unsigned long foo, bar;
	int ret;
	struct long_struct_name *descriptive_name;
	unsigned int tmp;

Please check all your code.

> +
> +	if (!tboot_enabled())
> +		return NULL;
> +	/*
> +	 * ACPI tables may not be DMA protected by tboot, so use DMAR copy
> +	 * SINIT saved in SinitMleData in TXT heap (which is DMA protected)
> +	 */
> +
> +	/* map config space in order to get heap addr */
> +	config = ioremap(TXT_PUB_CONFIG_REGS_BASE, NR_TXT_CONFIG_PAGES *
> +			 PAGE_SIZE);
> +	if (!config)
> +		return NULL;
> +
> +	/* now map TXT heap */
> +	heap_size  = *(u64 __force *)(config + TXTCR_HEAP_SIZE);
> +	if (!txt_heap)
> +		txt_heap = ioremap(*(u64 __force *)(config + TXTCR_HEAP_BASE), heap_size);
> +
> +	iounmap(config);
> +
> +	if (!txt_heap) {
> +		pr_err("Failed to map TXT heap\n");
> +		return NULL;
> +	}
> +
> +	if (heap_size == 0 || (u64)txt_heap + heap_size < (u64)txt_heap) {
> +		pr_err("TXT heap size invalid or overflows\n");
> +		goto teardown;
> +	}
> +
> +	heap_end   = (u64)txt_heap + heap_size;
> +
> +	/* walk heap to SinitMleData */
> +	/* skip BiosData */
> +	/* get BiosData section size */
> +	if (!tboot_check_txt_heap_section_bounds(heap_end, txt_heap,
> +						 &heap_section_size, "BiosData")) {
> +		goto teardown;
> +	}
> +
> +	/* skip OsMleData */
> +	heap_ptr = txt_heap + heap_section_size;
> +	/* get OsMleData section size */
> +	if (!tboot_check_txt_heap_section_bounds(heap_end, heap_ptr,
> +						 &heap_section_size, "OsMleData")) {

Ugly linebreaks. Let it stick out. Ditto for the rest.

> +		goto teardown;
> +	}
> +
> +	/* skip OsSinitData */
> +	heap_ptr += heap_section_size;
> +	/* get OsSinitData section size */
> +	if (!tboot_check_txt_heap_section_bounds(heap_end, heap_ptr,
> +						 &heap_section_size, "OsSinitData")) {
> +		goto teardown;
> +	}
> +
> +	/* jump to the SinitMleData */
> +	heap_ptr += heap_section_size;
> +	sinit_mle_size = 0;
> +	/* now points to SinitMleDataSize; set to SinitMleData */
> +	if (!tboot_check_txt_heap_section_bounds(heap_end, heap_ptr,
> +						 &sinit_mle_size, "SinitMleData")) {
> +		goto teardown;
> +	}
> +
> +	heap_ptr += sizeof(u64);
> +	sinit_mle = (struct sinit_mle_data *)heap_ptr;
> +	sinit_mle_end = (void *)sinit_mle + sinit_mle_size;
> +	if (sizeof(struct sinit_mle_data) > sinit_mle_size) {
> +		pr_err("SinitMleData size is smaller than expected.\n");
> +		goto teardown;
> +	}
> +
> +	if (sinit_mle->version < 9) {
> +		pr_err("Unsupported SinitMleData version: %u\n", sinit_mle->version);
> +		goto teardown;
> +	}
> +
> +	heap_ptr += sizeof(struct sinit_mle_data);
> +	if (heap_ptr > sinit_mle_end) {
> +		pr_err("SinitMleData header out of bounds.\n");
> +		goto teardown;
> +	}
> +
> +	/*
> +	 * The SinitMleData extended-data area is a self-describing list of
> +	 * variable-length elements with no stored element count; it is
> +	 * terminated only by a HEAP_EXTDATA_TYPE_END element. Traversal must
> +	 * therefore be driven by each element's own size field. Forward
> +	 * progress and termination are guaranteed on every iteration:
> +	 *   - the 8-byte header is bounds-checked before type/size are read,
> +	 *   - elt->size >= sizeof(*elt) enforces a strictly-positive advance,
> +	 *   - the "elt <= sinit_mle_end" cap bounds the number of steps.
> +	 */
> +	elt = sinit_mle->ext_data_elts;
> +	do {
> +		if ((u8 *)elt + sizeof(*elt) > (u8 *)sinit_mle_end) {
> +			pr_err("SinitMleData element header out of bounds.\n");
> +			goto teardown;
> +		}
> +
> +		if (elt->size < sizeof(*elt)) {
> +			pr_err("Invalid SinitMleData element size: %u\n", elt->size);
> +			goto teardown;
> +		}
> +
> +		if (elt->type == HEAP_EXTDATA_TYPE_END ||
> +		    elt->type == HEAP_EXTDATA_TYPE_DTPR) {
> +			break;
> +		}
> +
> +		elt = (void *)elt + elt->size;
> +	} while ((void *)elt <= sinit_mle_end);
> +
> +	if ((void *)elt >= sinit_mle_end) {
> +		pr_err("Reached the end of SinitMleData without finding DTPR nor END element.\n");
> +		goto teardown;
> +	}
> +
> +	if (elt->type == HEAP_EXTDATA_TYPE_END) {
> +		pr_err("DTPR element not found in SinitMleData\n");
> +		goto teardown;
> +	}
> +
> +	if ((u8 *)elt + elt->size > (u8 *)sinit_mle_end) {
> +		pr_err("DTPR Table exceeds SinitMleData bounds.\n");
> +		goto teardown;
> +	}
> +
> +	if (!tboot_check_dtpr_size(elt)) {
> +		pr_err("Invalid DTPR Table size.\n");
> +		goto teardown;
> +	}
> +
> +	return (struct acpi_table_dtpr *)elt->data;
> +
> +teardown:
> +	tboot_free_txt_heap_mem();
> +	return NULL;
> +}
> +
> +s64 tboot_teardown_tprs(void)
> +{
> +	s64 ret = 0;
> +
> +	if (tboot_is_tpr_protection_enabled() && dtpr)
> +		ret = tboot_disable_tprs();	/* uses cached dtpr + txt_heap */
> +
> +	tboot_free_txt_heap_mem();	/* releases internal mapping */
> +	dtpr = NULL;
> +	return ret;			/* 0 = success / nothing to do */
> +}
> +
> +void tboot_free_txt_heap_mem(void)
> +{
> +	if (txt_heap) {
> +		iounmap(txt_heap);
> +		txt_heap = NULL;
> +	}
> +}
> +
> +bool tboot_is_tpr_protection_enabled(void)
> +{
> +	return num_of_enabled_tprs > 0;
> +}
> diff --git a/include/linux/tboot.h b/include/linux/tboot.h
> index d2279160ef39d..d7c00024b26e0 100644
> --- a/include/linux/tboot.h
> +++ b/include/linux/tboot.h
> @@ -24,10 +24,17 @@ enum {
>  #include <linux/acpi.h>
>  /* used to communicate between tboot and the launched kernel */
>  
> +/*TXT Extended Data Element Types*/
> +#define HEAP_EXTDATA_TYPE_END   0
> +#define HEAP_EXTDATA_TYPE_DTPR 14
> +
>  #define TB_KEY_SIZE             64   /* 512 bits */
>  
>  #define MAX_TB_MAC_REGIONS      32
>  
> +/*TPR Base Disable BIT*/
> +#define TPR_BASE_DISABLE_BIT  BIT(4)
> +
>  struct tboot_mac_region {
>  	u64  start;         /* must be 64 byte -aligned */
>  	u32  size;          /* must be 64 byte -granular */

Please put side comments over the line they comment.

check your whole code.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
