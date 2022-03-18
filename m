Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E63C433EF
	for <iommu@archiver.kernel.org>; Fri, 18 Mar 2022 14:59:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C1FD417BF;
	Fri, 18 Mar 2022 14:59:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RjqV8uC31ttn; Fri, 18 Mar 2022 14:59:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 38121417AE;
	Fri, 18 Mar 2022 14:59:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05862C001A;
	Fri, 18 Mar 2022 14:59:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD5F9C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 14:59:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B6148417BF
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 14:59:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PqAmzgf_yDeH for <iommu@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 14:59:52 +0000 (UTC)
X-Greylist: delayed 00:08:25 by SQLgrey-1.8.0
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net
 [83.223.78.240])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 55E36417AE
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 14:59:52 +0000 (UTC)
Received: from h08.hostsharing.net (h08.hostsharing.net
 [IPv6:2a01:37:1000::53df:5f1c:0])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "*.hostsharing.net",
 Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
 by bmailout2.hostsharing.net (Postfix) with ESMTPS id 385E128042B86;
 Fri, 18 Mar 2022 15:51:21 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id 2CB204ADE5; Fri, 18 Mar 2022 15:51:21 +0100 (CET)
Date: Fri, 18 Mar 2022 15:51:21 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] thunderbolt: Make iommu_dma_protection more accurate
Message-ID: <20220318145121.GA11127@wunner.de>
References: <2d01fa50c2650c730b0244929097737918e302e7.1647533152.git.robin.murphy@arm.com>
 <BL1PR12MB515783C0F998169D49D92A55E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <BL1PR12MB51573F55B3C2B3922BAAA7F1E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjRvMk1kcbMwJvx+@lahna>
 <65207fdf-c4ab-5165-dbda-8ab55b51adb7@arm.com>
 <YjSCWaq7Ej/2iJPp@lahna>
 <78fc0426-c22a-ec62-f92b-0019bea5947e@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <78fc0426-c22a-ec62-f92b-0019bea5947e@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "michael.jamet@intel.com" <michael.jamet@intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
 "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
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

On Fri, Mar 18, 2022 at 02:08:16PM +0000, Robin Murphy wrote:
> OK, so do we have any realistic options for identifying the correct PCI
> devices, if USB4 PCIe adapters might be anywhere relative to their
> associated NHI? Short of maintaining a list of known IDs, the only thought I
> have left is that if we walk the whole PCI segment looking specifically for
> hotplug-capable Gen1 ports, any system modern enough to have Thunderbolt is
> *probably* not going to have any real PCIe Gen1 hotplug slots, so maybe
> false negatives might be tolerable, but it still feels like a bit of a
> sketchy heuristic.

The Thunderbolt Device ROM contains the PCI slot number, so you can
correlate the Thunderbolt switch ports with PCIe downstream ports
and know exactly where PCIe tunnels are terminated.

Code is here:
* thunderbolt: Obtain PCI slot number from DROM
  https://github.com/l1k/linux/commit/756f7148bc10
* thunderbolt: Move upstream_port to struct tb
  https://github.com/l1k/linux/commit/58f16e7dd431
* thunderbolt: Correlate PCI devices with Thunderbolt ports
  https://github.com/l1k/linux/commit/f53ea40a7487

I implemented that in 2018, so it won't apply cleanly to current
mainline.  But I kept forward-porting it on my private branch and
could push that to GitHub if anyone is interested.

I don't know if this will work out-of-the-box for SoC-integrated
Thunderbolt controllers.  It was developed with the discrete
controllers in mind, which was the only thing available back then.

Thanks,

Lukas
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
