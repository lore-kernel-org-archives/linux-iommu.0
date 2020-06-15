Return-Path: <SRS0=8EFN=74=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371D1C433E0
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 14:50:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF5920644
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 14:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VprH3CbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF5920644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9D3B423B44;
	Mon, 15 Jun 2020 14:50:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c1yBMXaCtZXT; Mon, 15 Jun 2020 14:50:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5745E20467;
	Mon, 15 Jun 2020 14:50:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B838C0888;
	Mon, 15 Jun 2020 14:50:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FABBC016E
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 14:50:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F137187F49
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 14:50:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q7+-cCI22jEv for <iommu@lists.linux-foundation.org>;
 Mon, 15 Jun 2020 14:50:47 +0000 (UTC)
X-Greylist: delayed 01:59:22 by SQLgrey-1.7.6
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BB82C87F0A
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 14:50:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AO1pMwKSyQHpWSTu9jpWY2LdE5xoYnJBoIcBpuIv0PyclGYPHHvNneqZ3V0Y1BjOoMrKi6OTR1TT0bOKrCfdwvs41d/VFGlt6T8Hb0b9mzQLTVNvTeTRPDJrRXvv4bl7JZa+Wxgm2Itzdacj33WCme+BvS1FbUNlPy+HNGaNrsRGZ2VmWSOCjO/RMo+Vh7dWefZkg/ByoMbLeXPFJ/rb7EsUHwMYus6u9NNd1G2h08Kb5Jfo7I+ACuhTojlTXdm234YwaJ+WfTM49XJIy7sUX3F6rjSIlruid9sKEv0wuwcHTSH7sv+UhJsung4j5RmfEyOlozhzdpNw+ECHs02oOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMyxvV2FGeT9TepR4Hegun/+h4YMEw7pyq/mA4nY0+U=;
 b=XuaD2c18idH6OmrTHnw0YVsz/fa6zy9m558G0Q7oEV+xxpPj9d2WFDE4ieS8cd71vk4NyW+LV+/7nCdrR7vRJ2cCb22iMfUOjBWIrStjuB+MJPym8m0Bfpi4KKO7efTrAkMX0/aXAUoisvO/ojEWRdvHKS4fixmQt3hsd9EuKKuFYfhJTkrCs/+pySofqyHjaqfmwZ8lxuly7TGlfW7bRQxW/nrjU0AF88u8IiHvyU+nphPqg6pnTjtdHwRKg5Fv0DFpdC9MHOC/bBpnY2hK0ebVYBW+u+se8GGjvu8f9BmU/LpYmA9nZibccNMZp4ypkDlD5iUqsMDb7IRuRruv8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMyxvV2FGeT9TepR4Hegun/+h4YMEw7pyq/mA4nY0+U=;
 b=VprH3CbKddnoL+7R+e4FhPWjKr+MTE2t/a92vqbGBHXZn1aNpG5MpxyaI1rgqBz8Opwpn+5eDXo6Lg01jyd8dlmBySd8vdCfLrkTYNqbVdfXZRRzsDuV4VOU8PDv9GQ5e3LEjVFi/jn+JQaVAjVgXOOhD/+IsFe5r1McPA19SjQ=
Authentication-Results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18; Mon, 15 Jun 2020 12:17:01 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::c1bc:8ef9:9ba3:99bf]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::c1bc:8ef9:9ba3:99bf%10]) with mapi id 15.20.3088.029; Mon, 15 Jun
 2020 12:17:01 +0000
Subject: Re: [PATCH 2/2] iommu/amd: Move Kconfig and Makefile bits down into
 amd directory
To: Jerry Snitselaar <jsnitsel@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20200612231100.293734-1-jsnitsel@redhat.com>
 <20200612231100.293734-3-jsnitsel@redhat.com>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <357cfad9-75d5-f7cb-93e6-f85e6056c309@amd.com>
