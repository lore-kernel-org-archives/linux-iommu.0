Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794887751;
	b=wCtIwSL3Sd5ae5Ef+DRQjF/FdScwCnzW0DI9kL0BbU1TkGJvL/IaGE67qG+uYT3YvZBj
	 opnA4Ag8arWBcTavkrCJU94f+XLfQj3wldmBAWp5KeKUzz8v6GOwOdn3ILbq89LtLj9zF
	 uUkH9kzwBvglbkgRK2V3X5LwjuH5Y00Py0J814+JDSU2VpgZrlWZI6OBBz6ZZWJ3RU/B9
	 X2SNDwFaP+MCJ7heDRj8AKn+OdKFThKlNBLEQ1E1vW10SN/UqK0PcN+2CJBewYXvXvcRK
	 39lrN8bea0pMoFBgQfrjdkE1bKv9plP4VK4PQAdya42zkVurI2WCiT3fXWuNP1VqNeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794887751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=mygYInQxR58p7J21QOwq1w85iqa2FjsjKi0zK68sH8M=;
	b=MxusjhI9b4pliP3fmnSOy00eh2NOtHPZ0TKdYPXD1pnaYd3iUmEqFDpyujektoiqMhD+
	 HBNxFuohAHHGzsNrHDFTT2jSh1JSHaXSDtIyuA+G2m4KzkE0b9E9ta1c938U7GPPpmecE
	 FpdoXUH4wdI85AjIGcNn4JjrdlzRTt1qitCzg9ouDRuqMytPJP8HPhQxi//Z9UyphybMS
	 0pxw14vBZ3MGLkw78P9lYRW6jj41d90pyTe4Y83m8WMFpJrYxZnn1UVrZ0jSpJSCqDJ9N
	 w9DXGgvKGSqDCc1MdPSfy5VlNDBmhxxSYz/eEuiHV0xk8pjG+e3plT2qbk5lCYIlQYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NoxsTvFq;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FCA606A31C
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 03:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89FCA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NoxsTvFq
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ee254f6eefso44845ad.0
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 19:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794887750; x=1795492550; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mygYInQxR58p7J21QOwq1w85iqa2FjsjKi0zK68sH8M=;
        b=NoxsTvFq21AKveyy2RkEBhFwC2wfz1sAqOlqDz0NwQ4VJIhxla5AAOx9GaPHJNemM4
         WK6egHqVrZs8u3ZJAUpT2+a2iyyKQwZkj0LFMmN6vqzJk/MwAyzcEKLRZP5njrNtZLXy
         yq/bGPCkVDJqXXSmamP0oPnSGjaMWa5BJVkodsV2BkC2cGtAjwrDtNo0Yob86c+FsFAb
         7QCIr+Gxk0ZhEN5e4TuDT3xyURxAEycYIPqtFol/llbEgE9e2VEBeOgSVoo74Cq09jov
         ErNQY/WVRDbbbGd5ZSplkcmEigxdExIAqHkV2mVzKTJvVYNb+FnnuJZXJqcc5TG0+LBW
         NatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794887750; x=1795492550;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mygYInQxR58p7J21QOwq1w85iqa2FjsjKi0zK68sH8M=;
        b=iemGo7zzhQe6kSPzFRuzmRNkXVawHO+51F6I6nIYXlQosZf4kX2DhiXDtMiKz++wRg
         g0eITv3dftyxSNgPtlccej7j89caU7xZvDFe9y5t/fziBgie0FZiaBPWbSQFWOQyX3pj
         RNnvO/sUJu1fG2icq3k6agM3jwSIbz83IlseLwR4QvU/YwoxLEONvBeyVRIQyXfjgufP
         8PXoaXKhJ975W/KaDY4DqiADBc8h9Zbm+aHqzg4pfBUKZ2DM8wkqzkUPiEPvrgS94DV/
         h8FuPgvCr1hqni+x3ECCc+4cM57NLCmkCtzX1UBGiYkVWk2wogR1mFn3o7vGJe40VJ5H
         IYkQ==
X-Forwarded-Encrypted: i=1; AL+hErEd/w/iUBf6ggvH3tL5BKjyl6XszCQxshbGLh53sADl63KHHYnE9JRp3lIZ1C5LgkmkIcRBpA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+3CXXrQzL6ZBTRQgjT4mdT0PIzG/3l2ruL7IkdZ+k+BdtJUA/X
	LXYqpgui7GhgkvgXRo/ZIZHv7szHmdS6dhmrOC2Dg8V1Ju+dFT6JeR+8cU2tWC7FUQ==
X-Gm-Gg: AZFdTZcojyJikJCgWTX4BTWuzofPce6uDuVz2OwDvrbME3TxjKPHvq9zvPyAUe/D6VQ
	1tNZtRmds80QVmNplNUw3PUbNan4FhjV+R6xUCGRV0QEM1hRTLcK1fKXwKfUBtuSQDNAtFOo+YV
	DwPnmu6rz7ddpTtCaU6HgxM/gfE4kdffQo9PGbHJI8h6jup+okrv1ayBj4K663uPedmjxNpgj6Y
	WQe784/KzD33J90czlrtUcHh156Gjl50EuqPKT1Alo1mDbfljhr0Fi3czjEMIZZkiEp5XEPu7r1
	2Oxm5jnh/Pugzkqf3AEQu/F0iae5+PRsE3lSVYvYxQBM6gdM+UW3mPnRTEB6aS5gQKrA5fNYl7E
	yPqv75QMdy9wTgp3NGfZoT88jFo+aoUnU5Fxf01V01L1r/rtad/JEwCWxE5uq+hlyGLT2dyyqIk
	bQGKf/06LAgkyQEwObzeKF7+qhOTr2GQ7rIqFPwrMOfiFHKq+zzogC49Rxh+lBk9BVTAr+CYOaw
	OWYZIzPogUZlEfZjRBCQTJGATfv38R2gPrTFtQ9x5PnxrSVXk7fUFjM5feeR3go2C8XItPiH3WH
	HrJ8niQIT28D6GgMBDHZDEau3Bx0sEG2l7zcQCSwrEvHjAlK77lCFnsABDV3VMbsGUp//csXU9A
	9SC2gp29u3dF1O8fmw97FwA==
