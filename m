Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC48C433FE
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 15:45:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3188460732;
	Wed,  8 Dec 2021 15:45:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XUKxoPBTbSKw; Wed,  8 Dec 2021 15:45:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1910E60794;
	Wed,  8 Dec 2021 15:45:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6A49C002F;
	Wed,  8 Dec 2021 15:45:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77DA7C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 15:45:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 59501403EA
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 15:45:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L-G2-s_HRVVy for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 15:45:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 216AD403E3
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 15:45:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTL3jC/soHCZRgpiqGm9Ug+/yvgXqlSiCUtU/n6kCxBojGQWF1vul2ni9HhPEGpjTf3+Gmyluqfvc47ZpBs/BTkkxnvxEvDE5gbAeiFPBXGJCJ/wBrs0IISR8tvzzwqVlRq8kgw0CHG5GA/4GMdBkljzQrn7J71+e+2IGr5Df3W53c4ok41i+HGDbM/zlEoRsBvPsnbeWw5zcstF2OWrkbm3sIptmZj4IJMffj8mUn3g85Da8KoN0j/CpVRQE4ulf4PXcrS0eiTlPi5byZvEorYue+vPRs4iIOo0v6c94ZP0s58AQ7Ihj1pSpZ+rwWwcCuR0HnTKkUJejUIK0hhWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHmYS/B98+JED+8Wv+3w810KgqCQ3Nsl3heM6MOFHMY=;
 b=JuFd5s85ipvEr1iVDb/FAwb5mxYKd/ws47f8HNDdMTpxFgs24PtGeiSJObKyOzwCMNyE43Z6e1VICCw5KXC20hLcQU/f1ftbAZg7hQ62B53RYGzHmUwHwXFwNCT0L2MFFNs8x+VQlEEL7dDVuqg9q5B7DfYfxhABaezJGOjt9xcFM5a/Y/DB2qS7z80YBOZ8Th1A/YIE1ms54WRhOx1PS+PJdTgmHxEPASieSvSk/xZ/yMRx8YTEvYub4qwts9DsiwDqYj39WaewKTKYtM1PaDaG7tisGnw1Sq8gQ7p8bUMYv8u1obWIS6dr277qtY78c88quLp0MX+FfPRpZokfFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHmYS/B98+JED+8Wv+3w810KgqCQ3Nsl3heM6MOFHMY=;
 b=d5rRlYXFKdGNp5gjoAizr6qUuyQ240IxmXy4byrN/NBsSF7kmb7es7rgGhHkq2uw+XMh/4+nRRnpNkK/boGQz2+OzzlVKOf2pp3AbdB2lWcKPIKCm2BI/wEJ2CqlL7fdUHr7QmKolq83aFkqpFn8LNIJO11wnJrvjjVD/UUgiyci0oL76JpRPteNdczVCGkl7Yn73Q9CO2abg3KLv2Y2Z4QPDc2/UKpy0tPxLYx2/676IRbSGUV44DqSaJ8rW6evKbFKJqKVRFrnZBXKxqeVShOIogDr6npaEiHrBb40fem7+aAYXOTr39wrGFYjqiQ9dUE4KecYi8CDK/PRVgm8PQ==
Received: from BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13)
 by BL0PR12MB5508.namprd12.prod.outlook.com (2603:10b6:208:1c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 15:45:06 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Wed, 8 Dec
 2021 15:45:06 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.013; Wed, 8 Dec 2021
 15:45:05 +0000
Date: Wed, 8 Dec 2021 11:45:02 -0400
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 21/36] x86/apic/msi: Use device MSI properties
Message-ID: <20211208154502.GV6385@nvidia.com>
References: <20211206210307.625116253@linutronix.de>
 <20211206210438.798385721@linutronix.de>
