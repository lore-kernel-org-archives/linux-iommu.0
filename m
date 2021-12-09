Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FE8C433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 21:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9DA314EEC7;
	Thu,  9 Dec 2021 21:02:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7UapQRVaewXf; Thu,  9 Dec 2021 21:02:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8C9EB4EEC2;
	Thu,  9 Dec 2021 21:02:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 646E5C002F;
	Thu,  9 Dec 2021 21:02:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3D52C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 21:02:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 847384EEC8
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 21:02:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ct2TdGz_vbjz for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 21:02:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E33A54EEC6
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 21:02:07 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639083725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xxqdvbsXfW9ZTgMmCuXp8YRHSWgAbwtAttb91gr8JjI=;
 b=DOc6YJ2ZnBO/S4LCXZXRmaCbKg4mw4ULShgz8TQVMTQrtnAO2Xt2ML2QqNoyx+YxXUsHJN
 M9Uc19toNCVSDrL0eBe6B+2C6HaFEOtjxR4Vo4wDMaGkR/fPp4Wnk8pCtSmMV+G3zim+uJ
 dTY6cTrRvZdPCszRejdDVRTgiEJq+lNz109fnZuFt1e703qlfscJY8ERwknVxLcHHHkz7A
 wxSoldZRl7kvhteRoNYLnpDjrMlrysFM5RCRJ+id9dYpo1pfWpwST9eeIao0MKlvGxa//1
 fq90+ELl15EUbs0r5Np+mZtUBnTVF1oCbSyBny5RQeJBwFKovf/OUugsxVxS8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639083725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xxqdvbsXfW9ZTgMmCuXp8YRHSWgAbwtAttb91gr8JjI=;
 b=7h0lucwwwhZa1hvXVoxI9ymbY55FLNkqkYChkOSRhqiPlIIQ18VrnDa7PbaNLMd6ZwoxZ+
 K+aavqocs9ZCuaAA==
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch V2 19/36] PCI/MSI: Store properties in device::msi::data
In-Reply-To: <87k0gdzmu6.ffs@tglx>
References: <20211206210307.625116253@linutronix.de>
 <20211206210438.688216619@linutronix.de>
 <20211208155816.GZ6385@nvidia.com> <87k0gdzmu6.ffs@tglx>
Date: Thu, 09 Dec 2021 22:02:04 +0100
Message-ID: <875yrxze43.ffs@tglx>
MIME-Version: 1.0
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Marc Zygnier <maz@kernel.org>, Sinan Kaya <okaya@kernel.org>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 Megha Dey <megha.dey@intel.com>, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Juergen Gross <jgross@suse.com>, Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
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

On Thu, Dec 09 2021 at 18:53, Thomas Gleixner wrote:
> On Wed, Dec 08 2021 at 11:58, Jason Gunthorpe wrote:
>> On Mon, Dec 06, 2021 at 11:39:26PM +0100, Thomas Gleixner wrote:
>>> Store the properties which are interesting for various places so the MSI
>>> descriptor fiddling can be removed.
>>> 
>>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>> ---
>>> V2: Use the setter function
>>> ---
>>>  drivers/pci/msi/msi.c |    8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>
>> I took more time to look at this, to summarize my remarks on the other
>> patches
>>
>> I think we don't need properties. The info in the msi_desc can come
>> from the pci_dev which we have easy access to. This seems overall
>> clearer
>
> I fixed that now.

So much for the theory. dev->msi[x]_enabled are set after everything is
set up. Some of the places are part of the setup...

/me goes back to stare
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
