Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC49E3AC0E7
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 10:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785233509; cv=fail; b=kOjuUioYpgRFgjd5pbPbPzE50mCZcTBmNmG3mR1FV2L9Mq+3VhCBE3q48Vq+SzNfkhIHcVnEad5lEqsoDV4GTXvFxVQfhiACXNfvrG3huhpj+lM9fJIofZ84NcKv9lE7q/RASkBgSD0G6NcJdO87kWBOkOfrt3D+wUUlu3OrpjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785233509; c=relaxed/simple;
	bh=voYzZVYwlnlkwug6QdYncLom8Dfe8Yb2itgw+Tu7358=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MME5pfv7L7eM4KMO+dZt3ieKhlBdZmfp3Iiax+IVg+JORbsRTa6o9B1DKu+ogRfbzzDUVNPkD+loR1o+sHrr42VhQ2Hv9NSt682Mn0tE1Mbr/qDLEhDTAsn9JRDxdk/ASAV7YkXm+blhwn1pWGislIWW5/L/kl6Uguapnv6eNHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QMDsNcKO; arc=fail smtp.client-ip=40.107.209.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QMDsNcKO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDWeSYhKNEQwGkHXAMtf3U3uQJoo3zfoy2ZJWesg3az/R0pbrOalmnfd1AO3LM2fRMPwpbCLTrlehYKDrhD+SVaJ52mOPhzMyY2B5sMlNPhHPORjQcSm3YeLjV5zkjePCuDz4nkPxGbltXpAmMzdO66OSzceNEY8+VZ1QHZaUfDbBLPHZGsmt3cMFpzzr+qWfeflPg3OuebjDRl4YWCDFKjk7qEKUgzNHhUHm6aFc1qTN11ehwQYJKiTpfOH88HfFR84zA5DJC6+7CkdT+8jXtbruT+p+931RzgwxHgQUNsASncP9kUoo7l+csRNMGqKL2GyYZh7E7MBJEP4n6OoPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vasu7Q0ijUNfzHiJI8a1SIMtgyeEYhSOypix5fKyK6E=;
 b=XZrqRy+lrLHjCsGaTA2qiE2MQ+JnqiRGBU0UA+VY681ta07wlrZdb18zZqV7gLxRPIECcF8ggoi6yBZoLFzERkWST6cJY7nHNTnDM95U/JWZv48GtNkw/05Bky0PRKrYZz5NtKazbKUW6AZ5NLkDrqxFRpmDLcpabcbtiUz2WSQdYIvJ58vlFeKyrffrogGja1Db3cdslmQqDmaH8S7+p9CiqlGg5YYMNwmviOEnQ/z7a936yvHuBrnNYPMC2/Or/gk/owPSrUPJ00nLbSfzkK/k3ACJy5x01liILyopRzliMcNvRrGGBrH/yG2b4jhqSJc0D0v2zT6G85tsZjzpXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vasu7Q0ijUNfzHiJI8a1SIMtgyeEYhSOypix5fKyK6E=;
 b=QMDsNcKOaYDDncrkobsUJBM0SdmK3dvm40pY2/RuZWAhwQwiEOfVHu5v5bak4bm/W1Hpbni/lrju24EOcrkkPsb1bGWdB0wAj4O52AA++7hHPuUOFoTTCMWCfLxVW4FeBuIPNOsvGNrsRziygQXDk25A0d287a9+eT8UIjNXIEEGQY32iIk/sBPvSnwBQ2HG45izw3darwFIZpMqpAQEmtt8H8c/d/cToSuoESBSNxCtFOUYB/DuxOihAMX6MHgmdHOSesOVA6SwKVHrO2o3xiAfXtwWO1LsJgY9Pz5++E4pjBueA5v0Y77Bxe89yiIVqwRtPI+qtDbnp1O88x2AAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CY8PR12MB7756.namprd12.prod.outlook.com (2603:10b6:930:85::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 10:11:41 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 10:11:41 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-tegra@vger.kernel.org, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject:
 Re: Fixing TegraDRM on multi_v7_defconfig / Enabling DMA API with tegra-smmu
Date: Tue, 28 Jul 2026 19:11:33 +0900
Message-ID: <mhoTTfeISomvwxSD3zp57g@nvidia.com>
In-Reply-To: <910d1492-ad3b-4201-93c6-208be1dcde7d@arm.com>
References:
 <erKxvAxkSpOaODz6rOpDbQ@nvidia.com>
 <910d1492-ad3b-4201-93c6-208be1dcde7d@arm.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4P301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::7) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CY8PR12MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: 910e896d-df7c-4939-f580-08deec909eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|23010399003|4143699003|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	J7Xem96TzZEKZ8OSVdh0xt5sVtcf2CR6NSy7oQ70gb3iTEKaBUFtJO/VBTv+1QMJ9xp/SwJMzumbRcTwD/4Em3pJCMuo4DYA23dnsQb98AcIgXbnWCs/rFHN7ACzrynxZa3riJwMMA4Y+2XoYtESt9hg3qrwqr+wYY8z8UF+jyCc9n+A007Lqqho3Wg0Ur92brqdI4xHJ5/JWKpoYzA5xjlwl8pgE8SUTxeqY6umgBAIdQJjsfRNuzywyLCxhjTgwQ/r0ud3eYWrlJ+/QottMoZd6cOy7LuBIqG3xgRSQJhtYrxDeQux9UaN3SX46uGp7Rpus5c95DU0KOnUijPAwSg2mykOJ+WxLtTChvEGS2AkeGI0W0iohpZxoh49einGSQSWDyrY8l0Z36SOv4R6lNfcQhZ1VDvL3f9UDFqKlXJVzljmGDGumbk+ramLEQe/jejJKoPTCY+j8gU0i35z0ApeZjQDvrncWWAiUJ5TzDGiqJ4GjvzhAgPvTSuW7TEO+LLrWfFQiqT5O4y8qMJZz5h/syr8dMz6HuoU9x45mdS1O0CN7VWZRtH9aglzQWQnFzSrxdtOKQ9NWMw7UrKyG0IAXeMO1f97p4lQ8OA7oTV0Oi9bFD4cpGm5Nqb3OCpgUV3KlrgkMyjEOY+tRiVl+C3iNdKgPZRdl5mHViUY1V8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(23010399003)(4143699003)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHRvS3R5ZVI4R1FqTUttOHduVHBhVVg2aUgwZk1xV1dZWWQ5MzliWHpyZDZl?=
 =?utf-8?B?Q1pBS2VkQTR1MzRuZFdsVFZDUHRVSjBuSXg5Q1pIeHB1Tk9NcTJuMWttOUE2?=
 =?utf-8?B?anJSQzFwcjYraFdxZ2Rjb2RkZzUwbURLS0dVTWN1VE5COUxXMkRua3lTR0E3?=
 =?utf-8?B?a0R4czEvemMvejloTEx0T3BBNmVsWEh1VDNtYkxVWUxNZEY0VlIzUkFTMS9J?=
 =?utf-8?B?U2grYUpQZ2JkR21WZlFKRFZuOGlTejhqOHg2TGt3SDNqTlEybXRlSjVuRFc5?=
 =?utf-8?B?dnRmVFNnRjkyV3ZoTVF2VytLV1VNcmkwcm8wUml6MUMyTTVuSnByRHpMWVRp?=
 =?utf-8?B?SGROWkdMMG4xQXEvazVGM3p3THJ1WFhmeW1kNmxpODNtNXVvK29xNUhRdG04?=
 =?utf-8?B?eDZEcmlNK3NYZFkrQVZXSERBUnM3L1FYdFFCWUV6ay9zU1h1dzA5WWkyRllS?=
 =?utf-8?B?RTN2NHR5TUQ2SUVnSFRJZ08yVFVYYlovOUoxRCs3eTY1ZVpmQXpUMm5IUDFv?=
 =?utf-8?B?M0pYc1dpTklWdVlWTFZxa3JXWi9vUDQ5aWQwL3J1VEplZ0I4TmYyQS9Kc2tm?=
 =?utf-8?B?dnBTYXRROEE1MWJaSWk4amFTT0UwWjg5cFJueHAvNjZHSit2MTdJYi8wcERF?=
 =?utf-8?B?Q1B3R2hMOHdnUFJJa010dnRycXZKTEpmT3o3OCtBZFEweG9IRHd3bTVVMGlm?=
 =?utf-8?B?NWhsUFVzc29pNVJvcEV4TEh3RlFsMUpxaHo0N2dWeXpaN3FMdDFyQm51eUJh?=
 =?utf-8?B?L3BmLzNqOFUrU1NXMXVzRXF3VGVKTmpNL3N4Y0dGTHYySTY2WlF5WFpnT3Za?=
 =?utf-8?B?TmdlYnR5Yzc4UU5xNEZwcktPY08rSTNFRWZKb0hpT1NpVjl2TTFPRHVBdzky?=
 =?utf-8?B?Sy8xcHZ3VWpONjBrWUROQU5Mc0ZDNThVRS9zTUpzbHV5d3R2NWVjZEJ6Z0tT?=
 =?utf-8?B?TGgrejBIOC9hRjJqd2txb3l2cDhlODFwKzJVbzJhZzlWdjkxT3FqNzFhWDg3?=
 =?utf-8?B?Qm92eTFINDRDaHZheUs3VGxicEhpKzhMNUtwVUI5V2hHN3BKc1JXa0NpVUZM?=
 =?utf-8?B?R28wMW9Ec1c4SjRmVnMrVUhkWU1WQWpIMk1LditiZ1Y5OU5ZWFJGb0FhaW14?=
 =?utf-8?B?Mi9iQ1FVYU1IcVEvV3BTSUQrZkM0V0pVWjFicGpGV0JnYVd2VmgrNTRKLzJo?=
 =?utf-8?B?YWpQTk5DNHdtQlAvYjRDaVBHQkR5aWQ3eFM2VWdIOGQxZ3hveFlhM3FJR01C?=
 =?utf-8?B?SXQ3MGZvaW9YYjZqVmFqNEF0REU3TlZVNlQ3Z0JBcVRrY1JjRnJ5MytqUHZr?=
 =?utf-8?B?M0VOMTFDWUMzZDkzVGNrQ0g1UEVtbjlQU2orUjZOSm5Td0ZqYmsyM0g3Tlox?=
 =?utf-8?B?cjFHa000STNGbzlMTzc0dWEvajJYczFHanZDanlrOXVhOGpLK2VrdVcvR0hm?=
 =?utf-8?B?YjZ6T3FxZ3Z5QnZxK0NWNXBKODNuNGN3K1R4MWU2ZURSR2U5YzREMVlvLzFa?=
 =?utf-8?B?NXZGSmdYb1FSOFJSOEFIZ210M0xJK0RKRStMNGZrUUdGQUJhcFJFY0tjN1lU?=
 =?utf-8?B?Q1VMcy9NQVhJSjkzM1duU3VyRHNZd3NHcnN6WWJuSXp0TkdZSHR6ZFYveG55?=
 =?utf-8?B?b1RuTU42ckk4Y0l0SDBuZzB3UlNWZDVjVkhTSThIWEI2UjRFc1luVkN0Z3gr?=
 =?utf-8?B?VlovR0tyb1BFNXVWZXlyZWt5ZHFWQnRuRi85Wnh0UWhNR1NaaC9jY0RrdU1t?=
 =?utf-8?B?eDJGNE9zN3VRUGErL3ZrRnR2QlU0ZTlmZWthTUdRbFd1SmY3RU9ncHdDaTgw?=
 =?utf-8?B?aThnVmRwaWoxOXZZMWxoNE9pSmdndGxkaGh5ZmdQZTFXcUxmVUNpV2V4YUd0?=
 =?utf-8?B?NjRIbzVTSCtHV1YzMEt3N0xMZDdvY2g2N2dWZnh1MG41eGpIaUkvZ012b2Qy?=
 =?utf-8?B?WFBITEpXaWlZczFRU29VSThJdG5Mc1F2bVpvQk1ib01UWUVleHludk1GU05T?=
 =?utf-8?B?Ujl2MW9LTlJpbUpxSS9mMGdqUGNWcjJUWnlhQ2Vjd0ZTUUxFNTFXVmNjYW1s?=
 =?utf-8?B?aWlrb294MlA1TFdDL0hOcVNGMmNqU1ZtYkduMVF5aFpmdDg0ZW9NR204d2NV?=
 =?utf-8?B?cnNlbTBZVXFhYXhvMEtBalpCRlYxV3hhc2RtNUlPNHVPMWNNUkdNclA4SWUw?=
 =?utf-8?B?UUFPN0tlSTV1QnNuOHNyMEFxemFpTG1jdXZHTlU4cDFEWjFrcXB2dDQ2bERI?=
 =?utf-8?B?Sms0OUtweS9CMkdUWTBTTlVTZmNXMmdSVjczRTZ1OVpMRnduSjJKRytlSXNw?=
 =?utf-8?B?N1QxUWhJazV3SEprQWJFZ2s1L1RpTGk4TjdWSU4xaU1GZ0VFSzc2MHRFSTFY?=
 =?utf-8?Q?kBcmVn+5pPH64O1Zm5yEIfSvY5D/Pp3R7nDiYfyT8RLUx?=
