Return-Path: <SRS0=wClR=S7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76327C04AA6
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 21:15:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44FDB21655
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 21:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxHibykQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FDB21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0A0FD1DF1;
	Mon, 29 Apr 2019 21:15:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8AEAE1D7B
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 21:14:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3D274876
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 21:14:48 +0000 (UTC)
Received: from localhost (odyssey.drury.edu [64.22.249.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 95338215EA;
	Mon, 29 Apr 2019 21:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556572487;
	bh=XX0aTJglLKQg7dsZbY4eNn1vqzsBT3b0Sj+xLrzx0yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YxHibykQtphUqTaLCrPFMVUnoPuwdK1iYO2VrtH44UQZDBpPNEIgM+EQM+ho0ajOH
	U7bQco5v19ubB1D43u2lfNBs8KvFl6/Tbwn+o5UIMte+7mdc6Euc/IXTI8nadeZc+Z
	9qxqwwsQIbuhid6oF/FqEvGGNc8TC6PpId9D37hU=
Date: Mon, 29 Apr 2019 16:14:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v2 0/9] PCI: add help pci_dev_id
Message-ID: <20190429211446.GA145057@google.com>
References: <2e1f9a57-6d08-d017-24da-3e6b97fa2449@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2e1f9a57-6d08-d017-24da-3e6b97fa2449@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: David Airlie <airlied@linux.ie>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"open list:AMD KFD" <dri-devel@lists.freedesktop.org>,
	Paul Mackerras <paulus@samba.org>, "moderated list:ARM/STM32 ARCHITECTURE"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
	Jose Abreu <joabreu@synopsys.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Alex Deucher <alexander.deucher@amd.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Benson Leung <bleung@chromium.org>, "moderated list:ARM/STM32 ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"open list:8169 10/100/1000 GIGABIT ETHERNET DRIVER"
	<netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	David Woodhouse <dwmw2@infradead.org>,
	"David S. Miller" <davem@davemloft.net>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190429211446.BCcOXxFoI3UQkba3uALk35CK3a8tL_juIj4cSfJGaBQ@z>

On Wed, Apr 24, 2019 at 09:10:21PM +0200, Heiner Kallweit wrote:
> In several places in the kernel we find PCI_DEVID used like this:
> PCI_DEVID(dev->bus->number, dev->devfn) Therefore create a helper
> for it.
> 
> v2:
> - apply the change to all affected places in the kernel
> 
> Heiner Kallweit (9):
>   PCI: add helper pci_dev_id
>   PCI: use helper pci_dev_id
>   r8169: use new helper pci_dev_id
>   powerpc/powernv/npu: use helper pci_dev_id
>   drm/amdkfd: use helper pci_dev_id
>   iommu/amd: use helper pci_dev_id
>   iommu/vt-d: use helper pci_dev_id
>   stmmac: pci: use helper pci_dev_id
>   platform/chrome: chromeos_laptop: use helper pci_dev_id
> 
>  arch/powerpc/platforms/powernv/npu-dma.c         | 14 ++++++--------
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c        |  3 +--
>  drivers/iommu/amd_iommu.c                        |  2 +-
>  drivers/iommu/intel-iommu.c                      |  2 +-
>  drivers/iommu/intel_irq_remapping.c              |  2 +-
>  drivers/net/ethernet/realtek/r8169.c             |  3 +--
>  drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c |  2 +-
>  drivers/pci/msi.c                                |  6 +++---
>  drivers/pci/search.c                             | 10 +++-------
>  drivers/platform/chrome/chromeos_laptop.c        |  2 +-
>  include/linux/pci.h                              |  5 +++++
>  11 files changed, 24 insertions(+), 27 deletions(-)

Applied with acks/reviewed-by from Benson, Joerg, Christian, Alexey, and
David to pci/misc for v5.2, thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
