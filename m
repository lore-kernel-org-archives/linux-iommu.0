Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F72339182F
	for <iommu@lists.linux.dev>; Sat, 10 Oct 2026 02:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599514; cv=none; b=ZZgk5oyflbRFObeRv8wg213KBCQpRuYPpFvT8TCdc/1rwrSx/2s1a2gC4fJTAfeEtH+p6xRJ3g8iK4uGqyGVOIpW4kszroJPgIIEQSU9d60qXpMpF5kbIJyVya4linYSb9+SU9cu2yWZPz9EJdLGTSpRaL8C583Qf6PYjE8D5Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599514; c=relaxed/simple;
	bh=Wsfe86TYaGANkos5Or/r/Ovy9nBCe20RY2SVazy8WIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlXc19jqZzm3C4IsChP5WNW7xDQpaCWjWOMX/ydivs4nI50rrEtdvQDGAqX8ZsCr5nE2zTRIeIgbyM/f1+v6WIx2R97AW5bG02L2uff5UUivk98m2r/8qu5X8LyRbtiE7GJyCR5jPLZWYmkcTbh/nnzY/JDjdEllF473A2l/DGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J+/RDeAA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+/RDeAA"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2db33db4de9so10355ad.0
        for <iommu@lists.linux.dev>; Fri, 09 Oct 2026 19:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791599508; x=1792204308; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3rzKQ4RjsXxN/zYQ6wEGpTgXALdkb/UwVP3kYDgAqNA=;
        b=J+/RDeAAxbz2pfHo8FtgbLC24E8EiKi8WjRX6l5q6795Z10KxWzxLlhlytOGTvHj+Y
         kzKKGtuMgjBoQaYo9YOzCurDsH1nH86HXIgjIxzAzgG392WBwDcvGRaW4yn48XTC4G5T
         tDQr6OIiNmQ+LWZMCOGruZayfj3g2xhZqsIqih5OuGKDiEZdZYyjzegNc4vbaxTDU5NV
         o+zilT5XgRy7sNpeqmP56cfaFZ32ATSplgqgtEY++GrsHMtToHcuDxoOjBkZxC8K4zyp
         LLXKFIwC2gVVd3mWlDljsakEKfXbmduzprCbs1vn3qXseofd2YJdaopXXjgR2IBI4T/c
         l1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791599508; x=1792204308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3rzKQ4RjsXxN/zYQ6wEGpTgXALdkb/UwVP3kYDgAqNA=;
        b=q+lRtiKmHutuK7uoZZ3HXKeLuohsvLvPRA9im9nFbeot9joHXF5F1YVY8EmmH+qcg4
         1ZpPdDe922g2NpcpdEMkCraDS1ZKevLgfGJy0OFe3Kr9aFsDaobRDkDpFpoIKUt7z7n5
         ZwsYpaPsk4bgqiJDghYyni3wo2LK0+N8dKer1S0PPRohyXqRbrYV9cwW/RpKbPIQRgu2
         ZE2QAXqs3Ig6nn2B02kOfT7Ztrxrwo2RgXhRShh29Mqwcqa3W8SDUsazH0f6KL9EDrou
         IlDETorYRLSGjwwVrUNErtkvD/yEJ0mMkuUsT5H4QeTfm14Si6QZMuXQvut3UKSdhfW6
         QZJw==
X-Forwarded-Encrypted: i=1; AKwUvBwo5XhZWlF2Ix7JMhje+ysnO8fV7BhQW4A7Utlk6TKL2yHYEgDUpMU/wBpocPLAAtAbsOONIA==@lists.linux.dev
X-Gm-Message-State: AFq9FYI27AQPCpbUR/OZBsgtdhvwtrcS8Y5LOZyOL5Ty9cBlvGKQ3rTx
	BUZVkgkAUg2XopqZksuVFIM2h41t3wN99ezNU6PIJdAX6P+HIFWEWGHLcd9ZGI/TJA==
X-Gm-Gg: AYBFou045Zs6NdBjEQSHc5AljEjib5K+SrXwazqMxSCwY47Vl+/0UFepLOWSRsYv4dl
	rmmJJwNZqGxmFqu3JNlnlhfQn+kyRw4emLjb3Ur/sjxabTfz6wyMLqBCZSC3M3KKqKH2k++UoP7
	OaKd0bGQ1GpViuwf1mYcNvSjDdd9+2tvOndF1qorPrkDbqlKwf/S5zGB0Uf/7eAH/70VkwE/BXn
	K9+H3+RSxWCbZPUaIm+gNlG0qLRIUtr0skjk5ojAm3iJwyEg0LkObIe2y3ww+3Vpit+fDPbEoPF
	hWOEuOk7e+rTJw3KYX4aYGSZf9Ki5mjQ7YzbsDQZmWjqBY9C3akZy1M7TJ/0FhEmYtOn3/naMeM
	Afrl3DevYt1DgSPCCf2Z0D8TuMCQ8Axw6HTC62mYnAhejqDifHLd+vYre5OARWiO9el8M24j4kA
	k6A20VrjX63hgSKwEK9edwdlXx92oVaSM9g50FCYzcF1YITqfdsGOcEqLR+idCdqoPm9YtUJ4BI
	tpvyQfyNjjH1yEpS/k8XIqqGHeImwaepUvbSAdprPyS5Ze1ewVKKxIcQIyuLNoUPgw=
X-Received: by 2002:a17:903:15c3:b0:2e6:1917:fd with SMTP id d9443c01a7336-2e87e2bb07amr579615ad.7.1791599507817;
        Fri, 09 Oct 2026 19:31:47 -0700 (PDT)
