Return-Path: <SRS0=3Hz1=2H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9E3C43603
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 10:22:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ACDE2067C
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 10:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACDE2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2354E858AE;
	Tue, 17 Dec 2019 10:22:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qj5PnspnJl2a; Tue, 17 Dec 2019 10:22:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3055785C56;
	Tue, 17 Dec 2019 10:22:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DBE3C1AE8;
	Tue, 17 Dec 2019 10:22:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE639C077D
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 10:22:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AA1EB203F1
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 10:22:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MRsP24zdUeOq for <iommu@lists.linux-foundation.org>;
 Tue, 17 Dec 2019 10:22:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 1358A20014
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 10:22:43 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 1FD18286; Tue, 17 Dec 2019 11:22:41 +0100 (CET)
Date: Tue, 17 Dec 2019 11:22:39 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] iommu/vt-d: Set ISA bridge reserved region as relaxable
Message-ID: <20191217102239.GM8689@8bytes.org>
References: <157609608124.14870.10855090013879818212.stgit@gimli.home>
 <e330865d-6f88-4537-72c6-f0ecc8252327@redhat.com>
 <20191212122711.30e3b8ac@x1.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191212122711.30e3b8ac@x1.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: eauger@redhat.com, iommu@lists.linux-foundation.org, cprt@protonmail.com
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

Hi Alex,

On Thu, Dec 12, 2019 at 12:27:11PM -0700, Alex Williamson wrote:
> Sure, if you remember the ordering between these then that might be the
> better option.  I checked that they both entered the kernel for
> v5.3-rc1 but didn't dig deeper than that.
> 
> Joerg, if you'd like a respin for that change let me know, otherwise
> just swap my Fixes tag for the one Eric suggests.

Swapped the Fixes tag and applied for v5.5, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
