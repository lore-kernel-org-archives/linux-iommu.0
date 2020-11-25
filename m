Return-Path: <SRS0=GPDh=E7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DE0C56202
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 15:42:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC0C2145D
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 15:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuSjByGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC0C2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darnok.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 582D586E77;
	Wed, 25 Nov 2020 15:42:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3JxU7fLzEVnE; Wed, 25 Nov 2020 15:42:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 93D6586D38;
	Wed, 25 Nov 2020 15:42:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80A7AC163C;
	Wed, 25 Nov 2020 15:42:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34284C0052
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 15:41:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2F78687694
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 15:41:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oKf-oImB+asm for <iommu@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 15:41:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CD3FE8768D
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 15:41:57 +0000 (UTC)
Received: by mail-qt1-f196.google.com with SMTP id z3so1864158qtw.9
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 07:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=zJQ2hLwoYKnLT/mLeaSf+xgCMRB9d8OpY3uJGRpDrh8=;
 b=nuSjByGqfM0DLOPHS8807/d2MHwZyQ0oMMJcegcmic4Jy1ihsuYDkdrbQzDnrQ9q2T
 HJ0PX5wyfoeAyfEC10mav6bnWlqqySIplmsuTG7QK2JfK/URX4sdDuNt6Rr0xUtzvPtE
 Chs6DLzUgP4cJiJoOWafEYZgCKU/EZ/fFxIkkKdpBPjUKkDxMF69psIK+4VrAghS7Zek
 tfa5NJYwkr7MPK8nohTHTDXnnq/40o6x1lsycNv1fZsecnnshQpG5mvx0T4dj95UmQGk
 ljmFWunS4mOE9UvlQLw1Kpfc+L5smnqYbCx7gcLpoAPgc19ixzF2GffUHQkrEKr3C9Jw
 OYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=zJQ2hLwoYKnLT/mLeaSf+xgCMRB9d8OpY3uJGRpDrh8=;
 b=E1PCvG1Btkevx0XpVHNhhnveUK/rs2bwnKLHkUdtWJeA6yfdLtuEsEjYQWpW3ovafT
 4p3ZMj+RO+xjgl+REo1seryp1kquA8C3353OpWs4PZHQa8QnPhVyzemSLNkJbLhdSuC6
 zuhS9OSFUFISo6UeMLB0w6p0STyBvEFl1Za5nniUxTe0uc2j0SsTrYTVUA6naiuTKUAs
 AfDPoc1uaVznUAIB8I1c/Sp8K8kWgx2NjOGZ9ZcMj0DomU8FM5bUvqMKc9RuQgpDnJLJ
 5NBGN9VYbyXT4Iq+lPlrwE7Lkf8vElgbMGOttRqtrzUuOLYcsFZsAhEZAMKhP6vMEVNw
 ugXA==
X-Gm-Message-State: AOAM532ZBnP0q3n+T9YTVWvxIeAXfl84T9ywszpbIpixYa6k5Nhv5PP8
 tlhJ4p74BlMQcn/PJb1xX0s=
X-Google-Smtp-Source: ABdhPJzlDG5z/jwneHQe+Gy56zmcIiQjlk3cCKzARF175d58GjbcAuixAtHHERx3PCVRr/TXMWBn1A==
X-Received: by 2002:ac8:4a8c:: with SMTP id l12mr3634691qtq.7.1606318916838;
 Wed, 25 Nov 2020 07:41:56 -0800 (PST)
Received: from localhost.localdomain
 (209-6-208-110.s8556.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com.
 [209.6.208.110])
 by smtp.gmail.com with ESMTPSA id z88sm2800542qtd.46.2020.11.25.07.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2020 07:41:56 -0800 (PST)
Date: Wed, 25 Nov 2020 10:41:53 -0500
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/1] x86/tboot: Don't disable swiotlb when iommu is
 forced on
Message-ID: <20201125154153.GA29929@localhost.localdomain>
References: <20201125014124.4070776-1-baolu.lu@linux.intel.com>
 <160630605367.4096500.10722779964348157570.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <160630605367.4096500.10722779964348157570.b4-ty@kernel.org>
Cc: Ashok Raj <ashok.raj@intel.com>, catalin.marinas@arm.com, x86@kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Ning Sun <ning.sun@intel.com>, tboot-devel@lists.sourceforge.net,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Adrian Huang <ahuang12@lenovo.com>, Thomas Gleixner <tglx@linutronix.de>,
 kernel-team@android.com
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

On Wed, Nov 25, 2020 at 02:05:15PM +0000, Will Deacon wrote:
> On Wed, 25 Nov 2020 09:41:24 +0800, Lu Baolu wrote:
> > After commit 327d5b2fee91c ("iommu/vt-d: Allow 32bit devices to uses DMA
> > domain"), swiotbl could also be used for direct memory access if IOMMU
> > is enabled but a device is configured to pass through the DMA translation.
> > Keep swiotlb when IOMMU is forced on, otherwise, some devices won't work
> > if "iommu=pt" kernel parameter is used.
> 
> Applied to arm64 (for-next/iommu/fixes), thanks!
> 
> [1/1] x86/tboot: Don't disable swiotlb when iommu is forced on
>       https://git.kernel.org/arm64/c/e2be2a833ab5

But tboot never ran on ARM. It is a Intel specifc.

I think either me or Thomas should take this patch.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
