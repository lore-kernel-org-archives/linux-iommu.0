Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370EEC433E0
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 07:10:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3AB02070A
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 07:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNjmuoW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3AB02070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BC42688058;
	Tue, 19 May 2020 07:10:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pgvh3uawit0X; Tue, 19 May 2020 07:10:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3EBE88803E;
	Tue, 19 May 2020 07:10:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 380D7C0881;
	Tue, 19 May 2020 07:10:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 084F4C0176
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 07:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EAB498803E
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 07:10:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PZcngVc-69n1 for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 07:10:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B0A6588058
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 07:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589872201;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=X/KmdOdFxUdbyg6uVeDwn3rmdrmoPPzdKKlBwCaZDW8=;
 b=WNjmuoW/PIJ1hRvYgLOlGXSIEnUUHJPCFf16hhkOQmcoCtimpUZrNHmQtFV1FfDcG/5cSY
 E3aF7mENkE5nfsXds8KKUucHy8YYJKdqpCv2LeO/Z1iCocOK9keiRklxgZoaLIrzgyF/0R
 6bDzH21+jKCEEGTnwLDLPo0Zv3qRHCU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-GExg93yrNOmYuqFNW9djDQ-1; Tue, 19 May 2020 03:09:57 -0400
X-MC-Unique: GExg93yrNOmYuqFNW9djDQ-1
Received: by mail-qt1-f199.google.com with SMTP id c8so8270786qtk.13
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 00:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=X/KmdOdFxUdbyg6uVeDwn3rmdrmoPPzdKKlBwCaZDW8=;
 b=fL+I5K0wt86evPXr6MGP+qrXlV/l0Xi9gZjt6wieLhXdvLbPmMSiFxCXgQy3D19uFr
 C/ceRUu9zrqq2GlYxw0Bi9ztC3YE0sHGZSkR9IOil1tljmF8tYeHBUA62tcFV7N3amFM
 Dhu/BQqfiQWU78ckL/Wp2FIEqOd1HVNobJpd13YYz+DkzjkYQEvzQLVPtBrl64GbwqSS
 QNBCCYT7FAznuwdzPA58QxsyIIbiqG3B1ouETkNw1epijZjcHl2H0zcU6nOaeQnSmany
 UeMRSvEw7I1iuG54iV5pxYbBqTjiDcEBz+EV81b38PGC8FM8V/PVPjcu35NTzxMfGCe+
 bK7Q==
X-Gm-Message-State: AOAM533QZHFMHze+gtiUhNI+m4cI49H4I5LvV+Hl/o0SJHgeV7ZAcVc4
 Mf9iq+u5qKoyBC+4CEBfJstnz7/EndCjXjc5Xx80EqetERZWlj/ZB3mK2QZeaIGtQcgz9oXpa1y
 OD/I0nRnueL1xny8/Cb/h/dZDHWdhbA==
X-Received: by 2002:ac8:1416:: with SMTP id k22mr20425543qtj.205.1589872196663; 
 Tue, 19 May 2020 00:09:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0YMv2+wLa6G/v8B+VuLF5wHB7dK7W95KBy80WPMbmb/VrIkRFFWmt1lxr/8MBtjeVz988yg==
X-Received: by 2002:ac8:1416:: with SMTP id k22mr20425523qtj.205.1589872196359; 
 Tue, 19 May 2020 00:09:56 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id t88sm11138889qtd.5.2020.05.19.00.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 00:09:55 -0700 (PDT)
Date: Tue, 19 May 2020 00:09:53 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu: Implement deferred domain attachment
Message-ID: <20200519070953.dj46pvdqvqdglr4p@cantor>
Mail-Followup-To: Joerg Roedel <jroedel@suse.de>,
 Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Tom Murphy <murphyt7@tcd.ie>
References: <20200515094519.20338-1-joro@8bytes.org>
 <d4e1cd9e-fc83-d41a-49c0-8f14f44b2701@arm.com>
 <20200515161400.GZ18353@8bytes.org>
 <e7bdcbf1-a713-618d-3e02-037f509a17e9@arm.com>
 <20200515182600.GJ8135@suse.de>
 <f5c6ec5b-06c6-42e6-b74d-71cf29b44b8d@arm.com>
 <20200518132656.GL8135@suse.de>
MIME-Version: 1.0
In-Reply-To: <20200518132656.GL8135@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>
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

On Mon May 18 20, Joerg Roedel wrote:
>On Fri, May 15, 2020 at 08:23:13PM +0100, Robin Murphy wrote:
>> But that's not what this is; this is (supposed to be) the exact same "don't
>> actually perform the attach yet" logic as before, just restricting it to
>> default domains in the one place that it actually needs to be, so as not to
>> fundamentally bugger up iommu_attach_device() in a way that prevents it from
>> working as expected at the correct point later.
>
>You are right, that is better. I tested it and it seems to work. Updated
>diff attached, with a minor cleanup included. Mind sending it as a
>proper patch I can send upstream?
>
>Thanks,
>
>	Joerg
>
>diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>index 7b375421afba..a9d02bc3ab5b 100644
>--- a/drivers/iommu/iommu.c
>+++ b/drivers/iommu/iommu.c
>@@ -693,6 +693,15 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
> 	return ret;
> }
>
>+static bool iommu_is_attach_deferred(struct iommu_domain *domain,
>+				     struct device *dev)
>+{
>+	if (domain->ops->is_attach_deferred)
>+		return domain->ops->is_attach_deferred(domain, dev);
>+
>+	return false;
>+}
>+
> /**
>  * iommu_group_add_device - add a device to an iommu group
>  * @group: the group into which to add the device (reference should be held)
>@@ -705,6 +714,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
> {
> 	int ret, i = 0;
> 	struct group_device *device;
>+	struct iommu_domain *domain;
>
> 	device = kzalloc(sizeof(*device), GFP_KERNEL);
> 	if (!device)
>@@ -747,7 +757,8 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
>
> 	mutex_lock(&group->mutex);
> 	list_add_tail(&device->list, &group->devices);
>-	if (group->domain)
>+	domain = group->domain;
>+	if (domain  && !iommu_is_attach_deferred(domain, dev))
> 		ret = __iommu_attach_device(group->domain, dev);
> 	mutex_unlock(&group->mutex);
> 	if (ret)
>@@ -1653,9 +1664,6 @@ static int __iommu_attach_device(struct iommu_domain *domain,
> 				 struct device *dev)
> {
> 	int ret;
>-	if ((domain->ops->is_attach_deferred != NULL) &&
>-	    domain->ops->is_attach_deferred(domain, dev))
>-		return 0;
>
> 	if (unlikely(domain->ops->attach_dev == NULL))
> 		return -ENODEV;
>@@ -1727,8 +1735,7 @@ EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
> static void __iommu_detach_device(struct iommu_domain *domain,
> 				  struct device *dev)
> {
>-	if ((domain->ops->is_attach_deferred != NULL) &&
>-	    domain->ops->is_attach_deferred(domain, dev))
>+	if (iommu_is_attach_deferred(domain, dev))
> 		return;
>
> 	if (unlikely(domain->ops->detach_dev == NULL))
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu
>

This worked for me as well.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
