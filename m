Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA4219753B
	for <iommu@lists.linux.dev>; Fri,  7 Jun 2024 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771769; cv=fail; b=km7zl5Ym9/FnVZPr4328mrBcHbWOtibF+zIYarDnfyf//V9Vru7sMh/aJ1ztj2jWlfurLPFnxIw7Y0igZdSlOXBazf2p4OTb92cpK2719KLcq/pqH6izFDxxHmS6Bc9praZCRIl/utFtc90WGNX7BjcilDSR5vlaoNLU9mHQDV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771769; c=relaxed/simple;
	bh=vNL3B27RLag1zRrZ0quxU1obFxPkoPngCbm/Xd3Tjo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ttj+wtqBUgC1Xed9cbg62jhvvvjogfkyDWNZTB0bIGnfJSPnZ/FdNjPdCyZF8tLImrKfDwsAgTejx/LA3GilTxq03AwfT7DRGgu6H4chNnmyp3++vldPHCamCEcScnFSp//ajc1wL7049UixDVUenCHrGruB1h4otikISoFUctY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PT8lUWud; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PT8lUWud"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDKkf4bT0OYpkUTN2NLQ+9vy7JspJgLbwGnkpWqbXNkn8g2ZjoIlkHfdWvdRGYLhgEKQv4VC2RAMcEqj9YPJhns3sMZHXn7bOsPGqdEzuWZPw9ZMzmGuaNPs2SD+/J82CP3YYlo51/vdJJM6QL2Mfak21ZIKBkOrFxn8+ADmWcIHqVES6TOha9PUJrNlo0wM0iVCnStLQSPI+TDoMcbwZNNMMNGO4HsXBvVtw8w/29y61iH2eyYyCjhZ3qRlPC20vsWntRK+A3zmQjHZCG8EC6R6+ZpeMlAV32s/R5gdvi0O9dVakK8zjLQ+ywXmU1wndT5qKHGUFDa89GLwQ9JXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Yh89vploRfSJcxSon1/E2I94AyugCqbc8IScQp4OEI=;
 b=hlVh4aTtLwfySO1cTTfTvYCd2RYI4D59Kxt1vtu/Bo7cqAPK7cKFrWKI0Ep7KjVKNntLCsCffzExfCUrh15tWicpTH7ge8liSAuAOAbEFlRg71Uz6YfZYJ7VLlcwTW7NllKWcj+KOS7TPJpwl4IrfcqmCMzjdK0WOkmfucOA6vyQrdF5JeBl6X8kHg6qHyzreUNdeXUeON9RGU8xDw9gl5GDqCtsKuDPE8jho0Yj+JI4IT0ug4SCuij7ZHAa/uVH6V8YhGWyt8lyxoKC1E5Rzb30+Oli+aSQ31ZY4JpqwlUU/BCCgSNal0LgQehEKbfyppCoCMTsHTwH/WcPykqHjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Yh89vploRfSJcxSon1/E2I94AyugCqbc8IScQp4OEI=;
 b=PT8lUWud/71WtrisLYPSGGVXGpemODuwdrJYi8q/6kgW2YD9uvHTYRRmiMrtbfPOVFvi1h/VT3USiulWQRrYT7N7DoX7D33FgaDOUYKY90/iSlye9igqko7wjZ/GKn+LRfmV/epyStFTCjJj4UkPp7t+SCBzaFHOc08wVMRyrlsNiNpsN6IIcJx2HgKE5MEznyqOgR7D6YnLigs+lMGlS/jL3P9hI5t2Oeh6bZyXlBYLST3r38lgYwhKYY06nM6zHkohUMYs0MeDl8hZVJnwPCe5dzUe0uu/RYg8v3E6XNNpYEp4kESy/duDb50jGIkEjtTWnWfi79cHZSG75cYB2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.35; Fri, 7 Jun
 2024 14:49:19 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 14:49:19 +0000
