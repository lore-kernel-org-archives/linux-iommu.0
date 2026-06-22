Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3250833CEA2
	for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 19:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782155959; cv=none; b=NFYtHWAx8fGXNtfu8N39WK5igriJzdFtqV+T11B9aZ98cKzS97H9wva+L38zYt0uiAht58b6Fv1tft+NuOrh+go9DDHkVelx3vGtC9j9TmWRqN9uLlzf2Sj4Cgoik9GzBmmRC935eJIUk2S+xPDMnvuFtEHWeSQL9BjRhxuBSS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782155959; c=relaxed/simple;
	bh=VRGucQtupWQRWS1s+tdmc5UQGx54vGuaacc25MOY5WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCN05XHP8QRSpzYR7g7UU5pyuotELA81PCcdMipnDkfLbLooJYgWN5nKARgcSED7zj8X2AUKlYNFxvaOAsmrH6LWM0lH4az5u3EpUgGCixXThqnL3SkrqXMQ3SEtgSKwR8aoP1tDwaS46ydcgT0sdzoc+eiM5e/friVNUYso/us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mBQu1eBq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mBQu1eBq"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c73cefe192so7365ad.1
        for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 12:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782155956; x=1782760756; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5kwLaFdFxHHe5ydqDODGo5QwfbB8vLExL1rAylvF7mc=;
        b=mBQu1eBq1OFF2RpSQAkzsQ2Vm8M/8ckdj+H3Fbrb82H0RsqIYbYhrhQhSXlAVuod4B
         ZizXOTgrYUa8n2g7AQpgtxj9qklC1JMCJq6EqvE8C8CRsPfU35MvavwFtrIEx9P5XCJR
         fe2PTt7nmJiYV7po+K/SMoJybymlUpKu71DWtKenRcXV1MNuvEuqlar/0X4FZFDxYp/T
         ZEBXKkBKhlFYTRZpEYuXdr2HFF8dAezLgCUwvjuy7N/GbMTTpmlWK0WTv5hv8oVZAuMC
         BZ098HM+VJAOw2w/xXYGkINajNr3xY4qe5VsPFZMKmsF0phtDCdoF0GV0uhRFIW4wtXD
         esIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782155956; x=1782760756;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5kwLaFdFxHHe5ydqDODGo5QwfbB8vLExL1rAylvF7mc=;
        b=nNuvRd9NV5GL7kNFHqjkQiV0AfiikKjhlOK+bnhnGsgBRG1AnQ510R7xgP7HbVZU/q
         rFWabeKYpBnwDT4XPPJ6qwUfM9KtRJRow7y17x5kOKkwee/PumOXj4h3Cr0lJROegSy7
         7oX844QjKOHcS1Fz2nwC1lbsgAKuhTWkdLcNe8IiWCHMugT0ju9+cNZX9EMOph0AIIRr
         8NrRX+qeIdorKimg1iAX2/1ng/jxFWZ5AxH8Qqd6135Q7RLmmSo1IXAajYUWOnTbDVIe
         QluBATP+hbxi0tfDRd3SccZyaIXFoEELujLbnmy0JWZ3f9lXE/su4HdYhhd2t5EtC+sY
         bhvA==
X-Forwarded-Encrypted: i=1; AHgh+RoICbWj0cGi4FosC1LAixur+y0NLhrqx5IZGr+5g9E+5ebONAyPJfIydjpsGx8XKjokjnFxgg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDs0/FV2nqHNHQIPwzte8S+tC1MHqIR3kBfoYX+wMJIeMzyH+q
	1JSdKo5umq3snJQYoUmWfGd9bsbDryieUPI6tGAgbCbKYK2jB3HUqezcBf3wfNXdjw==
