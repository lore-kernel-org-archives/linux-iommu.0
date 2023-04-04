Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5726AC942;
	Tue,  4 Apr 2023 18:51:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaL9inVUMfhcOCZSHMaCTncLwPBv4ulJ1PByhdOlmmTjSYBY/rECeEPvm3cC2GlxMEl67z8ZIBFnHvX1itLPCdZNRvMBNbs3cWBNYK++xvcBF86k/X3BcRIWQLMuPxRs14MwVFaUpux8SRmVm7eICJRm24CvMIeaWYgfXT1LSmx4k5FOs8tUpMGrVmeUKC4BANNuHqs5jc4Ua0rYXaQsxlzrDUJdPTaKgh7NS0l3gJz/s1l0bPq5FZ5PVaOgmQFSafPoMVuARZuwXsWyNVx7Ft3VxdPoP+gVbfsNSugiObkRjRH/SGKpqKuzpyKLq2BZjZP/FiXZwG5biiqSEFdtog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUI+lrSbw2xvrc1cSeWEuSP+r2BIeIMxg2yWSUH2Kjw=;
 b=UPQhjKsEw1J9dv/M9nHflGT2gffgUD+e0DWsjtWXaoTFEgwFtn4S8NsbAoC8DJSDPPOiGfrxvX3UOredefloeJzjtRfuWyIpTF/l75oxqiJamarsI/qbytvT6tgZtCrJXUKJxTJFYF4jlb4xwXGDDi+ZR1oZhRYJ8lpF6EL/DPztkpRKptLD2zSKIZRZFQCCXW/ZfILnyjW68RGhtrYtVv0ZhRW3A4rLKaPtCLkCRrnA9Lj2UqW4C3iZGdCYjWEH7CIVmyZ25ijPv+TGLZoJCBvtXuMuwnVMB0UCzJV3ZACBHM4Ofyuf/OFW2xeshTdcSY5+/jcXQ5MMmZyoYfx8/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUI+lrSbw2xvrc1cSeWEuSP+r2BIeIMxg2yWSUH2Kjw=;
 b=nm4a8+ojqVdhTDORUEBv6Ou3peLTZonW8JgizFTDBljRECqbI4/rKm7FB7/qgktsqNYzni66ptG34btr7QwYZUC2PZHRn0Z1GxfEw+f94zM1mPwkwxp61BzPIp9cHg4w1QduezsDy2mjj2QZJvTmoNEIBeGgFU2i1umOvm4QVqybhfPuNknlPXjI621MJB1v8DtJmlGwuaB2P1e3OGAWNaUqPs7ssQVNwUGaY2Fgfk19We95FWVoO9XxXhFWghZ50jRBgXJpDU3nf7emrTLdhlNNxBOrQD04DrPXzuCwQTZ5tvOWYhE1Cq8DWo14ceAts2bO8VCj8RZyiHRjtQKgNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7587.namprd12.prod.outlook.com (2603:10b6:930:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Tue, 4 Apr
 2023 18:51:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 18:51:21 +0000
Date: Tue, 4 Apr 2023 15:51:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, "Rix, Tom" <trix@redhat.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 11/14] iommu: Consolidate the code to calculate the
 target default domain type
