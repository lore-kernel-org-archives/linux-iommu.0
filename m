Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73799CCA473
	for <iommu@archiver.kernel.org>; Mon, 27 Jun 2022 14:02:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F16844195B;
	Mon, 27 Jun 2022 14:02:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F16844195B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ZV1HzTDR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z4sVXUUT_Yuf; Mon, 27 Jun 2022 14:02:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9C26741959;
	Mon, 27 Jun 2022 14:02:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C26741959
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C18AC0032;
	Mon, 27 Jun 2022 14:02:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22102C002D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 14:02:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D95D24195B
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 14:02:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D95D24195B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VxEtWmR1gcXQ for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 14:02:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8FC0C41959
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8FC0C41959
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 14:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=BpEvF0BzklG8G9XjSPP96oVb/MAS3WNPpABfNhe5u5s=; b=ZV1HzTDRRvvaBT0EJFa4US4l4F
 GHea9PgpyHfJqxTevWsYuYnrsgtVy9qh9+rPGLXlDi5Dei3SciLj7YfCl/o2/O0HsBqJyMkC8xkpl
 Xh88cl/xkod+OM8+U/Is97UoRJr0ObUiAcWofUjeB19Rlil3RdV67Z1VcUj+rBVZERJSYgoYMr/J5
 C2eaahpLR+mgEQZZ+g3OvEQsT6JBsMs7TxjWMNjL3aklnutRHkh5j/FOUPM6Az+bLYno2OoY+j769
 mHTtQqN4tzH8GcVbCiF20H4rKSiqdZGeH04LYb9DpDLA3iVBjz098WeniRwPEEBbD7+dR9dHW5XzL
 l8+9JBmg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1o5pJ1-00BPhR-AX; Mon, 27 Jun 2022 14:01:35 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC4D230040C;
 Mon, 27 Jun 2022 16:01:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id BE20C29BEB0F7; Mon, 27 Jun 2022 16:01:31 +0200 (CEST)
Date: Mon, 27 Jun 2022 16:01:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yicong Yang <yangyicong@huawei.com>
Subject: Re: [PATCH v9 0/8] Add support for HiSilicon PCIe Tune and Trace
 device
Message-ID: <Yrm4O+AFbgnoBVba@hirez.programming.kicks-ass.net>
References: <20220606115555.41103-1-yangyicong@hisilicon.com>
 <af6723f1-c0c5-8af5-857c-af9280e705af@huawei.com>
 <Yrms2cI05O2yZRKU@kroah.com>
 <e737393a-56dd-7d24-33d3-e935b14ba758@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e737393a-56dd-7d24-33d3-e935b14ba758@huawei.com>
Cc: mark.rutland@arm.com, prime.zeng@huawei.com,
 alexander.shishkin@linux.intel.com, linux-pci@vger.kernel.org,
 linuxarm@huawei.com, yangyicong@hisilicon.com, james.clark@arm.com,
 will@kernel.org, mingo@redhat.com, helgaas@kernel.org, liuqi115@huawei.com,
 suzuki.poulose@arm.com, acme@kernel.org, zhangshaokun@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
 Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org,
 leo.yan@linaro.org, robin.murphy@arm.com
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

On Mon, Jun 27, 2022 at 09:25:42PM +0800, Yicong Yang wrote:
> On 2022/6/27 21:12, Greg KH wrote:
> > On Mon, Jun 27, 2022 at 07:18:12PM +0800, Yicong Yang wrote:
> >> Hi Greg,
> >>
> >> Since the kernel side of this device has been reviewed for 8 versions with
> >> all comments addressed and no more comment since v9 posted in 5.19-rc1,
> >> is it ok to merge it first (for Patch 1-3 and 7-8)?
> > 
> > I am not the maintainer of this subsystem, so I do not understand why
> > you are asking me :(
> > 
> 
> I checked the log of drivers/hwtracing and seems patches of coresight/intel_th/stm
> applied by different maintainers and I see you applied some patches of intel_th/stm.
> Should any of these three maintainers or you can help applied this?

I was hoping Mark would have a look, since he knows this ARM stuff
better than me. But ISTR he's somewhat busy atm too. But an ACK from the
CoreSight people would also be appreciated.

And Arnaldo usually doesn't pick up the userspace perf bits until the
kernel side is sorted.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