X-Gm-Gg: AfdE7cnrtrV+W9GD8htavg4+PsfATo8yrZ/d0MLfcYHgjl3gj7wlzt7qL6lKmEajz+b
	0Cri58SQe74uYTExpTOxVPTj7LoxfZv0ATmPVXUv/CuhZC9VVriLNALMJagz7BrfadJWyQzkN8X
	cHVNGHCdRlKRwCuSDT5O40kUWspvvwinhKbtBkVFKavFFjqcYHLDEO6g29dZALQ8BVUx8Qlu0yy
	NVYYiRmJohGok5y7QVHyJZ7kOELuLWHWONfOat1MzPOVBGwbeJgUogoDA51MMspWaqD/Qbum7Ap
	VPLyCR3stYy+Lowz/w35XCVRRSaynnSjehP+7I5GoTFui21JcgjuKTySqdTwmqrkkRgHoeTZeKb
	woJMhD62IAbZo7ubNTIn0YM382lSbAPFuwl2UAio9Sq9HZUIOtXH2FdYx3XSIz9ht8bso0Q8UK8
	RPn7pfrwx60ig/Hk0BbuLkOCtluNklPcIlahRweRFFfs2FWVzGH9Gw+ycRs2G1uhTGTkNQ30Kr5
	G2RYorm
X-Received: by 2002:a17:903:8cd:b0:2c1:5756:1230 with SMTP id d9443c01a7336-2c7c4c43e3amr480935ad.0.1782155955831;
        Mon, 22 Jun 2026 12:19:15 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ea72d7sm8228523b3a.46.2026.06.22.12.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 12:19:15 -0700 (PDT)
Date: Mon, 22 Jun 2026 19:19:11 +0000
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
Subject: Re: [PATCH v3 07/18] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
Message-ID: <ajl7xfcoKsohfpPJ@google.com>
References: <20260614233728.2212104-1-skhawaja@google.com>
 <20260614233728.2212104-8-skhawaja@google.com>
 <f3e2fef9-4f8c-4032-8d7b-007f47b3fb61@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f3e2fef9-4f8c-4032-8d7b-007f47b3fb61@linux.intel.com>

On Mon, Jun 22, 2026 at 09:50:36AM +0800, Baolu Lu wrote:
>On 6/15/26 07:37, Samiullah Khawaja wrote:
>>Add implementation of the device and iommu presevation in a separate
>>file. Also set the device and iommu preserve/unpreserve ops in the
>>struct iommu_ops.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  MAINTAINERS                      |   8 ++
>>  drivers/iommu/intel/Makefile     |   1 +
>>  drivers/iommu/intel/iommu.c      |   8 +-
>>  drivers/iommu/intel/iommu.h      |  28 +++++
>>  drivers/iommu/intel/liveupdate.c | 175 +++++++++++++++++++++++++++++++
>>  include/linux/kho/abi/iommu.h    |  21 ++++
>>  6 files changed, 239 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/iommu/intel/liveupdate.c
>>

[snip]

