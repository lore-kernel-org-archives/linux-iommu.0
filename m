Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD691AB52C
	for <iommu@lists.linux.dev>; Thu,  3 Oct 2024 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727995829; cv=fail; b=qDlv7R3alnge3tdbYx99LlH/NBPyLQ93i/Bl0H6LFVjpOymBmmmmOD8C4iQ6WL56fT5H8S6oIWy0d/gjlRV8pdhUJHPA0N8U78zHwTwJKp5J0Ucf/nqeuJGrpRoJIPU2Q1FYPM/HCIL+tB6jpTpLc6GXRKgkM2QyXrnoRQFDPRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727995829; c=relaxed/simple;
	bh=sfDXc7a6scHsNpEmDAOS1SfdfIXUzCUKmowoxm9TZ4A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooUtd9A/4OuHDko7Rt6VLI4V5JFta91dnbjlW0VGfnFk7a7+KjE7vtFsMYMG7cPeHNqKFgXrY+EDq39l2ndvA0nzzWeK5sovgPbseA94TY5JHrW3CMC3R1TEzAVV9aJz28sLrmIg2zmzxP7DD26Ie5gw6ZzWzWm7tHbSena5tmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nvx1nqyb; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nvx1nqyb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuj4YWjmMm78pDxbKPeTmRa15j0Hatj1b1WcUwCbFprf5NCv57HJJ7nyFHPqSVQc9K9/bG6Tcr+cgCuZ6HTuSqYmWUVvG66C3nzMNOgqr33xovHOlAjr6syL2ICWPth94pD8qUuX6BPmrdB9pgmmDpq/jwJ3aX/oFU0gxJjQ0Ckk6a3nXPDXyGHsPNgJrF8pmFA++ORTRw2x+dSkZeDH0i123hGEQinTwIAhbgcKxezM7boD8YNjfbIvEL8YLu6pk1dHqUlQ/hKYZjkL385vvr/HPGSMr++QB3aPTpG7JsmvN6UBwJUGjP9FVLnVI++8lSNu4sbpXDBGIkl6FzyZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARd/qDnXS7IseXJ5VzALD4oRYOPJW9dB3aNdV2IIDD0=;
 b=Adm2ZlISAGXV+W2kjT5YkMsKhZTztno9vHGFuu0bc/VTVBCcfeKbsp0f9R68s5V/TkSSbtO7S3dTFQXQgfsmxJOLlf3XQvXw/K2GCp93x8n7PbQNujVHTn+v0Be1P8IPGrhjzWaePQSCfsRPUUnGHXu7z/ksf1r73xi6V+HQaBYGuHz55tsav1ct0Tq/R8v4W7fhKZDnrQY08XmuAxk6FX+iHUYVKDAPnWbed0apUYXViIMDItBRqbIrRWUph7/LO9XILK1rMEiv4rs2XpStVGU4PlghhfPb2ONHgf29fQlIbrKN2qi/qGApT/QQgBlZDD/IUlC0WLCGSfH3UGI9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARd/qDnXS7IseXJ5VzALD4oRYOPJW9dB3aNdV2IIDD0=;
 b=Nvx1nqybhO3eSgfFbY3/z191JYSIFkZ2hmpKUoYoHMhiFENTdW1F0xk/ja7xDGyC9JrPyhOhtCLCrSrIwNKn7F4OFyev9j34rgJsTrWBwxoe2VG+H6JjnThQkY8mTJBxyACTBG8utnbK2qiS3TrHnvo/AViEVaM1SQkWfoNM0Aq1Ctjnp/u1jeQ4tL522Bq69TdcDWu2CaCZdRGuvpKVBcyYXdToWwezjzbLGXZovLWxtZcIij47GpJRj3X7DhrmdC5hjw5OadKSu+T9hFu9wCR7tWq0Lv1QiNQLotEzYER1slxoAW30Ue+XjhNg7V8I0hWXASCWPCQGnptH6pvX7g==
