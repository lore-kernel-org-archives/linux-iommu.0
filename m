Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F8723BE;
	Wed, 26 Apr 2023 13:36:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuB2Qrxwj20h7vS/2g7dH1Q57wZzMkdSlgWZLNWTHtSL3ppTRxDMRHS6xBhsW1B9iJdiWoRroVest5s2g3QgXTp/gyG/ye9FKRuk3Mrdk3kydaf0NLvVAmx3mUdCVl06PlfSHk9hR7zhowtf9NvZ2KOHJI/A5L5TSM2BFCzdB1UQ1KKfrXHdwOiZxoLcJPA7QdRTNrNrH2CwamQsQL9ldbZ4nxm3m9xA56NnrUuXeNVZT/labkWYtfdzvICbyHvZqanc5G8r0Ij7ES9pyy6HBvwGi9QI0hqTnRVOVDw2GQK0vb1uOglt+hnzP6NEtXnyqZlkIgCeUNW5/W8W8dHQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9hMEAs2Co78RtA0wI8Zpgk4roJP1XYs1yWSIMXUv3M=;
 b=HSs+RswqQXvTN0HHA+3x3RDjt97a557yhqq6hhgQKwiLQm6Gh1nOkGFh6fYAyUZpcLTPa195+KqWsNfyI+w2Xwy0TzyGVvfZsMjIZRTVxv9brO4J8R6/om+1dqBB6ZmAB8za/Rzkgux7ArGygLYwIgREY0PNICb387ZOXI10lb/xcQxuZEcU3hp2+aJWlDGD2fGnkh7fRVzYqmcot3/q/m6jlqnMDdu0KmLRnHByXQJrmRKc12I//iA5bAcxCrsMjXmDhVfPFk8aEURX7HbUXJEaqhdyisJt/XxJDdJo5Nu3BOMJ03XqPSVqkMGONqmTxMEXGxS2Bc9HL78STqGgIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9hMEAs2Co78RtA0wI8Zpgk4roJP1XYs1yWSIMXUv3M=;
 b=mCD+/diCuPZ7tkAXEv8UIeIhkcY08atVCzyi+q3Mnbk9bytvGVsCk2KWYZvLWYk38rKXEZ9CCs8BWHdseB3tFfjn27i0JUa9Y2iMccIzlRdBypYdi3IZ4uXxNe1+qgepuRapMI4AURiv4fjNvlvxge0SALYSwzQXtAzx/Ut3H9g2Hril6AmgY8VcZCICqeV6jS5RQhh3YcDiG+ZuLLBkxD5+OHMV1VyZpDV4c8FgcOWBGDzQYkJYyaeUDIfGHU3ijOIGShnftfrErUwWIBFbOW0OVLxlL5lEWS/nhCM3gLqn4agXVW8wpv1yp9YbEMIGDj6lJEcaJuMhqTRSUX0DxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5285.namprd12.prod.outlook.com (2603:10b6:208:31f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 13:36:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 13:36:23 +0000
Date: Wed, 26 Apr 2023 10:36:19 -0300
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
Subject: Re: [PATCH v4 15/17] iommu: Allow IOMMU_RESV_DIRECT to work on ARM
Message-ID: <ZEko0xQzArFvR82J@nvidia.com>
References: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
 <15-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
 <BL1PR11MB527165BEE507FED5D3D57A928C639@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB527165BEE507FED5D3D57A928C639@BL1PR11MB5271.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5285:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e69053d-45e4-4663-125a-08db465b39d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UQfE9rDsfxpyATAEu6dL7T/jqLxUhN5ov1/4kAJAyEiKo5kKM2GmoRT+YwM16tmQx2tz4X3JEnbJ50tMuQgOZCbGofRKURNw5uvW7yyHXtGPRczGltAD0FGDCYPhg/V0ogkONd43fLzuCZf5iyvapjSa3PkEVPEZoc92k4bKsNRjMtPbzWnZa2Dx8SxAj1WwseuzgVuLKD8s8Sf5s9C/KVKMQ39oRUJQNr7mysyRu6kdY5Zw9XZxZoUzN9U6C9+FS6+svm0+UlJSlq4EHhTW+ANZYUubD+/D5P2DVzoq9IvriySyYdPblSIw1EAU5JyLPKk/DntvYUrd6KfttIuSN1mJnFZiREz5T4zdvkbFtyiBsoPN1CiOOFa+0Dmj8USdeCNM2jtjmnXaNzt7eKcuRlIMreF2dqysVCmXBmen7ZbhPhPvfIaVg1tx99w5vDe0U4ErNr5Wmx2F2f0xlLZC00F20yYbq9O3ttraWHgQkgZH6/iKi2ZCdyfs2NXTQHmg7ttj2W4A16wqtqWJDxjgT9vV1CVvfswrRQLJtNQRFy7Fm/9bVBfOmGAeMCPLHoSZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199021)(54906003)(6666004)(478600001)(83380400001)(2616005)(107886003)(6512007)(26005)(36756003)(6506007)(186003)(38100700002)(6486002)(41300700001)(316002)(66476007)(66946007)(66556008)(4326008)(86362001)(2906002)(6916009)(7416002)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U2LGIfPJkUnzuSOpHNO92Hflf0fzOILfQyE+gRICt07iMIlios08p0qzzW2Y?=
 =?us-ascii?Q?SRMXLCvV9fyAVxJ/Q12ueJOGAtbQZppfEauq8FRStyi0zKB3DzYl/pW7oRbT?=
 =?us-ascii?Q?Qw7LVIzWWf7YZ5AU4kbfV2lpctZONVB7TdOHgeP2JTQ/ZgUZweXFgKChg5vP?=
 =?us-ascii?Q?3EnIe0j8snPqe1Devuv8PAXUmO2MVed9ODMWV1iS36AzjsVp5ZxEm36C8p1v?=
 =?us-ascii?Q?lcDUnw7c67aiFIwTaZZJfVfZXucgLNZv3panWkvp7Y0pLrrE/oR+XOOMihbr?=
 =?us-ascii?Q?y+NIdeHVMlEX4hqozUNdiQtU7cU6NbKeYDvcSj2lJqYTMsGOmmuBm/FI0bpl?=
 =?us-ascii?Q?YWv9V/qJcYX3xi71sJfFcMg2O9YDSs6o9MMkzZPKsMxacZuQoVUynWEgDBEE?=
 =?us-ascii?Q?nDDssoypBPNg6C9AYxrLIFf+yjGySX9BEjvtH2zmiGnwuQIv7Rc2sa7xKFnU?=
 =?us-ascii?Q?rtwpyrjaM7cbKPpd+YmypXM1vOUMjdPjXF2jYs7BI7YE8n8JiX/lUQF9Z8Rt?=
 =?us-ascii?Q?n5VnhLCimf2J+pknxxEqCsod5Ci3LL6/i1uVVnu7yddbYDcDEnCpk4u8xZJ/?=
 =?us-ascii?Q?Dvg5pmUdEDkRnuTMD/hHHioIXJVDr3BHdZV6fr5C0a07Ra8iqL7nqbmq+OwD?=
 =?us-ascii?Q?Ao3UkMRa0DoE0iT6rD4sfVonmosGPKdqM4HcIqEmGaFbT0u32pn+LYsol8/Z?=
 =?us-ascii?Q?Y4llUwkH+VrVuhzsTMeX6O5Xms3y3UqjivxZm36GMANgdul2WpO7Bfgki4CU?=
 =?us-ascii?Q?/5ZSg59zTltPsg07W91TVAmpegD9BzORAJD4s8JSy2/4gXyG2bT+jfx8euaC?=
 =?us-ascii?Q?Vwyeo4m/Cx11MeD9tXXhx6l8ubzrDr+jXtODKQzzMcvJcvfUyBvn/TbZ8tjU?=
 =?us-ascii?Q?jCrwDOqt+pWuuAvzc9uBdFGhpfI9EJXynBo7L8PqHaIsUCd/LJJB/GtmKp1y?=
 =?us-ascii?Q?6ZiMeaAIXI1v3Rh7dfG7jBQrQGLMmzbZciHnFOOABjinI8l6vzkJpUBN1J33?=
 =?us-ascii?Q?IasgjvxmpmbcUYfGXqozzVFzv1dJpA7nHzN6rE//leGqUSrOuy3Xw/a5GSXC?=
 =?us-ascii?Q?peCepYsiXlkVQ1+H1ja8ccx8gdqxuoHGMybxuZ3h+oTBYYpovLptvmpJly2E?=
 =?us-ascii?Q?ShIVcP/gFirQwHlWL76HGM/xbInU96OZNTKmqtcGEq3BXZ23/gO2kTljDdpi?=
 =?us-ascii?Q?k8iPPXTT4zFz72ajsLrWJ/3hA5xIFQr7r4Fj3ok2eO8+q4SCeTvl7ZE3HoHs?=
 =?us-ascii?Q?s6/m09vFnNG+6C8bty4UfBy8N6jhH/0CCk1W+ITho5LgPIrFLcf+nCVEMVWk?=
 =?us-ascii?Q?aB1lGY6fl5LEeM7owbMEr06y7cQWmM/zMGJt88Nthpa5gED+kklPQm/JDBd9?=
 =?us-ascii?Q?fuwYKc9AbwIkBw6R7gjcRjr/XHIKeSfP/6IKPXl3G+gIvRCZK+/+124ciUOU?=
 =?us-ascii?Q?4NZvVzxkSNDI40H8eFiCR/dw3A99OCpykcevHTcITYza0BEYhY5ftLk8LIv3?=
 =?us-ascii?Q?zAFj5brJ0N+E+M9wCFMbU8nAw4ncMDgxQY/NRuwKmV55xNvCnae/fXS7A8Ci?=
 =?us-ascii?Q?sZ1A44lSBJ3pWgiV+mZJF/0H/F678ZqXavBmyhFS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e69053d-45e4-4663-125a-08db465b39d5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 13:36:23.5215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btoA2up/wwMJuf2E/q3iu9YN4FAFWEH51YZ60xFBumZ91VjCdNDZfjxTGJ2U83TZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5285

