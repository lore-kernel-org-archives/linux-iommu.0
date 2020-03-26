Return-Path: <SRS0=Ybkk=5L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3C6C2D0E9
	for <iommu@archiver.kernel.org>; Thu, 26 Mar 2020 09:36:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 644F92076A
	for <iommu@archiver.kernel.org>; Thu, 26 Mar 2020 09:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hahwN8lB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644F92076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 44BF88714F;
	Thu, 26 Mar 2020 09:36:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KO7kgHbOlM9A; Thu, 26 Mar 2020 09:36:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A77048712A;
	Thu, 26 Mar 2020 09:36:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A16A7C0177;
	Thu, 26 Mar 2020 09:36:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6919C0177
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 09:36:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 96B0488406
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 09:36:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s8eSlUGnSkiy for <iommu@lists.linux-foundation.org>;
 Thu, 26 Mar 2020 09:36:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D0BBD88467
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 09:36:49 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id s1so6854895wrv.5
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 02:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j471hzdxUAR7EU6PCnbMP3ieYDtBrBQiNzMOXYZJCHM=;
 b=hahwN8lBsOe0HldVvgYxNZyiM1sk0fbN+/opi0glHvk6UhNTj5xexzfNSZ9UquiFmp
 tJjeLxv+EoCg4ngONz4sSLRGDe+iDylpaGh/MTs/RHbZL/qCMKaGgng0SngG4iFUVh1v
 Vgp0EZzrmWFRsqzkqa26TTJWLh3J437xnpEqywG+wOB/VZ/2wbB9jLkpXkZiZSqeIovk
 JPols3O1PmTGpp5cdN1DN+TMeBaYv/XMbADdCjvVkky70crkSa5UF/NCT//Q5dwuLYXA
 r3eVVPbwVAr1AtInHCdqxnbGHcgSmx6G0G5ucTLtbskDa/gmZ1nyGYtfX9HhbGtFBnU/
 dhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j471hzdxUAR7EU6PCnbMP3ieYDtBrBQiNzMOXYZJCHM=;
 b=El+kgu7nbi0oBLEA5T2gyrnXwpX8J/455uI9zEqeTz08ZWDZARKxdnSUxbywtHzpui
 79sR4l8g11OYhjw+ze4kvgkbXFNe1aKjok8AphpAhbSjVnhtZK4Ye2ezsanGdwwWLF62
 RyXyFwKdgFNy9Gh7TJDTT2a+pw9Y3P2TC/aUdfmTza9TRPs+Z/jpAfdWttJMQGA06ZKy
 Cztd8NGWwI0vc20i8BwtpwORDDKxJ3qZauVjkVI+u/ZMnMCRaeKkrgSYlZ350uy6lfKH
 mducYGj06D+MLSS0qe5cpEKV09GtzQVxiSEgP9K0kfp6iUHXQr+h2VrNE+YntgL9MADH
 I6cg==
X-Gm-Message-State: ANhLgQ0qx8+a9kJpT5jRDnUn3f62shWAjvVi+JVSiYNcr4b3g6TK6syu
 bKcSSOlJkaypB4dd/Cm//LOyRYNRkUGHUg==
X-Google-Smtp-Source: ADFU+vsM5lxFML11UASi2+uT04jXEQnY07dpdp4rWBE43fHIdyDlKVDxcTsYUYPllzibVzqM6L348A==
X-Received: by 2002:adf:f401:: with SMTP id g1mr1783646wro.140.1585215407914; 
 Thu, 26 Mar 2020 02:36:47 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u8sm2670165wrn.69.2020.03.26.02.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 02:36:47 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 2/3] iommu/virtio: Fix freeing of incomplete domains
Date: Thu, 26 Mar 2020 10:35:57 +0100
Message-Id: <20200326093558.2641019-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326093558.2641019-1-jean-philippe@linaro.org>
References: <20200326093558.2641019-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, bbhushan2@marvell.com,
 jasowang@redhat.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Calling viommu_domain_free() on a domain that hasn't been finalised (not
attached to any device, for example) can currently cause an Oops,
because we attempt to call ida_free() on ID 0, which may either be
unallocated or used by another domain.

Only initialise the vdomain->viommu pointer, which denotes a finalised
domain, at the end of a successful viommu_domain_finalise().

Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
Reported-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index cce329d71fba..5eed75cd121f 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -613,18 +613,20 @@ static int viommu_domain_finalise(struct viommu_dev *viommu,
 	int ret;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
-	vdomain->viommu		= viommu;
-	vdomain->map_flags	= viommu->map_flags;
+	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
+			      viommu->last_domain, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	vdomain->id		= (unsigned int)ret;
 
 	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
 	domain->geometry	= viommu->geometry;
 
-	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
-			      viommu->last_domain, GFP_KERNEL);
-	if (ret >= 0)
-		vdomain->id = (unsigned int)ret;
+	vdomain->map_flags	= viommu->map_flags;
+	vdomain->viommu		= viommu;
 
-	return ret > 0 ? 0 : ret;
+	return 0;
 }
 
 static void viommu_domain_free(struct iommu_domain *domain)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
