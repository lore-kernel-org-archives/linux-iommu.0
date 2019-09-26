Return-Path: <SRS0=V6zV=XV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60C9C432C2
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 06:48:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 712FE222BE
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 06:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2Jq8rhk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712FE222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2DFC1B7D;
	Thu, 26 Sep 2019 06:48:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3FBD5941
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 06:48:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
	[205.139.110.120])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 99F058D
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 06:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1569480486;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=n6CUXrWr4mCPGYCq+cJLTlwJMgS1vQs/FCrBmY/MsK4=;
	b=h2Jq8rhk49WrD0cQYUJTxRYN+zitMEHTR/m8bXpCYRRLQr5GlixIdHqh8+QEXoX7PKET4J
	ABnPrr4NJJ4MLPpdlLEGudPOECckre6V9YhRAmfkDQQ5x9v+eiYA6uF96XpbzvGQclU1jG
	KyapgmXNqkMpLdR04nAPcPbaqlNohl8=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
	[209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
	us-mta-124-V67IaLQaPV-85I7sm3zzKQ-1; Thu, 26 Sep 2019 02:48:04 -0400
Received: by mail-io1-f72.google.com with SMTP id i2so2804917ioo.10
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 23:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=ZSm7lrM/XD7oxHr83AfSfhbwTzHXmHDlDYOIH9PCddk=;
	b=cxPy/wF7ZEUEnlGxyO0rkev9yQS+soAFGrXxw+yEN1r+94wz6dmw/N6CD7siyJL18Q
	g4k2KuTIZ6/WxlAd9dvHrO7hjoIkgRS/ecKCAlrM4v35meuCsz36qvTKhQBUpR4zWIZp
	UzEMuIOYdx6UERtpQSPA862xyfuuZS41KprfOXeIT+Vv2+Wmv+1OsIOrOwwlBu5WPqbu
	k1gw/PP1lolLRpgSrd0rmygPM9Vp6Jd0S7GNL0v0y89dciTMM6YbqQ99kt4LpDF2EODS
	AtgffLTVHr1Gowc9C20dDil/2bmsaZPtTkheDdJHp5bTqm0bMXlSOi0xsfgRVNBDjidv
	ZYjg==
X-Gm-Message-State: APjAAAVccq+gn1+Wua3DPUrWNkSQrERfGuhUdffAgATkkfuZZD+tGHCb
	sHxr8lmEtRMU2nkyVFVwOrVaCiwkos64tVRx1vhfUs3SBE+Mt8wE7C3XHUqTxm9fnLCyLl05D+j
	+XG2FS6jexqEQy/A5kvIg7YwnhQC+nQ==
X-Received: by 2002:a92:5e02:: with SMTP id s2mr947981ilb.144.1569480484364;
	Wed, 25 Sep 2019 23:48:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwJSRja6VCsS2ybSJHa0Z8SqncAf8TuDMbL2bTwto/aV25QFNo1lNdMDE8p05XJtTsG1lJVjw==
X-Received: by 2002:a92:5e02:: with SMTP id s2mr947971ilb.144.1569480484094;
	Wed, 25 Sep 2019 23:48:04 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
	by smtp.gmail.com with ESMTPSA id o66sm333473ili.45.2019.09.25.23.48.02
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 25 Sep 2019 23:48:03 -0700 (PDT)
Date: Wed, 25 Sep 2019 23:48:01 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 6/6] iommu/amd: Lock code paths traversing
	protection_domain->dev_list
Message-ID: <20190926064801.ipdx4g3f34h4heuz@cantor>
References: <20190925132300.3038-1-joro@8bytes.org>
	<20190925132300.3038-7-joro@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20190925132300.3038-7-joro@8bytes.org>
