Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC6BB645
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476490; cv=fail; b=FhF8nqSEi40yBp8Kt6pBFiPS+giAaxEXHJaePRw0pUo3lh1NjmdAeXlkYAgBleZuxpVyn+o9ilMMPmc3FyjjCOIArUXfq3fFbDYe29038CaWyPCxpS4vXwRpiqIzxIEc9v3oLL7J/S7AKvTu5m5GhtqfvVMRbgN70FoUSWgWpCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476490; c=relaxed/simple;
	bh=zzXHwnatcg+9bwfNSqmu46NR+TSpI3MPaxqsQalcN7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nQUT3ExQYPuNEp4/yv3ive9hnOMDNfqSc6Il6VPCmy/xT0511h6LSG0ZkToaLcUdbsR6+TxpeAI2yN1ix9xXWfb7OgNWhThdiNaxDvtQbeUj5/QjoDOEsvo7LT6uSQhR9s2M/dq33NCukC3zFg9vD2PPbKjYdd5Z83vJvnksu/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Po6mmDVb; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Po6mmDVb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yz2Xgx1EiG90EHIQanjb/g3BZ4GnIY341EawRMCoCSpdPmTvLV4DGKluM5WN1STieYLx3VRjvFE+OFhdK1myaUt3Qw5YeoZsVmzFiSSHnl/GChrPyslfHYKpMoUZNYWxeWxQgGrpRe+MBxesMZZfj5f2xfMhqWJvl/wYv3p41LazwBLIBk05lK68VbDIbIVSfnwNmdTTX3dOdKZNXLgvbgbaCyfo2cikC/R6w+hkLI9i0KLdEJnJs+2YMAClOz277ICKWYvt+8h2wvq1cPp+HbShnjWWaLltYq7WT+ssycYBN8ptdacWwbNpwZCxOdbCm9ZXEVtuGZRdgBN9OMsxrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynNQJP/726/thj4X6tMeGKd3+cfSPG5tpgl22ZHnCXg=;
 b=H0iw1ylXiFY5xWkCyKgC5XdXD63JqnfYTvSKItK1X7oa4TN1MyeNu+3KYPnVLTeXEjUUMOyM94tpSRcm54TBQEPsaJ0BNuSo0DFxoArezo20yTMDZqyG4JQ9XNHiCqyI5JhfYn2VRiiEn/bGalP+zu7YW3c55luOK4zRUrV7bXjqh6zZ9SqY1jhOr3stS7vM1EiAzQ2sDiOb/waLUMHsNT72IAf1CO5NO3QGtaceo7bMBtnLOf26Tko7gS2891qEU8vBynLB4Y5QR7vLn7A6nABpQRXtoOSnmVWKYiGzT687NNdbdWxIKrdJSdtfAE1KMA7rHsmlo1OPp3nN+tG/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynNQJP/726/thj4X6tMeGKd3+cfSPG5tpgl22ZHnCXg=;
 b=Po6mmDVbGMt54wEHFgMmM7aIqMH/UFB9Yl1i+uApAr8Cnm+mTCySpfmxBIwfRobF9oVMFMZyDk1fj69SNpJuXjZy5hUNHKy1t7B7YfXIN8zkqnKKPL64fuMqFHyykV1OE2obuCx5U9EMfHVd5YWJqTFZaw/btvTcQZa7yv3rjYB7HwOONwhLJ8ISs9LYPbSHy/1Dx9sUNMUhXu3d7D9/x2VdIkFtX/G9VA00gSkOi+ikm7ObdL31sgin39tVr52jDW5ulQwb2ltPJBh8va84HzIdyBAet3Xow6gbb5MB5aMPrUJULHhjB9WBnzRgTiFcIUdT1FCV4Va0tLRr9wLaYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ0PR12MB8114.namprd12.prod.outlook.com (2603:10b6:a03:4e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.40; Thu, 23 May
 2024 15:01:22 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 15:01:22 +0000
Date: Thu, 23 May 2024 12:01:20 -0300
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
Subject: Re: [PATCH RFCv1 07/14] iommufd: Add viommu set/unset_dev_id ops
Message-ID: <20240523150120.GO20229@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <6e57d7b5aa1705bdd547b1cd2aca93d3bf70dfa4.1712978212.git.nicolinc@nvidia.com>
 <ZkDWXnPW7CaX5TtA@nvidia.com>
 <ZkGZc5dvLigXcWib@nvidia.com>
 <ZkOI8ztR1mUMJ8oe@nvidia.com>
 <ZkQW6/OAQ8MzN6Go@nvidia.com>
 <20240521182448.GN20229@nvidia.com>
 <BN9PR11MB5276EEC2A1DDA9C92F96737C8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276EEC2A1DDA9C92F96737C8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::7) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ0PR12MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bce8f28-7224-4790-ac8f-08dc7b3935e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l4eFQQ0zT7OJaFjg/bmqkUBGNJLb92AvvllebzQmYoohCs4ItHfc/9pPCVEj?=
 =?us-ascii?Q?rgC011eLyuyaMbqkhgk7pRyw3jrEcfpQwQTVItFzlTE8PVmwXDapPkzXXdjY?=
 =?us-ascii?Q?jMq2dTkdUYlI+H/4GfcMo1nyzZRTcidRvOHnRvlxxKUzSrrQLNNtIjUqVtEo?=
 =?us-ascii?Q?L4zD0Jy9WkjGdxLqK4guGhkzcaO30uCg8BYeDYBBZzYeGG4WI0ofO1GPwiJ0?=
 =?us-ascii?Q?E9VnSl1+JMx5iqMQ1y9zcYPn4c62mq94lq1MEgESlZlIUY2D5E7fIWBd/msO?=
 =?us-ascii?Q?q64txQJLz6RLYLykzic270e0uYoq41AydYbROxzF227nMIhfcEvlevEBAErG?=
 =?us-ascii?Q?+RtxZVXx43r7MP42MjZpofpU6LfT1Q//aHspWcPMMZorX9ANPh9nSztO4eVB?=
 =?us-ascii?Q?HZzxbIoP3Ae7IEjEFIaibl9qYj2XM+hj3clx8If18y97lAvQWHmEF5fWYNKO?=
 =?us-ascii?Q?Cp7ch0cHfryfxANNi+9/iySw9VhSkNo/Ax82NjpmducJOwr+DhP+6RrTB3aJ?=
 =?us-ascii?Q?u1B5quVCaPe6WvrZSs2Q496tiivbGAzFWyJEYUJQF5NRGhvPuN+W0eN9FNH8?=
 =?us-ascii?Q?f7UmR6xewR48CsGBjAUPPuKhhfbyCP2IymB5SBnzNLNkEOV7rtqcxNQX0yLR?=
 =?us-ascii?Q?ljXSk4PAXRqiD0Wchcajuk/thhv9GWhjUWQ43MiA4B4YW4Bt51qoXoBjK1oi?=
 =?us-ascii?Q?LLmef4ulC1Bi4yCxFdf50waMHXjqnO/QZYzSXAghWqR48MjMc953ISDN3CCb?=
 =?us-ascii?Q?TVOW/5SZ3UNBHC+3vvU2ActshZBclDAN8aW+k4CXimwQKDxUHz/dmURKTUw8?=
 =?us-ascii?Q?vUBQjgEF+2Gdq8GJYRQDWqGoxYaY9GVYU5mX3VywVn+Fpwc1ASKPGjfPgjV2?=
 =?us-ascii?Q?eNEa8pqe/CizEeJlRZERcwW2C59FE306+ZVBo+3cd1wO+uULBTWTBIlRJY92?=
 =?us-ascii?Q?57WsX5it/rvOPApebdtkuGCcWVfG3fV9A0Hbc0Y4ue0I4NYPEEYWbZsOHudU?=
 =?us-ascii?Q?oR/MTIwR0SC9xiWHdJNMWXCrJWkzXgK8xyq4u2Xp89sHOD84+9cVtNBoCwQF?=
 =?us-ascii?Q?SetwDMef8d3GgxQYP+Yyf0zos8wzjz+072BXaG66POLI9Tyo97UhgHfFdFht?=
 =?us-ascii?Q?u9ZTUmS96aishjgB0LP8JEKe/SiZ8Xs7C7aTsrzmzBXk/Bx58Q+zIxe8TVZt?=
 =?us-ascii?Q?qqiUji40ZdUXQmLVOY5nnDshkVPfKNt7HSHt6qHAZSfx8BD52yjyoj1z7KOX?=
 =?us-ascii?Q?i49svGTxXY2sAzvHOzZVMtnhHjHz7tkqbU0XBv4C5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LZX4qqxvUnaQOi4q7WNbgYi5SCxGQltn10C3n+fvcSAI3YXHLrulllKPO3U2?=
 =?us-ascii?Q?3Q9tROhc8VK7R3J9tf7EPc9ceShNWqu6KAaRo70pCEiGLrIlgf8su2nebi4L?=
 =?us-ascii?Q?OgQeLbzD7S9x6Phsr3UgNOEWibmpf6Tul7/6c/3QHpxylrAsHJiUgt11UyEE?=
 =?us-ascii?Q?AsbBbB5C4mJiAdhRbXUSwYkMh5PyoO2rMR/dG9TMCa1C+eEjjJ4gbdbxcbmg?=
 =?us-ascii?Q?5NunQWVwTvWov56nr6HrA7qGWmAJRmB2hUdAf1K5xZ2xppllkA7UlWFqvcmU?=
 =?us-ascii?Q?w8XYy1SmaY1+n4U6/T4N315m8gzCexRs5rmwptCDwLtp3rZg5p/VypWf1NKq?=
 =?us-ascii?Q?m0T5xBf+FsI6ILZr3kTSclAlazQtBIMdUZvo/93ohyN4fp2exjXeEucWlEJ/?=
 =?us-ascii?Q?2Kwb2KU4kGZrzuoQCLLVb0OwxNOFRJmQj4/VEaXbRqNo0me0MJg1v6f+/QkI?=
 =?us-ascii?Q?U+0wXV7UG3TGkqS4rSNkgRYf4hMH1wFEewwru/UbfUIIJSPpN38/VyyojfkV?=
 =?us-ascii?Q?IYVo5fl2Z6CWcp0twpJfPhFn+8JbgQR+AMEuQQciWTqD53/oSsb/4ZCTVL4W?=
 =?us-ascii?Q?AZNFHPq+hTN2YekRO+hd/qRovcDXZmDKrUTt1SUg3I+wEfhhdAuisi9GryGd?=
 =?us-ascii?Q?htuUHw/j18BcOQ2pdapVtjbtnWhgd78byvM/NAmY4XOBaqK4mPVwWAQ6qb2e?=
 =?us-ascii?Q?9You2EVozyWwlp4BX0tG8djGsr1KNYTJR9krGmir1eIBzJ7w16ovXFPOXUwd?=
 =?us-ascii?Q?+LhmProEfGsBw+JYMYueFTRwyDxWyHjb/UHcH24UeQS/LHDLcabdLDTP1Y1Z?=
 =?us-ascii?Q?IXwfMbCDclezEoUVRoHJsCONz0lvPJ4IeZPBaNdxSM8OXNkV/feIrpnb4RfL?=
 =?us-ascii?Q?fL9N2XY82VvLF9y4MuhRStJazQHae0a5lJDqUSlYhIIbylzqIRTdlbVIzqNY?=
 =?us-ascii?Q?RIpEn5nP0TwpdTzxCAsa0P4ZV92TfZIt8rBwn8kLDNqayH+wYdQSovRe40NX?=
 =?us-ascii?Q?kF5X71iL6TxVaStEh9gknwkndkbWfxIiBotkFhZSPJRcUm1zG07bzwfziru+?=
 =?us-ascii?Q?RV48mwIbINQqEA8U+nmAZAmr6Et1FXPxJR6Zn3TxJ8Nemm/yWIMhc0INoWHy?=
 =?us-ascii?Q?EMAejj6qCWF5ZjdvrxfaCD86GRLwtFR356/cpbL7r/tASZwfWng0r82qQpgw?=
 =?us-ascii?Q?1ri8bW3e5TlQMC1lUmW757LYiA9A9B+t6csvlOObW6/Amx4vkyAT7K0v1Q2T?=
 =?us-ascii?Q?retY3/ZiIniz4IodgIgAALIHlLJyJ/AByjktqoMlvCd6815CdP5R1q2o/LuP?=
 =?us-ascii?Q?6l4JBMZTviwQEBhdbVS6w1XzwKPHQ2W+1LfAzn8x9bKnXrdcnWtqoy96N5QZ?=
 =?us-ascii?Q?QJolCw+1g2nww0c4t54MGhMVKtbhd/nRUXzM6k+C7yJfYRdkbmRARpYTVGSx?=
 =?us-ascii?Q?PP2rMhj75/VSzX+aDZiuqHpqs/1gg8M/o30ItY/NKJER4w/ryjvjl9FtCkd2?=
 =?us-ascii?Q?oZyFosxJRKdwWnpDkuli62qD0ejxDKsbxRfXEbeXLkc3vkHlw4plumRvYaKB?=
 =?us-ascii?Q?40pEi/9LDm4FggXvLgk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bce8f28-7224-4790-ac8f-08dc7b3935e4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 15:01:22.8706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZahrvXsjQsTbkB2+uehfhtkFm/s3dfr52wLNQr6jY25Y2/q/cLwyLywqOtNujD1r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8114

On Thu, May 23, 2024 at 06:19:59AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, May 22, 2024 2:25 AM
> > 
> > On Tue, May 14, 2024 at 06:59:07PM -0700, Nicolin Chen wrote:
> > > So, you want a proxy S1 domain for a device to attach, in case
> > > of a stage-2 only setup, because an S2 domain will no longer has
> > > a VMID, since it's shared among viommus. In the SMMU driver case,
> > > an arm_smmu_domain won't have an smmu pointer, so a device can't
> > > attach to an S2 domain but always an nested S1 domain, right?
> > 
> > That seems like a simple solution to the VMID lifetime, but it means
> > the kernel has to decode more types of vSTE.
> > 
> 
> why does ATC invalidation need to know about VMID?

ATC invalidation always requires a vRID to pRID translation and the
VIOMMU will hold that translation.

On vCMDQ HW and on AMD HW the vRID to pRID translation is pushed into
HW, and vCMDQ requires the VMID to do that.

Jason
