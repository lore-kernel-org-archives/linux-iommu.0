Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B6AC34026
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 15:45:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 772522176D
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 15:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dT/gXBRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772522176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3B00F20387;
	Tue, 18 Feb 2020 15:45:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nhv-uy5jAYao; Tue, 18 Feb 2020 15:45:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 80BCE1FF11;
	Tue, 18 Feb 2020 15:45:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68678C08A0;
	Tue, 18 Feb 2020 15:45:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87FBBC013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 15:45:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 76ABB858F5
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 15:45:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BOLYDQEzJ1OT for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 15:45:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1E86085450
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 15:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582040754;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type; bh=KTSW1OZwPiPdJwMYOvwCwRE1eJ3tjAnM8w4W+E+rh6w=;
 b=dT/gXBRcxfPRpqnTcbwfNKo2axJ+kGLC+WSejjxScXsOpuJKCDwBiD6ldalj3ON7M6X3/8
 5CtyhpU3JnaoXwGRgYOTTVfQP1rr0e6fb8WUHJbM+2f/JAx6o3brl0Qqy8S37hxPcBcpUK
 qYbLWwftcN3OpFSlBqGAvLvVQcKLVyU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-qXnhJdjnOJ-RsHn4eb0nPQ-1; Tue, 18 Feb 2020 10:45:52 -0500
Received: by mail-qt1-f197.google.com with SMTP id k27so13325829qtu.12
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 07:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:reply-to
 :mime-version:content-disposition;
 bh=KTSW1OZwPiPdJwMYOvwCwRE1eJ3tjAnM8w4W+E+rh6w=;
 b=KS6q4VY37DGrKNtYyp2olyWBCtJnO2arRy0ZQM+IgKJpqTHbJZ34lZO9wC4bAj6uXP
 mAiAbEVvsde877Ax55lDXG8otarGtyP+iXVjOx1flLeAqsiC1HJNUJnnAwusSTJ9dP5B
 sMI4RjQT2qeFuB5Bgl3ZbeYrhTL02fsBI8NwZBe+s3s/vjZUZAxDY7OSwT+AiGmNf4wp
 JTKlsPATxk8toSrC8gU1+e5RProSeVP8R5ukxqOiqiALvxIDiyB6QPUmr0yyJ9KF0rx1
 4x8fGZavNb6QU4dG2lonxqSaDjRjzdHAml+W6lhPq5Nf76EMMxkP86gigLshhqxFYXm1
 mPRQ==
X-Gm-Message-State: APjAAAX2W1ShVQ2mAnr0VQuugZEQvbmqJ+56BVLkym6S03Jnd+orxdC0
 pKfL7NMowvtQl6vceJ5bhjiOxx9XZHZoZTpn93mqtYiA1HYCus+o/lQtIL9HOEnG1rP6Z0fOqcP
 QOgh7P2E/kETbORqoSwDQmGMXp4Dl+w==
X-Received: by 2002:a05:620a:12c8:: with SMTP id
 e8mr18803846qkl.380.1582040752113; 
 Tue, 18 Feb 2020 07:45:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqw8wl+ddWZDDh083Yy64zDV3e2XvgwSI2I1DHZrSjz4qXqjvaV+BlhIYWdcM+ZsKcWUd9qQig==
X-Received: by 2002:a05:620a:12c8:: with SMTP id
 e8mr18803818qkl.380.1582040751772; 
 Tue, 18 Feb 2020 07:45:51 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id n7sm2024185qkk.41.2020.02.18.07.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 07:45:51 -0800 (PST)
Date: Tue, 18 Feb 2020 08:45:49 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
Subject: dmar fault right around domain switch in iommu_need_mapping
Message-ID: <20200218154549.rcav24rkm7rc4hvp@cantor>
MIME-Version: 1.0
X-MC-Unique: qXnhJdjnOJ-RsHn4eb0nPQ-1
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

Hi Joerg and Baolu,

I'm chasing down one last issue. I'm waiting to hear back from them
testing with Joerg's patchset, but I'm guessing this will still pop
up. It looks like right around when the domain switch occurs in
iommu_need_mapping there are some dmar faults (below is from 5.6-rc1
plus earlier fix attempt that moved deferred attach to beginning of
iommu_need_mapping):

[   12.546920] DMAR: DRHD: handling fault status reg 2
[   12.546923] DMAR: [DMA Read] Request device [02:00.0] PASID ffffffff fault addr 791dd000 [fault reason 02] Present bit in context entry is clear
[   12.635193] hpsa 0000:02:00.0: Using iommu dma mapping
[   12.776712] hpsa 0000:02:00.0: DMAR: 32bit DMA uses non-identity mapping

[   14.091219] DMAR: [DMA Read] Request device [07:00.0] PASID ffffffff fault addr 791dd000 [fault reason 02] Present bit in context entry is clear
[   14.180842] DMAR: DRHD: handling fault status reg 202
[   14.180845] DMAR: [DMA Read] Request device [07:00.0] PASID ffffffff fault addr 791dd000 [fault reason 02] Present bit in context entry is clear
[   14.268756] DMAR: DRHD: handling fault status reg 302
[   15.542551] hpsa 0000:07:00.0: Using iommu dma mapping
[   15.567256] hpsa 0000:07:00.0: DMAR: 32bit DMA uses non-identity mapping


It seems to only happen right then, and then things are fine. Happens
during both regular and kdump boot.  With the kdump boot the faults
are from the hpilo in the logs I'm looking at, so it doesn't seem to
be tied to a device, or certain rmrr. The faulting address always
seems to be the base address of the rmrr.  The dmar tables look sane.

Regards,
Jerry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
