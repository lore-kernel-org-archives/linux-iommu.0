Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD9E25D55A
	for <iommu@lists.linux.dev>; Mon, 24 Mar 2025 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825133; cv=fail; b=J3RPSwmo3+FDy2C4TIHXveLZLkt57WwX71YBMzgW277JvaMnjYuiOMuGhqCz313VQC3LS/UcvjG2iQt2C6Ang9CGxWzC1SGGDk2Lqe4P4HrouBUh9AeLEQJae70EczSKOGN71dTUBfBkMKZklq4s4Qx+sR72u3wpFN+BrnWzOQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825133; c=relaxed/simple;
	bh=g6Pxtjcb9y+McLL/iZ/qDFWMx1RjhTkYPdojMxuGCWw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdnh/dXVqwnbYX7OHjum98oheKmqvdKT864thxEQYYTmzAyKz+wMHyJGZ4u1OpLwvwvcxSCWh+4k1Qat06gZXAmbHTPUnHdG3qGfm6jfnfVUBI0Ka6NUcaJFfKcgwSdXi41fW8LBFuOHQ/OJJFrYy1rH2osOQWPZPjRbkBBVjlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FjWtlc/q; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FjWtlc/q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhdV9H3N99hXE53mSYC5AqTi4kpMQWxGPbnoQjZX4WQfj9XZtwEg6SvoDqFFaP72M2le8Rva6PWxBbJsRGyQlsCyC2gE7oSMOzV+uuui3kzS8y7KvZ3rrWSvy3mRPLqbvUkeO7SdllVG+Jvworuy0Aq4PRCU9RXVeCmxulHEPOPRzpPHnIPtnQrEIEO2F6qk/5nmo5VZAZM9Qrf1daFjTC4MQf6QOqC7zWNKr52STbrt/F09GzPkFDgiebGy7IKSlY23bUzsFJJ1QnlYef6a3VqPQwHO1xoQUjEJGSxl+6HrM9cwS4UzAxob52MlU784wP/FiPCx43tTiXpY9jBHlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQozY6N6pymrZFiccFJEEf7M5+rL3sj1NCFXpgppoTw=;
 b=oWv+flaEd3AwjVRF82b4WQ/bcGSYmPq9DiW3zMSFcgd2jXRrA9qccy6VqZAgMIu1uZBKUKFYTZeAijMTFDxOmKfVNO1lUfRofHbh0b1lyHo2ToUL4YWKmrxxWBKkrEs6YZda6Bj9Ho58wNckNsQgFIrFSj5oc4Q+cDdaGKmQ2GpWOYCBDpqzMLWSNWt0KE387ZZILuXzoods8o4VSXxrQ0sMpfrlCWJ9TlVVp3jQV1qdSlw6LwDSsVv8tYEmvH0gt0DcNu9haSDyYg2RnSRZxACDTOlZYQaVAX9Yi4LKwRT6Ao3d1TRLgsjqPstI3c5gT+QD1n6TUZ7rA/VNO1zCPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQozY6N6pymrZFiccFJEEf7M5+rL3sj1NCFXpgppoTw=;
 b=FjWtlc/qSJokUDGuiYXcHbHM2/3nSSbiQJ8PCDgt/FeWiWYfrjN9oGCFpkui2A7ttkRvW9AntriAFP2SG/tw6LzFgi2aQBC8FL81ECql9yuNhxEaSy+1gLbehLh4Yob8DTTvCM5GedCk7jtLM9LYlEvfxicYmCWW9ifRFj9lpNwjNQBbBeTDx3WMMa8Z8v5dxZjEBErvRpujFwJ0wNNDzSVQDup/nip4794NhIYJClsrtUzFICwK1hzQ+pOyns2YB5K+FsaCRXuO8BrSux6uCXwvYLmoAKLQR3se1KXY/FWHkYusTJgXvm/YR6MA7+PJXE8516CLk5aC8PsVzoKhLQ==
