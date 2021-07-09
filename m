Return-Path: <SRS0=6oxg=MB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585CFC07E99
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 13:35:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 029DC6115C
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 13:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029DC6115C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2B344228B;
	Fri,  9 Jul 2021 13:35:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zuElTLjIV2Wd; Fri,  9 Jul 2021 13:35:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 73C6A42280;
	Fri,  9 Jul 2021 13:35:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 461BFC001A;
	Fri,  9 Jul 2021 13:35:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18533C000E;
 Fri,  9 Jul 2021 13:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1486C605F2;
 Fri,  9 Jul 2021 13:35:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e1gN9qyjNdPp; Fri,  9 Jul 2021 13:35:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 59B10605F1;
 Fri,  9 Jul 2021 13:35:00 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id g16so2287729wrw.5;
 Fri, 09 Jul 2021 06:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=t65TrXzTgBuxjzSlReCJ6QpG572DUj+HfWyNKCca6RQ=;
 b=Qv9u1QO3unyqOyV+03hq9Cmoq1QrzoxfVVAd7ISz0ok0z9Rpsnwq9ac7yQr5tXIvdg
 F1Ef26HfLFcDnkOLRCNlLAKHQobxoFkOONkjkR1dEivTk7HTpcbpEYeprV93TwcJI+3U
 fr77d/5Fn0OULSLyjokgG82EDt8WSDXDEKtBY20hhKOA9e4IRNc7IEjOmlKy/eeADGXb
 SVWZOibV9YWG8aNfVf6JY4skMyS5KY4DAheMHH2aZmfDw/Q9KbKIKrr9vT1N8ylbIUdt
 UHY6SHlve53BLI2bcFnI1mOz+cZ0XswS76d07nzZpmaKs7MQfVr3P+LA6JeQSg93TSzn
 68CQ==
X-Gm-Message-State: AOAM5337lfcdqemn75GTdW7aw6vyVVPmI74qulcTU70Ir/wnoUX3vhm7
 qSyxG5V5Z8gz0vH7hcBsEa4=
X-Google-Smtp-Source: ABdhPJzHHNK5AYPEu+qwIR4GYzqj1yEC+9+CdEccFDeVhjdj+9HVf35OD8XaFW5bR5NKmUQP2/tU3w==
X-Received: by 2002:a5d:5751:: with SMTP id q17mr13896201wrw.18.1625837698522; 
 Fri, 09 Jul 2021 06:34:58 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
 by smtp.gmail.com with ESMTPSA id b20sm5067213wmj.7.2021.07.09.06.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jul 2021 06:34:58 -0700 (PDT)
Date: Fri, 9 Jul 2021 13:34:56 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC v1 6/8] mshv: command line option to skip devices in PV-IOMMU
Message-ID: <20210709133456.awctvxgtivjo6fuj@liuwe-devbox-debian-v2>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-7-wei.liu@kernel.org>
 <1c839a00-0f5f-fdfa-cfb3-f345bef9f849@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1c839a00-0f5f-fdfa-cfb3-f345bef9f849@arm.com>
Cc: Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 pasha.tatashin@soleen.com, kumarpraveen@linux.microsoft.com,
 Vineeth Pillai <viremana@linux.microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Will Deacon <will@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Michael Kelley <mikelley@microsoft.com>
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

On Fri, Jul 09, 2021 at 01:46:19PM +0100, Robin Murphy wrote:
> On 2021-07-09 12:43, Wei Liu wrote:
> > Some devices may have been claimed by the hypervisor already. One such
> > example is a user can assign a NIC for debugging purpose.
> > 
> > Ideally Linux should be able to tell retrieve that information, but
> > there is no way to do that yet. And designing that new mechanism is
> > going to take time.
> > 
> > Provide a command line option for skipping devices. This is a stopgap
> > solution, so it is intentionally undocumented. Hopefully we can retire
> > it in the future.
> 
> Huh? If the host is using a device, why the heck is it exposing any
> knowledge of that device to the guest at all, let alone allowing the guest
> to do anything that could affect its operation!?

The host in this setup consists of the hypervisor, the root kernel and a
bunch of user space programs.

Root is not an ordinary guest. It does need to know all the hardware to
manage the platform. Hypervisor does not claim more devices than it
needs to, nor does it try to hide hardware details from the root.

The hypervisor can protect itself just fine. Any attempt to use the
already claimed devices will be blocked or rejected, so are the attempts
to attach them to device domains.

That, however, leads to some interesting interactions between the
hypervisor and Linux kernel.  When kernel initializes IOMMU during boot,
it will try to attach all devices in one go. Any failure there will
cause kernel to detach the already attached devices. That's not fatal to
kernel, and is only a minor annoyance to our current use case, because
the default domain is a passthrough domain anyway. It will become
problematic once we switch the default domain to a DMA domain to further
tighten security during Linux boot.

Wei.

> 
> Robin.
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
