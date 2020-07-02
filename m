Return-Path: <SRS0=8rqH=AN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D589C433DF
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 12:04:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8D0820737
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 12:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D0820737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 88C7E88EA2;
	Thu,  2 Jul 2020 12:04:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P0zT1_pTqWYW; Thu,  2 Jul 2020 12:04:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6F69088E97;
	Thu,  2 Jul 2020 12:04:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54D40C0888;
	Thu,  2 Jul 2020 12:04:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67B90C0733
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 12:04:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 47C9589BBD
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 12:04:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JaEWelNN7zfy for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jul 2020 12:04:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D28BD89860
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 12:04:27 +0000 (UTC)
Received: from mail-pf1-f197.google.com ([209.85.210.197])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1jqxx3-000700-V8
 for iommu@lists.linux-foundation.org; Thu, 02 Jul 2020 12:04:26 +0000
Received: by mail-pf1-f197.google.com with SMTP id d67so16455562pfd.4
 for <iommu@lists.linux-foundation.org>; Thu, 02 Jul 2020 05:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:content-transfer-encoding:mime-version
 :subject:message-id:date:cc:to;
 bh=6U4bdTq8kytYWqveDbphl0yfVzNtHItRUMAWKUCvHZ8=;
 b=J2yCTHAdd/CJ4CFOiB/hzESOueJ8Sp4D2+4PvCiCppcOvpC9cMojbik2uG2nkI3yzT
 KCtUyCe0S39e655Y+cyU3LQ+idmat07D4HOAzWSXur6IaeBKHsoEG0sA681MRgZJ2xTq
 G86dSHAl+I1Uq/u6h5LsntZ2+bqqmdMozdd1A6XvHaroyx2pHkxfJsmIFJYfiRUXPW4E
 kdN0hilNdOfrXNvmoHcMhyT0RJIWSDol9HS8307TqgPll+Q2rmD07cOH+HdulKPrAH93
 UpK8hGOuAa41M+md9Jo7PPQ1KtJU9ou+G/0dB8EMDMbgnNoOe5xi0vurQKejrJEEOyWr
 tjkA==
X-Gm-Message-State: AOAM530gpm4afr2iyXgdoIaMBdZdF4vLLC2z8ABj2ErXWlA4BkKeL3qT
 Rj7B7v7/RJ0LQSe3pTFI/CmGBFYkvrp4QCxwS15LnXMAcOY73w75HvtFZjuhGC224bSmg0Vlwwh
 jng0fhFwTikSktYy4ZCXyTVwG+yx5aydSgsZE4Bjl9Ob098A=
X-Received: by 2002:a63:5013:: with SMTP id e19mr24290813pgb.68.1593691464573; 
 Thu, 02 Jul 2020 05:04:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRvd+NbScka7tYb6z92sznSO8thLnWMVPdDQU4d17B5jU9vGbiHDEXuLN8ZHl6gVSFbzEj/Q==
X-Received: by 2002:a63:5013:: with SMTP id e19mr24290787pgb.68.1593691464269; 
 Thu, 02 Jul 2020 05:04:24 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net.
 [220.133.187.190])
 by smtp.gmail.com with ESMTPSA id 193sm8577808pfz.85.2020.07.02.05.04.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 Jul 2020 05:04:23 -0700 (PDT)
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: [BUG] "Pre-boot DMA Protection" makes AMDGPU stop working
Message-Id: <546DB0FA-FDEB-4FD1-93CD-AA5474B5F0DD@canonical.com>
Date: Thu, 2 Jul 2020 20:04:20 +0800
To: Joerg Roedel <jroedel@suse.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 iommu@lists.linux-foundation.org, open list <linux-kernel@vger.kernel.org>
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

A more detailed bug report can be found at [1].

I have a AMD Renoir system that can't enter graphical session because there are many IOMMU splat.

Alex suggested to disable "Pre-boot DMA Protection", I can confirm once it's disabled, AMDGPU starts working with IOMMU enabled.
So raise the issue here because I have no knowledge on how to reset the IOMMU.

[1] https://gitlab.freedesktop.org/drm/amd/-/issues/1204

Kai-Heng
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