Received: from MW4PR03CA0041.namprd03.prod.outlook.com (2603:10b6:303:8e::16)
 by DS0PR12MB7745.namprd12.prod.outlook.com (2603:10b6:8:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 14:05:26 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::fe) by MW4PR03CA0041.outlook.office365.com
 (2603:10b6:303:8e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 14:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 14:05:26 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Mar
 2025 07:05:10 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Mar
 2025 07:05:10 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Mar 2025 07:05:05 -0700
Date: Mon, 24 Mar 2025 07:04:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>
Subject: Re: [PATCH 1/2] iommufd: Initialize the flags of vevent in
 iommufd_viommu_report_event()
Message-ID: <Z+FmiNT9Y6STqdQp@nvidia.com>
References: <20250324120034.5940-1-yi.l.liu@intel.com>
 <20250324120034.5940-2-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250324120034.5940-2-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|DS0PR12MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d4918d-4c59-4739-bd9f-08dd6adced41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QiSpuOB+msHKAI8RZ7H+xqyIBo4Wc00IcWy7Ep6zbsM+H//pOE52RqbiFSPY?=
 =?us-ascii?Q?gejCnGRXc/lEKqEWUVU/CEn3feN1iILNrvTtMSD+iEvSgaMr5IUQr2oeh3jn?=
 =?us-ascii?Q?olEgfmuyCAP0P9XjiJAtLMjkDgbuQ/uMq/2TNNChfExKRzC6Hrdn1+0iOKsq?=
 =?us-ascii?Q?EBb+HS+JoFZGw0sWI/8nlLmgKsWBYLmzLDgTyFwvhZL/eY6c0TAGxPpyQ6Vp?=
 =?us-ascii?Q?Po6KOGy7wfEDeZ+j1L/iXww57J1PoZj3Avk6hOEIpIIv67fv5n42BLDG+s0T?=
 =?us-ascii?Q?iLKLi1HeZSUJJnheItHKiH1SOhBREen86fHStsu875bQshxMx4oerJb+sAg6?=
 =?us-ascii?Q?mZPNTQ1Uds6bKhzAXJjqWIN5/3n5LHPIp8lZt8IDAVQgzJE9bRl4N8I6mWiH?=
 =?us-ascii?Q?gZrYee+Rmrre9b8mm5rwSP76z8tHka8TtvlpVhppumU8EwQV3UBn9SjQparo?=
 =?us-ascii?Q?G/lBVu8Y3ELYjay+4pVFa8D3yDMOYw4adPxfyH1Nqn+JRG8jmIQSkdq+UCCh?=
 =?us-ascii?Q?W8RcuL0jBTZMkvrnhpKEpxGa4t6qI5+E55+e0vbXJEosHD7njtwIbEKmt8qb?=
 =?us-ascii?Q?Xu8MVNUpoewLcorkM8QH6GJ5FIzgH6JfxNv3ApiNA7PsLYNpLpgPEz3FrTAD?=
 =?us-ascii?Q?IOyUZ6eT6wAGZ89tn4i9YmKxH8Fiox2OK1NiwT2zp85WJvWvmolAvesaZ+y9?=
 =?us-ascii?Q?W6o1z6TMR2k1JP10ao3XshoGVjwAH9yqaR6S1evoENFIj7Eg409n0Wsad3Ya?=
 =?us-ascii?Q?SIga1+sU+hNiH08I3uzenryg9gVY0ZnWrnAedxRppTQDrFihWsobTES6SKo9?=
 =?us-ascii?Q?uj7D5rberEOgKAnVeiPJQuvChI5R+5asLipvqsbvcIjXHiBRyLkdrE72ibzG?=
 =?us-ascii?Q?QGSLtYR88WWyIdtskp6y3mje3/I7GGsMr2TlUu1iwNrSuIZKhZ6LaHNiTbzw?=
 =?us-ascii?Q?YHC/RESo9YY+xybntADPFfmV4qjciQnCX3sEpyv6CA9FmBQi9/yJrb7aNlYL?=
 =?us-ascii?Q?U8rtP4cIt953v9KWq0YtEsKsVk4kSY5e37zODkYEJZGT55AhnNdhF1o21Vu+?=
 =?us-ascii?Q?dzcITidQiaUAJiRj3WrcGDJcHW8g1sSSXa/jSawPNrjkie+3qUYov9dpiZpF?=
 =?us-ascii?Q?W6fgDzreL+walDKBlDhE9qsT7zdou+RweByp/gI8kDtEmKj5Bq1ynE2ljDfO?=
 =?us-ascii?Q?z7OiynrntDHOkkRTbnloZwj1OXkNuFim6AUcxm8lfXuQg1pOi8bx0+9CYnIb?=
 =?us-ascii?Q?6gL9TSU229KL4jBFgYqYFgYS1ILTbqIfUH7MUKXOe/CkT34HgCpryXiKC+pb?=
 =?us-ascii?Q?H4vhcai7FqD/qUJLQ+uOk/z+E7Yr3XchUZybQRh0PHF0PivJwsRjeHHQc4Mt?=
 =?us-ascii?Q?duwITpjIV7LRhDBbQC58JtJIsWmKE03o8qphvWh2niANeNQcd4ilTWdNhLSM?=
 =?us-ascii?Q?lRR/5vetLxWs2j4lbDG70IuWap4JBbIaFKDKAIm/xI+gui0Ybjs0nAHTo2yl?=
 =?us-ascii?Q?TGKYvc+jdiXbsTQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 14:05:26.1398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d4918d-4c59-4739-bd9f-08dd6adced41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745

On Mon, Mar 24, 2025 at 05:00:33AM -0700, Yi Liu wrote:
> The vevent->header.flags is not initialized per allocation, hence the
> vevent read path may treat the vevent as lost_events_header wrongly.
> Use kzalloc() to alloc memory for new vevent.
> 
> Fixes: e8e1ef9b77a7 ("iommufd/viommu: Add iommufd_viommu_report_event helper")
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks!
