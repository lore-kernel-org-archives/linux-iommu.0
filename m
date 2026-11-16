Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859498;
	b=itH1Qm+6SYc8cBR4MNAi4D3FPjjjrO6cP96uqGGfM4EY2x3hswzcgEWUgznYmLoLKHkc
	 V6/4+Cp09/2CF6PDvSpUAq3hACKosGgWSggpUU/SQbvECGXZ/peAndVcrOEqKV6k0rVdf
	 Gj2AEWVWAsCpjGG6syxXeQQyPsHVQ8toZgx703pOfdsQ2MOH4ee7aVoKjxSsPE/j7se1O
	 gk+pl/j98sHJq1wuX2M73V8fOL0f6k9HL91bRtL907x4ZqBVjMt8D6VnaYV2CHwyA+h2F
	 5XaQlDOtU7xJTslDiXGt2y1eQiK9GZZOV2sU3AvNdIcpK78QQXki4hPQWXt562xAhdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=GpoVt9829rgvfoUhDyd+CedkZ9hCk1E54sZ/xm+5leo=;
	b=MhepPU4IJDBOk2K+I2BkozS6LifrmEb7cKH8DM//8tA7qkzCnzNRf8p9ikAz5Xd9sFkn
	 OdmtOXRBoWNF5c4FYw8KM8yx+OoyDWjTK6bCHyxTywX7oqYnoKJQgt5c2aARyOgCmu4Qo
	 nVIdM0h4ZVn+aaeTUFcc99fDo5FlWiA65cj0Gi2TOagilcDfQ+iqBXLHTgZw+xc0vslbd
	 o8AvqOIBYt5webK07nY3yiyPkZavc57b352pN2oaQPQDeBio0177MQWZsXRT+YAgV3YON
	 2ytfK+m6T9PNQXke8e/CG/ntm1WElf/dmc4h4IVI3XYfP/dWKZpDW04R4YKQ60cAylw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="G1EI/WHy";
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6AE606A33D
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 20:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF6AE606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G1EI/WHy
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2efc4a84e75so13685ad.1
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 12:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794859497; x=1795464297; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GpoVt9829rgvfoUhDyd+CedkZ9hCk1E54sZ/xm+5leo=;
        b=G1EI/WHynECSj0XtHG1UocXu3+y6slcW4cTA5C/9JLTDuYhF8tRGe4oq7mRF4JBkaN
         byVRaX7wF8ju+EvW7ty/N/LQeYNJl5lwgFzB0Ru25eWloVKD1LYtvQcXHXMUjuAE6Kd+
         QoD4zqTd7GPplyVoY1v1Rol/eqRU9iQj8LBpbSfwIo+iZclfbE6hC5edBEdxyQhYQXSL
         IKdsmoRMX46xasAzlZdSpq0ay05L75Q+BFrjXmC5wQ/vyHowsAvIIdNP1a6jQupw79aS
         znVJlSZTwU06MQgJLkVPjlqsweD1IOytF0dqX6r/QXPUabTy41yoy90b7KFl7oxDx5yU
         zN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859497; x=1795464297;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GpoVt9829rgvfoUhDyd+CedkZ9hCk1E54sZ/xm+5leo=;
        b=LgRiP/SvFhbkTSVAjSTxJkrYuFsS2lk6PgDyfh28EDsPaIxprej2jBeiJGITIaytWz
         C5TL9VlzV7jW9w3+jBB2m1Bls567CxGclIDUd0cEApL9fSbaHZRIL7OZS7Gi4eV8/6RY
         N26i7S1znm73eqeub7TuyNTk1jrZXbLYT3AXfIjs3RFti8EaatkYH3yVy/1FVGXVslU2
         YWlub/CtsxtITRSXzWJT5iO1xYukYsj82Bv6CDCvJVX/UX+rDncr5BCBPCHu2Nz91r6p
         NPeQ2tf07z4/cIf1MDb1624GYbe/Ssknec/21LwTVKUTnhgMx58BRJ1j4A7F/1sk7V0+
         ZOyQ==
