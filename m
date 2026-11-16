Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794861258;
	b=0Skc0NnuW99zXTU+6goD7yM1vdRALdjcU4Y7oXoCX8UULXWt+csgMMleC01Q8T1ljX4y
	 MhTDrAcjGmnkI+0iREV+vs3ig9u8P7amSQk+yiPo7hNG1P2ArmSIjV7go3zm7pP7sXaFt
	 av8AqArxueRADlm/T+XCJQSPJ6HPSSqp95WGCPvNGjkPqdLzTT8g4lgyIoTbuHHIr/FMH
	 KYx4kFXFcpKDGfgvETrj9QqH2SgTa0bdDocWa70c1JLbwITjyQ4bmxXhagQnXv8ZQCPQJ
	 TIoThJ2GRb0vIdxYMt0Q08a1GTUS/J0+EWZhO0lAlsm5SL9HUSd68KKv0NxnjEPxWPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794861258;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=FuP841QZILSYrGI+sOs3ttqavD6cxIfZJ60TQUpud2E=;
	b=fw42oMgWbt/WIozRt0euGPQp73VXNUPquUQiyL4dk6nfCJgqyx6vRMUKyBHXTyGWgRz+
	 AX1h+JFPnQstGy2thQPxjxs3A7FubARRfFlyOrF42jffvvt1bWXGmSERQAvdaoOoReLvw
	 g+UsS4u6ZIlw83N259ZIVXWbZ2uv8R0mn4+EmI6tJU1hSDp6o5KGDGmilVTbtb7NeZhCg
	 boITHD4bsNJw4FIfHypC9qihuT4eAn6KqO+2KSWxqyq5QbqEKZJy5K5f+gggadCzVfl5Z
	 vrIRvH7YOxYVeyQLxK4CyqShCASHElloQHyQCQO6wP9jpAzOF8Rr1aB5t4NGm9Pk/Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PjEyx7nP;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15999606A323
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 20:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15999606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PjEyx7nP
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ee254f6eefso18135ad.0
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 12:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794861257; x=1795466057; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FuP841QZILSYrGI+sOs3ttqavD6cxIfZJ60TQUpud2E=;
        b=PjEyx7nPvulLaxrDCQ140cdvsr3gKqnJlQVwZ0cvMLtCvPmpxj5pqFcIy3oaQiKXW+
         aqJPNXlBfaPYhxIuzCOsxsQzwTtLtSBUtubP2+vGj+QddXfHzTLlK/xDNtzR3WoxuzU/
         gZSzdfLsv1gGYoVJAD14FZyv8cBS9MswaCyJfve9hyeGfxnuY2XfijkPmYHSjWEi2KDl
         2EYgEKj/LINBEDviDhjJFwuSciriOU6xtmJ03MqnlcRjhA+k7MLj228iBAgcn0GwS2Kg
         l5ZfJudRraFw936Ntdn55Ax3khJThoNrSWDnJv+OS1/R/7ydMNg4qjmdGWi5bRWC51Yj
         MCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794861257; x=1795466057;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FuP841QZILSYrGI+sOs3ttqavD6cxIfZJ60TQUpud2E=;
        b=WzqbViyaLL64Hohk0S0S2KQHvENHwnTkPWrCyod+L30HKSzECw22TPNq96cNDfk/n8
         gi79FARRRNYzHBFbzq4lW4H3vkiw8XAgoCURd6rUiEfCobZuJC1Z1scVe0qD2ts83qgf
         EMFMVHDGW3J/Etnn6onIjsYKDn33IREqOCaE7LTl5yGgsnp9+HKaVT7RoP7/p2iUpkU8
         FhwlEjtBuHlqjC/KyXe9eyZJvNWZ/jC/GC9zsG1NbVgs+X+ZffhVVdlSQ1DvaZ/aVm3T
         3seO6gu15Lm6CFg0fBOZ35/tKjb0HhUX14orDObcRonWsQRzB/Hljjcvg+No3BNCSAgd
         E+mg==
X-Forwarded-Encrypted: i=1; AL+hErEO90vnYWtm0Flb7zvuP75rNpbtv40GEU18XIVpL95+eEpiXrEveWTNnvLN+mYH7umYHa8Cug==@lists.linux.dev
X-Gm-Message-State: APuU4Z/KJAY9yCJWkycZyHAWnWdQNQIAE89DvBwpYAsgyEwVU9zKCaxB
	bo5uA0L6w93s9bqXf9u9vtM/Tntq0AJ4Qn5LhFTn0fr8M0Mrec9n6qgJOFrU68Z7tw==
X-Gm-Gg: AZFdTZf0ZZGuQQUuuwu5YLT4iCHMeIEVcHKWojQz6LU3xCd7m5JD1DSz+E0PkEzHwgM
	HWdgORUAraeY27jLiQm6jK44slrtp0qpQvGbPZd1DuHDjMw5tvWTtTw+H5uN2QgGY51JIUntf5E
	2mR6d1vqGQczMig80DKK9Ye5noMPKM4Q2qDOYt0No5e8tkbKiUW1dL7iJkNltNveJohj0QkEeAu
	bG1ACCuT2Y4Dgh/3zCW4a+xunT+GCnIKjUFJSIoS3W0mbDSjpNpLu0nzD/Pz3eTHEerNPv6gKDV
	GzG6MymHxgAZLfABsyGwb8HV7V8bMaNO3+yfaLAelrivZtNfE0Vc/8L3e4r60IPLEZzrEv/3Tw/
	+Gadnv8PUVCshWMiJY+Tl8FyedzD+pUD7dKwJSBNfysx8gMS9pkbUCoKkH8Rsq0Z8HgN3czWsK2
	MSOC28FH/uHb6hXX1fvBPw9p3ZN/N9taD75URvhtATlaOJnqM8UCI/nbO56RnCjUh5dI1odohJf
	u/iWfCCIESHzlzWLp5VebmQYWO7qIej4dVVpWZ78eqXECduW5OkvQq7p1tkj2+cPl5x1U+Vyq5R
	lTSUIQZJ9l+FeSxHXUsADDt2dDdD8Cwp11tE0sjRcgUdZzkj6HcvtjoH3PONPoDrH9bTdb6wXZx
	Eao0ot5V2KXA9YHZB1DNJTw==