Date: Fri, 7 Jun 2024 11:49:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>,
	"Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Message-ID: <20240607144917.GK19897@nvidia.com>
References: <BN9PR11MB52762EA9B444DA71F551C3868CF22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlafEktUu5znDsNt@Asurada-Nvidia>
 <BN9PR11MB5276AC43120376A2502D3D148CF32@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlfPPwsnY6P4SoGF@Asurada-Nvidia>
 <ZluWXYQjroz0fqqn@nvidia.com>
 <Zl03rsgZl/msa3I+@nvidia.com>
 <20240606182423.GF19897@nvidia.com>
 <ZmIDqgfINXfB0i3L@Asurada-Nvidia>
 <20240607002707.GJ19897@nvidia.com>
 <BN9PR11MB527604637EC37B3B03FBBE468CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527604637EC37B3B03FBBE468CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0108.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::23) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN2PR12MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: 192f64b3-b2bd-469d-643f-08dc87010255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TPaoS8Y+Pipio0IfwrYZmDBKslF6vPpFVxeo3VBHnI2z8GDanUZ6DOCXAB8S?=
 =?us-ascii?Q?92ovzIuZri/S7l/j2UckEYYGoUCwWX7tT5XbZotwI1u5tqpKQAIhiyh7YEYc?=
 =?us-ascii?Q?3Wt6TlqkiyBg99J5g2paX4cpe/mn89kmd86W1HZeoQP5PJbjw5woVbelj+iF?=
 =?us-ascii?Q?sI22aIZX+xTIfLSlNjfNfzr/TqmbWDAAagNNYXhdlVPDcM5vBs0L1DTxLx9q?=
 =?us-ascii?Q?p+aXxeVC7cQYjXmqEcgGaSy5f5MiY4JpxadfGMKzWvy+Tv2oTAQvx1RzRlOe?=
 =?us-ascii?Q?gl3FvdnfQpJUKjaPhLiL0zK8nCmt/AXWkFQDZP/uBYmWKwJUdm+no7MGc/xd?=
 =?us-ascii?Q?TcTj1yJDYym6GBw/5ZSJGJ5PfiA4eot0KQtIgOsARRGw/vFDPdNQo/tWduC7?=
 =?us-ascii?Q?mXdZdM1ra5w5q333hLFADbOQe+AXjvJkjV38fianeGzrLHffcl3IJ1WC+kKQ?=
 =?us-ascii?Q?zNEyS1XYBU6vYP2QPbf0YixKreCUB4z2xyBlAUftuvJU0Irsaun12jRpduPv?=
 =?us-ascii?Q?lJACKB/OUIQbhzf0HYB9BN1madHEZc5AsxrEfCDuJiNnNqy0OG8l+UuiMqoN?=
 =?us-ascii?Q?zHqLCeA/XETFa3pwKmFtDgJbO1nwa+DoU4a9t9owpY26QU9vOIEj9Xu52HB/?=
 =?us-ascii?Q?htwNd9x4UZW5GRy7Ylvny5Tl1Umngq9ESDs619hEoY1sUE/lCPfe25Jgl8sR?=
 =?us-ascii?Q?O3Zt2uDW7vYHI2Ve6vzxLaSq99XVeTAaj7Hu1CJGPHS0CKGpEPBMKhGIGjMO?=
 =?us-ascii?Q?BxQmUPum9y/02rr8d/Tb8ZpCR7CO3NtZi4O8vxMpN5GRdpZiJ0HevJVYcVaP?=
 =?us-ascii?Q?9twd/qYYAu+DzLDq2cQBpOtb48RLcVAkKk67G7LRSzolfSJI3m/LkCuBLB+u?=
 =?us-ascii?Q?bN4T4ewHqr0zjOl5d53qr0Tgopp0V0dSGwIvDsF+S8P5XU8r+snPIbF0bpCz?=
 =?us-ascii?Q?e6uQlGIQVZ919ykH3RsENYlvGDLtGQrlIv53oMkONhyY0NhDCaHc7s6FP6L1?=
 =?us-ascii?Q?p4477mRRvoNh3KAl4kGI/tCZ119zPRnQh4/UeKXgxrgiR2eQZintFjPaO398?=
 =?us-ascii?Q?w2gfzr1m6CPmGXCLo7vrbYyGIqJ47Cvgd38jWz+SWPiisofMDBTaE/43Vkoi?=
 =?us-ascii?Q?UTxkDpLp2jNFXYX66I8bkwb8E8AK2Y9FAe8as0rUQ4Lr9ifxUv7RHCIxVrX8?=
 =?us-ascii?Q?kqUFvPYATlxBMkvaJimEvz4uUOGS+sITGQbXgAtO453FpbVjk85aTOjXasjn?=
 =?us-ascii?Q?0xTsLOMALGDFAhX/cSXow3ePaJKv/RcfLOx3IQqtdorLBqQsEQZCgJPbCXH3?=
 =?us-ascii?Q?7OhTmlctYXnsA3vhCRKuJJ7H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uP+XD6whdwKn1KtTIspcqxH82fgnh1Ahhy0TncM9x4p2X9kP9arlgBVe605D?=
 =?us-ascii?Q?UpB8yi7Klae2RvuzLns8uhhQ8Inu7WBV44jtTnZt0it7Y61IN7qYBAlcL01t?=
 =?us-ascii?Q?gh49FHkks15/cNsM7xGg6FXx3ymK1ASJ0D2IjxOtoLnc/nI0PcgXIengvSsP?=
 =?us-ascii?Q?UyRQU1mN1hqiuuYhsWl4LjNd53EzmQRNBmjv5y+xGqepNINOksRn9GBLjzjo?=
 =?us-ascii?Q?tkNp5I63G5ayftaXRjdcHLqjLe7rLb/u53KLrajHqFP0oW+9+CG2GvSg1viO?=
 =?us-ascii?Q?vmjw2frJbPnjsSLlNSVK6Uswvovbzfcb2tGNrV6Oledtq57rSC9ORKJ8EAnN?=
 =?us-ascii?Q?oHE9qD7g7gwTe48Zni3/1ll2RNGKAfpTYPHblbAXX193YFpQP97dnUtOiwzg?=
 =?us-ascii?Q?GrrMpT5r6WM6itQzGLZFmlPMLDHXvn6prYnV+Q/gvURL6+TbQ7titbvUj0nH?=
 =?us-ascii?Q?n/h5xdby6/JvSnD9p0LFxjIuYqgympkhmR4DWGjkHTKj88MShpVi6SzZiIwR?=
 =?us-ascii?Q?UeDLYax30rOTfBqC8kHXBWgxDTsNjrcuNXeJ5c1m+NyN6ymOUlWN1SjrvoKy?=
 =?us-ascii?Q?kAubfghP942xDzxUZ6IftTdjN3p39DBFEcCwacglUDC3sqYIvQLHoTvpEvCm?=
 =?us-ascii?Q?nLIcPN130Z21UuNm+4O5lJ7eZoGvCgyolF8caxyE6YwjfWLD5/yYQk/nq1YV?=
 =?us-ascii?Q?rUymk9cykGo2j3wznBboX9nA+4/xtv/JNKb0TTOVafoC10MKuMMT4O/I879f?=
 =?us-ascii?Q?w3r13/sspKIA+8cbr0QlGwyc7K11pL7zYmsP2vytS/XgYtwH3Tglf7Jpli77?=
 =?us-ascii?Q?qby3C1uy24iWxbTUvyFBxa8xKysnHV5BN7WtwZBfXuIFzK8o1/eOcNMDqspK?=
 =?us-ascii?Q?gA5JNVOq6pMOB3aM5rneRQvKXF+3IU7Lr/ZlM5LvREni7ohA66FEeEyFAW8k?=
 =?us-ascii?Q?uAP0RlP5rL++mOlS2Tyk38PkzEqis1qSzOv2RYwOr/doh3x/s1wN33Praf6a?=
 =?us-ascii?Q?qIIZghBd7z0KjYPob7ya0V+R5fbKrfYBIs15pbeVVs+TOH+vCaLtAWrLwhZa?=
 =?us-ascii?Q?zh3sCX3qJzPD37TdIFEPTsWrVI7wSc3tHIzBx9pta9ajckjdsmaAX3/oDajE?=
 =?us-ascii?Q?ELullEPgCjXhE5mJduMQ6I9w2wp3w5ZxEWKQd8C6MdTfZgbQTf+ud120ObtE?=
 =?us-ascii?Q?JNs7HR7L5Ylb6ihwUmqZzj73j97yjZxvETBH/lN9jY33zt/DRDk7JkaDszBk?=
 =?us-ascii?Q?j0eVoLianCQDSnRH6MDiBlG7tqDkxld+37CHAwo4bOZmvxnHfDveQgD2ZP26?=
 =?us-ascii?Q?MosDHLmFU6Z5iyhFRMiT0Tkoy/BOvC+1EcJHDblWhQAWPj5F/vg5qSSJHL90?=
 =?us-ascii?Q?Kwct5gT+BgyZsPyjF2IOR1S54BwwVmYXKWqDTF9QriPg3DGluiuG1hka5QWe?=
 =?us-ascii?Q?BfWdLp+z56UNu4bmMvDgNnFGsYVxR+0sNf0SdNbRwOo9SC5ptVNQe2E4tyrO?=
 =?us-ascii?Q?ncWMciUB1DPLqsjvmelzmTIgiV0MiKeZrQCJm2QzUg2rVDTVpA1f9PDm9m3S?=
 =?us-ascii?Q?p7I7thhFSWy3ssDBnQ5h1mdBIWIwdQlJyxs97zWl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192f64b3-b2bd-469d-643f-08dc87010255
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 14:49:18.5078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPRHPqhnIwPmzm7B/mIDFFQUwIJ3SHRm4xlQWSEV+/kNWxEAfVKvDr9UAqubn8lC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078

