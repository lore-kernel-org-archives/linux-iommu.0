Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793389316;
	b=Z5AKB7lJ0WReYWoE5J9RqSTx4ZWYqMlW9eRtnPrxhiQkdCL0pitfang10P9aWbakHF/E
	 /a8MHx9GMKJUKHB+CZULbpMa18uyTZ9VYbLBKShp161H234vItsXhThbyi7ae16dEtaQ8
	 UyUQgHyZlu7L2J9sIgJ+/kw53TKX0l+2bffiaMIvhB/D56Z1/g40t7N/gqyHAc1C/gGAt
	 lPeYaCrKt4GZZd59ZafJgEr9LTyfHM9UfgQU0emezBl/hjvygfPKSrfUdHZa83yIuRDC0
	 BuBWtxm4Kal2n2rcTD7bqduIpxLYIfux5VcnVQrtPyrGKGQ3pV/zN0/Y+pFhYFB4Ggg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793389316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=dTiMgOnQWSO1fXm1V5etvmBssPqHNLO/3CtDNAXggW4=;
	b=xTUxFdZy2b28jI+29KaS9mfRc1RypZGz8ULDzWU5OxfRVREBdzuUWRaK7TPDpeHMPbCi
	 LTRlIiN+mvaUhqk6lO6YUl7xY7OtPJFNmJvaLB6qpR442L43a/9/E7XPMNYJ1fOXUsyjK
	 CA9bPOfchfMcj10/Nr2ICrNIAUt3Tfeuk1I3weSg1SMTAfNERal1gUJ5C80iJ1tRj64Hi
	 6vI/GcUJecmyU2QAp0FDIGvOVyaPhUDPoSE5/nnyrmzHCkUBii4IbpYpCWnAYcT1ElV1E
	 TqxDex8RSAxjtUlVj4qys6xzkzJxhUoVb7MUFDZpZTPXrJdED49pZQQABc76MuRleZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=av3NVNcT;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4940C606A31C
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 19:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4940C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=av3NVNcT
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so11865ad.1
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 12:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793389315; x=1793994115; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dTiMgOnQWSO1fXm1V5etvmBssPqHNLO/3CtDNAXggW4=;
        b=av3NVNcTDYmVVYY8g8qN6gtr/z1i2b1TjXbBxD00TZUMxaIGdy/SU+DO2lc09qLnrE
         4H6DkUVFtZfs5dncS41vUyS2CDQLmUBDuv7UZqRXZVH3we++gMndzVhndRQ53howEPKE
         yvA15DdgyKZDjjgdq7prJOyyXON1HUsJT88Dca81ilKRXan9LzdVi2Bq2hV1PIs+zbIr
         stcNr4aFm45Hrfvk86Y7KZZA7OlNVJ+L7p24YBYjw540voNKpT372HLodFDK0htHUGgh
         sjMg+jKyuRpPso9czqxE2CcK41+u/rpXfxyk7cm4FN7e5TnKYIchwXMbh2ctx+kebgp3
         rc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793389315; x=1793994115;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dTiMgOnQWSO1fXm1V5etvmBssPqHNLO/3CtDNAXggW4=;
        b=oDYtPQfMu/e43YTdBsoznrC1ImDRqwnKeeEX3t4hwPDQjXnCzuLJJBugnuilC2DqCT
         ncRQgg1KhwZVliTFtZf+mFgbICkZPzvxqmrOx7hy3iGsPHTBgzjEjRzO5wWF9vItXk0t
         c/GGQhWZeDsBN+EqoYLIGennobu48bpE0FNMefKFOVCbsyhDH5ccfemJIFc8uMKFzXBc
         B5ztJfCxhCnw/u9/CeOiOIXlYQOxXhk+mhPj52WWYPoKazXawO0ERKxTTsLdk7vcHZmo
         PbdyEC0clpndkxGD8xHo4E/j/P3ogJBGklY0J+G2ctOqEm1g6aszuE64fetY8I5/rKYX
         koiQ==
X-Forwarded-Encrypted: i=1; AKwUvBywkZ33zcu8ejbWoxF20UpWeb9MzvcX9Vvxg3Ioh8VoF42zWmeiqIqLc3IgbqIzm76H2lweVg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLFYxvk8rrSK5S9RFqKrfH+V2dgO4cPR+pWeurqq9xBYAjzWe3m
	Us8MwpRay45Z93+h/aGLL9o7Xn2xJ/2LrXcThgUA0NGaRE1vCVv0DmU7FwO4cK6TwQ==
