Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C7915E5D2;
	Thu, 29 Aug 2024 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920444; cv=none; b=fn4GHqft+/CXaDSBlZiJZpzg/dlOekBoTZ6fJE0JhztBqJBFYpWg3Q3LhtxwU5fTAbHfnD0zcvDvI86FW9NSvXs7miPIUAnLbw8RxKMU0l3keTdZRxqFhYJMuMzesXlarL4t0bSOHvKMUpQ3++QbrVT/I5wtr1rGYlTvBs0znys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920444; c=relaxed/simple;
	bh=xnO6Vk/kr83JqD3+FgZr+ybVhaKA2iYaHmoGntXHCUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLv6dS+/WKk+XGpoRTlLME5Z7FQ4qNmOPtwtSkj248s3fuMwokj7R38C8xlnzIHeaolMAqiM9aqRjMUgnA8P9eHaWwd8bu8adi1fbnNZ4XoUnEbE8h+na9+2Q3/Tr0bg0Br8jzlAsPoee/8tutrwwkDwXBe9oEkdd54ja9x7ack=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvWtyZKe; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvWtyZKe"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6b5b65b1b9fso3619217b3.2;
        Thu, 29 Aug 2024 01:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724920442; x=1725525242; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nZH8C/6+CJkUjQ49MDGAsBNiI4/0rHnzfSpqasFYyAQ=;
        b=ZvWtyZKe8RMqNaxBV8Das0pu+nKdPtnkIo+KP/HyKn0UyIty0wYuohf72Yl5ylPAUI
         AOCTGsZy9SJUn6UyggsgOddSBhmPv+Zw9qOTwm2WJec6MCA1I/HRMRKQ8EqI6oGUA1os
         t7IVkIzS7sk4YHNjo/tfbFTWvq7vfZszelWluePU9M1M5wWHvaVnqAVjP0jyScivizDc
         Tk2cOdiBIOYFOnw/roDc78fvD/rLG8AciFi1kcAuGYitI5wru9HhPPJODIZ0qpH6vvhZ
         0pov7vzd5CFli20GWPxelVMFliAnktY12OUUoDlY7NytonDObnsph8k9YsCDo7K1Ihai
         nJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724920442; x=1725525242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZH8C/6+CJkUjQ49MDGAsBNiI4/0rHnzfSpqasFYyAQ=;
        b=iwzqaH2M+CPx9qK4q79IczsEl0fduOKsUUwlFTPfOSUCSSoBiknA8fq3vvOPe1eEd3
         OUx3YM69atstAgWiTwEwLIN7SJnpBTktwJDXoYV1UCKOm98H/HVnHa6YC2/k8X+2QvpG
         4fFb9YTkhYUgCda3Yo0Yp8YdcnlO74KJ87I1IFJvZhosWORv+OVPrbQt/PZqo0nrXH7k
         hxObX7BVqOFtpqzIhOpL5AwQRBbipIK3PpbhV0bqiJTmIW3lX9KnJmW2GjNBgNXj3vlf
         srLzFitqnIbe3mRDgveLcWE8tJzpMbCHTPVkkk9OQND3maBlqYEprnPbHZkihmy7ua5+
         14jA==
X-Forwarded-Encrypted: i=1; AJvYcCVg0BbxLKshBPHuwozk1Pht2Jw5i4C2ekwTmHVATe2817W0UCiRi+ItHUh87BEUDv9Lwdqvqw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6kq0U8yDpuOIKuU5PTO76aUQ8wp14lkc34c+WQF2Zmstya61D
	RC4rcBS4Fndd5eamv8J+gw5ToTYTy1kIkPcUR2SjEHBn/6qzeDRmb2Te7y2c1h2Q+i3SW7JQkfa
	9tHwOBkGBGAO5oPmETcI/5P2HyQs=
X-Google-Smtp-Source: AGHT+IFIIJBgW3DmgTVJDmDJspPS4/uQxe5thXeBxoW8qdyKIaXW/D3gCaAHqkLJr6InbrRLPMRAFDNFKsLa8HWjQDk=
X-Received: by 2002:a05:690c:a96:b0:664:5957:f7a with SMTP id
 00721157ae682-6d27620cb1fmr23909667b3.15.1724920442069; Thu, 29 Aug 2024
 01:34:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <c844faa0-343a-46f4-a54f-0fd65f4d4679@leemhuis.info>
 <BN9PR11MB5276CA2E1922D9FD6B9F2ECF8C962@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CAOcK=CN3-v=dgMC9XTbh-h0zaD01uatOZKjvSF7ocofTCOGp7Q@mail.gmail.com>
 <CAOcK=CPi1TokgySF77X+zuQ10kxfsfCXekYVanPhF51+Ow1XRg@mail.gmail.com> <CAOcK=CM4Poawy2AN3f6C2ooPdoT=dg4J9Bg1Fu=gsFjvkrBpQw@mail.gmail.com>
