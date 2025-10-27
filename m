Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA4D1FF1C7
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581786; cv=none; b=J17mFoAZwKG+koDWkuLT0i/aH6hfI21qqp9lg2vSmO0bC6gDWcOR7WS/Q7wlyTsh8YNee62SpdwG1CmeQL7P4fTP3j9C87HbXvN+n9cRY2OEBekIWybx8vGZjAbj9gzuNLB3gke5UVMuyF8MKy0kVDeMwJNmARiiROLa+RrW/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581786; c=relaxed/simple;
	bh=3wCGtKGfEfUVDnBC8C5bVc0OXhTWmTJ9owWx+LYZ9Z0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHU0IHAN1K07HgaPoCqyqTqv/0v8c1H89ElCgKGShkHn6RmIOHzqhGuD6weB6FnwxTHEYpwtsKcHfXIHxcuNBYVgm3a5S/8cbJcopARFgMj7L+p50eOmN1Eg+QuqtaFe33uhG1Kp4nacJEGwgmhiPhekX6cmN4a2h7i5HPSoXTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GBrnmmN8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GBrnmmN8"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29490944023so30930525ad.3
        for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 09:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761581784; x=1762186584; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+C5nkX5sn1K4bEz3EiVINhEQsJt21mryoGeQgXdKq0c=;
        b=GBrnmmN8ZkVjhvxO+dc900YNLR6w8npvg0BdapU9BbgKkn+wzMlM2IQo39PtKKp7jc
         pTJi5J/jPvMIocx9w67lLwswVtFOe1OBiD9RTOatTV+pMkeaqi7BSeb6tM8CZ0LCuP3a
         CdIfHOklwLchw7z1jDCUZ9euACSBXzqWEF2mc9m5KVCX1iTbqf5GG/grqA4YwTTXhBjY
         jMQMAy46wIGJOq0l1HqNRvWJHdUIrLyh+3LeNM5t1lOS8yKqlmY3c4CyQCcEEHI2rBWA
         jtHKa7rOm4ud59castlxVTlo9IqITZcKpZPzwBREN4V2jTQ/7A+hDLqJL4512I82bopi
         r/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761581784; x=1762186584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+C5nkX5sn1K4bEz3EiVINhEQsJt21mryoGeQgXdKq0c=;
        b=CzNyIiYvvjiCzab2yJ4epWMBedlEs6+woEl7TVVjFKQKckZv6huHUiA0JhRb7YJuvz
         KAuiR3u9aVSSsDTzGeoEDQDy4+Y/Zq3ManWCohHiPd1i2Ke2eQoh2uH0cmbIGeMBWxjs
         SSxEnGLwKH6aFCqvCRxTn5DfwS8RfL9UAxLnxBE8PY7Nx/2lVdG30b/2o0QVlBJk8gpR
         zSCETBtIwPzGzIS50YCl3XeEsyZY/AoAhM9Ofm60Tz4EbD1dyOW5Xpdt5iKJdY17A1wG
         Kxt2bMRCp65bhrz3bnkGoOLwO5jySCbXwjT8Q2RWKNDSY5ffZ8JldwPj6Ee5PuEhFnOt
         b0zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE9UgKfcrO/XyBpYbNa6+O5mTKrEAucevmBS7xQx4S+HqZeJMvS7KRDyN/a4rtmbNpoiGoyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgZU4LB7wXN13qjMCvUq0ZGwjdBAyhmvpR3k3gRhuGvJhqlkbq
	pjKr5iivD23WsMvT2OL02RLlAhBDp3AofL3ZJS//k/IOY0ufbvyqLsJXLEZ+9uVKNzU=
