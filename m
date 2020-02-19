Return-Path: <SRS0=JfOd=4H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF7BC34047
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 11:00:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65FFD24658
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 11:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqvIKoXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FFD24658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8D442204EB;
	Wed, 19 Feb 2020 11:00:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GrxFMiUfr5jv; Wed, 19 Feb 2020 11:00:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A0A26203CF;
	Wed, 19 Feb 2020 11:00:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82D27C1D80;
	Wed, 19 Feb 2020 11:00:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2A6BC013E
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 11:00:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CDB1A84AB8
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 11:00:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PYB5Ry3dlKsV for <iommu@lists.linux-foundation.org>;
 Wed, 19 Feb 2020 11:00:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 49696842B8
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 11:00:51 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D0D94206DB;
 Wed, 19 Feb 2020 11:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582110051;
 bh=HtKSRzQFCzl6DpMToIACUoz6CFw9/WPHWtojy9tN6C4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YqvIKoXgJlUXHE6v2ZNciKOcnyr2nij9pTwaiosZpolNsOddKA+lu3shaOIVINk4T
 fRjceMxDAj6fr6WeN4yDxLXRc049jKo50o+bgWERH6tGqgD4P0eYebmJ0vEjI6zjEQ
 rQheC1zqgkbqsXHIyS9Tff9Ybc4SVJFxWwYqk3S8=
Date: Wed, 19 Feb 2020 11:00:46 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu: Restore naming of driver parameter prefix
Message-ID: <20200219110046.GC16824@willie-the-truck>
References: <20200218172756.2131-1-will@kernel.org>
 <90975c71-9089-b857-6b22-804415e4d5cb@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <90975c71-9089-b857-6b22-804415e4d5cb@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Russell King <linux@armlinux.org.uk>, Li Yang <leoyang.li@nxp.com>,
 iommu@lists.linux-foundation.org, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org
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

On Tue, Feb 18, 2020 at 05:40:39PM +0000, Robin Murphy wrote:
> On 18/02/2020 5:27 pm, Will Deacon wrote:
> > Extending the Arm SMMU driver to allow for modular builds changed
> > KBUILD_MODNAME to be "arm_smmu_mod" so that a single module could be
> > built from the multiple existing object files without the need to rename
> > any source files.
> > 
> > This inadvertently changed the name of the driver parameters, which may
> > lead to runtime issues if bootloaders are relying on the old names for
> > correctness (e.g. "arm-smmu.disable_bypass=0").
> 
> Indeed, it turns out this also tripped up some Juno setups in our internal
> CI that were bodging around firmware issues.
> 
> > Although MODULE_PARAM_PREFIX can be overridden to restore the old naming
> > for builtin parameters, only the new name is matched by modprobe and so
> > loading the driver as a module would cause parameters specified on the
> > kernel command line to be ignored. Instead, rename "arm_smmu_mod" to
> > "arm_smmu". Whilst it's a bit of a bodge, this allows us to create a
> > single module without renaming any files and makes use of the fact that
> > underscores and hyphens can be used interchangeably in parameter names.
> 
> That's awful... and thus great :)
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Cheers, Robin!

Joerg -- please can you pick this up as a fix for 5.6? I don't have any
other SMMU fixes queued, so it doesn't seem worth sending a pull request
to you just for this.

Thanks,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
