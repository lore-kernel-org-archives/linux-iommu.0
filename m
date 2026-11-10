Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794269232;
	b=qemc0st4N6BbQWmM+Q0sla43xC44bpw7ik+jhsRmX4O1XpkJjCl1Id4A+/uLEXNM3aeA
	 H5pcHzatJikiCn462Ei3eGCmI2uA8iD2QcTWWBV0goyo/sLc++HPXK+W9YqR2BEhRQObO
	 M10B0/83lkL76zdsdwhPPG9Nlf43rIF9dHwS+4v/eyTrBfOm2vD7bi2Sym1W7iWczlBl9
	 07QnceQdt8EdJn7/ITr9qfDKma/T/TykIHTFXgA2dW8x23FGGbCmbo2oQVmHarAp5y7C5
	 q+zRMPt2Aij/noHBQQESMK8BnIPkM32u28SAUia6cqdB56IcREEn4/4l+Py17vjq86g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794269232;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=cH848nBB2JYZZR8gfhKmZDRVyjtqbBBdYIiS+WbkklI=;
	b=49DoN0c9zpjtFzzzGpaebwjuoNh2qJ32NMMYzSq7w20rWyVDXN2g39cHgF757LAYhQXA
	 vy76H8iAA7cNFcZYYJRE6BJcZMcL5kNbqEFz1WvwP3Tw/pu8HT6KVXUL4v2bEUSTCkHWb
	 T9H2y4X398yf7RSulsLZ1xqX1XgpjUus35X7DqUD2LKM20Mctk1JaA5MQwSbcTMIeEbjZ
	 ambC68EUhCuOgMTqHA5kd4MXs6T3WmnOmNq39bg/bLDqVOCfTuScBXYdnrhIWGoAUej35
	 +MegzMo0t8+zxTNn6VvC5V1pTKEFJstKWgNHwlLR/80FpA86M945cSKaZLm0jS2rzcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="OW/MiH3Z";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB680606A325
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 00:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB680606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=OW/MiH3Z
Received: from localhost (unknown [52.172.102.219])
	by linux.microsoft.com (Postfix) with ESMTPSA id EE43620B7168;
	Mon,  9 Nov 2026 16:06:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EE43620B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794269228;
	bh=cH848nBB2JYZZR8gfhKmZDRVyjtqbBBdYIiS+WbkklI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OW/MiH3ZsN2c4gO4mKXVgmT5I8hKDEfZ0hixVV+Vt35CiYDPF0lcxRbZclWdBJBmC
	 nPF7WECBxPGTECvSkI7GxavpFCtI94ZGs6/1dGuMQo1ot3rrtf/2SGJVT6VGGmMurj
	 vfIENo2HM8GhMIFZfoXbBfbLI7F06o6ylU0Rr0SU=
Date: Mon, 9 Nov 2026 16:06:57 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org, jgg@nvidia.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, arnd@arndb.de,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH V4 1/5] mshv: Add gfp flags to deposit memory logic
Message-ID: <20261109160657.0000594d@linux.microsoft.com>
In-Reply-To: <20261105020106.3496339-2-mrathor@linux.microsoft.com>
References: <20261105020106.3496339-1-mrathor@linux.microsoft.com>
	<20261105020106.3496339-2-mrathor@linux.microsoft.com>
Organization: LSG
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Mukesh,

On Wed,  4 Nov 2026 18:01:02 -0800
Mukesh R <mrathor@linux.microsoft.com> wrote:

> Currently GFP_KERNEL is hard coded in hv_alloc_dep_pages(). Add
> gfp_flags parameter so it can be called in atomic context from
> map_pages callback in struct iommu_domain_ops and other places in
> future. A new function hv_deposit_memory_gfp() is added to facilitate
> this, so hv_deposit_memory() can continue to function as is.
>=20
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  drivers/hv/hv_proc.c           | 20 +++++++++++---------
>  include/asm-generic/mshyperv.h | 14 +++++++++++---
>  2 files changed, 22 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index f811bb5c42a1..8380e9050f46 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -22,7 +22,7 @@
>   * Returns: number of pages allocated or -ENOMEM
>   */
>  static int hv_alloc_dep_pages(int node, u64 *pfna, u64 *lastpfnp,
> int num_pages,
> -			      bool single)
> +			      bool single, gfp_t gfp_flags)
>  {
>  	struct page *page;
>  	int num_allocd, count =3D 0;
> @@ -37,7 +37,6 @@ static int hv_alloc_dep_pages(int node, u64 *pfna,
> u64 *lastpfnp, int num_pages, while (num_pages) {
>  		/* Find highest order we can actually allocate */
>  		int order =3D 31 - __builtin_clz(num_pages);
> -		gfp_t gfp_flags =3D GFP_KERNEL;
> =20
>  		if (!single)
>  			gfp_flags |=3D __GFP_NOWARN;
> @@ -81,7 +80,8 @@ static int hv_alloc_dep_pages(int node, u64 *pfna,
> u64 *lastpfnp, int num_pages,
>   * so we must split that also. Lastly,
> HV_MAX_CONTIGUOUS_ALLOCATION_PAGES is
>   * not guaranteed to always be power of 2.
>   */
> -static int hv_call_deposit_pages(int node, u64 partition_id, bool
> contiguous) +static int hv_call_deposit_pages(int node, u64
> partition_id, bool contiguous,
> +				 gfp_t gfp_flags)
>  {
>  	struct hv_deposit_memory *hc_input;
>  	int i, rc, num_pages;
> @@ -98,14 +98,15 @@ static int hv_call_deposit_pages(int node, u64
> partition_id, bool contiguous) num_pages =3D HV_DEPOSIT_MAX;
>  	}
> =20
> -	hc_input =3D (struct hv_deposit_memory
> *)get_zeroed_page(GFP_KERNEL);
> +	hc_input =3D (struct hv_deposit_memory
> *)get_zeroed_page(gfp_flags); if (hc_input =3D=3D NULL)
>  		return -ENOMEM;
> =20
>  	hc_input->partition_id =3D partition_id;
>  	pfna =3D hc_input->gpa_page_list;
> =20
> -	rc =3D hv_alloc_dep_pages(node, pfna, &lastpfn, num_pages,
> contiguous);
> +	rc =3D hv_alloc_dep_pages(node, pfna, &lastpfn, num_pages,
> contiguous,
> +				gfp_flags);
>  	if (rc < 0)
>  		goto out_free;
> =20
> @@ -159,7 +160,7 @@ static int hv_call_deposit_pages(int node, u64
> partition_id, bool contiguous) return rc;
>  }
> =20
> -int hv_deposit_memory_node(int node, u64 pt_id, u64 hv_status)
> +int hv_deposit_memory_node(int node, u64 pt_id, u64 hv_status, gfp_t
> gfp_flags) {
>  	int result =3D hv_result(hv_status);
>  	bool contiguous =3D false;
> @@ -179,7 +180,7 @@ int hv_deposit_memory_node(int node, u64 pt_id,
> u64 hv_status) result =3D=3D
> HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY) contiguous =3D true;
> =20
> -	return hv_call_deposit_pages(node, pt_id, contiguous);
> +	return hv_call_deposit_pages(node, pt_id, contiguous,
> gfp_flags); }
>  EXPORT_SYMBOL_GPL(hv_deposit_memory_node);
> =20
> @@ -232,7 +233,7 @@ int hv_call_add_logical_proc(int node, u32
> lp_index, u32 apic_id) break;
>  		}
>  		ret =3D hv_deposit_memory_node(node,
> hv_current_partition_id,
> -					     status);
> +					     status, GFP_KERNEL);
>  	} while (!ret);
> =20
>  	return ret;
> @@ -266,7 +267,8 @@ int hv_call_create_vp(int node, u64 partition_id,
> u32 vp_index, u32 flags) }
>  			break;
>  		}
> -		ret =3D hv_deposit_memory_node(node, partition_id,
> status);
> +		ret =3D hv_deposit_memory_node(node, partition_id,
> status,
> +					     GFP_KERNEL);
> =20
>  	} while (!ret);
> =20
> diff --git a/include/asm-generic/mshyperv.h
> b/include/asm-generic/mshyperv.h index 4c9f3353074a..2584e693d7b3
> 100644 --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -346,7 +346,7 @@ static inline bool hv_parent_partition(void)
>  }
> =20
>  bool hv_result_needs_memory(u64 status);
> -int hv_deposit_memory_node(int node, u64 partition_id, u64 status);
> +int hv_deposit_memory_node(int node, u64 partition_id, u64 status,
> gfp_t gfp); int hv_call_add_logical_proc(int node, u32 lp_index, u32
> acpi_id); int hv_call_notify_all_processors_started(void);
>  bool hv_lp_exists(u32 lp_index);
> @@ -357,7 +357,8 @@ static inline bool hv_root_partition(void) {
> return false; } static inline bool hv_l1vh_partition(void) { return
> false; } static inline bool hv_parent_partition(void) { return false;
> } static inline bool hv_result_needs_memory(u64 status) { return
> false; } -static inline int hv_deposit_memory_node(int node, u64
> partition_id, u64 status) +static inline int
> hv_deposit_memory_node(int node, u64 partition_id, u64 status,
> +					 gfp_t gfp)
>  {
>  	return -EOPNOTSUPP;
>  }
> @@ -379,9 +380,16 @@ static inline int hv_call_create_vp(int node,
> u64 partition_id, u32 vp_index, u3 }
>  #endif /* CONFIG_MSHV_ROOT */
> =20
> +/* Generic deposit function with no default numa node and GFP_KERNEL
> */ static inline int hv_deposit_memory(u64 partition_id, u64 status)
>  {
> -	return hv_deposit_memory_node(NUMA_NO_NODE, partition_id,
> status);
> +	return hv_deposit_memory_node(NUMA_NO_NODE, partition_id,
> status,
> +				      GFP_KERNEL);
> +}
> +
> +static inline int hv_deposit_memory_gfp(u64 partition_id, u64
> status, gfp_t gfp) +{
> +	return hv_deposit_memory_node(NUMA_NO_NODE, partition_id,
> status, gfp); }
> =20
>  #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
nit: no user for hv_deposit_memory_gfp here.
IMHO, hv_deposit_memory_gfp() should be introduced in patch 5/5, where
hv_iommu_map_pages()=A0 first calls it:
ret =3D hv_deposit_memory_gfp(hv_current_partition_id, status, gfp);

Other than that,

Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
