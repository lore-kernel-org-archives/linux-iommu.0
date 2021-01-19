Return-Path: <SRS0=ZMVL=GW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE49C433DB
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 15:56:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E787208E4
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 15:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E787208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1E844851AA;
	Tue, 19 Jan 2021 15:56:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lrGNY-ORXO0j; Tue, 19 Jan 2021 15:56:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A4A1A8517E;
	Tue, 19 Jan 2021 15:56:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A157C088B;
	Tue, 19 Jan 2021 15:56:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E503C013A
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 15:56:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 09CA28517E
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 15:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xrwE0GsDFs-1 for <iommu@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 15:56:13 +0000 (UTC)
X-Greylist: delayed 00:10:05 by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 653D985184
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 15:56:13 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 1626C450; Tue, 19 Jan 2021 16:46:05 +0100 (CET)
Date: Tue, 19 Jan 2021 16:46:01 +0100
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: IOMMU Maintainership
Message-ID: <20210119154601.GA3229@8bytes.org>
References: <20201117100953.GR22888@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201117100953.GR22888@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Will Deacon <will@kernel.org>, Alex Williamson <alex.williamson@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Tue, Nov 17, 2020 at 11:09:53AM +0100, Joerg Roedel wrote:
> Hi,
> 
> last week I spent in the hospital and had an unplanned surgery from
> which I am recovering now. The recovery will take a few weeks, which
> unfortunatly does not allow me to fulfill my IOMMU maintainer duties or
> do any other serious work in front of a computer.
> 
> Luckily Will Deacon volunteered to handle incoming IOMMU patches and
> send them upstream. So please Cc him on any patches that you want to
> have merged upstream for the next release and on important fixes for
> v5.10. The patches will go through another tree for the time being, Will
> can share the details on that.

I am happy to announce that my recovery has gone well and I can now
return to my duties as the maintainer for IOMMU. Will already sent me a
list of pending stuff I will go through soon.

Thanks a lot to everyone who helped to keep things going through my
absence, and especially Will Deacon who picked up the work to collect
everything and sending it upstream!


Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
