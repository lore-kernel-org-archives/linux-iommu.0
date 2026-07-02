Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013080.outbound.protection.outlook.com [52.103.74.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7E44E379A
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003251; cv=fail; b=l7DyJ4kL0+UaJnYZ4/SSfhW5JLD/sOnP+gcqTXR0mVMSukZJvq9tdJqrR2VaaI4rwZQ2IiedIerbQmZWnc/EtdIlRrZphYS3iQccmCrVVb/PHhZDuda9eE/wX8QdmoeXag0jqktPBrxMt6E0NXNPFOj+zgn0j+2KBj42i+fzfFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003251; c=relaxed/simple;
	bh=YM3y0xXvO5orj56Jim5ynlxW0KM1LczW2LN2HdVEBDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QpUqjV83dRCOGecwuYjGZU3msLJgB807CikFnBHdrXcQZ8XX7GmRnpQ8QV8M8QKEGacCt7TBlU9G6mcRs0dldAaeS6wVG1zekXDcCgex1Fday1+cg/wBKa6fv4i8fqOKqceWy634jrVTScdH/k/L5Nz81/Gb7tdo7TQVc/uataM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=CQd5TnjP; arc=fail smtp.client-ip=52.103.74.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="CQd5TnjP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loyYRfNo1C+21gUa0h0p12/QbcrfP1H+8ervF9niWyz3NEFM0JoXXR0gq/9fVGW/qGlytB+3ylOiuZqFNoqDRmOpQr40cLs0tSoXaoe2TPYnAyBeFQeLGSFwBngQwArFyx9cwjmfdvmINJh7J6F6zcNSjDVN3MrOwvjvCFpsdUfNUTxqPE1Bcp210caqCagqhUKLdWNy7CEcLdu3OYm8xhSonDt1wgmbWAmQzuk6nHif1m4UEzJXSm/mBUiNZtkliNrKXskxjbhRnrm4pkk5pa4+SRNLNqjnVutW+3cnnCt9YY80oHrc5HglhH5Go7b6xDztBlPEBTKte8GSO5eyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wmja2ucUQFi2cwaAoJ7dALaH58S1XDA9xivHK6o0zg=;
 b=lMrT35byvd+lolKPSDww4nWqDWbuRrqy3Nvpk5gFYQX/K8j8Ajffn5JQNTD0xVpAAH/hp0pmyg90eBWQyS2X/V7CVm4tcFgQxP0orSH51+b8E+qtYNwVcbjwYH1/hZ+n78NOerxITx54M0qYrmroGefaw2KKpMZMd+UaSh83qMAdArPkOAfFG6I/5sBprt2GAHLUJz90Tuu1Mtrf5Ai0/98XqdLsayl3ElgDuNEbbYQSNlCtzR7Om4304lBcQEmPKZ94keKlinmD6bx1tuBOyLiQZV7MMzo/dYIVVwIa5+Xvtm0K8BG9eLL/qJ1V9JyAwvsxqt9ORRAKuoWMYUvlxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wmja2ucUQFi2cwaAoJ7dALaH58S1XDA9xivHK6o0zg=;
 b=CQd5TnjP6IMa0glqiYZnZkB+RLBz+P2X0bH7ejLj/fnyq656xRlfjR+UvsKGkWYaemYVZLq2q+zO5L/U5Nqby0S/AOsETOeYRJl1RHx3YZ9gfg2PQsy5PL21ClfJnhYd73xRwmLxXHyB7qAq2Swboeo8nWWu/QF+ECSZ4tx+6J5HxYly7T2ZsrtfgocX8D5DZMi9ErgE6LW1KVzf093Py/vPs6/8E9gOl9ZH40WjpfnZ7F8cJ3iXtUTObF6NHPzhFcL7iJ13SKlXK84rh8mghWi6A1C+P6hDFubxYeY6tnVavoN314bLuoMmbjxq62nINl/cdZiTsnR6ZSiMlpiuVA==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by TY0PR0101MB4786.apcprd01.prod.exchangelabs.com
 (2603:1096:400:27b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 14:40:44 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 14:40:44 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: joro@8bytes.org,
	vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com,
	thomas.lendacky@amd.com,
	aik@amd.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	xuyongwei@open-hieco.net
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wei Wang <wei.w.wang@hotmail.com>
Subject: [PATCH v2 3/3] iommu/amd: Dynamically verify Southbridge IOAPIC via PCI config space
Date: Thu,  2 Jul 2026 22:40:20 +0800
Message-ID:
 <SI2PR01MB4393E767DAFD4150CBE57190DCF52@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB4393F989AF7FBFC94C304E61DCF52@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393F989AF7FBFC94C304E61DCF52@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0066.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::19) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260702144020.1296835-4-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|TY0PR0101MB4786:EE_
X-MS-Office365-Filtering-Correlation-Id: ed023ecf-4ba0-445d-75bd-08ded847e532
X-MS-Exchange-SLBlob-MailProps:
	AZnQBsB9XmrTkIzDOCxR6E7nJ4I/6XZ7LRwchmRqr6U/hEkoWaiRtEjnLqs4cU5mnbwgWGxOxdszWPbwp/U7Rt2ex97PHWRbv+uqBi5ozrrvFahN3aRe536N9gOD8gstpFSE0F+YCLDCFUp+idd+2HYcfTfWoc2RchSUgBgSPKRjFGPJDNP9NT2oHoBIEAzj0rMXmGGqIU79z1oYy+dMuV8pf2qk/hWj1EIHBbOwYJZv5Jl/L9CA/3Mqa93zdMY/+lKtp3scTnVRKCpslZADhhEdbbE0k1fh1a4BGECje3+TT0WuY7ZHn9bR4Mqz5HDaVAhiIk9LUZuJCdtDGpezm/XmUnVQ0ZSIkT2jkvQPvgzi0LmPjOwBqocTmOVcr1qgHzvBKC/3Gg5W8awz1fej0xIt0AsqG0LMxfAECmdorQs2plTCGazWAMnQGbva4hDUXfpmDyMvpGx1yhWDQARFSxIunIFnJyyCho6uQ7AQyT9z2sJfPnx+moC+7QLTmDcUS8pe/dl2g0i+y2xhL7p7skcGJuJN7ToRe8k6IdcuXWE/sZ7QpD65ezAzRxI3ITgs31n9kqIQNnqdsetNFBYcpAoKqWVI9UwDWT8v/lrY7L3XkVJje0KJgQEhJdG5RGLFd7XsE3GY+Y7A433LcsWg2j0rAnSvp75HxKjg+w68W/BgP6Qd6lcpAeIaBRa8zem/4v3tWfSAQuAyWN6v8Av56Z5DEuSgOqtZThihHzNAV24RF/Hep4lakxHtHGw/gxT468k7eUHHD4I=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|55001999006|45011099003|15080799012|25010399006|41001999006|7042599007|37011999003|23021999003|5072599009|21061999006|51005399006|19110799012|8060799015|12121999013|12091999003|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Z6RIYPpcKbmr9Y+hOHaqHCkSImVPoVPHP9EYkM8aLgHoTSGVXoTcKOPPu3G?=
 =?us-ascii?Q?UPw81oz2qP9dvngWr6onxq+Gsb/32FHTdpv3Th1cE0I+K0Mma0VR4G+z97DP?=
 =?us-ascii?Q?CGp5536RG0uqyPP4yDFIaBJrmIrmvnTw87LLqaRLivSZWnLulTh0+927GZrq?=
 =?us-ascii?Q?4tPhQ/qMcb/D0QA6lVz/7/Nz7nLEmNmx2+UJHoePs77CDCP+xJiIu1aPBRwx?=
 =?us-ascii?Q?Zo8JAAZzVRG8JJvEtn0GmkR7AclUFtN7b3QcSr2v+TAiCvVpA0YIOYw4TZb8?=
 =?us-ascii?Q?Po4+iVBq5KkbH0O+8LZausjSPJSoGVBX44lF1uIEqgUy+o6gATwpsdXHcU/1?=
 =?us-ascii?Q?wOF9nn/uKf3ChCIrTCGHZVT1cAuycSP1htbrqYW9J76fT4imV8kOgKotl8Hn?=
 =?us-ascii?Q?fii76cm957uvkTrGrYGgsy+HUuSi+Hkhse2oBpvP6IIGDtoMAOfDyekVkLMw?=
 =?us-ascii?Q?6/bFSbxd0oRlMjPOsWl4PpsJiarYN5j92QWMzwTLpKciGx2MhI7zX7yyl8Ex?=
 =?us-ascii?Q?y9dv5n7Cfkda/eAT345gf9sB3G0OVtDSWdpyhjBavpUA+MzxbuiHar20Crg4?=
 =?us-ascii?Q?Y5abBn9Gs4z25cQqD58yFPjNXbfCBL7wd7q8ttq/3CeOOAtuSnhEZAaOjYjR?=
 =?us-ascii?Q?nDl3nYttSzx4r3KfYSen147JBD2UFHHqoSaRU5CeP4rOtEHh8uzrT2pPWSaM?=
 =?us-ascii?Q?MQXvZn5/MFeEFlyXSU7pR9x4ATgJWG8aIbnBWCfgjdu2oubz2WornV8FecWT?=
 =?us-ascii?Q?pSAnvqGVK7XKqmzszfrt9zoZrhuv+g/fDlWp+I6YoNRypIYAaQQzAnT/A6sq?=
 =?us-ascii?Q?tuopuHKwriKyE/fq9vTyDKzWv8DtBYaWDzulyVP0nUAkIbHDDvHUoQJKIEVa?=
 =?us-ascii?Q?3eB1P3hNssC9zkaSDFzbGWPh9tQunDtZ8V9EDcMEk91cjuz/KVrAmVoy8Qk3?=
 =?us-ascii?Q?oEm8qi4GvwDdvAQQL/pP1E0Pwues7uxNxfO39chlhvXGAddfNsi0/xcMe9QP?=
 =?us-ascii?Q?FOD6gZZEJfyyOe5MSNSGxitfey1IhiKwFvaWKf6lbSc2A4g8x/PpGK/Wsclv?=
 =?us-ascii?Q?8GIPRs4j1pRzDafdpHeuRxhupO/LCzLb0MOyAEL3wOxtrtygO4PErVDrV7km?=
 =?us-ascii?Q?8SG0y8o7IARUM6tEUtIjb11/qc0/4i5dD1zUNMaocpL2BigcYzXLs8fzOM2S?=
 =?us-ascii?Q?kJadM5Ithiw3dRpi?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Bhbv1ummNnP/qS8rT360deyGFbgmj5H2wqdLODoEDDH7KhQZxr0bp86nh5V?=
 =?us-ascii?Q?nso92B0rYJYsV+QXTNjcxzJHdUDWLyVbXwMp2zq4CrYfVdDuKxBWUQoWzrt0?=
 =?us-ascii?Q?pF9Gf/1Kg7X4UmYFj2fAmD+B9LeVunuPoPnHJZ92DYnWbBCbGGxOQFYH8YJM?=
 =?us-ascii?Q?l6HUqnOYIhEJVOxqiNoTZe4ttue+cEz2IiWt6+43VkdkbUWb9TpNNxIhUR4w?=
 =?us-ascii?Q?krfwU72vuC8QkV4LT3UIOSAcBxEOVo48jNr4cPeoAYjqAqU8MmllOVITAIUE?=
 =?us-ascii?Q?6uz2dTT7i83oyOszT7Cy49B4PVueqFdGvkGBF9rnJJv4oHH9G25Jq0JvAMuy?=
 =?us-ascii?Q?PhZZ6HHrdd65QHs6vk0ebqZaXQPDqfZjL002MO/C+bYbj+7s6tRxgy7nwlPG?=
 =?us-ascii?Q?qBmSk7U/hOiCTB/H3lfHqTbCcgqK+DzodSyrRGoNWAFaeGSZNtuRz48EcU48?=
 =?us-ascii?Q?z6Yu8235Lj1l8FPcRmtnohWCELAEvNBnf5WK3tNcekstYfSrC8FoofLT0gKf?=
 =?us-ascii?Q?aXN0JfDwnmgKGJKw0TcjhKrMmq4JZWX4kcxz56ypN3wfmM+Lt8AfCF+UNdRK?=
 =?us-ascii?Q?VE6qTx9ZYRqtS63DzZwSM5ffPMLzLVF7SVzfmg5vVIMCxjgi0JMM2JO36H1C?=
 =?us-ascii?Q?9rr/wBalhSUjRqdxQlfksAOL/wYRJ491+naXhLuBxxBeAihzlfi46iEiTqUq?=
 =?us-ascii?Q?nTzjPE5mEcXjBVY4l1fynV4ADpgSEFINNwir0EGkTVgu/nRYNyZUgRjcw6sx?=
 =?us-ascii?Q?l+/sicCor5nQA2ZpmE39zzCsQ9Dly3SP0nJX4z0P2Gl9/vPAwh3hTBvPv3fq?=
 =?us-ascii?Q?Lot1QJljP1MCaijhnjvXQm+HUSyYsGpNCRsyVvPgYaaAD0N943c1YgIF+0Pe?=
 =?us-ascii?Q?CZmMSHp8pATQBquULT5R4Ou3vJhZEkLxQfotQb2n5+yolntUVnHH9LQY7Vvi?=
 =?us-ascii?Q?j27Q7y/DsaQx216fShP+i84B7eltPEra29vq81Ct4cEm8SY8O6Uta8NOntGR?=
 =?us-ascii?Q?AU92xYPEFY6mMerWbsoo4z0H/jQN3bLEIVBXzoOzihm3vUJvaB0wv93DPSXR?=
 =?us-ascii?Q?0iYsrfGm/FkXJ5WJeFTbICEhQ0Uf+VXMJKEtTwSIcnqGvUhG4cCfIq2lGfgA?=
 =?us-ascii?Q?ILMEZBAql2tRcp7oe7Uo1V9ITxinQXupXBUC6rT26U97nW0N/UMluM8590Xw?=
 =?us-ascii?Q?YD6Wb6bX0l1uiNWNs8LBX6HIKHfAgK+y77Nk5a6kIr9rL1+xu9RMMB/iYzz8?=
 =?us-ascii?Q?UwIagfduDhf49zziv+/TrF0hndpv1q8T5FrZPiie/ImVAVfTu/LlKLXq6SaQ?=
 =?us-ascii?Q?vcQ6g55iKLHiIsGELKfzQ8D1cr2rVIMKKe4YFwNxZl7+GDcPxSzZm4AOJM8P?=
 =?us-ascii?Q?PfsHtt6fTrrpb9elxnxvk5+5aCiV?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ed023ecf-4ba0-445d-75bd-08ded847e532
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 14:40:44.2385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR0101MB4786

check_ioapic_information() verifies whether the BIOS has provided a valid
device ID for the Southbridge (SB) IOAPIC in the IVRS table. Currently,
if the SB IOAPIC entry in the IVRS table does not match a historically
hardcoded device ID (00:14.0), interrupt remapping is forcibly disabled.

This hardcoded expectation does not scale to newer architectures. For
example, recent Hygon Gen 4 servers use 00:0b.0 for the SB IOAPIC, which
originally caused the validation to fail and interrupt remapping to be
disabled until this device ID was added upstream.

Instead of maintaining per-vendor/per-generation hardcoded device IDs,
dynamically verify the SB IOAPIC by reading its PCI configuration space.
Because the SB IOAPIC is embedded within the FCH (Fusion Controller Hub)
and shares its device ID, we can inspect the PCI class code of the given
device ID to confirm it is an actual FCH device (a SMBus controller or ISA
Bridge).

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Tested-by: Yongwei Xu <xuyongwei@open-hieco.net>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 9e07f7c4196f..c0748521dff8 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3085,11 +3085,21 @@ static void __init free_iommu_resources(void)
 	free_pci_segments();
 }
 
