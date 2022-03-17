Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222A7C433EF
	for <iommu@archiver.kernel.org>; Thu, 17 Mar 2022 06:30:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA40041873;
	Thu, 17 Mar 2022 06:30:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dvlZXUxi4QkI; Thu, 17 Mar 2022 06:30:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0C2EC410C6;
	Thu, 17 Mar 2022 06:30:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5920C0012;
	Thu, 17 Mar 2022 06:30:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EC9DC000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 06:30:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3E67460DCA
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 06:30:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zhw4MAb63vSu for <iommu@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 06:30:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8BACD60ACA
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 06:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647498617; x=1679034617;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+EitQhRNu6NXwpeAYT82YbKRTfk60BrW2G0bXEc4/dM=;
 b=F7BI8qNQUvEwD/IB50x22X4q7asSqIT6H8yN7QXPrdqyXA90Buoo/SYv
 QiVjKiK5IS2NXhw3GzSV9/VBjtx+h7eW/3CFaMTR2k8u3lmq4rtRolhXB
 oB//v1nv7HB5Kmou86KVh/igdYao7Jn/1Rr40BtqBvwq22JTz4F37aPfI
 0sl3iShwLO0BiH/E4OBRzWHS7yI5xXCS049SFn/vEzFV9S8MIMnVPWww2
 tHLKYUZLiVg0PX61hZaCQq1PqjBDODxvtn2kbdegOfuK7sOh8bpl6pEhh
 H1zOjw/WP11VvaoIYiTfQmsBvnOtgdH1FngaQZNmaRowpd3wIgDkMVOEf w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="320005908"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; d="scan'208";a="320005908"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 23:30:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; d="scan'208";a="714916184"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 23:30:13 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 17 Mar 2022 08:30:10 +0200
Date: Thu, 17 Mar 2022 08:30:10 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: Re: [PATCH] thunderbolt: Stop using iommu_present()
Message-ID: <YjLVcnl1qfdoDf48@lahna>
References: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
 <YjHb1xCx4UAmUjrR@lahna>
 <16852eb2-98bb-6337-741f-8c2f06418b08@arm.com>
 <YjIb+XOGZbWKpQDa@lahna>
 <BL1PR12MB515762E68F3A48A97EB2DC89E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjIgQfmcw6fydkXd@lahna>
 <3bb6a2f8-005b-587a-7d7a-7a9a5391ec05@arm.com>
 <BL1PR12MB5157DA58C3BDAFB5736676F6E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <5ef1c30a-1740-00cc-ad16-4b1c1b02fca4@arm.com>
 <BL1PR12MB5157380CD6FD9EB83E76CBB0E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5157380CD6FD9EB83E76CBB0E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: "michael.jamet@intel.com" <michael.jamet@intel.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>
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

Hi Mario,

On Wed, Mar 16, 2022 at 06:34:51PM +0000, Limonciello, Mario wrote:
> > Might it be reasonable for the Thunderbolt core to check early on if any
> > tunnelled ports are not marked as external facing, and if so just tell
> > the user that iommu_dma_protection is off the table and anything they
> > authorise is at their own risk?
> > 
> > Robin.
> 
> How about in iommu_dma_protection_show to just check that all the device
> links to the NHI are marked as untrusted?

Actually this does not work either because we have pre-USB4 systems out
there that are using firmware based connection manager and do not set
the "device links" (as it is only needed for USB4 software based
connection manager systems).

So only thing we can use is the ->external_facing (and ->untrusted) as
those exists in all these systems (well assuming the BIOS provided them
but this is Microsoft requirement in the same way with the DMAR bit).

[For those who are not familiar with the connection manager, it is the
 software or firmware that actually creates the tunnels over the
 Thunderbolt/USB4 fabric. In Intel systems up to Alder Lake it used to be
 firmware based, and from Alder Lake and beyond it is software based
 meaning that the Linux Thunderbolt driver creates the tunnels. Apple
 systems have been software based from the beginnning.]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