Received: from google.com (163.1.145.34.bc.googleusercontent.com. [34.145.1.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38b9633fsm7435279a91.6.2026.10.09.19.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 19:31:46 -0700 (PDT)
Date: Sat, 10 Oct 2026 02:31:42 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v5 13/18] iommu/vt-d: Preserve PASID table of preserved
 device
Message-ID: <asmeX0tryM-fR-d_@google.com>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-14-skhawaja@google.com>
 <f48258bb-df50-43bb-9141-433601d885a2@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f48258bb-df50-43bb-9141-433601d885a2@linux.intel.com>

On Fri, Oct 09, 2026 at 11:38:57AM +0800, Baolu Lu wrote:
>On 9/21/2026 8:48 AM, Samiullah Khawaja wrote:
>>In scalable mode the PASID table is used to fetch the io page tables.
>>Preserve and restore the PASID table of the preserved devices.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/intel/liveupdate.c | 141 +++++++++++++++++++++++++++++--
>>  drivers/iommu/intel/pasid.c      |  10 ++-
>>  drivers/iommu/intel/pasid.h      |   8 ++
>>  include/linux/kho/abi/iommu.h    |  17 ++++
>>  4 files changed, 169 insertions(+), 7 deletions(-)
>
>Should this patch come before patch 12/18, which restores the device’s
>domain attachment?

Agreed. I will move it before the patch that restores the device's
domain attachment.
>
>>

[snip]

>>diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>>index e4f24d3f19a6..59cc69383799 100644
>>--- a/drivers/iommu/intel/pasid.c
>>+++ b/drivers/iommu/intel/pasid.c
>>@@ -13,6 +13,7 @@
>>  #include <linux/cpufeature.h>
>>  #include <linux/dmar.h>
>>  #include <linux/iommu.h>
>>+#include <linux/iommu-liveupdate.h>
>>  #include <linux/memory.h>
>>  #include <linux/pci.h>
>>  #include <linux/pci-ats.h>
>>@@ -60,8 +61,13 @@ int intel_pasid_alloc_table(struct device *dev)
>>  	size = max_pasid >> (PASID_PDE_SHIFT - 3);
>>  	order = size ? get_order(size) : 0;
>>-	dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
>>-					1 << (order + PAGE_SHIFT));
>>+
>>+	max_pasid = 1 << (order + PAGE_SHIFT + 3);
>>+	if (dev_iommu_restored_state(dev))
>>+		dir = intel_pasid_restore_table(dev, max_pasid);
>>+	else
>>+		dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
>>+						1 << (order + PAGE_SHIFT));
>
>This restores only the PASID table pages. The PASID table is eventually
>installed in the context entry during probe_device:
>
>        if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
>                ret = intel_pasid_alloc_table(dev);
>                if (ret) {
>                        dev_err(dev, "PASID table allocation failed\n");
>                        goto clear_rbtree;
>                }
>
>                if (!context_copied(iommu, info->bus, info->devfn)) {
>                        ret = intel_pasid_setup_sm_context(dev);
>                        if (ret)
>                                goto free_table;
>                }
>        }
>
>For a restored PASID table, the call to intel_pasid_setup_sm_context()
>should be skipped. Instead, it should check whether the preserved pasid
>table is compatible with the new kernel environment.

I will skip the setup call here, but the compatibility check is done in
the intel_pasid_restore_table(). The command line configuration and
other things can be verified during iommu unit restore as you pointed
out in the other patch.
>
>>  	if (!dir) {
>>  		kfree(pasid_table);
>>  		return -ENOMEM;
>>diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h

[snip]

>>index 5aaa29da6832..308cd83fd3e3 100644
>>--- a/include/linux/kho/abi/iommu.h
>>+++ b/include/linux/kho/abi/iommu.h
>>@@ -129,6 +129,19 @@ struct iommu_dev_map_ser {
>>  	u64 iommu_phys;
>>  } __packed;
>>+/**
>>+ * struct iommu_device_intel_ser - Intel specific state of serialized device
>>+ * @restored: Whether the device state is restored
>>+ * @pasid_table: Physical address of pasid table
>>+ * @max_pasid: Maximum supported pasid
>>+ */
>>+struct iommu_device_intel_ser {
>>+	u8 restored;
>>+	u8 padding[7];
>>+	u64 pasid_table;
>>+	u64 max_pasid;
>>+} __packed;
>>+
>>  /**
>>   * struct iommu_device_ser - Serialized state of a device
>>   * @hdr: Common object header
>>@@ -136,6 +149,7 @@ struct iommu_dev_map_ser {
>>   * @pci_domain_nr: PCI domain number
>>   * @dma_owner_token: Token to identify the DMA owner of this device
>>   * @domain_iommu_ser: Domain and IOMMU mapping
>>+ * @intel: Intel specific serialization data
>>   */
>>  struct iommu_device_ser {
>>  	struct iommu_hdr_ser hdr;
>>@@ -143,6 +157,9 @@ struct iommu_device_ser {
>>  	u32 pci_domain_nr;
>>  	u64 dma_owner_token;
>>  	struct iommu_dev_map_ser domain_iommu_ser;
>>+	union {
>>+		struct iommu_device_intel_ser intel;
>>+	};
>>  } __packed;
>>  /* There are maximum 256 buses, so maximum 512 context tables */
>
>Thanks,
>baolu

Thanks,
Sami
