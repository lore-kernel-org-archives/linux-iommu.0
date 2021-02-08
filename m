Return-Path: <SRS0=aVDl=HK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D658EC433E0
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 02:24:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25CE464E87
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 02:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25CE464E87
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D94DC85087;
	Mon,  8 Feb 2021 02:24:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F5BENJXCqfiL; Mon,  8 Feb 2021 02:24:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5E6C784EA7;
	Mon,  8 Feb 2021 02:24:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21F69C0174;
	Mon,  8 Feb 2021 02:24:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B64EAC013A
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 02:24:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9E91220414
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 02:24:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4HSrn6+9mBAO for <iommu@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 02:24:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 by silver.osuosl.org (Postfix) with ESMTPS id 743B9203CF
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 02:24:11 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id r75so520615oie.11
 for <iommu@lists.linux-foundation.org>; Sun, 07 Feb 2021 18:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :mime-version; bh=GAcPfGgqFaC7AQHCBuJv2BWxwOPW6rvQxJdX43h7J8I=;
 b=RFsozuFj8ctQYWnOlHXA/Y/S/JT+BT2d1zgMTOBparInBD0Zft//MwDz9Pv3qTpRo6
 cYnt4/eMEoTNmZaIjVO2TLhCmJ5C57vV4qvNpNJbSbEiEAYxF4yWJG4MXu8cAsWDTDo+
 WbVbEUREEq2v/o6uVpD3zSkYM6tjdfLSWrvXySJCEv2KSD78mt+euMZNuzFuILuIrev/
 gekJ7tvJj2hVKKklNDYczXUA/ko/19HwJDowAenLYVLrIG2SP/7gwDb1vJahO8ndfhgh
 01X02jthq8tr3Gyytp+nR/cZpF484dMC3l0bxJqjGc6dIl8lMe9epYDH0TO4L9WbxQHy
 xe+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:mime-version;
 bh=GAcPfGgqFaC7AQHCBuJv2BWxwOPW6rvQxJdX43h7J8I=;
 b=kiGGs+wqlN2vjTyobg/34RxApplA49DSodMeESMWu0R7o8MBBuQfmuJy3HwRUVfNXG
 aZ6k8N1YxX/m0O8upIW+qD4/0i/hw62DuhjSStbrZ99ms+6NGtkUOywOz/IkAwb7F6HC
 0nFCjYpiONKMoBmOYaV9I6IBa+lmDsSvynYtMQ7UiCLWsUQyAJ3/LSZK8ZO1mXeU6vEm
 Y6e8O6Wp4L+wf/sWYd5F4FeoZLgHJPI42Wwx2ioQwVXvdwippmiepMVEnPIT+i7A9DCW
 yMziR471B1uMf8uFFqalLVdnAE0x0zTSr5HhoOSBSC5XeTX+Z69mRnSaXed7G5Fxyfhq
 6PLg==
X-Gm-Message-State: AOAM530QbjU9TPH38JKNkDdCew71RTqSyzmkMG+rarA4c4yuRgGjj+bF
 WSSwUo2vTdGo4S2dczrhNAwuGGaLZ6JRhQ==
X-Google-Smtp-Source: ABdhPJzp7qfYhmXBu6bdi33JxaukusthN+TP0Ot/ZqOrf1qCP06tl6JjG1EiU2ivo+TK3WKChum8ew==
X-Received: by 2002:a17:90a:b782:: with SMTP id
 m2mr14552165pjr.220.1612750683085; 
 Sun, 07 Feb 2021 18:18:03 -0800 (PST)
Received: from [2620:15c:17:3:8d40:a1e2:ae2d:6c53]
 ([2620:15c:17:3:8d40:a1e2:ae2d:6c53])
 by smtp.gmail.com with ESMTPSA id f33sm354958pjk.17.2021.02.07.18.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Feb 2021 18:18:02 -0800 (PST)
Date: Sun, 7 Feb 2021 18:18:01 -0800 (PST)
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Subject: RE: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory pin
In-Reply-To: <f4b2d7db8a1047d9952cbbfaf9e27824@hisilicon.com>
Message-ID: <90aca1e9-61b5-88d-d28c-369e6973559e@google.com>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <20210207213409.GL308988@casper.infradead.org>
 <f4b2d7db8a1047d9952cbbfaf9e27824@hisilicon.com>
MIME-Version: 1.0
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "chensihang \(A\)" <chensihang1@hisilicon.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liguozhu \(Kenneth\)" <liguozhu@hisilicon.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Sun, 7 Feb 2021, Song Bao Hua (Barry Song) wrote:

> NUMA balancer is just one of many reasons for page migration. Even one
> simple alloc_pages() can cause memory migration in just single NUMA
> node or UMA system.
> 
> The other reasons for page migration include but are not limited to:
> * memory move due to CMA
> * memory move due to huge pages creation
> 
> Hardly we can ask users to disable the COMPACTION, CMA and Huge Page
> in the whole system.
> 

What about only for mlocked memory, i.e. disable 
vm.compact_unevictable_allowed?

Adding syscalls is a big deal, we can make a reasonable inference that 
we'll have to support this forever if it's merged.  I haven't seen mention 
of what other unevictable memory *should* be migratable that would be 
adversely affected if we disable that sysctl.  Maybe that gets you part of 
the way there and there are some other deficiencies, but it seems like a 
good start would be to describe how CONFIG_NUMA_BALANCING=n + 
vm.compact_unevcitable_allowed + mlock() doesn't get you mostly there and 
then look into what's missing.

If it's a very compelling case where there simply are no alternatives, it 
would make sense.  Alternative is to find a more generic way, perhaps in 
combination with vm.compact_unevictable_allowed, to achieve what you're 
looking to do that can be useful even beyond your originally intended use 
case.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
