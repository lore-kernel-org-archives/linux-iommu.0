Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182CB2DC34B
	for <iommu@lists.linux.dev>; Fri, 18 Jul 2025 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752845359; cv=fail; b=LxXcpW/Ra3Rhl0pmoMamdatZcL9aO7a2Nf4zQSFOfiBwY7t/UxGwqcVt2BeMH3VFo+4WOZazKFxvXEy/nMd6ozkyo/EjyDpxN16LQofvkmxmd5e/aT9B+5aPoChLBbWIHCeMLwVIAMmkW/HPmy7aU2NxMlHQdj5YesZSWIS0IMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752845359; c=relaxed/simple;
	bh=OSHKditElNuTbWAo1zifinLH7O79cTx22xES/elAOlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YdqWxAstTV4btCgwJ3pWhyommXW+GkT8bhNK6aJKIe0q8Z0LaxmFNDepupRKXVxHIw64vPozOll/SjFDbVYehG69PFhNctBr3iR86bU3lQOiOLDlUNb8SVp+ixPhg4PbE+XMMpXfFM5pBB/u4l3533kHXCGtvIKfH9BkfanVTzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CAV+8Nmn; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CAV+8Nmn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFFVXjtxRUF+HckjhIcs+eDV1ChMPEw8EvYAIzGKOL9jIlyDEHyZov9Pwg+jcVKFhrdFoTIeoPAEseMBSIq1jFmVgno8i+H1iBbWjgfb02+tK85lLNW1eEeF+BVaCmZ/qNYllyOQzVOY7mXwUMcMvsRFhJvWx1Eu874fjgaaaDEFcSocruK4H3gJFAAnzgYvZG39/wEqdD6wnCgOh8pt5WZz/kk9NhzpDQS7FQ1jWpN4WVMz60hVMYD+Cdz8d4e8Is7kP6xFBfijkYBKzi+buVhy+6eTHr/wbNBoXtntOoj4epzn+EYiCgWwNNV7+KfvKyOGj2fX4zpCptMn7N34MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSHKditElNuTbWAo1zifinLH7O79cTx22xES/elAOlc=;
 b=VgZX8Ed3SYI1K6U9Swk72hmtyQAKylCRDuGXySn8v9pBseVxQAIEI52FGA4mtiAShNxxtC332pFKDlqFOux+qks4220sP2Q5n4f8oY2+CuTlhnCvXGDVjeujPWhYO4XCYMKL19zbAU3J8Z32YGE9GAF9E/Fu7U93ZtQV7rye/VHNZriTPpk8EiFCiaCsINZcQvaymLivKMYSPHnZC2G+CnUnbAMLyz1vAgrgTyY+VLzLILVqULMVQjHhohDfPiv7q8gY4/focPeyn5SjNlRZb5SXARIIaBnoee7D7GK9i8X9nFZLZXaTINXGQm2bXfQMMEdg7tXvLgu0gOZWlLVdzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSHKditElNuTbWAo1zifinLH7O79cTx22xES/elAOlc=;
 b=CAV+8Nmn2/SKGoh0czO/UdvwT3xV8sGdvroYDe09xMoIOHe0JbzTxWNEuXGFc1bk4w/ls8OpYm+dqxWOSloNP9kikLSLxi2078mm10mQ109A/U1u8ZWVKDkrrWiHb4isJyBBFvntPDj34c8GldB/AO3n2voFd/miEmWR738kJO6zBDEDhGGJMU4MTZYSQgIMjByiwNyqu4pBMmpmJkHTp5hGgM/8tj0UAGZza411KzC8TUy83jnU2Qs/Rk9iizDaS3jz5Drk6RJLVuQ8+N7bf3errbA37QPwZW0nAMD6CdIGjXdNnQckzU8+Kzt7jvkSHJ5+cXtychnIvSx9K4FFZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 13:29:13 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Fri, 18 Jul 2025
 13:29:13 +0000
Date: Fri, 18 Jul 2025 10:29:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] iommu/vt-d: Optimize iotlb_sync_map for
 non-caching/non-RWBF modes
Message-ID: <20250718132912.GC2250220@nvidia.com>
References: <20250714045028.958850-1-baolu.lu@linux.intel.com>
 <20250714045028.958850-3-baolu.lu@linux.intel.com>
 <20250716141218.GA2166806@nvidia.com>
 <8aedbbcc-9f4c-4700-acb7-43ec4f540135@linux.intel.com>
 <20250717115559.GD2177622@nvidia.com>
 <3ea54d65-7ccc-479a-8912-bccd79d678d4@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ea54d65-7ccc-479a-8912-bccd79d678d4@linux.intel.com>
