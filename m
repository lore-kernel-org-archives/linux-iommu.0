Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E852F2B
	for <iommu@lists.linux.dev>; Fri, 11 Nov 2022 16:44:57 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id o30so3243161wms.2
        for <iommu@lists.linux.dev>; Fri, 11 Nov 2022 08:44:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXPe6WX8jBjWxRwy3pL5D2Wep2saGki4oUGtlWeziig=;
        b=z7rnU8PHpAUcZeJff9swLBq9CyhHioh+Jd+XiHGWLy5MMVX6f3LhnmyILrBdUkmz9a
         Av43s/bKY7YO8AWPWkDWIq1MFay5Nn3qlGO07RB6WCV6FzwDM9mqR2TbqksPq8gDUxs7
         W9VlPuoCXPGLcn1CQbXoooiutBvRA44lhVmAeWRApKUeShSvNYc8/s2UFuI7IOAdGOt/
         iuvabu81XyGIosG4jMMYjXaT1IrQeBWl+zU310avL25tn9zTwCQhFofOZhB5u9qnKDvG
         oYDIPHahNUYUUSagugPhikl+3yyjDgrCVvR/U+6g+LdC7kvpfCiC4TNC7KhT7MEJGorn
         5xOw==
X-Gm-Message-State: ANoB5plp26SGe8obYaSGBPKFdJTYxTWfHrj6Npk6CExtYbVVXpVSBIra
	Aj0b1VCZ5Lfn/MZpikprAxM=
X-Google-Smtp-Source: AA0mqf5Sn0xQORHJpQN6R8VYO4G2A2ivXDMnYvQDhL1ytehzwGpbrmIn369cEycyw74wQAil/XuM7w==
X-Received: by 2002:a05:600c:2195:b0:3cf:6c2f:950c with SMTP id e21-20020a05600c219500b003cf6c2f950cmr1893974wme.146.1668185095259;
        Fri, 11 Nov 2022 08:44:55 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d4cc2000000b0023655e51c14sm2282939wrt.32.2022.11.11.08.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 08:44:54 -0800 (PST)
Date: Fri, 11 Nov 2022 16:44:52 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mikelley@microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, luto@kernel.org,
	peterz@infradead.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, lpieralisi@kernel.org,
	robh@kernel.org, kw@linux.com, bhelgaas@google.com, arnd@arndb.de,
	hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
	thomas.lendacky@amd.com, brijesh.singh@amd.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	Tianyu.Lan@microsoft.com, kirill.shutemov@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
	isaku.yamahata@intel.com, dan.j.williams@intel.com,
	jane.chu@oracle.com, seanjc@google.com, tony.luck@intel.com,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2 00/12] Drivers: hv: Add PCI pass-thru support to
 Hyper-V Confidential VMs
Message-ID: <Y258BO8ohVtVZvSH@liuwe-devbox-debian-v2>
References: <1668147701-4583-1-git-send-email-mikelley@microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668147701-4583-1-git-send-email-mikelley@microsoft.com>

On Thu, Nov 10, 2022 at 10:21:29PM -0800, Michael Kelley wrote:
[...]
> Patch Organization
> ==================
> Patch 1 fixes a bug in __ioremap_caller() that affects the
> existing Hyper-V code after the change to treat the vTOM bit as
> a protection flag. Fixing the bug allows the old code to continue
> to run until later patches in the series remove or update it.
> This sequencing avoids the need to enable the new approach and
> remove the old code in a single large patch.
> 
> Patch 2 handles the I/O APIC quirk by defining a new CC_ATTR enum
> member that is set only when running on Hyper-V.

I'm waiting for x86 maintainers acks on these two patches before merging
this series.

Thanks,
Wei.
