Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793411735;
	b=kkJL1vH2CtB5QNbYPv1Ta6gJlnB3H6tNQNpsE9McpshcdS6uGBLI+YOH6latc8xidPss
	 y/A/CK8y/qb5pqZtKv6w1W1w5PMv3dytSCVe1exNI/2uIMaWeAYwhLPsgZwUMDCux6kzM
	 vUcfsvDpTjiDhyu4+ROO3tPKAEwnOIIxmLBqmkND0gf4QccrBnnLIetMpUgrQ9FcmXHF3
	 rq+wHEbGm9bPC3ktGja2Nwqw1EZeNFxQowC7EYRqJquyUqfUowyh5vYK5zUJYq8JEZ7al
	 rW0d/Q/9enT7Q7367Y9FXmJmNGsUOF1T8ezdtcECwLu+VBeUdtl+yekpRK+Of63eXGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793411735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=L2o29doa9iweGy825AZDWyjKjFpPQ47IdlCL02by6zg=;
	b=1asDLQPD9990wuOnDuVM0Rj+CxhWgfJ8Ql++BWrBY+R03gF98niJI0wAEeZdKfXEqyF8
	 dtr+CF4vZLdh+Tf22F8gz8uyKjuBw53RecdFMwhdkr0RgdfNmWBFILz5J7qNMwbd6uF20
	 j61a+tjCKryKn+oIxwq6Mxe5+eE98wTDV7c8iqwmz1ZjFp/mjg0+F4YuJA2dHREUZ84NL
	 iZiBjkMNVPUP0Gsm1+R42QESTR4zAvhnwvBp7YWsBNIiTNtztwFohEJeuoGvgZBkCA//L
	 NQ3rtqBQzrttRmP32wviiSUTL7CaFRmfotaKo7CSZ+6UAR+JQXev8JMgqeI4dcvFi1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bRqE2OIj;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A0D606A31D
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 01:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81A0D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bRqE2OIj
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2eb0a52d605so26945ad.0
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 18:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793411735; x=1794016535; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L2o29doa9iweGy825AZDWyjKjFpPQ47IdlCL02by6zg=;
        b=bRqE2OIjZ4XD/m91VDvOC40QrnuTANas0lXRecmVXqw3ZqB+NKP2qzGPidq8UVJXVA
         0unEAlWDLzjsvfW2YN65Hwhcwe7vN/hmub+R1PgWFTffeEHJ9kA9eCtrnfrKvOM5eGfc
         duOQJdUUG4WfHn7wmpKJ6ojcPWRIx80EDuVv/mcaaUo2RJSi+whkmJjX2kuSAMTrjEJN
         uWfjJDbq5DeEMxnWkU2RjDhT+cphgi63kIBNsHGVUEwqNih/pql4WBBLpbuX2I7mFI2D
         QKirI47qNIJiCpP1XBFJamX/3v34YS7XJVpCdJkDDJHJsdCWNCuG0aWD0WnLuFGkVriF
         IBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793411735; x=1794016535;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L2o29doa9iweGy825AZDWyjKjFpPQ47IdlCL02by6zg=;
        b=lOduWsICGxvImtZiSX/oIYTwREsrEVEj26yk/mkXBNLx9d0mrACcC7tYCTziOSMSCC
         Huju6Hr2+wuOGZJYu+nG77ZqE5l1gaBr4f2c5uFUTxd8N7gKpCLS1696SaaieXHnCu62
         tNIfOAKIrBS92op8CwOTo3WviSXCQaHQ0qcf57D/HEzZOpU9Ay75z+Un09RE95/fZl4b
         0kGRWH3bCSofXVM3Sm5ztFAe/NQ4530RAYQi00G+FYA0dsCZ2hGdYKyXzl4fVq2KFWPt
         iaTRMoelIxcDMq3AvCtBY/tGbTvnsashQCcNwOBx8JgtrcVIO/2ci5gvSKmYZKKSNq5r
         Y7lw==
X-Forwarded-Encrypted: i=1; AKwUvByz7nvQlffUs0sbeHAOB/87mWtpBP6ylQ2XgqWeOgXGRE7vdNuWCvq4J7CwWKjkvvctE64ABQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIKo0PM6BPPlWhJuR9EmU/Y+4PjQGpDBpQXzbjlwIKzs1J0IAeG
	icag893KWtagJYevjwf2PI+pLQeRkWWzQw1wR3B/rw74mdDl4tbOoUxVNpmFtjyNXw==