X-Received: by 2002:a17:903:37cc:b0:2ef:d87f:8a20 with SMTP id d9443c01a7336-2efdc89d1a2mr134375ad.12.1794861256762;
        Mon, 16 Nov 2026 12:34:16 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ab9f4c98sm775625a91.0.2026.11.16.12.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:34:14 -0800 (PST)
Date: Mon, 16 Nov 2026 20:34:11 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v7 10/18] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
Message-ID: <avtiC6VfIf7uc5gj@google.com>
References: <20261110040828.1774343-1-skhawaja@google.com>
 <20261110040828.1774343-11-skhawaja@google.com>
 <57c85edf-8400-4b45-9a64-5eddc0d29134@linux.intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <57c85edf-8400-4b45-9a64-5eddc0d29134@linux.intel.com>

On Mon, Nov 16, 2026 at 11:31:29AM +0800, Baolu Lu wrote:
>On 11/10/2026 12:08 PM, Samiullah Khawaja wrote:
>>During boot fetch the preserved state of IOMMU unit and if found then
>>restore the state.
>>
>>- Reuse the root_table that was preserved in the previous kernel.
>>- Reclaim the domain ids of the preserved domains for each preserved
>>   devices so these are not acquired by another domain.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      |  57 ++++++++++---
>>  drivers/iommu/intel/iommu.h      |  14 ++++
>>  drivers/iommu/intel/liveupdate.c | 139 +++++++++++++++++++++++++++++++
>>  3 files changed, 197 insertions(+), 13 deletions(-)
>>
>>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>index 6c86c155d12b..a83971368bef 100644
>>--- a/drivers/iommu/intel/iommu.c
>>+++ b/drivers/iommu/intel/iommu.c
>>@@ -987,6 +987,8 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
>>  static void release_dmar_iommu(struct intel_iommu *iommu)
>>  {
>>+	intel_iommu_handle_drhd_restore_failure(iommu);
>>+
>>  	/*
>>  	 * All iommu domains must have been detached from the devices,
>>  	 * hence there should be no domain IDs in use.
>>@@ -1452,7 +1454,7 @@ static void intel_iommu_init_qi(struct intel_iommu *iommu)
>>   * Returns 0 when the ID is reserved, was already reserved, or cannot be
>>   * re-assigned, and a negative errno for a genuine allocation failure.
>>   */
>>-static int reserve_domain_id(struct intel_iommu *iommu, int did)
>>+int reserve_domain_id(struct intel_iommu *iommu, int did)
>>  {
>>  	int ret;
>>@@ -1743,12 +1745,16 @@ static int copy_translation_tables(struct intel_iommu *iommu)
>>  static int __init init_dmars(void)
>>  {
>>+	struct iommu_hw_ser *iommu_ser;
>>  	struct dmar_drhd_unit *drhd;
>>  	struct intel_iommu *iommu;
>>  	int ret;
>>  	for_each_iommu(iommu, drhd) {
>>+		iommu_ser = iommu_get_restored_state(iommu->reg_phys,
>>+						     IOMMU_SER_TYPE_INTEL);
>>  		if (drhd->ignored) {
>>+			intel_iommu_handle_drhd_restore_failure(iommu);
>>  			iommu_disable_translation(iommu);
>>  			continue;
>>  		}
>>@@ -1766,7 +1772,9 @@ static int __init init_dmars(void)
>>  		}
>>  		intel_iommu_init_qi(iommu);
>>-		init_translation_status(iommu);
>>+
>>+		if (!iommu_ser)
>>+			init_translation_status(iommu);
>>  		if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
>>  			iommu_disable_translation(iommu);
>>@@ -1775,14 +1783,18 @@ static int __init init_dmars(void)
>>  				iommu->name);
>>  		}
>>-		/*
>>-		 * TBD:
>>-		 * we could share the same root & context tables
>>-		 * among all IOMMU's. Need to Split it later.
>>-		 */
>>-		ret = iommu_alloc_root_entry(iommu);
>>-		if (ret)
>>-			goto free_iommu;
>>+		if (iommu_ser) {
>>+			intel_iommu_liveupdate_restore_root_table(iommu, iommu_ser);
>
>What happens if the incoming kernel is booted with intel_iommu=off?
>
>intel_iommu_init() calls intel_disable_iommus() before reaching this
>restore path. A preserved device may still be issuing DMA, which would
>then bypass translation.
>
>Could we detect preserved IOMMUs and force VT-d on in that case? We

Booting the new kernel with intel_iommu=off after a live update is a
configuration mistake. I will check for preserved IOMMU state in
intel_iommu_init() and force VT-d on like you suggested.

>should also ensure that the ACS configuration for preserved devices and
>their upstream bridges remains consistent with the previous kernel.

The ACS configuration of the preserved devices and their upstream
bridges is preserved and restored by the PCI live update series.

>
>Thanks,
>baolu

Thanks,
Sami
