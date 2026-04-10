Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012039.outbound.protection.outlook.com [40.93.195.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C0A932
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 00:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775779499; cv=fail; b=HzDycqcR3EkZVZ+OXUSXssb1xkVu5h/s6edjSiRZp72CgptDOwoU9cxkEq87KkOroB7BBblXejV6wGNeKXReSJqxmHIZRzTcsE3ipKe2qQD0V4TW1FHKLaTInDKzmgxH0GeTErO1rnzFbc05F4KpIawL1i8rFYBHcs6rmyxltqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775779499; c=relaxed/simple;
	bh=pSn51U1D5tLjwy+rgcqrMdvAiA5JtaGMFiBmADPbUlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hL18ma9fIBXBh0F4T2pTeJl0BhvGtM8lPvwYibByjs/lAo/TrwrQPIqwld1zr+T86fwy/DFdUTs3RJ8618y1WpKez4o2cNllJa5D4/DkZKFJH0+aO6DRxcDxoLOPuY6keu13X0B8A+quYo+bG5O+DNExHVfLmnUeXe9POgbgw5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KQ81Nq9E; arc=fail smtp.client-ip=40.93.195.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KQ81Nq9E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ce8XRyujtHZ53NvsYlv6L0m6X7DJn0t6SMIY0zIxcyzGlncHUs1Mo6NYbuoM4p5OJP8kfU9KNCaN2LlMxIvHQ3rODsu0MuNxgVQdU5p38suJdPy5AZrVkKMYyGK4lvIuwmnQVEJCyyZDhY5xg+ulQEWqb7IvS2qw3OvDLrBQ7Bq83LVC12+YKp58wRy6GB1JU90ofRXnvhmcVypsIiXmvq9GAG3GAGpS8ldio7qy0akahFUXja1mF6pGaDkSQHdykYd/g3j7b7nRFtydkKpLHhs291Jo5b0pqbtDqC5rmHn2z0uuDxhFr7iM324aPnS4hYyKza9X3k5rBc9mPGYFiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jzNH63cXzi64+81zKlydL78snXftsVwG9dQtRTRqjk=;
 b=OiROGmOLduHoK1FLkwWLxQ9zwk7PVU7voY4h7UkAbJOQzyXGtsBDMzWX+Jj7FLanW4qCcndXa3/YHc6lOEiP9hmodNCg2wRUSSgU3nAXaa8ayz6Vztbw9Fn0jooqulfVf7Smm9hmv1M7p68PMbQ6HLyZEwW3GDNQaxKEzIlEczzFEhR5Wm0IGgpygYluU+ATy14ds9FCHk0Cthn12JXPSZn/16QIksEBE3xUOOEqp3jbPbu19mxgrOvg/6UZS9xsc0Olou7TLFEiIfbV3QcF6pOPSYlvBRpWx8oYxWFjMbCS6d3ElC8B6/J4d/OtLzGYzXKs6WWo+ralVR0mIHSaOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jzNH63cXzi64+81zKlydL78snXftsVwG9dQtRTRqjk=;
 b=KQ81Nq9EdnhYwCOkCQSUYNnmhZUZwMy7f/OBYWQk3y3VdAxuvXOp/sJQe4OxI3dJUOyFrTUU6tKPAV3Ybv0L0uZw/LVcSz9ZTAcIsvA9BiSIpLi6qUJGbbRQyfhe+dVKmpugs1uAtiFrVgHvjH5jxQBHX4c3lUMrx9n8iNJfthACGJRJ9H95T9xrrfqUUVmrFG4iZJxq+zNW/YtF4fw+pvB2Z3FWnljt+Is4opMLVtVizwhJKrbClHys7mG+dv6h8UAIhme3urTzH68tFgFK6MSb63m1kNtfBRRSJh0pvF5ORCJXuOtA2L2Zbmda9vK0K/lNGiil/JUGQt0DoImZlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Fri, 10 Apr
 2026 00:04:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 00:04:51 +0000
Date: Thu, 9 Apr 2026 21:04:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jpb@kernel.org,
	praan@google.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	jonathan.cameron@huawei.com
Subject: Re: [PATCH v4 07/10] iommu/arm-smmu-v3: Allocate IOTLB cache tag if
 no id to reuse
Message-ID: <20260410000450.GA3357077@nvidia.com>
References: <cover.1773949042.git.nicolinc@nvidia.com>
 <aea51cbf226d90436918dc09df5cf8f5c64ef8bb.1773949042.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aea51cbf226d90436918dc09df5cf8f5c64ef8bb.1773949042.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0472.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB4328:EE_
X-MS-Office365-Filtering-Correlation-Id: 60870588-0805-4290-9673-08de9694c990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	//DW6RTxJJsKooNXmMsXR3vPdYt5CaxIJWhJDwSyGtZZJNflGdx0r3Teud5vb+g/M0xICk878EfSPYn/5POxNFACAdIR9dwjHI5wCIkyvL55NKkI2j8YCSOGTz7kv7Q3ELkXieRL2nVvWOhB/EycwFc8/2uHaBQ7RtidFZGDvsnyb7ISMETyaI4/DknKox2cynhPmLpFKpsYvQs4lP+QEv+jo0VeAvtYA1R+Td8Dfl0rnpxSPwbf1mwgzRQNtsxCfMeFgSGutuIbWmeDegprlQd7TixIZPt6pYhU14Po3AMH+cEZHZEFFU6Qjkexsg2HHrf3us03up+BLpij+e9h05MBUCGhsLthCTDF3kpA5qhAPV2YQGjnUZe7WJ9ZdGpR0t6J2KPSak/AjI5H25KYq6N2jLQM74vdAmuEciy8SOiZwutNWZWZlspG5TB+3dQPWvcnviNx7CNRJ3KjBIV6ufc+oeinRB1HehMhhQRoCK8JWZEMh46xe7DJTWyAP3lvVgx2ZwKL26I2o4gwa/+1Ym/luzDB76waF0NF/vm10NbMLRoNl3+DjR6rdNanwxTeZ3uWd+SVIscjYUHwN5b20Vb+gnRbmB3vNrDjy2C3YaDjlTda7boGipsi5ax69mLPaL6gO0yqH5oxH0h28HdoYD8y9YpO5lObnEQoaHIJXIK13pj3Zsns3OU/N8XTmLyEpQwKqWSeb/6hXqTrtcjce9GQHBMmPYIWWE1Kcm00bE4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tkSI6bgpKXg1ZDt8MYTIovvl7o3keBVL3IRoettFyNt3cgDiKOqDpaeMFddL?=
 =?us-ascii?Q?S7krNHFN6cAdaGe9fYqF1AXk0N11ofdWgn2149w5V5zAYoEahYsKIfuWkTcQ?=
 =?us-ascii?Q?oLJAySiAeozftEspLpacQbkIzoZlyk4gmb78T4JT1Q+r8y51KVzKkoVbKKu0?=
 =?us-ascii?Q?He7muk88iwM6r2k18aeY/tMvHmtG8pUk5MN8JbhKEQcoJezdktwUimHQq1C6?=
 =?us-ascii?Q?ZW65ITJNp8+/kstnq9TFX8SXhX9IxFVBg3l6LmwWZnttI+9palGl18douY/I?=
 =?us-ascii?Q?sshBsmRS77ODhRp687MvffZadjJQP1I2kuPe7Rgf4QIOmb6aJahGZ+VzPySm?=
 =?us-ascii?Q?SLelRr2fpT0IYNul93tW3sYSGmXC3htwK9WmAR3BQFtKYnh+cnd1bXxyfklU?=
 =?us-ascii?Q?679R3A17L7nciptliZqyd53tAWALK02Q10maBpJzgKL/bf1koVu6CEnu1tbp?=
 =?us-ascii?Q?C1PLdr8qrzZv03M5zHiEBwbFXNWXZEYo3XjTymU8+0YX9MZ5+Qkt4ksnFkIE?=
 =?us-ascii?Q?DiLL3XJmqTWiF5PoRsbx3HovtXnKolIf1+cRgrr2qpoQhRmLk8IUEAIqIkmr?=
 =?us-ascii?Q?RMzHGXbaHV14Y/ZpcqLHF5/agDVjH6Ee+8d+EvWljRqcRb6dW4lpyXNxEXgJ?=
 =?us-ascii?Q?u5gMIERZELdrLd1to606VFPKcwO/7C8vIvubdldwYX/XF0n2PNcoyz82m4mb?=
 =?us-ascii?Q?uanG84Ea3idmWIM7SNj+bjKbTMeJ1nzrURx5gu8/c6jEyXPm6XmxVlCucRf8?=
 =?us-ascii?Q?833XyGQ+EtmQZY6qEIMQk5exyO5V1oQsH/PIGqdDz1Kzl18nU1x70Y48vsLb?=
 =?us-ascii?Q?/oropjxepCh6EV6tgNYIW+1rh6WtAR7taTs7TBDZ/VHbmYQrYF6tpkcRaVyk?=
 =?us-ascii?Q?dF2gXVkTcV2kv+FSieEHvw1+2tH/GsYrxU91Ro/3Z8p3a1AhWYrBC9GVL848?=
 =?us-ascii?Q?7VWVIsBEkOEEIdmJyGuiZj2KjzNZzeUK+yE06ZhZVPuFrrRaD1deirltZoYG?=
 =?us-ascii?Q?3GDHrwXNXriO+bFqYSZsZPJjgi3RUP68WkO4VSIXE+EYD7Ro2DCJQlZInNPA?=
 =?us-ascii?Q?izUZ37Uedb8SqQUWJ2GlRHxhvLL3QJ4CvlkxXKpspj/ueO0aXrbOYUwSfL86?=
 =?us-ascii?Q?8Xn3eRC0UX/pxnAra99r0ryA/HGcUAeUxVW86ub1RtN9jiTpRpASOdwlaiKl?=
 =?us-ascii?Q?ZG9wbB9VrNMaXEgghn1WgfLS2hXEftRyirQNO0h/WyytqeOX1/KYjqBttlqY?=
 =?us-ascii?Q?MUHOBjGLpUeGy6evmeV9ftKGdfR+imMho2qbUVKko2G6SXzjNLJe20qY4V23?=
 =?us-ascii?Q?DDfk2EG0BxpyLIdF+siB8YuzWu0Q0sqxKZfSc+57QDZDYfykUz+83LZdVpDR?=
 =?us-ascii?Q?7+PHeT/MR6dANPHeFLUOSb2/lF3z1em6RT7kCXccN0VKEAxikG0m6WRI/Dtq?=
 =?us-ascii?Q?kkaSOdOSw36AbIqdam+6qNXtgakXg1CFVrzYuMwPrgv4m0ZYMwAOyeOV20+e?=
 =?us-ascii?Q?EVms7clKFwmFNEtKcEa3MeN553eBPuW8vLW7gyePG6Rj5vLmoYNUXycduOmz?=
 =?us-ascii?Q?JXvxS293kQ7CI4xtDus17AlOz2sYUUHybzER3pRxf9bh8o9zshQEsn5lbfYY?=
 =?us-ascii?Q?ygGScmxXlvBb8FUZ8o1SgjpFh9xyZJCTjeJal972w0OMq0viYaX9EltKfVrp?=
 =?us-ascii?Q?HAbPriAjVez62yZMAYmPo60LTPh1y4ENlowHE342Dhi76eGR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60870588-0805-4290-9673-08de9694c990
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 00:04:51.7036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyUW0q1kerYHRxTXPkZwMMFPkDatNQuQjl1X2GYTtCOZYaftDOwCXmrpCKnQeikw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328

On Thu, Mar 19, 2026 at 12:51:53PM -0700, Nicolin Chen wrote:
> An IOTLB tag now is forwarded from arm_smmu_domain_get_iotlb_tag() to its
> final destination (a CD or STE entry).
> 
> Thus, arm_smmu_domain_get_iotlb_tag() can safely delink its references to
> the cd->asid and s2_cfg->vmid in the smmu_domain. Instead, allocate a new
> IOTLB cache tag from the xarray/ida.
> 
> The old ASID and VMID in the smmu_domain will be deprecated, once VMID is
> decoupled in the vSMMU use case too.
> 
> Since invst->new_invs->inv[0] and invst->tag are basically the same thing,
> merge arm_smmu_inv_flush_iotlb_tag() into arm_smmu_iotlb_tag_free().
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 63 +++++++++++++--------
>  1 file changed, 38 insertions(+), 25 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
