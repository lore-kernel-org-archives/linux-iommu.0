Return-Path: <SRS0=Hf/t=64=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5734BC433E0
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 19:03:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C442065F
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 19:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYimicxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C442065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 787A220468;
	Thu, 14 May 2020 19:03:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rbBLUcBz92LU; Thu, 14 May 2020 19:03:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BF02A20457;
	Thu, 14 May 2020 19:03:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB4B2C0863;
	Thu, 14 May 2020 19:03:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 284FAC016F
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 19:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 10789882D8
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 19:03:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PuRp8XMocpBL for <iommu@lists.linux-foundation.org>;
 Thu, 14 May 2020 19:03:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 36E098829A
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 19:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589482983;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=2eOJy4laohP6xg+8A1hLlhQR4abouEEHiBpBsBK1Fng=;
 b=RYimicxNj4mX5aXn35wnD/QUiDUZ9mvfU6FpFpOhaTf+dsd/bqOPFdsQfRHMDyxZXRvT11
 F6QRZe7tGK1YS0YSEMnolLsc5MO6saW2kqkNzQw4AFC7td0eZv+6rDlZMWgu8rAsxYu3fz
 QK5kJySnkQRsPBTI70YfFNqgkItrHbA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-ekf82a8VNKGaTWKJQZAOkQ-1; Thu, 14 May 2020 15:02:55 -0400
X-MC-Unique: ekf82a8VNKGaTWKJQZAOkQ-1
Received: by mail-qt1-f199.google.com with SMTP id s65so4619235qtd.21
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 12:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=2eOJy4laohP6xg+8A1hLlhQR4abouEEHiBpBsBK1Fng=;
 b=E3eJgSrKYJPi5+5nD5iW6I2fuxQXpXNuKPtzTn6gNZNr5srpEwHFWTKPxmVlliXyr0
 yk6jdJ3JBHdoYfVWZSSTD/ZR/27Ef3xiSJM6tKWhjpjJSI1X0qojnpMzqTo5TqJsrr0n
 UODhc52dW2i6StPCI0OHOun+ggcIgUdd4xAivj4gbpvWoo3P971sa+UsbyMhe5iuvZ/a
 4rIMShNbcLVxwe6rhm0YBDuwpWZaA9z5blT1O5JsApkzhf0rahW3fCpyINSn9/lG+Qdg
 g0eJGzdJ+btZj107CNGfYcfL+zDeKC0M1Vbu1AXmhuMgo5sHexmJX6dJSyiA9FVOCJBx
 jvFw==
X-Gm-Message-State: AOAM533p6fK0Z38nUP5lV0/3TKKa4TjG8x64jTLNQq04R46ZuyOYS0At
 mt5a1nA7EC08vxiWlEELkiUtbs1WYVy1BDqmnpO9uOqqXsJBQvJYtgGe52InVDV6qV96TGuiWbe
 +WJI5lR6kbf+PINnLSxgRb57wT3NQzA==
X-Received: by 2002:ac8:1b58:: with SMTP id p24mr6333927qtk.29.1589482974703; 
 Thu, 14 May 2020 12:02:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqPwbX6QW79CMjPsIoDBx8Qxq0c+7FfBXcMz8FzBF9t3LMhNJFhfsG5B/dObcvNwywLNEMVQ==
X-Received: by 2002:ac8:1b58:: with SMTP id p24mr6333894qtk.29.1589482974377; 
 Thu, 14 May 2020 12:02:54 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id z60sm3267882qtc.30.2020.05.14.12.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 12:02:53 -0700 (PDT)
Date: Thu, 14 May 2020 12:02:52 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: amd kdump failure with iommu=nopt
Message-ID: <20200514190252.ykwdpu7qwzsxjvlp@cantor>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Tom Murphy <murphyt7@tcd.ie>
References: <20200514031838.2oklmyrc3n5it2ox@cantor>
 <20200514153623.GM18353@8bytes.org>
 <20200514154020.GN18353@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200514154020.GN18353@8bytes.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

On Thu May 14 20, Joerg Roedel wrote:
>On Thu, May 14, 2020 at 05:36:23PM +0200, Joerg Roedel wrote:
>> This commit also removes the deferred attach of the device to its new
>> domain. Does the attached diff fix the problem for you?
>> +static int __iommu_attach_device_no_defer(struct iommu_domain *domain,
>> +					  struct device *dev)
>> +{
>>  	if (unlikely(domain->ops->attach_dev == NULL))
>>  		return -ENODEV;
>>
>>  	ret = domain->ops->attach_dev(domain, dev);
>>  	if (!ret)
>>  		trace_attach_device_to_domain(dev);
>> +
>>  	return ret;
>>  }
>
>Sorry, this didn't compile, here is an updated version that actually
>compiles:
>
>
>diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>index 4050569188be..f54ebb964271 100644
>--- a/drivers/iommu/iommu.c
>+++ b/drivers/iommu/iommu.c
>@@ -1889,13 +1889,19 @@ void iommu_domain_free(struct iommu_domain *domain)
> }
> EXPORT_SYMBOL_GPL(iommu_domain_free);
>
>-static int __iommu_attach_device(struct iommu_domain *domain,
>-				 struct device *dev)
>+static bool __iommu_is_attach_deferred(struct iommu_domain *domain,
>+				       struct device *dev)
>+{
>+	if (!domain->ops->is_attach_deferred)
>+		return false;
>+
>+	return domain->ops->is_attach_deferred(domain, dev);
>+}
>+
>+static int __iommu_attach_device_no_defer(struct iommu_domain *domain,
>+					  struct device *dev)
> {
> 	int ret;
>-	if ((domain->ops->is_attach_deferred != NULL) &&
>-	    domain->ops->is_attach_deferred(domain, dev))
>-		return 0;
>
> 	if (unlikely(domain->ops->attach_dev == NULL))
> 		return -ENODEV;
>@@ -1903,9 +1909,19 @@ static int __iommu_attach_device(struct iommu_domain *domain,
> 	ret = domain->ops->attach_dev(domain, dev);
> 	if (!ret)
> 		trace_attach_device_to_domain(dev);
>+
> 	return ret;
> }
>
>+static int __iommu_attach_device(struct iommu_domain *domain,
>+				 struct device *dev)
>+{
>+	if (__iommu_is_attach_deferred(domain, dev))
>+		return 0;
>+
>+	return __iommu_attach_device_no_defer(domain, dev);
>+}
>+
> int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
> {
> 	struct iommu_group *group;
>@@ -2023,7 +2039,12 @@ EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev);
>  */
> struct iommu_domain *iommu_get_dma_domain(struct device *dev)
> {
>-	return dev->iommu_group->default_domain;
>+	struct iommu_domain *domain = dev->iommu_group->default_domain;
>+
>+	if (__iommu_is_attach_deferred(domain, dev))
>+		__iommu_attach_device_no_defer(domain, dev);
>+
>+	return domain;
> }
>
> /*
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu
>

Yes, that works.

Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
