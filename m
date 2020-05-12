Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC884CA90AF
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 17:05:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85599206B8
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 17:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFVPVX42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85599206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4A2AB8948C;
	Tue, 12 May 2020 17:05:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5EuqQedM32wL; Tue, 12 May 2020 17:05:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 257548948A;
	Tue, 12 May 2020 17:05:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AED7C088A;
	Tue, 12 May 2020 17:05:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82B85C016F
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 17:05:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 67A6126244
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 17:05:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e5mUH6EdujoG for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 17:05:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by silver.osuosl.org (Postfix) with ESMTPS id 2ED5020511
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 17:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589303118;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=NQsZdhRM5gIgPtMfQMnU66AoyPDuBpRTokOdoS4x+qA=;
 b=MFVPVX42BTnwtrGNRMt/UzLr7RiBZUm8Us6SDyzGbdTBgIONayhrL8bpE4/Y7eFSDpppBf
 UhwmaLLQdu9xBSmYB/YLHvceeNEZ1Xl3TCXTOTt6BVtR8NLcTA0C5uBwyfK2lL6m1c8R4s
 f5kSFAwDC90i5fUjBBKIYnQLizF12Bg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-SZsvxB_OO2Ov7MfFO6utmg-1; Tue, 12 May 2020 13:05:06 -0400
X-MC-Unique: SZsvxB_OO2Ov7MfFO6utmg-1
Received: by mail-qk1-f200.google.com with SMTP id y64so14214910qkc.19
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 10:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=NQsZdhRM5gIgPtMfQMnU66AoyPDuBpRTokOdoS4x+qA=;
 b=fggruqTSWqEN55HwfUpKJlgn3HOiGYQ6CI/OHtUOMqU99amiwElNOv9yHaFgsdCcys
 zgOniV0E2wThb4/S04fylwk+Ca/tIiwf59EE3yZQN948TCecOMwsspacvodj7NZHv+9y
 XAQIrDW50NJbUSNilB+bGPiHcemoLZxozUwsf7teX8MqOftBp5xCtBTXKfG/qjSF/u8S
 FdlImMbEuz6IIJHTlBbS2yeUYpYfab0Le+HUBUBkTuE5L4HzLxUEFWaNW/LgwJn/m7sh
 JiI94Lup1mrGMfQbb55F5QO0pxTkCOrai5Gh7fUNnIJyQt9yht676c1tuJCedfddg2O4
 z5BA==
X-Gm-Message-State: AGi0Pubq317vm7Ee4az65TN7Lz1zU40625tw9oNtQFsZf4y60CdLcOXg
 YQHb2/pPk/75pJ6YRkD2WCOoRIoWEn2JaTS5etMNfuEe+35vbwr1ulIJ9IgHXdkVPlZf3a8GsYM
 43fbmcuovZij0MYfeHZFSN3u1mmsKQQ==
X-Received: by 2002:a37:a8cb:: with SMTP id
 r194mr21225767qke.342.1589303106456; 
 Tue, 12 May 2020 10:05:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypLE0CmPSv9/GgTYzXzA9V5mJ2Hx5/ecjiiOjRgiYtfr9m5AwRQVkp8vhmle37LvlVE7OKuSmA==
X-Received: by 2002:a37:a8cb:: with SMTP id
 r194mr21225749qke.342.1589303106181; 
 Tue, 12 May 2020 10:05:06 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id h12sm6069301qte.31.2020.05.12.10.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 10:05:04 -0700 (PDT)
Date: Tue, 12 May 2020 10:05:03 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 0/3] Replace private domain with per-group default
 domain
Message-ID: <20200512170503.skwillhipuvocaff@cantor>
Mail-Followup-To: Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
 jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
 Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Daniel Drake <drake@endlessm.com>,
 Derrick Jonathan <jonathan.derrick@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
References: <20200506015947.28662-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20200506015947.28662-1-baolu.lu@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 Daniel Drake <drake@endlessm.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Derrick Jonathan <jonathan.derrick@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed May 06 20, Lu Baolu wrote:
>Some devices are required to use a specific type (identity or dma) of
>default domain when they are used with a vendor iommu. When the system
>level default domain type is different from it, the vendor iommu driver
>has to request a new default domain with either
>iommu_request_dma_domain_for_dev() or iommu_request_dm_for_dev() in the
>add_dev() callback. Unfortunately, these two helpers only work when the
>group hasn't been assigned to any other devices, hence, some vendor iommu
>driver has to use a private domain if it fails to request a new default
>one.
>
>Joerg proposed an on-going proposal which makes the default domain
>framework to support configuring per-group default domain during boot
>process.
>
>https://lkml.org/lkml/2020/4/14/616
>[This has been applied in iommu/next.]
>
>Hence, there is no need to keep the private domain implementation
>in the Intel IOMMU driver. This patch series aims to remove it.
>
>Best regards,
>baolu
>
>Change log:
>v3->v4:
> - Make the commit message of the first patch more comprehensive.
>
>v2->v3:
> - Port necessary patches on the top of Joerg's new proposal.
>   https://lkml.org/lkml/2020/4/14/616
>   The per-group default domain proposed previously in this series
>   will be deprecated due to a race concern between domain switching
>   and device driver probing.
>
>v1->v2:
> - Rename the iommu ops callback to def_domain_type
>
>Lu Baolu (3):
>  iommu/vt-d: Allow 32bit devices to uses DMA domain
>  iommu/vt-d: Allow PCI sub-hierarchy to use DMA domain
>  iommu/vt-d: Apply per-device dma_ops
>
> drivers/iommu/intel-iommu.c | 396 +++---------------------------------
> 1 file changed, 26 insertions(+), 370 deletions(-)
>
>-- 
>2.17.1
>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