On Fri, Jun 07, 2024 at 12:36:46AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, June 7, 2024 8:27 AM
> > 
> > On Thu, Jun 06, 2024 at 11:44:58AM -0700, Nicolin Chen wrote:
> > > On Thu, Jun 06, 2024 at 03:24:23PM -0300, Jason Gunthorpe wrote:
> > > > On Sun, Jun 02, 2024 at 08:25:34PM -0700, Nicolin Chen wrote:
> > > >
> > > > > > I understand the appeal of doing this has been to minimize qemu
> > > > > > changes in its ACPI parts if we tackle that instead maybe we should
> > > > > > just not implement viommu to multiple piommu. It is somewhat
> > > > > > complicated.
> > > > >
> > > > > Would you please clarify that suggestion "not implement viommu
> > > > > to multiple piommu"?
> > > > >
> > > > > For regular nesting (SMMU), we are still doing one vSMMU in the
> > > > > VMM, though VCMDQ case would be an exception....
> > > >
> > > > This is what I mean, always do multiple vSMMU if there are multiple
> > > > physical pSMMUs. Don't replicate any virtual commands across pSMMUs.
> > >
> > > Thanks for clarifying. That also means you'd prefer putting the
> > > command dispatcher in VMM, which is what we have at this moment.
> > 
> > Unless someone knows a reason why we should strive hard to have only a
> > single vSMMU and accept some invalidation inefficiency?
> > 
> 
> migration? a single vSMMU provides better compatibility between
> src/dest...

Maybe, though I think we can safely split a single pSMMU into multiple
vSMMUs using the IOMMUFD vIOMMU interface. So if your machine model
has two vSMMUs and your physical HW has less we can still make that
work.

IOTLB efficiency will suffer though when splitting 1p -> 2v while
invalidation performance will suffer when joining 2p -> 1v.

Jason
