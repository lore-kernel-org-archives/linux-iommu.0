Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABB63B7753
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787777218; cv=none; b=G6EzHGj3+RgtUrx5+Fwnp3HQgIdLwtk5OyE8bPT9tpVNgkPqyiJa6UVeN9QvyJ6zv8i2ksv/YQHwv9lYMTqZ7tAIi8d0m/gz4t7/9tn79bO4/ycaYIr930R/HlXbgF1WRL89TF6JxN1RYnuCQuCQtlxhF8jicHShTKv5xZfc32Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787777218; c=relaxed/simple;
	bh=8W+6nm1p92cnpBRrsTxdlV28jcWT30IBrjF2fyWBd6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/sHxg8dir8ZzlRSBNbhZZjXIvjG4h2Cuhao79dOM/lAgN2v6d2dB8RxGgjvvXoqiMfoCfViUlaUSP2DZErsZTYtdD1nT7pQZQmYv/I7XfmxtlIboNyKwfpyKIPp8Vf5+UQ5rCJ9UnwPCV7FO5OJ7HOYKMbjIEUs1LwpEO4odH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tcdlcEM4; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tcdlcEM4"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d3b445a84fso9465ad.1
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 13:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787777216; x=1788382016; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tVpNY9AYqp69vRQbsKPPtkBeX+dXdwmZPC7oJAGryqk=;
        b=tcdlcEM4K4dP8qhx2ZONbihB1c18l2W64VwOmClZY5b2rN9FAfxD8vbpTufWm77Wba
         dDx+LGPgP+fzPiWBjr8Se8WyCb3QZKY3UrP7kCENLavAMyy8mumi/vk0121tISoyRwWO
         gtbLvr4bJYe4TSuRoRCVmLMLbF83hMMApwAuhMHPCPQDz7MjLiK0FFW57zgv79KSNSPu
         79+DwMN1YdLIdtWBlYdVnPk+YZzZoCEE3weG/S/CWGLXVMdN46COFvCacQTTn8GV6sCt
         SGCIbj6EpgkOS2J1XTgigvwWgAZde+BgE9WmMiVxSc2ucex4LyXNhMNvcCAbKOLL3a0m
         4bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787777216; x=1788382016;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tVpNY9AYqp69vRQbsKPPtkBeX+dXdwmZPC7oJAGryqk=;
        b=BlzW8Xyr8OZ9aY5kDnguaBxAXEc8xXMsELLoGeLj3QLQm/QaPGgaBugkXHFtvS95Si
         Ndk2oH8Gt0GuuJRHFSjIu5nQPpObqf40N9iNSIiIj0NchLba9Zz00zJELqFJ+mIXYYAv
         ZN9ikSbGIscx+TtSRtLZtM8GMuNJJZft0jP8YnwrjcTVuygYjKLmRrUwAVPwU8gboGp1
         q1lHWBpJ/b6vz3zUVgqQJ8EHt3QG7Eirti2miVfSYdhzSkFWSqD9PbZN5ciaIIzUvggM
         Ba8dpoWR2J1r4t9NHH1++QZ3SvG6vQg+s1Xis1cpuE10wkYV4TJFiFVg03huc6P2oCEC
         yzGQ==
X-Forwarded-Encrypted: i=1; AHgh+RrV4iAn7kAzBRxbiNFKWQ1stM9VFOjycJy0/k8MgH71RKxCeAQdbH7FBwXGGd/FozEF2lubeg==@lists.linux.dev
X-Gm-Message-State: AFuF++lp1t6YoJqjXx940n+UH9titYA4poPoJtTv7b5RyWDMeLLlNJc9
	QoUur9BINgHYsXaHN2hlz5TmoKPc4mml+NKBEuWl3AYjq/b+KgQPrID6e4QXek7u8A==
X-Gm-Gg: AR+sD12FCDUbpygZec1TGizrXUzypkpHXqSHZ6+X73kL+LR1/18Qk28sdx40CKLj+vV
	axfRP4pdZ3AWPJVgbiuuyIk8xAf2sdGw1k+BUAvXtaVq0IVP6dW/ObX86b0BlOULyPl55Ji7Huu
	BvkyEvFB8IGXIfuyqSrPZ0G7CUpRaJmL5Tkdimv4b+4wrs4XaL4jtrY3Beej9rkxXY5Bru6wgZd
	ePa+ZVsqPUqBWA1IXAOM4cBatzsqX8O4njgECyq9Ab2SjuYzJJOv5j946nSgpxPZjALHu4aiXlm
	Z3Irc3cdAl+c0p1RyeskboFg6loXVKRIRrVjCsWwg4tIR18mlL3LSn3ol9i+z5oNKVTL2MvrtVu
	a2eCx8AfMulxjWJp6jBFKxiFxJY2+BS1lcbNj7krDF7WqfUEvMqDczqovlLdO3I7Xw1VNGrEj8n
	Iphzvh5mII6i6GeF/++JNBD7Q5fr9tid0uDCw99Q/8qcZleVkZUEPjMGpdCN2n6eJcKHztYzJ2I
	oY7gELVTqd+5l75WyETZ79FTZkXoxdnNzcdOTVqXmS155wJSVvcV86FmMX19dEYD9EyFw==
