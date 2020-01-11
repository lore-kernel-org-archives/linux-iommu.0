Return-Path: <SRS0=xAAD=3A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D5EC33C9E
	for <iommu@archiver.kernel.org>; Sat, 11 Jan 2020 05:52:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 228592077C
	for <iommu@archiver.kernel.org>; Sat, 11 Jan 2020 05:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="K0QbsSu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228592077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D79D986BC2;
	Sat, 11 Jan 2020 05:52:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nA3iu_fvjTns; Sat, 11 Jan 2020 05:52:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3CB0186BAE;
	Sat, 11 Jan 2020 05:52:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CFB4C1D80;
	Sat, 11 Jan 2020 05:52:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CEAFC0881
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jan 2020 05:52:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 01B8286D29
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jan 2020 05:52:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6fPq-y5oll2f for <iommu@lists.linux-foundation.org>;
 Sat, 11 Jan 2020 05:52:22 +0000 (UTC)
X-Greylist: delayed 00:55:38 by SQLgrey-1.7.6
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E633E86838
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jan 2020 05:52:22 +0000 (UTC)
Received: by mail-pj1-f74.google.com with SMTP id z12so2536651pju.0
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 21:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=RjLzBv4qlo+z7GYjo6uSKDnHrbZe99ibYMQ8E0CYwHw=;
 b=K0QbsSu9JkSBJauq5SjLqo6PxvRTkqJsdB2vro3IKA1ZG8/ckNrvFMDL0SFIQB58t7
 5LDzHFXI7cdYhOTuNUneLFBT83kHI5SmNQ2M9LjhLBuZBpvhRuKFUya/sSZ4OGyqVzo4
 O3eJr0WcfVpg0aDjqZDBEJgLpPAEdVA72EmoflXIRUCp+ryA6TbEDWt9XCO847V5v01P
 Jpzbdu/r+e7UAo4Id9d+rEHxJsJFS5Q4Zlzo/3P8VxNlUWQ5JVgXzswIWioMcVm0ep06
 oexphr6+T1IfwVGVCHIA5cUeqr+EH9BGhFdiIrNcnxWzZ9bAEi6HkhDfCul0USbieNL0
 5Vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=RjLzBv4qlo+z7GYjo6uSKDnHrbZe99ibYMQ8E0CYwHw=;
 b=tazhAY0Se3Pb0QMd3neJp36eBLQyKNCZt4MbaJdZDV3sOBp0XwnIXxxegEwLolTgE5
 F2K8VPUR7wSacZ7K+73/NOcl9y8pQUSP+1GOApVvCqwPABcGDhTtTvh5hwn9NDY55iNx
 HP4m1iU12ECdxkzBukfOSHUVLQS8e4W13c8PPH7qKp7kvbI3pJHD02KSFtmSdzTabsbh
 gulcwWyro7DGvVrWoyGPdOIPadf7t9om5SzboTzmypEPyPxbyIPuZUt3veK+JlRDMtDf
 HSLqujDrheJ8VopKvH1eirfTz7y5E59yHqlboqOnplQsrQHHJeKgOZxzrLdMkY3D706n
 Bp5g==
X-Gm-Message-State: APjAAAXLakxPMlJIxQV5nbw3rG4D6pCgePGAJVAtw05VgU2LCmRkLOPB
 5pxnM/TMKYEZ0WDn/1m4kq7zMcFIVPEy2EA=
X-Google-Smtp-Source: APXvYqzKmsGlqJpeihD7vxzuMcgio6xYtq4QElmTQfynt8iK9bmE01b6bbQij88VWMmN1+xvy6ZrRXWGp8DXKA8=
X-Received: by 2002:a63:8041:: with SMTP id j62mr8822576pgd.41.1578718603417; 
 Fri, 10 Jan 2020 20:56:43 -0800 (PST)
Date: Fri, 10 Jan 2020 20:56:39 -0800
In-Reply-To: <20191209150748.2471814-1-thierry.reding@gmail.com>
Message-Id: <20200111045639.210486-1-saravanak@google.com>
Mime-Version: 1.0
References: <20191209150748.2471814-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: Re: [RFC 0/2] iommu: arm-smmu: Add support for early direct mappings
To: thierry.reding@gmail.com
Cc: kernel-team@android.com, Saravana Kannan <saravanak@google.com>,
 Patrick Daly <pdaly@codeaurora.org>, robin.murphy@arm.com,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, Pratik Patel <pratikp@codeaurora.org>
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
From: Saravana Kannan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Thierry,

I happened upon this thread while looking into another thread [1].

> From: Thierry Reding <treding@nvidia.com>
> 
> On some platforms, the firmware will setup hardware to read from a given
> region of memory. One such example is a display controller that is
> scanning out a splash screen from physical memory.
> 
> During Linux' boot process, the ARM SMMU will configure all contexts to
> fault by default. This means that memory accesses that happen by an SMMU
> master before its driver has had a chance to properly set up the IOMMU
> will cause a fault. This is especially annoying for something like the
> display controller scanning out a splash screen because the faults will
> result in the display controller getting bogus data (all-ones on Tegra)
> and since it repeatedly scans that framebuffer, it will keep triggering
> such faults and spam the boot log with them.

While I'm not an expert on IOMMUs, I have a decent high level
understanding of the problem you are trying to solve.

> In order to work around such problems, scan the device tree for IOMMU
> masters and set up a special identity domain that will map 1:1 all of
> the reserved regions associated with them. This happens before the SMMU
> is enabled, so that the mappings are already set up before translations
> begin.

I'm not sure if this RFC will solve the splash screen issue across SoCs
([1] seems to have a different issue and might not have memory-regions).

> One thing that was pointed out earlier, and which I don't have a good
> idea on how to solve it, is that the early identity domain is not
> discarded. The assumption is that the standard direct mappings code of
> the IOMMU framework will replace the early identity domain once devices
> are properly attached to domains, but we don't have a good point in time
> when it would be safe to remove the early identity domain.

You are in luck! I added sync_state() driver callbacks [2] exactly for
cases like this. Heck, I even listed IOMMUs as an example use case. :)
sync_state() works even with modules if one enables of_devlink [3] kernel
parameter (which already supports iommus DT bindings). I'd be happy to
answer any question you have on sync_state() and of_devlink.

> One option that I can think of would be to create an early identity
> domain for each master and inherit it when that master is attached to
> the domain later on, but that seems rather complicated from an book-
> keeping point of view and tricky because we need to be careful not to
> map regions twice, etc.
> 
> Any good ideas on how to solve this? It'd also be interesting to see if
> there's a more generic way of doing this. I know that something like
> this isn't necessary on earlier Tegra SoCs with the custom Tegra SMMU
> because translations are only enabled when the devices are attached to a
> domain.

Good foresight. As [1] shows, identity mapping doesn't solve it in a
generic way.

How about actually reading the current settings/mappings and just
inheriting that instead of always doing a 1:1 identity mapping? And then
those "inherited" mappings can be dropped when you get a sync_state().
What's wrong with that option?

Cheers,
Saravana

[1] https://lore.kernel.org/linux-arm-msm/20200108091641.GA15147@willie-the-truck/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/driver-api/driver-model/driver.rst#n172
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt#n3239
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