X-ClientProxiedBy: MN0PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:208:530::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: c047b618-6600-4512-d10d-08ddc5ff15fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5CvQI20cNgKm/EguDG1e7HuRIUrNidEjQuHaNDtYTTbWJfxU03NGXUF+Zt03?=
 =?us-ascii?Q?pVfekpgsdncEDAewFB73GGrX/tvod/XuFSvuNDOO0HPY3tqzfa+WlE5OBBhc?=
 =?us-ascii?Q?8v4g4RQQHDfewVbZkVA1S5SW1fADsvJCnODZmOID0RygDYjitSz8/HffkSfQ?=
 =?us-ascii?Q?QTVarb4gdP3VZ7bYgPrjIu6cY4m8LlGf2Hq2NUZVsQVS3OuO/iT6jUOlE6pq?=
 =?us-ascii?Q?8bDhNGHvl45VjpGWkhWuCLAijfCjflUYIz+7bkpMrpvHuxiHmPfVKsqzf2qP?=
 =?us-ascii?Q?jMdyPEp6ljtIPzVZxgEu+xkd2NzzoPKrkfaeckuASzmzJRoNGG3GRXKQv/Jq?=
 =?us-ascii?Q?KVPfOKKvR/LdXD7PfU7dqdeVt3SV1j9r9kZhVP0kVkEzjn/QUguHFOjHYWt7?=
 =?us-ascii?Q?CMk8iZlswH68Qh5/HyNd/H1HAUqrPoWb7JJp6A82auezKhfz+IWhM9Ur8g7r?=
 =?us-ascii?Q?OJluzBKDQ881nj15SAfedJJGzsa6oGBKkSQt5QCgEU/IpweGbWpWjHVCG6xu?=
 =?us-ascii?Q?jv1nJUaRylBpoF4xk9ai0HgMk0u5q19dLNoB8meKJ58611NzCoMndp6USsTj?=
 =?us-ascii?Q?k5ZN6gX5z+UQRtAhGMQw3VcNspoAkNO3xyvpNzPjG0KFjm+PXUVsd8tr+awp?=
 =?us-ascii?Q?t6BteSrol2oYH9GC7rgYHNIlQnbh6CoVhtTZBe7KHDywkLdFmQbGZ62z7XiZ?=
 =?us-ascii?Q?rR7ur7UHaFKSk89Q47KA+pIeqJrQ9OOAbf6JNJTPFEWr5rfuwXHFr8wGL8nO?=
 =?us-ascii?Q?mxtQHiR8fH7Rt+4jjmqHJjdiz1bR6ftztXjF3GOvindrUV1ZTw8Rf86nBvCm?=
 =?us-ascii?Q?bTQ+B7XUmYmdVy4z2QXeLQ7I6xCpupJHhie80/ic5l5HGTBwhLlt14dwKvlk?=
 =?us-ascii?Q?Um4TtwCxPiW+YnkorpMNhHQ9Dxe4C0cvzF88KOELGPIXqkYKK+Tk/NTKyVVp?=
 =?us-ascii?Q?tuHWgE2lJ/Jt7x+zFSa9u5OO5rqLVp1cKSyDnbAiWNfVf5bPKLwV6JMvFhlB?=
 =?us-ascii?Q?wwGvtHBdfNp2Nz/D9NInJs/aZeXXhW4WN861JLMW3mzWIDU8CVgD43TVcDfp?=
 =?us-ascii?Q?FVHCGKhrQK8wOuoLZ3a3gF3naUyqly4QSnVwa92ZivSLAahlaBm6p6RAMyxY?=
 =?us-ascii?Q?ID0fK1sHtOyfVmEJdP6a8L2Cvt10XRcbZhFHFlqm2XTYIV8B98CZCkLWvXCe?=
 =?us-ascii?Q?dOCT3K3JWZ4FbIkA6EXHJAGf9BFM2RGUY1ikT9pZ1TmkmB7WHizunUS3RP/U?=
 =?us-ascii?Q?KzOQSGcbdXPl/AojRhLYDbt1YGtX8oyTYpUCiuBkb0Pn0hmNoBA+8xuHhn5k?=
 =?us-ascii?Q?Wtmuy4KVtif6wU7TLgpMwyynczNtoKo8Aw8Pafl1tE2WxDM29L8S413aFmO1?=
 =?us-ascii?Q?UIZxAIyp5ywGK8saGVvpRw2YQkTQxZoV3FhH9bYtL8nvdBg3yzS3Cfq7CLn0?=
 =?us-ascii?Q?TOtC32Y68Ds=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MF/VA/vNKCzrGUbHRHcn2ZLmwsO29D56ifmLiqYdSA2e0E7giYTR/ZGEXpjy?=
 =?us-ascii?Q?+y8YAqa/5/huvtqceMCzC75rrL6l7qyb1LcDcAsh85wfBvfmGuJgY620WOf5?=
 =?us-ascii?Q?/6xM+Fdy51K00MoEk9SIR03plmgH1w0qF66b8pNrXp8qc08GJaiJaVsPXojL?=
 =?us-ascii?Q?UK1/6Q82eT4QnfUqhTnM3+vWjys03sLVnrY5YqJPHV2/5oB2eSySAYQbaDpc?=
 =?us-ascii?Q?BcZmBQOfluRifIgKGPI5U20qz8gLjA43KBdH7Gs4UUawwmqd3bYVCtGxjUjz?=
 =?us-ascii?Q?ER06TJk86CRv84LqWtUTImJxjCqO6DbFAMxjCex8Sa8sCxvRyqf7aQTcL3Tb?=
 =?us-ascii?Q?L7ffmSeySg/c773SRqdCBw2IxJDVKiBvIw5V9UNTaUZtguAPKe2Q63EW9Lur?=
 =?us-ascii?Q?EtozEntyTlbBRUMjz7Qpk70QIGCQdGrLAo7iYsThZdveQZ6T5nznB8F9Zezj?=
 =?us-ascii?Q?Og7hjIRlSYNy1ZBvGD9RxlgJo/2rs5YO6fFaVXZO9SOlhBVLLQdqKRxYB4ZJ?=
 =?us-ascii?Q?/QEXIDKa5HzdOgk3zDDmb6nmsDgoHJlyJMmkY00DX2lwXhBIiGqL1R2uPXrC?=
 =?us-ascii?Q?eYa/FLIGCT13ZSDNaIm5OydjJN91kjiwUBgIOAdr0cS/oKeKz7LrLgZv4GGA?=
 =?us-ascii?Q?UTbjQfOblaXNq1qpcCJuk6OsA1JWBu6M96yEayTJqPxNFCtkAeS58TOTtq0A?=
 =?us-ascii?Q?0qJkFDugio27TWVS+B/ptzs6mhjUn5BKklfuxxx2mhRb9brPdGN9XAp2wrB+?=
 =?us-ascii?Q?xQJ/uF9qpKaQ4Q8CMwNDwPmvhOlFeq44Gmxq84AUACCQL7yjdDMs7wypEuMY?=
 =?us-ascii?Q?9uO0xIvYXyJtO92N1RgX3Cg9VQlh42nKApFxp4EXin20934qjy92fshjrjrt?=
 =?us-ascii?Q?EZP5Z+F92Is7OsiL2hePxGJKmo0ga0cx26lqA1CYoFCo6lgeLtJ/rWyk5PH9?=
 =?us-ascii?Q?OMm3rpL9yVP173XJlFMaUtRRZFkmXB4zyyBhRkysTKWyDnF1cGqjWuMkbORy?=
 =?us-ascii?Q?FzYuh2OwmMNS3Mkm6CKcALUYdI5Jq0H6TcGX/prLr8ocEevK/oKb9M3XCTQQ?=
 =?us-ascii?Q?Kf/ZNHjvpu7SxRGgt1oAvN2eWbASzqAqQGoDtYc+e6lwjh9c9A3FkwpwmVye?=
 =?us-ascii?Q?QRhOOLzkmwp6pJ5Y8auzFE7l2Nuamk6kYPbAZisn4APpmr/nRbDf5oDZ23ie?=
 =?us-ascii?Q?TSWzqngSSyKyE9OQQt6HmXcACvFnboMnqNZh9nJ5WAN16EH1M2xJDsygVR9p?=
 =?us-ascii?Q?UK4BkqLvgQWRNLF+Tl3GkKazJgaWKFJRya5WEmeJub/hxuTR26q0Z8mvUVSd?=
 =?us-ascii?Q?t/sE1C5cgYdQldd2L5VJR3uoXb4k8wU+nar9+2qAKPkjUNPfc0UhkK3d9mSx?=
 =?us-ascii?Q?2KB+C4I5qxp9fHKiFUCYHEMt/QjyHT9RZr0zVF5tDHCNZ/56pXMyo/VahfaU?=
 =?us-ascii?Q?/lymVI8NC2/FQRhli/yuGEpARwbk7a0DPTKi4SNE1aZP4umRLh0a9Q2hPNKr?=
 =?us-ascii?Q?tFv8gPWyCCU2nPzbpM/SAKIk0a7faCbQ14q7IQuAc5aotrcr4+92zkjWTFSM?=
 =?us-ascii?Q?kPJnn5iMs1cTJfkyjzQN7oSLSguNuJi4mfAIGtgo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c047b618-6600-4512-d10d-08ddc5ff15fc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 13:29:13.4748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olH065y7KGPlqN6dY0pqlmewgJXLxhSM0fOTkM0VwOCBFSxHnpLhco8ecJ8XuFuF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751

On Fri, Jul 18, 2025 at 10:56:24AM +0800, Baolu Lu wrote:

> How about the following changes (compiled but not tested)?

Yes, exactly what I was thinking!

That leaves the cache tag linked list race..

Nicolin is working on a neat solution for SMMU I wonder if we can
reuse it here too..

Jason
