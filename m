Return-Path: <SRS0=JKdE=Z4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B05FC43603
	for <iommu@archiver.kernel.org>; Fri,  6 Dec 2019 21:58:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F8720867
	for <iommu@archiver.kernel.org>; Fri,  6 Dec 2019 21:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="SdYzh+WS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F8720867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F023487E9C;
	Fri,  6 Dec 2019 21:58:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ha6mbN9O+BvE; Fri,  6 Dec 2019 21:58:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4B2128855B;
	Fri,  6 Dec 2019 21:58:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38954C18DD;
	Fri,  6 Dec 2019 21:58:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B633CC077D
 for <iommu@lists.linux-foundation.org>; Fri,  6 Dec 2019 21:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9FD79869DD
 for <iommu@lists.linux-foundation.org>; Fri,  6 Dec 2019 21:58:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fbPVdPXwmWDA for <iommu@lists.linux-foundation.org>;
 Fri,  6 Dec 2019 21:58:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CC341869D1
 for <iommu@lists.linux-foundation.org>; Fri,  6 Dec 2019 21:58:00 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id g15so7785673qka.8
 for <iommu@lists.linux-foundation.org>; Fri, 06 Dec 2019 13:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=d39qGeCsB4T9yCMwOh22rEPx7j2ZU+Ojm9VxaLz0ibQ=;
 b=SdYzh+WSgVb+UAlrT82ud0JxMqc9Kvl4cFMITIP+eaCXAcdaJ4yq0fMWJk1wUaA0KC
 aFhnoG2xYpNONhb8lucwmhPkCepfnnJNWG8rRO0IDppIJNDgt62M0F7egSn/zAYZexT8
 3I3q7NnSV4x7CYCjMCFtWHAiVC/oRmDSC2wVzt/po8yJYZwUoldH3xbNxJXmxZeQ2odJ
 PpFSR9acSpVoHqlnxgF0Kwo+kDC7el18CLU3MNqJFsvpFRP/O2w8NGOXAzND5FH4fMQn
 ntJoiEwVQ1pfPUtaGEw/gnrTWKbVG/CP9vPMOUbf/z4WXywE8D+GHxoP+eTgapBxaLkr
 3c3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=d39qGeCsB4T9yCMwOh22rEPx7j2ZU+Ojm9VxaLz0ibQ=;
 b=eC8M5dpug9CmAGhqocpeEp1X2YamF3uhGJajXVLhK/UkM/pdsO0dFFOP75I3LvZoua
 DyH8t7wWLRsmK2lnvNDzUpkrThbt3O5x1COt5R3UiT1emDatutXeX4G77QxMJZseIefC
 526G//n+M4ACKQmAOK0aWLLUs9h0TMBESfF/xOkB2UFcr9EPnyAudWWioIx90JK3Gy1O
 yeITClrLf8LAKWxO/Y3UC2Bh+FYeLvyv5ycZKr71NdP2EtBGBMH1EWPWg7Hr/9Z6YWr8
 VmDMt6VdjugDekt5NcplyMMze35bnFBzx8FGO1UFPTSvXHK7p5xUKx35n7E34zZKp0bL
 gZ2g==
X-Gm-Message-State: APjAAAVj2bUUyzOOLMwvuylBXbPBA5+E+kycvdPvVnoaXW4TYrMh+wjE
 zKByvgo4zkXy5HTkEr7DkFSvyA==
X-Google-Smtp-Source: APXvYqzH8Eo/GmMk2sk0tLQrh06wbKztQryZpegYYGstCKfUtNQvXS54OiLe/ItzwAMah8/sBlxczQ==
X-Received: by 2002:a05:620a:144c:: with SMTP id
 i12mr275001qkl.439.1575669479724; 
 Fri, 06 Dec 2019 13:57:59 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net.
 [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id d143sm875770qke.123.2019.12.06.13.57.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 06 Dec 2019 13:57:58 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [Patch v3 0/3] iommu: reduce spinlock contention on fast path
From: Qian Cai <cai@lca.pw>
In-Reply-To: <20191206213803.12580-1-xiyou.wangcong@gmail.com>
Date: Fri, 6 Dec 2019 16:57:57 -0500
Message-Id: <1CDA04A5-9EF1-4B6F-8461-37361D6460E2@lca.pw>
References: <20191206213803.12580-1-xiyou.wangcong@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
X-Mailer: Apple Mail (2.3601.0.10)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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



> On Dec 6, 2019, at 4:38 PM, Cong Wang <xiyou.wangcong@gmail.com> wrote:
> 
> This patchset contains three small optimizations for the global spinlock
> contention in IOVA cache. Our memcache perf test shows this reduced its
> p999 latency down by 45% on AMD when IOMMU is enabled.

Can you at least have a changelog compared to previous versions?

> 
> Cong Wang (3):
>  iommu: avoid unnecessary magazine allocations
>  iommu: optimize iova_magazine_free_pfns()
>  iommu: avoid taking iova_rbtree_lock twice
> ---
> drivers/iommu/iova.c | 75 ++++++++++++++++++++++++++------------------
> 1 file changed, 45 insertions(+), 30 deletions(-)
> 
> -- 
> 2.21.0
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