X-Forwarded-Encrypted: i=1; AL+hErGXO8m6U6C8XZ5vuBy1CbiWRUTrBU7FXcFOQFcHt+QYjb3JwaWk2k4qvyMGYx//NnBvxtG6JA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+3p+8ycQk+yOKwQpPNPiYWci7Xa5mnZVhNuLiKLKLjmePDBu5o
	L7tFnXErwQce5EKR19lq6OrpecJ5kHfKuH+tp41DCIaYFLzhbYxxtHwRreDCriR9xQ==
X-Gm-Gg: AZFdTZfHB1FI21mRVJuq95NJooPoWRFTbu3R+oSS69ce+FsGJsAOAO0kI/B78cgdpEy
	GHYG+bNwnAalSB/aiiu7Hyx3YQdDRXmk6kIjs/UMNr70HNLTBbw+4ZKQrj//OKOhuRzbyGjMmnO
	n1KGmBM/A2JYSvfB5jHx21fLeOzMv95OSoUTjmyLkyqty0EYijO78wOuyZJSb8FfSREYXOLSrRl
	9Uvphv6QifbLTHQcV6Z/hbEYGvDzx3KleBetiKUjghhj28hVpGoGzH9QeffysihlXti7zMRoT+w
	SXhvri2yZbzKw/zzsBK0kL0eItemtTMR0lAG88iVMunJ5VBHQhPFN8bkMCAcLZwlc0oQKeAM6af
	5XWM4NmtMYEVpt/ZtVsI9SZ/QWQcEUkp15OtPPzyffw769ks+letqxDbj+R/H8O2wBabGlVdL3X
	vLF+ZuLX3+VTFYOvIyUytYjrz9Tc8llIb+FGGUWFapbWtso79hFIwpgazX4YF3dnNqZlYwVaDox
	mVK16bc53WjoX2jPMg/g8in4sIf+M8MgnrYuE+UXsEDVMFYpnsqfzf7+g2YCfKMW419YyUdb/lk
	nfOl8ZWlkbAaHhVAGbKdbjEJ2CrMJK0FEsgMrW6EPz+DSsFlCRYEisyxZPRqPSL5XR3c5I7M6Lg
	ocBJLv8pLjnb0mDaqJWWR2A==
X-Received: by 2002:a17:902:cec9:b0:2ea:4a1:e8a4 with SMTP id d9443c01a7336-2efdac96629mr683765ad.13.1794859496524;
        Mon, 16 Nov 2026 12:04:56 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18adce4sm4599286a12.23.2026.11.16.12.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:04:54 -0800 (PST)
Date: Mon, 16 Nov 2026 20:04:51 +0000
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
Subject: Re: [PATCH v7 13/18] iommu/vt-d: Handle reattach of the restored
 domain
Message-ID: <avtOvPkcidH1RRST@google.com>
References: <20261110040828.1774343-1-skhawaja@google.com>
 <20261110040828.1774343-14-skhawaja@google.com>
 <7ef6d626-4920-434f-bbd9-eda46e7ab780@linux.intel.com>
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
In-Reply-To: <7ef6d626-4920-434f-bbd9-eda46e7ab780@linux.intel.com>

