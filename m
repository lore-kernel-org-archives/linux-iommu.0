Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A46C5223
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 00:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729730188; cv=fail; b=qom6XbGWDu4uSe69mIlMlEDM/btn1+HplvdTy3Uqmcv9CsbF0nD2c9WcgQmUqeFxj7Lm0lgHW7ZQEFbe1efKIzul0dWKiyHpkBFcomj1vomoayGI6OR2OfcvhLrGFQHb4jc7CZgNuEnQMrGtJbOdem8wchcu16xfpqR6bzJ5Bf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729730188; c=relaxed/simple;
	bh=mNcaVaX6cXLuz/NdSJN0ihXTn/CF+kAH3o4jAL3hFLI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgMXb0TBCGOvHAXyEULHRyqz04USDL7PbWOkkI90m41T/hjwGVqPCH11KEMkYeJRGH3lm7aoeIkiLKxHJRhSswHglWjiIEbWiEB/gn6GnGTxKbWJlHckVvRYIddUUNYymwsNdzkvlGAeTtPw6/FGekBgjSLMLTiRjPhNIvsb8eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jkqjx1jD; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jkqjx1jD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVJcn/Yr32yV++kyhLd2zuxgFX8FlgtlHggyvzMB6TMljdrwN7xudB7EAJNvZhPG9tdERyWmb9xySBw1UbDEVeSnyeeV7OGa8tYdnTCgXtsxt+WD/eqn5hMlAQFNC/CkDxsND4RWKQ21MbwmnbWFXTniPe771pV7aeEQp634mna69s0TBb6ukk5tz6w/sSixvJOlJmQmNKUjyjbewvNfGrocYxe32oNo2O2yTE7TBkFWXyVG3uWxBcWIksUeCTICHmu1WlORdJQJO/7rdIwzPraVoSUsYm3cgYHg171T0eCw8xzwOx9Rxt5gY5KuEjY1mSgqqkNfmOjRsoheo0t/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMhOoBgWmslBizID6+NzFe0ZIGfrD/e+1MZVK4zZXOA=;
 b=njLFIMMx1uvpK6iXOrFCZqXLDfEss+hOY/LwcT5uyAEmDvKLit1XtA2vT51kOhMBI8OQoZAa5spZ410bJ0ssddDePnJmMdnKWQiOyFHjtwMM1atRCxlIruYVF4xx/SLzDe1nsGKDl7uFmlfWqXA9X3Hi5+xVb5INMXL5r0zqGWB54p1WLniFXRxLeP3sqXZvbzEFKtWhw94pIlHl/tCI+MmOo6S0aUJ93HFgjtyYOrrxatphmhEC3LOLQ7heNiaIFWF2CV/I+YLtMV7x+7K645rWfRPBHo0GLE+wuM/GCXGN1OaOpM7Qh5WRMoC6m5vGEiu/FmiAu8Xve0T0gCYfHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMhOoBgWmslBizID6+NzFe0ZIGfrD/e+1MZVK4zZXOA=;
 b=jkqjx1jDIQY2l1DsWwzv639XWhcMZgJ58Z8Sp/wlk2LNnVeI2cqhSs313yKZun9jHZg7FVhho/OnZGrzzBXIsSc9NLu0wUe0c2rOsDp+dV1RL2sbBJoviHYmvokmRn3o/qcIIa8xCgR1VtEKqJFziw/i2LalE47C6bedTk+/LimI1GYFXePyj8WFtvbkFMrk+g1LdV6Zwa57aE7wnuXn62ztFNmd6Y46noPvKhN0O1D8skRiA8Ggz4bmCIcgY6Ek6Y7Zbbm6k9n5SAVYILIy++5OAxKMbFzxhwPtjERSPXiLKSgCGaraQ1Gyxm4zQA8DwHuWKrD4QuE+nfMfrbUCHQ==