In-Reply-To: <CAOcK=CM4Poawy2AN3f6C2ooPdoT=dg4J9Bg1Fu=gsFjvkrBpQw@mail.gmail.com>
From: Markus Rathgeb <maggu2810@gmail.com>
Date: Thu, 29 Aug 2024 10:33:50 +0200
Message-ID: <CAOcK=COEd0njBPGhJ8idaLbaqvATr_zSB1O9dyzwi+fbU8GhqA@mail.gmail.com>
Subject: Re: [regression] usb and thunderbould are misbehaving or broken due
 to iommu/vt-d change
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>, Adam Williamson <awilliam@redhat.com>
Content-Type: text/plain; charset="UTF-8"

With respect to my previous comment I tested to fix it myself (I am
not a kernel hacker and do not know anything about iommu etc.).

After applying the following change to the v6.11-rc5 it seems to fix my problem.
I can connect, disconnect and connect the dock and USB is working and
no DMAR error.




From 5f621c079f0f8bce9895ae05a9cd81b001a58089 Mon Sep 17 00:00:00 2001
From: Markus Rathgeb <maggu2810@gmail.com>
Date: Thu, 29 Aug 2024 09:37:17 +0200
Subject: [PATCH] fix: iommu/vt-d: Add helper to flush caches for context
 change

Signed-off-by: Markus Rathgeb <maggu2810@gmail.com>
---
 drivers/iommu/intel/iommu.c | 7 +++++--
 drivers/iommu/intel/iommu.h | 3 ++-
 drivers/iommu/intel/pasid.c | 4 ++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9ff8b83c19a3..e92e06e604b2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1944,6 +1944,7 @@ static void domain_context_clear_one(struct
device_domain_info *info, u8 bus, u8
 {
     struct intel_iommu *iommu = info->iommu;
     struct context_entry *context;
+    u16 did_old;

     spin_lock(&iommu->lock);
     context = iommu_context_addr(iommu, bus, devfn, 0);
@@ -1952,10 +1953,12 @@ static void domain_context_clear_one(struct
device_domain_info *info, u8 bus, u8
         return;
     }

+    did_old = context_domain_id(context);
+
     context_clear_entry(context);
     __iommu_flush_cache(iommu, context, sizeof(*context));
     spin_unlock(&iommu->lock);
-    intel_context_flush_present(info, context, true);
+    intel_context_flush_present(info, context, did_old, true);
 }

 static int domain_setup_first_level(struct intel_iommu *iommu,
@@ -4269,7 +4272,7 @@ static int context_flip_pri(struct
device_domain_info *info, bool enable)

     if (!ecap_coherent(iommu->ecap))
         clflush_cache_range(context, sizeof(*context));
-    intel_context_flush_present(info, context, true);
+    intel_context_flush_present(info, context,
context_domain_id(context), true);
     spin_unlock(&iommu->lock);

     return 0;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b67c14da1240..0a4ce98faa60 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -988,7 +988,7 @@ static inline int context_domain_id(struct context_entry *c)
     return((c->hi >> 8) & 0xffff);
 }

-static inline void context_clear_entry(struct context_entry *context)
+static inline void     context_clear_entry(struct context_entry *context)
 {
     context->lo = 0;
     context->hi = 0;
@@ -1154,6 +1154,7 @@ void cache_tag_flush_range_np(struct dmar_domain
*domain, unsigned long start,

 void intel_context_flush_present(struct device_domain_info *info,
                  struct context_entry *context,
+                 u16 did,
                  bool affect_domains);

 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 5792c817cefa..cb4bbb45ac2a 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -694,7 +694,7 @@ static void device_pasid_table_teardown(struct
device *dev, u8 bus, u8 devfn)
     context_clear_entry(context);
     __iommu_flush_cache(iommu, context, sizeof(*context));
     spin_unlock(&iommu->lock);
-    intel_context_flush_present(info, context, false);
+    intel_context_flush_present(info, context,
context_domain_id(context), false);
 }

 static int pci_pasid_table_teardown(struct pci_dev *pdev, u16 alias,
void *data)
@@ -885,10 +885,10 @@ static void __context_flush_dev_iotlb(struct
device_domain_info *info)
  */
 void intel_context_flush_present(struct device_domain_info *info,
                  struct context_entry *context,
+                 u16 did,
                  bool flush_domains)
 {
     struct intel_iommu *iommu = info->iommu;
-    u16 did = context_domain_id(context);
     struct pasid_entry *pte;
     int i;

-- 
2.46.0
