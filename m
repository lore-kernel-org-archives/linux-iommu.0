Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ED45678
	for <iommu@lists.linux.dev>; Mon,  3 Apr 2023 12:23:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emaIgsqizn9p5XYcPftJYS2Ik9AQCGyHe+BsLOeIaZzwmC2bE6Cccujn9JxZR3WF2A1V3m3h/Fu5iawflwSa21eKchuCrGFJG8DL/X6uS392j1Dp42JAJfergeAZ2bxDFjpeUf8KlQb+juhCS7H4y3uZK6oQfSLUYy24BS3MKLLj0OaQgqjpkrgHseHRSRI8vW83NAuf7/fiOfL+551y7/o2Qa8JMi5b5b6kNV7u/oU+N6kLOzA8nvqmjfFGHd1gEATeaK/40qRv2MEZPwk4JJb3wrh70HZYPCBbBi2fz4QnrQF/3zZLIX56dj3T5tdGSsx1YDZscMt7IwS75Im+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5TFbaPhqT9n5R+Mc9LZaiix9DE+YpZewOJGbjwd/oM=;
 b=ltBg4DdnvTKvCTLxN+uPY6lQPFWzuqPhMgbFBFY/4p5F+Kmr3eChwkv+uIcE5Qf8aH6WSj3FcvOVOx04cFuGTljF2jYEEbR127gzqka4oYqm62Om0zodt/afgUi+dsYZ/qrwQS7mSk1kO8mOW58z7N5cOmbblMG4rhGAG6Tc6rBZVuIRz0Vj4VvIas3f1QkaQpzpCelDhIRGm2Hncc2guHlx16FmDc9opOqCFpBbe7Fqhzw0f+G2OgDNmCw84fiPtcjKocRlXQxs01+9RcEpNJLHVb1lVs4H5gJcgdR1Urarhe2dkRcxQswmn5JzulvoZuoBY0DLrux8szkLy8qaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5TFbaPhqT9n5R+Mc9LZaiix9DE+YpZewOJGbjwd/oM=;
 b=P7cKrVKMovBmTcf0DnQP0/bXoEL4N9gmXh8kaYkW7C5LAYK9kOrV5ZWqk+KdtlsJV+JK1EIfa/5cnkf3+yFKag/elBP9ooi9Y3MoEyDm5JyMcFLKczHQCq7CVn4GmRu5d9UuAJCS0enAGfhmBCRN7Z/woVtfrD57xY+jdiY98uLK//7cRwZO2CkpKEAqPz7sKXcYU48rpqO8b9gOaVKk+HWH2ozDZW7u8hArpBbzrI6NQmW+UBeAHUQVHRbeRJ+S7rZbizEKT9Nf25EKhVJsXNUxwYA3+LeqZtn8n6S7/D8aU6XG4qOf95+xX1S9eyIe8oiMine/ErMgyR+f8k/ypQ==