X-Gm-Gg: ASbGnctjp0glX6MLlBYfS1lh4+XoYahSwKEBy6ZNx3sDegwZIBO7DCoUXxne7StM1ls
	wSKWTpNGTArW2LlS6dqWpcVqhtt0eqq65K2HqtBJGakkCv7hwiaqdgVVZmy3TbSrboKT8pSkfvp
	JM8dgQO3HPi9SMvFJis3j5V2ezqocTt+ks9JpEzpp+JtInsOcDdQ+tLM7iLK363eOCtHHPceX1i
	JlC05v/1Oifo9QulLBmIpk9Y4lOICYWvcaJcUecbLzKZ/xHRintg10pzJHPHSPmtVY0wWyvDTwI
	wWP+13wcDPwqIuKV+JG7Q67/7u+2spzSgDBh4UBPJr4uVsTOTLhOSi/i0UnCt6N8SbbGG2m8gEq
	yYaEjDJOK8y9BWPjTagPaPxB6n//52Be/MarMdaf/mRy17xddH6o2rzKAPUarNWhe9vBgrYLC2W
	KQJOswisgOxkYMdfXXZyLvsv9aw4nt3mSgpshlZNEBYYRh
X-Google-Smtp-Source: AGHT+IEvo0w9nrmzLwC61hMvEr51HQII0JiZ9ihmX2g/MOfxFywkHmUnTCvOH6rmdOxXEsaaHDwS4A==
X-Received: by 2002:a17:903:18d:b0:269:936c:88da with SMTP id d9443c01a7336-294cb671783mr4897625ad.41.1761581783862;
        Mon, 27 Oct 2025 09:16:23 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([203.208.189.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d273cdsm85701305ad.55.2025.10.27.09.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 09:16:23 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: joro@8bytes.org
Cc: guojinhui.liam@bytedance.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v2 1/1] iommu/amd: Enable PCIe ACS only if AMD IOMMU is on
Date: Tue, 28 Oct 2025 00:16:17 +0800
Message-Id: <20251027161617.4020-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <3agjkv6s4zk6y4ir7ix7bnqeoxl6i63hcwwksh6dews3wg7v3h@wm2nopcqv6yo>
References: <3agjkv6s4zk6y4ir7ix7bnqeoxl6i63hcwwksh6dews3wg7v3h@wm2nopcqv6yo>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Oct 27, 2025 at 13:30:17 +0100, Jörg Rödel wrote:
> > To preserve PCIe performance, ACS is enabled only when
> > AMD IOMMU is not disabled.
> > 
> > Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> > Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > ---
> >  drivers/iommu/amd/init.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> > index f2991c11867c..38e8c38c5f10 100644
> > --- a/drivers/iommu/amd/init.c
> > +++ b/drivers/iommu/amd/init.c
> > @@ -3314,8 +3314,10 @@ static bool __init detect_ivrs(void)
> >  	}
> >  
> >  out:
> > -	/* Make sure ACS will be enabled during PCI probe */
> > -	pci_request_acs();
> > +	if (!amd_iommu_disabled) {
> > +		/* Make sure ACS will be enabled during PCI probe */
> > +		pci_request_acs();
> > +	}

> Instead of checking amd_iommu_disabled here it is better to move the
> pci_request_acs() call to early_amd_iommu_init(). This function is only called
> when amd_iommu_disabled is false and runs still before PCI probing.

A previous attempt (https://lore.kernel.org/all/20250928065817.1279-1-guojinhui.liam@bytedance.com/)
fails when interrupt-remapping is disabled via CONFIG_IRQ_REMAP=n or intremap=off.

With interrupt remapping off, early_amd_iommu_init() is deferred to rootfs_initcall(pci_iommu_init),
which runs after subsys_initcall(acpi_init) and therefore after pci_enable_acs().

Keep pci_request_acs() in detect_ivrs() to set pci_acs_enable before any PCI device is added,
regardless of the interrupt-remap setting.

PCI devices probe
---
subsys_initcall(acpi_init);
 acpi_scan_init()
  acpi_bus_scan()
   acpi_bus_attach()
    acpi_scan_attach_handler()
     handler->attach()
      acpi_pci_root_add()
       pci_acpi_scan_root()
        acpi_pci_root_create()
         pci_scan_child_bus()
          pci_scan_child_bus_extend()
           pci_scan_slot()
            pci_scan_single_device()
             pci_device_add()
              pci_init_capabilities()
               pci_acs_init()
                pci_enable_acs()

AMD IOMMU initialize
---
rootfs_initcall(pci_iommu_init);
 x86_init.iommu.iommu_init()
  amd_iommu_init()
   iommu_go_to_state(IOMMU_INITIALIZED)
    state_next()
     early_amd_iommu_init()

Regards,
Jinhui

