Return-Path: <SRS0=A6MP=2O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABF3C2D0C3
	for <iommu@archiver.kernel.org>; Tue, 24 Dec 2019 19:09:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78FAA206D3
	for <iommu@archiver.kernel.org>; Tue, 24 Dec 2019 19:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fozZi9x1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FAA206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2BE4A203E1;
	Tue, 24 Dec 2019 19:09:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ENjI1oSaZARx; Tue, 24 Dec 2019 19:09:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7314220015;
	Tue, 24 Dec 2019 19:09:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59D00C18DD;
	Tue, 24 Dec 2019 19:09:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8784C0881
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 19:09:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A176386CDC
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 19:09:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i+-supUQ+7Gh for <iommu@lists.linux-foundation.org>;
 Tue, 24 Dec 2019 19:09:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D7B8886CD7
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 19:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577214542;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=sN9oy8InhvYTWTcIBE/ApxS/MBEGLGguoOVJTgKsavo=;
 b=fozZi9x1Ple9UyanOnGziPsYTV58zSsoSg2xtnY/xRVN4TOBQxryTPNj+1ap9xZitKbCfF
 fkxfUtQSz2T8CfOb4wUwKKyi0FhVlc1g9LwhvR8B5vC9+0GKkUiZ1X3Rq8AVvgdwIeQ5P5
 Q6D7EsxSmwMHszKJyZwBFthhrymgqT0=
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-G3i7YeiQOMuTC38ca6JmTA-1; Tue, 24 Dec 2019 14:09:00 -0500
Received: by mail-yw1-f69.google.com with SMTP id q130so15929268ywh.11
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 11:09:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=sN9oy8InhvYTWTcIBE/ApxS/MBEGLGguoOVJTgKsavo=;
 b=KtmCmK2lvCWe4CfrBPN8IxvXUNcnKKec7B+Ng0Gpf63oKXE2JjDcmlCTYV+3+m4sSY
 OVPcwZIgqhp8yod3/BmdXg26UIGwRNPxW6GV7a1xzzMaOtMsP14zuQIX5Ixua3jr7iYV
 sHJ7YzOlxUkwUdqewQy2s+RCSduVCNHBn0PvEOVS+WY0SdxWCWKVU6JuaRsq4pPgns8g
 KeSo/eQ7ge9CnBo9t/gzgxc0Kksf+vWcg2VzR8cWnBr1+Rl1vn0K6tfrcbq1GH0j1Hv8
 RYCG0N0sgKXgWCeg7TP6kItOyGhhApM9WfQiaui8OIUeZCqo7XLozfgNp4tF6K758Dp8
 BpTw==
X-Gm-Message-State: APjAAAWIdoaNOjUzaktQkY3aibLuLf2ZpdA2FE0OVBw7qsZ7hroZOGIJ
 4J4A2ldFB97UJu/2LcQNImmnjmuiBnHh7ojr0mllF/F/txbYUowX6ZXw3g/70HsGsKbKzusf7Am
 50HcypLphdA6eaSUaX128/izDpxRpTg==
X-Received: by 2002:a25:68d2:: with SMTP id
 d201mr27072872ybc.177.1577214540288; 
 Tue, 24 Dec 2019 11:09:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqz0S3EZ46tOP4qqPj6eQg1Mo8wV9UwKPT4m38jrGBN38s6oteTQkqrcrF05/SG735A3VfXw9w==
X-Received: by 2002:a25:68d2:: with SMTP id
 d201mr27072853ybc.177.1577214540042; 
 Tue, 24 Dec 2019 11:09:00 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id e131sm9679917ywb.81.2019.12.24.11.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2019 11:08:59 -0800 (PST)
Date: Tue, 24 Dec 2019 12:08:57 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Add a quirk flag for scope mismatched
 devices
Message-ID: <20191224190857.kb32qjogzumoh4xv@cantor>
Mail-Followup-To: Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>,
 Roland Dreier <roland@purestorage.com>, Jim Yan <jimyan@baidu.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20191224062240.4796-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191224062240.4796-1-baolu.lu@linux.intel.com>
X-MC-Unique: G3i7YeiQOMuTC38ca6JmTA-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Cc: Roland Dreier <roland@purestorage.com>, Jim Yan <jimyan@baidu.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On Tue Dec 24 19, Lu Baolu wrote:
>We expect devices with endpoint scope to have normal PCI headers,
>and devices with bridge scope to have bridge PCI headers.  However
>Some PCI devices may be listed in the DMAR table with bridge scope,
>even though they have a normal PCI header. Add a quirk flag for
>those special devices.
>
>Cc: Roland Dreier <roland@purestorage.com>
>Cc: Jim Yan <jimyan@baidu.com>
>Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
