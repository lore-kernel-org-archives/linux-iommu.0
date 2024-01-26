Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CCC17E
	for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 00:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706228358; cv=fail; b=DN7QeBjhADVhoXzvdepnjedhpHCKclVfe+SDKjmQIBZOlDBarzm84Rbzki530Ot/sG+i4smvNo5GmVjmq3Vc/U/6snR3Zyu4J3wN0qTYkomxi2i70+XACdCXZDTpD+eqeNt82W6zzc8w6h3j5seXoADUyZOJTFY7fv+92RFNjpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706228358; c=relaxed/simple;
	bh=TFbuAxYhc1U6i4gZeFHHBemeUJ76xa+Z3H7wmh8MwQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JYeoULqQ0i6Ik+vdTbqMHFLchb2jfyHY9Z/Z4vYlIK1DWRtcPqFipjag1iux9JmpbNZryMVpK8/+6I2k3OAOOUP9z6Kr+CLD6P6Kr7SRgE3S6i8hWDrRhO1hxjXcDRB42VbRnt0ShEjBxXm9zam3BglO1giT61//D2gVdqZpBnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ej0FPzqj; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ej0FPzqj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTMWO1u7TKsclXbtrDoEvNyKejL9WDlVGj3VFKU6E1n2pkGw7Xc/XrCBUFFnGcZXsgvpladbAfZcfOOdZ5x2rXbMTv8nFFe8zxQ1btrydrjzjrlH4xJuFVzmdZVorziwF5gFR42GTWIbfW9pjBjm/uXpcRRdbjABGTIqWiF0hxBTrznoA1tA/bpSaN1Y5Q2mRxKvXXxtwSVYt2xOCCUMPYNBRbQW0XzYbqr30ghEDwo9lo4mDaxNikZLkSCZet0oVJZl2y8WpLp16ps3COFkpEzWycQNX1xBQFQs+GE/L86PG2//L7jcLCjtwYmqJqxu32NLdiRB4vE/fqqF8/V9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifzVQbcDFlBdFGJxKqqZ2Ebsi1uOW7vi1pC7+Tk623g=;
 b=LTjiCyK4YGhqiOzFoKB1ul4GJEYnhn2uOeynSn5pl3zyvZC1cUNxKhF7nhdLAvmbrjE2LdK+OSsrtwMLHxrq2Y3lt7a+4LvYgsli/as1czw8kP41Yx3qqrc7xLM9u0dpeQyjAubXVSM6K0waArg0kC83/LiZwXWsmS7gdaH+xfTBTmrEJINPI2bAIeyf7p9hgmrzBgogGRB/YMOB3NPL9s1Hv3RFVQSaHhFt3OojM5FmE8QbB3l9N7bG3avJ6tci7xvNo6BRK4jSQFAx05z5DSNBQQUXVWkWNUTQg6Idq7T/Br/OUn61zj/oOpvOEtt99zwAaLP2WUspjvS59Da8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifzVQbcDFlBdFGJxKqqZ2Ebsi1uOW7vi1pC7+Tk623g=;
 b=ej0FPzqjh4+93y49UjGTDJQPMD9fgCCBSCwIwsWtbiAnyFBklPHoV5uy5H6voO7oIAUQLfxEtTQmDfzWs4Xsjto4xd3tfqBvYXdQmPzOwY+jpHP8F+gI9Z0CppiNnLZhO895z6hIIjedXZeXpBbaPp3v634SzRcy1xKdivDz4bLuMj4M6n4V8ZQHeN70ln8HzhNX8/ePOLpdCcWu98sGZ8WVIwXvm05EMFbIHR9Yd9k8SB4YGYDUrg2uRthjT9Yg9QSekHj8QaG0MN/th9hR8y3lOgK+9IgUOa6qJ7ozps4QEXEI+lVE2lGLachwJIdabszxYiZj346vdjgQVkNB4Q==
Received: from BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 00:19:12 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 00:19:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 00:19:10 +0000
Date: Thu, 25 Jan 2024 20:19:09 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: About unmap pages and set dirty tracking on nested parent domain
Message-ID: <20240126001909.GU1455070@nvidia.com>
References: <92f8aaca-093d-4161-b8f2-5ab1680df769@intel.com>
 <20240125140331.GQ1455070@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125140331.GQ1455070@nvidia.com>
