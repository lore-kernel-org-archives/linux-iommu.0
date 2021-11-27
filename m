Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9E6C433EF
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 12:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 679E1401C9;
	Sat, 27 Nov 2021 12:12:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LKB2_VPfD7y1; Sat, 27 Nov 2021 12:12:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2725A40010;
	Sat, 27 Nov 2021 12:12:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E78D4C001C;
	Sat, 27 Nov 2021 12:12:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE19DC000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 12:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE37E81CE3
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 12:12:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LIw9xK5Xs5Jv for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 12:12:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B09B881CD0
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 12:12:39 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EA58F60B12;
 Sat, 27 Nov 2021 12:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CACCC53FAD;
 Sat, 27 Nov 2021 12:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1638015158;
 bh=Nsypz1pbkrnBiWqd93zUKpPoJWu4uG4aFKzWclKNc9A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zzMjx7oKYUBaSqI7Q8w0u1AgdSfR07MfyEkU7XIvbNq5Z99yeq3J4Ls/QMed/W4SP
 Eba1zDMeN9zfI4spkq4X+daCizQux5tAT+r3n8r6Ku+d9bimqPGycb4C4JVbp6uXIm
 qSTj78+6e5GnhJjPjP0rbDK368g5U+kzGjFnnUew=
Date: Sat, 27 Nov 2021 13:12:35 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 02/37] device: Add device::msi_data pointer and struct
 msi_device_data
Message-ID: <YaIgsyae/J0XJbHQ@kroah.com>
References: <20211126224100.303046749@linutronix.de>
 <20211126230524.045836616@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211126230524.045836616@linutronix.de>
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Marc Zygnier <maz@kernel.org>, x86@kernel.org, Sinan Kaya <okaya@kernel.org>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 Megha Dey <megha.dey@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Tero Kristo <kristo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
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

On Sat, Nov 27, 2021 at 02:20:09AM +0100, Thomas Gleixner wrote:
> Create struct msi_device_data and add a pointer of that type to struct
> dev_msi_info, which is part of struct device. Provide an allocator function
> which can be invoked from the MSI interrupt allocation code pathes.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/device.h |    5 +++++
>  include/linux/msi.h    |   12 +++++++++++-
>  kernel/irq/msi.c       |   33 +++++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 1 deletion(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
