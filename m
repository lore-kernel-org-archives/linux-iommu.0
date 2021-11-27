Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585BCC433EF
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 02:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2A5F61BFE;
	Sat, 27 Nov 2021 02:10:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1kHv-x6f4oIH; Sat, 27 Nov 2021 02:10:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8D940606B9;
	Sat, 27 Nov 2021 02:10:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5175BC001C;
	Sat, 27 Nov 2021 02:10:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D7E9C000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 02:10:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2376560789
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 02:10:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d3OXc4BFTiAs for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 02:10:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 62D1F606B9
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 02:10:23 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="235973752"
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; d="scan'208";a="235973752"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2021 18:10:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; d="scan'208";a="652307974"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2021 18:10:20 -0800
Subject: Re: [PATCH v2 0/2] iommu/vt-d: Fixes for v5.16-rc3
To: Joerg Roedel <joro@8bytes.org>
References: <20211126135556.397932-1-baolu.lu@linux.intel.com>
 <YaFYRRGU5Qg4ViB8@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ac24b6c9-8ebe-9f29-270e-4aa96373a8e3@linux.intel.com>
Date: Sat, 27 Nov 2021 10:10:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaFYRRGU5Qg4ViB8@8bytes.org>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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

On 11/27/21 5:57 AM, Joerg Roedel wrote:
> On Fri, Nov 26, 2021 at 09:55:54PM +0800, Lu Baolu wrote:
>> Update this series with a fix for an issue reported by Intel 0-day
>> robot. Sorry for the inconvenience.
> 
> Replaced those with the previous fixes, thanks. Please just send a fix
> on-top next time. This was already in the published fixes branch, which
> I had to rebase now.

Sure.

Best regards,
baolu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