Received: from CH2PR15CA0029.namprd15.prod.outlook.com (2603:10b6:610:51::39)
 by SJ0PR12MB7460.namprd12.prod.outlook.com (2603:10b6:a03:48d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 00:36:19 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::d4) by CH2PR15CA0029.outlook.office365.com
 (2603:10b6:610:51::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Thu, 24 Oct 2024 00:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 00:36:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Oct
 2024 17:36:04 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 23 Oct 2024 17:36:04 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 23 Oct 2024 17:36:04 -0700
Date: Wed, 23 Oct 2024 17:36:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
CC: <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>
Subject: Re: [PATCH V5 9/9] iommufd: map file selftest
Message-ID: <ZxmWctd2d7iyRz5B@Asurada-Nvidia>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
 <1729630838-24586-10-git-send-email-steven.sistare@oracle.com>
 <ZxlZbBP3XE6alSPe@Asurada-Nvidia>
 <cc72218d-d4c7-4d42-9745-c5351fd8563f@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cc72218d-d4c7-4d42-9745-c5351fd8563f@oracle.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SJ0PR12MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: a0518ea9-e55c-4532-2b41-08dcf3c3e071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tW8LjQ+QyVxi09xepG/RgTeWdLQCWSKoDkDFKZdBUhdOCiDvy4ynb+tiAoH9?=
 =?us-ascii?Q?kHd1rQPWZPv43gM5+LVXP7d9dN2nqmNvd3pUlNGgXIW7zNllXAEYTxn68ZtZ?=
 =?us-ascii?Q?F4ruAsgnb0N8zb1zL0vR6OaAYcHztA4A7t8Y3JPqB+BWYIFRMbVllBTTOvjb?=
 =?us-ascii?Q?Z6kMs1BhL1AiE2Ud0abYKZ2uVr0cXw++ELTSv0hv7CTzoDwFeJ1d+jBoegwA?=
 =?us-ascii?Q?DfSfmb46YUIDU4dVwvrgAXzFPTahrmgOYmsryPVf0ywZ5PeD2gvLWwOQVRKA?=
 =?us-ascii?Q?B8OeaDnf073dsCLWVx69+40SlvWrSbQKe/E1biYPu45JtrsesiJ/YyKljYhR?=
 =?us-ascii?Q?Rx6hAPYNpQDf/PY6/29qhkw6VVv1zTYHO1rr0rQL96n0o0s2gqeDww9qInEF?=
 =?us-ascii?Q?3MiDMyK1soiCdiTBkOQkXPtLLgZdARLRFsU0MvVY/XasO52fEB2uuwB0e8Qs?=
 =?us-ascii?Q?+a8JY6eppwD7EY/Wy1Cmo9nx10vaC7ChbyXaldaGSKJZEGSc1EH5D+ZkfUdz?=
 =?us-ascii?Q?iViLcGcco072w21pcXF9Tc5pg4xWGt5raz1Z7IlLp/t/q+j7rmlnVySaPkAL?=
 =?us-ascii?Q?PwhPkpPvg+8Ihh0MqtWRQ8XIUJwUkiEioRZIdmYYm4UsCXRYrrTayYgGG61x?=
 =?us-ascii?Q?uZBUYGR36QwOrLU5yKMw5RB+SRFFK1OBRP66p+pzJ5/5luo6cvBEjPjx+vFh?=
 =?us-ascii?Q?yP3c/uiXXcdeRawBgoHLX2+dV3FF9Ud1VTmzFrssXt9zfuo/qtAjWSnMWNDS?=
 =?us-ascii?Q?gRdPFBG5MMFGjTlSYjaR3Z3dHOdj9Zh7a7uU+lYf1AZF9BcN84NELw9LRQvU?=
 =?us-ascii?Q?8OjTttLOMePXOePv4k0FG2xLvo2J8L9q3OotH+UQgwJwlbS4MNg5WkkKMkba?=
 =?us-ascii?Q?X29lBj02Zrpfh7Hz8nWfaxvWIiHoQf5sLdAm3X+mzKg7BnSA0NrmFc3032Hu?=
 =?us-ascii?Q?mA/o3Hjr1l3r2TDIbfNZxY+mHQ16sa1N2Vk2SM8Bzl60rROoONlYGN3p+5rb?=
 =?us-ascii?Q?8KGLM4EkZzM7SUdxz6UWWXq/SWkFdVnRR95mXeXEudCgq6FaF5eL8k05yGpg?=
 =?us-ascii?Q?8cqfKbkKupak6bwNN9c/eE8Tqww3aSkYdvw9n+gCvVIwtDWXqD4lC//nHwYO?=
 =?us-ascii?Q?CYkuBhVMacj5taAZfpLKWkeMSswyqNjghI300eotqOnjxW0y5VKVfZU/eVCG?=
 =?us-ascii?Q?TqRsMa1+tKGywUbSp3Dam2+fMmmIAmXWsMgdt56vKvSyFTTMEciDrrjNj53A?=
 =?us-ascii?Q?kSv9dqNL1qXNWx4D/61Ga9ELuBXut1OmnyRNHAq3ysCqTXdqCGYCAX8QGwCK?=
 =?us-ascii?Q?Od6fPjYLpDq4c6maeWHKArA6ALuAl/KPgjbYwOGOosvFDNTqbGHSUcyAEVp5?=
 =?us-ascii?Q?qY0iL7pXH6HnP/pP7FwBYxIh7c6XH6l+Q0yntYHhepicUiXX3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 00:36:18.7734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0518ea9-e55c-4532-2b41-08dcf3c3e071
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7460

On Wed, Oct 23, 2024 at 04:45:32PM -0400, Steven Sistare wrote:
> Thanks very much!  I will fix all the nits.

When you respin the series, would you please also send the series
to the selftest maillist? I think get_maintainer.pl should give
you the list that has it.

Thanks
Nicolin
