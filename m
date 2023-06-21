Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8AA11CB4
	for <iommu@lists.linux.dev>; Wed, 21 Jun 2023 11:59:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOkhFJNa79DJXF//sUgrMTrtkRvtnDCPE3BpGLghKyk3tMgA6bl0kmSqKdeWqKFAlkCnftI3UZSIRxpWwvv9/LFPH6BrBopjSGsh6VvXbfxk8TCHJG1NMEdPOaK8i5OinvRKPqn4xpBiWuRDRrgs5Hty9qdhy0/2sKUWJvImeAdAka4d0lSu1zKnzwM+dKigOLdz6S9p+F/a2ZJD5BlsTg1xO7MC6PUL4jB5DZzhVsaXFjFvrqdBlyq8Qxz53fk4pJXQKrtQTtauzl1EFGbsUsQD+S/hlaRVsK55UjNON6jM3a5XieqGNpVnGuzSgTdPhV//je3EebcnneY+Cz/j0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sf9po9Hks1sMenC8MIRWAloL0mVO0F4EUAL8JTJJOrE=;
 b=c9aWzWdALF16eY3RyVvRhFOGcKNrASgzACdDWP8a3MT6V7MYfHiv4WPXVVLGPGov3fZaoFe6NU95XexeqmWxbcnSd2uC9e289SD5V7YGHL50r4IXZUGfuDneIOcxSvCwo6JErqEdX/uNKvln5+ChgFUKF/MZVh9+ZfITQOpS5f0TgwktXLxIGl6NkiiePvwycmGc0NqFOOIC3Eni5JmDkTPLeTdMUv65oo7oFisiDW5yvcyO12wxzI374FIU5Bt8e4jJ4bTSsvE+ccrazzeJ1YM1O89Vnc0KnItf0AVgp2d0QmzKecoWkV/9LNIx3V17tlb/G2jcvfVt9PXn9gI+MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sf9po9Hks1sMenC8MIRWAloL0mVO0F4EUAL8JTJJOrE=;
 b=gYBjrxcOb6W4iYlnsgBNCm7dSv4jCdAeIA5UA2vUH1UbW+0qtjK725a/yOGbZBjjXNdNlZ12zNfToHfqsVnGQImtLpeVWGs2mwnktN/46WNwq89xPOdBKciJCKS1XTMZL3kmDu1UsocQ06nvzFLeWKlhH0NXunEHySe0AyvSK4bFmvsE9i253y8ekQFzNndSmgoyEeEfMNPIoRcCB8p4/knsaHJ92LYsoX9fZLpvFGoHzdt5vY1LQmDHZOrq7VcInnFgKdL3Lbv3DMef1uV+Hglj/B0lM9j9KiPqStn3G2G1xVBBBv6CMIzBGCGCjmQHBO/RPOHuppJVvO5U0j2zgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 11:59:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Wed, 21 Jun 2023
 11:59:32 +0000
Date: Wed, 21 Jun 2023 08:59:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com" <syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com>,
	"syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com" <syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH rc v2 1/2] iommufd: Do not access the area pointer after
 unlocking
