Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96323C433EF
	for <iommu@archiver.kernel.org>; Sun, 12 Dec 2021 20:55:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F96A60EC8;
	Sun, 12 Dec 2021 20:55:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NwSeFnDOtjR5; Sun, 12 Dec 2021 20:55:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 24F0760EAA;
	Sun, 12 Dec 2021 20:55:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE06FC0012;
	Sun, 12 Dec 2021 20:55:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6051DC0012
 for <iommu@lists.linux-foundation.org>; Sun, 12 Dec 2021 20:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4130E41D30
 for <iommu@lists.linux-foundation.org>; Sun, 12 Dec 2021 20:55:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="LpEiLakm";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="bcZqTtGa"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 06XeHQspIJoh for <iommu@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 20:55:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9535341D2E
 for <iommu@lists.linux-foundation.org>; Sun, 12 Dec 2021 20:55:35 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639342533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X/NAgpabmqU7SvS/VZzGUCF8aINHFotBjDodV/Kfsg4=;
 b=LpEiLakmAttHKGEe/3XvPR1wZM1Zx04nHfXTOtMTF+y2v8crOvCX0wLiHUiSxD2FMv70dd
 pVyrjpQGUNXm58MyJoCymnp+uSMpvxZnJPhGJa4bENiiTG4Tx6pYhvxGRFH0V84NDRbSzF
 6essnvXYnG0FXAPt+wqOfhMKDE8tNgK0lOLemWVecVSYa/Isa8wFkTUp45sIKm8iuR7JRK
 73Bi6yC8SORzL04D7o1qph0B/nQEXBpoCQTxZWY8AfMdKlWhBMJba8XHmqBLFYgd62OD6+
 lCYxnrO3qvB6jMsSI4UwL+BfNgM4mUqSqh0zXXY8IN/6StMQhO6/wd+p+7HX6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639342533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X/NAgpabmqU7SvS/VZzGUCF8aINHFotBjDodV/Kfsg4=;
 b=bcZqTtGalDhuJSdfHxRVIoNBI2gdJizxqQQ5t6JV10dXy2tkk45yd0xK2H3YKD2oPO52mo
 TOV2vJAYg0Kr3gAQ==
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <BL1PR11MB5271326D39DAB692F07587768C739@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
 <8735n1zaz3.ffs@tglx> <87sfv1xq3b.ffs@tglx>
 <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20211210123938.GF6385@nvidia.com> <87fsr0xp31.ffs@tglx>
 <BN9PR11MB527625E8A9BB854F3C0D19AE8C729@BN9PR11MB5276.namprd11.prod.outlook.com>
 <875yrvwavf.ffs@tglx>
 <BL1PR11MB5271326D39DAB692F07587768C739@BL1PR11MB5271.namprd11.prod.outlook.com>
Date: Sun, 12 Dec 2021 21:55:32 +0100
Message-ID: <87fsqxv8zf.ffs@tglx>
MIME-Version: 1.0
Cc: Allen Hubbe <allenbh@gmail.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marc Zygnier <maz@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, "Rodel, Jorg" <jroedel@suse.de>,
 Bjorn Helgaas <helgaas@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
 Logan Gunthorpe <logang@deltatee.com>, "Dey, Megha" <megha.dey@intel.com>
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

Kevin,

On Sun, Dec 12 2021 at 01:56, Kevin Tian wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> All I can find is drivers/iommu/virtio-iommu.c but I can't find anything
>> vIR related there.
>
> Well, virtio-iommu is a para-virtualized vIOMMU implementations.
>
> In reality there are also fully emulated vIOMMU implementations (e.g.
> Qemu fully emulates Intel/AMD/ARM IOMMUs). In those configurations
> the IR logic in existing iommu drivers just apply:
>
> 	drivers/iommu/intel/irq_remapping.c
> 	drivers/iommu/amd/iommu.c

thanks for the explanation. So that's a full IOMMU emulation. I was more
expecting a paravirtualized lightweight one.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