X-Received: by 2002:a17:902:e94f:b0:2d5:db3d:1a44 with SMTP id d9443c01a7336-2d73365a24amr151945ad.17.1787777213391;
        Wed, 26 Aug 2026 13:46:53 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1befce3b8sm1396240a12.5.2026.08.26.13.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 13:46:51 -0700 (PDT)
Date: Wed, 26 Aug 2026 20:46:47 +0000
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
Subject: Re: [PATCH v4 07/18] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
Message-ID: <ao9PE9gdOh3DXNvP@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-8-skhawaja@google.com>
 <065b2be2-2ff1-42a0-99b1-ed81e783dca1@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <065b2be2-2ff1-42a0-99b1-ed81e783dca1@linux.intel.com>

On Wed, Aug 26, 2026 at 03:10:31PM +0800, Baolu Lu wrote:
>On 8/8/26 10:27, Samiullah Khawaja wrote:
>>Add implementation of the device and iommu presevation in a separate
>>file. Also set the device and iommu preserve/unpreserve ops in the
>>struct iommu_ops.
>
>This patch, on its own, does not fully implement the preserve operation.
>At this point, the callback preserves all root/context entries used for
>live update, but it does not yet clear non-preserved entries and
>invalidate the related caches; that cleanup is supposed to be done in
>the next patch.
>
>So I think we should either:
>
>- add a brief note here to make this dependency explicit, or
>- merge these two patches into a single patch for completeness.
>
>?

That is a good point. I kept the cleanup patch separate as it has to do
with shutdown and basically getting ready to go into kexec. This patch
mostly focuses on the "preservation of the memory" being used by various
IOMMU data structures.

But I agree, we should add a note about the cleanup here. I will do that
in the next revision.
>
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---

[snip]

>>+#else
>>+static inline int intel_iommu_preserve_device(struct device *dev,
>>+					      struct iommu_device_ser *device_ser)
>>+{
>>+	return -EOPNOTSUPP;
>>+}
>>+
>>+static inline void intel_iommu_unpreserve_device(struct device *dev,
>>+						 struct iommu_device_ser *device_ser)
>>+{
>>+}
>>+
>>+static inline int intel_iommu_preserve(struct iommu_device *iommu,
>>+				       struct iommu_hw_ser *iommu_ser)
>>+{
>>+	return -EOPNOTSUPP;
>>+}
>>+
>>+static inline void intel_iommu_unpreserve(struct iommu_device *iommu,
>>+					  struct iommu_hw_ser *iommu_ser)
>>+{
>>+}
>>+#endif
>
>I believe the #else ... #endif stubs are unnecessary and can be removed.
>
>Specially iommu core checks driver support via callback pointer
>presence:
>
>        if (!iommu->iommu_dev->ops->preserve_device ||
>            !iommu->iommu_dev->ops->unpreserve_device ||
>            !iommu->iommu_dev->ops->preserve ||
>            !iommu->iommu_dev->ops->unpreserve)
>                return -EOPNOTSUPP
>
>So when CONFIG_IOMMU_LIVEUPDATE is disabled, simply not wiring these
>callbacks is sufficient.

Agreed. Will remove these.
>
>>+
>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>>  void intel_svm_check(struct intel_iommu *iommu);
>>  struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
>>+

[snip]

>>+/**
>>+ * intel_iommu_unpreserve_device() - Intel IOMMU callback to unpreserve device state
>>+ * @dev: Target device
>>+ * @device_ser: Struct containing serialized device state
>>+ */
>>+void intel_iommu_unpreserve_device(struct device *dev,
>>+				   struct iommu_device_ser *device_ser)
>>+{
>>+}
>
>Please add a comment explaining why this callback is intentionally
>empty.

Agreed. Will add in the next revision.
>
>>+
>>+/**
>>+ * intel_iommu_preserve() - Intel IOMMU callback to preserve hardware state
>>+ * @iommu_dev: Generic IOMMU device handle
>>+ * @ser: Struct to populate with serialized hardware state
>>+ *
>>+ * Return: 0 on success, or negative error code.
>>+ */
>>+int intel_iommu_preserve(struct iommu_device *iommu_dev,
>>+			 struct iommu_hw_ser *ser)
>>+{
>>+	struct intel_iommu *iommu;
>>+	int ret;
>>+

[snip]

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

Thanks,
Sami
