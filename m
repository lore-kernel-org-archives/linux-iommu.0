Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793474394;
	b=gOg2wQFqBhZ9aVaSaAA7L0G047f1Yg1tB7kRFZK7yXY+AwTfGfS/4h1q+5h35hIjPP5j
	 Clj2TDXf/ESm03Z3d6HuUTouykBHDatUpgUj60IkBhPkdzNrwDGqO+K+TK9a40HRd/yYy
	 xQkFuSuyDUgBw2eHk7tVOTX6XanyZZhFawD7mI4UmK3l69N90rUBIJ8lCPSS8LScaUbvH
	 gaF4l6ImCtFharur3KMEeFAQLkTlc16pp8ljyo2lYzrdSOsvR1CN5By7E6RTaNMfHD078
	 HkRRHaVknbKsn+AuD4DLCYzmoAwyl8t3XBdPGqAKru/2NvOBkHkYS1RzKGhA16XFNVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793474394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=FI17lU+UEkaw3gnc3aMhItamMlJeUZRGnzTnl6hwNL4=;
	b=15gS7HQaSJXlwiX9ZrdnBDQe9wb+VLSXyARV3o1JSiQrJwVgxNUD/Urt0K5tYyDEzSJl
	 S8x1J9IOZdutpc51MqY0aSwQKPpc9uxN+TI8nNUoh7emHBx92+oqRGmXIUWLbtIJERH1T
	 SiWg0JWh5ReuTQY/db5P4OuycZ3KpO1tOnDO8dGFo8oeLO6kban4PDS31Q+lVvVuHS+pQ
	 DPqTBeqjbTVXADVO2Ue0fGdOFCMDtuOt75s/OhjIjZhPyTgPBj9GdDfstUL7QjPJ6l9Gt
	 XjMAO0zYuEBkiWFfd3LobTrTCqbIPyFwi0f+NcDQ8pLOInhBIT+7OvmHMhCVRiUglQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YDQ+cz3G;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254F1606A31D
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 19:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 254F1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YDQ+cz3G
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so27615ad.1
        for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 12:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793474392; x=1794079192; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FI17lU+UEkaw3gnc3aMhItamMlJeUZRGnzTnl6hwNL4=;
        b=YDQ+cz3GzRgApEo88OLjxSrWEyGC5nelgti8UY1XkRQ3BP2C+BafonCkQex7w+y0PF
         aL6czEpFNegZDMPaYdug0mlMzjfQtIpcZK90jLXkun0QJgE4O8QKQkJFKX8ACzI//aHg
         ZNlZA6icScg/gB8d+XkK+boUbYnH+4nL6h6FrwvlQMEzgVm3sxyJP802wIa85mh/TDWj
         EP+whnTKlRpCLx1hFyOWbga0w7t0D3jMPiN//7YFE6BYMXu/hoygFrXvg9LArTbcH7xa
         +fVvzZ6lOHz+66Yq1X3cRFdGYjb1kvyB+rSXqzA0Rkgj8ftTZoRzkH+mQV445PL98cMf
         bpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793474392; x=1794079192;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FI17lU+UEkaw3gnc3aMhItamMlJeUZRGnzTnl6hwNL4=;
        b=ltTJ21LgzXge99jp/RTTWwg2fuKsoK8OYjuDwKVrscW66uqTLdMg3j2akWnJY6vUVG
         hnmqMFCl8ukU5izRvdiECn8qsZatOUIyLLkWNkNs4iKPp5JlbW+ZXuacV8uyph+9YaM2
         1loLbkbLOv6oXIQjHqOBlwYNg8vL2pMTadE3ZBhfqohSNwz3NM4uNDHFCkLWpKAlt/A5
         QUGJ3O5FshpQF+d+9rCSU63idcNnWZ1YTdZ7wfsKy/5BZSyrn7sclIIejPc54b6U166c
         IBlsZyX2M1i6kI1dcx1feLRRgvSNupLchCmg/N4l8RT8bw58hcQfPjWrvFAhiWFm5i0R
         zzGg==
