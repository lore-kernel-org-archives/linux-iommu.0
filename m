Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1477C433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 16:05:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 925C4408D2;
	Tue, 14 Dec 2021 16:05:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RsKrq23NEDcm; Tue, 14 Dec 2021 16:05:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 675B8405AE;
	Tue, 14 Dec 2021 16:05:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CAFFC001E;
	Tue, 14 Dec 2021 16:05:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7031C0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 16:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C540C816F5
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 16:05:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=alien8.de
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2gU_6S-4d3v1 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 16:05:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 428D881656
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 16:05:07 +0000 (UTC)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de
 [88.67.202.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1EC1C1EC01DF;
 Tue, 14 Dec 2021 17:05:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1639497900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=CvKZKs3K1S02aP8gGCL57BLEXwZ8163K5Z/pwHkvTYw=;
 b=n7du2s5k71sYuAU9hRqtj10nW/i1hdOQeyxDRXOoV721Cd6Va+jNJxYyE4hfKuhZbgNNaM
 KfWPAx4LAj7GUDCTIy96twOJeqTQwVq/LtoGn8wOzH0yJpWSY/a6vtWTLmDfd/L9kbOgQ5
 amL+A6pTzbz30GvqWVxI54DllegLQ80=
Date: Tue, 14 Dec 2021 17:05:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH V7 2/5] x86/hyper-v: Add hyperv Isolation VM check in the
 cc_platform_has()
Message-ID: <YbjArUL+biZMsFOL@zn.tnic>
References: <20211213071407.314309-1-ltykernel@gmail.com>
 <20211213071407.314309-3-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213071407.314309-3-ltykernel@gmail.com>
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 dave.hansen@linux.intel.com, dave.hansen@intel.com, hpa@zytor.com,
 kys@microsoft.com, hch@lst.de, linux-arch@vger.kernel.org, hch@infradead.org,
 wei.liu@kernel.org, sthemmin@microsoft.com, linux-scsi@vger.kernel.org,
 x86@kernel.org, decui@microsoft.com, michael.h.kelley@microsoft.com,
 mingo@redhat.com, kuba@kernel.org, jejb@linux.ibm.com, parri.andrea@gmail.com,
 thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com, arnd@arndb.de,
 konrad.wilk@oracle.com, haiyangz@microsoft.com, tglx@linutronix.de,
 martin.petersen@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, robin.murphy@arm.com, davem@davemloft.net
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

On Mon, Dec 13, 2021 at 02:14:03AM -0500, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> Hyper-V provides Isolation VM for confidential computing support and
> guest memory is encrypted in it. Places checking cc_platform_has()
> with GUEST_MEM_ENCRYPT attr should return "True" in Isolation vm. e.g,

Stick to a single spelling variant: "VM".

> swiotlb bounce buffer size needs to adjust according to memory size
> in the sev_setup_arch().

So basically you wanna simply say here:

"Hyper-V Isolation VMs need to adjust the SWIOTLB size just like SEV
guests. Add a hyperv_cc_platform_has() variant which enables that."

?

With that addressed you can have my

Acked-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
