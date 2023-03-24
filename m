Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C1B6FA1
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 15:18:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTkbOoZHO/Gg/lZtABJ7fqHz5aY9BVEC6sKw7JTP6XukPidG08phyJnifiKCYU5XCY/fNrXBVscmIg89FlysCtugrfdTgRdg0phQqYS24n4jRAxlHNEHHyrbbOuXboZ1rRBoEqyJ0thMcYlGY8mjXFxcMxj9IojzUfjaBRTmsYn5V3qvYcZl3/e0eVeIm9aiPnTFdUXSV6ACPbW3IiP++DYo0x8MiV1nERrQ2tBXYViTYAkwR3ULoRYgddxoGV8ZdPkwZNVd4uqRDsZVfVAV3I+7h32T0Fu6U4gf3TTWykvVNjEYGMjb4R0ibOULn1dQW9Ha5C2aW68llcxRe6nDFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAZQQ7ML2yd9M1ZP+C2UylAKI37TONVeb+tsP/kq2Ak=;
 b=clHIfDP5AqaFFuxjsWINcrX0OWY1hp9dDvGFKb2eDkI66EBCHKsJFloHOpuV1fTaHhWftgCHX7njr7qvFt7OnhBPRgE2wZ7BLNxQRlarOLmiHtfvg2hXbYp2+pEE/+i7H+U+dSYMxif1fJ5hm4crUXfH/slHGXKqkw3cnXXYsRUUYS6uVuQ7JEjTPauvg+eclIkw2ziOVekf8U1BfpY/+MZl1ZfVkvyfi0BMk4Y9mt0xLZxNtBwTR/paIQBjAOeQrCvJqWfEq4Ae/vq8Yn2fSVJ1dy4LtrViTC3P3jDfSu4AfxUQcO931hTizBrdXNYRDE2KUmAg3GecKiIVWejU3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAZQQ7ML2yd9M1ZP+C2UylAKI37TONVeb+tsP/kq2Ak=;
 b=fZVU/DLI3PhMG26FGKTLWQeup+Rpp6cmPl0MDPTtB32aieKV96IDoa3SiaWE4Dfgfmpn6BV5fNTkqZ2bDV/W774ak4c/G3xyt5v/mmi7TLy6bBGhMOAcICpK3VPGPGXgK+rr4y6WJdCUjAAN+jAsKAUMsK+yz7IVf1MlF4LXoHTwpI8iiHJ5rql5Y5wH9g9O9LfkZa5BM0Usb/HIXOOhPYMhGqMxx8MCnRjG0HT6+EoRHNwqMWWrktpMPSwaJxdX+A8dJE+JCVnYhUbHxldJ+tkEYfHOZixIO/jCoN86hsX7ezrT4dS6bTYTFRfp0GA6Z3AkyoXQudYy7zZvkmJKjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 15:17:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 15:17:55 +0000
Date: Fri, 24 Mar 2023 12:17:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 1/9] iommu: Make __iommu_group_set_domain() handle error
 unwind
