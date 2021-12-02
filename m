Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C8CC433EF
	for <iommu@archiver.kernel.org>; Thu,  2 Dec 2021 00:01:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1A2B840358;
	Thu,  2 Dec 2021 00:01:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6YlzjkiG42JC; Thu,  2 Dec 2021 00:01:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C7403400DE;
	Thu,  2 Dec 2021 00:01:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA8A7C000A;
	Thu,  2 Dec 2021 00:01:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FDEDC000A
 for <iommu@lists.linux-foundation.org>; Thu,  2 Dec 2021 00:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 24CB540358
 for <iommu@lists.linux-foundation.org>; Thu,  2 Dec 2021 00:01:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4YGFNVCvVS1U for <iommu@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 00:01:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B164A400DE
 for <iommu@lists.linux-foundation.org>; Thu,  2 Dec 2021 00:01:45 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638403303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sL+YIaY0kXx9h0ZbGxqN7dkvXLUzeLZfDG9h71cyvO0=;
 b=wwn+hpt0XnJfDkFE5pg37ANYJtFnOIy3FjiYVnKOtejDXM8uCnkxu+nh7L/Gt7UI1Mznej
 zm/jXSJ8zu1FRnqiDDEnnIda6Hm9awW653bsk3gmtsFS5bdhFgLpvguxugwMjmimAoDXGP
 MI6j85IqGUEkNWJ0Y6VZaY8CHvzYsWxvm4gxrYDb+4S+OeiBytABjZMye+/6hPnLkDoVv9
 PLwcWEgQO+z9NfGAYS2Ig+/s9MwNuPxiZoL5aqfBf0zZHNmZfZ5+gEGSKZkGVc4UicQw0N
 4Pxe+kcWs1WTUhOL+BDwP/+OOVm+QVzvUqSSWmCL4/nzzQ+MfeLBuxPiOR5ZyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638403303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sL+YIaY0kXx9h0ZbGxqN7dkvXLUzeLZfDG9h71cyvO0=;
 b=EgThZXNWcMkIxl29m1yERZS89u/hm615vIHy6fzYAwVqJgaHfeGocaaf76bjgJPa/atLqw
 b5jxYX7bxpP9pjBg==
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <87mtlk84ae.ffs@tglx>
References: <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
 <87ilwacwp8.ffs@tglx> <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com>
 <87v909bf2k.ffs@tglx> <20211130202800.GE4670@nvidia.com>
 <87o861banv.ffs@tglx> <20211201001748.GF4670@nvidia.com>
 <87mtlkaauo.ffs@tglx> <20211201130023.GH4670@nvidia.com>
 <87y2548byw.ffs@tglx> <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx>
Date: Thu, 02 Dec 2021 01:01:42 +0100
Message-ID: <87r1av7u3d.ffs@tglx>
MIME-Version: 1.0
Cc: Allen Hubbe <allenbh@gmail.com>, linux-s390@vger.kernel.org,
 Kevin Tian <kevin.tian@intel.com>, x86@kernel.org,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marc Zygnier <maz@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-ntb@googlegroups.com, Logan Gunthorpe <logang@deltatee.com>,
 Megha Dey <megha.dey@intel.com>
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

Jason,

On Wed, Dec 01 2021 at 21:21, Thomas Gleixner wrote:
> On Wed, Dec 01 2021 at 14:14, Jason Gunthorpe wrote:
> Which in turn is consistent all over the place and does not require any
> special case for anything. Neither for interrupts nor for anything else.

that said, feel free to tell me that I'm getting it all wrong.

The reason I'm harping on this is that we are creating ABIs on several
ends and we all know that getting that wrong is a major pain.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
