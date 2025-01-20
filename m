Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F3A1B982E
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737385257; cv=fail; b=IH43Eyzfipa6ecTk5xgrgNDmFRN87aCGaA1e9+nLCG/IrE2yzuoliSMGF9dA79XJXKrTBNEsqzsbckySlCxTAg4MtCYgs3+iCgXNpj2C9Cumbyplqtb9NiPXvWDQBCWx+i52ILBuYF6xkUlFzXbgl/Pj/AqGQe290/VRVqIxP/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737385257; c=relaxed/simple;
	bh=6pv70C7G0DYBDAFH2qeQyL0ErqLEiLt8OaFFCnv8n3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ljD/PcRnr0vsnUgSBNzFfTQDnAvTIseGTkm+pn1zHxIILKV3VK5IBD0T/G7LXQ5biFa/LjOSZ8XaUU5NUs0Uj0BgtYTEWy8Qflx9OCkVdsUhonpjn24ks7EQG7ZNFgWVYmbiSDL5ZrlXiZb40TClzQxRIh0pzKNWhnHE+lGruBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t4YNz0xt; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t4YNz0xt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJafPvqEoUONDmP+/tqSk5UzWIfwyid5eiDULBw1Xu6zUupuezzsFocEGAgTIzXzfLGXwz3DfUpvMFJEjlbaICgMR3J1mxw3wy+ttaDR/utDZVFYxtRZi5s2vGg2+Wf1sa39J/ek2e+5OzoNgn9cxhpq5GGndslZdBQnHNiYHm/xq/gSmVvtn5IY8xbwP+pXGf14W2HUiN0egts286A5QQSTjgto0LAtM5AOuL7Ji61wdk0/TFa9QBI/zmC9pygR+2mKE8wm8yRvU+OMwcaAqCjv9OqyNeP2AJgrIIN/DGa/Rsw4V2kqYsxJKnyo6DYepHJwbk5qlupJW4gI9qO3JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pv70C7G0DYBDAFH2qeQyL0ErqLEiLt8OaFFCnv8n3w=;
 b=dZZ2ER1eSbYNickYxiNLrP+UKSqUfB5Dv/0iiOQs/UDrekjkXqNirj7oEFRfb9KTdwRMy2JUgCVoTwIjVar8QIA+PRGArdW/FTy9AHK2APr6zUdfg1Ras5DJepiuuIM66zZGCuBJoZ+1fJyuXo5gRnCm2J7TlISpeEqAD3j20GdVlVhNzj6xPZzw25GVjjtcks+7XYTMRVjWl04zbv9O1wISyiKQRlOWusm4Z+IaCb6xowmEGLibA556heR5sLM5VxEc7deQNROzFOtY7CLsRuh5rWSOFx8AoV91GtD1T/NVPwJxtspyVihm+fplsDSOUGLivm0/QE40uO0IOstxyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pv70C7G0DYBDAFH2qeQyL0ErqLEiLt8OaFFCnv8n3w=;
 b=t4YNz0xtqKmziJCZKh7KVWrMBowDf0poQniX1dql7vHwVRxJ2Iyuf+JWO34E5IVpsFFMIowojh0d4Ld4RHF932N+Eahmnz2Zvn5vUCcaQ5AGed4Fva866KhpVE1Bh7LgUwBxlyhsNx0A7bDbtCceg85CYSWZOK+IlBhVN7BA8slPAvLmYDasJwgVGl6ftPosiMyP+0OKp1shptrDVJRPCFvw3m/kWdzwZ9j0NTm22zOIvO+e80bKfliYCHa3aOkI+LiYhtjYLQSbi3vUrR9qeME5MCNVZ4rnVNs1IM1/YZFq5g+6AHLAw0oWm3J6Zscxv7e6jgfkxgNAIRmpoc2+VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 15:00:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Mon, 20 Jan 2025
 15:00:51 +0000
Date: Mon, 20 Jan 2025 11:00:49 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc v3] iommufd/fault: Use a separate spinlock to protect
 fault->deliver list