-/* SB IOAPIC is always on this device in AMD systems */
-#define IOAPIC_SB_DEVID		((0x00 << 8) | PCI_DEVFN(0x14, 0))
+static bool __init check_sb_ioapic(int devid)
+{
+	u8 bus = PCI_BUS_NUM(devid);
+	u8 devfn = devid & 0xff;
+	u16 val;
 
-/* SB IOAPIC for Hygon family 18h model 4h is on the device 0xb */
-#define IOAPIC_SB_DEVID_FAM18H_M4H	((0x00 << 8) | PCI_DEVFN(0xb, 0))
+	val = read_pci_config_16(bus, PCI_SLOT(devfn), PCI_FUNC(devfn),
+				 PCI_CLASS_DEVICE);
+
+	/*
+	 * The SB IOAPIC is integrated into the FCH (Southbridge), which is
+	 * exposed as an SMBus or ISA bridge in PCI config space.
+	 */
+	return val == PCI_CLASS_SERIAL_SMBUS || val == PCI_CLASS_BRIDGE_ISA;
+}
 
 /*
  * The Southbridge IOAPIC is assigned a GSI Base of 0 (handling interrupts
@@ -3140,12 +3150,7 @@ static bool __init check_ioapic_information(void)
 			pr_err("%s: IOAPIC[%d] not in IVRS table\n",
 				fw_bug, id);
 			ret = false;
-		} else if (id == sb_apicid && (devid == IOAPIC_SB_DEVID ||
-			   (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON &&
-			    boot_cpu_data.x86 == 0x18 &&
-			    boot_cpu_data.x86_model >= 0x4 &&
-			    boot_cpu_data.x86_model <= 0xf &&
-			    devid == IOAPIC_SB_DEVID_FAM18H_M4H))) {
+		} else if (id == sb_apicid && check_sb_ioapic(devid)) {
 			has_sb_ioapic = true;
 		}
 	}
-- 
2.51.0