On Thu, Apr 20, 2023 at 08:00:28AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, April 12, 2023 9:52 PM
> >
> > @@ -2918,6 +2922,17 @@ static int iommu_setup_default_domain(struct
> > iommu_group *group,
> >  		}
> >  	}
> > 
> > +	/*
> > +	 * Drivers are supposed to allow mappings to be installed in a
> > domain
> > +	 * before device attachment, but some don't. Hack around this defect
> > by
> > +	 * trying again after attaching. If this happens it means the device
> > +	 * will not continuously have the IOMMU_RESV_DIRECT map.
> > +	 */
> > +	if (direct_failed) {
> > +		for_each_group_device(group, gdev)
> > +			iommu_create_device_direct_mappings(dom, gdev-
> > >dev);
> > +	}
> > +
> 
> Throw out a warning so user knows that the continuity might be broken
> here?

I suppose we should also fail the whole function if we hit failures
here?

So like this:

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f44e2c21e9d05e..7a3b249601ea49 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2873,8 +2873,12 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 	 */
 	direct_failed = false;
 	for_each_group_device(group, gdev) {
-		if (iommu_create_device_direct_mappings(dom, gdev->dev))
+		if (iommu_create_device_direct_mappings(dom, gdev->dev)) {
 			direct_failed = true;
+			dev_warn_once(
+				gdev->dev->iommu->iommu_dev->dev,
+				"IOMMU driver was not able to establish FW requested direct mapping.");
+		}
 	}
 
 	/* We must set default_domain early for __iommu_device_set_domain */
@@ -2906,10 +2910,20 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 	 * will not continuously have the IOMMU_RESV_DIRECT map.
 	 */
 	if (direct_failed) {
-		for_each_group_device(group, gdev)
-			iommu_create_device_direct_mappings(dom, gdev->dev);
+		for_each_group_device(group, gdev) {
+			ret = iommu_create_device_direct_mappings(dom, gdev->dev);
+			if (ret)
+				goto err_restore;
+		}
 	}
 
+err_restore:
+	if (old_dom) {
+		__iommu_group_set_domain_internal(
+			group, old_dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
+		iommu_domain_free(dom);
+		old_dom = NULL;
+	}
 out_free:
 	if (old_dom)
 		iommu_domain_free(old_dom);

Thanks,
Jason