Message-ID: <ZJLmIr8NLEVjddWB@nvidia.com>
References: <0-v2-9a03761d445d+54-iommufd_syz2_jgg@nvidia.com>
 <1-v2-9a03761d445d+54-iommufd_syz2_jgg@nvidia.com>
 <BN9PR11MB527648F55F4F36A24B50E6778C5DA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527648F55F4F36A24B50E6778C5DA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BY3PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:a03:255::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 061025e1-e374-4dca-2a79-08db724ef9d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s8pSL7L79w01hnNqKyTevtD62LSuh4BOLFq+2jr5m4L/NxpTQUJgt4G5MWgZm8aWHtnXljOGIANmKtkW25N6RML3RhG3gh9eTjD2oc6mX3v0oct5pcV/rZTg78Rgg6Mkqe96rpE5Bc1DKqfGQGxescP+JkH5BzL+lDLJbXg7xF7H/SPpYDCPtlSEidg5YmwDzpymaeYlKCmSb4OnHTW0/dgo67CtpI7ckHsdNXrIbMXMm1eTVt1lyVktvldxgaIZ3Ivv6QFuQtZ5O77IIkVRi5U4r9Iy0K77KzJeQnBll+8lzxJlnbO4nMP8YUO3Bn+UHziaKEIGQYdAshiFx6193dWleqUPxXZ9uLDAckwBWZbPcMTU9sILhb/VLZ4k9xHc/tsE+SVJTLoSY9Ng2oBtQRHEbmB2yrSgcv4DezwQHbRr3Bp4dh+iixjZpQ7MBYFWaBY1yKj0tIrcaqItUHxp0QBaajU/H2s3eJSNUVuNJ5h6SR0s7qQG9YVjrQTFHLC1dpa5JEcXrqLPW1TAH6IVuCb+2u2yAy1zIXorVs+nYpDO/MtDM+QSgH7PPGE+MoMm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199021)(38100700002)(26005)(6512007)(6506007)(83380400001)(186003)(2616005)(2906002)(4744005)(41300700001)(5660300002)(8676002)(8936002)(36756003)(6486002)(478600001)(4326008)(6916009)(66476007)(66556008)(66946007)(316002)(54906003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a9mFh5NEgq/mjK6YhDolTRvU3LQ1zd2ELGfdu+0WLfRoD1nmMrZwXEwpS44H?=
 =?us-ascii?Q?IRx5e70Isel1R4XA0DG0fHTB8OZmcHCo0OHt6a83qaSX6hRFsGJvhPw/nH8y?=
 =?us-ascii?Q?Oj7aLO1xgU33sEx/aVu40+hBIn3uvI2SiLGFZQO/5XAXj82rYpA5GBMqmyc5?=
 =?us-ascii?Q?OSZadB0AelyrbUlED3lfu77gdNjesZ9u1dLf0M5ObylXHNpNBNQEMdvK+zOx?=
 =?us-ascii?Q?1scCt1CSvT0yXUVZhkTEXS0MBxMwyZ46tQgyrTM7sp9b1pl6k/jalkSlmb1f?=
 =?us-ascii?Q?sTo8D5hBfevHQd+rcl7iWqSXwxdi2VX3ZkPM4KA9s2QknKNAQYj63nz+Qwsm?=
 =?us-ascii?Q?Tl7XA+JLCAqL1Pbq/S1GfPG8JcspZd7OISQUWnCr54jQkWEmpIie7rxfmoOQ?=
 =?us-ascii?Q?Pw2Bzvv8Sbsgx3QIwHRym8T1dsw3iLpxs9rlmHzxdAZ6zQUZphImytK8J/2g?=
 =?us-ascii?Q?LOWdMs4D/fi1B2kFqyQ75RHfaE8tciecj7gIql9Tqh17oMv6+FxfcMum+5CB?=
 =?us-ascii?Q?KnCtllvJO1nvqzqxdIN1yD0U9BVq/cvuXzmv9+zVXKABNYljQpFqkqX4Pe6S?=
 =?us-ascii?Q?yxFNEi07imHmzttw4TPo6XWW9nogdsR7mSLC/M+3VJPivjP8O+nI9MQseC0g?=
 =?us-ascii?Q?Jt4ov1980klMHF62LuO7VwPklv7G7ORRrKGX9l3VqH49d/H3eXe0TD2rgfsT?=
 =?us-ascii?Q?RmrpXZzG+/jQ83oOX8OVXC7iy/BcUmCyHmJaSdSYjd0G4rcwPIuWrDKYsEjN?=
 =?us-ascii?Q?0lt7nd2dw2ZYeYrRW0FQV9p9TUOvxHRRugu6kgV5Qc6+O2Pytr5TJWMvce4H?=
 =?us-ascii?Q?ZS3iOlBo9vOIWZ2KPyFoH3s4BP3SFmNilqrLP9AFGrNUq2qRHZ0yRNWPMu0j?=
 =?us-ascii?Q?zS7zpZUuSj3yQiz/2dUTeIP0hMlLyiKd+zwO7urDcD/5kI77j3ptPgCKgyrU?=
 =?us-ascii?Q?LNU7dxABQskgeETYpFsykQ9Jg8/fzGiTgdj4gtFFKimNMU+SmBCust0vtzE3?=
 =?us-ascii?Q?N7WfBzqOPg22EzbEcuFcx3g32ZWdgCA+h/ydgBYKdwTkfp4jsGcU9hjd7KUi?=
 =?us-ascii?Q?G7Vv59qpKnfZ3K9/TVFh//ya75mFXW8B3b3/nOWQxiJEDDf8aDxgVoaj+pOr?=
 =?us-ascii?Q?ymOjF23hRA4rvOssvGkK10k/yNvOPhway5KmcUq23gYnRO0HpTA9WvWBF12a?=
 =?us-ascii?Q?+ObXX12KvvaPZItKdEbu3/EwOBtspRrSs1XbsfTG3i5lCncr2xtzsmMrtG7o?=
 =?us-ascii?Q?Hr32FbbXiI8ibaeCpnn0jb3q63erj00nNMr8jg+0p+sCDmWwOsAuAkLE8xRW?=
 =?us-ascii?Q?Tl6rIH6pdU22Jkwh4RtU/nsWB/x6TTWtSI3UXXxktyFhviQ/5WaZr3J6C/5Z?=
 =?us-ascii?Q?TV/K7n8Sf8EWaatwt4xzlx/VFi0aVAjjXuwXZlUNDQcRJL0jUcyl2LvSdgXo?=
 =?us-ascii?Q?/5BtRpTMUz8/UKPhe467W/Bt8hdOj2g7oMrs06EFQHwOJOshLK3gc/LIyNW3?=
 =?us-ascii?Q?eG8uP2V01K87Zf92qFqFHhFN99OJDUUA9+XzRro6tbxPAG8XO4C91TjMJZPm?=
 =?us-ascii?Q?o/WwdChZceNOzGtTZe8ZusGmZ/NlKXi+f2fv8E7y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061025e1-e374-4dca-2a79-08db724ef9d8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 11:59:32.9017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RpayXoOHgBhvSwlQtiZpiyMC+Tq9YPQzfHR2AAinh2CfNHi3ETqH9vOPp7tyy3V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594

On Wed, Jun 21, 2023 at 05:01:28AM +0000, Tian, Kevin wrote:

> At this point what about a concurrent thread triggering freeing of the
> area pointer and then adding a new area at the exactly same offset
> and the new area is also attached by an access?
> 
> If it's allowed and repeatedly occurred, then the counter may overflow
> too given the new 'area_first' is equal to 'start' in that
> theoretical case...

Yes, and that is appropriate to return EDEADLOCK if we spend too much
time trying to free the same IOVA.

This is userspace harms itself, no sane userspace should race map and
unmap of the same IOVA.

Jason
