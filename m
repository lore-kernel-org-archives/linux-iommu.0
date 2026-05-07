Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C089322B9F
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173283; cv=none; b=AEfkzRkjUGBKDJMrnLzfui033uncOwQj6Q21KsQnu/+qihwZqJEHsGCTn0FNC7bwkXBRCUu2+0HAR/o4wQRtQL6t85ROflmtltGezBHHyoWAnu+Cn0kIBlFaO0AywogCLNGSWMKM1FIwD24zb+K7ObpmX71m6DO/c/OzofTD+RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173283; c=relaxed/simple;
	bh=uGGj2U/vJnMxhbFJKIqotpYIMg1EjnVQnfMDueaf9rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCxFCJprmdNi2j8loPqb0mTmooqr2wOmKl3uTpykL96HsWg6hayIevI14FkdgUekh1kHGIn25zTrlF5Fo9dkRExX4iLdeTjyFWEnrne/tZaLabxuTvpQ2FB+umE1ZNNHm5SHPbe5bVBqVd/YmBLiqx9k0dD8Nsj8ZXqkCsm2xi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nd9V0QTl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nd9V0QTl"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so5275ad.0
        for <iommu@lists.linux.dev>; Thu, 07 May 2026 10:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778173282; x=1778778082; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EkZhl2rjBW+nl3nyNEminS+13XOQl2O/je9IzImrzRw=;
        b=nd9V0QTl3NdQez57J0LL23cEj8+ZC/lnpG1lrvfxIBAw4ShoMtihgio5ktl4vPeyyI
         p2pE/sQJ1pIGqkLx9d8Id6QXOpRQMcYhFVDYqFG1VqHV5jAH7MHJYTEzzIJxlkpC7nLC
         w9QdV2Iua0heGQTTIo+/DhM9KwC/HynaQiCHTBGTAq+lAO+A64LqD/bz7MOrIL+JvozT
         Ui8kbAp7pVep1SP7eeV7YmzI1bjHJqMEOzeHzcMXOHTt/b+Fj7fyeH3VOU2amuaS4How
         LAosLIlnzJQZcJ+E1R00kMYhyEzOKT9ielny4FiAeidmfa77QGBp+S0eMsYQE3a1YSgY
         qeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778173282; x=1778778082;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EkZhl2rjBW+nl3nyNEminS+13XOQl2O/je9IzImrzRw=;
        b=r07kSqhajhZ5ZBpLdIu1y/U7+5kilG5xLigTkK1/GovSrDSTV9YgqbSFGK9djZCIHE
         nM98ujMdrk52/JuIaRYXD6tBUhX35WLJkAWRPZ8qW0g7muFR2kC0PVXLTbyX1FUPj3nH
         2YA00ibGV9VV5unl+zfJFaBLDWFHWb0Be28/HEMpAqKYFq7oNEtQty0AeYAlmm5fJmRN
         HZOKvd/vuT3j+4/oTh3CEV4iPDn1wr85eXPzCL7uTwNjuCJljISoB1WhtZHFIzXYi0iE
         6qeIUBvPj5TTcuDh2ShATsjGQrQiGit44FknIqJi0vbOja5gupPlVDuQwnsrNyfhD/D7
         Jr+A==
X-Forwarded-Encrypted: i=1; AFNElJ/hri+d1xSsy3XIM6Kcn9zIT19X9Aalv6ygeGe0FIVPDOI5Y3ef8MzlQ9+4hDJv47RDbdb8kw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMI//MsrNpwN5sPG0AYFqEqnVpqP/JBKs/lkAWgsIHUc4CrzIX
	pzD0MTsEzEPeeIQCjuR8BNlVsmV/w0LwNP5R5Yx0dSMCzASUG2CR1yoAHvd5XZcKGw==
X-Gm-Gg: Acq92OH3NgSE4a/9O70+uT2VV+KpvlqHee20Q4+GHuekjUTDLrTub9pWHHgK8c3JESw
	ni9WE1bWm7BebQqLnGRm6LP5EXqgs+FYxHuqN3VUcCz2fK+td0LcdQFn+BAVU3gBBsdZYdokD0l
	bE7R5CrLr/EioO+xPRKSr5uzsBdw9+5xDV8QcQvQCU6VCjLulxs6LCIuigNBCPsb5Gaq6KonYni
	H8glZMyIO1Q6ihdjr4/5K5TUQaT0UEQvZwXrjVFhdSDnbfjtup4dhAopDpzp11eBgF+7ZrJOWA+
	NXI+vXyPEZISQenQmJmS0O0MlPA22OUCbUQJzVwq4uNv3AoDp7oIhaHl3vVd8hbuMJ9B5ZBadDG
	IrdLqFtPMKOzLrqjH4T6ETfL7c9uo6FcmHeO4WJdgogag5JeBaLl/43apnVLePY45TODzK2j8l6
	qQeYFCplUlPamJTXqTH8wg2YarHr7/8K4PMnB6q3PvTwf6K8OzN2lo51R5QE98K0xPo+/f3mb9E
	S3IdD0=
X-Received: by 2002:a17:903:151:b0:2b7:b03d:9847 with SMTP id d9443c01a7336-2bae59d0064mr672355ad.7.1778173280664;
        Thu, 07 May 2026 10:01:20 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bae755e95bsm2712105ad.25.2026.05.07.10.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:01:19 -0700 (PDT)
