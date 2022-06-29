Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722EBC43334
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 16:44:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF6EC612BF;
	Wed, 29 Jun 2022 16:44:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EF6EC612BF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=E37c3grA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uqYbMgii1PWP; Wed, 29 Jun 2022 16:44:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2F2CF60C33;
	Wed, 29 Jun 2022 16:44:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F2CF60C33
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00A54C0032;
	Wed, 29 Jun 2022 16:44:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E569EC002D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 16:44:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B8CC540C5C
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 16:44:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B8CC540C5C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=E37c3grA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xh1tbdhDPAns for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 16:44:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0BFC940201
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0BFC940201
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 16:44:01 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id r66so15856239pgr.2
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 09:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=H6SDMsRMBFpIBVc64uIxAbw8HhGrz6w0VpurvPOqgsM=;
 b=E37c3grA1rBzm//lFsHFq0a6MEvdOJph9uYs3FQO1S8A6X3GdkgNphhA/C6P2kfvHI
 Z9lg3Mz12GVOO2ZhjOOKzktWjASYcaNGpIqcqxP190j8kEnP4ALnkN4Pr4WvOiO5a2qz
 +fPd3kGXalda8Z0nnf7k1O/MWlnMqVX3Vi379rTIfoUXcJq0QwGwES99n41Ui8zMsPeO
 I7qpItVN6Z8/GhxF5R/7Nka26QL1rRbcIvXROtDXJyqfS5Zw6ZRt0EXbmLr9V0dYI++w
 By5gG0xbyAEEhB1NwmMbVUPTjqUnazp5q43Fx4MkLYKlFj+P7IeotiTuwMt/bsLVuNL6
 Li+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=H6SDMsRMBFpIBVc64uIxAbw8HhGrz6w0VpurvPOqgsM=;
 b=eGuCXEzet3l34USDWx6XaWpXymWJo5qc21uh9L5rtxnROJ1yKF6GwjRbAAIYu8Q+hC
 cL3VB6DeRVcUaDwbmDLmrm+5L3wISSQBv0nM4c0AuRwbRqWunRcgHhRBw1HgoIvULeO3
 TYzhB5voFBrzoG9b8dzoJjEyL6YjuBfEO+ImVW3CwNl+SXI02IJO3tr2Rqi6DvWIvEEU
 bowIdLK9VlKJdntw4gu7bPY8A0Y1DHIUxEfAz9K7hraoxFnrWleU7LTIT4gHLszazyJj
 bVA+5ovYaTndNnziewKUMon6M0QkfspIJVKAz9SfDQj3eBbRL9xMxB9haeCpXxpFjt0A
 CuKg==
X-Gm-Message-State: AJIora/J8UN/aAaA/7rftxmogW8Ewb5KG6QjYTiWQGvVKq3V4Fk35nkG
 BtGQgZ/WP+bL48U8ekveb4+Zuw==
X-Google-Smtp-Source: AGRyM1v+C9A3jaRc2Q1KV6w1TvaLeuYysn0eCdaDGnMabgdtlVm1AV+vGXDLImhGSxwXKw+9L5UhTA==
X-Received: by 2002:a63:fa56:0:b0:3fc:d3d2:ceac with SMTP id
 g22-20020a63fa56000000b003fcd3d2ceacmr3778194pgk.99.1656521041434; 
 Wed, 29 Jun 2022 09:44:01 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
 by smtp.gmail.com with ESMTPSA id
 cu7-20020a056a00448700b00525373aac7csm11665197pfb.26.2022.06.29.09.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jun 2022 09:44:00 -0700 (PDT)
Date: Wed, 29 Jun 2022 10:43:57 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v9 0/8] Add support for HiSilicon PCIe Tune and Trace
 device
Message-ID: <20220629164357.GA2018382@p14s>
References: <20220606115555.41103-1-yangyicong@hisilicon.com>
 <af6723f1-c0c5-8af5-857c-af9280e705af@huawei.com>
 <Yrms2cI05O2yZRKU@kroah.com>
 <e737393a-56dd-7d24-33d3-e935b14ba758@huawei.com>
 <Yrm4O+AFbgnoBVba@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yrm4O+AFbgnoBVba@hirez.programming.kicks-ass.net>
Cc: mark.rutland@arm.com, prime.zeng@huawei.com,
 alexander.shishkin@linux.intel.com, linux-pci@vger.kernel.org,
 linuxarm@huawei.com, yangyicong@hisilicon.com, james.clark@arm.com,
 will@kernel.org, mingo@redhat.com, helgaas@kernel.org, liuqi115@huawei.com,
 suzuki.poulose@arm.com, acme@kernel.org, zhangshaokun@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, Greg KH <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 iommu@lists.linux-foundation.org, leo.yan@linaro.org,
 Yicong Yang <yangyicong@huawei.com>, robin.murphy@arm.com
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

On Mon, Jun 27, 2022 at 04:01:31PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 27, 2022 at 09:25:42PM +0800, Yicong Yang wrote:
> > On 2022/6/27 21:12, Greg KH wrote:
> > > On Mon, Jun 27, 2022 at 07:18:12PM +0800, Yicong Yang wrote:
> > >> Hi Greg,
> > >>
> > >> Since the kernel side of this device has been reviewed for 8 versions with
> > >> all comments addressed and no more comment since v9 posted in 5.19-rc1,
> > >> is it ok to merge it first (for Patch 1-3 and 7-8)?
> > > 
> > > I am not the maintainer of this subsystem, so I do not understand why
> > > you are asking me :(
> > > 
> > 
> > I checked the log of drivers/hwtracing and seems patches of coresight/intel_th/stm
> > applied by different maintainers and I see you applied some patches of intel_th/stm.
> > Should any of these three maintainers or you can help applied this?
> 
> I was hoping Mark would have a look, since he knows this ARM stuff
> better than me. But ISTR he's somewhat busy atm too. But an ACK from the
> CoreSight people would also be appreciated.
>

I'll spend some time on it next week.

Thanks,
Mathieu

> And Arnaldo usually doesn't pick up the userspace perf bits until the
> kernel side is sorted.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
