Return-Path: <SRS0=m57D=Z3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC053C43603
	for <iommu@archiver.kernel.org>; Thu,  5 Dec 2019 01:39:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 974702077B
	for <iommu@archiver.kernel.org>; Thu,  5 Dec 2019 01:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974702077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 52B9687141;
	Thu,  5 Dec 2019 01:39:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ugcGP90-CBdv; Thu,  5 Dec 2019 01:39:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2E4CC87126;
	Thu,  5 Dec 2019 01:39:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D49DC18DD;
	Thu,  5 Dec 2019 01:39:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06515C077D
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 01:39:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E7CD2886DA
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 01:39:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z5VVIdpQ+a+j for <iommu@lists.linux-foundation.org>;
 Thu,  5 Dec 2019 01:39:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 57596886D0
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 01:39:53 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Dec 2019 17:39:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; d="scan'208";a="223464028"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 04 Dec 2019 17:39:51 -0800
Subject: Re: dmar pte read access not set error messages on hp dl388 gen8
 systems
To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20191202063422.3lyfoerkejig4num@cantor>
 <702d8a8a-88de-bffb-911e-9eb9a6a7845d@linux.intel.com>
 <20191202071406.jpq5qobbtnwhktlc@cantor>
 <20191202161332.ctc3y5cvdgqwnz7l@cantor>
 <14bbe41c-61e9-d2b6-31cb-67c0b1ad11da@linux.intel.com>
 <20191203095636.epmuinnrpykecfda@cantor>
 <5ce8d57e-25f0-5d28-7408-92c650ba54aa@linux.intel.com>
 <20191204205300.4jiexjqfpnqlcagu@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2d4e0c05-f0ee-d4b1-d2ed-24197811b097@linux.intel.com>
Date: Thu, 5 Dec 2019 09:39:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191204205300.4jiexjqfpnqlcagu@cantor>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

On 12/5/19 4:53 AM, Jerry Snitselaar wrote:
> Attaching console output (can't get to a point to actually log in) and
> config that is used to build that kernel.

[...]
[   21.969477] pci 0000:00:00.0: Adding to iommu group 0
[   21.971390] pci 0000:00:01.0: Adding to iommu group 1
[   21.973173] pci 0000:00:01.1: Adding to iommu group 2
[   21.974930] pci 0000:00:02.0: Adding to iommu group 3
[   21.976672] pci 0000:00:02.1: Adding to iommu group 4
[   21.978446] pci 0000:00:02.2: Adding to iommu group 5
[   21.980224] pci 0000:00:02.3: Adding to iommu group 6
[   21.982096] pci 0000:00:03.0: Adding to iommu group 7
[   21.983868] pci 0000:00:03.1: Adding to iommu group 8
[   21.985644] pci 0000:00:03.2: Adding to iommu group 9
[   21.987484] pci 0000:00:03.3: Adding to iommu group 10
[   21.989830] pci 0000:00:04.0: Adding to iommu group 11
[   21.991738] pci 0000:00:04.1: Adding to iommu group 11
[   21.993557] pci 0000:00:04.2: Adding to iommu group 11
[   21.995360] pci 0000:00:04.3: Adding to iommu group 11
[   21.997145] pci 0000:00:04.4: Adding to iommu group 11
[   21.998915] pci 0000:00:04.5: Adding to iommu group 11
[   22.000694] pci 0000:00:04.6: Adding to iommu group 11
[   22.002569] pci 0000:00:04.7: Adding to iommu group 11
[   22.004556] pci 0000:00:05.0: Adding to iommu group 12
[   22.006388] pci 0000:00:05.2: Adding to iommu group 12
[   22.008186] pci 0000:00:05.4: Adding to iommu group 12
[   22.009968] pci 0000:00:11.0: Adding to iommu group 13
[   22.011815] pci 0000:00:1a.0: Adding to iommu group 14
[   22.013605] pci 0000:00:1c.0: Adding to iommu group 15
[   22.015408] pci 0000:00:1c.7: Adding to iommu group 16
[   22.017216] pci 0000:00:1d.0: Adding to iommu group 17
[   22.018991] pci 0000:00:1e.0: Adding to iommu group 18
[   22.021826] pci 0000:00:1e.0: Using iommu dma mapping
[   22.023783] pci 0000:00:1f.0: Adding to iommu group 19
[   22.025667] pci 0000:00:1f.2: Adding to iommu group 19
[   22.346001] pci 0000:03:00.0: Adding to iommu group 20
[   22.348727] pci 0000:03:00.0: Using iommu dma mapping
[   22.350644] pci 0000:03:00.1: Adding to iommu group 20
[   22.352833] pci 0000:03:00.2: Adding to iommu group 20
[...]

It seems that iommu pci bus probe didn't enumerate device [01:00.2] and
[02:00.0], the corresponding context entries were not setup. Hence dma
fault generated when devices access the memory.

Do these two devices show in "lspci" output? How do these devices get
enumerated by the system?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