X-Received: by 2002:a17:902:ce04:b0:2ec:f228:764d with SMTP id d9443c01a7336-2efdc8db07amr2084325ad.18.1794887749194;
        Mon, 16 Nov 2026 19:55:49 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a818asm4348658b3a.17.2026.11.16.19.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 19:55:48 -0800 (PST)
Date: Tue, 17 Nov 2026 03:55:45 +0000
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
Subject: Re: [PATCH v7 12/18] iommu: Restore and reattach preserved domains
 to devices
Message-ID: <avvK73lUs9RXdl0-@google.com>
References: <20261110040828.1774343-1-skhawaja@google.com>
 <20261110040828.1774343-13-skhawaja@google.com>
 <0a38ae25-3eac-42f6-862e-3dc1d644ab97@linux.intel.com>
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
In-Reply-To: <0a38ae25-3eac-42f6-862e-3dc1d644ab97@linux.intel.com>

On Tue, Nov 17, 2026 at 10:29:37AM +0800, Baolu Lu wrote:
>On 11/10/2026 12:08 PM, Samiullah Khawaja wrote:
>>During default domain setup, restore the preserved domains by restoring
>>the page tables using restore() iommupt op. Associated the restored
>>domain with the iommu group of the preserved device, and reattach the
>>domain to the device.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/iommu.c            | 115 +++++++++++++++++++++++++++++--
>>  drivers/iommu/liveupdate.c       | 106 ++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h |  39 +++++++++++
>>  3 files changed, 253 insertions(+), 7 deletions(-)
>
>[...]
>
>>+
>>+/**
>>+ * iommu_restore_domain() - Restore a preserved domain for a device
>>+ * @dev: Target device
>>+ * @ser: Serialized device state
>>+ *
>>+ * Restores or reuses a restored preserved domain for @dev from serialized state
>>+ * @ser.
>>+ *
>>+ * Return: Restored iommu_domain pointer, or ERR_PTR.
>>+ */
>>+struct iommu_domain *iommu_restore_domain(struct device *dev,
>>+					  struct iommu_device_ser *ser)
>>+{
>>+	struct iommu_domain_ser *domain_ser;
>>+	struct iommu_flb_obj *flb_obj;
>>+	struct iommu_domain *domain;
>>+	struct pt_iommu *pt;
>>+	int ret;
>>+
>>+	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
>>+	if (ret)
>>+		return ERR_PTR(ret);
>>+
>>+	mutex_lock(&flb_obj->lock);
>>+
>>+	/* Preserved device should have a preserved domain */
>>+	if (!ser->attachment.domain_phys) {
>>+		domain = ERR_PTR(-EINVAL);
>>+		goto out;
>>+	}
>>+
>>+	domain_ser = phys_to_virt(ser->attachment.domain_phys);
>>+	if (domain_ser->restored_domain) {
>>+		domain = domain_ser->restored_domain;
>>+		goto out;
>>+	}
>>+
>>+	domain_ser->hdr.flags |= IOMMU_SER_FLAG_INCOMING;
>>+	domain = iommu_paging_domain_alloc(dev);
>
>Ah, here it is.
>
>This allocation uses the driver's default. For VT-d, it prefers first-
>stage translation when supported. But the preserved domain may be
>second-stage, for example if it was allocated for dirty tracking or
>nested parent. Would the restore callback then walk the preserved page
>table using the wrong format-specific operations?

Yes, that is a valid case. We can store the allocation flags in the
serialized state of the domain so it picks the right domain format
during restore. Note that in case of dirty tracking, we do not
preserve/restore the dirty tracking state, as the restored domain is
immutable and will be replaced with a new one.

>
>>+	if (IS_ERR(domain))
>>+		goto out;
>>+
>>+	pt = iommupt_from_domain(domain);
>>+	if (!pt) {
>>+		iommu_domain_free(domain);
>>+		domain = ERR_PTR(-EOPNOTSUPP);
>>+		goto out;
>>+	}
>>+
>>+	ret = pt->ops->restore(pt, domain_ser);
>>+	if (ret) {
>>+		iommu_domain_free(domain);
>>+		domain = ERR_PTR(ret);
>>+		goto out;
>>+	}
>>+
>>+	domain->domain_ser = domain_ser;
>>+	domain_ser->restored_domain = domain;
>>+
>>+out:
>>+	mutex_unlock(&flb_obj->lock);
>>+	liveupdate_flb_put_incoming(&iommu_flb);
>>+	return domain;
>>+}
>>diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
>>index fb1e8efac8ec..68c7ebca25f6 100644
>>--- a/include/linux/iommu-liveupdate.h
>>+++ b/include/linux/iommu-liveupdate.h
>>@@ -99,8 +99,31 @@ static inline void *dev_iommu_restored_state(struct device *dev)
>>  	return NULL;
>>  }
>Thanks,
>baolu
>

Thanks,
Sami
