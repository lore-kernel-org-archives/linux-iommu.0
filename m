Return-Path: <SRS0=jQQH=32=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06941C35247
	for <iommu@archiver.kernel.org>; Thu,  6 Feb 2020 23:17:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF042214AF
	for <iommu@archiver.kernel.org>; Thu,  6 Feb 2020 23:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRUB49WK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF042214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9233F2046C;
	Thu,  6 Feb 2020 23:17:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VMr72g9u+uDy; Thu,  6 Feb 2020 23:17:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A604B2040C;
	Thu,  6 Feb 2020 23:17:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88075C1D81;
	Thu,  6 Feb 2020 23:17:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13943C013E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 23:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EDF0C86B04
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 23:17:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3vvxqEQgMbs9 for <iommu@lists.linux-foundation.org>;
 Thu,  6 Feb 2020 23:17:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BEE9286AFE
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 23:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581031024;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=T752ko3Ei2efsaUGjzJICF753uWA5ZgrCxsts87GgVk=;
 b=fRUB49WKQ8RudZKvbc51f/GLOxkrMpaE1k9tZ7bUwKdBHWm/ZlxEnRqfTweAD8vm7zpBEj
 IiY8bhUWaanL3RkQ0jpOl1jQmCISkZbFpObOmxtc7Ui1zct+AIcrjnqgDAu6wScoow95qe
 06iBuk9POzp2WI6D1t5QMOE2rLdJAyg=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-tUAR_JnbPPeALerS326oGw-1; Thu, 06 Feb 2020 18:17:00 -0500
Received: by mail-yb1-f200.google.com with SMTP id o82so534367ybc.18
 for <iommu@lists.linux-foundation.org>; Thu, 06 Feb 2020 15:17:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to;
 bh=T752ko3Ei2efsaUGjzJICF753uWA5ZgrCxsts87GgVk=;
 b=oA00sd26zAtSZrQwGPsiFoJS6JQRsgKInYiOOK1TPMPKM76e6I2rO/YCcHsF2eKmBR
 Jb1UKhMKFgbN3QqS+HHbb2ZyvU9ECuGIQE6xNvm5Yq5AdFtDkY1mfwGfiejaDyEy9mpS
 kovoAFcqfFw5Fi6/i5F7/1/46FAcMftjItAOOmuNlyeiRySmqj3ptB9BrmO3o511KeU4
 pmGDRlO2xf4xsJeD9EQJfU31I3HHvR48CfvTCLknKf/PJxLk+U02PbJxJ8IWn5sULUH0
 dZeRRRze52uUJTKO4iw+Kh7V/gK2BONZV2DmAEiZvc5kH5OKP+0MSPqv9p24K4gEIfND
 KAXw==
X-Gm-Message-State: APjAAAVq6Hdc6lenZ7HxNAnI/a37W0jZIRSkdizhy2IbDppUzFxWJyxI
 t1qL4CBbrTdRAY4aguoOmXX2W/S/WWeGcWElfK3tEXqDO+2bwOI4yQ9x0JdDCZ7apK17UipXUFo
 Phnjzewd1hWGrxzaPhWydI65JwnAzjA==
X-Received: by 2002:a25:7797:: with SMTP id s145mr5253865ybc.416.1581031019897; 
 Thu, 06 Feb 2020 15:16:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxc9pPMhKOSmcBxFq9Db5b0rtlnQOkrLLKfeeUApZCVLtPWJEUgpADaiwbJl8Hi3Y5VsDgvbQ==
X-Received: by 2002:a25:7797:: with SMTP id s145mr5253850ybc.416.1581031019631; 
 Thu, 06 Feb 2020 15:16:59 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id y9sm409537ywc.19.2020.02.06.15.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 15:16:58 -0800 (PST)
Date: Thu, 6 Feb 2020 16:16:57 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux-foundation.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: Seeing some another issue with mixed domains in the same
 iommu_group
Message-ID: <20200206231657.aflur5zq2jvexrdn@cantor>
References: <20200206175432.4r5vaurm6codfa4a@cantor>
 <20200206184707.h3lfh2qaxaooe2vi@cantor>
 <20200206213643.b75uilwh3m76rprx@cantor>
MIME-Version: 1.0
In-Reply-To: <20200206213643.b75uilwh3m76rprx@cantor>
X-MC-Unique: tUAR_JnbPPeALerS326oGw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Thu Feb 06 20, Jerry Snitselaar wrote:
>
...
>The above cases seem to be avoided by:
>
>9235cb13d7d1 | 2020-01-24 | iommu/vt-d: Allow devices with RMRRs to use identity domain (Lu Baolu)
>
>which results in the watchdog device no longer taking a dma domain and switching the group default.
>
>
>Without that patch though when it gets into the iommu_need_mapping code for 0000:01:00.4 after
>the following:
>
>		dmar_remove_one_dev_info(dev);
>		ret = iommu_request_dma_domain_for_dev(dev);
>
>ret is 0 and dev->archdata.iommu is NULL. Even with 9235cb13d7d1 device_def_domain_type can return
>return dma, but I'm not sure how likely it is for there to be an iommu group like that again where
>the group default ends up dma, a device gets removed and added to the identity domain, and then
>ends up in that code in iommu_need_mapping.
>
>

Hi Baolu,

Would something along these lines makes sense?

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 9dc37672bf89..40cc8f5a3ebb 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3614,6 +3614,20 @@ static bool iommu_need_mapping(struct device *dev)
  			}
  			dmar_remove_one_dev_info(dev);
  			get_private_domain_for_dev(dev);
+		} else {
+			if (dev->archdata.iommu == NULL) {
+				struct iommu_domain *domain;
+				struct iommu_group *group;
+				struct dmar_domain *dmar_domain, *tmp;
+
+				group = iommu_group_get_for_dev(dev);
+				domain = iommu_group_default_domain(group);
+				dmar_domain = to_dmar_domain(domain);
+				tmp = set_domain_for_dev(dev, dmar_domain);
+			}
  		}
  
  		dev_info(dev, "32bit DMA uses non-identity mapping\n");
-- 

Obviously needs some checks added, but this was just an initial test I
was trying.

Regards,
Jerry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
