Return-Path: <SRS0=bViT=VU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A236BC7618B
	for <iommu@archiver.kernel.org>; Tue, 23 Jul 2019 15:29:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63BA2218B8
	for <iommu@archiver.kernel.org>; Tue, 23 Jul 2019 15:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UxFk0PGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63BA2218B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 136BEC87;
	Tue, 23 Jul 2019 15:29:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CDC71B49
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Jul 2019 15:29:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
	(mail-eopbgr700057.outbound.protection.outlook.com [40.107.70.57])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1BF74709
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Jul 2019 15:29:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=YYwBsSqxSUj5LMMZ4xOFbUB7BMixEJbWcipTzmJT4s5fUyjJEmPkjD8c5BHK8FPXlxTVuyZBmPMYuy/mqmYNNPsBdfVX8cU8tYLYI2I9j84alYGe8nEUirGo9bi5ws+HAyncNnxrpvUGZNtDhUhAeuKQPUr4dFFWmgtXqkyOP/K5F7/MsCfdm/X237pQDh23RXep+NmGmLIgSjOXRWG+yO+6wRNiICi2J6hG/g0F3k/S27WndwJjcAdCvJtX1fN8yfH8iZqp4aOD8U3sfUoWIzc3u1gfjlDxMaqGJ391bnuMBPCuMi4++JtES55sRFMplLpgmiZD3IkhaanWL986uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=E/oEEt6hvgilUyKbKYsYICEpJ7tiWoVli21KFnenhyU=;
	b=eU8wV5gLoGxEp9CdI4PoO8KFdLD7v8K7017LDGrgnoYYCBE981JLsuxsB97Yc88X0ih/Ts1FHoR4ySwaLHYMu5UJDl9z1yEJeHwMHUYV5x90H0IsuK/cyfBHPUo7FaSmoW8quJuo6KXnWw46BBjW8WPcC4DPrrmcA1iNLYgPuJ07y8Tq1po7afPcIyf8qSE6+D63j58D4qxOkmbYx8jztxR41VJ3o8MLZt6YeldzrC52ADCm9BIJbWwLWIiNwNI1W4JiMjPjHbfTc27w8rWpE3faya9qn4BB7tqEqWIWHWvGwsmj94VvOD35UbuSnoShJpciCrccPNAEzTf+xdb6/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
	smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com;
	dkim=pass header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=E/oEEt6hvgilUyKbKYsYICEpJ7tiWoVli21KFnenhyU=;
	b=UxFk0PGOkF9drCC6ZhyHCHtts+BqMWjfTO989c4ktEwEOvLrjWWFdt2ck5rt9C/4cLRH2n7yz0fUlHlv9Bg07LcOvVejwGJHYz6mvE3vJuBFWeYaaRTE8fvgQDXVZ+iGA0V5tZTcrGrKWoUm8YWe0s9RSNcS5VDW3CnQF9vlFNg=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
	DM6PR12MB3913.namprd12.prod.outlook.com (10.255.174.82) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2094.16; Tue, 23 Jul 2019 15:29:01 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
	([fe80::a91d:8752:288:ed5f]) by DM6PR12MB2844.namprd12.prod.outlook.com
	([fe80::a91d:8752:288:ed5f%6]) with mapi id 15.20.2115.005;
	Tue, 23 Jul 2019 15:29:01 +0000
