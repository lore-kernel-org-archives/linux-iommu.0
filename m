Return-Path: <SRS0=eP4Y=2X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D334EC2D0DE
	for <iommu@archiver.kernel.org>; Thu,  2 Jan 2020 02:25:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9320F20866
	for <iommu@archiver.kernel.org>; Thu,  2 Jan 2020 02:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EDL5C+xk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9320F20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2E58084F35;
	Thu,  2 Jan 2020 02:25:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UcM346lAPcj2; Thu,  2 Jan 2020 02:25:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DFF3E847AC;
	Thu,  2 Jan 2020 02:25:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA9A9C18DC;
	Thu,  2 Jan 2020 02:25:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F43AC077D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 02:25:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1401487447
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 02:25:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i24Nm3Lav-7q for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jan 2020 02:25:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7BC30873BC
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 02:25:33 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id r19so39370576ljg.3
 for <iommu@lists.linux-foundation.org>; Wed, 01 Jan 2020 18:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7qXKgxWJTDDZhWbPniSjnyCGcoo+refp8o/oKspx+yI=;
 b=EDL5C+xkmCwGNBNpL+y3XQzQ9ySiVJRYn9BUr1aaC6wt8hvbgc2h0XLY0rYXtXkdWz
 hjSuGxszQ2iz2OOemtOg39CnPIXJtCXz+VH4i0B+YmRv2mFpcn+HuCs7vuJs7UoovO/r
 mUlCUbiR5CXYdnBI1NQjayLHvUchZaPMfkCSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7qXKgxWJTDDZhWbPniSjnyCGcoo+refp8o/oKspx+yI=;
 b=ITEa/IwombVz2jQ7XDxrQk3jV+Bw5o5pJTurx5qdp9c4YzgnXKJjsRbkf2zwhG+4K8
 c318ccXX6Ld30dN7i4ZqcJ822OV62PW76FZ2YsW/VCXuvuh754Gp4KomtOdUcfAqef6/
 t8Ywklt63Xx1AJR96yDYsOPgUTEMBAtnU4XQU6LsgFUY0CFLWUM79qSnqogrvHKNrMSi
 Uj5QDfgkr/qr7tlETVcmsoqLj7uAJxMSpaoEcI7LaOsOl7V57oYTa3S29AbxdqE//MsZ
 1RzHT6VRGAzyyr+rqrdnkG1t+ofBFZjYCcG4NQSaEFqDcL6QVGVYOX2wC0t/wV5wuN1y
 vMrg==
X-Gm-Message-State: APjAAAXJR71EmFf9LyMlGqusMtJEUOA0xmUDfbQQPlYuYUy/5RxlUate
 eJIskrkEMQIYnHvNZ3L28pS9Jh4YXnsPn4jrvj7xTw==
X-Google-Smtp-Source: APXvYqxQzwPhelV6ZZwrq5MSX1IyTK+je77XKLvDTBKYjSLw0vhDo5VbqVt+scExdL3msQaC3X+JPutk59fE7HYmztQ=
X-Received: by 2002:a2e:9687:: with SMTP id q7mr39169212lji.232.1577931931707; 
 Wed, 01 Jan 2020 18:25:31 -0800 (PST)
MIME-Version: 1.0
References: <20200102001823.21976-1-baolu.lu@linux.intel.com>
 <20200102001823.21976-23-baolu.lu@linux.intel.com>
 <CAL1RGDWU=s6nVArvkci1cXyZVw-fvdtcOjuY+9E+rgBi65q=Aw@mail.gmail.com>
 <567f1506-4a13-535b-ce41-aac079941510@linux.intel.com>
In-Reply-To: <567f1506-4a13-535b-ce41-aac079941510@linux.intel.com>
Date: Wed, 1 Jan 2020 18:25:47 -0800
Message-ID: <CAL1RGDVF1icaeEWMe0r0VA8AaxtHGJZ8NHCpvJfT8+1duOUYAQ@mail.gmail.com>
Subject: Re: [PATCH 22/22] iommu/vt-d: Add a quirk flag for scope mismatched
 devices
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jim Yan <jimyan@baidu.com>, iommu@lists.linux-foundation.org
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
From: Roland Dreier via iommu <iommu@lists.linux-foundation.org>
Reply-To: Roland Dreier <roland@purestorage.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> We saw more devices with the same mismatch quirk. So maintaining them in
> a quirk table will make it more readable and maintainable.

I guess I disagree about the maintainable part, given that this patch
already regresses Broadwell NTB.

I'm not even sure what the DMAR table says about NTB on my Skylake
systems, exactly because the existing code means I did not have any
problems.  But we might need to add device 201Ch too.

Maybe we don't need the mismatch check at all?  Your patch sets the
quirk if any possibly mismatching device is present in the system, so
we'll ignore any scope mismatch on a system with, say, the 8086:2020
NVMe host in it.  So could we just drop the check completely and not
have a quirk to disable the check?

 - R.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