Date: Mon, 15 Jun 2020 19:16:50 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
In-Reply-To: <20200612231100.293734-3-jsnitsel@redhat.com>
Content-Language: en-US
X-ClientProxiedBy: KU1PR03CA0001.apcprd03.prod.outlook.com
 (2603:1096:802:18::13) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (165.204.80.7) by
 KU1PR03CA0001.apcprd03.prod.outlook.com (2603:1096:802:18::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.7 via Frontend Transport; Mon, 15 Jun 2020 12:16:59 +0000
X-Originating-IP: [165.204.80.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 78847aa5-3fd5-4b26-c467-08d8112601df
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44357BA1B6074014D9CEC1F3F39C0@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TTpeVAuHUVggxIFu65i1abImw42wPJeV8Ryh3qRaVGN83Com1bKl541w2DvpFlRpw/ynOjsCTJw8bzdjjBPXO202orRlVPB7O6CVWF3FkokGMx2mjW/Bs8CQrhKTtd7NTsigW8J+uB+yXnGQZKdiNT+7SvUs4ArNLqpug8lqGJ5cGGseMMwqT3CH3jdci3UGBVEthrGjr42CUdZEYkfViIJnghvBOXT9wwHP8xfHuvc6c2xu6c8tehYfPreYGrtCarrVlteQpaOKBQkV/AKhsPydhn8ASYmiJ5w9hwsCWsBGn+TEOR2jszfSoJ1+SnxtlbBXpIxlvcXs8wH/rMOTZs7RurzL0Dc4yAqfnfz4xfmXTP7iQPQZQCJWpqImAqpnb9cQV7lZpwqkXkZIf+bVnYpyYkc45OHWGTjxh65ptTTn5yUwtrgrp8iguDNNUCfz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(8676002)(83380400001)(5660300002)(6666004)(478600001)(8936002)(4326008)(2906002)(6506007)(53546011)(316002)(36756003)(66476007)(26005)(66946007)(66556008)(31686004)(86362001)(956004)(52116002)(6512007)(31696002)(44832011)(6486002)(2616005)(16526019)(186003)(141333003)(181643002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: lsh2IaLyut6kJaO596EU6GtmO0/0SpugbdN2p9KOHNzKSmU/fHMM5VHM4waRkdHDKeMeXczICW5w4CqkbMbztrWxBjtSFqCfM0M6fSopWiaYK2NJMH9l1MTnWuqAn01Dw+OkdLeWN4wCCvBNjiRRB6ladizkoG+qI8sYRqDH2Ae7YtMDE2vtSS2DmJddcvp2h0inWRbItCaATNBYejh8exOnNooTsO9j2ZfZYiIMBQCVSW2z2/opJcHhPJsWBxCSPLgqMtkUDBDTL5YTvTwUzjsU9aZudPa8xe7ellaxJaWiS3II64rtmoc/GisFX6yHhGFXQ7IF6dIAtkmea1mLDQe9d6XoW8gOJHFr8uU/oaX4FvDfTh+y/WgKP/OoE424/Ymgw3QIlWeZUx5pRd/JXhuRq0dsYARWKr/qhPKT8M4ThDfivTn7c5GVYEe1Qii2G3tfnixhuc1rLlKmyGXPYz8FKt+kV8qocsZbmmmSEy4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78847aa5-3fd5-4b26-c467-08d8112601df
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 12:17:01.4564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbgyCUmG7Y2qnmHXF6AoXicry1OUTIUcAfKtW8vyp6+2Ts9A1b7uWNQg/j4q4Q4jJOvJ1Rp1GZLZxKqyFk9CQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Thanks,
Suravee

On 6/13/20 6:11 AM, Jerry Snitselaar wrote:
> Move AMD Kconfig and Makefile bits down into the amd directory
> with the rest of the AMD specific files.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
>   drivers/iommu/Kconfig      | 45 +-------------------------------------
>   drivers/iommu/Makefile     |  5 +----
>   drivers/iommu/amd/Kconfig  | 44 +++++++++++++++++++++++++++++++++++++
>   drivers/iommu/amd/Makefile |  4 ++++
>   4 files changed, 50 insertions(+), 48 deletions(-)
>   create mode 100644 drivers/iommu/amd/Kconfig
>   create mode 100644 drivers/iommu/amd/Makefile
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index b12d4ec124f6..78a8be0053b3 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -132,50 +132,7 @@ config IOMMU_PGTABLES_L2
>   	def_bool y
>   	depends on MSM_IOMMU && MMU && SMP && CPU_DCACHE_DISABLE=n
>   
> -# AMD IOMMU support
> -config AMD_IOMMU
> -	bool "AMD IOMMU support"
> -	select SWIOTLB
> -	select PCI_MSI
> -	select PCI_ATS
> -	select PCI_PRI
> -	select PCI_PASID
> -	select IOMMU_API
> -	select IOMMU_IOVA
> -	select IOMMU_DMA
> -	depends on X86_64 && PCI && ACPI
> -	---help---
> -	  With this option you can enable support for AMD IOMMU hardware in
> -	  your system. An IOMMU is a hardware component which provides
> -	  remapping of DMA memory accesses from devices. With an AMD IOMMU you
> -	  can isolate the DMA memory of different devices and protect the
> -	  system from misbehaving device drivers or hardware.
> -
> -	  You can find out if your system has an AMD IOMMU if you look into
> -	  your BIOS for an option to enable it or if you have an IVRS ACPI
> -	  table.
> -
> -config AMD_IOMMU_V2
> -	tristate "AMD IOMMU Version 2 driver"
> -	depends on AMD_IOMMU
> -	select MMU_NOTIFIER
> -	---help---
> -	  This option enables support for the AMD IOMMUv2 features of the IOMMU
> -	  hardware. Select this option if you want to use devices that support
> -	  the PCI PRI and PASID interface.
> -
> -config AMD_IOMMU_DEBUGFS
> -	bool "Enable AMD IOMMU internals in DebugFS"
> -	depends on AMD_IOMMU && IOMMU_DEBUGFS
> -	---help---
> -	  !!!WARNING!!!  !!!WARNING!!!  !!!WARNING!!!  !!!WARNING!!!
> -
> -	  DO NOT ENABLE THIS OPTION UNLESS YOU REALLY, -REALLY- KNOW WHAT YOU ARE DOING!!!
> -	  Exposes AMD IOMMU device internals in DebugFS.
> -
> -	  This option is -NOT- intended for production environments, and should
> -	  not generally be enabled.
> -
> +source "drivers/iommu/amd/Kconfig"
>   source "drivers/iommu/intel/Kconfig"
>   
>   config IRQ_REMAP
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 71dd2f382e78..f356bc12b1c7 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -1,5 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
> -obj-y += intel/
> +obj-y += amd/ intel/
>   obj-$(CONFIG_IOMMU_API) += iommu.o
>   obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>   obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
> @@ -12,9 +12,6 @@ obj-$(CONFIG_IOASID) += ioasid.o
>   obj-$(CONFIG_IOMMU_IOVA) += iova.o
>   obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
>   obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
> -obj-$(CONFIG_AMD_IOMMU) += amd/iommu.o amd/init.o amd/quirks.o
> -obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd/debugfs.o
> -obj-$(CONFIG_AMD_IOMMU_V2) += amd/iommu_v2.o
>   obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
>   arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
>   obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
> diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
> new file mode 100644
> index 000000000000..1f061d91e0b8
> --- /dev/null
> +++ b/drivers/iommu/amd/Kconfig
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# AMD IOMMU support
> +config AMD_IOMMU
> +	bool "AMD IOMMU support"
> +	select SWIOTLB
> +	select PCI_MSI
> +	select PCI_ATS
> +	select PCI_PRI
> +	select PCI_PASID
> +	select IOMMU_API
> +	select IOMMU_IOVA
> +	select IOMMU_DMA
> +	depends on X86_64 && PCI && ACPI
> +	help
> +	  With this option you can enable support for AMD IOMMU hardware in
> +	  your system. An IOMMU is a hardware component which provides
> +	  remapping of DMA memory accesses from devices. With an AMD IOMMU you
> +	  can isolate the DMA memory of different devices and protect the
> +	  system from misbehaving device drivers or hardware.
> +
> +	  You can find out if your system has an AMD IOMMU if you look into
> +	  your BIOS for an option to enable it or if you have an IVRS ACPI
> +	  table.
> +
> +config AMD_IOMMU_V2
> +	tristate "AMD IOMMU Version 2 driver"
> +	depends on AMD_IOMMU
> +	select MMU_NOTIFIER
> +	help
> +	  This option enables support for the AMD IOMMUv2 features of the IOMMU
> +	  hardware. Select this option if you want to use devices that support
> +	  the PCI PRI and PASID interface.
> +
> +config AMD_IOMMU_DEBUGFS
> +	bool "Enable AMD IOMMU internals in DebugFS"
> +	depends on AMD_IOMMU && IOMMU_DEBUGFS
> +	help
> +	  !!!WARNING!!!  !!!WARNING!!!  !!!WARNING!!!  !!!WARNING!!!
> +
> +	  DO NOT ENABLE THIS OPTION UNLESS YOU REALLY, -REALLY- KNOW WHAT YOU ARE DOING!!!
> +	  Exposes AMD IOMMU device internals in DebugFS.
> +
> +	  This option is -NOT- intended for production environments, and should
> +	  not generally be enabled.
> diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
> new file mode 100644
> index 000000000000..552f68ddcefd
> --- /dev/null
> +++ b/drivers/iommu/amd/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o
> +obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
> +obj-$(CONFIG_AMD_IOMMU_V2) += iommu_v2.o
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