X-Forwarded-Encrypted: i=1; AKwUvBygit6QKNrGMRryIwohN1tZqFXA3A6Ad2ghrlZLn4WxpOVX5HDkKZduyJgcFVqFv5GyFGStDw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKQgwtE77n2C9me2oGikDJhS7R6r1vQcPtkPhGUeVj/y3grSQcD
	QLT1j1OnzBWNYzFAPj0K8M+vvmf6uutJQJJB1AnLjYl4X++In/8SiL6mkN/HRLevIg==
X-Gm-Gg: AYBFou2dtcw6f5RV86jhY7eB7n/BqPD9af08Bb4VWLOPYotuT+bOmBXYf+ZB7CwRzhy
	GKyuCJ/jKiYVlpej+WoqKuhgcjG2+FsLYQolWVivWbp7IAiLXJ/pZgWvVhdZrINJmyrhr6hqMfd
	3cUxBUIp4FCSGogRwAQtbjEhmlNWdixKNq0W3NUfbbXXJ4MeX3RFqh+a2S/rVUbxZQYbsF21yQd
	gCImOWZDyil/xhZj5DUWoOkgfVBnS0+to/cJEq7IHZsg8DlNOau2yjfMu8JfNN5UMzcP+Kaou3M
	NVd76VBq6Ri8uS8sgCCBZRxCSCvrqZuiH5GxqZlIYHxCJ0R0IPgYtc5TJTg/CscCucbXzn0V0Bt
	MZXa5JGpx04fgm6FBhWwUJf8Jvwys0a1Na8x9JMpqVA81h1O4o1JPFwhdRQfSBomEq+jzIyfhJf
	3vxCkeYxeI+SYoLjfdoaZmqja80LlbAGX25uHe8jnFxg0R11ulNO071Z6eLi+uUayMLn/r3tj/B
	wbI0HaS70rYmQv5nVHrgEup/CcQwuUoh1yiUtVobTy2crgS5DcvOsNClBOW6PSLjbHFkbc5tyUL
	PnSaYoblwu5N6ZWvQPw1LvIe1TmuzOVgT6NUBn5TK3G7tXiXh++lalc548JXDsb2vzGiCqV17j4
	gliPzVBAnGXvHt+lp2jpW0A==
X-Received: by 2002:a17:903:3c70:b0:2ea:4a1:e8a4 with SMTP id d9443c01a7336-2eb1b8c029emr17343335ad.13.1793474391728;
        Sat, 31 Oct 2026 12:19:51 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7d429fsm12698201a91.2.2026.10.31.12.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 12:19:49 -0700 (PDT)
Date: Sat, 31 Oct 2026 19:19:47 +0000
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
Subject: Re: [PATCH v6 05/18] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <auYtwy3DjRxq3Upi@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-6-skhawaja@google.com>
 <df75f891-05a0-4d47-8705-d6a00c81ff97@linux.intel.com>
 <auTzN4NWuKsBvIZU@google.com>
 <38384919-f0e5-4c93-b71b-065b96a74c38@linux.intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38384919-f0e5-4c93-b71b-065b96a74c38@linux.intel.com>