X-MS-Exchange-AntiSpam-MessageData-1: cltTns8YCBeINw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910e896d-df7c-4939-f580-08deec909eaa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 10:11:41.6289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JotO0padxatXB8w54JHFhUl2pGVsTsDO9fjYhUlrcr5Uy4OCoe9bqXUDLQMMCCzmHjtvFU8E3K4cZpSmM8Y/CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7756

On Monday, July 27, 2026 11:51=E2=80=AFPM Robin Murphy wrote:
> On 24/07/2026 8:35 am, Mikko Perttunen wrote:
> > Greetings everyone.
> >=20
> > I've been looking at enabling more CI for 32-bit Tegra platforms
> > recently, and I ran into a problem with TegraDRM not probing on
> > tegra30-cardhu, but only on multi_v7_defconfig.
> >=20
> > I traced the issue to the following sequence of events:
> >=20
> > 1. On multi_v7_defconfig, CONFIG_ARM_DMA_USE_IOMMU is enabled, while on
> >     tegra_defconfig it is not. This causes arm_setup_iommu_dma_ops to r=
un
> >     on TegraDRM devices.
> >=20
> > 2. Some of these devices will be placed in a single IOMMU group by the
> >     tegra-smmu driver. When arm_setup_iommu_dma_ops is called, dependin=
g
> >     on probe deferrals, the group may have only the currently probing
> >     device, or a previously deferred device and the new device.
> >=20
> >     arm_setup_iommu_dma_ops calls iommu_attach_device. If the device is
> >     alone in its group, this succeeds. If not, this fails. If
> >     iommu_attach_device fails for every device in the group, everything
> >     is "fine" and TegraDRM goes to probe and work fine. Hence let's
> >     assume we have one device that succeeded the attach.
> >=20
> > 3. iommu_device_use_default_domain gets called and succeeds on the firs=
t
> >     device in the group. On the second device in the group, it fails
> >     since group->owner_cnt was already 1. The custom ARM DMA IOMMU
> >     implementation uses a custom UNMANAGED domain so the domain !=3D
> >     default_domain check evaluates to true.
> >=20
> > 4. Devices fail to probe which leads TegraDRM overall not to probe.
> >=20
> > I've thought of the following options to fix this:
> >=20
> > 1. Match behavior with tegra_defconfig: Figure out a way to not run
> >     arm_setup_iommu_dma_ops for this situation (ideally any multi-devic=
e
> >     group situation). However, I'd also like to enable DMA API with
> >     tegra-smmu to get rid of the manual IOMMU API code paths in TegraDR=
M,
> >     so this is not a particularly satisfying route.
> >=20
> > 2. Improve the legacy path: Fix the ARM IOMMU DMA code to support
> >     groups, and add an exception in iommu_device_use_default_domain. Bu=
t
> >     I presume we don't want such non-trivial modifications to that code
> >     at this point.
> >=20
> > 3. Modernize: Support CONFIG_IOMMU_DMA on ARM -- since there is an issu=
e
> >     with per-SoC quirks, I think this should be done one SoC at a time.
> >     So come up with a way to dynamically pick between the legacy and
> >     IOMMU_DMA paths. Perhaps if the SMMU driver explicitly requests the
> >     DMA domain type, use the modern path. Currently, CONFIG_IOMMU_DMA a=
nd
> >     CONFIG_ARM_DMA_USE_IOMMU are mutually exclusive so that has to be
> >     changed.
> >=20
> > FWIW, if we are to move to using DMA API with TegraDRM, one blocker
> > would have to be resolved: boot splashes scanning out while the DMA
> > domain is being set up. Since we cannot really use the iommu-addresses
> > reserved-region device tree bindings with these old devices, my thought
> > is to leave the display memory clients in bypass in tegra-smmu until th=
e
> > display driver has quiesced the hardware and can then call into
> > tegra-smmu to enable translation.
> >=20
> > Please let me know what you think and whom I missed in the To/Cc fields=
.
>=20
> TBH I rather feel like the time for converting ARM to iommu-dma has=20
> passed - there are drivers which rely on specific behaviours of the ARM=20
> IOVA allocator which iommu-dma does not match, and meanwhile iommu-dma=20
> continues to grow more server-specific features which would be nothing=20
> but bloat on ARMv7 systems with <=3D2GB of RAM and no virtualisation. At=
=20
> this point I'm inclined to treat the existing DMA ops as legacy code=20
> like with alpha/sparc/etc.
>=20
> While there is technically an option 4, to have tegra-smmu do what=20
> ipmmu-vmsa and mtk_iommu_v1 do and go coercing the ARM dma_iommu_mapping=
=20
> into groups behind the arch code's back, I am also still hoping to get=20
> rid of that and the messy probe_finalize step altogether. FWIW my=20
> preference would be some form of option 2 - off-hand I imagine you could=
=20
> probably get most of the way there by propagating the ARM mapping=20
> through group->iommudata (ironically tegra-smmu being the only driver in=
=20
> the way of that - looks like it could probably do its internal group=20
> accounting explicitly in release_device instead), plus one or two=20
> special cases to recognise ARM DMA domains in the core code as you say.=20
> The more involved, but ultimately neater, option would be to turn the=20
> ARM mapping inside-out and make it a proper domain cookie type with the=20
> ARM code providing its own definitions of iommu_{get,put}_dma_cookie()=20
> and iommu_setup_dma_ops(), so it could then work as a proper=20
> IOMMU_DOMAIN_DMA default domain, and we can lose the current=20
> ARM-specific identity domain bodges as well. I reckon the impact of that=
=20
> to core code shouldn't be much worse than the existing special-cases it=20
> would replace, while on the arch side it should effectively only really=20
> redistribute the current arm_setup_iommu_dma_ops() path, so functionally=
=20
> pretty low risk as well. It's just liable to be fiddly to do in=20
> manageable steps rather than one giant patch changing everything at once.=
..
>=20
> Cheers,
> Robin.
>=20

Thanks Robin! I'll take a look at both option 2 and the 'proper' option=20
and hopefully come back with some patches :)

Mikko