From: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH] iommu/amd: Add support for X2APIC IOMMU interrupts
Thread-Topic: [PATCH] iommu/amd: Add support for X2APIC IOMMU interrupts
Thread-Index: AQHVO48Hx/kfNidzeESmMCe8zpPtA6bYX5MA
Date: Tue, 23 Jul 2019 15:29:01 +0000
Message-ID: <adbc96db-2574-8573-b05f-9206aa1db915@amd.com>
References: <1563251350-81400-1-git-send-email-suravee.suthikulpanit@amd.com>
In-Reply-To: <1563251350-81400-1-git-send-email-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
x-originating-ip: [165.204.77.11]
x-clientproxiedby: DM5PR1501CA0022.namprd15.prod.outlook.com
	(2603:10b6:4:9d::35) To DM6PR12MB2844.namprd12.prod.outlook.com
	(2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f7fa349-7e96-4757-9dbb-08d70f827cec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB3913; 
x-ms-traffictypediagnostic: DM6PR12MB3913:
x-microsoft-antispam-prvs: <DM6PR12MB3913F7DEF6883C357B450E7BF3C70@DM6PR12MB3913.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0107098B6C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(979002)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(199004)(189003)(316002)(58126008)(11346002)(476003)(110136005)(65826007)(66556008)(2616005)(6246003)(66476007)(66946007)(229853002)(6486002)(65806001)(64756008)(446003)(6512007)(2906002)(66066001)(65956001)(66446008)(76176011)(6116002)(3846002)(71200400001)(71190400001)(86362001)(81166006)(81156014)(31696002)(53936002)(52116002)(6436002)(8676002)(68736007)(14444005)(478600001)(25786009)(2501003)(305945005)(8936002)(31686004)(7736002)(486006)(26005)(6506007)(102836004)(53546011)(99286004)(186003)(64126003)(4326008)(5660300002)(386003)(14454004)(256004)(36756003)(969003)(989001)(999001)(1009001)(1019001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3913;
	H:DM6PR12MB2844.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KND17uQLbw5jgCnh2zcXQiJguMmQAAAkEppfo2aCkBadR6uHw1measQeWL3Lfy827V7uYV5Buev72Bx2alxVEA0cFJgwPBu/KwciPzxL1t2B8mx/W9gAxDTzH9WSTflXDwPkIH8iChLB8N01wybuD1Rvxt7qVyiIqzq+zNc3NAplf76cjbTNGPB+pav0yaov6csMMcd6ye2c7ixRqf52++Pdo+bP9sQZsVIwSImgfCVam9V32jM+2OSh4+exe1cPMPNua97JsZ5awyVJJ/cnEgPJNHL3UUwm0jlXVYN5S1L3fKeKEG79lkAYFD1TqJjkukdEUAd2cvc8KluZOtaC9Nw52rT0tFEkvBYyvgIrp6hN6/Rzxc8xsF0dJU8jd9OdksP7p+gPLMJTT1z6Lyt5fMfQJs9kI58blxuyVI1sCUY=
Content-ID: <5673A26540045742AED93E246F8989D8@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7fa349-7e96-4757-9dbb-08d70f827cec
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2019 15:29:01.4290 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ssuthiku@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3913
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

Joerg,

This patch also fixes general x2APIC support for AMD IOMMU, which
was introduced earlier. Therefore, I am including the Fixes tag here.

Fixes: 90fcffd9cf5e ('iommu/amd: Add support for IOMMU XT mode')

Thanks,
Suravee

On 7/15/2019 11:29 PM, Suthikulpanit, Suravee wrote:
> AMD IOMMU requires IntCapXT registers to be setup in order to generate
> its own interrupts (for Event Log, PPR Log, and GA Log) with 32-bit
> APIC destination ID. Without this support, AMD IOMMU MSI interrupts
> will not be routed correctly when booting the system in X2APIC mode.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd_iommu_init.c  | 90 +++++++++++++++++++++++++++++++++++++++++
>   drivers/iommu/amd_iommu_types.h |  9 +++++
>   2 files changed, 99 insertions(+)
> 
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index ff40ba7..a4c5b1e 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -35,6 +35,8 @@
>   #include <linux/mem_encrypt.h>
>   #include <asm/pci-direct.h>
>   #include <asm/iommu.h>
> +#include <asm/apic.h>
> +#include <asm/msidef.h>
>   #include <asm/gart.h>
>   #include <asm/x86_init.h>
>   #include <asm/iommu_table.h>
> @@ -1935,6 +1937,90 @@ static int iommu_setup_msi(struct amd_iommu *iommu)
>   	return 0;
>   }
>   
> +#define XT_INT_DEST_MODE(x)	(((x) & 0x1ULL) << 2)
> +#define XT_INT_DEST_LO(x)	(((x) & 0xFFFFFFULL) << 8)
> +#define XT_INT_VEC(x)		(((x) & 0xFFULL) << 32)
> +#define XT_INT_DEST_HI(x)	((((x) >> 24) & 0xFFULL) << 56)
> +
> +/**
> + * Setup the IntCapXT registers with interrupt routing information
> + * based on the PCI MSI capability block registers, accessed via
> + * MMIO MSI address low/hi and MSI data registers.
> + */
> +static void iommu_update_intcapxt(struct amd_iommu *iommu)
> +{
> +	u64 val;
> +	u32 addr_lo = readl(iommu->mmio_base + MMIO_MSI_ADDR_LO_OFFSET);
> +	u32 addr_hi = readl(iommu->mmio_base + MMIO_MSI_ADDR_HI_OFFSET);
> +	u32 data    = readl(iommu->mmio_base + MMIO_MSI_DATA_OFFSET);
> +	bool dm     = (addr_lo >> MSI_ADDR_DEST_MODE_SHIFT) & 0x1;
> +	u32 dest    = ((addr_lo >> MSI_ADDR_DEST_ID_SHIFT) & 0xFF);
> +
> +	if (x2apic_enabled())
> +		dest |= MSI_ADDR_EXT_DEST_ID(addr_hi);
> +
> +	val = XT_INT_VEC(data & 0xFF) |
> +	      XT_INT_DEST_MODE(dm) |
> +	      XT_INT_DEST_LO(dest) |
> +	      XT_INT_DEST_HI(dest);
> +
> +	/**
> +	 * Current IOMMU implemtation uses the same IRQ for all
> +	 * 3 IOMMU interrupts.
> +	 */
> +	writeq(val, iommu->mmio_base + MMIO_INTCAPXT_EVT_OFFSET);
> +	writeq(val, iommu->mmio_base + MMIO_INTCAPXT_PPR_OFFSET);
> +	writeq(val, iommu->mmio_base + MMIO_INTCAPXT_GALOG_OFFSET);
> +}
> +
> +static void _irq_notifier_notify(struct irq_affinity_notify *notify,
> +				 const cpumask_t *mask)
> +{
> +	struct amd_iommu *iommu;
> +
> +	for_each_iommu(iommu) {
> +		if (iommu->dev->irq == notify->irq) {
> +			iommu_update_intcapxt(iommu);
> +			break;
> +		}
> +	}
> +}
> +
> +static void _irq_notifier_release(struct kref *ref)
> +{
> +}
> +
> +static int iommu_init_intcapxt(struct amd_iommu *iommu)
> +{
> +	int ret;
> +	struct irq_affinity_notify *notify = &iommu->intcapxt_notify;
> +
> +	/**
> +	 * IntCapXT requires XTSup=1, which can be inferred
> +	 * amd_iommu_xt_mode.
> +	 */
> +	if (amd_iommu_xt_mode != IRQ_REMAP_X2APIC_MODE)
> +		return 0;
> +
> +	/**
> +	 * Also, we need to setup notifier to update the IntCapXT registers
> +	 * whenever the irq affinity is changed from user-space.
> +	 */
> +	notify->irq = iommu->dev->irq;
> +	notify->notify = _irq_notifier_notify,
> +	notify->release = _irq_notifier_release,
> +	ret = irq_set_affinity_notifier(iommu->dev->irq, notify);
> +	if (ret) {
> +		pr_err("Failed to register irq affinity notifier (devid=%#x, irq %d)\n",
> +		       iommu->devid, iommu->dev->irq);
> +		return ret;
> +	}
> +
> +	iommu_update_intcapxt(iommu);
> +	iommu_feature_enable(iommu, CONTROL_INTCAPXT_EN);
> +	return ret;
> +}
> +
>   static int iommu_init_msi(struct amd_iommu *iommu)
>   {
>   	int ret;
> @@ -1951,6 +2037,10 @@ static int iommu_init_msi(struct amd_iommu *iommu)
>   		return ret;
>   
>   enable_faults:
> +	ret = iommu_init_intcapxt(iommu);
> +	if (ret)
> +		return ret;
> +
>   	iommu_feature_enable(iommu, CONTROL_EVT_INT_EN);
>   
>   	if (iommu->ppr_log != NULL)
> diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
> index 87965e4..39be804f 100644
> --- a/drivers/iommu/amd_iommu_types.h
> +++ b/drivers/iommu/amd_iommu_types.h
> @@ -72,6 +72,12 @@
>   #define MMIO_PPR_LOG_OFFSET	0x0038
>   #define MMIO_GA_LOG_BASE_OFFSET	0x00e0
>   #define MMIO_GA_LOG_TAIL_OFFSET	0x00e8
> +#define MMIO_MSI_ADDR_LO_OFFSET	0x015C
> +#define MMIO_MSI_ADDR_HI_OFFSET	0x0160
> +#define MMIO_MSI_DATA_OFFSET	0x0164
> +#define MMIO_INTCAPXT_EVT_OFFSET	0x0170
> +#define MMIO_INTCAPXT_PPR_OFFSET	0x0178
> +#define MMIO_INTCAPXT_GALOG_OFFSET	0x0180
>   #define MMIO_CMD_HEAD_OFFSET	0x2000
>   #define MMIO_CMD_TAIL_OFFSET	0x2008
>   #define MMIO_EVT_HEAD_OFFSET	0x2010
> @@ -162,6 +168,7 @@
>   #define CONTROL_GALOG_EN        0x1CULL
>   #define CONTROL_GAINT_EN        0x1DULL
>   #define CONTROL_XT_EN           0x32ULL
> +#define CONTROL_INTCAPXT_EN     0x33ULL
>   
>   #define CTRL_INV_TO_MASK	(7 << CONTROL_INV_TIMEOUT)
>   #define CTRL_INV_TO_NONE	0
> @@ -604,6 +611,8 @@ struct amd_iommu {
>   	/* DebugFS Info */
>   	struct dentry *debugfs;
>   #endif
> +	/* IRQ notifier for IntCapXT interrupt */
> +	struct irq_affinity_notify intcapxt_notify;
>   };
>   
>   static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
