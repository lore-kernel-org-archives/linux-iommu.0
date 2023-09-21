Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F260163E
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 16:31:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/Hie9MP7MWWTea+pS6BJnwjVaMPXWRdQSlF1CVK5BQjGQ18PPzUICu0+3FPjDKIm6L0FwnMpjZyEIFR/wXcoswT1uBQcM9TKljupPMOjdKrRiY7u2mVO23nszWcZ3BxlLNOk6I8XZdkfdUR2NC/WefNVL55OMsh9RPJPnzgwK68II8SsoAp3U8rQlIfyth+VvW8vZVkyz+kDOIJ2E/GsrvehQCLWBa4mL6jbL5uqsK+BWhqgeFQh+dShsM4TLaO+sVl9mgnTPlBRVN++QaYm3TbWXTjf54gnuLA/9dlZs7F+YAL7mGpoqp8/XVB7zMG+xZ2lRB+dsD453m/jYrRAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2fGQ4UMuomiE8PqCbDqo9IaUHRIydfZBLk0kSjrNGg=;
 b=RlOe9wEzLwO5dgSk0EeYJbYh1mXnkzmTF1oDlq/O1tv81o/gtZ0u4eTUrDCAnunkPogZivcwV6d8cCQbNl+G3T4sDc34jFCT1a4LAnUosNJrsmi1cd+Z+Gm/Nt5rc0uWo2t8gcMoE4UbPaT3vA5P2Oq7HZy4SuBh2l2TwgafCFQqsThPh84m9FmKtexcxEaW1ebZ54y5OOmrpRvysZDnsnNxrGZxl8TfGKexNEZbLGAM3Dq1hsQetA1D9a4bFgicoMXDSIQzxpW1v3GX1bYFkZcuTLlyahVE8R6Xoml2bo3k1DLTYYEeKZUV/nRcpSTtuQfgMO1Sl17JAdANkVtM2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2fGQ4UMuomiE8PqCbDqo9IaUHRIydfZBLk0kSjrNGg=;
 b=b1MDdDM4XzVG9N67Mq3P0y9f1luKtoywBK/OqfPpR7GFes31mTpkHE/euPKXiz9R1pbh1eAKhgFBpbYxkMRgfD9Nh9TRdPzY0sH5xoEwfBemhalWBViJiBunQrgA7yk4HEGYVMTybLB7069MnI2WlOiSWy7BcPw6kKy+/A6f3BfCNAMUafWM6xdz9JSVJd2fRlwivSVoCiUvKZDfoFgIKaT3BCUYGCv3WWeqGPwxdmY5qTv6mukDmBt8CJfZ0TRm9GZmEhlSrPSDfuXJvIuD0wVIiVb637RAxs2+5wmmgqkBpDv7MrWu8SEdfJ2rNwxaEAP0/KzuZMPkxAdGsBqNaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8546.namprd12.prod.outlook.com (2603:10b6:610:15f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 16:31:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 16:31:56 +0000
Date: Thu, 21 Sep 2023 13:31:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Hegde, Vasant" <Vasant.Hegde@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
	"Huang2, Wei" <Wei.Huang2@amd.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Message-ID: <20230921163154.GO13733@nvidia.com>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
 <20230921093140.6162-2-vasant.hegde@amd.com>
 <BL1PR12MB5144C5ADC106D450EA73C511F7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921141415.GN13733@nvidia.com>
 <BL1PR12MB51449627A11B2BDA55B97C8CF7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB51449627A11B2BDA55B97C8CF7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
X-ClientProxiedBy: CH0PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:610:32::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7efe2a-6760-417b-b163-08dbbac04558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	egy84zABDNQIhF3KlPyp7lwE0fGI6tK9n4t2VPDxatFo3sn+3HUGiurbRJ69GgGNwFhhs2VNa4qof+wt5HVa9S5i5k1XE+Ry+a0vVjrSsJpOdoUhysgG121y+iZsXmNEGhqVlTNg5vys9LGEFOsth7OWiWWOMjSANAR9o1cFe/a1lAs2QE0gl50pUS4UWgPuUUVPQhMKNKCdeHEsOr7f3F9O1PODJ+rEQS80x7e9/VA0ywzmRhZr6a1QX+cjKpUoN/wUQtT1FvTIdGysQs2U+9TRljg7/k0vShW8cnKnwFJygyT6e/rOM8P4UguwF88Uwyg3v0VHKWet+BsrISzQeldqzHv+MqrIIN3Su3FoCd+Heot59HVb5+wLfNQXvywYVy2BvW0XsVtdOJxUjDrr5SgQfomRkRGPmjVHurm5PjMy1Nw1Mra+5flRDRlRl1xs3qZ+L7Kr7ddi1kaXHktF+PM1mXyO8JG9oIMtv/a63PdzNseFderVnZXGMDYYbfsYYWpmyflAMJQ161OeBj/useFAMCjSlAQTAn4BewebeqXeJPTQjVMUQ1ALitw2AIbm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199024)(186009)(1800799009)(41300700001)(1076003)(478600001)(8936002)(4326008)(8676002)(2616005)(38100700002)(316002)(6512007)(6916009)(54906003)(66476007)(66556008)(66946007)(83380400001)(5660300002)(26005)(6506007)(6486002)(2906002)(86362001)(33656002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mrbb4TD2veXrn/ajzYB3ufm7IcN7rEBjNuQydhj6dj2lOuBw0qXqexosxDfU?=
 =?us-ascii?Q?L0491+gjaRlZgrL/uXUzefoXUfRC7hRzDZS+XpisChovaBlYMp2mlnH/cPiR?=
 =?us-ascii?Q?XfWw1ZOVGzSTas/2zy079q1XZhD09toUHmw3HMROcZWnLvXgndVMAKmIlk6C?=
 =?us-ascii?Q?NHx2MQd06vOJ09WvDPzmplRHgnP/7oMGu5fIvByDEiROMfbanErwSf/sF/2y?=
 =?us-ascii?Q?SDbcg/zCW0YInTF4PZwLe4C5vpYdKw9krvQeBTJzjt29vp5Rs88vN6TUi+uK?=
 =?us-ascii?Q?PyZlRHOHz0MWeJzUmH29XoipwGsaV7Oit2gldkIdOHeV1XAjVwSjFbXTkMQq?=
 =?us-ascii?Q?fUBfEE6NSCzfDDnayxMswo3qLASrDkLD9qYLjDuvs+KxNid9Gfs0ubdOwFcv?=
 =?us-ascii?Q?k+kEhk1Z0hho6mYP7AgFgGEcyNpsmC0++HvkYFcrZfBuXKGgfDtos/DVTPh3?=
 =?us-ascii?Q?i0KCdYvP1mZafIpcsd8AOcja8yjTagW3fdPhFFp7SOnH9Y2301BmoRtTCs3q?=
 =?us-ascii?Q?PgARCVGSUKtfG6jA/peTcOeSCmnaew7WgaBhZ99K9D+g4odAjGcdOh1n7HXP?=
 =?us-ascii?Q?gsfaaami8ArUkSwWZ00kN5leKtXEugNUfCK/M8TA11LqzcmFW+NtbWRF6JCs?=
 =?us-ascii?Q?v7pOevJlhutSFEtI476pKS9bogzU5edxzE5bVa40f9hMq0i+rY4qQHkZ/2hW?=
 =?us-ascii?Q?lZlKkr+mF986dSQ2mcHU5caRgNVmIAKeKUTc8htfgxE0lj61OUZMjRtD+HFS?=
 =?us-ascii?Q?MsFqVCzowEgoXWWSt1iyX/K1hcknf41EX4ULADHiAyr+p8Yba7Q/pB2DYOWM?=
 =?us-ascii?Q?bc/jkBwN5lpG6U6cR9TpmrdyN2zdXBL8Mmh8pmakNeBzEC4LakErvzVbjWOQ?=
 =?us-ascii?Q?puRHWOIenYQRWW+9kSYooZq8AuiJwfHEr+l3mRgUxKJJ+dj+8+Kh9EG2AuTI?=
 =?us-ascii?Q?Vs/i1IYL09ZBfuM9PzB3CYz21L4uw/hXfAcqdbH0thare4LwzM01Oymk2hPF?=
 =?us-ascii?Q?yZXkMxlICaLp08GbNNnieo/zzNzYCGB2tozftTZqDTK8DlHjo05K7azZF48R?=
 =?us-ascii?Q?Lrpm5Fgo7kToQjf/fheMboq6H5TnBQ7yVt2vWqth4HSd3xSzabqtcXSJGdFV?=
 =?us-ascii?Q?bra1zXyVmaachmy3iRE0hviP0CakRNxdCYmbQZO4W/NiI2eFwzeie9/M+4fz?=
 =?us-ascii?Q?UnDIowFbv9Y+qBdw2szR5ideTHoR4VcpBXtYs6ff5LdKuWvaOZ8ObdAV3xy6?=
 =?us-ascii?Q?J569qclsrMKYAYBbU2ZOJWJGi1URwY8+clQO4ITxh3WZ+8WNgWnH0z2Yq3k7?=
 =?us-ascii?Q?JUnsrR3V7SjYBOJoXX/K7W/hZJrdB0RxdiSDEemwnrXV1RV2uK9Du8NiGkTr?=
 =?us-ascii?Q?n9AifD3KjyTsATAs3HXQl8LH08xRdaMTP9Iie72uB7XG9ABpeUQBi//H8B9t?=
 =?us-ascii?Q?P1UOr+YFqmca4S9k1Q9QGwSctHazB4VSc1PojxUcPRdhoTwQX10yma0DzYH4?=
 =?us-ascii?Q?/pbDdkrzUQjw9U19b9TxPwa1/5kyvSFF4hah3ar4T3hziTNuYFPt82JSl0y5?=
 =?us-ascii?Q?fn2XKJQ07IKTIWX9JIlXfecbaw733Cxqaiz3c7O9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7efe2a-6760-417b-b163-08dbbac04558
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 16:31:56.4127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BzlzeoLoMx7IIt5VAz740/CzKn8bXZHKNjRFSAsWJ4au9RlNnDILnX19mJOmkP7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8546

On Thu, Sep 21, 2023 at 03:15:42PM +0000, Deucher, Alexander wrote:
> > > Does this patch or the following patches make any functional changes
> > > for devices?  E.g., devices which supported ATS would have been put
> > > into an identity mapping mode previously Is that still retained?
> >
> > Huh? Why would we ever want to do that?
> >
> > Policy for the default domain belongs in the iommu subsystem except in
> > extreme cases, the AMD driver should not be doing random things like forcing
> > identity for ATS capable PCI devices.
> 
> I'm just concerned about regressions in random devices due to a
> change in policy in the IOMMU driver.  Previously the IOMMU driver
> would put ATS compatible devices into 1:1 mode.  Also some of the
> earlier integrated GPUs require 1:1 mapping for display from system
> memory due to hardware limitations.  There were also a lot of sbios
> bugs in the carrizo/raven timeframe because windows didn't enable
> the IOMMU so lots of OEMs had bogus IOMMU ACPI tables which didn't
> cause problems when 1:1 mode was used.

That is a fair concern.

But we need to root those out and fix them as narrow quirks. We don't
want a driver to have blanket ATS == identity configuration, it will
harm other legitimate applications.

eg if you want to narrowly quirk integrated GPUs and carrizo/raven
that would be great.

Jason
