Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DB336E484
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 18:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856458; cv=none; b=nXXToAEenSoP/vZdxRlio82x9OxVyM3HHJRmrfaGl5eQJwzVTEPUaSivrdLZcjQSfDCziPzu26tUaDv8YTRyJilh6XpAOiEFe/B3jgasxoJw73QtsNYNVten68WQu6JVZf1eAcS8G6VJHBkBynrzRz0/gsMTSmbEbEo9yI/+fsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856458; c=relaxed/simple;
	bh=s6TDNkQ3m5Ifn1QOQ+tRlAhnTRhRVstkHNNtZuESBYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ky0mQ4IuVn4g3ZldgocGUPQV9NOfK6ZEdRE9X+nJhL7e4Dw1KtldigD9clPSiuIR/ECv/8sHBQARyvUmh3rERnmJhfrWJiENI1poQav9pkd0t3vJ8C+fe6XDXp8AEvTmQv03fq+nJViqSaHJ3tK3zjmaminxlW+rqOnvFn1Vmh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X0Kcge2T; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X0Kcge2T"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d3b445a84fso22115ad.1
        for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 11:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787856457; x=1788461257; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8TWHy0fq0LlmFIRlDT3XzMY9bVByxWoJTpTIiV/A2Vg=;
        b=X0Kcge2T87ZoXNdelQ/l/MziqnHKfYjdt1Wt4EK+G5HiAHQiZ6I+XB2SmFMJs5z8Of
         QvPN0wWkJKsW4KU4XUXoC+JHw8XbBqz5GPpbiia7KlrD3Z2eRYYKzxSWVAvvkwh1v+Og
         eRc6+KcasKYSqjtetWGwOVfN6S1RxTqLYBFP2TJW3LZfUdquyHG1Oyd6ohVG8gELNMfo
         QBh3tl58mC0lA3YCSr19xV1xru5BzZY2byRP4FZH+lWa/aZdQbyMBPdH5mCsGJShMANS
         v9Rc8dGrlb0gUYs59WVtjDZplibML8WaHUnHl079i8Ro+RzYKv5IofjXNn5hDMZop3SL
         AtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787856457; x=1788461257;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8TWHy0fq0LlmFIRlDT3XzMY9bVByxWoJTpTIiV/A2Vg=;
        b=kcie8bWdNM/EQhNvji0iqAJNTiMSYiD/06c474IWkDI5mK9W6hzhHxsBLCePE+S7c5
         8iguajZoTSqYNdMoDTPhQ6aTQIWUwZkk2+usxPCKinWC0w63PqL7fNmSCKFt9EEvSdY0
         Mi2Fk12TC938yVJy7cYbz8hncuV0Ll6kfoM5owwQgsHjgaIUx1Qa6njG4fu6hcfd1QfZ
         SqDO+N0Z6014YbvDCevInQ2UtTErXGeDvppCd2C0OiJXRLUU7YLz5VQcbzDtAGkOiNGJ
         53kn+mMS7zQ94tByqV7QD+MXOVSemARIPHqTgM+CIYxl/QSAN23GN44Yub+66PHO93aB
         g5zw==
X-Forwarded-Encrypted: i=1; AHgh+Ro4mtyEJSmMkkwoLU1t6iTa2PjSV/zIPIfJ0ucKgiv+P1m7XRrw5jMPhKhg2SWHD9gKFDpQ7Q==@lists.linux.dev
X-Gm-Message-State: AFuF++n+2s+LRVnLwKmDGzOTwbtxnRsfHiNj69kUzejZJic+Af+W43Az
	6biyrc9CDY5SkG5Id0NyITsiuxnUQ+zK8wTxjBgTdSEoUC+8SpSTFwZlCEiWyfKDFA==
X-Gm-Gg: AR+sD10VRMcMCR8EApbz35x9sjvH1ZlkCJFjwCUhSi3TU8PL9WVAB7e0f/atld7HN4V
	M7GpW/V0tRWVKv0JMYZdUJQD17ZIQ+D3azINKvL/nVVFGp7OfCA8U2Y6aXSLa2pnm43g8rFkzpz
	ONdld+Yr76X5+U/ZHB/O74LC2Rjw3Sd+nQ00LOarSRV0NiWW+hC8jgUtem/BPwR7id/ilsmcE57
	4Nz+4z8U5Ce4NbvV9Q7/3lvy6BcwV0zQ65nQF1p8/p1hbhNQF+70rMNHcb40Q3aJbQZ9C+J4/s4
	yLlCxaOqSATN0JXBCqKoZuTPRY4bMad+pbKzNfLjRvJdH8NSGR9qWdPh9+rE8CPMsCsVJ3yS3Jk
	uPdkQEOT6ak6CerDPfwFKjB49+KiXZMq303BTdbaEiDUdwepNbwTqJiSji4UEUTII2/11BvNqwr
	Vxm8+pZpUHAhmnHodjIk0EWeQsA0FYWMpPVPtc611WNx2DtY8LTRy1AHI/MR42G1iKEKINMY3tu
	l5Qou21wgtn7Ni5Fj158fwiK1ocsGp2MNX5jXuOjGS4MFZF9cUnaRT9bFs=
