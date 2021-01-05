Return-Path: <SRS0=smho=GI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA568C433DB
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 22:07:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 944F222E01
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 22:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944F222E01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 51361871CA;
	Tue,  5 Jan 2021 22:07:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vEv98VXjTnRU; Tue,  5 Jan 2021 22:07:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E0766871D6;
	Tue,  5 Jan 2021 22:07:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D59A2C088B;
	Tue,  5 Jan 2021 22:07:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1F86C013A
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 22:07:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B0D0322B25
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 22:07:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C+NdZvmAyeBZ for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 22:07:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 3FCCC228EB
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 22:07:12 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48D9322DFB;
 Tue,  5 Jan 2021 22:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609884432;
 bh=eSEXOr41V/dBpsepFxXoVybj3TSEep3A1pAtN7NQDEA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IBNd20msi0GKzy9EZ413szRxyQFByA2T3rvR8Vutp/ZAo0nM1NBs3LGyr/A0twlKf
 Weg5Lk8+/BeFIvXhpp3uqjFihD4fwDB6YKzqr+w39ZmACRNObBtoMLk2vkcc6wfdgg
 vFbaNRZULRaGgTGrsJXcBGoMwWLOIZOQC3J5R6oMOtr0gMEylqvNXd19a8m/tj0jLk
 j8IuzwtmuSigav1t4ghngbinXLg2yyxAPZsRncva55j8OTtTSv13pcyUqVWtzVX8mo
 eDQdDiqBSCW/gtw3K7mW5PyD3ZiVEg4YJjm8w8Tt04S/cpMc6mnBSgRkhBLCp2SvSv
 8SlWzg3Lc+ACg==
From: Will Deacon <will@kernel.org>
To: Borislav Petkov <bp@alien8.de>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] iommu/amd: Set iommu->int_enabled consistently when
 interrupts are set up
Date: Tue,  5 Jan 2021 22:07:01 +0000
Message-Id: <160987442134.30234.7295735708927658122.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <50cd5f55be8ead0937ac315cd2f5b89364f6a9a5.camel@infradead.org>
References: <20210104132250.GE32151@zn.tnic> <20210104232353.GJ32151@zn.tnic>
 <50cd5f55be8ead0937ac315cd2f5b89364f6a9a5.camel@infradead.org>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 catalin.marinas@arm.com, lkml <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
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

On Tue, 05 Jan 2021 01:32:51 +0000, David Woodhouse wrote:
> When I made the INTCAPXT support stop gratuitously pretending to be MSI,
> I missed the fact that iommu_setup_msi() also sets the ->int_enabled
> flag. I missed this in the iommu_setup_intcapxt() code path, which means
> that a resume from suspend will try to allocate the IRQ domains again,
> accidentally re-enabling interrupts as it does, resulting in much sadness.
> 
> Lift out the bit which sets iommu->int_enabled into the iommu_init_irq()
> function which is also where it gets checked.

Applied to arm64 (for-next/iommu/fixes), thanks!

[1/1] iommu/amd: Set iommu->int_enabled consistently when interrupts are set up
      https://git.kernel.org/arm64/c/12bc4570c14e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