On Mon, Nov 16, 2026 at 03:38:14PM +0800, Baolu Lu wrote:
>On 11/10/2026 12:08 PM, Samiullah Khawaja wrote:
>>Reattach the restored domain to the preserved device using restored
>>domain ID. While reattaching do not setup the context and PASID entries
>>as those are preserved during liveupdate.
>>
>>Note that in this phase nothing clears IOMMU_SER_FLAG_INCOMING of the
>>restored domain or the restored state of the device, so the restored
>>domain cannot be replaced yet. Replacing it is left to a later phase.
>>
>>Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      |  28 ++++--
>>  drivers/iommu/intel/iommu.h      |  14 +++
>>  drivers/iommu/intel/liveupdate.c | 141 +++++++++++++++++++++++++++++++
>>  3 files changed, 175 insertions(+), 8 deletions(-)
>>
>>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>index b3402fd9fe75..95ec37554360 100644
>>--- a/drivers/iommu/intel/iommu.c
>>+++ b/drivers/iommu/intel/iommu.c
>>@@ -3296,6 +3296,9 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>>  {
>>  	int ret;
>>+	if (dev_iommu_restored_state(dev))
>>+		return intel_iommu_attach_restored_device(domain, dev);
>
>How is the restored domain's type and page table format selected? I
>don't see the allocation path using the preserved state to choose
>between different domain type and page table format. Could this result
>in a mismatch with the hardware configuration?

The restored domain is always a paging domain allocated with the default
flags, as only those can be preserved. With the default flags the driver
picks the page table format from the IOMMU capabilities and
configuration. These stay the same across a live update on the same
machine, so the new kernel always picks the same format. I will record
the default paging domain format in the preserved IOMMU state, and use
it when allocating the restored domain to check if the formats match. I
will also add sanity checks in the HWPT preservation for this.
>
>>+
>>  	device_block_translation(dev);
>>  	ret = paging_domain_compatible(domain, dev);
>>@@ -3426,7 +3429,8 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>>  	info->iommu = iommu;
>>  	RB_CLEAR_NODE(&info->node);
>>  	if (dev_is_pci(dev)) {
>>-		if (ecap_dev_iotlb_support(iommu->ecap) &&
>>+		if (!dev_iommu_restored_state(dev) &&
>>+		    ecap_dev_iotlb_support(iommu->ecap) &&
>>  		    pci_ats_supported(pdev) &&
>>  		    dmar_ats_supported(pdev, iommu)) {
>>  			info->ats_supported = 1;
>>@@ -3531,12 +3535,16 @@ static void intel_iommu_release_device(struct device *dev)
>>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>  	struct intel_iommu *iommu = info->iommu;
>>-	iommu_disable_pci_pri(info);
>>-	iommu_disable_pci_ats(info);
>>+	if (!dev_iommu_restored_state(dev)) {
>>+		iommu_disable_pci_pri(info);
>>+		iommu_disable_pci_ats(info);
>
>Above changes are not needed for domain reattachment, right? My
>understanding is that ATS and PRI are not supported for preserved
>devices in this phase. If so, could they be split into a separate patch?

Yes the ATS/PRI should already be disabled for preserved device so this
change is basically a no-op. I will remove this.
>
>>-	if (info->pasid_enabled) {
>>-		pci_disable_pasid(to_pci_dev(dev));
>>-		info->pasid_enabled = 0;
>>+		if (info->pasid_enabled) {
>>+			pci_disable_pasid(to_pci_dev(dev));
>>+			info->pasid_enabled = 0;
>>+		}
>>+	} else {
>>+		intel_iommu_detach_restored_device(dev);
>>  	}
>>  	mutex_lock(&iommu->iopf_lock);
>>@@ -3544,11 +3552,15 @@ static void intel_iommu_release_device(struct device *dev)
>>  		device_rbtree_remove(info);
>>  	mutex_unlock(&iommu->iopf_lock);
>>-	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev) &&
>>+	if (!dev_iommu_restored_state(dev) && sm_supported(iommu) &&
>>+	    !dev_is_real_dma_subdevice(dev) &&
>>  	    !context_copied(iommu, info->bus, info->devfn))
>>  		intel_pasid_teardown_sm_context(dev);
>>-	intel_pasid_free_table(dev);
>>+	if (!dev_iommu_restored_state(dev))
>>+		intel_pasid_free_table(dev);
>>+	else
>>+		kfree(info->pasid_table);
>>  	intel_iommu_debugfs_remove_dev(info);
>>  	kfree(info);
>>  }
>
>Thanks,
>baolu

Thanks,
Sami
