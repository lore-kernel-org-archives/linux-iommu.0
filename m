Return-Path: <SRS0=5Lc9=HM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E323CC433E6
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 18:04:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E50764DB1
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 18:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E50764DB1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03E4C6F78A
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 18:04:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S1CHmZ3S3zGJ for <iommu@archiver.kernel.org>;
	Wed, 10 Feb 2021 18:04:22 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id D55246F70E; Wed, 10 Feb 2021 18:04:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA9786F69E;
	Wed, 10 Feb 2021 18:04:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 833FDC0891;
	Wed, 10 Feb 2021 18:04:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 687DDC013A
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 18:04:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 562D1874C5
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 18:04:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v5DJjFw8fdAI for <iommu@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 18:04:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0A058874C3
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 18:04:08 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id l27so2524408qki.9
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 10:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=fn4OROpwcMvlPuFG0mr8IX6FA+jFG3+mu5LheKqkXo0=;
 b=iPiobhPwf6KAYITESCCZiytaCFr72WzGFqO5Krxg583eeHZJJswee2IVlHJuHVFk51
 hUWKXhD6qUJQZ9akF+hoJ0SBMSynl89auCrmXzGqpwVR8TTrOwLCakALhhncmc/31KKO
 w5cpzUSnU3cZ2kGIXac5w3JXTOg1uG5uRsLrYjb0siJVoMpiahMmcfRtKm3eynVnB77A
 qq+aY8bUIaIHuFg9y9XapEOc7TwpMRqaDXdJ3B4ZZnVPlh2aFbugjNjlrCgAvTvQbuiv
 8rQnonVEPXVhg74c+0AallmP+gLOo6xaV7ay5dZwzBUgW+9vToCfuh+GOlDUSGRfOBpQ
 oKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fn4OROpwcMvlPuFG0mr8IX6FA+jFG3+mu5LheKqkXo0=;
 b=hEsGrNfXNjTKdilRC2VBhorqGWfhMcSQAbVcKg9Z1uGScEf8rGt2vlgAHdaZsUANCR
 DyumlM9xJrU7qS2p9ZqDQjICQUAZpQ6PY6ac1KUo4YVe5cW0cxa4OQc9UjHKJ7bAaLj5
 VA9rESb2ynEv9ltkzsToNqS+gO2eCbnppzP12p7vTZDK3BvebirAxk8qu9k1ZeDqButc
 ypOTHz2tSrs2CykSCzSEbqzLFVA3DSA9kN76YF0ybiOURcqxf5b1UmTTBf/kGntIDO5b
 8nQM3AQ1YhyKcb+eYO1oR2py8Xe747eVJT0n3JJZaBA34JJmn3fIWTNEG61w0zYxKwYl
 hTlA==
X-Gm-Message-State: AOAM533D+8bfFuPYduyJW2pzTlnC4O5yzybmrObjHtxeyz3kCutY8npj
 vkji7pKcvGkthFE4wzEAgfdWRA==
X-Google-Smtp-Source: ABdhPJyf3nDN5LDKdSKYE48IyBU6XZ6U0kgAEb02GCT83X4HerFr5BHXcsaa/epIdRev4YLuR0GG8A==
X-Received: by 2002:a37:6f01:: with SMTP id k1mr4613354qkc.252.1612980247944; 
 Wed, 10 Feb 2021 10:04:07 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.115.133])
 by smtp.gmail.com with ESMTPSA id j46sm1828038qtk.1.2021.02.10.10.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Feb 2021 10:04:06 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1l9tqP-0068Ck-JW; Wed, 10 Feb 2021 14:04:05 -0400
Date: Wed, 10 Feb 2021 14:04:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory pin
Message-ID: <20210210180405.GP4718@ziepe.ca>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <a587bd61-9194-4b46-c122-8b4da7b941a8@redhat.com>
 <20210208183348.GV4718@ziepe.ca>
 <0dca000a6cd34d8183062466ba7d6eaf@hisilicon.com>
 <20210208213023.GZ4718@ziepe.ca>
 <0868d209d7424942a46d1238674cf75d@hisilicon.com>
 <20210209135331.GF4718@ziepe.ca>
 <2527b4ac8df14fa1b427bef65dace719@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2527b4ac8df14fa1b427bef65dace719@hisilicon.com>
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

On Tue, Feb 09, 2021 at 10:22:47PM +0000, Song Bao Hua (Barry Song) wrote:

> The problem is that SVA declares we can use any memory of a process
> to do I/O. And in real scenarios, we are unable to customize most
> applications to make them use the pool. So we are looking for some
> extension generically for applications such as Nginx, Ceph.

But those applications will suffer jitter even if their are using CPU
to do the same work. I fail to see why adding an accelerator suddenly
means the application owner will care about jitter introduced by
migration/etc.

Again in proper SVA it should be quite unlikely to take a fault caused
by something like migration, on the same likelyhood as the CPU. If
things are faulting so much this is a problem then I think it is a
system level problem with doing too much page motion.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
