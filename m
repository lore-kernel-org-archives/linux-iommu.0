Return-Path: <SRS0=S8Y4=ZU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF1CC432C0
	for <iommu@archiver.kernel.org>; Thu, 28 Nov 2019 01:18:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 384732158A
	for <iommu@archiver.kernel.org>; Thu, 28 Nov 2019 01:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="td7BZspJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384732158A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EB45E86E88;
	Thu, 28 Nov 2019 01:18:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id etTtFIDTpMP3; Thu, 28 Nov 2019 01:18:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DD80083AF8;
	Thu, 28 Nov 2019 01:18:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0CCAC1DDA;
	Thu, 28 Nov 2019 01:18:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32770C0881
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 01:18:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2C2C184138
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 01:18:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UTcMRpJm09eL for <iommu@lists.linux-foundation.org>;
 Thu, 28 Nov 2019 01:18:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com
 [209.85.208.171])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E46C7835CD
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 01:18:08 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id g3so26515147ljl.11
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 17:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=JMQdYJyn4DZq+HXMjxQakd49p+RuvCwuEXKGIF9rqTI=;
 b=td7BZspJ5Xsl83MelXI11nerSudeInN1dov3tywp9Hovx/ySwez9UXMND2e1ouhfG4
 /10vSg83C2Vhx5p8DHPlhZegPsUcnLpA6XUfIYIhq8X7TtXHqZmIb9eSq6BwZXXCApzx
 K45DuwlPrlJkDvz/dXPvOmdO9d9jlT2PM7z926PjB8RQMnBu3F46YCyq9uJSrpP7alwz
 4KEAKfJef/nezV3ly7DF/nK10VbbM6M2fFdbY1M5BRiLlRmbkR2VpTjfzij6FvxjtNvx
 M+og1v2CfIdYOLVFJlbzREX7jIM65vqK2twHNWTN4ae0qnZe/UJIxsmbc7q87OEvFosu
 XjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=JMQdYJyn4DZq+HXMjxQakd49p+RuvCwuEXKGIF9rqTI=;
 b=heAscgmGXWC30Z6Dj6gyWG7tDeOTw8Hhw8197dT3mxq/KpFq8M8hewIJPQ4jKCD/De
 n7bZPkVfS65Hc2X/ZTVamaf8ydmorB35nK8FRbUf93rLsiVEPQK82H5/7QKOJVaycDzH
 flDedWFoYo2umTAi1m/wiDYCJ0I+xPHEXEPB/A1dG9utTpr/FgHgosgF3X7Akpvx9Oi5
 UPYZgpPsKbxjnUidtjvJ/LUDzu37WW36ZqmQf53exlS7HdY8rRFZZDHlZ+wwORnWG+Ns
 hg2AhR9iXnZ5BGEl9D5PAb56rubHSIEkoSYtArnRPzt155PyLRFhmc51O44iAjTFyM9a
 gZeg==
X-Gm-Message-State: APjAAAV9CO6EOOMfjNNI6bswGvGa0dVw13uZlnCVAjkFMbZVtU99nsYU
 vGc6owiX/x6Fy3YtCUMD/1Ihze2bDzLQC8MOd26PaHT/
X-Google-Smtp-Source: APXvYqwNI2Fn5vC7EN8OmFJ14kSZpXPfxH3nPk3/O6TZYFxT3mCT14/zMqKHMucTYlDtMco1octC6bGk+3BoFLsY54Q=
X-Received: by 2002:a2e:2283:: with SMTP id
 i125mr17406903lji.244.1574903886798; 
 Wed, 27 Nov 2019 17:18:06 -0800 (PST)
MIME-Version: 1.0
From: Aaron Gray <aaronngray.lists@gmail.com>
Date: Thu, 28 Nov 2019 01:17:50 +0000
Message-ID: <CANkmNDekywL6p7q48pG0_-RqF+LakRze8b7FPbR+kz620Ngwcw@mail.gmail.com>
Subject: How to read BIOS'es memory from IOMMU
To: iommu@lists.linux-foundation.org
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

Hi, I am interested in writing a program to verify BIOS integrity via
SHA512. Most modern BIOS'es seem to be accessible through IOMMU. I'm
wondering if there is a device driver for IOMMU or whether one could
be created for the purposes of accessing BIOS memory.

If anyone has any leads or advice or even can show me how to do this
in code via example/pseudo code I would appreciate it.

Regards,
Aaron

-- 
Aaron Gray

Independent Open Source Software Engineer, Computer Language
Researcher, Information Theorist, and amateur computer scientist.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
