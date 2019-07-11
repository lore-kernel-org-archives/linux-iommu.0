Return-Path: <SRS0=Q5U9=VI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9698C74A35
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 12:25:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C1520872
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 12:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C1520872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4F2D84EC1;
	Thu, 11 Jul 2019 12:25:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8E3804B2C
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 12:17:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 62A34DF
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 12:16:59 +0000 (UTC)
Received: from [5.158.153.55] (helo=nanos) by Galois.linutronix.de with esmtpsa
	(TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hlY0M-00067N-Ax; Thu, 11 Jul 2019 14:16:54 +0200
Date: Thu, 11 Jul 2019 14:16:48 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] dma-direct: Force unencrypted DMA under SME for certain
	DMA masks
In-Reply-To: <10b83d9ff31bca88e94da2ff34e30619eb396078.1562785123.git.thomas.lendacky@amd.com>
Message-ID: <alpine.DEB.2.21.1907111416060.1889@nanos.tec.linutronix.de>
References: <10b83d9ff31bca88e94da2ff34e30619eb396078.1562785123.git.thomas.lendacky@amd.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
	SHORTCIRCUIT=-0.0001
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Lianbo Jiang <lijiang@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Wed, 10 Jul 2019, Lendacky, Thomas wrote:

> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> If a device doesn't support DMA to a physical address that includes the
> encryption bit (currently bit 47, so 48-bit DMA), then the DMA must
> occur to unencrypted memory. SWIOTLB is used to satisfy that requirement
> if an IOMMU is not active (enabled or configured in passthrough mode).
> 
> However, commit fafadcd16595 ("swiotlb: don't dip into swiotlb pool for
> coherent allocations") modified the coherent allocation support in SWIOTLB
> to use the DMA direct coherent allocation support. When an IOMMU is not
> active, this resulted in dma_alloc_coherent() failing for devices that
> didn't support DMA addresses that included the encryption bit.
> 
> Addressing this requires changes to the force_dma_unencrypted() function
> in kernel/dma/direct.c. Since the function is now non-trivial and SME/SEV
> specific, update the DMA direct support to add an arch override for the
> force_dma_unencrypted() function. The arch override is selected when
> CONFIG_AMD_MEM_ENCRYPT is set. The arch override function resides in the
> arch/x86/mm/mem_encrypt.c file and forces unencrypted DMA when either SEV
> is active or SME is active and the device does not support DMA to physical
> addresses that include the encryption bit.
> 
> Fixes: fafadcd16595 ("swiotlb: don't dip into swiotlb pool for coherent allocations")
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
> 
> Based on tree git://git.infradead.org/users/hch/dma-mapping.git for-next
> 
>  arch/x86/Kconfig          |  1 +

For the x86 parts:

Acked-by: Thomas Gleixner <tglx@linutronix.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