Received: from CY8PR12MB7313.namprd12.prod.outlook.com (2603:10b6:930:53::17)
 by SJ2PR12MB7964.namprd12.prod.outlook.com (2603:10b6:a03:4cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 12:23:34 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7313.namprd12.prod.outlook.com (2603:10b6:930:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.28; Mon, 3 Apr
 2023 12:23:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 3 Apr 2023
 12:23:33 +0000
Date: Mon, 3 Apr 2023 09:23:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"peterx@redhat.com" <peterx@redhat.com>
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Message-ID: <ZCrFRJEF3/oickfY@nvidia.com>
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
 <DS0PR11MB7529BD4A1AE9E75E1408DA4BC3929@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB7529BD4A1AE9E75E1408DA4BC3929@DS0PR11MB7529.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0379.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	LV2PR12MB5869:EE_|CY8PR12MB7313:EE_|SJ2PR12MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: f376c198-ebf6-4e4f-bcf8-08db343e3dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qWHjbkHM4jVwaHSIh7LOOJrKzgSsghWZFSmHkArfK7kqDk+C02h2G9uyPW6P14oJYujA6CrJmyr0UJ4HV/l4kYTeODOwTZXDnnA/3nMKOvV3fUmHhTM6KCUh+EvuKy9p4rLFZu/uHVQ4lk00rbvN6dbH6yZyi9D2axVaCMkoTHMI4ueWOKW8+CeKREIwArKZSfvBV43hI8h96Wb+55rgftxmdNt5uaN06lAZj5fzd/P2nFSq4MM0Z98N3MKnTvBdkt++ZbPyAVaC3Np6En+5zZ35ZEADnw/1lvlpPVUQc7sKDkWTuY8nBTwwjMmt+uCBf9rsSjVkOvmhYwA+3usSsmUpfcHMF71KhxNDAKxTZ6rGkjw/lN7MYV30kZ0Bay5eDM9mfskWe8/+W4tJeuHXCbgt4s5N2nfMeHCp8+ZKEu+6zeznnJuuw43Ml+nXbYejTzrpleHmFTnbmuw8v66CFZHxXCA/cDv2mhl59IX7ttYfT0n+ZOoMKastEuLMkMGIajsU8JlTYYIQvgU5VXbgKnWccFLt8Lcoh0ZRs8mkvNZZwQeu07u0GvckSczsjkEW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7313.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(38100700002)(86362001)(36756003)(6486002)(186003)(6512007)(2906002)(26005)(6916009)(6506007)(66946007)(8936002)(5660300002)(41300700001)(66476007)(8676002)(66556008)(478600001)(316002)(54906003)(2616005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OT/+pcKsm0arXLFj2J3PPf5SZqX7KqRWKWMYWrlb9XYhO9Tr5DdFdvd2OgxS?=
 =?us-ascii?Q?6n1BRAS34klXIV+YhK/oBOqtPGx+X5bhM4YqwEXMmwuCPsP6AOCgPJ4cJg9C?=
 =?us-ascii?Q?S4mAdRQxjdUN0d6T2InUcKUg0TD62lYi4+p+F536Ax0Wn/GVOMm8Q3n+MBhL?=
 =?us-ascii?Q?/xnxsF5wnsCpTPALJC3JHyF2Mnp74cm2GbUMW7uaosItgk2U3K5iTNr7gbOS?=
 =?us-ascii?Q?vCzzXiylcUgNjedKfybBZ6241BWKEUwpKIL4ig89/N+PBncqa6+PkVQlEiJn?=
 =?us-ascii?Q?VZsLOpq4NiJvW1xMHOf8LdnluzIhpM6RF6VyV5sgnussKu+ngVDNcLVC3xpC?=
 =?us-ascii?Q?Zx+gkxeriJVkvM7TbaIdf1HgwsOhlLwvKrCPwqI3lkS10Huku0k2trO+A7So?=
 =?us-ascii?Q?Jg5ofcYqJi52ANC5p13ZBx4uixqVi5AwTBIN2fZjPK+VMB8Ege92wB1aubKC?=
 =?us-ascii?Q?F44BXngTEEtfXZ8erUZXdQJCGGbFwnhKEDVws426JenMdtNX06U+syTF3RQn?=
 =?us-ascii?Q?IPehwXMLmPWuANxXU//ux3rd7mdx+24bImCSNm0MdYA4FvLC2RZKlIlM7jxQ?=
 =?us-ascii?Q?pRdWbmajvTJiBWtvi6mJNMRFEK8pF2AM1Say7/uvPksm71OTSmmBg1MOWL1R?=
 =?us-ascii?Q?HJNrE7Wnwml3FsXsDFaIBZ5Z28fRdm0mC4HK0dYBhE5DXNscKApy1FUjdWu6?=
 =?us-ascii?Q?v85Fn3Ds1cibjBUeD8iZQ/qC4VSUR43cpgU3K4VqYZ9UJInLjF34w/A79Lvm?=
 =?us-ascii?Q?t4KQNbTMyERTia6wWc29bjYn+Gw+5Yyi8hFAl7nfyOQwfsG59yGVc9exzYVE?=
 =?us-ascii?Q?cD5QFVbxX+TmNIaG08mmujQZxr8p63k8pxG7bazaonfU9hK64HCJBy+NNoaC?=
 =?us-ascii?Q?6i2u4j4eU1j3tzpZhT/GguRLMuvf3AA1gIuoQTspRuZNDl2vDPlxvkEBRIi5?=
 =?us-ascii?Q?a/wOVpYW0zjkaksMp8rNmkBEK36F4VLrwJ/jKW6AdpqRE+pxqODzzYThLeft?=
 =?us-ascii?Q?7LGbTc4sQQ8h/PUTmOavTmYPO+z1DGcYF1AEU6i+/kF05Evk2WgjfCtIxZw3?=
 =?us-ascii?Q?mSYRKPlEvZjxpNGisFb3L84J+SYbjaWI/dy/i+SkcvZg+aW6sLoTpe50v5QW?=
 =?us-ascii?Q?TyDwFFCVSdlQaGO7RcQ5lBqbF+0g77saC01azVCJ9T69QrHlRCE9nM3w1TLB?=
 =?us-ascii?Q?T2tkTjwRd+OcBF3AwxFow0a4jAkx9HdT4Q+Mc/3Q9bKBQhKBEYdyeNUWjpV8?=
 =?us-ascii?Q?AayERgtz+zSSQbBgD/R4mp6gAIqU0pdEy6ahTunWmdTPpzFOtzOxzXD8gSN4?=
 =?us-ascii?Q?cc8RWQ9vrB5oGbNDOX9I4eukpWeJhrPu3ScsERrrqxksPlx6oWHNpnqmIkk2?=
 =?us-ascii?Q?Cwwzuji34tb+0pJ7bf5OB9tlYi86oyAPJwsHCD4SWmnJxE5tYBhSgBu8r76S?=
 =?us-ascii?Q?33O1xEopbS3se3/cViMkgwciOBtHkHyg365+mob20ft8rgRBA2NGoM6XGuAd?=
 =?us-ascii?Q?rhNge/KFRzMVQSPPSQ+LwMzUhaL6hsXWkwWmj9s670p081iSTBb9NYvOytou?=
 =?us-ascii?Q?PLH79hi8LmyqXLs8TRA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f376c198-ebf6-4e4f-bcf8-08db343e3dab
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 12:23:33.1745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7yqDtRCym6sHHEPqFozvwXW2fLgSeUhzwHIHnL0zkkfOhxxVw/S2Q/l26KmbMhy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7964

On Mon, Apr 03, 2023 at 07:26:28AM +0000, Liu, Yi L wrote:

> For VT-d, except for the device-TLB invalidation, there is no RID
> information in the invalidation command submitted by iommu driver.
> Device-TLB invalidation would be somehow an included operation in
> IOTLB invalidation if the page table is used by devices that has
> enabled ATS. So guest VT-d iommu driver may not use the Device-TLB
> invalidation. So vRID->pRID conversion may not happen for VT-d side.

It is the same as ARM, the RID translation is only needed to support
the ATS case.

> Domain_id is not global today. So if there are multiple vIOMMU instance
> exposed to guest, the vDomain_id would have conflict between the
> invalidation commands submitted via different vIOMMU instances.

You'd need to expose multiple physical instances as multiple virtual
instances.

> we may make its allocation global, I'm also curious when and how should
> we build up the vDomain_id->pDomain_id relationship in kernel. Maybe a
> new iommufd uapi just like the vRID set? 

I'm not so sure it even works sensibly for VT-d. Don't you also have
to convert the type of invalidation as well? Eg the nested mode uses
the DID quite differently than the guest that is not nesting.

IIRC you end up converting vDIDs into pPASID/pDIDs and doing a PASID
invalidation.

The point of doing all this stuff is to avoid invalidation
multiplication, one guest invalidation should translate into one host
invalidation. When properly setup the guest invalidations should not
iterate over host objects..

Jason
