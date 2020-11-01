Return-Path: <SRS0=oYak=EI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A572C00A89
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 10:37:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F87206BE
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 10:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuIEQ8e6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F87206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 361B1204A5;
	Mon,  2 Nov 2020 10:37:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xBD52y4OHgEU; Mon,  2 Nov 2020 10:37:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 18E4420452;
	Mon,  2 Nov 2020 10:37:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05910C0889;
	Mon,  2 Nov 2020 10:37:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7152AC0051
 for <iommu@lists.linux-foundation.org>; Sun,  1 Nov 2020 15:43:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 52B02203D4
 for <iommu@lists.linux-foundation.org>; Sun,  1 Nov 2020 15:43:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2gzsEiY8aE-m for <iommu@lists.linux-foundation.org>;
 Sun,  1 Nov 2020 15:43:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by silver.osuosl.org (Postfix) with ESMTPS id 0037A203A5
 for <iommu@lists.linux-foundation.org>; Sun,  1 Nov 2020 15:43:36 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id oq3so13314686ejb.7
 for <iommu@lists.linux-foundation.org>; Sun, 01 Nov 2020 07:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=w86MdxES7QgjJ/aCgpHMmEZHj70Ct+Ac20WhoGDMRd4=;
 b=HuIEQ8e6pSZWNi+tXO4E3ik7mbThP3McTM7hvRQ0Ad7qlxAOSi1odydK2x//kOt63v
 QSZJnQYF7va/crVQfZh8lXtA54aYwl/4iyHC1iegROQolGC0XAdhpjRpa+mUdDLcETAJ
 F/Lv2lt9yqYCxZ+Y2gmiDzuOL4s1HJWl4TgTHcVU0gzcZ6CyQCz7zZxjPtHqrQCg55hQ
 1X4e+2b5bwhAhRhm0h0L/FoCaaEejvLNVVL0gufNVR3gqzaONTu0ONUfFHLFtiRlxBSb
 4GmSP/2zF4TuZjhEj8aR+XGaJw8jmIJ1Jmh6877H6FuKh8oJD4Vcc2qmVCOnWZbL98AQ
 082g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=w86MdxES7QgjJ/aCgpHMmEZHj70Ct+Ac20WhoGDMRd4=;
 b=MYPT2htwUDCXrW7CLpyNTTOPcCfFDh+7+YglmeZ29np3EBP6weuvDNYsGVZzRNwJEx
 xUVZYKuL98Fyya1aI/+3doOD4VRCXn8Dw1UZC84NKmBtYXQDowX8LO2gE81QdhAeh6mC
 sEmCODbGvCBrOL9Pd0Pgzp+rHI1cUQ4hZSUCRrEef6DpG2MCXH7N0q602TkLTp3EB3eP
 nOkUJXLusIibXT0CbCHT7Yyek7n2934inGEpZS6SdTe6exq9OZLZ54+uN4lPzbnVZXFC
 ZELGjGdo7q7BXTTzWQBKVOjNHLok2Q5XkuZp0A5Ob6ziVd+Av0xUpPV5VivXth/EzZAd
 anjw==
X-Gm-Message-State: AOAM532DWt+g8DP9ncXS5DOpjkFkB8TlFR4wmI0I0UVd6QWt59l4qVXK
 70e2VKzJRmSTPnljDxcbSD8dIEqaeu004MqLv1LuaQdElwA=
X-Google-Smtp-Source: ABdhPJzJuvAaQtQ0+KYWEqtby7LH4TNwuomOs8NIM35gLJSVvn3daE0QNYklLpevcHFJaCBA6+UtrlnopuaK/nok/tQ=
X-Received: by 2002:a17:906:a195:: with SMTP id
 s21mr10960877ejy.146.1604245415213; 
 Sun, 01 Nov 2020 07:43:35 -0800 (PST)
MIME-Version: 1.0
From: Tom Yan <tom.ty89@gmail.com>
Date: Sun, 1 Nov 2020 23:43:24 +0800
Message-ID: <CAGnHSEnS9OZ0i-7aL3ZuCRjNGTnUuqmbEaVN1t=WEOjUXRrUqw@mail.gmail.com>
Subject: Intel VT-d IOMMU group regression in v5.9
To: iommu@lists.linux-foundation.org
X-Mailman-Approved-At: Mon, 02 Nov 2020 10:37:10 +0000
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

Hi,

Please check out https://bugzilla.kernel.org/show_bug.cgi?id=209857, thanks!

Regards,
Tom
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
