Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56052ECC
	for <iommu@lists.linux.dev>; Thu,  8 Dec 2022 12:22:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJQcXeYb3LKyUHjOn+ksyfokJWXhIxOFTADlEzwYDgl2fOdZoOud6HVUEzXJ7caEgL9SxDvtaW9AUT5djOoajCd4rMMfIZKwfVBShedSeOdjTNlz1ATBQ9u7pTIpKCM2bG7s64C8E9cz3+N4LwQSsevCBWuNXsSHmL1aWCBGQtkM2ezQTyx6FhcXE6YwuX/oonuKMYjcTmqMFOyJ37r8qoY0kYphZbB1Os8QsPsk23Im6aweArFjdYutI4lT9yUwBJKLeTP10bQf4hB1h6H+cRIPJxw4Y4ENBSmYd67V48BtFE1gSacMHLV7/IEzEAa7cspozrCzYOZaOgSREm+WAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/kgzhgy7U25i31+5R95VOVt7/YUZVeLVSYQ5CAVt7U=;
 b=RhLT3npOs1sHxui/XiLhiiFS8hl1u9EFcqQPWBOmA3A5Ve9qO5Dr1PEl6jiCkKc+T9z8FQjqFbpI3ziqxZAuF3IRKZ/s9SpuzzSNleEGKJ7edHvWLyxUPq62kyIlbk5AmiTtT2xDt0gmADdAp1RoOSpepEX6YAyR6cJ/ZORfliid05G54KI5xrbH12z4amqPNkDYryPYqTfdltRGRRHk9Tv0xnc2AgFY0FehScWVUDkOx/oqUZ3BXcsxU1gQVWQq5J4bXXuB911dqcRE4H9s0gTJU0OOXc9jkio7I1BJ2iYFKj5Rjkhru/BSazSLhsy7xjo1actbkzEDVTvRRrEPCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/kgzhgy7U25i31+5R95VOVt7/YUZVeLVSYQ5CAVt7U=;
 b=SuLuZvQBfenF4C2hf7t6oKwslghqDaiHYAf0xIfag4lb++yau7Om5k/qP/rv4T5yBC9wif8aQHHRvPMftCC8GQ0zb1butMyxmRFdPGDZHCitZNA7rH0/x3FxN1u32fDenJKKtUu+K1u7SLFtAaF5KRUokpH0hMfSvhajSiwpCZpS79FjRPcvXMNKrZx7oeSL9cE6bs2IzEu7xmsW5Dn9hQ5NdVtqSKg6fcSgz2dHHgxFpNsxmdt9L5PYevdTby9kSYEL/yFdugC0hanGNEL+VbW71HfwP9g/OdLMJ5CP3k1+rzcY6d7zi/x0wTClEdCfvcBwTq8dWUdaJv4W8hQp3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Thu, 8 Dec
 2022 12:22:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 12:22:15 +0000
