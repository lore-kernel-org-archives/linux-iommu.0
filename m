Return-Path: <SRS0=UfkB=G5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B61C4332D
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 18:27:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3CE8207C8
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 18:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CE8207C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 26CB1204D0;
	Tue, 26 Jan 2021 18:27:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XUs-J09BREeP; Tue, 26 Jan 2021 18:27:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A258E204AF;
	Tue, 26 Jan 2021 18:27:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 602A7C0FA7;
	Tue, 26 Jan 2021 18:27:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EA98C013A
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 18:27:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 99AE686657
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 18:27:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qBMjL4gv9ZN6 for <iommu@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 18:27:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D12FD863D5
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 18:27:33 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id t14so9332945qto.8
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 10:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3pcCknD/BxtIB8RBkZo8Cp7IF2+vwd74k7zS24kTbR8=;
 b=g4dYrV4PaU2nmFT29+g3Rzm5JnSUd20A1ZWJ6EdcZinlf0+ZNWNonkfVQ6Dp3gXNCM
 iJu2ORFJvR2ymNl1/WjeVn9tUusJv6B/KvgegcBmQ+lLLD9FbefZpf21si64F1aicoOd
 TuRy802BItwrexCICDhtbGPbzg6DJN4LdRpJN7tiwQrpEsyHaBUXEq3AfaOQslLRuF5e
 xmnc145bBdMdUKni1AZrxpkAvtY0ZQoozUmrlJqyHo2l4q/WuLLfAxAj+BFYkFP1drk5
 cjVu7ZEjWMrDw+WqzYGeymS4FdQsB1s+TzvrnDOUgLArhdfwXDigOGQ/NLrHQa+OwxGj
 HAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3pcCknD/BxtIB8RBkZo8Cp7IF2+vwd74k7zS24kTbR8=;
 b=uZJXOQ0hCRietu+9IqJ4UaG8bcyfEj1SGZNt5lDj0ygOMIiAl6rgNhSB3S5nlOp4FD
 qepUAAEOPZFmhuCILT+PQ5tflZkvKfwJysOES1asS30vaN83+uAq/X42mHMRx6eBN3jQ
 NedIXiUcIKlwEqKtWZXXlqc+N6/K/e/VR7JGRmRX7W+XIDawRFgthSBf58PG4OCsYEK3
 G4YwyO7bixBBucjZV01uKPcMgmPcSV+IfRVgX7qc/GppWuKBa1kJEwaU4lBi6MebX8oh
 FfLWeEwgV3abSRSBhs5e5bzcKx//qz2a5lUCYy1LbPnxXkfKkaDeqdRPpAqWgZmxfG7Y
 HOlQ==
X-Gm-Message-State: AOAM532Ktpqb6MTYK2n00I55hUS8OVfscs2CuXCcFCf4dbf8d/1XNrw+
 bxvcC1NKc7CC/OEe5mkgFjxA2YpLSWmOd9GI
X-Google-Smtp-Source: ABdhPJyv228KfIjwwkPqso1SD69kZ5ZLPyWizKOSKwm7PPgZ1vF7s3nuEYfyIbVsj4pXarwA8sS6PA==
X-Received: by 2002:a37:bc8:: with SMTP id 191mr7214911qkl.384.1611685225677; 
 Tue, 26 Jan 2021 10:20:25 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.115.133])
 by smtp.gmail.com with ESMTPSA id x72sm12135585qka.51.2021.01.26.10.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jan 2021 10:20:25 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1l4Swy-0078zV-Bj; Tue, 26 Jan 2021 14:20:24 -0400
Date: Tue, 26 Jan 2021 14:20:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Subject: Re: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Message-ID: <20210126182024.GA4605@ziepe.ca>
References: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
 <20210125154717.GW4605@ziepe.ca>
 <96b655ade2534a65974a378bb68383ee@hisilicon.com>
 <20210125231619.GY4605@ziepe.ca>
 <5f64a68042c64f37b5cba74028bd2189@hisilicon.com>
 <20210126011304.GZ4605@ziepe.ca>
 <d7fce136c3644755a7aea5794bddf453@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d7fce136c3644755a7aea5794bddf453@hisilicon.com>
Cc: "chensihang \(A\)" <chensihang1@hisilicon.com>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Zhangfei Gao <zhangfei.gao@linaro.org>,
 "Liguozhu \(Kenneth\)" <liguozhu@hisilicon.com>,
 "linux-accelerators@lists.ozlabs.org" <linux-accelerators@lists.ozlabs.org>
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

On Tue, Jan 26, 2021 at 01:26:45AM +0000, Song Bao Hua (Barry Song) wrote:
> > On Mon, Jan 25, 2021 at 11:35:22PM +0000, Song Bao Hua (Barry Song) wrote:
> > 
> > > > On Mon, Jan 25, 2021 at 10:21:14PM +0000, Song Bao Hua (Barry Song) wrote:
> > > > > mlock, while certainly be able to prevent swapping out, it won't
> > > > > be able to stop page moving due to:
> > > > > * memory compaction in alloc_pages()
> > > > > * making huge pages
> > > > > * numa balance
> > > > > * memory compaction in CMA
> > > >
> > > > Enabling those things is a major reason to have SVA device in the
> > > > first place, providing a SW API to turn it all off seems like the
> > > > wrong direction.
> > >
> > > I wouldn't say this is a major reason to have SVA. If we read the
> > > history of SVA and papers, people would think easy programming due
> > > to data struct sharing between cpu and device, and process space
> > > isolation in device would be the major reasons for SVA. SVA also
> > > declares it supports zero-copy while zero-copy doesn't necessarily
> > > depend on SVA.
> > 
> > Once you have to explicitly make system calls to declare memory under
> > IO, you loose all of that.
> > 
> > Since you've asked the app to be explicit about the DMAs it intends to
> > do, there is not really much reason to use SVA for those DMAs anymore.
> 
> Let's see a non-SVA case. We are not using SVA, we can have
> a memory pool by hugetlb or pin, and app can allocate memory
> from this pool, and get stable I/O performance on the memory
> from the pool. But device has its separate page table which
> is not bound with this process, thus lacking the protection
> of process space isolation. Plus, CPU and device are using
> different address.

So you are relying on the platform to do the SVA for the device?

This feels like it goes back to another topic where I felt the SVA
setup uAPI should be shared and not buried into every driver's unique
ioctls.

Having something like this in a shared SVA system is somewhat less
strange.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
