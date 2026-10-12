Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013061.outbound.protection.outlook.com [40.107.162.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AF0476053
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807605; cv=fail; b=fFdx6a1vTri2EkkpriTvbZ7WaaRyrWtRKIXwiEIknTjvaUzyhiRX+TvLSAhejqmvt4qhur7gRjOR2m25Crlt07pnQGEj2A/9y1vS0l9ZjHbEZDkNlrEp7xs6UhuazT7UoS5KmNuS9I4kpLb27/SvD1I+C7LhscovVnJSbl8KP/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807605; c=relaxed/simple;
	bh=7GvAdqDk1L2DlIiuZYnLENYHCMHim0fpxhVYH4Zzv1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vGbi1fc0XyTP3Qu/67nt7QiyHxVOInDLlDJL5JGct4m7Uo8SfIdNxQsaDywQrxBj5W+5eMqckQwI6P4YKu1G7DP+noZvvmgv5vmLjxUPRLjSJsytSXdlWc5T9OBUAbxNkK5pEMuRqmjGthlHRGF5vd/m5RpWS7p6mgzMXRZRJ8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sAwkecPN; arc=fail smtp.client-ip=40.107.162.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sAwkecPN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xd/nzymqqmIt1P107AvVj0vguEuVTvtAtOqB9+0AFKylcPmXPADRCdOyjOaXLUYDTqLdROD5trIyUMSAnaEbTykQTYUzE1u2bGJpN4C7FKHsLwk8fK1wXcMoc3XxJgVYJmGJvAg5tY/elMaq0xTEUtZ61gaSa2bHTzX8PyVfCt75pvQHtpb9kCOs0Ad00RXlNvbMCxUCOfLXWrHdxwiIAetI8qVgTbRX0D9rU9GHMxvULbzR6K0qevqTIEwuJRUJRqrUDPevMjetOh0+MqIBJNfFRsuPrORZn7Dg/iDb+3QORnLAB3kuye9kmTmoYoef1lR3tZgv6AKYNRyN9/A/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngf4ESPhCbanmeZhB/tfoZFgfA6X2C9mEJQSWpx6ZqA=;
 b=Um51cYPTDD9kIa+7xOAXaaIr4M0X33IULk6+xt/6ue00QP61gtmlGE6GX13cUj6N9KCbQyWylBN3KnTyjFl8m8kc8tgmEMHcHFGYDRq/zTCH/cQoyF3Hodbv2J5KN39kauxQuG+NNX1uLihXg9ayxhVhvpFw5Y3WNYpPhktu/l0DyinbRvH/eApT0rPIT+A4btIpkSfhOACRMwA8BFQ6iOA0wLz2OvtI2VzDhjE2bdFhj+ZXoN/zNVuR1N8+XYe13XmfxQln9AlHrZWtLb5TNYG/u/6J88uXYC4Y5kySx8EFZERF8+vdwj5YX4Gl9jAyWB8oOmNTF6wDANeoV6xgBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngf4ESPhCbanmeZhB/tfoZFgfA6X2C9mEJQSWpx6ZqA=;
 b=sAwkecPNXaQ2QQTCvTHOUBnl3yEDdhiEHbT0qgFb5Z2Ah/W8D774S3+o4oYB8jiOQvGl/Z9ZnXqVSFrVaOPn6vcGhk5l2goJH7Rbqo/1BSdKvthZGVkLZBHgZuHHU1fP6pFkBBNxtzM+OrpNlKtmrgpM9BmMO5vD0MCqGsg9R/bwnE/N5051mH3Msu5nlLvYDu5fl6gELy+64qPV1ECWMBqwUcu7DSoSxoh918V/vT7W9iOLT10jxz/3u48WNU6J6afFrCcRbPGvr7ZrYsQRzBEz71VMCekhCSsimQqs+d5x/QrHhqdeb+LCrcQmSf6ug+ZeZXQX4DBxL5tvf+YqAA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB7885.eurprd04.prod.outlook.com (2603:10a6:102:ce::14)
 by GV1PR04MB10991.eurprd04.prod.outlook.com (2603:10a6:150:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 12:19:58 +0000
Received: from PA4PR04MB7885.eurprd04.prod.outlook.com
 ([fe80::6e41:b858:46f8:c5c7]) by PA4PR04MB7885.eurprd04.prod.outlook.com
 ([fe80::6e41:b858:46f8:c5c7%6]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 12:19:57 +0000
Date: Mon, 12 Oct 2026 20:24:33 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Thierry Reding <thierry.reding@kernel.org>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v6 4/5] iommu/arm-smmu-v3: Group aliasing devices
 into the same IOMMU group
Message-ID: <aszRgehfo5emwCt+@shlinux89>
References: <20261011-smmu-shared-sid-v6-0-cb76b89dc612@nxp.com>
 <20261011-smmu-shared-sid-v6-4-cb76b89dc612@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011-smmu-shared-sid-v6-4-cb76b89dc612@nxp.com>
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To PA4PR04MB7885.eurprd04.prod.outlook.com
 (2603:10a6:102:ce::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7885:EE_|GV1PR04MB10991:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0c6e18-0de3-417d-7943-08df285b20ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|23010399003|19092799006|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	P84wJXteFeXIi66iwmTZPYj1cJl+l8CGNLsZoRiB38/9XPjJxTWdElg4NV19Emg5WB2/8yN6Y55nYE680gjtx87M2ijsNtb2TcHXn2Wa9yQYPOFRGDr6E0+fFFti2rUnfmv/oHmh5vlQHiE7PHA5EZ8Ioe7mxfolhGDaVLeCtYlsi87P6u/VONrOno+DFVIU8eR+P3CBM0bQVmWel72ogXVbrolTFstAAkXkPsZMLzJ9PraY8FyiKe8/FLWYvGYGEmYo/lW4wOakeB4rkJHQvQhSPDynNWAxYFuWZyK/mQz9w8aTRoPTYC/+hliTJCkUuk83XrZkUnXhNO47io0XYQ9I0iXaDJLrhpEFbH8IxSVyU0KeazhqjtlCrXEvMJ7lKhbTptzAZ5tGedjhNulCLkkGw+iMl0gbg+8+1IzOJMb0j2JP6JPqMM71+zopB5Akn8+MwxIGL1pSEcusqaaXIGoyLOtiL7roh0SLCuIFf0/A6r/qDnuQCrRmhRwGNizbxX5MmM8rezijhOReIj1O0GtQBzvIp2Z9Vv53P2aGy+wS/PVh7M6ie/FayCEoSiZ5GpLgNTUvAWz0YtA5Oyqc1HOFy04miK8O8nZj4YTTsoqxDpPcNHpzl6UMmX5/rGnN04XhdpBWMWaH/PTICHM/kihY48wvExqk/FT/MNLTXww=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(19092799006)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OekZEu+x8npQ0M98Arezo/yX0nHMoBxbK3fL68tUf83kgYgs+J6XI7wqABTw?=
 =?us-ascii?Q?DOnCVsYULVDD+rQgdRddM6/RLJ4HadknHrOuMVysrKTgiNDOtlP0FJVq0e/g?=
 =?us-ascii?Q?be4CDJQikg3TFhvJHgD6xQkFILDiekYsnu5vSmAF6bpHBQnLF69nMoaF027O?=
 =?us-ascii?Q?vJ8vrqZyUB82Uof5Vrz+rzdjdXooQTasgtjDR4uKoW3U1KjXPvOCQzVZpKyQ?=
 =?us-ascii?Q?oUqemEKJzp9isSZNy/jPvksPd6vwkvTLNAcNfutw5/MV3h7THz82CaX3UJ2C?=
 =?us-ascii?Q?9kYgswt+k1r1pJml48l1gJsMamSyLglixWr+DZDqqistmlRR3fkBpHl/PO+o?=
 =?us-ascii?Q?4WGol9n/VoSLWPNcjeeVvQNaQWtiCQ6jEpiJqY4e/bsWnKC63e285F9ZPtCd?=
 =?us-ascii?Q?BETBbrfvbq2+ioyDDtOvi/Aby0XU1qEJr/3JvpVZYmsayxSZpxMUu1WbWNQJ?=
 =?us-ascii?Q?Lc5A4aktmffv+JSs50P7iK3mvLYsFvT8ERXYLzJfzRFx9QfLstd0waMa6/84?=
 =?us-ascii?Q?7c+GVLBX4LfyCHl33WXGubmhavz6HrufEsDw0rIiWNRRWvvAY641jU8RkGhN?=
 =?us-ascii?Q?ShTTSgkNjKRUEO1vI1Dt9S8CuKBVFzc8rDjfLRwq+NSHmDKwm7fLpD/1HcNr?=
 =?us-ascii?Q?GMoagYVlUqKOPZqOBLY7e7jYiIuHswkeIRIigMCI8pa6MFioGjQ5BR8pZW1Q?=
 =?us-ascii?Q?lGJtAT9nbJreXaQ2zd/tRUEB7fDI7zA3+/BsRA/mhgdFinMv0d/OSeTSIf5O?=
 =?us-ascii?Q?ANoa1tqj8HxDs/TGVEBG/wpCMm9WjsPSl4y+qjyeQcW+6pJ/b2UK6BikJAzH?=
 =?us-ascii?Q?kTKlTS32MehUSmH8NQklmQcmzIE7uB5/njPHjSiy6PY32F6GPMpNw8KdjYhm?=
 =?us-ascii?Q?pIFePRrGKEiPrNUkvWn85xpwVi78Cd3H0+S25xKAMYioOyHfjBh12KQYTNC3?=
 =?us-ascii?Q?56WYN5Z/WQVCRwRn+41q38IoWmJzn4JfY9++anjWX3NLO+VSfM3XnOlzzwU8?=
 =?us-ascii?Q?3S++AEIVLLfdyEkOUoKXXSM9a32YAr2qwI6fSrFv2NyzoFX8m+zIzEeex1a1?=
 =?us-ascii?Q?5ljGGYfoUC/xQf5xWMPJkRjkSe/I74y+RDoo5FgWaM31VlX9q7FQsDyPdrCV?=
 =?us-ascii?Q?v4LgQhGgqskuUbxPWHupXWAF47qKRVqI6MXYbVruNupw/cYGSttgIPwtS1GE?=
 =?us-ascii?Q?57wAQCyZhhKgAE/uciCmq5uMm2PBE2rmMOLLY3VtBveBlNIdvJFCDmXprYU2?=
 =?us-ascii?Q?ASht9oDn0uFY4aB7WmY6nbaKDN58LLuaaVmKlcYpjW1TUV3iK8RkW8YlDcvN?=
 =?us-ascii?Q?5rPLIf6NVKVG1JYq7O2d3dScn+qxZvYfMaSFq7W+oW8t/wiTJeZkvdqth+B0?=
 =?us-ascii?Q?B1IIKlcQ2RA5CIzNozbeN33iQSomolRzDiLrhrDXGyOczdDOnTbfc26f99kM?=
 =?us-ascii?Q?Y+kk9yG0h1cEd0tdDu4ysGYm+PQc52Ie+L7yzSg6kwZFhtql8A5L+BSOoynx?=
 =?us-ascii?Q?6Lx8gh9/0faWGNLt/rW69arwuY57BZK+BmOrixmeN3Kbui38JVnrJAhfjkLe?=
 =?us-ascii?Q?lLi/IrPjz9AqQprnCAqaqb8aZSYj+D5n27ovVI0AwM0ifbkuI6a695KVAWdI?=
 =?us-ascii?Q?NESniy8eNKHobMOyDyC/xplNHgZs7ZZXwGJsq4mJ89wgIOWSrQfxfWGAcSp/?=
 =?us-ascii?Q?SKYPKXCAby4gDrkHjHt+0WXYAhDPztgozt+LdnC0d1dQTQL539oaWyi/EMYL?=
 =?us-ascii?Q?HCZYVTjeBsO9GqNIg+ocjZT8CXmU6AFgeLtELGH/H7c91xxfCr88?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0c6e18-0de3-417d-7943-08df285b20ed
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 12:19:57.2429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9fcScE1BgjSftyM+xp++ujM1kdpgS9z2mm9cW3nHZ7mgaY9lE9QDN9uvNEw+08QBAjv5X9cBT9IuPLuDCQjUSYjgPKnVnzXtEIZLFQjjX+jKiEYZFLTnXkKWwJpkB3u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10991

On Sun, Oct 11, 2026 at 07:31:28PM +0800, Peng Fan (OSS) wrote:
>From: Peng Fan <peng.fan@nxp.com>
>
>Devices sharing a SID must share a single IOMMU domain (and
>therefore a single cd_table) because the STE can only point to one
>cd_table at a time.
>
>Detect SID aliasing at group-assignment time by looking up the RB
>tree for existing owners.  arm_smmu_device_group() is called before
>arm_smmu_insert_master(), so any RB tree hit belongs to a
>different, already-probed master.
As Sashiko pointed, I need correct as below:

Detect SID aliasing at group-assignment time by looking up the RB
tree for existing owners. Since probe_device() inserts the master
before device_group() is called, skip the device's own stream and
look for a different, already-probed master that shares the same
SID.

>
>Assisted-by: LLM
>Signed-off-by: Peng Fan <peng.fan@nxp.com>
>---
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 ++++++++++++++++++++---------
> 1 file changed, 23 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>index 351ccdfa765b4..328d580935b96 100644
>--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>@@ -4572,19 +4572,32 @@ static int arm_smmu_set_dirty_tracking(struct iommu_domain *domain,
> 
> static struct iommu_group *arm_smmu_device_group(struct device *dev)
> {
>-	struct iommu_group *group;
>+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>+	struct arm_smmu_device *smmu = master->smmu;
>+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>+	struct iommu_group *group = NULL;
>+	int i;
>+
>+	mutex_lock(&smmu->streams_mutex);
>+	for (i = 0; i < fwspec->num_ids; i++) {
>+		struct arm_smmu_stream *stream;
>+
>+		stream = arm_smmu_find_stream(smmu, fwspec->ids[i]);
>+		if (!stream)
>+			continue;

Not very sure here, should I use below as check condition?
  if (!stream || stream->master == master)
      continue?

Per my understanding stream->master will never equals to master,
but Sashiko concerns: Could this logic be adjusted to better handle the
device's own stream?

Thanks
Peng

>+
>+		group = iommu_group_get(stream->master->dev);
>+		break;
>+	}
>+	mutex_unlock(&smmu->streams_mutex);
>+
>+	if (group)
>+		return group;
> 
>-	/*
>-	 * We don't support devices sharing stream IDs other than PCI RID
>-	 * aliases, since the necessary ID-to-device lookup becomes rather
>-	 * impractical given a potential sparse 32-bit stream ID space.
>-	 */
> 	if (dev_is_pci(dev))
>-		group = pci_device_group(dev);
>-	else
>-		group = generic_device_group(dev);
>+		return pci_device_group(dev);
> 
>-	return group;
>+	return generic_device_group(dev);
> }
> 
> static int arm_smmu_of_xlate(struct device *dev,
>
>-- 
>2.34.1
>
>
