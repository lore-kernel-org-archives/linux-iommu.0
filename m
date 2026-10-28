Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157044;
	b=APkjJEAk86C7uYXbGIoqeZHUsY/6WeL/+8sRHl2Wp86xVhCenXSilCcKY+glaix2Gi7e
	 OPJ2Pb1AuzVq1hbOlq6STIuI4pEnOsLw0yCOvt58hP9k9v+GagSG4kcNawmVeTYoLweiF
	 WOPuYEX0ULp5XlW6iV5GH/9uaoBGxJt8N2tpELJWeqyKHKXk8oM/jBv9xw5LsKSj0jBE6
	 dutvOzcP++RUnzvosu62L3Y+jbRxAB529zH4VksUPSzl0GGdTMBGYe9EYzq+TwlfP2yO5
	 bX7/tFklOsihOoI7i+iYR0qM7V+bOj/5PdQYUyTVcNQmCDO6NUWqr//Dh9gOQcvAYag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=fy0HfsUMOjewH2fDLKsY21nLEjTbk/eksQFYtRokMBQ=;
	b=FHON98s1junS7e1Br7pu1JHlts3ztf2dFVK97w2ml4oc3cDm+dypRSVMJ5jBiYlw6TeY
	 KdX+FpBxFjsNXYKPwL74pOHJWSgoSnaGsn30vAg5gxuMUy47SWpAvBh1zgc4ENmT4d9ZG
	 4jmib0kO/Iz2jJn005rit6j3+kI7EQCUXbSjjMD5dg3BV2TucZptRH+axzad/3GdEq1UP
	 ljWZnkpvV8I9pqRyNvwDibCt/ZrU6O5w3TD8uFedT3DtM3RgKNIGtVpm+ft3ci5LEog1X
	 +Sjdr+wR9pGssQp4rECsrfr2MaHdQ9t2go3Hby15qr18sMql7NxG1k/y28bFdqLEFbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BaDwqiZw;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D39606A31A
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 03:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6D39606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BaDwqiZw
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ea7f9c11e6so36185ad.0
        for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 20:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793157042; x=1793761842; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fy0HfsUMOjewH2fDLKsY21nLEjTbk/eksQFYtRokMBQ=;
        b=BaDwqiZwwPKyrHPuPDrndR0h467KxS/TQmzSn/ijgrrsDbMkNEzuCAkmm+UlNNhWvn
         gsno5r1NyrlgyRMZ5eCH7KcJakuhXyazVprXlKPOcHaObHToBFp/L5u3gznW2gQ3gV89
         YT5nd1OKzMjAURXqML5THhmxPp+4X/HRzh5ckojjGqji9ts86p0BwR8yltl9PA+htcBm
         mHOJAicGIh1E8yJMZV1FcaJXteDqxY31YkgljRmizWeWGAoj3f+9ATwpLrS7EjSCyJJj
         bvVKAzMkN+ZOL14moJ4U6yEPyYPTQCZ3WhOWzrEN0lCyOBJzd94ig7Q/03//rKegNCGq
         giMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793157042; x=1793761842;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fy0HfsUMOjewH2fDLKsY21nLEjTbk/eksQFYtRokMBQ=;
        b=vBd46jcxQrTTjx1H/+Oi8IL/rvd1PXpX3uIBwVotffZI1KK1LlLKfHPIy6gOCsSloW
         nwzkvWhEJnTnuB8UfPeiYJYCcVmpqKtAEx8Ww7PT2e9mookt7ArlOKwiaLzQjnm1T+3c
         iBAzA2W0fF9NViI7/rbTfhOcQtm66ajW9yY7qKIB86/vWPzsz5muiNMPnfKoc1VMsred
         BnRSQCkPnm/DiwcDdsfA13UpBoF/KT6suWbH965UTRraZ1jTEFYBRvDUb8t7vG/q6rqq
         i3GtyNRMx41+PXFaVV5t8b9ru03xH+H/WsNEiFMnaiIA+ZviH9TmTMwcYTWrSsOu0+iU
         XyXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwkRnZoxNUQwYR2WwRJANeVZnl44NqaEp5C8oy5vmSW/JN/2B/5vbDDJdvRJ2AkG6yu4g8KDw==@lists.linux.dev
X-Gm-Message-State: AFq9FYL1aeqvbU4z+vUo87iMfWrjjNfJH9INZrdwoMchkUvgSol1Sgme
	/aSAXnIw7c8S2dnd2IpY//9VYKNBxMI0iJB9G+lOvgWTHU2H6jtHx2q3nDXxXKL53g==
X-Gm-Gg: AYBFou0dnlHA1hCtKHKsTfKE7gcuCylycz/O8z8l7Qg9DFIROdabyJfiSUFe9TqLxcP
	C4vtby3AC4WDGbJqiIkInDL5w3BPSP7WtV6LHkKrKCwRB6ZAgwAxVzvLKRcZioqhmfs8hXa7fye
	lF1wKKFqvGW0eZI4UZKVkR+DPjQ5NWtWlN+bdVvc2BIVzW0y+sj3yrAbn7tTvLZ8qodduU6MMqO
	i9wcQXqE4cStg0lZMa6Qv1WoKGadmYihOmIYvo3IagffbhrWC85U5rfQSW1lIS2Mgb7+IZlldPD
	xH/+LHb73pmCK6FAAykT/FYclaCbi+mVH18QiGwHgYEA4Sj0VoVJ0IeT66AceZekiwhLssEW8Tj
	yPsRgyATJ293u4DdO4SzzT4FkSpmARyAon/z2iq1u9raLkHRmQLQoanPHz+zGNP5eBJQldlVZsB
	BRTphDGgnpaSCcFNVCDQYwh49XW+CCEXIp6Q7lFsky569z10QY6ZgpHH4twTNSReJeY8Xy4L8vR
	sv9nlc/sdgpr1S8OxD39SZiE3/MHc4cd9TH5WQ0HFGcKoaQNNgaC6sA42oTt8DWH1FLYLWV2Hhv
	cj8382N8Ndzzj9wWNnwESnEusXfWLgc9ULYVJ6gGqLJ2cRqHdhzHOCQmQ2Nbu/iN6J/8kgWP3Yj
	Vp09Lc8Tfexa0+K30893BKQ==
