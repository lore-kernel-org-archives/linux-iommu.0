Return-Path: <SRS0=codQ=S4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6411AC43218
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 13:50:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D290206E0
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 13:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D290206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0AC0027DD;
	Fri, 26 Apr 2019 13:50:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7670E27DC
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 13:47:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4F331875
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 13:47:31 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 590925F7; Fri, 26 Apr 2019 15:47:29 +0200 (CEST)
Date: Fri, 26 Apr 2019 15:47:28 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v2 7/9] iommu/vt-d: use helper pci_dev_id
Message-ID: <20190426134727.GE24576@8bytes.org>
References: <2e1f9a57-6d08-d017-24da-3e6b97fa2449@gmail.com>
	<0889204c-18aa-8a5f-1781-aaf32ee5beba@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0889204c-18aa-8a5f-1781-aaf32ee5beba@gmail.com>
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
	Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <20190426134728.m7hKiVCysMupb1y3kQaadt7L5ARZaA20W5BNV4wVv-g@z>

On Wed, Apr 24, 2019 at 09:16:10PM +0200, Heiner Kallweit wrote:
> Use new helper pci_dev_id() to simplify the code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Joerg Roedel <jroedel@suse.de>

> ---
>  drivers/iommu/intel-iommu.c         | 2 +-
>  drivers/iommu/intel_irq_remapping.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index d93c4bd7d..3f475a23a 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1391,7 +1391,7 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
>  
>  		/* pdev will be returned if device is not a vf */
>  		pf_pdev = pci_physfn(pdev);
> -		info->pfsid = PCI_DEVID(pf_pdev->bus->number, pf_pdev->devfn);
> +		info->pfsid = pci_dev_id(pf_pdev);
>  	}
>  
>  #ifdef CONFIG_INTEL_IOMMU_SVM
> diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
> index 634d8f059..4160aa9f3 100644
> --- a/drivers/iommu/intel_irq_remapping.c
> +++ b/drivers/iommu/intel_irq_remapping.c
> @@ -424,7 +424,7 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
>  		set_irte_sid(irte, SVT_VERIFY_SID_SQ, SQ_ALL_16, data.alias);
>  	else
>  		set_irte_sid(irte, SVT_VERIFY_SID_SQ, SQ_ALL_16,
> -			     PCI_DEVID(dev->bus->number, dev->devfn));
> +			     pci_dev_id(dev));
>  
>  	return 0;
>  }
> -- 
> 2.21.0
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