X-Gm-Gg: AYBFou2W+dY/IQbh8mHRfioY17vWCk0F3Of/Qs44nDub/7EbC52wXup+qugngiDyI9A
	+SalPWdi3nXXeotjM/eeiWtW800oVY6w18m7LIJXi4L44HJHpG5fyI4e76j01ANEkjorPdIPZMc
	iX3zBe8eYCL43D8FBLv6cfpS1nLDR2uhzc+vuuRjAaYoE3dnDQPL1QgpJdfp6XSS38CLs4vflqm
	YWd1MKn53CnwJUNXbTVoX5ir1wXscCsYUGjlT/QhdLmeyBGCdEXOLHTwzCxW2swq1hElWDEMBsd
	qyz6Cxmgpzl4Il1dPF6Pt1bM1r3fK3n5xSk0JJO9Jgo8bKxAoPaOWTKeqlRSpODjZBxzvQ8IQgl
	7JxGZYY/vz4zPlC0GTwseyA6ykCJ4hzfkxbtdn/ICVFgMXnUSu2lEUSYjpc3z4yuYqsQ4gAxQnp
	DCjlM+MuTuf6RjR5LbCP6w8n7fTQG2G/JGHzBJlrBi/DMPGhF2CWQj6H+5jeTQnHtvqAkeGEBDG
	sOv/YYixJmxRtk++WsGVaVfRNObF9yXEgPQTdsgBhK1hImtmoIe8yIVzlitIP8dQ3aaHyQD5Dp3
	1Gc5K5FcLmFCLJszYzbXXVMefBhG6LgfHw9X3BYQaKX7LCUdWJe5CC48ZMeptl99YsmuaZm+pOm
	wRSwlOmz895Vzl9DJFfe4tdM=
X-Received: by 2002:a17:903:2acc:b0:2e9:73e0:2a6e with SMTP id d9443c01a7336-2eb019ace41mr19649005ad.17.1793389314108;
        Fri, 30 Oct 2026 12:41:54 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb096b7483sm1191940a12.9.2026.10.30.12.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:41:53 -0700 (PDT)
Date: Fri, 30 Oct 2026 19:41:50 +0000
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
Subject: Re: [PATCH v6 02/18] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <auTy6JtTflLq09eD@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-3-skhawaja@google.com>
 <d6e6abad-c3c7-4f99-996a-0030bf6ef166@linux.intel.com>
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
In-Reply-To: <d6e6abad-c3c7-4f99-996a-0030bf6ef166@linux.intel.com>

On Fri, Oct 30, 2026 at 09:26:45AM +0800, Baolu Lu wrote:
>On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
>>IOMMU pages are allocated/freed using APIs using struct ioptdesc. For
>>the proper preservation and restoration of ioptdesc add helper
>>functions.
>>
>>Reviewed-by: Pranjal Shrivastava<praan@google.com>
>>Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>---
>>  drivers/iommu/iommu-pages.c | 109 ++++++++++++++++++++++++++++++++++--
>>  drivers/iommu/iommu-pages.h |  30 ++++++++++
>>  2 files changed, 135 insertions(+), 4 deletions(-)
>>
>
>[...]
>
>>+
>>+/**
>>+ * iommu_restore_pages - Restore pages that were preserved in KHO
>>+ * @phys: Physical address of page to restore
>>+ */
>>+void iommu_restore_pages(u64 phys)
>>+{
>>+	struct ioptdesc *iopt;
>>+	struct folio *folio;
>>+	unsigned long pgcnt;
>>+	unsigned int order;
>>+
>>+	folio = kho_restore_folio(phys);
>>+	if (!folio)
>>+		panic("Failed to restore preserved IOMMU page %llx\n", phys);
>>+
>>+	iopt = folio_ioptdesc(folio);
>>+
>>+	/*
>>+	 * For the restored pages incoherent is set to false as these are not
>>+	 * mapped using the DMA_API. The remapping of these pages using DMA_API
>>+	 * is not needed as these are not going to be written to by the new
>>+	 * kernel.
>>+	 */
>>+	iopt->incoherent = false;
>>+
>>+	order = folio_order(folio);
>>+	pgcnt = 1UL << order;
>>+	iommu_folio_update_stats(folio, pgcnt);
>>+}
>>+EXPORT_SYMBOL_GPL(iommu_restore_pages);
>
>The pages were charged to the VMM's memcg in the old kernel (iommufd
>maps with GFP_KERNEL_ACCOUNT), but after the live update they are no
>longer charged to any memcg. I think that's fine, because the restored
>tables are immutable and will be replaced by ordinary ones after boot.
>
>This patch looks good to me,
>
>Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks for the review,
Sami
