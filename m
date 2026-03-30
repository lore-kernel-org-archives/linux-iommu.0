Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1B93DC4AA
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774891615; cv=none; b=JaYUa6edLVBixLRjkd7kd6nD+tdh1Rh3Q6RBLHlRB8QxLzAJWpnDCVZR2zhJFE1ZhERwUWXE3HMyqIiVmbXJein6o9hr0DZvVfU08ZhZIzCjgJnZpVbN6zNrOkLp471ZTk2gwurVjDZ/QRD44ZY2SpSLRlDcBtd9QSbKWFvDHgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774891615; c=relaxed/simple;
	bh=Xc0re7zSzhjk9nLcdtQctBdHkSwt6POuf8PnYeuCWUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/qlb2r0SjX6M3VjKhj0e4vjbp+GTyh1/vZ0jWQ0Zlprf2FnV/R9C867H75Tgeoc3UHji/23xuzcAB+oj43qFjWfaw72IHwT99C+Szn1pGjTmXA6IqiuAq4QtWnTu/xXDW7Xz0XRR1Iu6IK5Dh3iNIwU+7izD9TQDrGzhdrY1H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=ch3J6xe0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zvJPbARD; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="ch3J6xe0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zvJPbARD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3780D1400271;
	Mon, 30 Mar 2026 13:26:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 30 Mar 2026 13:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774891612;
	 x=1774978012; bh=AcmQN+EKdKBX/zWG5BYq7KzjIhGrfGKXjNQi10BLnZc=; b=
	ch3J6xe0zliO/u8k5D7Y3vVIqQUAwrWYBS94PKVMjs4q5Y7CLJ3BIvI8iBzlY6T9
	h/tEagvLTiMz/eXgmn3UI31/pZ2BwjYDcdJQOcmUFSLQBW3eHPAIYn+uFWL6hRUb
	PZ0OVpALvhZax/FxxpVlTuXHzcSS/ETnF/IoPBHCy42ve+rTeHoyUGvA5vfYOPv4
	QcOTGeUt0wqtfcdaVf2N52flNoUek9GPLGL1Nuf8Kri6UUSLitWvwbRUMxkj45Gr
	pR6Ao/p67gIhM20D5ft6MSRctr9n66q6lg5TCLiB1nDkOgy79J1QXJUNetC/Hl6w
	i2Wx1NKm1sfptapwjSrfTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774891612; x=
	1774978012; bh=AcmQN+EKdKBX/zWG5BYq7KzjIhGrfGKXjNQi10BLnZc=; b=z
	vJPbARDE91OdhadsoHtO6/EnN0EquxuxTPDs/4LVELdR1lfhlNz4Y/3CpNzOtFDZ
	qSl9LRa0AXEJDxJzvamTCsbsvvVHtuWsJHAqdzbDLPadb5Vf+B+yYtflL74FeRZy
	FSGIDnGiB6tIpF2pPT84Xxxne/Emp6+QzGWf7BTNM2IUTfB0KF6XbnVUlkovWcqY
	bD2sqSdYS16N74C5wioD60RoTTde7vjDneYoq9Qpryc/+K0MWVvzYwX9jvITmM8v
	GrXHim7GqMyVQ/L+wSA2VsWK0AX0qNKIOjJCbVoMVxeBeMBK0fUNfH04wYx+zQPw
	1/FSAzqfNAlOHjmYGrkmg==
X-ME-Sender: <xms:W7LKaQi5k68SX7I6XOP6jD0ps5YhGbMitWdQl9hDDAwnok1c_53vuA>
    <xme:W7LKaU7LZ_TAawBQIvLGtfh3FT58R37x2TS7FBV0Shr6eCjFO92M-1XpzQ5TxcMSY
    P-Jlsj7jyNjo9yzkcQeevyuDqchfMDaGlh_FEIiRXg7qj8n-cqn9cQ>
