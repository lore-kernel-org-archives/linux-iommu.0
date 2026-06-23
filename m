Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E1370D4C
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 01:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179208; cv=none; b=dqDFvtLzoSToA2DmUWELuCUbu/0sG0hFjdtvoEDkM64kzclNzAM0yPyGzjbnmBpXvHxSINmboPoMpasUQFl+OsOs0Bf6Y4kqflsOIJXOoZ2HkfoN2ZxH5L3AHtQbU4IK669jUcRn4hOnarfOX4RoI3mcqCS75zrmCqdKyvUyVLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179208; c=relaxed/simple;
	bh=2apY+z0N2eT8oIYqkywxMesHZ3STxvb01hviFdFriTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OA3WV2RJd48xS3u9QSQ9iyJP9eAWrxygBLiVqHNz404Qji9xz6DS8Kt0nXQSWdMzcNesC/sOnGGe3dR9q9l659m0hcryHkrLZi3dCNCUcFJVUWwdYY9Y+kX2yRSuhEZaXONkHd097nMHQWagV9v3pR2P1/Fecb7vNHt7f6kE0Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hycwDYvo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hycwDYvo"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c69fa0b1f8so25855ad.0
        for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 18:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782179206; x=1782784006; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W573SLR3fQ3LHn7BMqDZVpOE+yHqb2rgziXRTcKO9m0=;
        b=hycwDYvohBuJEZagyKqK8xZ5o6SxQ9w/ngYjRAihK4r6Vc3Fz984Q+zwHEEEFoqutb
         4SzLHefyos0ey1v6Oto6lBnADFlj403vUD6KWevyYYc1EhJLOg9SKhpeXRkRMFczjkyV
         jGWjJvasOD+0CubO81+VjJh7owzMJW6H1ybWzKg7IHGKWAq1CSUKZcGM1LGi1N35KnFG
         VeGTnrMNsUB7tNK00MokQFi1bgzQeGcRC5KMgHfXjBVLkGcpSBjLkTIPkX+BDnTrwF0Z
         El0Rde2RO0sYl3KcLHt3TnIurVkt1tgKUCjeYo3/6LNPIiMAcP/dCWZv19wuRMyxM934
         LOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782179206; x=1782784006;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W573SLR3fQ3LHn7BMqDZVpOE+yHqb2rgziXRTcKO9m0=;
        b=kvon2ZT9GodrL1sBtIX1/IUIh+S/8va/1UcVcc1+aKiyIeVfbLUrjsrk4cAqzPMw0k
         YEVge4rt4uBeQVQ5HJLt6ZZajT7+CrGHiPACkCH7DkvDpC0CWKhU7RQjuMnEYe0Yt3/2
         gEKH6CGPfibW7EVuEcBZpu7l8dIp6trTRsCD6XnI5QB4ePWYQDnsln5s5gCjN0TGVam6
         UkAY6D13m0WP9F7zNbHPBPtv7CStPd2XQ6Rxvbw2UtTXmZAXiAJ+9c6XoVjMvwCHY0ol
         QFjHXip87TOUJDfFjoWFGeDo9kE6Q6EaadgxI4BfKFXFk4uU37OxKRfqrkJSZmfQhQj6
         Gugw==
X-Forwarded-Encrypted: i=1; AHgh+RonqboQC6IEtlLQBUqrKi0nTb1mJkeUpEEGYFHCRlLmnPDyoC1PNEhBp6roDIKLE6s3hYCp2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDsUHYqLa1KUvikRwVgtmOwfQxXgjlGtyes+6OGYDOBJVErVIF
	nsb/+ge+puRe3v2GctO1Y54DWMF8r4qLqrGtdGwhCayC+hsXqldkljoC+lsNKvS7Uw==
X-Gm-Gg: AfdE7ckQ6sZvcThdK/6JQLVrFcowwKnhcjgivY4Fuo7NbToQN90NjDhunL4oL2EP3e/
	4wxUpDqlv1qwOvICdv12MOLyPZ6H4mE2ZQel4zhFmhZK/0Bsm7tcGhOOv8wBOAVwrK8rbYaP/qC
	Gw9KF9YOD1NarVhSYVIkvR5XRfY7SK7zZ9J95tQNU1S7eVm4qWGvmzzUXu+nF+olnVs3S88KFbs
	ZY9ZnimMahwXTUNFSDp5D8pKRDXEoBwiJYkhq/9O9C3Zn/l87qeC7VlnmuKL22johs/7v/qpXK/
	jE1l4LZIf98ngboZjGdVDhSfDqmsqlvQd46GepzxePgn5AMZkpCuqaT9E8uDhTuPs/jtPt2Tlx4
	YCKvQyEbEqIEIF/OqNQVpPTefv/w8eEy+myzhth97x5q51fIjPZmA6cdNxBotuwi+g81gmJkPd4
	oFlwbOyqtj0+YPgc1vqLXxXRwt5QWEtkOBfGG8i6x47I7FFxhD9Gorb6rITnZH+IzNrlLT9Qv0b
	dq8TGaPLHxhpFSQIfY=