X-Gm-Gg: AYBFou3UeNMHKsZEnfnb9RMkMTv11GeZBklwbp0SSnJjwQMEoiVdSvuIIn3g+zyK6oB
	r3XyaL2REbOSKtEI9PmyMMx9HzCZUJG1g52nOOrbqLVi0Ay/0Vx3mgFFxF1Tioiu3V6JEVsAcpJ
	OCxklclPDGwevndN4L8YxMQJ5DtRqoCapFHHXLz3Q+7vAwIhO1Jf9IsGzlA5AlNrttG4eQPOEnB
	Ejj5CKE/BbBnfEs0sLyNNruOCjlMMpYmozpKU2GwKz6I13l9bZzjzHyYCDUJEhf5oiO13zSi5O4
	VQS8uwlmlmHn09aCkAuwL1FTUdAFX+cZs6thFqVj4ckfGRvThZ1JMBGwe6yxNggFNgsa7TtUima
	R/S3AElY3iVNjcjmS7hoPupnFVIEbefPkVZ2rX78LOi335aA7dArQ19fibicmo00Rf5q1F45x0s
	NOFcCrEdaqZ/GcDapiOoRYufsXZNs+z5dXPcu2EmuikckqA6N/GPrshjKU/Ppdb05qBJMP3Czcj
	fhYoYlINyzotlRPGpFxAQzuQIG2WHkeYvjEg7lpIEg3pLjPJS+1FSfvCr6BZegdAxnjDJ8PpG2x
	EwYhbGyt/9HPotIURU7ZzpmM0fY6UrgDY7iAgqP21TMV1xiQKiWLa5lPYf0Mh2ign/XD5zt9nkM
	pOxe74ODd7QAorwzuAaxOGMs8vIBZ4zyZPzP4Wqi1lJ8=
X-Received: by 2002:a17:902:fdab:b0:2e6:f400:5655 with SMTP id d9443c01a7336-2eb1ebe3d33mr14502875ad.3.1793411734199;
        Fri, 30 Oct 2026 18:55:34 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e98afe3sm10181261a91.12.2026.10.30.18.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 18:55:33 -0700 (PDT)
Date: Sat, 31 Oct 2026 01:55:29 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
	Pranjal Shrivastava <praan@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Ankit Soni <Ankit.Soni@amd.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 08/18] iommu: Add APIs to get iommu and device
 preserved state
Message-ID: <auVJWkRz7C_Cs78m@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-9-skhawaja@google.com>
 <7e73da77-3cd2-491a-9ea2-68263f2b5d71@linux.intel.com>
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
In-Reply-To: <7e73da77-3cd2-491a-9ea2-68263f2b5d71@linux.intel.com>

On Fri, Oct 30, 2026 at 02:03:01PM +0800, Baolu Lu wrote:
>On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
>>The preserved state of the device and IOMMU needs to be fetched during
>>shutdown and boot in the next kernel. Add APIs that can be used to fetch
>>the preserved state of a device and IOMMU. The APIs will only be used
>>during shutdown and after liveupdate so no locking needed.
>>
>>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/liveupdate.c       | 88 ++++++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h | 70 +++++++++++++++++++++++++
>>  2 files changed, 158 insertions(+)
>>
>
>[...]
>
>>+
>>+/**
>>+ * iommu_get_preserved_data() - Get preserved data for an IOMMU HW
>>+ * @token: Token used to preserve this IOMMU HW
>>+ * @type: IOMMU type in preserved state
>>+ *
>>+ * Gets the preserved state of an IOMMU HW using token and the IOMMU type.
>>+ *
>>+ * Return: struct iommu_hw_ser on success, NULL if no preserved state found.
>>+ */
>>+struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
>>+{
>>+	struct iommu_hw_ser *iommu_ser;
>>+	struct iommu_flb_obj *flb_obj;
>>+	struct kho_block_set_it it;
>>+	int ret;
>>+
>>+	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
>
>iommu_get_preserved_data() returns the incoming state, while
>iommu_preserved_state() returns the outgoing state. The naming is
>confusing.
>
>How about using "preserved" for the old kernel before kexec and
>"restored" for the new kernel after kexec? For example,
>iommu_get_restored_state() would be consistent with
>dev_iommu_restored_state() and iommu_domain_restored_state().

Agreed. This makes it consistent. I will update this, and rename
iommu_for_each_preserved_device() the same way since it also walks the
restored state.

>
>>+	if (ret)
>>+		return NULL;
>>+
>>+	iommu_ser_set_for_each(&flb_obj->iommu_set, it, iommu_ser) {
>>+		if (iommu_ser->token == token && iommu_ser->type == type)
>>+			break;
>>+	}
>>+
>>+	liveupdate_flb_put_incoming(&iommu_flb);
>>+	return iommu_ser;
>>+}
>>+EXPORT_SYMBOL(iommu_get_preserved_data);
>
>Why are different export macros used in the same file?
>
>  EXPORT_SYMBOL(iommu_get_preserved_data);
>  EXPORT_SYMBOL_GPL(iommu_preserve_domain);
>
>Should these all be EXPORT_SYMBOL_GPL?