Message-ID: <ZCxxp5/Jbdksed/2@nvidia.com>
References: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <11-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <BN9PR11MB52765CCF875C64A9830A6B048C939@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52765CCF875C64A9830A6B048C939@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:208:91::40) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: a392fed3-c27d-4485-0863-08db353d94dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mgKPOonZTq9B7rhV+aIVv54c7RznDeCKmyRZ0GbIOt8x1vAWCdftKIwVduaAe0qjcuy3xapekHYJMj7St78HT1uQ7BXoL69N44w00NLWprWC7yz0FRe/oBNr51B3EjlHFvvgFB/1pwjp1BzDU8/yBzIhoXEZ39fiwyLYuEv3+ckHZG+bZWojIYkUQq0xN+XhVRK2lWaGkE/wBCk8bVZSfjP1/Ta3CVJF2+S5KihImetdfy92TQyh/HFKP1/X3CpSFEpVd2veiyn2RSv/jAwfnYgdXuvONwOIONOZKxeSMJ7HXKC4fcnCQn3K+h3Kvj190GZbaTWshpe0LRQ96Fl1eAHI/xXSX1rvA2+5UnSuQeAdyyogufeL0KwcgBOuwdCG/ZJ99nfhevNwig/2d2a6sY2028Wpa7PcbNmbMxgXu4f95HLKo7vXGPzBnvG+ZCu78hr/LwkjIR2gTqSWdHrV+oTk//zinPgj5yj1P+hRq5pE2OBKnLx5fqAmqE7W1edUPN1RHfAu64RkQkbK4Zs4eDjKz/EaiQ0NwnxW2tB7EmvKNqMHNaF9rxmqG8+/KH/s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199021)(6512007)(4326008)(478600001)(66476007)(6916009)(66556008)(66946007)(54906003)(8936002)(7416002)(8676002)(38100700002)(41300700001)(316002)(5660300002)(2616005)(186003)(6486002)(83380400001)(6506007)(26005)(107886003)(86362001)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SlFf5nC9VpFgPA6HOL6K4yTyeMiLSO93Keb7u7V53biLRsHidDNygb3Gw9+M?=
 =?us-ascii?Q?wpjBXveA6oqD9Pj91tydw7C1CYDlBzXr5Ce9sucz44sF3I6jSizQJ8aMY0Wg?=
 =?us-ascii?Q?U5CPWY5AIN6WO1z3Jcdrlw0P46KOV6h514P7vf8N1hdEbDJ0YQKNtaWhKEa7?=
 =?us-ascii?Q?cL774GcsqPKw21zjxeawMJBQqJJhhnPJrD1WgNQpFtFm+1EHCR8b3v4CPBUx?=
 =?us-ascii?Q?WDA5Gdu7lz6SXgNeEociHYPrbQjaQWqdMGULZN9TH/0Ijscf/PzZgX37G0jR?=
 =?us-ascii?Q?Pnyaz9StqVoWC0cAJNg3vYEkGJtwS7ZCOZ6JPm2a2regXHAdB1YfY+rAeVjZ?=
 =?us-ascii?Q?hDxJS6sg3yp7w/EAFazF7IKVLmY9oJ0Bpwvy57w6rzVl57vUdxfdIdGh0sH/?=
 =?us-ascii?Q?nbnsrBOAr3h+/t+dSSJNhnwPo9VMKdnu/d5zyw/TDbkAkPks7KypRwog0tT+?=
 =?us-ascii?Q?dL2vWofMDQraygnKZx+QHqFKni/+2KHevKAHHTPLMqWzXQqk6kc2XQW21T39?=
 =?us-ascii?Q?FM4C8lm3fi7g8kNMAH7mGzK42PI8eC5jUOovW8w+HGNC0UJy8MgOdncYNZfr?=
 =?us-ascii?Q?eubeAcPjIyBt4F3BdQgFAFzo+I031dWviLVPP1ZTh56EYv1puEhu2KtG9rhL?=
 =?us-ascii?Q?nUfSxNFYX31hlOZPYOC+6K0cTEhvjM2lJJ8bEKR7GMP+wspZeqSeAWX3LYMy?=
 =?us-ascii?Q?qi6Np/LBPZai5AU1b7IVNrJM7iqXrqSDF1/SMZlEsbhSRZH5O3qLO4Qnkock?=
 =?us-ascii?Q?1czm+GAb/1sSguYDn3xgzypdxONLAIgc3R/NArYVGE6R4iM1nbFudvTeVNKb?=
 =?us-ascii?Q?syXHh/my19bMQ6oDT23GqZxXz0M5vUO+Nn7aWewQz9UHJ3hlLJ3f5nTl4Bg9?=
 =?us-ascii?Q?hPDW15Uc4JCdvMijQbTNNNPmS6RR4Y0F9aC52jTEcM65kezqRTg9LyUBg6xq?=
 =?us-ascii?Q?d9+xNxGVZAEkbdjiUxIxqoYL7H42/1geg24Ykr2sZdWE3FkVpBEpcwoE3cS+?=
 =?us-ascii?Q?y4m8m0YvBHXgTjGoRydAmpro5R50B7MUA60y43GiRAH/0Wg1mPf+d5Bba1KQ?=
 =?us-ascii?Q?zZrxQA0JbQlfn3s/dV3lBF8PSEPXW3PHBbGimcAa1PLY6kmdzLDNvVAUV6tk?=
 =?us-ascii?Q?0ZOIWwAC/wzxKBVrwzd0+C7BdOclKK4h78b0Q73+tOGyOW/K4hH66UD4p9YZ?=
 =?us-ascii?Q?+FCCkfcqtWXU6zZg/SzpRtKzVE5ladaVhPFUidu55DPg6wcjAHhZ/NUXfAQj?=
 =?us-ascii?Q?v2eeQAwUaeh5VbAR6e2imHS8hPaCf6FLoYOR/0kYCOYy2taeH+mhfZ2KFKyq?=
 =?us-ascii?Q?nyiasz4XiPelvj1j9NdrtOmKl8afHMDn858I4F7ekI03LvhbEI8bgrVTx+GY?=
 =?us-ascii?Q?mGAWaDM8SVYyCv6cke+atQZei1XthJ7CwHLaeyVRDshi8UpnZcCogUd4n877?=
 =?us-ascii?Q?sRotbToX2Lga91emee0bFuc8wWuKWnUgD6AUOSHoyNUv01oy13KnwWnUh3kN?=
 =?us-ascii?Q?IrzPMF6GLqpX/i36iiuBlx474qXt8CsEbxbesuRkC6FwD8QXVwXR82MF2yWg?=
 =?us-ascii?Q?6m3yX/OTKV1Q8PxwNspLKMWRNE/6xh4TIT7l1oTl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a392fed3-c27d-4485-0863-08db353d94dd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 18:51:21.1691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7lIiWAduBhSwa1xDehnxVeufrC2GvecidE7kfMT6HolKgH9/UZF3H3uoxplc7QB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7587