Message-ID: <ZB2/IansEIlo2FB5@nvidia.com>
References: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
 <1-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
 <BN9PR11MB52765D03BDA136594DDD20DE8C849@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52765D03BDA136594DDD20DE8C849@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 7892a045-b0ff-4fa8-a802-08db2c7af1bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mLwT+qmo2IT3dJwtoLhpLADSlrIBZIvsrPL/nEEal3dQ1Um0a9BwzsL2WWZAWyqZIT3EUw5bvAflY/ibhn7Q5QE0LLJa//JYxNZuwhmlzstL8YvE7BZl0udZ87HwDfCZrxIY236gaph2euV3uhOTFaCg+PKDNU2mwDdkxS/eznBXKgNCMa3gSpdqbXV5B1V70zi2TdNoWAE6GSf7FcXdWvss9VD6bAHYM+DS6lTLpBMj9XCfsGmZmUzxjz4NLorQweK3qMGcnzY5SzBr4nJ1gHDLPUNTn/iyDNUstr0x0lv8t7jCCbBZAl9m+NYlIoLyafHunAUsPDnQl8p89nV5VDuhhTPkI/hgp7TPzioHnYcQWqUq2fcm4aAf6YP4xQ7YxTBjTolojpL0Pxvjf6uS7ObzQGPkZE+TYsy06X80H2Hcq6d6HQGoszq09unlG8tNqLi7TgmYAsWhrFsX1n3qB9VQc90J5sQpV1fuqDs+FymMnKiJwMSZDqw3MbcKxqm/3K5udVyOviqMCWJSv2JovDcWBdZzAc35BkkYifVqGRPLzzbSdA+Nq/e99/TkQLFw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199018)(38100700002)(2906002)(36756003)(8676002)(2616005)(6486002)(186003)(66476007)(478600001)(86362001)(107886003)(6916009)(66946007)(4326008)(4744005)(54906003)(66556008)(8936002)(6512007)(6506007)(26005)(41300700001)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O0COGWV7dj89BL1dkWBBicArUXW83TyEn5EiTPdQBUl+RK2cxeZA/1nM3nea?=
 =?us-ascii?Q?ynrjaAzPTBe+cWmgrX81h5hqVVCvV/Si1Bz0e7VVdx0s/uAG7MZilnV03cLb?=
 =?us-ascii?Q?l9+Pd1/jxkJbkkGKivoIGBbIznjjzg0970EyQEucDo2yZ+9VHTK/5JmNFl49?=
 =?us-ascii?Q?CPp6dpgKBs51+sEN/fnrdnWxanNSCt0vTOu/pgQ3KoQ/KRrBloxykQtzrqTY?=
 =?us-ascii?Q?6/EJ9AEZFJ+KFzsh7iT0UH+muXlGpEPpcb+XgLXjRneSh+k5mA3c6kWWvjZx?=
 =?us-ascii?Q?Y04BPshaWAVBUf57MxO8FeU7+Ag9R3F6Od4Fp7XbJmtcRzwLjc4NudnmzJ9M?=
 =?us-ascii?Q?5Mb9rkU8r1iu4lJdrODiqsFYPLQhdNcHy7J0q8lGPDQnaZxwDBiIbziIKBNM?=
 =?us-ascii?Q?6qmlz6sRMqqKY7HneG/UyDsQwaKsKBbFWwgXCI78gJWZe91/MWmYCRx2qsee?=
 =?us-ascii?Q?i/1KD+71I5QC8guwiHEKT/STad+WicybSgniIs5yab5bGLY0RbRbdKTaA3dp?=
 =?us-ascii?Q?AtDLJVVCQbMgh3R/zPrwFT+FKWoRrc4dxZd72B7eQZaQNljrFfYF/qXJPTnA?=
 =?us-ascii?Q?tfEoT5PpQJD2g9ebFwv1Ml7XpneJ2BwU+pWO3mWSnLkCVzQFtklhJZPWg0nB?=
 =?us-ascii?Q?BA2etlVHnm3RlFGe2qq/RVDaei8TrMjlkVwaQWJyQnzlgEAk+hYt+LyiIq4S?=
 =?us-ascii?Q?pEpsydL+dNTtvYq851E7/pSJzqc+myT5DOl8pmvjwc/i3XBCBcwWygvsFMC/?=
 =?us-ascii?Q?OB97/nfX7BmLJxLpZazZjqpzlGRdtbQ1u9V6TKHTCtZUtWhSLypWtS/L+OSe?=
 =?us-ascii?Q?tWMEPKK1gLvKN41SZqTm01Afsmr5kYLm+REZZ2RuktiUz3kOVnkjap+X3NIz?=
 =?us-ascii?Q?8b6W6MvNiAzU3Sy2WDZ46T4uqcTAWEjnHFE2TGWRHtFDdLTneXgcCRSN06Pl?=
 =?us-ascii?Q?cuwt6BCYCv+TyKiL7gcg+sbX3eXnMF06/iNQ6yyjrnlhjkUv7SHmBBn+n3V8?=
 =?us-ascii?Q?VgIEDXzGAq4QAx4aP+ohJPu7RusJTGSyaGU9ImRJi/aXHNqs0CoIwU7Xfb8c?=
 =?us-ascii?Q?I+UFCtZxwjZeQ/2eo7yoinf6sjHSaXWXzK6rt4RYngOvHYwxzzCdyUxUGxgR?=
 =?us-ascii?Q?7bKwqbsNPoseLF6+bNekCLXYUVSXe8OKwcmTbnhU9MDxhlEQ0JOifeA3Q/EF?=
 =?us-ascii?Q?uEoa+muHNxBAI4u72a7Q2D+itugpLjiimupuw0qaWIAt4qbuhSLynmZKiRiI?=
 =?us-ascii?Q?TaN4tWtYCwhETAL50HiqMc03nsb9+TV9L1CYmzJ3ZpWZsloaHO7+pwU56nav?=
 =?us-ascii?Q?kedTrXiZEZTY47c+6b50mio94INgiaDK3M0J6zl3K1Kx928DbC4M6dmBq1Vi?=
 =?us-ascii?Q?L0rysjgA3o5c5mPZa/Y1VYKXiFvADoUQHeCWOqbHxi444MBKkFYI5BbXSogh?=
 =?us-ascii?Q?95Vz/ZZN4onzEZkX8ISZMIbcQ2NvrcXB5c/1bkOCSd6H8g7Jqzgq82weYfwZ?=
 =?us-ascii?Q?Q57IwAhlMiX7xR0bcTVh4hs6Vn0UfFktsUxW9DOnLiD2h1Hgqq/5IaBiVnf3?=
 =?us-ascii?Q?wpDW/K4Cj/FPblzTKBahHV2ote3M6FPKbqe+ZchW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7892a045-b0ff-4fa8-a802-08db2c7af1bc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 15:17:55.7768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0D/jM5oEAzG/Py74kXFqAlzBaJciPP4S6zDVDbT7X5JLpU+oSbvB19RBElRZeOK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374

On Fri, Mar 24, 2023 at 07:17:57AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, March 22, 2023 3:53 AM
> > +
> > +		/*
> > +		 * If set_platform_dma_ops is not present a NULL domain
> > can
> > +		 * happen only for first probe, in which case we leave
> > +		 * group->domain as NULL and let release clean everything up.
> > +		 */
> > +		if (group->domain)
> > +			WARN_ON(__iommu_device_set_domain(group,
> > gdev->dev,
> > +							  group->domain,
> > true));
> 
> s/true/IOMMU_SET_DOMAIN_MUST_SUCCEED/

Woops, yes missed that

Thanks,
Jason
