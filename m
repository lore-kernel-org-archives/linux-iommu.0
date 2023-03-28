Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB661EBB
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 06:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679985196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=q07QYa8jqlXV7LzxVNmZ0meSFMFXzUOL6F+BJeKO9po=;
	b=KTNEqRHnh7BxXB2xMEneEgOHymtOkf1Is5g1mZ7D2lKp/9aC88zEma5xK6O4AvX2SN+Kf5
	SMwpQeAvl1VZ+8AwR65d6UsdSkp3hXhvnhe0iHNIoKSc1P+vY0GoslfeP0qU+09ALfnNLc
	n/+7vsbNHdzHf614aB5EvtcFHifnA2A=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-ELrRxD2XNlOu2eY9sXybkw-1; Tue, 28 Mar 2023 02:33:15 -0400
X-MC-Unique: ELrRxD2XNlOu2eY9sXybkw-1
Received: by mail-qt1-f200.google.com with SMTP id x5-20020a05622a000500b003e259c363f9so7509437qtw.22
        for <iommu@lists.linux.dev>; Mon, 27 Mar 2023 23:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679985194;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q07QYa8jqlXV7LzxVNmZ0meSFMFXzUOL6F+BJeKO9po=;
        b=DQ7SVzWlVK6Smzb9jdgQKB0rUC/TXTvLDGXC7zRPcVHCeeCnnfS5Hl/3rpp4/5yV7B
         PI/WHoR8CIlExYs/nD47qpPTga/Jdzkn7uBpa2rzy8NYoN6zEItTNLoWKqbysj2ZQKlt
         LVQ1IoGW7tz3vHAn80xjA+MWGLHibsrgexr4YTTOXjmSPGLL/SPA4fhRjuHd2QHybHTu
         P/LF1zv4Rtj4zN51S64AJqFDOcr46GHNw6BotG+s3322L94Mu73ayimPFP7XnILoDnGJ
         BBOy/hTsQPeKNQrGToyfDLJ0oVb455srrTvmu4VLUeSY4JbbusGZWBYMfZEgd4oryRcQ
         yOcA==
X-Gm-Message-State: AAQBX9fo7QsqfWlYtysgdJTxxl6sd5ACbxjd4vhFi7nMvxvrxaD6/dnI
	FGyAIT9Nv/ilkMDFZXNc7u4F/RhD11Ku4WPgnMc4e4Ez57GAqsq6aB3RRmad36xg6dxLLbMDewM
	UaUORYgh17dawd3PSTzHe+po=
X-Received: by 2002:a05:622a:1355:b0:3e4:f04b:dc5c with SMTP id w21-20020a05622a135500b003e4f04bdc5cmr3016516qtk.41.1679985194327;
        Mon, 27 Mar 2023 23:33:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350a+rWGGTY2mFekqcUySZNWppC/DS66byMXswuk5hRIdnPlhMXLgM1IpzmeiCD1bL1MjA+xFuw==
X-Received: by 2002:a05:622a:1355:b0:3e4:f04b:dc5c with SMTP id w21-20020a05622a135500b003e4f04bdc5cmr3016498qtk.41.1679985194069;
        Mon, 27 Mar 2023 23:33:14 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id q6-20020a37f706000000b0074235386738sm4060093qkj.37.2023.03.27.23.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 23:33:13 -0700 (PDT)
Date: Mon, 27 Mar 2023 23:33:12 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev
Subject: AMD v2 page tables
Message-ID: <bfugskdi4oawsiqobmarhifwh2iy55av6unl2yuvbjyludy7cn@lw3pgvhuk52a>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I was looking at this the other day, and by chance booted it up on a
system with a megaraid_sas controller in it. So it had an IVMD block
for the scratchpad or whatever it is they do. During probing
iommu_create_device_direct_mappings() gets called, and pgsize_bitmap
for the iommu_domain is set to the V1 bitmap because that is the
amd_iommu_ops default. So iommu_pgsize() uses that to figure out what
page size to use for the mapping. Then when it gets into the amd
mapping code it checks that page size against the io_pgtable_cfg
pgsize_bitmap, which is set to the V2 bitmap, sees that it isn't
a supported page size, and bails out of iommu_v2_map_pages().

The following worked, but I'm not sure it is the right answer.

Regards,
Jerry

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5a505ba5467e..040199ac8546 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2048,6 +2048,8 @@ static int protection_domain_init_v2(struct protection_domain *domain)
 
 	domain->flags |= PD_GIOV_MASK;
 
+	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
+
 	if (domain_enable_v2(domain, 1)) {
 		domain_id_free(domain->id);
 		return -ENOMEM;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 10db680acaed..e70e5cbec8cc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1964,8 +1964,13 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 		return NULL;
 
 	domain->type = type;
-	/* Assume all sizes by default; the driver may override this later */
-	domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
+	/*
+	 * Assume all sizes by default if not already set;
+	 * the driver may override this later
+	 */
+	if (!domain->pgsize_bitmap)
+		domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
+
 	if (!domain->ops)
 		domain->ops = bus->iommu_ops->default_domain_ops;
 
-- 
2.38.1

