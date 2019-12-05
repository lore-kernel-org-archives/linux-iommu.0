Return-Path: <SRS0=m57D=Z3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386BBC43603
	for <iommu@archiver.kernel.org>; Thu,  5 Dec 2019 20:38:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C5524670
	for <iommu@archiver.kernel.org>; Thu,  5 Dec 2019 20:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWmiSx+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C5524670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A7A2388380;
	Thu,  5 Dec 2019 20:38:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NWzOmwR5-YJP; Thu,  5 Dec 2019 20:38:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 838618838F;
	Thu,  5 Dec 2019 20:38:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67B25C18DD;
	Thu,  5 Dec 2019 20:38:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8015C077D
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 20:38:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AAF4188B0B
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 20:38:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ETKY44TTR3V4 for <iommu@lists.linux-foundation.org>;
 Thu,  5 Dec 2019 20:38:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7897688AC7
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 20:38:48 +0000 (UTC)
Received: from localhost (mobile-166-170-221-197.mycingular.net
 [166.170.221.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B455D205F4;
 Thu,  5 Dec 2019 20:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575578328;
 bh=K7c3qaYFnXWMMqmwVGrwX7rG4+uwWtUsCcODfBtRF1k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=NWmiSx+ex1TjiKC4MaIx3xgvijveWrSbxbs+XjqnQh8NtXiBsDxOC54dxgdSCwY2Q
 JFbBLgr1/UwBKIqUKv7MLbUuUhoa33JyMTyHQS/JVBgESXzRhy4V3aJStQ6g6aSYgd
 BMEn5r9MAm2BdXlEKpf1Z9W0pYFSQT6+AX76sG20=
Date: Thu, 5 Dec 2019 14:38:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v4 8/8] linux/log2.h: Use roundup/dow_pow_two() on 64bit
 calculations
Message-ID: <20191205203845.GA243596@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191203114743.1294-9-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 Shawn Lin <shawn.lin@rock-chips.com>, Eric Anholt <eric@anholt.net>,
 Hanjun Guo <guohanjun@huawei.com>, Frank Rowand <frowand.list@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Florian Fainelli <f.fainelli@gmail.com>,
 linux-rockchip@lists.infradead.org, linux-rdma@vger.kernel.org, maz@kernel.org,
 phil@raspberrypi.org, linux-acpi@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, Len Brown <lenb@kernel.org>,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, mbrugger@suse.com,
 netdev@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Stefan Wahren <wahrenst@gmx.net>, james.quinlan@broadcom.com,
 Sudeep Holla <sudeep.holla@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 "David S. Miller" <davem@davemloft.net>, Tariq Toukan <tariqt@mellanox.com>
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

The subject contains a couple typos: it's missing "of" and it's
missing the "n" on "down".

On Tue, Dec 03, 2019 at 12:47:41PM +0100, Nicolas Saenz Julienne wrote:
> The function now is safe to use while expecting a 64bit value. Use it
> where relevant.

Please include the function names ("roundup_pow_of_two()",
"rounddown_pow_of_two()") in the changelog so it is self-contained and
doesn't depend on the subject.

> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

With the nits above and below addressed,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# drivers/pci

> ---
>  drivers/acpi/arm64/iort.c                        | 2 +-
>  drivers/net/ethernet/mellanox/mlx4/en_clock.c    | 3 ++-
>  drivers/of/device.c                              | 3 ++-
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 3 ++-
>  drivers/pci/controller/cadence/pcie-cadence.c    | 3 ++-
>  drivers/pci/controller/pcie-brcmstb.c            | 3 ++-
>  drivers/pci/controller/pcie-rockchip-ep.c        | 5 +++--
>  kernel/dma/direct.c                              | 2 +-
>  8 files changed, 15 insertions(+), 9 deletions(-)

> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -10,6 +10,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/sizes.h>
> +#include <linux/log2.h>
>  
>  #include "pcie-cadence.h"
>  
> @@ -65,7 +66,7 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
>  	 * roundup_pow_of_two() returns an unsigned long, which is not suited
>  	 * for 64bit values.
>  	 */

Please remove the comment above since it no longer applies.

> -	sz = 1ULL << fls64(sz - 1);
> +	sz = roundup_pow_of_two(sz);
>  	aperture = ilog2(sz) - 7; /* 128B -> 0, 256B -> 1, 512B -> 2, ... */
>  
>  	if ((flags & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO) {
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
> index cd795f6fc1e2..b1689f725b41 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
> @@ -4,6 +4,7 @@
>  // Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
>  
>  #include <linux/kernel.h>
> +#include <linux/log2.h>
>  
>  #include "pcie-cadence.h"
>  
> @@ -15,7 +16,7 @@ void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 fn,
>  	 * roundup_pow_of_two() returns an unsigned long, which is not suited
>  	 * for 64bit values.
>  	 */

Same here.

> -	u64 sz = 1ULL << fls64(size - 1);
> +	u64 sz = roundup_pow_of_two(size);
>  	int nbits = ilog2(sz);
>  	u32 addr0, addr1, desc0, desc1;
>  
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -16,6 +16,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pci-epf.h>
>  #include <linux/sizes.h>
> +#include <linux/log2.h>
>  
>  #include "pcie-rockchip.h"
>  
> @@ -70,7 +71,7 @@ static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
>  					 u32 r, u32 type, u64 cpu_addr,
>  					 u64 pci_addr, size_t size)
>  {
> -	u64 sz = 1ULL << fls64(size - 1);
> +	u64 sz = roundup_pow_of_two(size);
>  	int num_pass_bits = ilog2(sz);
>  	u32 addr0, addr1, desc0, desc1;
>  	bool is_nor_msg = (type == AXI_WRAPPER_NOR_MSG);
> @@ -176,7 +177,7 @@ static int rockchip_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
>  	 * roundup_pow_of_two() returns an unsigned long, which is not suited
>  	 * for 64bit values.
>  	 */

And here.

> -	sz = 1ULL << fls64(sz - 1);
> +	sz = roundup_pow_of_two(sz);
>  	aperture = ilog2(sz) - 7; /* 128B -> 0, 256B -> 1, 512B -> 2, ... */
>  
>  	if ((flags & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO) {
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 6af7ae83c4ad..056886c4efec 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -53,7 +53,7 @@ u64 dma_direct_get_required_mask(struct device *dev)
>  {
>  	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
>  
> -	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
> +	return rounddown_pow_of_two(max_dma) * 2 - 1;

Personally I would probably make this one a separate patch since it's
qualitatively different than the others and it would avoid the slight
awkwardness of the non-greppable "roundup/down_pow_of_two()"
construction in the commit subject.

But it's fine either way.

>  }
>  
>  static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
> -- 
> 2.24.0
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