On Tue, Apr 04, 2023 at 09:39:08AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, March 30, 2023 7:41 AM
> >
> > +	for_each_group_device(group, gdev) {
> > +		unsigned int type = iommu_get_def_domain_type(gdev-
> > >dev);
> > +
> > +		if (best_type && type && best_type != type) {
> > +			if (target_type) {
> > +				dev_err_ratelimited(
> > +					gdev->dev,
> > +					"Device cannot be in %s domain\n",
> > +
> > 	iommu_domain_type_str(target_type));
> > +				return -1;
> > +			}
> > +
> > +			dev_warn(
> > +				gdev->dev,
> > +				"Device needs domain type %s, but device %s
> > in the same iommu group requires type %s - using default\n",
> > +				iommu_domain_type_str(type),
> > dev_name(last_dev),
> > +				iommu_domain_type_str(best_type));
> > +			best_type = 0;
> 
> well, in this case best_type is immediately overridden by following lines
> then "- using default" in the warning message doesn't hold.

Ah... Yes based on the original code this should just be return 0.

It was:

       unsigned int type = iommu_get_def_domain_type(dev);

        if (type) {
                if (gtype->type && gtype->type != type) {
                        dev_warn(dev, "Device needs domain type %s, but device %s in the same iommu group requires type %s - using default\n",
                                 iommu_domain_type_str(type),
                                 dev_name(gtype->dev),
                                 iommu_domain_type_str(gtype->type));
                        gtype->type = 0;
                }

                if (!gtype->dev) {
                        gtype->dev  = dev;
                        gtype->type = type;
                }
        }

So if dev is not set then we can't get a type conflict and once dev is
set then it sticks at 0

Thanks,
Jason
