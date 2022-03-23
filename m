Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1F6C433EF
	for <iommu@archiver.kernel.org>; Wed, 23 Mar 2022 22:15:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73A6460BBA;
	Wed, 23 Mar 2022 22:15:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BpYuXcVp-ZWW; Wed, 23 Mar 2022 22:15:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AFD0060B38;
	Wed, 23 Mar 2022 22:15:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 703D4C0012;
	Wed, 23 Mar 2022 22:15:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E664C000B
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 22:15:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F625849B0
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 22:15:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=canonical.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z1DENkNEG5eD for <iommu@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 22:15:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 53914848EF
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 22:15:16 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C1AA53F1F6
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 22:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1648073707;
 bh=dReMzwCuA7DzR3YY7V/dxHTfz3+PzXUF3Uux3SdiUmI=;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:In-Reply-To;
 b=ORMAxMXYx/809Tb9hd0Oz5e7cBj2ilZvVfG/BhPLLFeA4OEuKuCaaOqjT2/Wlz5cf
 AMCXD8Bi2vvxhivQ9HWUwGT8XSxD1r+bhXbSqSfJhu10Zv2tB+G+4zZE8jpdLcFirk
 uqv8tsueYfMlQclbUajpKcrNChw7XhhfdmimfoFGpugPlhamIax6Lut5R2RGu3Hd4F
 kSf65m9aKQ9AvhYfXWfYEOB5TLmWWyVWJq9E8/2umAhdNnfk30T7mByggxQHSVMTnt
 6lBjt+Bnh1bjp4Uye8tLG0MmaFTzPrSLARjruLjE3n5Gxq8fxW8kahN0Al6UWwvQFj
 cD2tqXwL1Hgkw==
Received: by mail-io1-f70.google.com with SMTP id
 u25-20020a5d8199000000b006421bd641bbso1929787ion.11
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 15:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dReMzwCuA7DzR3YY7V/dxHTfz3+PzXUF3Uux3SdiUmI=;
 b=BPkfUQczwAv6UHHDZcn1EWdF1bo5l2caB/o0dVvZfi7I3+W7JC8zghvMK2s9biea/U
 dUdafBS3yiluoLoQgaoV+iCTg3dnPj10/BBW7lNuIU8/Ym15Fy4nIPfDX75rOUdU91Jg
 /jDBSVdsh5VrNKb6WBqjpMLPV2bdfm+tYtcbCay2FIclJn2fvduDh4Wq6G3hRbAZSddO
 WdYFJwlB3QeMC+LW1S5CNC5ZstjViNwEEnTMij4RoC10LqfIUdTAzj+BYmrmL9c9dYC2
 AWw2iLIIzILYVA8JpE64onGEkCuJWZzFOjy2PEufZ7XkspKHiHOY3QyXUrjZPhStupY+
 6yDQ==
X-Gm-Message-State: AOAM530FCvm88xEb3Jtkx402zm5wD9UhQHgwfVTtRfrW3H1kZrJHEUnQ
 hD16EJ9TP1cZXk7GfmzCjOb37T0F/8gcECZZVYMRz5gujEEn5A6cIl3BwMQBC5OUSWgKDvXbRN8
 P7S9cpVo048sv+ZpX9ojqV3ZqA/EBjqVykLDoU1KuEhWA/6w=
X-Received: by 2002:a5e:a80a:0:b0:645:b477:bc23 with SMTP id
 c10-20020a5ea80a000000b00645b477bc23mr1117705ioa.191.1648073706601; 
 Wed, 23 Mar 2022 15:15:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+6tp9O8ufnlxk71fZyefoiD5uwhUdp8quxvaa4yYGqMyrpN0FkBtdLritCC8OWbVnRtSNug==
X-Received: by 2002:a5e:a80a:0:b0:645:b477:bc23 with SMTP id
 c10-20020a5ea80a000000b00645b477bc23mr1117696ioa.191.1648073706394; 
 Wed, 23 Mar 2022 15:15:06 -0700 (PDT)
Received: from xps13.dannf (c-73-14-97-161.hsd1.co.comcast.net. [73.14.97.161])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a056e021ba700b002c63098855csm588677ili.23.2022.03.23.15.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 15:15:05 -0700 (PDT)
Date: Wed, 23 Mar 2022 16:15:03 -0600
From: dann frazier <dann.frazier@canonical.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] iommu/dma: Explicitly sort PCI DMA windows
Message-ID: <Yjub51Ct3esuNA9B@xps13.dannf>
References: <65657c5370fa0161739ba094ea948afdfa711b8a.1647967875.git.robin.murphy@arm.com>
 <874k3pxalr.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <874k3pxalr.wl-maz@kernel.org>
Cc: robh@kernel.org, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, will@kernel.org
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

On Wed, Mar 23, 2022 at 09:49:04AM +0000, Marc Zyngier wrote:
> On Tue, 22 Mar 2022 17:27:36 +0000,
> Robin Murphy <robin.murphy@arm.com> wrote:
> > 
> > Originally, creating the dma_ranges resource list in pre-sorted fashion
> > was the simplest and most efficient way to enforce the order required by
> > iova_reserve_pci_windows(). However since then at least one PCI host
> > driver is now re-sorting the list for its own probe-time processing,
> > which doesn't seem entirely unreasonable, so that basic assumption no
> > longer holds. Make iommu-dma robust and get the sort order it needs by
> > explicitly sorting, which means we can also save the effort at creation
> > time and just build the list in whatever natural order the DT had.
> > 
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> > 
> > Looking at this area off the back of the XGene thread[1] made me realise
> > that we need to do it anyway, regardless of whether it might also happen
> > to restore the previous XGene behaviour or not. Presumably nobody's
> > tried to use pcie-cadence-host behind an IOMMU yet...
> 
> This definitely restores PCIe functionality on my Mustang (XGene-1).
> Hopefully dann can comment on whether this addresses his own issue, as
> his firmware is significantly different.

Robin, Marc,

Adding just this patch on top of v5.17 (w/ vendor dtb) isn't enough to
fix m400 networking:

  https://paste.ubuntu.com/p/H5ZNbRvP8V/

  -dann
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
