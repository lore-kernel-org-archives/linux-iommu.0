Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D2FC433F5
	for <iommu@archiver.kernel.org>; Sun, 28 Nov 2021 19:09:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E473E40265;
	Sun, 28 Nov 2021 19:09:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ERdvU9K0z-W4; Sun, 28 Nov 2021 19:09:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 756CB40140;
	Sun, 28 Nov 2021 19:09:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D42FC0012;
	Sun, 28 Nov 2021 19:09:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7FBBBC000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 19:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 678DD82A7F
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 19:09:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="RXQ9TCzz";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="bp81l/mv"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I-LLjB5z_OIW for <iommu@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 19:09:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B8EE882A2D
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 19:09:22 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638126558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CjZcRIM8mi5Lga3dE0YMFAAVgRUsLCHnKUD78SK4AQQ=;
 b=RXQ9TCzzfl4WPtWcEJoRHxY0CML6p5j+vVn642rlvX4FXeGOQlTdOUHJA7TT/zMvTcjhsJ
 z2rlcikR4dPUEfkkZEyKLgBw5JNje7IukbrP5rH+IE6poqMYiao1Ca4Jv76m34iRN55Ugp
 9P197uGT9ReR6cEJgyZzR2bL1i5B2LiF3G8u3m1MGyv/K7P7ZcAj693GrLpygGCZMR0zi0
 0KJ7ALQY8WY49eWHTHuU3ao5WzbumtDwaMd5vjrhuQEmq6z0WkfUTzt9rSRrTjaYjKnNAh
 cfKsUGOras+oIgI8Eal2B4zXTACelM12H/MpiLBy/YwAKS60vXfzAPoKFbwzqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638126558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CjZcRIM8mi5Lga3dE0YMFAAVgRUsLCHnKUD78SK4AQQ=;
 b=bp81l/mvh3aNr1oJURqDKy63fAKoxH05F3XfT4StsiB+7OI2VuNNOHrlu3G2D0TFLaaxGV
 tRyuRxEuQqfHuuBA==
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 02/37] device: Add device::msi_data pointer and struct
 msi_device_data
In-Reply-To: <20211128001406.GT4670@nvidia.com>
References: <20211126224100.303046749@linutronix.de>
 <20211126230524.045836616@linutronix.de>
 <20211128001406.GT4670@nvidia.com>
Date: Sun, 28 Nov 2021 20:09:18 +0100
Message-ID: <87czmkf675.ffs@tglx>
MIME-Version: 1.0
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Marc Zygnier <maz@kernel.org>, x86@kernel.org, Sinan Kaya <okaya@kernel.org>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 Megha Dey <megha.dey@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org
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

On Sat, Nov 27 2021 at 20:14, Jason Gunthorpe wrote:
> On Sat, Nov 27, 2021 at 02:20:09AM +0100, Thomas Gleixner wrote:
>
>> +/**
>> + * msi_setup_device_data - Setup MSI device data
>> + * @dev:	Device for which MSI device data should be set up
>> + *
>> + * Return: 0 on success, appropriate error code otherwise
>> + *
>> + * This can be called more than once for @dev. If the MSI device data is
>> + * already allocated the call succeeds. The allocated memory is
>> + * automatically released when the device is destroyed.
>
> I would say 'by devres when the driver is removed' rather than device
> is destroyed - to me the latter implies it would happen at device_del
> or perhaps during release..

Ah. Indeed it's when the driver unbinds because that's what disables MSI.

>> +int msi_setup_device_data(struct device *dev)
>> +{
>> +	struct msi_device_data *md;
>> +
>> +	if (dev->msi.data)
>> +		return 0;
>> +
>> +	md = devres_alloc(msi_device_data_release, sizeof(*md), GFP_KERNEL);
>> +	if (!md)
>> +		return -ENOMEM;
>> +
>> +	raw_spin_lock_init(&md->lock);
>
> I also couldn't guess why this needed to be raw?

That lock is to replace the raw spinlock we have in struct device right
now, which is protecting low level register access and that's called
from within irq_desc::lock held regions with interrupts disabled. I had
to stick something into the data structure because allocating 0 bytes is
invalid. But yes, I should have mentioned it in the changelog.

Thanks,

        tglx


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
