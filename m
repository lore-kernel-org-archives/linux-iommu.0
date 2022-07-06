Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AC87C
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 19:51:22 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id r18so20556592edb.9
        for <iommu@lists.linux.dev>; Wed, 06 Jul 2022 12:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T/Uniy8LBcxVwi6NUSTS6A3GCA+91o6vI7rMz3Wtdlk=;
        b=qiUwOsPCNmCmsMJzHRsMCaqHx/A29XFx+rEtXjpqLg05bj73vgI77R8nubnEYJ+G4/
         p3lABAQJJTZVJuLPfbcf0/Fbe8CGrKSC202O5G+CGOx6Ltsc0jTW4ZBsabqe1nhSvicM
         hGITTa5Eqvo/4HZ2OLE8sSJ1r0Z5cDjhIo9poy31FT4uT+YeMzQBou6F7hhhgFNb0vJB
         gmaOFBXvzYhqf5RoSr/SXJ6AaRWj15Xso85XVvRCE/8azbqlsFTr9Nc43wazo2H6U4Up
         0lZgKwKvQDF3FBwGEZ7WpsN1gQthA4oR2esJEp+LJQ6WbXe6sXLmZpHrG7GEeW8fjJtk
         O26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T/Uniy8LBcxVwi6NUSTS6A3GCA+91o6vI7rMz3Wtdlk=;
        b=NxFs5F7o4fp6VvX2juTRoVgPgGFEcCeGjMAf0kQhQnaZeGlcj3XfK880Uxo4LVfVC8
         rCqmFCtUqZpn+l6Er6eZsHpGcHDX2H46LwuUpcZyPu+l62NBiB1kw8EZkx0CF911b9JG
         Wzf291FgypbQQSAbsHqQ/Iy/lgn8denj/5AdElHHNpcmIqhqB8M0VoGy7w0+yNQhat+d
         SCaQTdrkl28fAqo2MP1ARSlG1eovkWNNUBVx/19qkxRy9BA4b80OZInLQ55/Y6IIGt0W
         oDkFHTh2iBCCkSfi/bm9v03YHWoSMc6V0SZ3cqQ2+EMtfdY8jyCoCYzLhKu6IJbmwcgb
         HW8w==
X-Gm-Message-State: AJIora/rMKnSeI9kNxu3CIQEW5E3JLvV788+r/Lf+Y4As5iOhntSc///
	zu0DwD5wFMgyxw7Nm3V9R/M=
X-Google-Smtp-Source: AGRyM1tL5OpzeEvjnryKM1zyCU6rO5tLkN/wI78MRbQT2J+6bNMgnN1GnuVvmU0S8Pptetfi9UCRhA==
X-Received: by 2002:a05:6402:42cb:b0:43a:5df2:bb5d with SMTP id i11-20020a05640242cb00b0043a5df2bb5dmr23876112edc.36.1657137080986;
        Wed, 06 Jul 2022 12:51:20 -0700 (PDT)
Received: from anparri.mshome.net (host-79-49-199-193.retail.telecomitalia.it. [79.49.199.193])
        by smtp.gmail.com with ESMTPSA id kz11-20020a17090777cb00b0072af18329c4sm1968127ejc.225.2022.07.06.12.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 12:51:20 -0700 (PDT)
From: "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Stephen Hemminger <sthemmin@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Anvin <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	x86@kernel.org,
	"Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [RFC PATCH 0/2] dma_direct_{alloc,free}() for Hyper-V IVMs
Date: Wed,  6 Jul 2022 21:50:25 +0200
Message-Id: <20220706195027.76026-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Through swiotlb_unencrypted_base.

P.S.  I'm on vacation for the next couple of weeks starting next Monday;
Dexuan/Michael should be able to address review feedback in that period.

Andrea Parri (Microsoft) (2):
  swiotlb,dma-direct: Move swiotlb_unencrypted_base to direct.c
  dma-direct: Fix dma_direct_{alloc,free}() for Hyperv-V IVMs

 arch/x86/kernel/cpu/mshyperv.c |  6 +++---
 include/linux/dma-direct.h     |  2 ++
 include/linux/swiotlb.h        |  2 --
 kernel/dma/direct.c            | 38 +++++++++++++++++++++++++++++++++-
 kernel/dma/swiotlb.c           | 12 +++++------
 5 files changed, 47 insertions(+), 13 deletions(-)

-- 
2.25.1

