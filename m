Return-Path: <SRS0=jcR/=E5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2743C388F9
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 22:34:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6048C206E3
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 22:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8w9dZ7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6048C206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E70608716F;
	Mon, 23 Nov 2020 22:34:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JtEVb6kyVuJt; Mon, 23 Nov 2020 22:34:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4E8F286AD4;
	Mon, 23 Nov 2020 22:34:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EAD7C163C;
	Mon, 23 Nov 2020 22:34:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A472C0052
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 22:34:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 55A0C85DC4
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 22:34:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KTb8KbkOcUyK for <iommu@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 22:34:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5152C85DC1
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 22:34:03 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2ED11206B7;
 Mon, 23 Nov 2020 22:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606170842;
 bh=EfAu8mvkAKJtvXGIKHOfxbFORCHbR6lzt8aMQ7RnXjc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l8w9dZ7t3FWKznc9S49rhn6NIXGz/p8IffABwKwfF5DIVGHepFHkRsjILerUwnVIw
 7A19bC/zDe/oZI2iD7jpUSOXivrfRImr/95RG1uEdmCD06Y8c1w77fJo14EJvcDwnd
 1REafM5KBMc7EBEBzmURh2A3U7dV0omHi5n2ALxI=
Date: Mon, 23 Nov 2020 22:33:56 +0000
From: Will Deacon <will@kernel.org>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
Message-ID: <20201123223356.GC12069@willie-the-truck>
References: <20201123134410.10648-1-will@kernel.org>
 <MN2PR12MB4488308D26DB50C18EA3BE0FF7FC0@MN2PR12MB4488.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MN2PR12MB4488308D26DB50C18EA3BE0FF7FC0@MN2PR12MB4488.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Edgar Merger <Edgar.Merger@emerson.com>, Joerg Roedel <jroedel@suse.de>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>
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

On Mon, Nov 23, 2020 at 09:04:14PM +0000, Deucher, Alexander wrote:
> [AMD Public Use]
> 
> > -----Original Message-----
> > From: Will Deacon <will@kernel.org>
> > Sent: Monday, November 23, 2020 8:44 AM
> > To: linux-kernel@vger.kernel.org
> > Cc: linux-pci@vger.kernel.org; iommu@lists.linux-foundation.org; Will
> > Deacon <will@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>;
> > Deucher, Alexander <Alexander.Deucher@amd.com>; Edgar Merger
> > <Edgar.Merger@emerson.com>; Joerg Roedel <jroedel@suse.de>
> > Subject: [PATCH] PCI: Mark AMD Raven iGPU ATS as broken
> > 
> > Edgar Merger reports that the AMD Raven GPU does not work reliably on his
> > system when the IOMMU is enabled:
> > 
> >   | [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout,
> > signaled seq=1, emitted seq=3
> >   | [...]
> >   | amdgpu 0000:0b:00.0: GPU reset begin!
> >   | AMD-Vi: Completion-Wait loop timed out
> >   | iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT
> > device=0b:00.0 address=0x38edc0970]
> > 
> > This is indicative of a hardware/platform configuration issue so, since
> > disabling ATS has been shown to resolve the problem, add a quirk to match
> > this particular device while Edgar follows-up with AMD for more information.
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Reported-by: Edgar Merger <Edgar.Merger@emerson.com>
> > Suggested-by: Joerg Roedel <jroedel@suse.de>
> > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
> > kernel.org%2Flinux-
> > iommu%2FMWHPR10MB1310F042A30661D4158520B589FC0%40MWHPR10M
> > B1310.namprd10.prod.outlook.com&amp;data=04%7C01%7Calexander.deuc
> > her%40amd.com%7C1a883fe14d0c408e7d9508d88fb5df4e%7C3dd8961fe488
> > 4e608e11a82d994e183d%7C0%7C0%7C637417358593629699%7CUnknown%7
> > CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> > LCJXVCI6Mn0%3D%7C1000&amp;sdata=TMgKldWzsX8XZ0l7q3%2BszDWXQJJ
> > LOUfX5oGaoLN8n%2B8%3D&amp;reserved=0
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> > 
> > Hi all,
> > 
> > Since Joerg is away at the moment, I'm posting this to try to make some
> > progress with the thread in the Link: tag.
> 
> + Felix
> 
> What system is this?  Can you provide more details?  Does a sbios update
> fix this?  Disabling ATS for all Ravens will break GPU compute for a lot
> of people.  I'd prefer to just black list this particular system (e.g.,
> just SSIDs or revision) if possible.

Cheers, Alex. I'll have to defer to Edgar for the details, as my
understanding from the original thread over at:

https://lore.kernel.org/linux-iommu/MWHPR10MB1310CDB6829DDCF5EA84A14689150@MWHPR10MB1310.namprd10.prod.outlook.com/

is that this is a board developed by his company.

Edgar -- please can you answer Alex's questions?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
