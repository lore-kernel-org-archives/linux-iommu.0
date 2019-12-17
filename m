Return-Path: <SRS0=3Hz1=2H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4966CC43603
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 06:13:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D11D24676
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 06:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S65UElUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D11D24676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CF08087938;
	Tue, 17 Dec 2019 06:13:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LKMvYMZQ9u+t; Tue, 17 Dec 2019 06:13:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E0918878E3;
	Tue, 17 Dec 2019 06:13:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C00F7C18DD;
	Tue, 17 Dec 2019 06:13:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AD22C077D
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 06:13:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 34AF9858BF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 06:13:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vZkgOKhsCM-u for <iommu@lists.linux-foundation.org>;
 Tue, 17 Dec 2019 06:13:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4E7F285868
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 06:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576563210;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=SiU3iojc8KztiOx21hGe4lTyBXAFozx9uHjLevKXtxs=;
 b=S65UElUd38xbejY709c/isPmnzPvpoolLKhdbukBOGFMzMoVPFGs4t+ZY+ZRd8hLPRatKD
 yx26Az3Ly4V4TQY+zzgMRbeDIwp6S8SACw/jNmhc99JsUG03f+scJpKuIoOEY0HoynRkMY
 paKnRN4HLWyblzoKJMmJAwOYp9Cuedc=
Received: from mail-yw1-f71.google.com (mail-yw1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-7ONnIkqjOZyTR2vJfWOzuw-1; Tue, 17 Dec 2019 01:13:29 -0500
X-MC-Unique: 7ONnIkqjOZyTR2vJfWOzuw-1
Received: by mail-yw1-f71.google.com with SMTP id c68so7386824ywa.2
 for <iommu@lists.linux-foundation.org>; Mon, 16 Dec 2019 22:13:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=SiU3iojc8KztiOx21hGe4lTyBXAFozx9uHjLevKXtxs=;
 b=VSXPzHJ8voWIblKrD2WA0B50b1mw3NsVlVfi1QjpUE2vC2r3uD13zIZXBgcMlHUveC
 KPdBVisvCjpYutS7aKJqGFIvYxh0Ul8vdUscTnHzgyzJJqdtNfKeATEDsVp631K4lNEC
 6VWC83SZRJvxwsUPyYAz5TY1LDjw8ykbXGV1huevzqlN6fXGpCOZX+RAxEQ0jGov56VJ
 Vf/hauCpTw080GFYoIl6iYAG9zXOUrarCwczMJLDcBlhvG49ql28iMvvJ6CAIh83SF84
 Conp0dV8oqFuE5KEL6K9uT10pQrjTGsymlHRN9qnHISzZBgcwdS56g+pZwxSqky5rr3n
 1eTA==
X-Gm-Message-State: APjAAAWoyWKD4R48KUw3hPsyN0DE5oNFrt4OVPQFMHDYWpvZZr1JOV5P
 PZ5NUFwSq89UGXaGtDpqjsrs5b/t6dhmE80dHmPYFPZCFq/LLKjT+sWLuoVaA3jIiuexZWLozrh
 DAXVZ4za2SlRyEjxx328BWT+u12j/1Q==
X-Received: by 2002:a25:3803:: with SMTP id f3mr23248220yba.144.1576563208268; 
 Mon, 16 Dec 2019 22:13:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqxoB5IjXGTbrM0Ii2yTe96Xko4hQNa6W9HaJcW2UvIjEDQcue5di77FK6VsGF+OdaPWhJQlPw==
X-Received: by 2002:a25:3803:: with SMTP id f3mr23248212yba.144.1576563208012; 
 Mon, 16 Dec 2019 22:13:28 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id x84sm9173071ywg.47.2019.12.16.22.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 22:13:27 -0800 (PST)
Date: Mon, 16 Dec 2019 23:13:25 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux-foundation.org, Lu Baolu <baolu.lu@linux.intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: panic in dmar_remove_one_dev_info
Message-ID: <20191217061325.fbzcxgh4sng5lkn7@cantor>
Mail-Followup-To: iommu@lists.linux-foundation.org,
 Lu Baolu <baolu.lu@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20191216205757.x4hewnduopbo4mpv@cantor>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191216205757.x4hewnduopbo4mpv@cantor>
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

On Mon Dec 16 19, Jerry Snitselaar wrote:
>HP is seeing a panic on gen9 dl360 and dl560 while testing these other
>changes we've been eorking on. I just took an initial look, but have
>to run to a dentist appointment so couldn't dig too deep. It looks
>like the device sets dev->archdata.iommu to DEFER_DEVICE_DOMAIN_INFO
>in intel_iommu_add_device, and then it needs a private domain so
>dmar_remove_one_dev_info gets called. That code path ends up trying to
>use DEFER_DEVICE_DOMAIN_INFO as a pointer.  I don't need if there just
>needs to be a check in there to bail out if it sees
>DEFER_DEVICE_DOMAIN_INFO, or if something more is needed. I'll look
>at it some more when I get back home.
>
>Regards,
>Jerry

Hi Baolu,

Does this look sane?

--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5163,7 +5163,8 @@ static void dmar_remove_one_dev_info(struct device *dev)
  
         spin_lock_irqsave(&device_domain_lock, flags);
         info = dev->archdata.iommu;
-       if (info)
+       if (info && info != DEFER_DEVICE_DOMAIN_INFO
+           && info != DUMMY_DEVICE_DOMAIN_INFO)
                 __dmar_remove_one_dev_info(info);
         spin_unlock_irqrestore(&device_domain_lock, flags);
  }




Regards,
Jerry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
