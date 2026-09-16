Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011055.outbound.protection.outlook.com [40.107.130.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DB02561A2
	for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571305; cv=fail; b=i6d2r3SBUxN7aiwKNXPizxTRAyZ2D1Uuoy6h+TQXkACN7jFQoTFR3ppgWO1Julv0BHSEail7oyhQm8/oki8vcig2Cg6tbBaoZ6D/nFV/jH4YThahq9i69zshrkZ8e1JHoawjrJzvTthAUVqSdB8W+GdhmgLGnzpSbchwGXh5LdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571305; c=relaxed/simple;
	bh=hlGoJuDTVtI25qEycQb3rLHnTqIHLrCDAn2yCb36Au8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=QKzZNuq7xRkgoErX35HZ73jAoGgmpp6P/zjz3nrWWdWNnbOkvkwPnVxRfClawNUEuyAXBncQNd6SqpUgM8pM+GsZXf7zVtfa9FSO1mIAtBTvy2I9+7DvnBIjxpgvyXutDkXtbwsAh2Xq5Z/yEuf4oQBa7/7LBAVBv2nunpnfgHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qtYScvQO; arc=fail smtp.client-ip=40.107.130.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qtYScvQO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNjUaPvgtQGZup0GzzfQRlA2mbCLk5BC54GahltZFdveE1mBVJUu2zbG/DckwO/uYeWrJtKbTEjO+WJkEwchsxkMgSGdaI6/e1GWHZhZM0N2BgP/qafHCUTcZI2ZMzqh9FbjlVuDDOYfRvaYO9F3pVFDEMzgQRaF2tLhy0SzfQ3S7PRUNRs8assPOV33FeUJGeJ8pCBzOsB0Fg23xrto1OorssRmDrGTkOjERF0ogJYoFmB5tWQN4euriQXTvVgyYPnU4T64khSvqtJ9XqZQnRDHdqVlgwg3JiIbqkfjFn80LhevtTOpF7LC1YLbz3FIDC4uijTTOTXPykid8/METw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fks/oUCAzR2TISL41k1Ym/4qnB2JZ6ihuZ03XwlY+UA=;
 b=axWlQ33E8B27TK9Orlp6B+H9WEPT7QAx46r7U2eqiJmkustgK2rN9QGvh1cqQ08mbbyH64xab4O05/HPICClvXFSYqOZvmVLc2Buu34tM1ajgtTbagPCd58yTt5W7SPqWnA8A5cw646ZU8JfGs1EC9DKrKzUzg5nN4l0miRO4zqZ/BTn40bOGRQikSS9Ol+XJzMNcSrciT9fFvJh4+NWSKWBYuWoqFclFnxhMXj5E2ZoceMHQdr3whaQW4EAV8BZa0Xm5FMWT3byvDmqG1bLld9ol1QhR3gAS3bsT4OOvxRqXrg91b4uRMQvhx5yofA2SDI9dg4YvrxpD2vtnNvU+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fks/oUCAzR2TISL41k1Ym/4qnB2JZ6ihuZ03XwlY+UA=;
 b=qtYScvQOkSIGcHLpeuxJlaxiwuj1yfhjg1iDQVTA+FZkuUQatoO9md+Yfj4703LzZvD/q2/018YtAjbUqmUqgTEmOLe5UetSH4QhSm18wd3XPI4GVg6HF7b2H2gDBgku/FeYGwwJZY2sqQ4LgcMKLhKL6AWzSLUjEkh5ttUy5zC4onp6aY46FNC7B0pHJhsH54Z+gaGcARhL1pOwElE1JJlGRDCg+BpOW8HSKynep4nAoeKSF0Y1mo/gdZF55djOCuoM8CZEsWUqQTq+1YJV4ST1CYln0Ups/+ShNjZ+fOGN1QALTLvmu+PJlkwwpEyl4QYbkxzf9Zy4ZUs87xXmww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by BR2PR04MB921731.eurprd04.prod.outlook.com (2603:10a6:2c8:2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 15:08:21 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 15:08:21 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH RFC 0/4] iommu/arm-smmu-v3: Support shared Stream IDs
Date: Wed, 16 Sep 2026 23:12:33 +0800
Message-Id: <20260916-smmu-shared-sid-v1-0-517384504aee@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOKxqmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS0Mz3eLc3FLd4ozEotQU3eLMFN1UEwuLNLNkkxSTNAMloK6CotS0zAq
 widFKQW7OSrEQweLSpKzU5BKQWUq1tQCqtVBKeAAAAA==
X-Change-ID: 20260916-smmu-shared-sid-e488f6c4d4f0
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|BR2PR04MB921731:EE_
X-MS-Office365-Filtering-Correlation-Id: 165f23a4-9df0-4245-9187-08df140458b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|376014|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	fnFhUHAzV6lKqc+MN5IdyIafTUtajtyh27i0DvBXkrPIIQjyEOxz/IXISz0BIAuZEcW1O3esm5SkH8sJN/Zk0HgEXZ+OmVPPkqTsj/g6etPcOZuWps5aoOXq3rLL7Pppe9P6nkPzlCmnnGrZ6yWgHRQa3GAaTKbWbTOAIlvWUm01hW1ZZhMwXikfiZGIk9OeztIARLyN1A6I2rnytAmQh4NQxYkcdnSgEYNpH6zFECj0eACDDAykyoEIsfKs4VBT5zEiRcB1QIcXUQ7Dslg4msJxZwaeHg3OAv5SdRHdtxgSohoqLyinDgeKu/TRADXAa4tdd8q2PSBWtHPshiUbYmJQVi267O08gwUKe685Z1RK1KNKAtL2TPgUdOU9npaWaDvbjQYplscQvvWrHPE2PLKRFjlfpX8B6sIUjHLgy0HpJ4iy/jQ90UekRa5imjxuIpgjD0iTktoA+ftiSVU4xa4qRjvafFE3tBzoeJk7Hb6OEfvMB7o3+AsdzEs9eLAAxDr66OGapd6YXvdoBauBpBXb8RJy4raELY9/Bz55Ly7avpwP7deEpCVfznfpxsV74x2ctwihgC48Dgb6wfvQWGZ4NCGmfhRVmBhUROTdpMnqDtzLmfWqrAMh9mwo6Rnn08EuGPE4k5cjEuQBGTMD59t7htJhc5J6cVwmgLagVpU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmI1enVleW9aMDBUU28yeHVDblA2dWFUNnBOVzFzbFc0TUxUS29zTEdhblNJ?=
 =?utf-8?B?TFMzby8yZ2pvWldjTll5NUFIL3dyN0pBM21SbFI4VDYwSDh2bVRtdmJDWmFM?=
 =?utf-8?B?WHozeURnR1NHa0c3cmNTU2ZRYXlhMGVDUnBFMGp0SVp4TGZmUnlBdVN5Nnds?=
 =?utf-8?B?UjZyUEhTTEdjWDNIVmpxOXVRTHU4MFNCbi8rSkZ1TUp4V2JFMm5Va1VnOUxK?=
 =?utf-8?B?a3VzTFJNUmJKZjhpbUZJalNIb1BHeVFvMVZWR2lVaUlaTWpUd1ZVQVY1MlZi?=
 =?utf-8?B?VXJ5WTZNK1VLaWorQ2xMSjh4dFpMb1JDR3FORkZmb3J6eXNuQ1RNSFNkUjNa?=
 =?utf-8?B?VlBsOFdTcE95ZU84ZHc4ZTRCMGtmOG1pUmVkckM5ekIxMHJ4TkxidmxYbk5n?=
 =?utf-8?B?ZjF6dzhoTDhCVXA3Q0Z2MkdJSy9uZmNPM0JSanpHK3gwdHFhd2p5VW8ySXZQ?=
 =?utf-8?B?eTI2K2FjS3lxWXhRRDR2WnBiaHhLM21LaUltWGdPUjZOVVphcTZWYTc5OC94?=
 =?utf-8?B?UFZKdEV5eVFzMXlmclR5WmliM0p2WkVDdDBqbS9sZDVFY3JYaEtSbERPQ3Fm?=
 =?utf-8?B?VEJZRll3eGhBbUkzTzhJNExhQXVvL0NqZnZBOXlsa20vT1FWcUxPWHk3OUVl?=
 =?utf-8?B?cXBKcklZd1Y1MnRoNDZvcTRidEdKNjVJNkQ0N1BIWlFaWTF6OEZzRC9KZ080?=
 =?utf-8?B?dVdrOUh1MWdzdGUyMlRSV1FIMXUxcFp1TkxnbVo1clMyVUtXeCtrcVlQRWZh?=
 =?utf-8?B?ZzBLR2tLR0pmelc3N1hObFpma1dUaVRpZGJQZHNKYS9IZXkxSTVneHhVSWE2?=
 =?utf-8?B?RnFiSDVPTWJBNVBCN09WTE5UVm5kbEk4endoYnNlaXZQeXBMREZUS2Fla1ZQ?=
 =?utf-8?B?b0ErWnprcDZFdlJYR1k3SkUzTGNodDZGUWxiOTRET2FGa2Z0a3ptNHlvSWtw?=
 =?utf-8?B?a3B3Ymg5ZGp0aW5JNEFJdGE1WjFqMWR2bUJFSUZtVDk1NTJ2YklJa2NTOTBY?=
 =?utf-8?B?ZERWQmJHZGRPYU9aU3UrUFNpL3BIWG1wSHZqdFk4V1E5RnozcDcxVFVwaEtK?=
 =?utf-8?B?blFEanFqSElCT0wrZytkbkZsRE5uWGdtbkt6b3NSZzdMRFB5R281WTlCSXl3?=
 =?utf-8?B?WEFLRTJZUmRLTW1OZGQ5UTgzREVHcjBHNUxFMlNGUVlTcHc2SHR2SFFQdHdr?=
 =?utf-8?B?N3hxU2lsVGRUdW1iMUVjVHl6MzA0OCtYeW5OUHdPNytrczNzYkNhQXdlcGxQ?=
 =?utf-8?B?amZ6UkdvS2J3VVlMV043enFPbytTdFdvL2loQjBFcmFFQlkzaUZqNDJqWVZ5?=
 =?utf-8?B?aHZaMXVBeC9pdUVXU2FkQ3dWZzVhSUFnNVZLUjIyNUcxMHNpOVNsaGRBa0p0?=
 =?utf-8?B?Mi9uazllSzR6S2V3Q0dyYzZoTWhrMTNRaURyMVZRY1QxSVF0ZG5VUjJKL2Vj?=
 =?utf-8?B?Qm5rcGFGU1g4dkVqUVhHSDZ4bDBYdTVoNVYrTWRLVjdod3podVJtdkdFdmE3?=
 =?utf-8?B?WXFiUUNaeEtuaWo5a3lPbU9lem5FQkFKcVVyWGZvekRSNDFRNXhueDAzeWRX?=
 =?utf-8?B?SWdwcGVRTzZiMmpiUVY0Y08yNkJ6M3Q2ZXdmZVBkYTdtRkZGSW1UTy9qUC9t?=
 =?utf-8?B?cEJlODlVTnI5L3g0QlpqYzEwb1ZYZUZQZXF1WThsbS9ZeFd4VXg5MnlEK3Ez?=
 =?utf-8?B?NXBJWUg4ZGJnSVp6NVFLV3RIend2b1R2M0NxNHhKc0N3ZDl5QURCTW5uaHFN?=
 =?utf-8?B?b3hiRWNvdTByZGZuWHU4eTRsbVFtdHpDcUlvNkZzY2hWbjdlOHJOZVZ4KzJv?=
 =?utf-8?B?cEZWRVFNMU9PMytVVmZVYWNJS25pODJTZWR4MHgvSTBCbzVEaDIxVlhaZGdq?=
 =?utf-8?B?K3ZvMnNCbGdLVHA2dHVOd2F4bzFZM2FNWUJMNFk5QkpWbGRzaUlwdXc1bDhn?=
 =?utf-8?B?Qmd6ZzJpNXRHdnVEWXo1ZmxyRU01SU1CMitKVUw4RGZZMFZxc1BraituZjR0?=
 =?utf-8?B?Ti9rUTNIWmdCMVRIYzFzWDhzbitadVdvZC85SlZNOWFhNVFETk96WW5GZWVz?=
 =?utf-8?B?MHJYelBSUWtQeklKcmRxZnVnMkV3TkJiVFNaY0FyZDlXbDJBelF0UDBTa0U4?=
 =?utf-8?B?N1k2cklSQitRR0piQ2ludEQxV0g0N2w1b0NKU0FhQ01hOUU3L0piRlJjRG9C?=
 =?utf-8?B?K2VmZXR1V29TeTFyS0lZZ3EwQTNXTXgweTI1ZEdHZUtuT1FzS09FaHhRMmRy?=
 =?utf-8?B?RGM3UEs4b0lzM0dMUDNpWVdySUFRM0NhL0NuUmg5d3ZaTWVuWjBIQkUzb0dt?=
 =?utf-8?B?V095Z1BkQXQxWmxvYlYzWlgrNW9TcU52R0RjWm9Uayt1RnpXeVQ3VEFqdUxJ?=
 =?utf-8?Q?OhpI3mrm7iS0NmK0ieIaZ+9gMxItC9MD8YVaK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165f23a4-9df0-4245-9187-08df140458b7
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:08:21.2975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQJpSZvozm+BDY18v2cKYv16R1x3MmgoWPMCInZF5lnK589owiqrjB6Ix6fngZWCOyX8BVBFu0Yv3+57v1vX907sB2zuOHZTGFhlX7ig/e4YcuKhSh8Sz/2fWOcN2vTT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB921731

Some SoCs have a limited number of IOMMU Stream IDs (SIDs) and
hardware that inherently shares them. For example, the NXP i.MX95
eDMA controller has 64 channels where each TX/RX pair is assigned
a single SID by the hardware - the two channel devices are distinct
from Linux's perspective but present the same SID to the SMMU.

The current ARM SMMUv3 driver rejects this with:
  "Aliasing StreamID unsupported, expect DMA to be broken"

I took comments in [1] and implement this patchset and only want to
support a very simple case that multiple platform devices share one SID.

This series adds support for multiple masters to share a single
SID, allowing per-channel DMA devices behind an IOMMU without
requiring one SID per channel.

Patch 1 converts the streams RB tree to an XArray for O(1) SID
lookup, simplifying duplicate-SID handling.

Patch 2 adds reference counting to streams so that multiple
masters can share a SID. Insert increments the refcount; remove
either transfers ownership or decrements. A per-SID linked list
tracks co-sharing masters.

Patch 3 places devices that share a SID into the same IOMMU
group, ensuring they share a single IOMMU domain.

Patch 4 wires up STE write ordering (first master writes, last
master tears down) and gates features that require unambiguous
SID-to-device mapping: SVA, IOPF/stall, and vSMMU nesting are
disabled for shared-SID masters.

[1] https://lore.kernel.org/linux-iommu/DU0PR04MB94172CB3F138AD39E9B6DEEF887F9@DU0PR04MB9417.eurprd04.prod.outlook.com/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (4):
      iommu/arm-smmu-v3: Convert streams from RB tree to XArray
      iommu/arm-smmu-v3: Support shared SIDs in insert/remove_master
      iommu/arm-smmu-v3: Group aliasing devices into the same IOMMU group
      iommu/arm-smmu-v3: Wire up shared-SID STE ordering and feature gating

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |   4 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |   7 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 265 ++++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  34 ++-
 4 files changed, 247 insertions(+), 63 deletions(-)
---
base-commit: e6e35979777d646fe3c7c94dca7dd32fb25d45f4
change-id: 20260916-smmu-shared-sid-e488f6c4d4f0

Best regards,
--  
Peng Fan <peng.fan@nxp.com>

