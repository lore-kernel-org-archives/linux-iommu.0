Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010039.outbound.protection.outlook.com [52.101.84.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF2748EBC1
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811143; cv=fail; b=hqGwnWd11n2Kf88B/wQDJVvyUZ/YSSiod1wb2z+xR52VOlBFsihHRHAYZL97b81TKYXY40ZyUQMs1iYufwM0DHlO2UQyUdxie/8N4B5+lU6tK97wzR+Ha9/tULD1GDQ7JEQNGPzx+h9PoIGGuPis4qJdRKPoGyQ26diKHZQEmPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811143; c=relaxed/simple;
	bh=ROB1Xf+TvXuzsrvpRMjnv5/L/HPgSvCmZX8AVp+e8Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O7WUH2W6HTScXMUdn9hr7FWEMepJm89g0ADN7Gt7Yuad2qiBc77+hCeuUp3K9qF/z89ld6W+4bcU+SCqIqr4II22MlPYNhJFyclDGf4uQKhkcnDuZKPUVVWL017BMkREOPDre6azRndPJGu7Flwf6qqlt27Xz6L8YlBEMo6ze0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TOGy+2c8; arc=fail smtp.client-ip=52.101.84.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TOGy+2c8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqSYDltBd1LMeVhe8QgkAeR5xNcM37S27ecWcIYsOzIz0S2Yjw4o1DFUokDfqzd+LBLDG2BzDFfnx46L6cyWuUlvF8lGjW3SOP/Iu6qIX8bdX84x3CJ3vIF1BWd26n/FmsmxdcX+BwBKI2Wk46wYo6WSmzLY9hC4OPWXjwjfMjzld/AI4JcuIT5eevnZyd7LzcOvE8fxwf+VeK4g13sSInMhrk7ENcOJz9ac/wMAOoTfAhRLgvLcuhj8pjSL5zbPtSf70MB1UPWZDyLB6iwaR/9q7Py99yN0SEDqjMeGhFJLS+wzNWKHEp0md1e/EO/MR9lEDHp7jNbYhTaE36cgHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dk75LqYt1alYz1PWaWOdD4b/cjZLZXMEv/OmqxUE6lk=;
 b=g4n/rU5ODzCBPcD+qnEMR0sDqAVWj0M2KBUw1nD30a7+cSqH4uoyW8KkWlWEplDRoBA32+QYN8S6flO0ERrIgeDYa5b391pSUzH/G0h5yw3VtLUV3g1GUUCo3fFdztEOkhKEx0fUUQ6Z2z11/8x6XnlVJuapkn/IgXjHtd8nyv6QtTVsEAASZB3HZlcV7N/iSfssdpc3dCWd2rnTIlOiR7m9SiQc0J/QvlN6v9Al8gb3L6zFK+6adKjHCiOX/OY73JcgIl1VwEOFDgR6M2ansrAIi7gbn3oq7zOiAOALlbKNooBiBv4pWp0B81hqJOWExO6tSR0NL8dcqVrjOY03lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dk75LqYt1alYz1PWaWOdD4b/cjZLZXMEv/OmqxUE6lk=;
 b=TOGy+2c8NpsMuIqFQ7RB0y/CRF7BpRJWjyd5Aga8Ww5uv1zkIu0rWD/BRwl1uamwjPEFLB5EtuuRPcB/lgxBTOPETEmfefh+vAs+IfEK1m/dpEDN72tknaKzSgE5xfDRUjGrwGgZeo2PX6f1r3vCI43zj6RHeX6lDLdRvCKwLFkehR6IqKQw+otgjQtD52UHwFI/neqQKIwL9Tz8ldgRhfuISnRp6VJ2xrHOf4zvwuB2oPjn2H9vBIvBQ30rCQFuI2lC/ZEYs28gRnT/0oVW8lPzgwErtlcSGbAs/0+2kr1GWfJMSEEsg75XhBsncQWsQeICVJ4wg6UTDzGxXqbaTQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DB8PR04MB6953.eurprd04.prod.outlook.com (2603:10a6:10:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 13:18:58 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 13:18:58 +0000
Date: Mon, 12 Oct 2026 21:23:32 +0800
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
Subject: Re: [PATCH RFC v6 5/5] iommu/arm-smmu-v3: Wire up shared-SID STE
 ordering and feature gating
Message-ID: <aszfVNP6DGzWYdK0@shlinux89>
References: <20261011-smmu-shared-sid-v6-0-cb76b89dc612@nxp.com>
 <20261011-smmu-shared-sid-v6-5-cb76b89dc612@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011-smmu-shared-sid-v6-5-cb76b89dc612@nxp.com>
X-ClientProxiedBy: MA5PR01CA0215.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::19) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DB8PR04MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b9dda4-40c2-434f-b921-08df28635f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|7416014|376014|366016|6133799003|10067099003|22082099003|18002099003|13003099007|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	By+ZwRpqBnzT6dsOJMDr36133UM+WAhbP5daSKBpaAvtaQuKh8pW2mogy96cMaPPAzC+80ZGrVOhw8Z/Ebf92Xb5NFOREajxPGiI0wMZGsC5hF6a5a3aXFZkT06W9r8HjSWVsQmL32Du0dpOUoA0f/AMp3QQWZWLVSVv1LHtr3ZCntFSOdpbQoRDu2thiopB071rQg+tdhn0uZOfO73JWBtClRVUZm+ZAqRgQaZ8Qp2eeL9fHk28eM+HJ93TAVvAoExl5MMUohMHNkX+klXHWuSC9zMUlpdEb68Z/wsbGj28R6GZ6ysyrChRxYEVa1IC8MgxJyDOqV9ehtsTBNyLEXWo172Vm/ELx9EkrVu3Gxu+3Bwse1QLa5GkY7ddt4/FFIkG+DIgLDXqjZwIJdLSGB+kQvWY0SKn8YNWEsp6MtpLuX3FcfY00U+aXMrCHhCeXrLGgHanje8bnrvJUlGFBtM8qfeICe/WDVn7iFVgUhl/UQrGd/vglYpvwA3IHzxUvuuCVawadnuwqKIzikEAsNJz7LE9VddLjGteguervnQVtdKGQwlWTWIz7wp3ONFNsjr9B2OEYpc76mfqO+CFTs5OdGgdbEmyWYrv0NaGZ7s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(7416014)(376014)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(13003099007)(11063799006)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PTLtNWnhqfAzNA65MedZ1FOFnAb/7zqp1UBLaxBc2jISYsp1Fc590pJJGy9q?=
 =?us-ascii?Q?rYM1IaaDGpPvOkNlKqZk8g57fDSKN3sVQHj5WlyYzAppvgi20PhhzqRgs3x5?=
 =?us-ascii?Q?m7KsIyBNvRt/rpcRc5xUCVETp5iGkXVt7L53EeEeulR8ViaGNkizBwZ5wiNe?=
 =?us-ascii?Q?nDlxaXzrvdL62yaCjkhchY5x8RCh8vJok2pspACNo+BppSZulnLyEsT8HQ13?=
 =?us-ascii?Q?AeC7pgU9f60sxojvQ0JYGlw7Yj96OuHMcK8vTQlHN2r7eRWBJeIiCLcKy7o4?=
 =?us-ascii?Q?9j9Qdvu0f69H8ifOfySEawRcVM9vlaD89CQymVUi06l93D/OrOV5GIw6EkrL?=
 =?us-ascii?Q?b8PWTqvVV4hhqqAomvAFUHnehoLtWTGtJS+OXhwSDmXoXkWrPeAm7Vt00OfV?=
 =?us-ascii?Q?m2aZREoBAaoX9k6Kd4FrnqQ7YMPeghUoLI2IA0OtzSJQ12AfhlyqSQaBzgkl?=
 =?us-ascii?Q?MEyoFJ73zlZgfrDIaGXDkO5y9tI6KwxDKFUGyTKmHxOAYTX7S8Fl8r9+QWeF?=
 =?us-ascii?Q?UJxy8LYR/6GgK4k6w3ey5sZxfNlpLU0V/xix0C6dwgk+RWGqhbNvgpwBaUnO?=
 =?us-ascii?Q?CyNxjFHDXaQ3qdUvvLDXjAoHRRpFJroNtw0A3bR8b2x2d+XqRY55D/1nFhFK?=
 =?us-ascii?Q?5uf85ag/ywXMHKufbJMA/ULTyIgBFqCrx3hBjBKHYRQpQXw2WpKW6hezP7AA?=
 =?us-ascii?Q?3QrsRISdwycxti69Zyd2PH2R9wlgTabjPP0cdeiJvg9EX/vmU3jBlglEOQM7?=
 =?us-ascii?Q?XJg6BfswI3ZMn2nq1CbLjYE9AyzpkCX8+3Q8FVRWmpx7zqPGLgQ+ZGQZ1arU?=
 =?us-ascii?Q?ADkjxPHf3POrI/s960Qy6Cz1AXeWx1gZ+49sYorwBErXaWODpws5f8BwOt10?=
 =?us-ascii?Q?nenyN1WfE3R2DyWeGZxzOQ8v58/GB1I9NHBWXAtIv6FJj6abTyaryAPXlh8H?=
 =?us-ascii?Q?+JB7gMZxELgaUjlxgmKoE0+NHKJue845g2UYETwSdca4SOSZ0/9unmDaHomC?=
 =?us-ascii?Q?mWBkr7Smr0PjfCsURuigwXJR1xXKZlLBY6056ZuPkDLAaNLdheQMQMEqtOWs?=
 =?us-ascii?Q?wzP6YfXemmKWNCMCIQy+bsjkOg9hAsvsMRBoJeZZB33BydLYHHsleoltRHjW?=
 =?us-ascii?Q?/y3HGxsPO29eqHpJ73JKhBYFbfFB/3ScldQ02kgMTVeWCerA6ifqejijqArz?=
 =?us-ascii?Q?jG3hWDxn2u5BpVBqzURMb77oEsmZKUUgiBbZr5Kuynqz1dl4KLeLJAcqHe7c?=
 =?us-ascii?Q?B4k7fq95v6n2esRKfEtQPCIwPI9JpV71I8zWpGoCT1NZOjhETCcWcWAjZtT5?=
 =?us-ascii?Q?tmLSYrAzz9ar7g50EXavo+2n+MFrhscurgrNRBwHz/s+qzNf8rh/S/3AGUB5?=
 =?us-ascii?Q?maQT8eEMgPRKIgf22nagX16k5qlagfiYaXvqhJENWMlALxhe16zdnzlXwu4q?=
 =?us-ascii?Q?R4UjzfiOqebEy16k+c3GB/en4ArHhjms7rO9o2eAGnL7sN6wTN6NSBsL63k7?=
 =?us-ascii?Q?Ec+IjOPFvWjayZ3ywpAtcWJHFZ/OYnIQ9UTY9zUAgO9caEWNRsepRBAyVaTx?=
 =?us-ascii?Q?5OS/IGJXL3AGpI+5tTGZBIp5Z9vYiGZTjeluvO/80uQK5Dk1Vbj1gsbsSSJK?=
 =?us-ascii?Q?vnfguB7QlW6CXiU2R7JJ3YnmEqU46iaquyh3sHhdO/OcCiThTiU62k/MQwkb?=
 =?us-ascii?Q?WyPxfPi+nyC83s1EWbypO2UUX2sV5Gmjkkcp6SDApVAYKLJQqQ7AdAcrhwrN?=
 =?us-ascii?Q?YDyFVQBbi1/XInhwN9l+ZyrOFkCnBOq7gyb4DYOohQRMOOwtK3y3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b9dda4-40c2-434f-b921-08df28635f9f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 13:18:58.4025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzD0cE2CHLbny92t5pHYNsa5MmfrQzPIw56xnbdAwhbJ41mHWTvGdEO9WFLXVnjF3cEYsIjuyoWDFXR265C6MK7w4S5DMmaeC5m623PH11f1dfaxWYpemicZSPrirBxd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6953

Hi Robin, Nicolin,

On Sun, Oct 11, 2026 at 07:31:29PM +0800, Peng Fan (OSS) wrote:
>From: Peng Fan <peng.fan@nxp.com>
>
>For shared SIDs, only the first master to attach writes the STE
>(tracked by ste_installed under streams_mutex); subsequent masters
>skip the write.  On teardown, skip the ABORT STE write while other
>masters still share the SID, and reset ste_installed so the next
>domain attach cycle re-writes the STE.
>
>Fault events on shared SIDs cannot be attributed to a specific
>master, so arm_smmu_find_master() returns NULL when the stream's
>shared_masters list is non-empty.
>
>Disable SVA, IOPF/stall, and vSMMU nesting for shared-SID masters
>since all three require unambiguous SID-to-device mapping.  Clear
>stall_enabled for both the new master and the existing first master
>when sharing is detected in arm_smmu_insert_master(), so the STE
>is never programmed with the stall bit.  This prevents
>unrecoverable bus lockups since CMD_RESUME cannot be issued without
>a unique SID-to-device mapping.
>
>Assisted-by: LLM
>Signed-off-by: Peng Fan <peng.fan@nxp.com>
>---
> .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |  2 +-
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  3 ++
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 60 +++++++++++++++++-----
> 3 files changed, 52 insertions(+), 13 deletions(-)

...

>+
>+static bool arm_smmu_skip_shared_ste(struct arm_smmu_device *smmu,
>+				     u32 sid, bool is_abort)
>+{
>+	struct arm_smmu_stream *stream;
>+
>+	lockdep_assert_held(&smmu->streams_mutex);
>+
>+	stream = arm_smmu_find_stream(smmu, sid);
>+	if (!stream || list_empty(&stream->shared_masters))
>+		return false;
>+
>+	if (is_abort) {
>+		stream->ste_installed = false;
>+		return true;
>+	}
>+	if (stream->ste_installed)
>+		return true;
>+	stream->ste_installed = true;
>+	return false;

sashiko has comments: https://sashiko.dev/#/patchset/20261011-smmu-shared-sid-v6-0-cb76b89dc612%40nxp.com

We just need to support a simple case that platform devices(single SID) which
could share there SIDs, such as MMC-0 and MMC-1 share one SID.

Shared-SID masters are restricted to platform devices sharing a single SID.
SVA, IOPF, and vSMMU nesting are all rejected for shared-SID masters (patch 5),
so VFIO passthrough and direct domain replacement scenarios do not apply.
The only domain transitions are the default DMA domain attach at probe time
and ABORT on unbind. Or I may miss something.

>+}
>+
> void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
> 				  const struct arm_smmu_ste *target)
> {
>-	int i, j;
>+	int i;
> 	struct arm_smmu_device *smmu = master->smmu;
>+	bool is_abort;
> 

....

>@@ -4360,9 +4391,11 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
> 				break;
> 			}
> 
>-			if (list_empty(&stream->shared_masters))
>+			if (list_empty(&stream->shared_masters)) {
> 				list_add_tail(&stream->master->shared_masters_elm,
> 					      &stream->shared_masters);
>+				stream->master->stall_enabled = false;

Sashiko comment:
https://sashiko.dev/#/patchset/20261011-smmu-shared-sid-v6-0-cb76b89dc612%40nxp.com

"
Does this dynamically modify the software stall state of the active first
master without reprogramming the active SMMU hardware STE?
When a second device sharing a SID is dynamically probed, this clears the
software stall_enabled flag for the existing active master. However, this
software state change is never actively flushed to the live hardware Context
Descriptor (CD), leaving the stall bit active in the SMMU hardware.
If the first device triggers a page fault while in this mismatched state,
the SMMU hardware will pause the transaction and generate a stall event.
Because arm_smmu_find_master() returns NULL for shared SIDs, won't
arm_smmu_handle_event() drop the event?
Alternatively, if a fault was already reported to the IOPF queue just before
the second device's probe, wouldn't arm_smmu_page_response() see the cleared
stall_enabled flag and return early?
In both cases, the required CMD_RESUME is never issued. Can this result in
a permanent, unrecoverable lockup of the SMMU bus? Should this sharing be
rejected if the existing master is already actively using SVA or IOPF?
"

I am thinking to simplify reject if stall_enabled is true:
 			if (list_empty(&stream->shared_masters)) {
+				if (stream->master->stall_enabled) {
+					dev_warn(master->dev,
+						 "Shared StreamID 0x%x rejected: existing master has stall enabled\n",
+						 sid);
+					ret = -EBUSY;
+					break;
+				}

Otherwise things will be a bit complicated.

May I get your suggestions?

Thanks
Peng


>+			}
> 			list_add_tail(&master->shared_masters_elm,
> 				      &stream->shared_masters);
> 			master->streams[n++] = stream;
>@@ -4522,6 +4555,9 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
> 	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
> 		master->stall_enabled = true;
> 
>+	if (arm_smmu_is_shared_sid(master))
>+		master->stall_enabled = false;
>+
> 	ret = arm_smmu_master_prepare_ats(master);
> 	if (ret)
> 		goto err_disable_pasid;
>
>-- 
>2.34.1
>
>
>
