Return-Path: <SRS0=ZmA0=Y5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7C4C010CF
	for <iommu@archiver.kernel.org>; Tue,  5 Nov 2019 12:15:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A0722480
	for <iommu@archiver.kernel.org>; Tue,  5 Nov 2019 12:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A0722480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 625F916E1;
	Tue,  5 Nov 2019 12:15:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 555DA16E0
	for <iommu@lists.linux-foundation.org>;
	Tue,  5 Nov 2019 12:15:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BDEE35D0
	for <iommu@lists.linux-foundation.org>;
	Tue,  5 Nov 2019 12:15:17 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 1DCFD450; Tue,  5 Nov 2019 13:15:15 +0100 (CET)
Date: Tue, 5 Nov 2019 13:15:08 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 5/7] iommu/arm-smmu-v3: Allow building as a module
Message-ID: <20191105121508.GA3479@8bytes.org>
References: <20191030145112.19738-1-will@kernel.org>
	<20191030145112.19738-6-will@kernel.org>
	<20191030193148.GA8432@8bytes.org>
	<20191031154247.GB28061@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191031154247.GB28061@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Will,

On Thu, Oct 31, 2019 at 03:42:47PM +0000, Will Deacon wrote:
> Generally, I think unloading the IOMMU driver module while there are
> active users is a pretty bad idea, much like unbinding the driver via
> /sys in the same situation would also be fairly daft. However, I *think*
> the code in __device_release_driver() tries to deal with this by
> iterating over the active consumers and ->remove()ing them first.
> 
> I'm without hardware access at the moment, so I haven't been able to
> test this myself. We could nobble the module_exit() hook, but there's
> still the "force unload" option depending on the .config.

Okay, but besides the force-unload case, can we prevent accidential
unloading by taking a reference to the module in add_device() and release
it in remove_device()?

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
