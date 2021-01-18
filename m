Return-Path: <SRS0=rNTl=GV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FE4C433DB
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 21:39:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4252222F
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 21:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4252222F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9A0B285A46;
	Mon, 18 Jan 2021 21:39:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3RyIDHdlXhIE; Mon, 18 Jan 2021 21:39:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E6E4281E56;
	Mon, 18 Jan 2021 21:39:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD3CCC08A1;
	Mon, 18 Jan 2021 21:39:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 295B9C013A
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 21:39:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0350A204E7
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 21:39:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fkJg8MXF4Lxi for <iommu@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 21:39:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 1825F204E0
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 21:39:16 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A445F22228;
 Mon, 18 Jan 2021 21:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611005955;
 bh=hZGvlx0rTFWGHIvxW7kbih2fSYuihcEgOha/kURQuPU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jp06HBfropG91/R5WFdHNzu0EWvsb+pj9GWKZ8IlRJ0qrRse6XSSOJFucNFaOcnam
 KBWT79MxSF01dkdzcWpp6IDTGDwqxuK4veFoy25IWvhVTDi08ZrR0BJzzLE8bhvylu
 rJM/iUpTZL6WtelaHw511Ovsgbpn0RnNExD/qQjFcC9hAC/yQAGUsX6iS7J+Rd3A08
 fdt4RZS1rS6ZYDJy/HX+KaYrBJUQZJwuLTy1QE8ZTtMkEaqx7Yshj+6gCllk+9uM+r
 C4nqmsfz0AeiHO0wUQP9XZuOEHdRRThA5QmhYwubDsqbOfQGNAn4esiuGhxXaRb9Cb
 PZiZFELeYw6xg==
Date: Mon, 18 Jan 2021 21:39:10 +0000
From: Will Deacon <will@kernel.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v2 5/7] drm/msm: Add dependency on io-pgtable-arm format
 module
Message-ID: <20210118213909.GA17971@willie-the-truck>
References: <1608597876-32367-1-git-send-email-isaacm@codeaurora.org>
 <1608597876-32367-6-git-send-email-isaacm@codeaurora.org>
 <CAF6AEGunsv5r_DmNsMbYwa4KQxRmK9J+5Bd12LYG4pQ=hrCe4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF6AEGunsv5r_DmNsMbYwa4KQxRmK9J+5Bd12LYG4pQ=hrCe4Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Android Kernel Team <kernel-team@android.com>, pdaly@codeaurora.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Pratik Patel <pratikp@codeaurora.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>
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

On Mon, Jan 18, 2021 at 01:16:03PM -0800, Rob Clark wrote:
> On Mon, Dec 21, 2020 at 4:44 PM Isaac J. Manjarres
> <isaacm@codeaurora.org> wrote:
> >
> > The MSM DRM driver depends on the availability of the ARM LPAE io-pgtable
> > format code to work properly. In preparation for having the io-pgtable
> > formats as modules, add a "pre" dependency with MODULE_SOFTDEP() to
> > ensure that the io-pgtable-arm format module is loaded before loading
> > the MSM DRM driver module.
> >
> > Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> 
> Thanks, I've queued this up locally

I don't plan to make the io-pgtable code modular, so please drop this patch.

https://lore.kernel.org/r/20210106123428.GA1798@willie-the-truck

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