X-ClientProxiedBy: SN1PR12CA0070.namprd12.prod.outlook.com
 (2603:10b6:802:20::41) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	LV2PR12MB5869:EE_|BL1PR12MB5969:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 534751be-79f6-4341-2b2f-08dc1e046b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ggp58T/aK+sID7eDXOp0AEZ5lEN3Nwq2hJ6nRtws0N+zir461A03Knf3D8rYFqcTFpo7h4EgrrC3MpVJVqBsukDUFR5jZeNgFRfje9UKPuOKOBo152x0XLaT0gdmIFznDQAKv80yjVRpE0u+UYR58WvTuXJ+jnciZqM8N+UgTg38YWD3AshzzCUGsSWj7gcpai08wJvCrSvMXhSPwz0JVEeH8WmV2odn6JKGGmuUtR32cOmoGr8ai5UxmwiF562g7XC4K/X58QIex9qaHne+JFiFTWaM9ASYpKB/CVsk2tToU1twLZ8L7xmcu2zm/Pb26O3gNjgH4y9rYh8DR6HkoFDxfh/wQyuL8U0cN9F40auf93vHu8cn4xWZPNI/YB8seiG1AIBJvclgwQXqzTQrs/mS6bVxg/4VK05s2LGZpGxI3dG8gZo6W45C3j2bMTh/zZ2LwMzdcOK2lz4yJgeUteXDaPOgZpGgbc6KzGNTiXLAFeBh+0HYxkSMwdtwUW9KXhkF3C3SGhfnYIbuvIGDmlJDTY8aGIyMtcukpB1akDlV4lUwe9+86g7DKY3CZlCiG4TlTmm0ifM2+OClK3Z6vYNCql9Q+05G08ZVv5YGI68=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5969.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(54906003)(2616005)(6512007)(66476007)(66946007)(316002)(66556008)(110136005)(1076003)(5660300002)(6506007)(478600001)(26005)(966005)(6486002)(41300700001)(36756003)(2906002)(38100700002)(86362001)(8676002)(8936002)(4326008)(33656002)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RbBgOpfyJ+jxZJK/bxYFUv1gEZe7T/rKZzbt7gW3KSDyRFgDPBFVagSeLRFu?=
 =?us-ascii?Q?35y+9DenzWuzTMhSwVsOwMe3CGL7gyVb3H1k5VPcEoryt9VWKrZxETh6RJFu?=
 =?us-ascii?Q?wH5RYQQ4R+IGAGy7DV6krWy59xcm5AdgsmcIznIf0kkKOR4wPPbcRlZS1dtl?=
 =?us-ascii?Q?KiBblkzeihEOv06T7tBwRU4TFYFk6QcQ+Ieokpy8a46Z8ANazMxK/MaZ55XO?=
 =?us-ascii?Q?eCsgzbfVo9mJWM3KxJdEvfpc/J3E65qLtWmNy4BVwbC41wy6B94dLq01f3Y8?=
 =?us-ascii?Q?9HhNIaxtWttsV2XPgnYZ3aUuDQ3ZfuJXHFUQkJPfiBM6+MA1lYYebLgiIcSS?=
 =?us-ascii?Q?lF/RLDaZm289Pr6IoBFTlr4YQLFW/nzwJjTy1y1ud45HLeIGlMnoOPPW6qqv?=
 =?us-ascii?Q?lY9UbqIL2CEUD1CChacxTZLEk7mGIDVBi85lSfCyAtHoYyq/OKqL2CeAh5dY?=
 =?us-ascii?Q?lR73ULFaokyhgl6w5etbQqagkFXM+F0Pe2Bt4lcjkFWJcF7lIjP4ckamdgWd?=
 =?us-ascii?Q?O0yyiNWjSrcYegNjja5wL1PvTKks04lKkFFhdp+ZJEAqW2x01urGCn9+FUM/?=
 =?us-ascii?Q?nbuoJBzJYsjh+NfASE5x0dDW/mlsiXKNTx+uy/cxdRrciV5h5o+t7PDoN9iR?=
 =?us-ascii?Q?UrGQx25n0xopYNJ/HiEFzf57rKcwAJhlVAUAX1hV9wKwtC/IDOW0Olwm7QhP?=
 =?us-ascii?Q?6gxsaOJyZ3MQBgqoTTWmk5r6nbLZU4/lfn7ADfaDFVKb5rjNHetbSDoC2D+F?=
 =?us-ascii?Q?Kk/N/duJAAi0voTCY34MwSMfazdrmmXrTVwFVGLMRTRvhkMfcq7pBQetCcUg?=
 =?us-ascii?Q?Ja3cGsZ+8AbP4cZuP4RKTIsD9T61uU7O7AJ2hKL70dO/NOHVEyCOYkcIS1t5?=
 =?us-ascii?Q?w8lcbyFQmSPw+ybn3Ue6RtjNrZELeUYrcIHHjO6KmP7s5j84z4EafbESImXX?=
 =?us-ascii?Q?tllRFhyK7t9yjYenVyqdhC1nlh+/CE89/eFwz2B07VwIA/4eVhpxnHO5rKP6?=
 =?us-ascii?Q?KKGEBM2y6pAJY8EZVfYpA5APDwEHb7mwu9TMBWUCxWVo80QX5akNu1Y7ai/B?=
 =?us-ascii?Q?7+cpqJQ7AXvgS/wM89YdywSGkBKpq8TdxTOVbTwzV6NK1UsjTI0SKArelxEV?=
 =?us-ascii?Q?MD1eM8X8s5RudYRF2KgPkGSS7lNPOeYpztj5XlvE++aBC8qaHGIjrh9alU0v?=
 =?us-ascii?Q?j/k5bkRTmmq+mWh82ijwGp7H5704HQUWlteeScdpqzMG5PctJ9izXWu47b4b?=
 =?us-ascii?Q?ojlXb5jm15osnyWFxOhK2+PdRsT9fx6Er8gkGVXVZMInaZZaNxbjCOH0J6E3?=
 =?us-ascii?Q?XWlSf/nTt3KTC/k+DA2KAG8R9e8iuZ7lU3F9gKxJprT1T+9hvm2kLPZ4/lIe?=
 =?us-ascii?Q?2xSO6CjsD2PJS5hgIDC26T/ovlc9e+xEVpfMwBmJ6b3X2B51pW4r/RRAZhzv?=
 =?us-ascii?Q?oFQ+Qn8GI30Qha04EYq18aHTWxIos1157W3iiMF4tzK0RDbqjCMS7TzEN4s2?=
 =?us-ascii?Q?OQmTBqgDO1sH3rVo+gp7ZHq7Fn4GoUQ0HG7E6JtrgLL8KeGmA7tnpsitnjLb?=
 =?us-ascii?Q?AFmH3CJHdf7AWggTMm8W9Rfqe+k6qV+7Ev4vSRvI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 534751be-79f6-4341-2b2f-08dc1e046b24
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 00:19:10.6818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGRnoFIW1CTUQNxsP9cs0ve3BTtzv6sWaOsh5NVaiH2iWV5crWCr0s1peAfJn+Wu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165

On Thu, Jan 25, 2024 at 10:03:31AM -0400, Jason Gunthorpe wrote:
> On Thu, Jan 25, 2024 at 09:55:46PM +0800, Yi Liu wrote:
> > Hi Jason, Kevin,
> > 
> > Today, Intel iommu driver only tracks attached devices/iommus in the nested
> > domain. While the nested parent domain does not.
> 
> Heh, I was just looking at this bug on my ARM implemention too :)

What I did for SMMU is on my github how:

https://github.com/jgunthorpe/linux/commits/smmuv3_newapi/

See iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED

The list that tracks where the iommu domain sends its invalidations
gets a flag indicating that ATC has to be a full flush

The domain gets a flag that says the IOTLB has to be a full flush (to
wipe the nest child entries too)

Also note that if the VM is being relied on to generate ATC
invalidations then the hypervisor must also track the VM's ATS
state. If the VM thinks ATS is off then it will not issue ATC flushes.

ARM has a convenient STE bit that makes this simple, otherwise the VMM
will have to trap the PCI-E ATS config write and forward it through
iommufd somehow.

Tracking all the ATS stuff was a big PITA, I think the approach I got
for SMMU is pretty good though.

Jason
