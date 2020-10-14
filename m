Return-Path: <SRS0=zShu=DV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF83C433E7
	for <iommu@archiver.kernel.org>; Wed, 14 Oct 2020 12:57:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F5A208B3
	for <iommu@archiver.kernel.org>; Wed, 14 Oct 2020 12:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F5A208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 83661879E7;
	Wed, 14 Oct 2020 12:57:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a0VYonlEoAsN; Wed, 14 Oct 2020 12:57:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F310D878F1;
	Wed, 14 Oct 2020 12:57:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9C10C0052;
	Wed, 14 Oct 2020 12:57:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06886C0051
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 12:57:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E951A88064
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 12:57:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ASF0KpA+ThZo for <iommu@lists.linux-foundation.org>;
 Wed, 14 Oct 2020 12:57:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8B75D88060
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 12:57:11 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 6799CD20; Wed, 14 Oct 2020 14:57:08 +0200 (CEST)
Date: Wed, 14 Oct 2020 14:57:05 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH next] iommu: intel: don't dereference iommu_device if
 IOMMU_API is not built
Message-ID: <20201014125704.GB3635@8bytes.org>
References: <20201013073055.11262-1-brgl@bgdev.pl>
 <abd717c9-9eaa-d4bb-3fd8-ff7250d97ab7@linux.intel.com>
 <CAMRc=MdLXaPNUwbUPGJS1AY0pq5je9zsGM7eHShLT=f6mT5Dww@mail.gmail.com>
 <dc6f3226-c6e5-b361-601b-afa91540144e@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dc6f3226-c6e5-b361-601b-afa91540144e@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux-foundation.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Oct 14, 2020 at 03:25:08PM +0800, Lu Baolu wrote:
> I suppose Joerg will pick this up. I guess you don't need to resend it
> unless Joerg asks you to do.

Yes, will pick this up soon, no need to re-send.

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
