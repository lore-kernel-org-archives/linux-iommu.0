Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE760C433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 21:34:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1FA64EF6
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 21:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1FA64EF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15E326F9C5;
	Wed,  3 Mar 2021 21:34:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tHypDGbqxp20; Wed,  3 Mar 2021 21:34:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FD5A6F994;
	Wed,  3 Mar 2021 21:34:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC39CC000A;
	Wed,  3 Mar 2021 21:34:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2447DC0001
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 21:34:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 12AA782FA9
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 21:34:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sPog70E02TB5 for <iommu@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 21:34:14 +0000 (UTC)
X-Greylist: delayed 05:49:43 by SQLgrey-1.8.0
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0AE1283131
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 21:34:13 +0000 (UTC)
Received: by mail-qv1-xf2c.google.com with SMTP id d9so6273088qvo.3
 for <iommu@lists.linux-foundation.org>; Wed, 03 Mar 2021 13:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yAenZ2k324Y74inyHnLSpf4GKMijWe+eb5zJ0f7us3Y=;
 b=Yo/WbLtNEcukoBaVIbtOmoJkqQ78eohGvlv9L6yTWcdDIuU+1DKAsD3fh1HE47Xrp+
 QFlB7j0powGVx/NAToiiojNwZYwizMSL3bMhnmCO5LXvVsufMjP7GNnPm8L/4Z04DNED
 PwkvridEsCPsRoNu/6CyDKV6GbFO6q2fPyLhHKJnUfbBGoKhaEDc7kAAkZXc5ASnjGnj
 COSukL6HNRaAnW+dWsCVUTEWV6O1Sj57SBKzdk7nqI1XHIiwgqRSH+n321SqE/5pCgGy
 ZRtUeRAi9hqP8qbDLI7pXQc3l3kAvlrBrJ0G4HVsFGa3WxRqSwAhAuIuaJFI+TFc8FpN
 EZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=yAenZ2k324Y74inyHnLSpf4GKMijWe+eb5zJ0f7us3Y=;
 b=CLTJBm2Eq8KMKxS6b46ifIniyODl1329B0xtWjh4h3kWvKgDzGr20beBw1pxxfgJfY
 6+f3lssoPUT0ono8VMs1lGv5NjQAs2XOMO/DNPVgLNoiUGsrgOLaUMAsNAhR+6eppEeP
 6vRa+1FR0xG7vMlwgk/enkgMDk3xioOcnIbCLmvN3ByKR6WIRU+13BqwjH3EI8ow84Ty
 PHE6heabwe7DC+nz3s8pfk3QOyFn4VEfqR4W0prEk3WHdMMOWLt4X0/8gBYU8x8GGp7q
 b9DDEUo2Qhwv1RNJCYx2gWZzCWsQzxzmJKborp+MnYTykGWzeZE7H+1P39zGOCY3tewn
 tRDQ==
X-Gm-Message-State: AOAM532kw/Av6g9TfW6rpMMmjjoGzrEpKeUOvrHLdMu+Qu8mJ/S2wKju
 zG7RazAl2nDleGwHGxB/dXcbbxIkgp3iEA==
X-Google-Smtp-Source: ABdhPJzfFnuZzOw9IZBrOfo12BzAhQPTqGWB0InFeznSDVw2hz00sFHfeQE8i+h+temYeCDQwJeU0A==
X-Received: by 2002:ad4:4581:: with SMTP id x1mr3253236qvu.9.1614786270710;
 Wed, 03 Mar 2021 07:44:30 -0800 (PST)
Received: from localhost
 (2603-7000-9602-8233-06d4-c4ff-fe48-9d05.res6.spectrum.com.
 [2603:7000:9602:8233:6d4:c4ff:fe48:9d05])
 by smtp.gmail.com with ESMTPSA id g6sm1590177qtg.91.2021.03.03.07.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Mar 2021 07:44:29 -0800 (PST)
Date: Wed, 3 Mar 2021 10:44:28 -0500
From: Tejun Heo <tj@kernel.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [RFC PATCH 15/18] cgroup: Introduce ioasids controller
Message-ID: <YD+u3CXhwOi2LC+4@slm.duckdns.org>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 iommu@lists.linux-foundation.org, Li Zefan <lizefan@huawei.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
 cgroups@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>
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

On Sat, Feb 27, 2021 at 02:01:23PM -0800, Jacob Pan wrote:
> IOASIDs are used to associate DMA requests with virtual address spaces.
> They are a system-wide limited resource made available to the userspace
> applications. Let it be VMs or user-space device drivers.
> 
> This RFC patch introduces a cgroup controller to address the following
> problems:
> 1. Some user applications exhaust all the available IOASIDs thus
> depriving others of the same host.
> 2. System admins need to provision VMs based on their needs for IOASIDs,
> e.g. the number of VMs with assigned devices that perform DMA requests
> with PASID.

Please take a look at the proposed misc controller:

 http://lkml.kernel.org/r/20210302081705.1990283-2-vipinsh@google.com

Would that fit your bill?

Thanks.

-- 
tejun
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