Date: Thu, 8 Dec 2022 08:22:14 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	"Yang, Lixiao" <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 3/3] iommufd: Change the order of MSI setup
Message-ID: <Y5HW9tEHWKe2pSJN@nvidia.com>
References: <0-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
 <3-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
 <BL1PR11MB5271B670EDF3977798E931178C1D9@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB5271B670EDF3977798E931178C1D9@BL1PR11MB5271.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:208:91::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: c02d18d4-5a77-46a7-fbdd-08dad916d767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nmVSlAkd5D9OQVHcdqNdXae36LFByRlKxbHOtYWVwFacJHjdfHZV9jxTvRGijLzNNZyNIqe3wGGuIJn/nE3NT2yZj+EacDuQWKzRv4LoeMDp0Xh4pTXXMxcHgSiI5YxLUhdAKmQM2b++na1AdcygTXhBwY8bi8lrN9EphpEnKrjyMbZRhJSLy+trlCDgzYTWClbZeAFlCG6SuNK4kNOfvcmqMLqEaKEV2v21a0jXKFMVKZLoZo49q+pIShbcmdLwYzMI8ZumlN/MnYp+Ane8NMXI0zKTs91J8vtp82D5IBv0kY+NsYLSvixKqcffpoOIjc7ao/e5FB7GuPMkiVrcFUXQKJimXv+AhqNSXT9PL/PkzC1gN8yTrrayfj6sXDyBClc70GUqUfyDgX9/TYS4uM4yEjFUkS1PQcrM6aHRH8jpS2+1vaV7DnSwuonglBJiijQld0zV02WqikSghUA8oAqCpJ/Opm4Mw7fbTzYy5YhC1z6/DMF0A7CPUevV3CImrspRyFtke1AjjAXXr1K3AFfOtND/VGHbY1N2k0y5wE8wtJPaWWkGvyCVvznVClAFrMZaLtJTqStiODYBzG5fybH2B8Kgg8/IuV337JGm1/XWltAq+tvKMPwNogQw9KQHoofqn9DVvebDBEagQa+hkA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199015)(478600001)(4744005)(6486002)(6506007)(66476007)(26005)(2906002)(36756003)(6512007)(38100700002)(54906003)(6916009)(5660300002)(83380400001)(316002)(66946007)(4326008)(66556008)(8676002)(8936002)(2616005)(86362001)(41300700001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zYXMIcmcCYrQ+VceNltl9sP8zrGRGxM1W+Skyp7eeh2t5AzVhGiFZHPXcoLa?=
 =?us-ascii?Q?l98HsjhiNTKpnWwNTCRWkLAsClOt1yyK2cntgKQqp2yuIbb39bXD1Qz8Uwyr?=
 =?us-ascii?Q?UCoykSRR6z6zxap8rHeo6q+Q8+v14KOrEJ3ha3qrDT5AbRawe9cEq+B4dXbf?=
 =?us-ascii?Q?4TzIOL/kpLUMfXSqWa8MRIwNSEpIiyaa4SiqTwONGFSqRv99SlcIiPM5sRYc?=
 =?us-ascii?Q?rFdUZOtgLfvRWwT9l7bMKoyY0eVHO3k9ideOAlo/L168GtIALS3GbM59mM7R?=
 =?us-ascii?Q?B2iTaPYBdMXjz+PhUsnILf09A9Rx7owyFphwXABHcAT1UFT+EOO7oZ6Cyq9Y?=
 =?us-ascii?Q?kg3jl84oEy9i9LmjB5q2ZRHmbvs5LYl+I4jdh8dPp9OQl+Wt/8jYlDKg8pxr?=
 =?us-ascii?Q?0+CN+Azxt3nNPWH4ykbQ6vq1JIviFJMELzEpv5q7Ozykr/0sdryDqROkYlvd?=
 =?us-ascii?Q?kVD6BHlO0TxnwS731ktVB9enL6f0XvWVeVVt9cRgfg/JGa89Ts6Jv3u2QU1M?=
 =?us-ascii?Q?P1S3QTOKkJUJuAE5Wt+r4m31+Xd1hOg5gbwB4f5+JO4fLNbZUBiikQpbijNP?=
 =?us-ascii?Q?hReFQDZtgXEL0g3yBcywJmgpB53Ke3JjXtJ7vymJnX4hmWr1JJ6qMP9V39+A?=
 =?us-ascii?Q?6I93qT7fELhg/pMitsMVooo+txZYYuQ24CmZdT45gIfYyP7JVp+HxqsYKhty?=
 =?us-ascii?Q?Ea81slnjR+tKQOxH3wrYLQIoYagFxat4ny+G5k5k9tHa0j8seiqrp2hJMe0p?=
 =?us-ascii?Q?e9A8PoGzClUF1yLIzNhdAuYGzEAPsK1v6hqs2Y43jWwDErT6QMWRYIVrckW9?=
 =?us-ascii?Q?QpF5s/A57uY2yRVZZqgEzOx2pyQ0WY79Xe8YgNCzz1RvmZuJozIJuNJOE4Eo?=
 =?us-ascii?Q?wycWUrXJ6vhFpUYf8cGYtj96HWtmbntE1Ee1Pio1VgB/sODlYjjkiFuCpM/v?=
 =?us-ascii?Q?mQ66Bu4tCmDl2zYumCIUmvvqxc5X7thjApMqSrYdQF1JYqWdk4iyuc6BH4Am?=
 =?us-ascii?Q?MB+XaB82UOsof240/enhtyoSU9WnRpyQjwJ/v2nhesQL7WDwe2oDVzuK34uZ?=
 =?us-ascii?Q?8mPRM3WFkH7X9NdZhN6CJ2GdZZa1TaaDKnPs52gWrRBda1snmefRUZuhlOV6?=
 =?us-ascii?Q?gQokkPu3KoY/UkVL2/t6Jhq7mNsBRWcYhd4c88kQg53CN38jdyw+HsmOP1n4?=
 =?us-ascii?Q?Kr59KfMe109qhNWkL5HfA5fUTUFBmveaglPZx1FKDhc8XZxeQdnYxukDRbGv?=
 =?us-ascii?Q?xVbF2VeXMtkkvPaIGg8J1tRqfxIx0NRFqmyK8QafBnC7W6qxzBZ3IkyqeOod?=
 =?us-ascii?Q?+SdktZaFaRaZXSTg/bBpmGkkDu9elBEc88VnEMNUE5Ev5wChBBnN4QcfO96i?=
 =?us-ascii?Q?/E4tMm4GLqhXn9Uxjqoi8F+JJuJ0uQosaCGSNM3O8IMaw3YggHxk3S9KUsbo?=
 =?us-ascii?Q?l3nO2J9dXSURVmSuOVVEP8APlcQ3v1839nEaL3K16rPbx9wdMGxsYc1xam90?=
 =?us-ascii?Q?bSWIeSBvMuq9iAdktsNELWKrHUztQE7tNWEg+r0/jMJzk9bPtysrjZ8Wmyr/?=
 =?us-ascii?Q?Ym9zjlo1/Wf+bwF1xhg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c02d18d4-5a77-46a7-fbdd-08dad916d767
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 12:22:15.4488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFfLmJz6JV2YL8he1iz2gJb2eTeBRVWiw9TEXPQQ4o9urDJQO09q1aHTkthI9xVU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562

On Thu, Dec 08, 2022 at 06:06:33AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, December 8, 2022 4:45 AM
> > 
> > Eric points out this is wrong for the rare case of someone using
> > allow_unsafe_interrupts on ARM. We always have to setup the MSI window
> > in
> > the domain if the iommu driver asks for it.
> > 
> > Move the iommu_get_msi_cookie() setup to the top of the function and
> > always do it, regardless of the security mode. Add checks to
> > iommufd_device_setup_msi() to ensure the driver is not doing something
> > incomprehensible. No current driver will set both a HW and SW MSI window.
> 
> "and have more than one SW MSI window".
> 
> Should we also change vfio with same sanity check? 

Probably not, it is to detect driver bugs, if buggy drivers exist they
will get fixed once they are tested with iommufd

Jason
