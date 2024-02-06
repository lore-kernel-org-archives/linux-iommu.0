Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C501134A5
	for <iommu@lists.linux.dev>; Tue,  6 Feb 2024 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707243222; cv=fail; b=BhsZaP7egYj1ZlDbHvG0GFFnYy/7h11HRWkn6QcO361T5tJ0h77C8RtHD9J6qUUSOd8BH9LoV7vkGFjdkoQiAVseYJmW2Obt9Il9BKn9dHibg+9WmIMgx17YSRMZd4e9ipkZb5bSHzy1cUrH+g7qdzQHtYtokbEkpeLik/HNZlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707243222; c=relaxed/simple;
	bh=woIb6OBYwcGlovru9RlXeGC1E9q8BkNV7asZfjSRr70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V83rdrLKov51qQFXx2X1HQA67AEwjqOmgbhLUnu0EnWfsuMXL8wKRJ/Pv+UjT6gLJjQdpxmdsITVzFSX1qk0yfl/cc2k0LHE7j/+OaJdUYeGHB3I1v0eXaVuj9P1Ij2iL7N+Yq0X5k84TeSJKNlKBvZ1/m0xC5aEtMlel/lXHto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QMXpWaKv; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QMXpWaKv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zb6rjrlPRZuIol3U9P4AJ0/sLxgtP6FoMQhkAJfpr+LMaoDYIDbI+DgvwFNslbcXPQLvcvDTD3FJ5YQsuwzIGLXwcQiUOFdWRote8+Ze5TcmNFmGPBWgeJdYXsyq1tUn6nAKZDdaCqQ7UV0wZ6f55Nflgsxap1ZB0qq41Acb4SispY4Y4AsBdYIQ1E0lpU3KU/BzrgA+xapcJj8W1UqRbx0noVWE/8iWXeT4/LVvk2ejZSTKI+9DxLZZm7tyKc+f0LGjFBuJjJKCizlCR3PVvC7Xw5LD9LOJrMVtY6ET0NawRm6Pp6aWKc5f9MvXxWhiLm6pOR1/w8c3HDtNg4me2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+N2Vu270WiRczgSdWgpg5aDRuw1AbovRZJMDyOC2no=;
 b=N0TUv3TgUO5ImnLIGmnNvobF1Ej9j5SHra/L53bYH6+vrOVAZLHRMVW3+FqOcpGFbuO7rU4T9GX8WGqZ3IVTqi7U1XQ/qm8AiycSkoRQl2rMUvi1UqeBU2uIqZEMYsP7GS9NQeb7wcGlJuoFrv0LqcG1oMNHOdFUmUGM7mGZaERehzxqSgJYhOI4E6pJwLZ7o3rbMSS+nuUaP9sdcYEC6G/kpuEII+qyuXB3xwrKYqVPDkgCSxm2h5QeKGpEnZ2N+nntWvqZ+IK0GR8vCj4ral5m2eMVcBAoBh50Y+jIy1GMErifUQtP91mwKR3adc4phB//7lSVGtkxEWw/mCVxRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+N2Vu270WiRczgSdWgpg5aDRuw1AbovRZJMDyOC2no=;
 b=QMXpWaKvfvJ/ganNbqqka6Hc+3YbRXYOW53vOzTjKqMMGJrQLrIQ+XqTV7O3GwywRvjWVUCrYSdan/TQpjfodDVpvxzNaE3kBGvVmJa4lc7q6K2uF4GHzmslP/xWRjxPgzeEU51OaPQyWdoLo3cww/AJoHcOPPwA+Q/ZT/x9Ftr+/z2mJnC8LHyHf9DX/8UTITSEwF4FLCFQ8ddiFXlXHxg+cPNGHb1nt5OvJ8a8ZEGmls6mi48zu53xS5PUr8ZI6FkO63VESNwxkpW+3CJuhM1+pS3FyVo/4j8TC7UJUs8MvxFGGCkHwbBmXzrI9VnKMCCL5u7RxLPq17cnRvcb2w==