Received: from CH2PR08CA0025.namprd08.prod.outlook.com (2603:10b6:610:5a::35)
 by MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 22:50:22 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::a2) by CH2PR08CA0025.outlook.office365.com
 (2603:10b6:610:5a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.17 via Frontend
 Transport; Thu, 3 Oct 2024 22:50:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 22:50:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Oct 2024
 15:50:11 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 3 Oct 2024 15:50:10 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 3 Oct 2024 15:50:10 -0700
Date: Thu, 3 Oct 2024 15:50:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Mostafa Saleh
	<smostafa@google.com>, <iommu@lists.linux.dev>, Daniel Mentz
	<danielmentz@google.com>
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: Print better events records
Message-ID: <Zv8fob01iAGP85ov@Asurada-Nvidia>
References: <20240928005143.2378938-1-praan@google.com>
 <20240928005143.2378938-2-praan@google.com>
 <Zvr4vmU7u2BY3MLM@Asurada-Nvidia>
 <20241002135728.GD1369530@ziepe.ca>
 <Zv168jJMZpxGLFmR@Asurada-Nvidia>
 <20241002171052.GJ1369530@ziepe.ca>
 <Zv2BRcOjpLSe+1cn@Asurada-Nvidia>
 <Zv8MDB4a_P3Jj6x1@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zv8MDB4a_P3Jj6x1@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f59e235-290b-4fe4-cf1a-08dce3fdc351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bRwgXeduxeWKUNtcfkKOUOH/5hd3TsXvwqFBz6auEvh77jtgwE/WuaGkyi7t?=
 =?us-ascii?Q?adPPYSIXQf6aEikJ9NS2gYa8+1kBsZqCUYm+ZrPqzB9kcx/Tm5e1Ex/jeuae?=
 =?us-ascii?Q?9HqXWxiHu5qCM5GH49mwjZpWQSvl4zkesTVUx6CVa4UlSZQTT1tvakPgFd/A?=
 =?us-ascii?Q?pd0Pwc/XwTgHyW9DPiMp4+A8ysW0Htg+uts8Qc35GLnX0z9oZWK0XQcQNpSd?=
 =?us-ascii?Q?92MwpxhNhmXrAF6eBQTF+VqMHe3aljESLtOGZit142ODnZVvCyRe4DKbwGth?=
 =?us-ascii?Q?nupzis+a7/jKrIL4kGhuW2cbBr3TgrbHNOimEXfZG28Q6Vc4RDptF16QQrly?=
 =?us-ascii?Q?LzxZmdRm+z1g+K73uH+IVPRTsIo6oYIToeV877xwdHtoOKjq3SP3XlUPGb2u?=
 =?us-ascii?Q?9nRB5i9JEQr1Es1lKytAjpleiJkFkHfhbkxS2xIDiUfj2/NM1Pq21vB/wzos?=
 =?us-ascii?Q?fyqd7D0yp9i/vStTuEcy28ZA46Xbp56pd01L7GKBRpzAsCuBjmNpZz3uBiGk?=
 =?us-ascii?Q?6GCq8lxr5Xbb3Ee15WM4ffixJtMbfME7gYSpHXZBtony0FpF/oTDCRGJ7bCG?=
 =?us-ascii?Q?qOHmhUAB+zF0ktYAGyvlSAQCXpupz3ie2BDQ4o9O7ayvwdtqy88ybI69ahl7?=
 =?us-ascii?Q?lbNDURlWPiqVa4uMK8SBGWyQl4ipl76SU6FEyPbvSWbAHKp3yKkvLvtbMemS?=
 =?us-ascii?Q?plagktUh3/z/n4IeFnKw1NnKlKSJHjtHMJZrjhnLKfvpuEjG0VZZY1fYpxmi?=
 =?us-ascii?Q?YQQ4IOBt6sH6lmWULL4U3xqcfW1N2nHTa5cdN1ZGpwcm+0IIbIgg9xpsiqbZ?=
 =?us-ascii?Q?Xj55yUbcwvdovE785KbK910dSAlWiP3K3xtRLUgA68zGRyGA825FJkJdVjqd?=
 =?us-ascii?Q?e27HXIzakBJPDfeqQlS62mf7q4YZ9aTfhCZlGW7gEhEVa7Q8lmtdU5Ua+6GU?=
 =?us-ascii?Q?urBwVy8+pkcpV4xG1wT2JIruc6DAhwsUFIu9QtCJ4DGrcRUB50uYgwYCo0G6?=
 =?us-ascii?Q?5EbEqbDkn5JDyio3gVFUCV0pZfCa2+V3T4DYHZJfqFEx9rzLjDuLbQQYCeCh?=
 =?us-ascii?Q?NGCtCk9bfvVWMaoaQBweEn/FVYXM1/+v1/9yB1iYvSs2bChoQT6sUt7VdG+g?=
 =?us-ascii?Q?6VamMvYnHdRHS81d+ZpeToAEoNYXSbDvQPHiGOkP8A/VQFts9IiDtvhgXO4V?=
 =?us-ascii?Q?2nrj450UqP9cuJ8D0BMVcoLFa2qFQg2/Fk6rTGV++mcqdlsXi9DC0U+NnCU2?=
 =?us-ascii?Q?8aD5IVBEuGB/uS1PYclPAGnFCDC7qyFLSoDoU9jOFjy+0dkXoSM+AmqcO1yO?=
 =?us-ascii?Q?dvrGD5E7pr9V8GGkt0/V5MUrQU/RlPmxVarNJ2TjK9gAog+9+jYjnluc0Vs0?=
 =?us-ascii?Q?XUe39FQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 22:50:22.1511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f59e235-290b-4fe4-cf1a-08dce3fdc351
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786

On Thu, Oct 03, 2024 at 09:26:36PM +0000, Pranjal Shrivastava wrote:
> On Wed, Oct 02, 2024 at 10:22:13AM -0700, Nicolin Chen wrote:
> > On Wed, Oct 02, 2024 at 02:10:52PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Oct 02, 2024 at 09:55:14AM -0700, Nicolin Chen wrote:
> > > > > dev_name()'s result can't leave the lock either, at least not with out
> > > > > some refcounting on the struct device.
> 
> Agreed, I missed that! Maybe we can avoid reading the master name in the
> `arm_smmu_get_evt_info` and move it within the `arm_smmu_handle_evt`
> under proper locking? Since the event won't be dumped before it's
> handled, we can avoid locking at two places for doing the same thing?

Yea, just move the master_name closer to the locker, and put the
dump() inside the locker too, either of which happens in handle().

Thanks
Nicolin