>>-
>>  /*
>>   * Take a root_entry and return the Lower Context Table Pointer (LCTP)
>>   * if marked present.
>>@@ -3926,6 +3925,11 @@ const struct iommu_ops intel_iommu_ops = {
>>  	.is_attach_deferred	= intel_iommu_is_attach_deferred,
>>  	.def_domain_type	= device_def_domain_type,
>>  	.page_response		= intel_iommu_page_response,
>>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>>+	.preserve_device	= intel_iommu_preserve_device,
>>+	.preserve		= intel_iommu_preserve,
>>+	.unpreserve		= intel_iommu_unpreserve,
>>+#endif
>
>Any reason why an unpreserve_device callback is missing here?

I added unpreserve_device in a later patch when PASID support is added,
as the context tables are currently unpreserved globally during
unpreserve(iommu).

But I agree this looks incomplete and I will add a stub
unpreserve_device in this patch.
>
>>  };
>>  static void quirk_iommu_igfx(struct pci_dev *dev)

[snip]

>>+
>>+static void unpreserve_context_table(struct intel_iommu *iommu,
>>+				     struct iommu_hw_ser *ser,
>>+				     u8 bus, u8 devfn)
>>+{
>>+	struct context_entry *context;
>>+
>>+	spin_lock(&iommu->lock);
>>+	context = iommu_context_addr(iommu, bus, devfn, 0);
>>+	spin_unlock(&iommu->lock);
>
>The spinlock is dropped immediately after reading the address pointer.
>If this is guaranteed to be safe, please add a comment to explain why a
>UAF or race is avoided here. Otherwise, the locking scope needs to be
>extened to protect both the pointer lookup and use.

In the Intel VT-d driver, context tables are never freed once they are
allocated during runtime, as they can be shared across multiple devices.
So I took the lock here to protect against concurrent allocations inside
iommu_context_addr(). Once the address is read, it is safe to use
without holding the lock until the DMAR unit itself is torn down.

I will add a comment explaining this here.
>
>>+	if (context && is_context_table_preserved(iommu, ser, bus, devfn)) {
>>+		iommu_unpreserve_pages(context);
>>+		clear_bit(CONTEXT_TABLE_PRESERVED_BIT(bus, devfn),
>>+			  (unsigned long *)&ser->intel.context_tables_bitmap[0]);
>>+	}
>>+}
>>+
>>+static int preserve_context_table(struct intel_iommu *iommu,
>>+				  struct iommu_hw_ser *ser,
>>+				  u8 bus, u8 devfn)
>>+{
>>+	struct context_entry *context;
>>+	int ret;
>>+
>>+	spin_lock(&iommu->lock);
>>+	context = iommu_context_addr(iommu, bus, devfn, 0);
>>+	spin_unlock(&iommu->lock);
>
>Ditto.

Answered above.
>
>>+	if (context && !is_context_table_preserved(iommu, ser, bus, devfn)) {
>>+		ret = iommu_preserve_pages(context);
>>+		if (ret)
>>+			return ret;
>>+
>>+		set_bit(CONTEXT_TABLE_PRESERVED_BIT(bus, devfn),
>>+			(unsigned long *)&ser->intel.context_tables_bitmap[0]);
>>+	}
>>+
>>+	return 0;
>>+}
>>+

[snip]

>>diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
>>index d06f251a2df4..ad760c497e13 100644
>>--- a/include/linux/kho/abi/iommu.h
>>+++ b/include/linux/kho/abi/iommu.h
>>@@ -80,6 +80,7 @@
>>   */
>>  enum iommu_type_ser {
>>  	IOMMU_INVALID,
>>+	IOMMU_INTEL,
>>  };
>>  #define IOMMU_SER_FLAG_DELETED	(1 << 0)
>>@@ -140,16 +141,36 @@ struct iommu_device_ser {
>>  	struct iommu_dev_map_ser domain_iommu_ser;
>>  } __packed;
>>+/**
>>+ * struct iommu_intel_ser - Serialized state of an Intel IOMMU instance
>>+ * @restored: Whether IOMMU state is restored
>>+ * @phys_addr: Physical address of the IOMMU register base
>>+ * @root_table: Physical address of the root entry table
>>+ * @context_tables_bitmap: Bitmap representing the context tables that are
>>+ * preserved.
>>+ */
>>+struct iommu_intel_ser {
>>+	u8 restored;
>>+	u8 padding[7];
>>+	u64 phys_addr;
>>+	u64 root_table;
>>+	u64 context_tables_bitmap[8]; /* Tracks upto 512 context tables */
>
>To avoid open-coded magic numbers, how about something like,
>
>#define VTD_PRESERVED_BITMAP_LONGS  DIV_ROUND_UP(512, BITS_PER_LONG_LONG)
>u64 context_tables_bitmap[VTD_PRESERVED_BITMAP_LONGS];
>
>?

This looks great to me. I will update this here.
>
>>+};
>>+
>>  /**
>>   * struct iommu_hw_ser - Serialized state of an IOMMU instance
>>   * @hdr: Common object header
>>   * @token: Unique token for the IOMMU
>>   * @type: IOMMU type serialized state belongs to
>>+ * @intel: Intel specific serialization data
>>   */
>>  struct iommu_hw_ser {
>>  	struct iommu_hdr_ser hdr;
>>  	u64 token;
>>  	u64 type;
>>+	union {
>>+		struct iommu_intel_ser intel;
>>+	};
>>  } __packed;
>>  /**
>
>Thanks,
>baolu
>

Thanks,
Sami