Received: from PH7PR12MB6979.namprd12.prod.outlook.com (2603:10b6:510:1b9::20)
 by SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11; Tue, 6 Feb
 2024 18:13:37 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6979.namprd12.prod.outlook.com (2603:10b6:510:1b9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 18:13:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 18:13:35 +0000
Date: Tue, 6 Feb 2024 14:13:33 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Avihai Horon <avihaih@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v1 0/9] iommufd/iova_bitmap: Bug fixes for IOMMU dirty
 tracking
Message-ID: <20240206181333.GE10476@nvidia.com>
References: <20240202133415.23819-1-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202133415.23819-1-joao.m.martins@oracle.com>
X-ClientProxiedBy: SN7PR04CA0096.namprd04.prod.outlook.com
 (2603:10b6:806:122::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	LV2PR12MB5869:EE_|PH7PR12MB6979:EE_|SJ2PR12MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa51479-929d-4b79-8dda-08dc273f5585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+dpBdTw7N6sjDrLstIuEEZyECPT/klsDlPftGc6giOWcihBlPCoRJui96R+oStu8TxR4khQ2JVchu1E95DivXV9epFGptn8VsUIiuw+rxSM+V6CsHAUuGGb4cxnm9C6fTCx6XKj9zNw6TMzyov31lWxtVp19qAdG+B0BH0pcpqZEtC9zKTk89LqskLprohwxsPMoiJhbEkeKNvjEXb5NpPoRB38kWzG5fskC9xUkRLoClqtorohW/QRvtRIWbu+BrsaPxJgLPliniJDEP4pOsFV0MMnJk7kNjOJCBoV203GEGl4vYs9LQRKXzNpfIqdWXp8jaEwSIOKhfLuvahjSzjtXpjuR44Vbs2MOPyFjCCH2J6hR6vykK4VdnGGl17SGqUbdwDnQMa+XUVf9Oo+9B5npKBGe/4hRXfhuHEuLJnuZBTUeWg1g8Dai1JJBkJXlKT0uemsXDlPtvvPrueREK9nisN4fGWd1oBDgTUtKC59IcAVSXnzT0Ifx1bVu7/TvqTmDT0rBfUzYaj8wQIneYgq9PfF03mV+sm0INQylQ6n7SICt4UdE1KzykCW2mPBG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(478600001)(83380400001)(1076003)(26005)(8936002)(41300700001)(2616005)(316002)(66946007)(38100700002)(5660300002)(6506007)(4326008)(6916009)(66476007)(66556008)(54906003)(8676002)(2906002)(6486002)(6512007)(86362001)(33656002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GbkH5XA3VpqJaaQKa34oolpTbayJCm2nLWrpF7y/7JgL12YHQpkcEOuqzCMD?=
 =?us-ascii?Q?Vnl2VKhK3PT8bM7LnxfPg23Pnyv7NsXFPMiROykDNKp7ceA5c/aren8MoHqi?=
 =?us-ascii?Q?507L92afy8uc6NPTnFRN7+A5h43DoXk4/pLzHq6I1lMWPf/+amlYjnZepAZf?=
 =?us-ascii?Q?CD186t0WVtClIsRU+JDFTL21tPPnpIUkkxtlWVXoiIvEfgKu5r5eTxTD2+s0?=
 =?us-ascii?Q?JGB1V0dXnuOE5yj/Y11fHCWnfFkw2dIhTpN6uXAaXraWPLw17+L9buPugJ5u?=
 =?us-ascii?Q?+IUriKefKsP77UOUFYTnsV68TZl3uvhWfDgpihQjq6EbyOriT84TD3F9kqJQ?=
 =?us-ascii?Q?3dTdz281eJ8oiiFfs40hj7415vZn0Y0iIhJwxsVoTfG4Bf4tYLkFyZy7oZwN?=
 =?us-ascii?Q?mGcovbb6BvUU9ROCSlIk5xIedRRVC6XNlfR16rSdOnoixLYBanjAAlWlrzUX?=
 =?us-ascii?Q?Mw08w0KSy58A0aNA9vhHCiuseNqDPPy1XAVYkQ25CN/1Uz0iOImFaanexsSr?=
 =?us-ascii?Q?2/D0qY2uDZF1Dge3if0qitORlxCeIBqIj3NWI2e1jCieW8cLWlcTB89Pl/Xr?=
 =?us-ascii?Q?+Tm95GTX/OhFo0lkwi81oaUUBC0vSUHMS2zqvQweHJ8CtclrMvmfXqCKXoi5?=
 =?us-ascii?Q?GFHIgOgxGT6KL1o6/p8tJ7J4fqwjncNnFH6GE3BV41ZbuyneOOcSZ+gsH2eQ?=
 =?us-ascii?Q?Cjz2JpEJt/jYrMV2VOiU6/vlBoVXrhpByFhGk+tkREC2kSj7zZ53EAWJ+6FX?=
 =?us-ascii?Q?X9QYhVytAhOPCUuC2rdX4fM7oD+0P+vyq6MgjP8Y4TEm+NP1X0erssya3LtC?=
 =?us-ascii?Q?8x+X7e+167FDgyVNIlas9wSDzt2dQiVbOJ3TjVPqBdiQCwIK+AY5cAZYC/cX?=
 =?us-ascii?Q?2yhLIZui5S6MVv/P/fpVdVupNW4MDntiKVr4hJ+P2jBeZEdC2LgIzAspPWw2?=
 =?us-ascii?Q?SAVd8uriyy3chrEV+rzWQMfvEyHkDZY8XhGxjvRvMUapMnDW6gul6kEW8J7c?=
 =?us-ascii?Q?aTxhdjsXJ593bYjpqM5T+H95NMdFa6bzxlKWE8G/6OdMpzNkdcdEzGdTMXg1?=
 =?us-ascii?Q?RqECET+WePme1luoynVy6I/e3Iy5jftvNYNZMg4iMlNWXNRzlpG+um0ZbiEF?=
 =?us-ascii?Q?7exW3oe8devAHzFeMY1VLvftzH3JaY4eLdB9Eqokg3BrzRTru2OoKCLSEt4H?=
 =?us-ascii?Q?AqTxfOfnc/vkDXdNmjzo4fSJdFLR1Xs40L9Z7wCHvXyuW04pRADRdxO9ck2M?=
 =?us-ascii?Q?QbjFrL0uO1TeCsk3+AOsKgCl7FZSxhvuHOZcq78AuYJRdG6aCzzcvXuuSkXs?=
 =?us-ascii?Q?nWQd8FfqRtNeWShTswqwgKk6DZzTHIAx4mACatGMeYOokM6RFH7byFmRME1x?=
 =?us-ascii?Q?/6BVwuwkYjhkeqs3Xpog9wzPVd7dqPgAcU2WJJE7sSX+6pjRLOWcjCBDysV4?=
 =?us-ascii?Q?3aEPTfsdqwvHEzS9BYDWpFpJRnuPMS5w0ibWi/vIerY9QV7F7mGwxRd/wqnW?=
 =?us-ascii?Q?3t5YeBnHrJ1qZBwdvOWkskuo8oZHvyjJrJkc4xqxrwdPqp26SyT2EfOndlav?=
 =?us-ascii?Q?p29BWNPlNnduEQj7/ZvhUoQe3jH8WX4kPIgZI+5q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa51479-929d-4b79-8dda-08dc273f5585
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 18:13:35.2495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3cbIwwc1rp4ksMk1ugQVthDpqZaaxyiiJ9Ox9YjaiS//Fj5/6ECkuZqpolhb0mg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9212

On Fri, Feb 02, 2024 at 01:34:06PM +0000, Joao Martins wrote:

> I have a separate set of changes, that proved also instrumental in
> reproducing some of these corner cases in a more predictable manner but
> with IOMMU drivers instead, rather than IOMMUFD mock IOMMU driver...
> without relying on VF specific behaviour. Though, it relies on being
> able to map IOVAs as dirty. This is not included in this series, as I
> am not sure yet if such direction would make sense (outside of testing).
> Comments, appreciated.

I would love to have a test suite that could drive real HW. I think
that would make a big improvement to iommu driver quality.
 
> The selftests in this series (a large majority of the series changes)
> are meant to be kept in this order to be more clear in history that the
> selftests exercise a given fix added earlier in the series.
> The last patch is an efficiency improvement, but can act as workaround if
> the IOVA ranges are smaller than 64G, which is why it is placed last.
> 
> [I think this should be targetted for -rc rather than -next]

OK, I took it for -rc

It is bit unfortunate that the number of huge pages needed to run the
test has increased but it seems necessary to reach all of those
corners...

Jason
