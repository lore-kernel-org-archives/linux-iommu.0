Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042CF8839
	for <iommu@lists.linux.dev>; Tue, 24 Jan 2023 15:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbwIZSKTeCVUxZPJeLKuxIaEYOZGCgDopNfiu84YrMyJLWiqkdoFkzEwYtpFWjLamzNGjKTDIf4JqHlLgPQdgeUA40FZKiE4Rh4t2kSvcXEOpJdTUA7mPzMjjkVI0qv9gc1yRhDbZGxYzhD7q9jVYF+9u57Dh9hIEsbqrFa6kvYPbY34uHq9XvEIyCM7lXsgDFEHFuZNzTPCNREHuH6svrU8OjKoY6kPq7oJjIeiZf52fR+uxTUl60RcLgGiubYEgCL7XLvDCdQwPAUzf1oWcERyPwI408nqTSK//dzk7YfyzQOgHvIpV6ifedhWaqoqCyPpQdOMhyswpJqU/LTlyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbPZLr86qmvgwBoKVL9JWAhAZEZusleEaVynSi0/9SM=;
 b=MWaa4SW+kiqf14BwJJ0P9srTT0qSOZRuydEP/69ea7F1aufGfagztXNKIeO2LWX001xDG+YHg7a53kqLcCfowtLwlrXlQu0x+0yngmaol+be0JJxfGp9oQvC8g5jhYcCefqxm5O2t6+URK5fGHoxt3bwRHJ1fw4fKOkzy6ENMxVKSbANlrmVx0InLfziP7eScQX+FWGUSnK4pPr5+Oehrt2WeEczvnsYi2w64yZUNJI7wX5jjpFrjyW3kZulPq8LaEIBzLsKg3CULctJmsKQfilW5xKWPAWYbEFv0RT9Da3mwQsxTENMIqt0DNMPzwLlMyRejsCtcPB8RfrprdDulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbPZLr86qmvgwBoKVL9JWAhAZEZusleEaVynSi0/9SM=;
 b=mKMY1Y1h7iA3816w4ORl6z4qGq0pOg1pSAFx3P3ANF0sp1CSZCOuUgPbWaftRuoH/6/0Q3lTUNx/9fOF8gcnH0H46g+y7CVRBE3mwb91A34yJly73KHZ9XE79KJ4BCpiQ4/wpW8suYc2lbxy/DoaLolPdPL2PQjoYKEKleQjJp3WVrXSPYhvevgJVQ6zZ+iV4ktzrXfe5ZNa6W3G/s8mDRA9fTdjf0CMtjhjoied5fkrHgGsl3nfXFF/0WKrU+hEO6M2AqfetIYwPxz2CKVDwDY6/vsWr3Tyoa2TiqRIO4Ay5058aLwnn3pEd++c6ytEg0pSRqxeEBJmKYtrxa4bxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5980.namprd12.prod.outlook.com (2603:10b6:208:37f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 15:33:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 15:33:22 +0000
Date: Tue, 24 Jan 2023 11:33:20 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	Daniel Marcovitch <dmarcovitch@nvidia.com>
Subject: Re: [PATCH 3/3] iommu/amd/iommu_v2: Prevent scheduling new ppr
 notifier during unbind_pasid
Message-ID: <Y8/6QCuqK9UGJgi1@nvidia.com>
References: <20230124104355.119166-1-vasant.hegde@amd.com>
 <20230124104355.119166-4-vasant.hegde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124104355.119166-4-vasant.hegde@amd.com>
X-ClientProxiedBy: MN2PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:208:23d::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e0a672-bbd9-461e-a3d2-08dafe205361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RoVd8hZ3f3MGJBfJXJfRUHxnuFuHa0FAO/qCcCjtmXSjzmAVH2qhi6hT1MEQyWKOeizbCz1S1fMNi3nOUZOQDrA2lLEE1wazPYqX3dGkhZBP9t9RFxAr5OdyhB6AZOQt+u4Y8h5Qt6KiSl9MvH2WzSUADJr0QiV0cDKF6WH1xYg1oekqtMDQ1Lqo/eAyWMQayjH87XShn/uKHZOorZd9ObUY7Ku5PfXPO13qP6/k7DOkib4VYkLczSMe4qYlVuu3ruzOyrjau++sigEhAdzAgJv3PPkNi+N+mm4ZGwTUos2XWWFWJJN8iierJYW75ErU7Is8JmqDe7vPY/Qfe/vGf8Mvb4BlPhEyWi5Esl/1EXPgjhmclJlbFq/wO49c49Kn+iTpjeKgM+uQmmdhCJY252juJNtaxcs7rGTS4kBvmWlbGAJq8A0Ot0vqHiRGUat198l76qu+BBVXTJ/paX0ETkyLRq70qZA5EqupiAxPsPxZ2eZZBS1FcyhVJNclt1D5HE+P8/7VTU09/+3PqNA59VgoLjnCOJ0E7QK/scJ4njccHrI1BsSwuDIaeJoPE82s/oDQx2v5BdeXeQ3i5WLva/UgG7kQXbfQYn9dugUOkI8IknZvlxRobjXGZ++dM1ZGxTD0JNTpqfdXXK+oELRUFQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199015)(86362001)(36756003)(316002)(478600001)(107886003)(6486002)(38100700002)(5660300002)(4744005)(2906002)(8676002)(8936002)(66946007)(4326008)(6916009)(66476007)(66556008)(41300700001)(6506007)(2616005)(26005)(6512007)(186003)(83380400001)(66899015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AcD+mXQURtH/huX0DMLSKAFURlE9ONrGDXS/F2oqfCjih5N16kLs8K4+JA9u?=
 =?us-ascii?Q?d2CTNL5Q5rzlWT5u+3TMeLmp06jBhx5z1Xbdo/qIDEjMRyBGWHMdPKjLDcHk?=
 =?us-ascii?Q?1Y/K7ZC/P36kmFNYsS05huuzrR2vNZI2NMnnRCrxKfxwq5qlq3sqADvm8NCk?=
 =?us-ascii?Q?BtgfO3HeictTUZc2nhdfwBi3BcnTAF2lJLSEuihtva37mKFflgoUiw3mi/r/?=
 =?us-ascii?Q?vpXvG1cQLIFa6jnBNHIZIweMoW8DCEy5GIbabk4dwsaU6gCnQNA8JPXlS3yV?=
 =?us-ascii?Q?Qt5HK+3cZjYD+lS9AZYGKsNQ5QmTHwsXQZbZg4+ucyQ4bfXwgZD5AcoEOtmL?=
 =?us-ascii?Q?ODz5ZGu2uriZcEKXqEDx4PoKL7Z1Vs6eMeU454lC+TtgGVbxjdfftiKP/Pq8?=
 =?us-ascii?Q?21+AzvWcJlJ4kn9u82PPBUts8moNxKQS0BKgyZyA34YujbI4HO7GI0xou8bn?=
 =?us-ascii?Q?gF4ILZ1ChOcpCWXPqIKKz7iAVM5mRYahmak/bDXNvtMlZT125Q3UtoEPMAbu?=
 =?us-ascii?Q?2/P7Zf89S0F+fpQdmQ6A/b6/Fc652qv8CLpzSLVuCDPJAw3SEjfI/Ifg2aZe?=
 =?us-ascii?Q?4VX05fw4L12QAx6K9oc/0trfLJB3/51rC53/htRcIbSFxAdp15B8RGwm1Gm7?=
 =?us-ascii?Q?UlM9sKicu9nfAKqMJUVFPI/XVUSi0cC955lQFwwoGcVoLSxLV6Xbeva8pR3v?=
 =?us-ascii?Q?Xol0U3LsO7zrplD1M/54loGTw1QHbS8FeTIsMqT7lCW/Crh+dpZVqyKoPRlC?=
 =?us-ascii?Q?9m3fgOjS+pX4iABLSUhPCE+vTfiZZUWqpcBUOMhcQzX6VhHpsA8Q+Xsp97M9?=
 =?us-ascii?Q?eOtdTI5IELDuXoAD/CfznWbSyJnQdTnSJrHYgqmpn7Pgxr4fQ8J5juOKSa7b?=
 =?us-ascii?Q?w2LPpZZ0y6l7wZHw1OZMvagSZpEeaVa0a5+Lx7yLSUIOgzJiIDTT3KWAWu9K?=
 =?us-ascii?Q?jnTUVJCzkcfutu71T/NK9uQWKgqykPN5yMlX5tvDma2dKv+BB0lyad1KYX1X?=
 =?us-ascii?Q?CwYyhWlluYT88jOk6QFeUXNHt5TNonJCOk41x//u2XsCltulRXdDaX0QlMx3?=
 =?us-ascii?Q?L6NMczAPIm+sELbJjtRSXJ/dM1T6TGqpf8DPR2FQLmu8+kMU11ZjlEbXCd8u?=
 =?us-ascii?Q?Z9+3YazjB2/qn28CaycjOeoshgnPtBUpxe/P+Ha/xTHflLQIwSbThb3g5Cjg?=
 =?us-ascii?Q?XvTM1qVXP1goyHoMGQY/m6eneQLiORwioXf03LuO0gb9Phdw4rBfa9oLX3OO?=
 =?us-ascii?Q?NFfxNBR2sCS04Uw2xZaHtRTaVyIRCaYkZZGEPxeN0gCjAz9aT5TgAGXdTuFM?=
 =?us-ascii?Q?aFxxbw4kJqjZPxSf7Rmj65kMuKiQiu+S5OXNC0Hix9OTmniPqAwjtwDt+gZR?=
 =?us-ascii?Q?bvHoaDhhnugojse4/h27JkFT24hGthLk0GnGp3w6uJlfBo9PALHzj+ud18KL?=
 =?us-ascii?Q?m7x/UG1cqtNQkRLfpTj+wG5Q+olMQPiMzc7mSdrSUzvfoksGbFxDl41yQIvE?=
 =?us-ascii?Q?1eyn8wIM8xAeu5Rr57Kd9XXhkdicwx1O6Z+lKcovdPfu3aY7LOkYev+JDbcC?=
 =?us-ascii?Q?uKlPnBFFf1Xs7tGrXpGoWroVRVgO5NLSvIWTfU8n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e0a672-bbd9-461e-a3d2-08dafe205361
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 15:33:21.9225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EbAAIRbGUApMa1brFcKb5joG6fDaRclTph7Xic0vgQRjKAvfXoJNVGRxox1Sbb2Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5980

On Tue, Jan 24, 2023 at 10:43:55AM +0000, Vasant Hegde wrote:
> From: Daniel Marcovitch <dmarcovitch@nvidia.com>
> 
> The pasid state wait_queue / ref_count mechanism allows unbind_pasid to
> wait for all outstanding ppr requests to be completed prior to freeing
> pasid_state.
> 
> However, we are still missing a mechanism to prevent new ppr_notifier
> being invoked after refcount has been decremented to 0, and prior to
> pasid_state deallocation.
> 
> This can cause unallocated memory access.
> 
> Fixed by changing ref_count_inc to ref_count_inc_not_zero to ensure no
> new ppr_handler starts after pasid has been unbound and NULL (invalid)
> pasid_state is returned on zero.

It looks like this is prevented by clear_pasid_state() which will NULL
the pasid entry under the spinlock before an attempt is made to zero
the refcount?

Though maybe that is missed in the free_pasid_states() path?

Also this whole thing is just begging to be converted into an xarray..

Jason
