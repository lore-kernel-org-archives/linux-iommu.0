Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFBEC4741F
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 01:13:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA97208C7
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 01:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZuDSndO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA97208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8101284115;
	Fri,  2 Oct 2020 01:13:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1N35ubjKBo+l; Fri,  2 Oct 2020 01:13:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 239AC84483;
	Fri,  2 Oct 2020 01:13:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A177C016F;
	Fri,  2 Oct 2020 01:13:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2264C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 01:13:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B68CA84483
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 01:13:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9GD4cGL0F7+r for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 01:13:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 13E5E84115
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 01:13:44 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id h23so30289pjv.5
 for <iommu@lists.linux-foundation.org>; Thu, 01 Oct 2020 18:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=cyj5bDIyFJEfsZsMox4XldvwN5w3gjkgLZSeBDyADL0=;
 b=VZuDSndO9n7HwRbuSpii2V7aBh35rBSo8cv4IVZ7C8HWKMHbFFR9nTIhXEKL7kWdHD
 iNC+1BgH/LoZ6P/GuM3ZQdQxa+vw3Yw7dz52aY2m9nJqVfONyfee6/+OgM3LxGhJ8C1U
 jdfgwF0SeNDbeNyio7znl0KM8vxNrSETZ2X0gNUmNMZnLgq8xiNvVyYREU59RJBuQQRn
 pNlXu6PG2igAr0ANQdxSu9C3wfppiZZADUyn6+tRLdvJ6QdqaRUNZW4AoqNswg/2q+6n
 zLHJJJhkl+Xaob5gh/hxq+udZ1boCCneH/ZgvN1QsvEulfF7bwsKnk9zDsBG5qPvxhGQ
 teRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=cyj5bDIyFJEfsZsMox4XldvwN5w3gjkgLZSeBDyADL0=;
 b=HzbSY9dKSEsHMoal4O2pd4veXfAJLpI5zVD+xVngOvmwMX1Q7VgeHF8MZVyUtK4/xw
 mincilU6XkzM2VVKYakoCUqPDGqUI+LZmMhyUHvaYaMDeoRXAgoaWyJPxm+Ylk5c+hfk
 FsJ5zCBH1Og9WbqL0VLzU5UjA3GFTaIt4b8u+M8mIJmwv25QXfExULaiGf2bRY1aNOk4
 FL5jUw+0NPO7azddLibENuBa77WUIo+QbQyzA2Bdos/sxYU5OX2ear7Q5SsNNZ79V2tl
 +sYOzxhRb8v2CLe7hb0FVsUiMZqipreCWpRAhC/XsWe2MJxejL/oXX2s2R81lw56fVOA
 UipA==
X-Gm-Message-State: AOAM531innI4wNXwW+VEvMTPRjdOCIlh6HaCihHksyDKE10dxeVZ2ufZ
 rB9RDaUcYHT6MxNXKgWSIK4=
X-Google-Smtp-Source: ABdhPJy1SQt9uw+QkCOsb9zaS5rHccdp+czF4vyWwr65WJMYUl078ivr6S9KMegcra/3a90mC1GJfw==
X-Received: by 2002:a17:90a:ea0a:: with SMTP id
 w10mr69467pjy.165.1601601223488; 
 Thu, 01 Oct 2020 18:13:43 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id a2sm7755053pfk.201.2020.10.01.18.13.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 01 Oct 2020 18:13:43 -0700 (PDT)
Date: Thu, 1 Oct 2020 18:07:51 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20201002010751.GA26971@Asurada-Nvidia>
References: <20200930203618.GC2110@Asurada-Nvidia>
 <13746922-0253-cda7-e9ac-2bd20bf1a17f@gmail.com>
 <20200930213244.GA10573@Asurada-Nvidia>
 <5945a63e-79d8-e3ae-ab53-cee8c220ac7d@gmail.com>
 <20201001012630.GA28240@Asurada-Nvidia>
 <72b11925-5857-8ce5-d084-cab01ca1b396@gmail.com>
 <20201001024850.GA28456@Asurada-Nvidia>
 <20201001102316.GF3919720@ulmo> <20201001110425.GB1272@Asurada>
 <b966844e-4289-3ff0-9512-852f8419a664@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b966844e-4289-3ff0-9512-852f8419a664@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org
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

On Thu, Oct 01, 2020 at 11:33:38PM +0300, Dmitry Osipenko wrote:
> >>> If we can't come to an agreement on globalizing mc pointer, would
> >>> it be possible to pass tegra_mc_driver through tegra_smmu_probe()
> >>> so we can continue to use driver_find_device_by_fwnode() as v1?
> >>>
> >>> v1: https://lkml.org/lkml/2020/9/26/68
> >>
> >> tegra_smmu_probe() already takes a struct tegra_mc *. Did you mean
> >> tegra_smmu_probe_device()? I don't think we can do that because it isn't
> > 
> > I was saying to have a global parent_driver pointer: similar to
> > my v1, yet rather than "extern" the tegra_mc_driver, we pass it
> > through egra_smmu_probe() and store it in a static global value
> > so as to call tegra_smmu_get_by_fwnode() in ->probe_device().
> > 
> > Though I agree that creating a global device pointer (mc) might
> > be controversial, yet having a global parent_driver pointer may
> > not be against the rule, considering that it is common in iommu
> > drivers to call driver_find_device_by_fwnode in probe_device().
> 
> You don't need the global pointer if you have SMMU OF node.
> 
> You could also get driver pointer from mc->dev->driver.
> 
> But I don't think you need to do this at all. The probe_device() could
> be invoked only for the tegra_smmu_ops and then seems you could use
> dev_iommu_priv_set() in tegra_smmu_of_xlate(), like sun50i-iommu driver
> does.

Getting iommu device pointer using driver_find_device_by_fwnode()
is a common practice in ->probe_device() of other iommu drivers.
But this requires a device_driver pointer that tegra-smmu doesn't
have. So passing tegra_mc_driver through tegra_smmu_probe() will
address it.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