X-Received: by 2002:a17:903:2c10:b0:2d5:db3d:1a41 with SMTP id d9443c01a7336-2d74f558e45mr1373495ad.14.1787856456011;
        Thu, 27 Aug 2026 11:47:36 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85359cd5eb4sm2424811b3a.11.2026.08.27.11.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:47:35 -0700 (PDT)
Date: Thu, 27 Aug 2026 18:47:31 +0000
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
Subject: Re: [PATCH v4 10/18] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
Message-ID: <apCC3xMkYkEyQRID@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-11-skhawaja@google.com>
 <5f8963c4-f6b1-44b3-ab2c-ed658822efb4@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f8963c4-f6b1-44b3-ab2c-ed658822efb4@linux.intel.com>

On Thu, Aug 27, 2026 at 03:22:26PM +0800, Baolu Lu wrote:
>On 8/8/26 10:27, Samiullah Khawaja wrote:
>>During boot fetch the preserved state of IOMMU unit and if found then
>>restore the state.
>>
>>- Reuse the root_table that was preserved in the previous kernel.
>>- Reclaim the domain ids of the preserved domains for each preserved
>>   devices so these are not acquired by another domain.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      | 111 +++++++++++++++++++------------
>>  drivers/iommu/intel/iommu.h      |   7 ++
>>  drivers/iommu/intel/liveupdate.c |  69 +++++++++++++++++++
>>  3 files changed, 144 insertions(+), 43 deletions(-)
>>

[snip]

>>+
>>+static int _restore_used_domain_ids(struct iommu_device_ser *ser, void *arg)
>>+{
>>+	int id = ser->domain_iommu_ser.attachment_id;
>>+	struct iommu_hw_ser *iommu_hw_ser;
>>+	struct intel_iommu *iommu = arg;
>>+
>>+	if (WARN_ON(!ser->domain_iommu_ser.iommu_phys))
>>+		return 0;
>>+
>>+	iommu_hw_ser = phys_to_virt(ser->domain_iommu_ser.iommu_phys);
>>+	if (iommu_hw_ser->type != IOMMU_INTEL)
>>+		return 0;
>>+
>>+	/* Only allocate domain ID from associated IOMMU HW unit */
>>+	if (iommu_hw_ser->intel.phys_addr != iommu->reg_phys)
>>+		return 0;
>>+
>>+	/*
>>+	 * This can fail as multiple preserved devices can share the same domain
>>+	 * ID. Since this is done during DMAR init so these failures can be
>>+	 * ignored.
>>+	 */
>>+	ida_alloc_range(&iommu->domain_ida, id, id, GFP_ATOMIC);
>
>This mixes two different cases:
>
>- another preserved device has already reserved the same DID.
>- the DID is not reserved because ida_alloc_range() failed (for example,
>  memory allocation failure).
>
>Case #1 is expected. Case #2 must not be ignored, because it means
>restore failed. So this should probably be something like (not tested):
>
>	mutex_lock(&iommu->did_lock);
>	if (ida_find_first_range(&iommu->domain_ida, id, id) >= 0)
>		BUG_ON(ida_alloc_range(&iommu->domain_ida, id, id, GFP_KERNEL) < 0)
>	mutex_unlock(&iommu->did_lock);

This is a good point, I will update this. Actually, I was thinking of
adding a new struct in the preserved state that represents the
association between domain-iommu-device. All the drivers have this, so
it is better to have a representation of this. Let me evaluate that.
>
>?
>
>By the way, why GFP_ATOMIC here at all?

Will update as you suggested.
>
>>+	return 0;
>>+}
>>+
>>+/**
>>+ * intel_iommu_liveupdate_restore_root_table() - Restore root table and reclaim domain IDs
>>+ * @iommu: Target IOMMU
>>+ * @iommu_ser: Serialized IOMMU hardware state from previous kernel
>>+ *
>>+ * Restores the preserved root table and context tables for the IOMMU hardware
>>+ * instance across Live Update, and reclaims all domain IDs previously allocated
>>+ * to preserved devices so they are not reused.
>>+ */
>>+void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>>+					       struct iommu_hw_ser *iommu_ser)
>>+{
>>+	if (!iommu_ser->intel.restored)
>>+		iommu_restore_pages(iommu_ser->intel.root_table);
>>+
>>+	iommu->root_entry = __va(iommu_ser->intel.root_table);
>>+
>>+	if (!iommu_ser->intel.restored)
>>+		restore_iommu_context(iommu);
>>+
>>+	iommu_ser->intel.restored = 1;
>
>This uses iommu_ser->intel.restored to prevent restoring the root and
>context tables multiple times. For this to work safely, iommu_ser-
>>intel.restored must be 0 the first time restore runs after kexec.
>
>The problem is: this field is inside struct iommu_hw_ser, and that
>struct is allocated in the old kernel. How to ensure that the previous
>kernel has zeroed this out? Maybe I’m overthinking this.

This is a valid point. However, the old kernel allocates this struct
with GFP_ZERO and it never touches the restored field prior to kexec.
So it should be zero in the new kernel.
>
>>+	BUG_ON(iommu_for_each_preserved_device(_restore_used_domain_ids, iommu));
>>+}
>>+
>>  /**
>>   * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
>>   * @dev: Target device
>
>Thanks,
>baolu

Thanks,
Sami
