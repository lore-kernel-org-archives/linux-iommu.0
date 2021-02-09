Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2612C433DB
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 13:53:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E86B564EE1
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 13:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86B564EE1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8F0148539A;
	Tue,  9 Feb 2021 13:53:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xhUt0BBUXtI3; Tue,  9 Feb 2021 13:53:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 08C3B85F81;
	Tue,  9 Feb 2021 13:53:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D810CC0891;
	Tue,  9 Feb 2021 13:53:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 969BDC013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 13:53:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9299F85F81
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 13:53:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YfWyRkuDifLt for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 13:53:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B017C8539A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 13:53:33 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id h8so7690029qkk.6
 for <iommu@lists.linux-foundation.org>; Tue, 09 Feb 2021 05:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=T8f8DDfwXSd9VRLmEP8P3umzAghI6Kqw6/qy/jeS5Qo=;
 b=gh04iuWWyfXXLlaV1RWSVt6ZQHHbXgL+7SqTdgohcZssGB7SFCglc2Da1zz58QYygR
 9tVoLF0GKpMU5fAKOJUQeZbKmiZNBpriOh6NJ88Z8/8Oiy+02484H0DfDsD9oLpEdCJB
 iqbllGJHAulzwrFuz8zaWKtRoDWR91pkLeY3goABlW/bNnl7a7ucWFWFLWHoTWeFdCfi
 E81odK7NiX2mIG23/RyV6fotvVvwHXBJ3/Y6NQ+7HvCiAyAGmRSY3kUdW52i458n5RX4
 NyglMvima/h3o9mIMHNuMfUszee7pZjUtNzI0o4O78Zz7zTTtKPysaZeIPpMxYD972RH
 nQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=T8f8DDfwXSd9VRLmEP8P3umzAghI6Kqw6/qy/jeS5Qo=;
 b=qNnqq+9eYi5RomRqj/bjaZC8j1te63YrGvEVR9fD/ukFolVanq363MR6utrXS4eSv7
 Ust5I4AGlz3NXWFaZRUTUeIr1vpeY/ABIBPbH4osWRRFW4iz1ke+ptMnrb0knt7qb6Pw
 cIuYfO5fquMjMpOaMzneLwp2roWP3KfiNjiAkamq8ySNuFzJuq7FC+6g6ZM0cwnfiY5o
 +R11SR+KJan8dqTUJ48v/I033YPT2zkX93zkfvF+BVzC4lOYpXY3Jom549sTQaesUwCZ
 FQ7HyrkYBu4O1Gx1/JFSU+eXu1J8qZfGTKvK5dGPIB5a9EwECArl7S8SN2mRQDRo9I1F
 XG2A==
X-Gm-Message-State: AOAM532wpL6X6O/cYnrO+57bYtTM9ede6Mrwyq8/2R1ohWka56DUQINp
 3zGo9ALpSdRMR9gp5bF64hQf+A==
X-Google-Smtp-Source: ABdhPJx3et279cgNvk+uqR894IQLoOIQFoSZDGEjQvDKhVHg09126LSd7Y8VSphbQdCDRlOdHVR86w==
X-Received: by 2002:ae9:e80e:: with SMTP id a14mr11633708qkg.103.1612878812715; 
 Tue, 09 Feb 2021 05:53:32 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.115.133])
 by smtp.gmail.com with ESMTPSA id d16sm17820271qka.44.2021.02.09.05.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Feb 2021 05:53:32 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1l9TSN-005RZu-ON; Tue, 09 Feb 2021 09:53:31 -0400
Date: Tue, 9 Feb 2021 09:53:31 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory pin
Message-ID: <20210209135331.GF4718@ziepe.ca>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <a587bd61-9194-4b46-c122-8b4da7b941a8@redhat.com>
 <20210208183348.GV4718@ziepe.ca>
 <0dca000a6cd34d8183062466ba7d6eaf@hisilicon.com>
 <20210208213023.GZ4718@ziepe.ca>
 <0868d209d7424942a46d1238674cf75d@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0868d209d7424942a46d1238674cf75d@hisilicon.com>
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "chensihang \(A\)" <chensihang1@hisilicon.com>,
 David Hildenbrand <david@redhat.com>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Feb 09, 2021 at 03:01:42AM +0000, Song Bao Hua (Barry Song) wrote:

> On the other hand, wouldn't it be the benefit of hardware accelerators
> to have a lower and more stable latency zip/encryption than CPU?

No, I don't think so.

If this is an important problem then it should apply equally to CPU
and IO jitter.

Honestly I find the idea that occasional migration jitters CPU and DMA
to not be very compelling. Such specialized applications should
allocate special pages to avoid this, not adding an API to be able to
lock down any page
 
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