Agreed. Will update.
>
>>+
>>  /**
>>   * iommu_preserve_domain() - Preserve an IOMMU domain across live update
>>   * @domain: Domain to preserve
>>diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
>>index cdf8a82b7f1d..10fcdd41c7a1 100644
>>--- a/include/linux/iommu-liveupdate.h
>>+++ b/include/linux/iommu-liveupdate.h
>>@@ -13,6 +13,16 @@
>>  #include <linux/liveupdate.h>
>>  #include <linux/kho/abi/iommu.h>
>>+/**
>>+ * iommu_preserved_device_iter_fn - Callback for iterating preserved devices
>>+ * @ser: Pointer to serialized device state
>>+ * @arg: User-defined context argument
>>+ *
>>+ * Return: 0 to continue iteration, or a negative error code to abort.
>>+ */
>>+typedef int (*iommu_preserved_device_iter_fn)(struct iommu_device_ser *ser,
>>+					      void *arg);
>>+
>>  #ifdef CONFIG_IOMMU_LIVEUPDATE
>>  int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
>>  void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
>>@@ -52,6 +62,46 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
>>  	return NULL;
>>  }
>>+/**
>>+ * iommu_domain_restored_state() - Get restored state of an IOMMU domain
>>+ * @domain: Pointer to struct iommu_domain to get restored state of.
>>+ *
>>+ * Return: Pointer to restored state on success, NULL on error.
>>+ */
>>+static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
>>+{
>>+	struct iommu_domain_ser *ser;
>>+
>>+	ser = domain->domain_ser;
>>+	if (ser && (ser->hdr.flags & IOMMU_SER_FLAG_INCOMING))
>>+		return ser;
>>+
>>+	return NULL;
>>+}
>>+
>>+/**
>>+ * dev_iommu_restored_state() - Get restored state of a device
>>+ * @dev: Target device
>>+ *
>>+ * Return: Restored state pointer or NULL.
>>+ */
>>+static inline void *dev_iommu_restored_state(struct device *dev)
>>+{
>>+	struct iommu_device_ser *ser;
>>+
>>+	if (!dev->iommu)
>>+		return NULL;
>>+
>>+	ser = READ_ONCE(dev->iommu->device_ser);
>>+	if (ser && (ser->hdr.flags & IOMMU_SER_FLAG_INCOMING))
>>+		return ser;
>>+
>>+	return NULL;
>>+}
>>+
>>+int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
>>+				    void *arg);
>>+struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type);
>>  int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
>>  void iommu_unpreserve_domain(struct iommu_domain *domain);
>>  int iommu_preserve_device(struct iommu_domain *domain,
>>@@ -88,6 +138,26 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
>>  	return NULL;
>>  }
>>+static inline void *dev_iommu_restored_state(struct device *dev)
>>+{
>>+	return NULL;
>>+}
>>+
>>+static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
>>+{
>>+	return NULL;
>>+}
>>+
>>+static inline int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn, void *arg)
>>+{
>>+	return -EOPNOTSUPP;
>>+}
>>+
>>+static inline struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
>>+{
>>+	return NULL;
>>+}
>>+
>>  static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser)
>>  {
>>  	return -EOPNOTSUPP;
>
>Thanks,
>baolu

Thanks,
Sami