Date: Thu, 7 May 2026 17:01:13 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Yigit Oguz <yigitogu@amazon.de>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	baolu.lu@linux.intel.com, dwmw2@infradead.org,
	suravee.suthikulpanit@amd.com, jgg@ziepe.ca, nicolinc@nvidia.com,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Lilit Janpoladyan <lilitj@amazon.com>
Subject: Re: [PATCH 1/3] iommu/arm-smmu-v3: Print PCI vendor:device ID in
 SMMU translation fault logs
Message-ID: <afzFWUEyw73n5yAR@google.com>
References: <20260506150541.60467-1-yigitogu@amazon.de>
 <20260506150541.60467-2-yigitogu@amazon.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506150541.60467-2-yigitogu@amazon.de>

On Wed, May 06, 2026 at 03:05:37PM +0000, Yigit Oguz wrote:
> From: Lilit Janpoladyan <lilitj@amazon.com>
> 
> For translation, address-size, access, and permission faults, look up
> the pci_dev from the event and append the PCI vendor:device ID after
> the device name, e.g.:
> 
>   event: F_TRANSLATION client: 0001:02:02.4 [1d0f:8061] sid: ...
> 
> For non-PCI devices or unassigned SIDs the output is unchanged.
> 
> Signed-off-by: Lilit Janpoladyan <lilitj@amazon.com>
> Signed-off-by: Yigit Oguz <yigitogu@amazon.de>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 29 ++++++++++++++++++---
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index e8d7dbe495f0..ab1afa36965a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2213,12 +2213,30 @@ static void arm_smmu_dump_raw_event(struct arm_smmu_device *smmu, u64 *raw,
>  
>  #define ARM_SMMU_EVT_KNOWN(e)	((e)->id < ARRAY_SIZE(event_str) && event_str[(e)->id])
>  #define ARM_SMMU_LOG_EVT_STR(e) ARM_SMMU_EVT_KNOWN(e) ? event_str[(e)->id] : "UNKNOWN"
> -#define ARM_SMMU_LOG_CLIENT(e)	(e)->dev ? dev_name((e)->dev) : "(unassigned sid)"
> +
> +/* "SSSS:BB:DD.F [VVVV:DDDD]\0" — 12 + 1 + 11 + 1 = 25; round to power of 2 */
> +#define ARM_SMMU_CLIENT_LEN	32
> +

Nit: s/ARM_SMMU_CLIENT_LEN/ARM_SMMU_LOG_CLIENT_LEN to maintain the
convention?

> +static const char *arm_smmu_fmt_client(struct arm_smmu_event *e, char *buf, size_t sz)
> +{
> +	struct pci_dev *p;

Minor nit: maybe we could intialized it here?

struct pci_dev *p = to_pci_dev(e->dev);

Not a strong opinion though.

> +
> +	if (!e->dev)
> +		return "(unassigned sid)";
> +	if (!dev_is_pci(e->dev))
> +		return dev_name(e->dev);
> +
> +	p = to_pci_dev(e->dev);
> +	snprintf(buf, sz, "%s [%04x:%04x]", dev_name(e->dev), p->vendor, p->device);
> +	return buf;
> +}
>  
>  static void arm_smmu_dump_event(struct arm_smmu_device *smmu, u64 *raw,
>  				struct arm_smmu_event *evt,
>  				struct ratelimit_state *rs)
>  {
> +	char clientbuf[ARM_SMMU_CLIENT_LEN];

Nit: s/clientbuf/client_str ?

I was able to test this with 7.1-rc1 & it looks good:

   [  106.880820] arm-smmu-v3 9050000.smmuv3: event: F_TRANSLATION client: 0000:00:01.0 [8086:10c9] sid: 0x8 ssid: 0x0 iova: 0xffffc000 ipa: 0x0
   [  106.880855] arm-smmu-v3 9050000.smmuv3: unpriv data read s1 "Input address caused fault" stag: 0x0
   [  106.880894] arm-smmu-v3 9050000.smmuv3: event 0x10 received:
   [  106.880922] arm-smmu-v3 9050000.smmuv3:     0x0000000800000010
   [  106.880948] arm-smmu-v3 9050000.smmuv3:     0x0000020800000000
   [  106.880974] arm-smmu-v3 9050000.smmuv3:     0x00000000ffffc004
   [  106.881001] arm-smmu-v3 9050000.smmuv3:     0x0000000000000000
   [  106.881030] arm-smmu-v3 9050000.smmuv3: event: F_TRANSLATION client: 0000:00:01.0 [8086:10c9] sid: 0x8 ssid: 0x0 iova: 0xffffc004 ipa: 0x0
   [  106.881061] arm-smmu-v3 9050000.smmuv3: unpriv data read s1 "Input address caused fault" stag: 0x0
   [  106.881104] arm-smmu-v3 9050000.smmuv3: event 0x10 received:
   [  106.881136] arm-smmu-v3 9050000.smmuv3:     0x0000000800000010
   [  106.881163] arm-smmu-v3 9050000.smmuv3:     0x0000020800000000
   [  106.881189] arm-smmu-v3 9050000.smmuv3:     0x00000000ffffc008
   [  106.881215] arm-smmu-v3 9050000.smmuv3:     0x0000000000000000

Apart from the nits above:

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Tested-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