Content-Disposition: inline
In-Reply-To: <20211206210438.798385721@linutronix.de>
X-ClientProxiedBy: BY5PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::34) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7848950a-ea12-4c39-187c-08d9ba61b492
X-MS-TrafficTypeDiagnostic: BL1PR12MB5301:EE_|BL0PR12MB5508:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB53010068C37C4A97DB7CC9F0C26F9@BL1PR12MB5301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: glWwDnif56mLRPbZ8kUqqsPht1x3doVlpO2gB4WiA/rQ0JmiR7xiLVi+BagkT77Xys7V2LD2ZpHeG34ziXTR9m/w9Kg+tBoHhoDVfKzDP6nZMN39rnDnJp6CbzpXSJ09VQx87j6jXBkVvESbkCjKAZuQDDrAjxukrej4a2Ppc0P7Vz3VwWnDrfoZ5Cftfgipbt1CumCjrHInWilFLhAgv70M98BZBCMJJmuaLUWK82JpJdvrs0MrCREQawGMsL991ws45nwvzSCcOseRTdZYL9T3rUdFlPNJRg/x3zfipl7OZ9shPvzYpJlakMKWaa8v3ukT1Ph4aCYKwE49m/l2ZGm9LWela4IIcFXh/JDfC4DugFRv8xXYFUClYsX5xB6Y9s6V0zVFgSnl0pyGOjEht0ojQ7fl1Pd470SZPDQmygZu9fvs5FNCqTTRIs1BljW7ZHYmWu+adjtPSLhH8o635Zh/BX3PJBP/RDuwoDYbYDxJIWGdaJ1mYKklA7vXkKVAOfmFYy2stVuMcAvZEwDBhmt+rwFjtS5CWx9i5HKza22VfTorwf7xjK8PmqZF7ze6oFUzZ2jyubH+pl6q4bcr0SsZQk1qQsglgvrC6YXc7Jm5k9fQa3ktr/tdi13B9x4K3wlaJgdh2svJYUfEz3jUVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(1076003)(316002)(33656002)(2906002)(7416002)(86362001)(186003)(5660300002)(2616005)(8676002)(66556008)(8936002)(66946007)(26005)(66476007)(508600001)(4326008)(6916009)(6506007)(83380400001)(36756003)(6486002)(6512007)(6666004)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZQlqhYh3++2ZcACxMS8bMJRuANV8tj8QLJhC7SeAXuQ3ILkt2f/fZogf3Xwz?=
 =?us-ascii?Q?pIR2bqPDL1Q66DQiXKrqlHBN3ZUWfr+RpfPyi3CwH8Oo+UQdpazy/ipOQayl?=
 =?us-ascii?Q?zmIZ7TrlcOtBDAgcLaeIEJkDAox1KexnOlGqPKzxPLsGiT2nyDhHWWKlrX+6?=
 =?us-ascii?Q?F1FL3vzo1lvbGPqn2XJLUmzF0WeuDgUTWvXBe+NFNB9WHAOuRX0pVzUxTCy9?=
 =?us-ascii?Q?uFURWq85J/nzBBF8R2mc5VXjo+9pGEV05vn4XEoDiioRXxxI8mXOlmx3fOk3?=
 =?us-ascii?Q?P12y/apAWO7gtBHg21LRkyY/z8DUVJinrIS0N2gSUB+DeeTPMRdvzH3W/B11?=
 =?us-ascii?Q?GMc59swR91PcgKQYzCQgSNxf+GBWcAHpYVyMv6RmM0/pMjJxvMX2/y/kgrYc?=
 =?us-ascii?Q?yHP/w3rxRJo+mAEbT5S2VYqL5b6aXY6+ETLnabvRii1onvyrcM79Sz7NEmUK?=
 =?us-ascii?Q?vrUVXg3rks0OtLieoL545yheMa5qv7b8/wgeeoqO3+FAnoV7JrNpYiL24VPI?=
 =?us-ascii?Q?G7jFNfOC3EcCwXeUUnm72+0kIsf3GBSPpEiB8nCkPa00au3Fbak/MLUXvGlZ?=
 =?us-ascii?Q?Bq/SA4xhMY0tEdeD+DYrijH9rQDXs5MRw7Dl/DI2PlOkHATVG8p+ygg4/9a3?=
 =?us-ascii?Q?nMhMigjoSXMiG7ReueZR1FVMP/oLpxphlfyfkQNHptQH1JKiqI5rq/cK3CTU?=
 =?us-ascii?Q?2wuO9ldJl6+FzECoeAcltTOgfTXhFWskBfR4c3ZmiiB3cj0ti9f2CH0N/f3z?=
 =?us-ascii?Q?QkROYmqjR+7K3PWnzelQ9QoHVzs54F4qsL2UJPuzQeYoX0DPLXrQXses4Jst?=
 =?us-ascii?Q?gArajhYIVhr/9+w02Ovnkdp8mQThsjotXYMI5n5OzLRYkXI7ORYEuQkvKP2e?=
 =?us-ascii?Q?VszthOUscvDZxaiyxpEzZaFGm8lDoAnPwxkOa5MqszALqR0lMX3Xz88TXpVz?=
 =?us-ascii?Q?Hk0BY3o/28HHLITvPj3IV7BJJDIDtZu1iYn+QoLX0UlOfr2daohJeTtdVvtD?=
 =?us-ascii?Q?4Kcbk/YzBPK6uSD9JylOBN2+favHiQzW1E1fY/K2IY2zmDj3n8iqSL74W4sK?=
 =?us-ascii?Q?RJZQltsG+S+M+Dv7nRK55s+O2rBDWmz6dsRceL9SD2MyHARAdX//UUjOrB7j?=
 =?us-ascii?Q?Z2WYLMVQlCmnQ8hfxgmvZBXOYIAaBQ4K504aKJnQQ0tYagMeKTR4PRI6mzI4?=
 =?us-ascii?Q?nzRh3LrzP2h7enG5SbtEP05k1TcEoUQ9uVFWX2ZM2TIPC0rHPj+/pzDRF4Sq?=
 =?us-ascii?Q?T18Njd8gx8xOW9sYJkGXOyS7UlV9uRamnGU+vmZKbMJksZeDnqHyOYO87aAG?=
 =?us-ascii?Q?OHe43in1TnfLkmsJr3xJ199W0bZCHnm9QFrODtW4PM9y8KUYFIEhFh3KR19v?=
 =?us-ascii?Q?OWL/NfPew69SNZACQvxs/RfNGR1pg4/d5f9gl0qchq1GmBAOqFon2ukSPGbn?=
 =?us-ascii?Q?Am18Jk7Gj7oiF6MU9ogoackgLY7rAXsSVaFjjfZgR9Sn/BGRlc1r3v1j3NmJ?=
 =?us-ascii?Q?OdLSVeNYoe3kBOFnBWtwWTNY3lyAICgc2Jxy+BNJRnKcohCZtHAYc07kPRSf?=
 =?us-ascii?Q?+fIwe9ja0to7rnh8ods=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7848950a-ea12-4c39-187c-08d9ba61b492
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 15:45:05.5723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RuoZIjeNCCpQ3AakyMBCvnQgaKTQpdCbc4ZqJ4MyQBApVoNRtiLLghWvKPfTXFb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5508
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Dec 06, 2021 at 11:39:29PM +0100, Thomas Gleixner wrote:
> instead of fiddling with MSI descriptors.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  arch/x86/kernel/apic/msi.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -160,11 +160,8 @@ static struct irq_chip pci_msi_controlle
>  int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
>  		    msi_alloc_info_t *arg)
>  {
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct msi_desc *desc = first_pci_msi_entry(pdev);
> -
>  	init_irq_alloc_info(arg, NULL);
> -	if (desc->pci.msi_attrib.is_msix) {
> +	if (msi_device_has_property(dev, MSI_PROP_PCI_MSIX)) {
>  		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSIX;
>  	} else {
>  		arg->type = X86_IRQ_ALLOC_TYPE_PCI_MSI;
>

Just thought for future

It looks like the only use of this is to link to the irq_remapping
which is only using it to get back to the physical device:

	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
		set_msi_sid(irte,
			    pci_real_dma_dev(msi_desc_to_pci_dev(info->desc)));

	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
		return get_device_id(msi_desc_to_dev(info->desc));

And this is super confusing:

static inline int get_device_id(struct device *dev)
{
	int devid;

	if (dev_is_pci(dev))
		devid = get_pci_device_id(dev);
	else
		devid = get_acpihid_device_id(dev, NULL);

	return devid;
}

How does an ACPI device have a *PCI* MSI or MSI-X ??

IMHO this makes more sense written as:

  struct device *origin_device = msi_desc_get_origin_dev(info->desc);

  if (dev_is_pci(origin_device)
      devid = get_pci_device_id(origin_device);
  else if (dev_is_acpi(origin_device))
      devid = get_acpihid_device_id(dev, NULL);

And similar in all places touching X86_IRQ_ALLOC_TYPE_PCI_MSI/X

Like this oddball thing in AMD too:

	} else if (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI ||
		   info->type == X86_IRQ_ALLOC_TYPE_PCI_MSIX) {
		bool align = (info->type == X86_IRQ_ALLOC_TYPE_PCI_MSI);

		index = alloc_irq_index(devid, nr_irqs, align,
					msi_desc_to_pci_dev(info->desc));
	} else {
		index = alloc_irq_index(devid, nr_irqs, false, NULL);

This should just use a dev and inside alloc_irq_table do the dev_is_pci()
thing to guard the pci_for_each_dma_alias()

Then just call it X86_IRQ_ALLOC_TYPE_DEVICE (ie allocated for a struct device)

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
