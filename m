Return-Path: <SRS0=eHMU=2G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DB3C2D0C3
	for <iommu@archiver.kernel.org>; Mon, 16 Dec 2019 20:58:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7814A21835
	for <iommu@archiver.kernel.org>; Mon, 16 Dec 2019 20:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRzD+akh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7814A21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3A3B6877C9;
	Mon, 16 Dec 2019 20:58:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g6o-Il81CULQ; Mon, 16 Dec 2019 20:58:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7AA4D86F87;
	Mon, 16 Dec 2019 20:58:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EC42C18DD;
	Mon, 16 Dec 2019 20:58:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51CB6C077D
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 20:58:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3F1B422643
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 20:58:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vQJ8RPyCuBfE for <iommu@lists.linux-foundation.org>;
 Mon, 16 Dec 2019 20:58:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 59C7E221D9
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 20:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576529881;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type; bh=grtorLDue+Atr16b7VawQ97nR0ZCI76hZCAvkSUnQVk=;
 b=aRzD+akhwMoXBIhwmiflfTFy1zRViyJ5clw9J56Z3MBIosKKxIVbJongXWZbcHhtSXQHr1
 uvXauE15hgttu7ghJJ9TT3yRQmnO2EUH2tSWvTcn9JsVtGkBfOM4IogKEG1Mi8xeL3Tysw
 fMNaS+Mc6U2Bz7HVNtd4461NsWysWvQ=
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-RaTg4-WtPgCZkIeRmSzgog-1; Mon, 16 Dec 2019 15:58:00 -0500
X-MC-Unique: RaTg4-WtPgCZkIeRmSzgog-1
Received: by mail-yw1-f70.google.com with SMTP id c68so6473884ywa.2
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 12:58:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:reply-to
 :mail-followup-to:mime-version:content-disposition;
 bh=grtorLDue+Atr16b7VawQ97nR0ZCI76hZCAvkSUnQVk=;
 b=LCFcB8wc1ATbYVGm2nueT3GmpYWNuWLrwY0cQ0bPo148aFEjCab/RbvraaIjf4zjrf
 wRDddLHexdjkIJRbncqenNaPQqKZV2Fwk/RoAlfqtWNraf8lsL6Pkvud1sO1gsqEO1rb
 MRqyjawb88SSrzum1+zzR+MGbPBiiJP0Xxt/jgDWKcQ37xCjr4DHNOHPrlP2Q0mG8sNu
 cjRmi4oWGBnFINTDuv0wGn1dr6a/9Ov+pIiBmxXKSq9+nlKFai470jn5Fng9BuVUWv3e
 WQJ+v20nW1c9qWjoMN9kreBsfRz/3JEjBaoxy59DhCMY/WcMP4eq1QoJvMcAvCYclaKO
 lY0Q==
X-Gm-Message-State: APjAAAU9TJXbWzMXEWuFrh/7IHsB6OX/EQ4TXnbFdMxP0o/ALoIp8yku
 NkvP48U7PrMlkoL4TQ+/tgpvq6+CkEBZ8eSJ4CBw0bnO0e82ib8sxjEiibgczfV97e+Oqa8Og/2
 j4JkdyVJKFKbsH7Pzm7F26X2t9FsQPg==
X-Received: by 2002:a0d:cb53:: with SMTP id n80mr13704398ywd.405.1576529880009; 
 Mon, 16 Dec 2019 12:58:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqx+OKdhPZQjA6xun6338qOULi2wP5YUfJvWUvCQuUfX5vn1GAiZni7I+dtFM/7KCqX1whgSqg==
X-Received: by 2002:a0d:cb53:: with SMTP id n80mr13704382ywd.405.1576529879712; 
 Mon, 16 Dec 2019 12:57:59 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id s68sm2425938ywg.69.2019.12.16.12.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 12:57:59 -0800 (PST)
Date: Mon, 16 Dec 2019 13:57:57 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux-foundation.org, Lu Baolu <baolu.lu@linux.intel.com>,
 linux-kernel@vger.kernel.org
Subject: panic in dmar_remove_one_dev_info
Message-ID: <20191216205757.x4hewnduopbo4mpv@cantor>
Mail-Followup-To: iommu@lists.linux-foundation.org,
 Lu Baolu <baolu.lu@linux.intel.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
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

HP is seeing a panic on gen9 dl360 and dl560 while testing these other
changes we've been eorking on. I just took an initial look, but have
to run to a dentist appointment so couldn't dig too deep. It looks
like the device sets dev->archdata.iommu to DEFER_DEVICE_DOMAIN_INFO
in intel_iommu_add_device, and then it needs a private domain so
dmar_remove_one_dev_info gets called. That code path ends up trying to
use DEFER_DEVICE_DOMAIN_INFO as a pointer.  I don't need if there just
needs to be a check in there to bail out if it sees
DEFER_DEVICE_DOMAIN_INFO, or if something more is needed. I'll look
at it some more when I get back home.

Regards,
Jerry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