Message-ID: <20250120150049.GJ5556@nvidia.com>
References: <20250117020449.40598-1-nicolinc@nvidia.com>
 <BN9PR11MB52763118C04E83C14683CBC98C1B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250117143856.GD5556@nvidia.com>
 <Z4qmGLQ1oB+aS9h1@nvidia.com>
 <BN9PR11MB527693E6217946E1386B72038CE72@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527693E6217946E1386B72038CE72@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN9PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:408:fd::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: c5584023-e588-4afe-7556-08dd39633af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Ttm90XvDztsnn+nmkwZJ1HDZA1nf7YeDA6MR+NZioWtieXC0xlWidNJmJi8?=
 =?us-ascii?Q?65Q9W+TR+eb1QtVByoZjZVhvxNDHivEWw6cIJSS3PUIiXsOSSMsLIK6NspXU?=
 =?us-ascii?Q?gZ9yzepzsGyfjH7dTRdNsBUKjVmvpOu6rTbSmKKFT9KXL0bpLkhpO/85wN2/?=
 =?us-ascii?Q?Jqz1iAox8cH1tZ1AF+/3lf13Cbd24osuYhPv8BKWlSuUT7qiWNt448z6f5rp?=
 =?us-ascii?Q?YZSBLvpKDtQoDYDoMRVyQ2v9fJRbkx9MIh+gk/LXAZUquI15k+yzTNC3oNdR?=
 =?us-ascii?Q?XLdGC21gADVvOaDayaywwpAjhojuMxgtxfsi93mK0ClsqeMoc5DPoBmi4Tnw?=
 =?us-ascii?Q?710CErtQej6rv5SKSUJhIPrjmDf2ZwP4kYq68JFJebIlhp7zLmtProdbxkOD?=
 =?us-ascii?Q?NsxC6RU24/fTd1lOYD/B/ILkdX5r1TbKte6SccThp8CSo82nWdfv47IYD7ca?=
 =?us-ascii?Q?vB2Ieaq04PGUxsz0UO+YySRfJq5RiKZOkT7MjcvND77u7xdn/W5uckcJBcoE?=
 =?us-ascii?Q?cXDfxjphbiNhqMMyktWGVW4J9vIkd7q3zaP24ns225BmiQ4cFP8B2gctSxEC?=
 =?us-ascii?Q?EB4UQnv0tM4ZjEEuocMrwdOeoxA/0k461/3bS6grxiAHZjr8CdN1AC/NYMsa?=
 =?us-ascii?Q?6U2wBSQ/WqXFksn2ywkwkQnL22qegOP+azgZcC4n1xKZVye7xlhruKaxV8cE?=
 =?us-ascii?Q?EomGfSjBZ1ScHKCmg1tk4h/xw2oqFrnjhV7YPGfUSgu7Kco1R4qYjt8EFgfr?=
 =?us-ascii?Q?K/jTf2FfZs7YwYJx7P0PvqBr8MybZE030nVRQ0wW/7r7nEYY8LDAKNJa0zER?=
 =?us-ascii?Q?5Wtp1dyShb351evDyQY5s6TDRy6/Bf+oeVgifC1a+CmrTQ7O/WQwSdhMD6lI?=
 =?us-ascii?Q?gZf2O3nuATFCDGP31rpuVyWYuqEQ5WUnbfOo4QL/lIEvBVCghilMZhedcX2x?=
 =?us-ascii?Q?ylyWXAGEYkI52Aqy+LMH+qdop9pUG/PUcX9ztIh1ZrwhIXRoQCXOk7SBU4x7?=
 =?us-ascii?Q?W4Pw+MMrFD5+vGmEK4oXu1IGCr4sCqVWx8tuRIY2xbkHjvi6yNBC3gklaJC9?=
 =?us-ascii?Q?dbIopM/P7/XpMD95nJ78e1vgY1Kt77GpotQLiYxgEjhX4LjUuph7tHRtxvXX?=
 =?us-ascii?Q?qpai4tCOcBS2aSRubNR8bmYi1b4SVMt1tOnd7ItTIvbgB2QbHTCiF/KRg3Vs?=
 =?us-ascii?Q?6thurr6l3eaAegw3QfLZQLHkNmjb7effy8VAKMc1gS82WA1rhEK/ixwSVo82?=
 =?us-ascii?Q?sLt+y9ST/DaC+D4R1nWhj4yVRpLvrxepXH9yLbUzWLENTQVebOTIlHAkYhIR?=
 =?us-ascii?Q?GzEV8JRVykzkPnds+XMFmrZFeItaxTUDDJ9qhbnBhJExwLcLwGoswasqOrCC?=
 =?us-ascii?Q?FJymnNAZnfZe2PpI9c8iwXFhC/Ps?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wMjrcOAg4a1fR4zXZmi3OFgQCZswaVRm67DEbN6ZXEqsenjS+h2wQoFoXFkI?=
 =?us-ascii?Q?vYJyh/b0DdcmC3gHwQIx75W1WAxmNq92DBiLHCzl/1/obN/cUO/NHhiNKl2q?=
 =?us-ascii?Q?QCzdONRqFqLlTxh0uWbNa1+VnZwZwn887KSepIXd2VFIOAbY4/xfgYaZyKt0?=
 =?us-ascii?Q?kuqYGJmFAOz1JRSZfUq+U60+4uXSvTBm/N+9yOLWwhvRrNW3kjLhWdUTJWBh?=
 =?us-ascii?Q?/HN1OYEmaDXaqUfMlKDYxqDXVweC4UeQIeSnRiwtlCNk0OWfrNFpXX/Os85w?=
 =?us-ascii?Q?s0yvCCWjVgGwj3U7rur3iKsgj7imJLRCB5qdgMl0ZGmm1vwjN/560u7uvy6Z?=
 =?us-ascii?Q?q2otjwBN0ZfPz4+RxbaYpBabKpOcYRUaNoWRuuo5Hwkkxf0Xmp9tX023CH0s?=
 =?us-ascii?Q?LdN72kt8sK+ZKSRy0Z8Dd7SoQ70T92d5sdOgFNGzjWpnrSASCf8dDOwIgpxT?=
 =?us-ascii?Q?MIySVMLjeEqWp8MLFHxWIsmugB/hr23binOwPmzmM3rA+7ADtlFrdAIen8k4?=
 =?us-ascii?Q?oNo9GqjWdwtiM22zAgFDwupZcB+kI0orAaUy0VVuosqxfcVUeNnd/RCIz42z?=
 =?us-ascii?Q?7P5FE8L57/fFR4lYw0QQvCjTFkO3TiLUrx1P2wECyz644y1W6xRuiO13ifJ1?=
 =?us-ascii?Q?rkwRzPmrUMwzh/KspciRIj32YTUJILGbiJW7K8t5Z0shwz4rAtk+ckqmXV86?=
 =?us-ascii?Q?yVhyhzMTe90IlNzP+/JsUtseWwRuCJ4Vllwko3tTuaO5Y9tY0bnmjHbbTclq?=
 =?us-ascii?Q?1VvWExC/mD58cHfGUFxj9iwt+CP2LPo5QoT5aQ9wMW5hHEAG1WQeR3DzXvMA?=
 =?us-ascii?Q?/DKGjIt8udSpwBeGHCYZ1MUrtfRCVu5G9nOnGf2adf4SHvqMgabk3HQlxlKy?=
 =?us-ascii?Q?w/zQ5h4x60fEtGOn7Vz/gKkPcTNGq/NCbH1enasmjvzvowIr21jdYaud+qNI?=
 =?us-ascii?Q?01fNWkkYUlSTvmG1EMhHmfRIGpP1HKM6RsEj640SkIMU62tBl5zAczZ7Tnqg?=
 =?us-ascii?Q?RR9iLAgem3LFGZCQsj6Zp0fof2GiBNaWRtJkfCh0FMUF/iqsxD7+Xaqnfdx0?=
 =?us-ascii?Q?q0GNsWOWZEbD40TXuvrQkSR9wMt/tjcfIdPkob3sbVxI5OzJXi/9jg7kg0Nz?=
 =?us-ascii?Q?EuB1iNfrbBedHH80x756TMm0o2Vg8AgFlp8ySH8wG6MW+i2jfrTlUdjY12QJ?=
 =?us-ascii?Q?RaUGw44WWEAnERY8N0mrtoYemnVBAaAJYI7Ih6HZsH1B2zzst5ak1gcBFUf0?=
 =?us-ascii?Q?sxmXuCfUld+aJDLz11JkCMRw4p4rRsU2f2jXeC7a47piG+sWIc45s9D9KgsG?=
 =?us-ascii?Q?GZMWnGg+6RQJQ8tFjbbZzuPPNawQN7WHXA9k1KS6Pe54UUixyMkciYIQSGjf?=
 =?us-ascii?Q?8xV/t1jkGUuKvZvAUyebPE8WsGy06gkpJrHHZ1fWrBXkgbAidrWdI3k6k8dY?=
 =?us-ascii?Q?hQFq9iqPihwCfGYhYQ39CJCvGWOfWXMYbJzuQHVt056LHEXoXU6w3mmLmotx?=
 =?us-ascii?Q?vu8LvmSIfirpiT/FhlAH6G1Ne7JfLykCEqONQJ7EDw05juQzSkh4EmUs1aVg?=
 =?us-ascii?Q?4PxaarUTYhFHL/tkXDM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5584023-e588-4afe-7556-08dd39633af8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 15:00:51.2144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDW22uYapzxOuZt/gjGMm0y8TYK9RtzYOoG2di8wlX5to9KStehFrvYwfLRHeqtr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7900

On Mon, Jan 20, 2025 at 09:22:28AM +0000, Tian, Kevin wrote:

> But I didn't see the similar logic in arm_smmu_attach_dev_blocked().
> And arm_smmu_evtq_thread() just removes an entry from the cmd
> queue and calls arm_smmu_handle_evt() to report. Seems no track of
> when those events are delivered.

I did not look closely, but I would not be surprised if this is the
case.

Jason
