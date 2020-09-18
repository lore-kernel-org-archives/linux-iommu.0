Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5654BC43464
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 15:12:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE6A2388B
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 15:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wzivI/0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE6A2388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 44FF42E21D;
	Fri, 18 Sep 2020 15:12:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NTycciBZjrr2; Fri, 18 Sep 2020 15:12:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 242C120242;
	Fri, 18 Sep 2020 15:11:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0303EC0890;
	Fri, 18 Sep 2020 15:11:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66CABC0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 15:11:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 316CF20242
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 15:11:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s12v4519gLJC for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 15:11:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by silver.osuosl.org (Postfix) with ESMTPS id E2BC42E22A
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 15:09:09 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id o5so5972416wrn.13
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=S4LpOOm6tVYTs7goMBdm7J8/ofwQxzSn7OTgJv+VXAw=;
 b=wzivI/0MdIxstfSwFf54c+jJRtzZxx7jtiJKyOuR5mPKA8ZJUvr8idkQk0A3mzHXVa
 qiAWaeYqeFNYNFF4REKb+lMNh6tmDMpJyZqvYjoD5ctIUbJ0fOdlCgKJLBFg+gcjxYDy
 FhYYsf/+LVH36+C4PQLMyFtTyI1+MAm2wqAiN0XP5G8JLN+68En3SBPEaQhZkL8W7oXA
 C75Hfxi9Gkm7ZLkxh2cVtkjGyr8iNvftQIGjeiy1gGkKbdRnlfmUoCAv3jXRaQuQ4Lt7
 ZkQfmDyo4y5jsMLKAlbvBg9bK8fIWM23gCR1pmyQHoN8YOOh1XCnwXSvJRGcf+D7ekuP
 hvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=S4LpOOm6tVYTs7goMBdm7J8/ofwQxzSn7OTgJv+VXAw=;
 b=Di3G6gOHsPegZ2A6hCkknOakvoGw8CDLu3yw6Dlny1FLreYwcYgiNb+JhTQdVTMlwk
 wqi7/wIDoR7HDRhQkroo3tLCHK9dlH+ylxJrR4f/r+8hg+Et0Tr8vTyzMcvwBW7a54sk
 NJv8o1FIk5I/TBxlCeBeF3mhuZI1KiYral3CerhWiH8+Tho13oOHLcokKYI4gc64nZTi
 txETEBvEOYOjG/ryhNHwbybvCAH93oLMwHIeimLP2XMr76Hs7Z8Otz83ds/lrohRyMmp
 tXo9IW4TQqRwbf8ZEl8ZWSf9Kwk5Oca5XfAcxBZLuTUEUZb7srcVycsykNKADJ+fqJhF
 da3g==
X-Gm-Message-State: AOAM533296GLvdEkbszVID0iiRnfi24K2dEXvkI6aV13p/5pkYO6okUe
 uEl/hA8NK0UPuplhEBo8/ZEgKg==
X-Google-Smtp-Source: ABdhPJxH72AIiZTyzgDTyzRlYy2NX5WYfjFMKfkPzelf6HiSsRcYDZxYMagFrqC8azag2ZiKPtTASg==
X-Received: by 2002:a5d:6547:: with SMTP id z7mr37973826wrv.322.1600441748298; 
 Fri, 18 Sep 2020 08:09:08 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id h2sm5945946wrp.69.2020.09.18.08.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 08:09:07 -0700 (PDT)
Date: Fri, 18 Sep 2020 17:08:49 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix endianness annotations
Message-ID: <20200918150849.GA632295@myrica>
References: <20200918141856.629722-1-jean-philippe@linaro.org>
 <67ae1b1b-16af-f488-9a07-7c0bf4a03147@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <67ae1b1b-16af-f488-9a07-7c0bf4a03147@arm.com>
Cc: will@kernel.org, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org
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

On Fri, Sep 18, 2020 at 04:02:26PM +0100, Robin Murphy wrote:
> On 2020-09-18 15:18, Jean-Philippe Brucker wrote:
> > When building with C=1, sparse reports some issues regarding endianness
> > annotations:
> > 
> > arm-smmu-v3.c:221:26: warning: cast to restricted __le64
> > arm-smmu-v3.c:221:24: warning: incorrect type in assignment (different base types)
> > arm-smmu-v3.c:221:24:    expected restricted __le64 [usertype]
> > arm-smmu-v3.c:221:24:    got unsigned long long [usertype]
> > arm-smmu-v3.c:229:20: warning: incorrect type in argument 1 (different base types)
> > arm-smmu-v3.c:229:20:    expected restricted __le64 [usertype] *[assigned] dst
> > arm-smmu-v3.c:229:20:    got unsigned long long [usertype] *ent
> > arm-smmu-v3.c:229:25: warning: incorrect type in argument 2 (different base types)
> > arm-smmu-v3.c:229:25:    expected unsigned long long [usertype] *[assigned] src
> > arm-smmu-v3.c:229:25:    got restricted __le64 [usertype] *
> > arm-smmu-v3.c:396:20: warning: incorrect type in argument 1 (different base types)
> > arm-smmu-v3.c:396:20:    expected restricted __le64 [usertype] *[assigned] dst
> > arm-smmu-v3.c:396:20:    got unsigned long long *
> > arm-smmu-v3.c:396:25: warning: incorrect type in argument 2 (different base types)
> > arm-smmu-v3.c:396:25:    expected unsigned long long [usertype] *[assigned] src
> > arm-smmu-v3.c:396:25:    got restricted __le64 [usertype] *
> > arm-smmu-v3.c:1349:32: warning: invalid assignment: |=
> > arm-smmu-v3.c:1349:32:    left side has type restricted __le64
> > arm-smmu-v3.c:1349:32:    right side has type unsigned long
> > arm-smmu-v3.c:1396:53: warning: incorrect type in argument 3 (different base types)
> > arm-smmu-v3.c:1396:53:    expected restricted __le64 [usertype] *dst
> > arm-smmu-v3.c:1396:53:    got unsigned long long [usertype] *strtab
> > arm-smmu-v3.c:1424:39: warning: incorrect type in argument 1 (different base types)
> > arm-smmu-v3.c:1424:39:    expected unsigned long long [usertype] *[assigned] strtab
> > arm-smmu-v3.c:1424:39:    got restricted __le64 [usertype] *l2ptr
> > 
> > While harmless, they are incorrect and could hide actual errors during
> > development. Fix them.
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks!

> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> > 
> > There is another false positive due to passing INT_MIN to cmpxchg, and
> > __cmpxchg* to truncate them to u8 and u16:
> > 
> > arch/arm64/include/asm/cmpxchg.h:172:1: warning: cast truncates bits from constant value (ffffffff80000000 becomes 0)
> > arch/arm64/include/asm/cmpxchg.h:172:1: warning: cast truncates bits from constant value (ffffffff80000000 becomes 0)
> > 
> > I haven't found a satisfying fix so far, except adding __force to
> > __cmpxchg_case* which could hide actual bugs.
> 
> I guess that's a general issue with the switch(sizeof()) idiom of sparse not
> being aware that those cases are unreachable?

Precisely. I wondered if _Generic could help, but it looks like the
problem is the same.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