On Sat, Oct 31, 2026 at 01:34:00PM +0800, Baolu Lu wrote:
>On 10/31/2026 9:45 AM, Samiullah Khawaja wrote:
>>On Fri, Oct 30, 2026 at 01:12:31PM +0800, Baolu Lu wrote:
>>>On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
>>>>Add IOMMU ops to preserve/unpreserve the device state handled by the
>>>>IOMMU driver. This is IOMMU specific state of the device that needs to
>>>>be preserved for liveupdate. These ops can be implemented by the IOMMU
>>>>drivers that support preservation of devices that have their IOMMU
>>>>domains preserved. During device preservation the state of the
>>>>associated IOMMU is also preserved as dependency.
>>>>
>>>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>>>---
>>>> drivers/iommu/iommu-priv.h       |   2 +
>>>> drivers/iommu/iommu.c            |  72 +++++++++++-
>>>> drivers/iommu/liveupdate.c       | 189 +++++++++++++++++++++++++++++++
>>>> include/linux/iommu-liveupdate.h |  76 +++++++++++++
>>>> include/linux/iommu.h            |  33 ++++++
>>>> 5 files changed, 371 insertions(+), 1 deletion(-)
>>>>
>>>>diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
>>>>index 1f9f886b2c10..6b0ef210b32f 100644
>>>>--- a/drivers/iommu/iommu-priv.h
>>>>+++ b/drivers/iommu/iommu-priv.h
>>>>@@ -21,6 +21,8 @@ static inline const struct iommu_ops 
>>>>*dev_iommu_ops(struct device *dev)
>>>> void dev_iommu_free(struct device *dev);
>>>>+bool iommu_group_is_singleton(struct iommu_group *group);
>>>>+
>>>> const struct iommu_ops *iommu_ops_from_fwnode(const struct 
>>>>fwnode_handle *fwnode);
>>>> static inline const struct iommu_ops *iommu_fwspec_ops(struct 
>>>>iommu_fwspec *fwspec)
>>>>diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>>index b486b8bbd1fc..a66363789ca9 100644
>>>>--- a/drivers/iommu/iommu.c
>>>>+++ b/drivers/iommu/iommu.c
>>>>@@ -18,6 +18,7 @@
>>>> #include <linux/errno.h>
>>>> #include <linux/host1x_context_bus.h>
>>>> #include <linux/iommu.h>
>>>>+#include <linux/iommu-liveupdate.h>
>>>> #include <linux/iommufd.h>
>>>> #include <linux/idr.h>
>>>> #include <linux/err.h>
>>>>@@ -328,6 +329,47 @@ void iommu_device_unregister(struct 
>>>>iommu_device *iommu)
>>>> }
>>>> EXPORT_SYMBOL_GPL(iommu_device_unregister);
>>>>+struct iommu_dev_iter {
>>>>+    struct iommu_device *iommu;
>>>>+    iommu_dev_iter_fn fn;
>>>>+};
>>>>+
>>>>+static int _iommu_for_each_dev_cb(struct device *dev, void *data)
>>>>+{
>>>>+    struct iommu_dev_iter *iter = data;
>>>>+
>>>>+    if (dev->iommu && dev->iommu->iommu_dev == iter->iommu)
>>>>+        return iter->fn(dev, iter->iommu);
>>>>+
>>>>+    return 0;
>>>>+}
>>>>+
>>>>+/**
>>>>+ * iommu_for_each_dev() - Iterate over all devices attached to an IOMMU
>>>>+ * @iommu: IOMMU instance
>>>>+ * @fn: Callback to call for each device attached to @iommu
>>>>+ *
>>>>+ * Return: 0 on success, or negative error code.
>>>>+ */
>>>>+int iommu_for_each_dev(struct iommu_device *iommu, 
>>>>iommu_dev_iter_fn fn)
>>>>+{
>>>>+    struct iommu_dev_iter iter = {
>>>>+        .iommu = iommu,
>>>>+        .fn = fn,
>>>>+    };
>>>>+    int ret;
>>>>+
>>>>+    for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
>>>>+        ret = bus_for_each_dev(iommu_buses[i], NULL, &iter,
>>>>+                       _iommu_for_each_dev_cb);
>>>>+        if (ret)
>>>>+            return ret;
>>>>+    }
>>>>+
>>>>+    return 0;
>>>>+}
>>>>+EXPORT_SYMBOL_GPL(iommu_for_each_dev);
>>>
>>>The function has no locking against iommu probe or release, so the
>>>callback can read dev->iommu while it is being freed or before it is
>>>fully set up.
>>
>>It is only called from intel_iommu_shutdown(), which runs after the
>>other CPUs are stopped and interrupts are disabled, so probe and release
>>can't run. I will rename it to iommu_for_each_dev_unsafe(), document
>>that it must only be called at shutdown and drop the export, since the
>>only user is built in.
>
>If it's only intended for the intel iommu driver, then it should be
>open-coded there. There is no need to add an immature interface like
>this to the core. It could be misused in the future.

Agreed. I will open code it in the VT-d driver in the next revision.

>
>Thanks,
>baolu

Thanks,
Sami