X-Received: by 2002:a17:902:e74d:b0:2e6:1013:ad57 with SMTP id d9443c01a7336-2eb0191f658mr2455145ad.12.1793157041492;
        Tue, 27 Oct 2026 20:10:41 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c90be0sm15672355ad.62.2026.10.27.20.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 20:10:40 -0700 (PDT)
Date: Wed, 28 Oct 2026 03:10:36 +0000
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
Subject: Re: [PATCH v6 06/18] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
Message-ID: <auFnMRfOOZCmU944@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-7-skhawaja@google.com>
 <b35a10e9-e48a-4da5-84d6-caaad693bb3d@linux.intel.com>
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
In-Reply-To: <b35a10e9-e48a-4da5-84d6-caaad693bb3d@linux.intel.com>

On Wed, Oct 28, 2026 at 09:51:18AM +0800, Baolu Lu wrote:
>On 10/25/26 10:19, Samiullah Khawaja wrote:
>>Add implementation of the device and iommu preservation in a separate
>>file. Also set the device and iommu preserve/unpreserve ops in the
>>struct iommu_ops.
>>
>>Preservation is refused for devices where ATS is supported. Carrying an
>>active ATS configuration across kexec would require adopting the ATS
>>state in the PCI core and in the context entries, and handling the
>>disable-to-enable, enable-to-disable and STU mismatch cases for a live
>>device.
>>
>>Note that the preserved iommu root table, context table and device pasid
>>table will need cleanup as devices do not go through the release flow
>>during kexec. So the stale entries need to be removed during shutdown.
>>This is done in the next commit.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  MAINTAINERS                      |   8 +
>>  drivers/iommu/intel/Makefile     |   1 +
>>  drivers/iommu/intel/iommu.c      |   9 +-
>>  drivers/iommu/intel/iommu.h      |  13 ++
>>  drivers/iommu/intel/liveupdate.c | 246 +++++++++++++++++++++++++++++++
>>  include/linux/kho/abi/iommu.h    |  27 ++++
>>  6 files changed, 302 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/iommu/intel/liveupdate.c
>>

[snip]

>>+
>>+static int preserve_iommu_context_tables(struct device_domain_info *info)
>>+{
>>+	struct iommu_hw_ser *iommu_ser;
>>+	struct intel_iommu *iommu;
>>+	int ret;
>>+	int i;
>>+
>>+	/* IOMMU for this device should already preserved.*/
>
>... should already be preserved ...

I will fix this in the next revision.
>
>>+	iommu = info->iommu;
>>+	iommu_ser = iommu_preserved_state(&iommu->iommu);
>>+	if (!iommu_ser)
>>+		return -EINVAL;
>>+
>>+	/*
>>+	 * We could do preservation of context tables only for the bus of this
>>+	 * device, but these devices can have PCI aliases, so context tables for
>>+	 * those will also require preservation. Also unpreserve would require
>>+	 * some kind of refcounting where the context table will only be
>>+	 * unpreserved when the last device associated with it is unpreserved.
>>+	 *
>>+	 * This introduces unnecessary complication with minimum benefits as the
>>+	 * unpreserved context tables will probably be recreated by the next
>>+	 * kernel as these are all active devices. We follow simpler approach by
>>+	 * just preserving the currently active context tables.
>>+	 */
>>+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
>>+		ret = preserve_context_table(iommu, iommu_ser, i, 0);
>>+		if (ret)
>>+			return ret;
>>+
>>+		if (!sm_supported(iommu))
>>+			continue;
>>+
>>+		ret = preserve_context_table(iommu, iommu_ser, i, 0x80);
>>+		if (ret)
>>+			return ret;
>>+	}
>>+
>>+	return 0;
>>+}
>>+
>>+

[snip]

>>+/**
>>+ * struct iommu_intel_ser - Serialized state of an Intel IOMMU instance
>>+ * @features: Bitmask of Intel IOMMU specific features
>>+ * @sm_enabled: Whether the IOMMU was used in scalable mode
>>+ * @phys_addr: Physical address of the IOMMU register base
>>+ * @root_table: Physical address of the root entry table
>>+ * @context_tables_bitmap: Bitmap representing the context tables that are
>>+ * preserved.
>>+ */
>>+struct iommu_intel_ser {
>>+	u32 features;
>>+	u8 sm_enabled;
>>+	u8 padding[3];
>>+	u64 phys_addr;
>>+	u64 root_table;
>>+	u64 context_tables_bitmap[VTD_PRESERVED_BITMAP_LONGS];
>>+} __packed;
>>+
>>  /**
>>   * struct iommu_hw_ser - Serialized state of an IOMMU instance
>>   * @hdr: Common object header
>>   * @token: Unique token to identify the IOMMU instance
>>   * @type: IOMMU type serialized state belongs to
>>   * @reserved: Reserved for future common fields.
>>+ * @intel: Intel specific serialization data
>>   */
>>  struct iommu_hw_ser {
>>  	struct iommu_hdr_ser hdr;
>>  	u64 token;
>>  	u64 type;
>>  	u64 reserved[2];
>>+	union {
>>+		struct iommu_intel_ser intel;
>>+	};
>>  } __packed;
>>  /**
>
>This patch looks good to me,
>
>Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks for the review,
Sami
