Return-Path: <SRS0=GPDh=E7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF17C56201
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 20:27:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C37192075A
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 20:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZvjYhLBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37192075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0ECAA2E128;
	Wed, 25 Nov 2020 20:27:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KZGL4ED8h1U4; Wed, 25 Nov 2020 20:27:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 275872E127;
	Wed, 25 Nov 2020 20:27:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0889DC0891;
	Wed, 25 Nov 2020 20:27:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23006C0052
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 20:27:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 119CB87443
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 20:27:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0++2HN6bUXkj for <iommu@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 20:27:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7F10187429
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 20:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606336056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=4HJ2v8f9kS+7OevKdt8lnBxNs8lmIy/EbT4vGg0ZhGU=;
 b=ZvjYhLBe7ippnV+dQX0AJNnuS5N6QQK6AXLt8ifievYmCMCK890QzQJqX3ROPYoAJt1RVK
 eyNCZnxO/sPpQyFLv6GPnVIKvE12UfBE/2L54d76YssPkHMXefcaaHDtFYOWh6ricHPNMn
 d4jKQoE+1rVKwBLX6upkpwm8qf9NPKQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-g-tWqs9iPUSdjU8WDufFog-1; Wed, 25 Nov 2020 15:27:34 -0500
X-MC-Unique: g-tWqs9iPUSdjU8WDufFog-1
Received: by mail-qv1-f69.google.com with SMTP id t14so3229031qvc.13
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 12:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:user-agent:from:to:subject:date:message-id
 :mime-version;
 bh=4HJ2v8f9kS+7OevKdt8lnBxNs8lmIy/EbT4vGg0ZhGU=;
 b=LpH9jGQPc5wTS3FfAPW0TqgkOiVlzE0FGQOdOVZyulmMeu9NLDdpKRdQwFp09KIqHI
 phus+IKwhBoy1vcbddfcfckdHZIhJ94GA930RgZ6Blik2LlCL+VldT8YMxHoSeGjUztU
 AX8u1T+MjoZxgHQNWtSzuf0j8vRF44jLiqlRAc9BLmdXXL5wxm9TVlylxSfHnOdwDXNQ
 rtZDrzrT/rdQ4ppDify475TRWWxSOLTcRgaX25LWV1ohEannqQvoxkmEAJEYAyVodwFa
 mkw8drLvtthNKBtYf5wSIgGG7MqgeKi0k63RRkDT5D4Lg2dA2wQgJ3IDrf6V1+mQZ+iC
 YbQw==
X-Gm-Message-State: AOAM533tVd7++EFMag+EJIr53r+oAfPA1SGzcDptDDzslXavx9V1FQ8E
 JKFosxeqq9zwQ4tWcz2G9oFNQgp+DAKeakkN8JAquV5Yha86Nl1r9syNIvFsFcaF4eLtCJPCtTk
 xJT79QS5MYfqd9uFiVsGT17u4BtvQfQ==
X-Received: by 2002:ac8:4e84:: with SMTP id 4mr685411qtp.296.1606336053898;
 Wed, 25 Nov 2020 12:27:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWFbZOwl0Conrxed5+2lAywJNEc3k82+XLXf8ktBVme0EYoDWjdb8pXB2rkats9/OyDEivzQ==
X-Received: by 2002:ac8:4e84:: with SMTP id 4mr685378qtp.296.1606336053632;
 Wed, 25 Nov 2020 12:27:33 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
 by smtp.gmail.com with ESMTPSA id b64sm447921qkg.19.2020.11.25.12.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2020 12:27:32 -0800 (PST)
User-agent: mu4e 1.4.10; emacs 27.1
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 stable@kernel.vger.org
Subject: Question about domain_init (v5.3-v5.7)
Date: Wed, 25 Nov 2020 13:27:31 -0700
Message-ID: <87h7pd6v2k.fsf@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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


Is there a reason we check the requested guest address width against the
iommu's mgaw, instead of the agaw that we already know for the iommu?
I've run into a case with a new system where the mgaw reported is 57,
but if they set PAE to 46 instead of 52 in the bios, then sagaw reports
the highest supported agaw is 48 and the domain_init code fails here. In
other places like prepare_domain_attach_device, the dmar domain agaw
gets adjusted down to the iommu agaw. The agaw of the iommu gets
determined based off what is reported for sagaw. I'm wondering if it
can't instead do:

---
 drivers/iommu/intel-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6ca5c92ef2e5..a8e41ec36d9e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1862,8 +1862,8 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
 	domain_reserve_special_ranges(domain);

 	/* calculate AGAW */
-	if (guest_width > cap_mgaw(iommu->cap))
-	        guest_width = cap_mgaw(iommu->cap);
+	if (guest_width > agaw_to_width(iommu->agaw))
+	        guest_width = agaw_to_width(iommu->agaw);
 	domain->gaw = guest_width;
 	adjust_width = guestwidth_to_adjustwidth(guest_width);
 	agaw = width_to_agaw(adjust_width);
--
2.27.0


Thoughts? With the former code the ehci device for the ilo fails when
trying to get a private domain.

Thanks,
Jerry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