X-ME-Received: <xmr:W7LKaVG_jDAGrlKVj4b46ObrJ1mtKugB98_TlgTp34c3rxkT9GzSBfGDEcU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhsrdhlohhnghhrohhssehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhorhhoseeksgihthgvshdrohhrghdprhgtphhtthhopehs
    uhhrrghvvggvrdhsuhhthhhikhhulhhprghnihhtsegrmhgurdgtohhmpdhrtghpthhtoh
    epfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsihhnrdhmuhhrphhh
    hiesrghrmhdrtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtph
    htthhopehskhhhrghnsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthht
    ohepihhomhhmuheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuh
    igqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:W7LKaWKmrXmumVIenrzpCFi24Qbl7iUl7xVmN-N_HxBZvc9_43UCBQ>
    <xmx:W7LKaSgdFfklcvh7724dZCMGkM62AGZTfleQqJX-noZ5qygX1U-fOg>
    <xmx:W7LKaUmXvckAEtCF7DYnq1e6phgqRfxEMD9gqliY-rnNsKHeuwstlA>
    <xmx:W7LKaZWWe0fq56oJYTdkhi-A68J5dI-oPe6cWgOsMPYOHze57vdznw>
    <xmx:XLLKaeX_QK17u9I_yZ_-a8w_mRx8_VZETStf5IhhxTibsPdVjCnhCwL->
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 13:26:50 -0400 (EDT)
Date: Mon, 30 Mar 2026 11:26:48 -0600
From: Alex Williamson <alex@shazbot.org>
To: Christos Longros <chris.longros@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH] iommu/amd: add amd_iommu=relax_unity option for VFIO
 passthrough
Message-ID: <20260330112648.5e447fa9@shazbot.org>
In-Reply-To: <20260328213228.12084-1-chris.longros@gmail.com>
References: <20260328213228.12084-1-chris.longros@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Mar 2026 22:32:28 +0100
Christos Longros <chris.longros@gmail.com> wrote:

> On some AMD motherboards (Gigabyte B650 Gaming X AX V2, X870E and
> others), VFIO passthrough of any PCI device fails with:
> 
>   "Firmware has requested this device have a 1:1 IOMMU mapping,
>    rejecting configuring the device without a 1:1 mapping."
> 
> These boards' IVRS tables include IVMD type 0x22 (range) entries
> spanning wide device ranges (e.g. devid 0x0000 to 0x0FFF, covering
> PCI buses 0-15).  The entries exist for platform devices like IOAPIC
> and HPET, but they get applied to nearly every IOMMU group on the
> system.  Since commit a48ce36e2786 ("iommu: Prevent RESV_DIRECT
> devices from blocking domains"), any device with IOMMU_RESV_DIRECT
> regions has require_direct=1 set, which prevents VFIO from claiming
> DMA ownership.
> 
> No PCI device can be passed through on affected boards -- not just
> the platform devices that need the identity mappings, but also
> endpoint devices like network adapters and GPUs.
> 
> Intel handles a similar firmware over-specification with
> device_rmrr_is_relaxable(), which marks certain RMRR entries as
> IOMMU_RESV_DIRECT_RELAXABLE so VFIO can claim them.  AMD has no
> equivalent.

The difference is that we have known devices on the Intel platform
which have these RMRRs for largely historical reasons and we've
collectively decided it's safe to "relax" the direct mapping
requirement.  We don't believe there's ongoing post-boot, side-channel
DMA happening in the background for these devices.

That's very different from providing a blind opt-in to ignore the
platform directive to provide direct mapping for any arbitrary device.
This is unsafe and difficult to debug.

I think the preferred route here is to contact your motherboard vendor
to both make them aware of the issue and determine whether they're
willing to address it.  Thanks,

Alex
 
> Add an opt-in amd_iommu=relax_unity boot parameter.  When set, IVRS
> unity map entries are reported as IOMMU_RESV_DIRECT_RELAXABLE instead
> of IOMMU_RESV_DIRECT.  The IOMMU still creates the identity mappings,
> preserving DMA for platform devices, but VFIO can take ownership of
> individual devices for passthrough.
> 
> Tested by passing through an RTL8852CE WiFi adapter to a FreeBSD
> QEMU/KVM guest via vfio-pci.  Without the option, vfio_iommu_type1
> fails to set up the container.  With amd_iommu=relax_unity,
> passthrough works.
> 
> Signed-off-by: Christos Longros <chris.longros@gmail.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
>  drivers/iommu/amd/amd_iommu_types.h             | 1 +
>  drivers/iommu/amd/init.c                        | 6 ++++++
>  drivers/iommu/amd/iommu.c                       | 7 ++++++-
>  4 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 03a550630..974506ad9 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -441,6 +441,12 @@ Kernel parameters
>  			force_enable    - Force enable the IOMMU on platforms known
>  				          to be buggy with IOMMU enabled. Use this
>  				          option with care.
> +			relax_unity     - Mark IVRS unity map entries as relaxable,
> +				          allowing VFIO to claim devices that have
> +				          firmware-declared identity mappings. Required
> +				          on some AMD motherboards where global unity
> +				          maps prevent any device passthrough. Use this
> +				          option with care.
>  			pgtbl_v1        - Use v1 page table for DMA-API (Default).
>  			pgtbl_v2        - Use v2 page table for DMA-API.
>  			irtcachedis     - Disable Interrupt Remapping Table (IRT) caching.
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index c685d3771..bc35d5016 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -907,6 +907,7 @@ struct unity_map_entry {
>   */
>  
>  extern bool amd_iommu_force_isolation;
> +extern bool amd_iommu_unity_relaxed;
>  
>  /* Max levels of glxval supported */
>  extern int amd_iommu_max_glx_val;
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index f3fd7f39e..a89120700 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -173,6 +173,9 @@ u64 amd_iommu_efr2;
>  /* Host (v1) page table is not supported*/
>  bool amd_iommu_hatdis;
>  
> +/* Relax unity map entries for VFIO passthrough */
> +bool amd_iommu_unity_relaxed __read_mostly;
> +
>  /* SNP is enabled on the system? */
>  bool amd_iommu_snp_en;
>  EXPORT_SYMBOL(amd_iommu_snp_en);
> @@ -3676,6 +3679,9 @@ static int __init parse_amd_iommu_options(char *str)
>  			amd_iommu_pgtable = PD_MODE_V2;
>  		} else if (strncmp(str, "irtcachedis", 11) == 0) {
>  			amd_iommu_irtcachedis = true;
> +		} else if (strncmp(str, "relax_unity", 11) == 0) {
> +			amd_iommu_unity_relaxed = true;
> +			pr_warn("AMD IOMMU: unity map relaxation enabled\n");
>  		} else if (strncmp(str, "nohugepages", 11) == 0) {
>  			pr_info("Restricting V1 page-sizes to 4KiB");
>  			amd_iommu_pgsize_bitmap = AMD_IOMMU_PGSIZES_4K;
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 760d5f462..4606fa6a4 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3070,7 +3070,12 @@ static void amd_iommu_get_resv_regions(struct device *dev,
>  		if (devid < entry->devid_start || devid > entry->devid_end)
>  			continue;
>  
> -		type   = IOMMU_RESV_DIRECT;
> +		/*
> +		 * When relax_unity is set, mark unity map entries as
> +		 * relaxable so VFIO can claim devices for passthrough.
> +		 */
> +		type = amd_iommu_unity_relaxed ?
> +			IOMMU_RESV_DIRECT_RELAXABLE : IOMMU_RESV_DIRECT;
>  		length = entry->address_end - entry->address_start;
>  		if (entry->prot & IOMMU_PROT_IR)
>  			prot |= IOMMU_READ;