X-Received: by 2002:a17:902:ec92:b0:2c6:afdd:e62e with SMTP id d9443c01a7336-2c7c5156f0emr1179185ad.14.1782179205657;
        Mon, 22 Jun 2026 18:46:45 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af54dsm92530885ad.11.2026.06.22.18.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 18:46:45 -0700 (PDT)
Date: Tue, 23 Jun 2026 01:46:41 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Desnes Nunes <desnesn@redhat.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	stable@vger.kernel.org, baolu.lu@linux.intel.com, dwmw2@infradead.org
Subject: Re: [PATCH] iommu/vt-d: Fix UCTP context table slot when copying
 root entries
Message-ID: <ajnlKDglN6wEBBrS@google.com>
References: <20260622133540.48591-1-desnesn@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260622133540.48591-1-desnesn@redhat.com>

On Mon, Jun 22, 2026 at 10:35:40AM -0300, Desnes Nunes wrote:
>When translation is already enabled at boot (e.g. kdump), the vt-d driver
>copies context tables from the previous kernel's root table. In scalable
>mode, buses that only populate the upper root half (UCTP, devfn >= 0x80)
>should be written to ctxt_tbls[tbl_idx + 1] through copy_context_table().
>However, the current copy path always uses tbl[tbl_idx + 0] in this situa-
>tion. Since idx wraps to 0 at devfn 0x80 due to a zeroed LCTP, new_ce for
>LCTP will be NULL and keep pos equals to 0. Thus, UCTP entries will be co-
>pied into tbl[tbl_idx + 0] instead of tbl[tbl_idx + 1], and written after-
>wards to root_entry[bus].lo instead of .hi in copy_translation_tables().
>
>As consequence, devices on bus 0x80 with devfn >= 0x80 fail DMA with
>fault 0x39, which breaks drivers running in kernels with translation
>pre-enabled. This fixes NO_PASID DMAR faults for UCTP-only buses such as:
>
>DMAR: [DMA Read NO_PASID] Request device [80:14.0] fault addr 0xe81759000 [fault reason 0x39] SM: Present bit in Root Entry is clear
>
>Fixes: 091d42e43d21 ("iommu/vt-d: Copy translation tables from old kernel")
>Signed-off-by: Desnes Nunes <desnesn@redhat.com>
>---
> drivers/iommu/intel/iommu.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>index 4d0e65bc131d..737936f942a0 100644
>--- a/drivers/iommu/intel/iommu.c
>+++ b/drivers/iommu/intel/iommu.c
>@@ -1443,7 +1443,7 @@ static int copy_context_table(struct intel_iommu *iommu,
> 			      struct context_entry **tbl,
> 			      int bus, bool ext)
> {
>-	int tbl_idx, pos = 0, idx, devfn, ret = 0, did;
>+	int tbl_idx, tbl_slot = 0, idx, devfn, ret = 0, did;
> 	struct context_entry *new_ce = NULL, ce;
> 	struct context_entry *old_ce = NULL;
> 	struct root_entry re;
>@@ -1459,10 +1459,9 @@ static int copy_context_table(struct intel_iommu *iommu,
> 		if (idx == 0) {
> 			/* First save what we may have and clean up */
> 			if (new_ce) {
>-				tbl[tbl_idx] = new_ce;
>+				tbl[tbl_idx + tbl_slot] = new_ce;
> 				__iommu_flush_cache(iommu, new_ce,
> 						    VTD_PAGE_SIZE);
>-				pos = 1;
> 			}
>
> 			if (old_ce)
>@@ -1484,6 +1483,9 @@ static int copy_context_table(struct intel_iommu *iommu,
> 				}
> 			}
>
>+			/* Track if saving UCTP or LCTP entries in scalable mode */
>+			tbl_slot = ext && devfn >= 0x80 ? 1 : 0;
>+
> 			ret = -ENOMEM;
> 			old_ce = memremap(old_ce_phys, PAGE_SIZE,
> 					MEMREMAP_WB);
>@@ -1512,7 +1514,7 @@ static int copy_context_table(struct intel_iommu *iommu,
> 		new_ce[idx] = ce;
> 	}
>
>-	tbl[tbl_idx + pos] = new_ce;
>+	tbl[tbl_idx + tbl_slot] = new_ce;
>
> 	__iommu_flush_cache(iommu, new_ce, VTD_PAGE_SIZE);
>
>-- 
>2.54.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