User-Agent: NeoMutt/20180716
X-MC-Unique: V67IaLQaPV-85I7sm3zzKQ-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Cc: Filippo Sironi <sironi@amazon.de>, iommu@lists.linux-foundation.org,
	jroedel@suse.de
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed Sep 25 19, Joerg Roedel wrote:
>From: Joerg Roedel <jroedel@suse.de>
>
>The traversing of this list requires protection_domain->lock to be taken
>to avoid nasty races with attach/detach code. Make sure the lock is held
>on all code-paths traversing this list.
>
>Reported-by: Filippo Sironi <sironi@amazon.de>
>Fixes: 92d420ec028d ("iommu/amd: Relax locking in dma_ops path")
>Signed-off-by: Joerg Roedel <jroedel@suse.de>
>---
> drivers/iommu/amd_iommu.c | 25 ++++++++++++++++++++++++-
> 1 file changed, 24 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>index bac4e20a5919..9c26976a0f99 100644
>--- a/drivers/iommu/amd_iommu.c
>+++ b/drivers/iommu/amd_iommu.c
>@@ -1334,8 +1334,12 @@ static void domain_flush_np_cache(struct protection_domain *domain,
> 		dma_addr_t iova, size_t size)
> {
> 	if (unlikely(amd_iommu_np_cache)) {
>+		unsigned long flags;
>+
>+		spin_lock_irqsave(&domain->lock, flags);
> 		domain_flush_pages(domain, iova, size);
> 		domain_flush_complete(domain);
>+		spin_unlock_irqrestore(&domain->lock, flags);
> 	}
> }
>
>@@ -1700,8 +1704,13 @@ static int iommu_map_page(struct protection_domain *dom,
> 	ret = 0;
>
> out:
>-	if (updated)
>+	if (updated) {
>+		unsigned long flags;
>+
>+		spin_lock_irqsave(&dom->lock, flags);
> 		update_domain(dom);
>+		spin_unlock_irqrestore(&dom->lock, flags);
>+	}
>
> 	/* Everything flushed out, free pages now */
> 	free_page_list(freelist);
>@@ -1857,8 +1866,12 @@ static void free_gcr3_table(struct protection_domain *domain)
>
> static void dma_ops_domain_flush_tlb(struct dma_ops_domain *dom)
> {
>+	unsigned long flags;
>+
>+	spin_lock_irqsave(&dom->domain.lock, flags);
> 	domain_flush_tlb(&dom->domain);
> 	domain_flush_complete(&dom->domain);
>+	spin_unlock_irqrestore(&dom->domain.lock, flags);
> }
>
> static void iova_domain_flush_tlb(struct iova_domain *iovad)
>@@ -2414,6 +2427,7 @@ static dma_addr_t __map_single(struct device *dev,
> {
> 	dma_addr_t offset = paddr & ~PAGE_MASK;
> 	dma_addr_t address, start, ret;
>+	unsigned long flags;
> 	unsigned int pages;
> 	int prot = 0;
> 	int i;
>@@ -2451,8 +2465,10 @@ static dma_addr_t __map_single(struct device *dev,
> 		iommu_unmap_page(&dma_dom->domain, start, PAGE_SIZE);
> 	}
>
>+	spin_lock_irqsave(&dma_dom->domain.lock, flags);
> 	domain_flush_tlb(&dma_dom->domain);
> 	domain_flush_complete(&dma_dom->domain);
>+	spin_unlock_irqrestore(&dma_dom->domain.lock, flags);
>
> 	dma_ops_free_iova(dma_dom, address, pages);
>
>@@ -2481,8 +2497,12 @@ static void __unmap_single(struct dma_ops_domain *dma_dom,
> 	}
>
> 	if (amd_iommu_unmap_flush) {
>+		unsigned long flags;
>+
>+		spin_lock_irqsave(&dma_dom->domain.lock, flags);
> 		domain_flush_tlb(&dma_dom->domain);
> 		domain_flush_complete(&dma_dom->domain);
>+		spin_unlock_irqrestore(&dma_dom->domain.lock, flags);
> 		dma_ops_free_iova(dma_dom, dma_addr, pages);
> 	} else {
> 		pages = __roundup_pow_of_two(pages);
>@@ -3246,9 +3266,12 @@ static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
> static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
> {
> 	struct protection_domain *dom = to_pdomain(domain);
>+	unsigned long flags;
>
>+	spin_lock_irqsave(&dom->lock, flags);
> 	domain_flush_tlb_pde(dom);
> 	domain_flush_complete(dom);
>+	spin_unlock_irqrestore(&dom->lock, flags);
> }
>
> static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
>-- 
>2.17.1
>
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
