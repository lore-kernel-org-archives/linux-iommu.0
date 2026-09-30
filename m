Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55E74FD26B;
	Wed, 30 Sep 2026 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777029; cv=fail; b=XyDaGMJolaBq5b8Smbd7cgypp7ire67S6IKW3Bp52Q5eKjUf6y4Zqli9QCFb3NXg+StoHpjT3PxtAxNAnvD9Rb2/dJabFukLKA8Gg+LaGTfNfhFFUD46ptDtbGrPfKq4tT4K8Y6tTFObcJk4EOlabV8FFRf20o+DwV+5E73OgfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777029; c=relaxed/simple;
	bh=of0K9Sp66YnM8vLKm/mpKBW+wNx+zQU7debAQdssNAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QM3ufpQwbo0ESo8NLsbCxBO0aMK8upxya+MrZ3e3LsvhABumzXMfcvRqJ6UsMThjefxmKhKUCFwKpcIXB+mnk0xtmhqQfsjGP4+O7obFMGlJxezut8KYlOzAVz0kKPldL4saDST/JHPN5UCfI9XOF7lGlY3ERgsyKIYSUWN7Ers=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BpkqHvMr; arc=fail smtp.client-ip=40.107.208.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BpkqHvMr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTdjZ+XlC3sTF599vsKNpPXI70K+MkMEcQ9q0mkdkAmzOSQYrw3DlvKqd2Kperp1c4Cza9fxHXBs50wsh8N4nYFJetmbG3xBuBIXWwoKcS/hsGKzBZHCiP8k4MpNs0obcF4l+M1a1N12+g3n+JdPijZHth6ik3O3WZplZvSRtcSxjDAvp7plOLXJN1O6J2dJsoIMiunn2W4HxdlKhBFqxDsURhAHqY9kb8L1QcSXEIHUSQKfDTQpI/P0O2sH6r9EQwBIvC6ZFCf3/WIzqKx1GLUU8TR4/3/5p7A9Vf6tieX+Aje22Um8pk8kP06E3bjy9vYMoQMLfVFeVbngcpD61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2swNwAELyy2Xq9mFNl5vN82MfCQPLGzBdoH1uH/cY0=;
 b=kUIgsp2VnGCmiRb/dNA2zw4QJUiruAW+XiKNQhAbo2e8sq4hM1MPyexunT1MynQL1PxO9+8b6uCeBiA1ni/9cDWvbKJTC+psHTVHd/7amFlcwF5ppDkx+BJB+PvqXM3HUWsl07o+GftAvOYMxkUuIW2+RFuQv44ImtedzOj2DkULhmhv0Ofrtoxc2gJ4My5biXM3knt3VRqTv2WwDT9ni4Bra6Y//TP9i3GnxeOVc4cOnB4o/rETPB4Y7rwsGcT7nhOjmOr+CAdg8PfLfe0r7WM2Ad3cB6KBNO04v5hF/kH1q1pRDzZtOwRMhXKNrLEkchvtfCVTBQUbFR2pdsI2+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2swNwAELyy2Xq9mFNl5vN82MfCQPLGzBdoH1uH/cY0=;
 b=BpkqHvMri2O/hliQIvmnjZILWHxo756k8Yg+ubn+pi/hQgCYoaRSA93RWUzq7ACFyq/U16si7VTdosy98yaLzRq454kaD7JQhp4p9Hx+VQwsueOoMiGw6a7/GbtgnnRQ0z93QISe9rqeVDVe5VTlA4wvkMJRzpTImZfiMuAH5ubYPLOMrKTO9+1W5wKbxLbiDcEdqxQWvs9hUQoG0/C0IAUAxEJrAPDu1uwUnh+Ac8rbrsvSrqiDPRyCCWKweep6xSYKR5RfFRKqlLafBGT03+rcGAh7zcO/LBqcELA40lowxaurMWTwUmFQ+i0OYeNzsjzX2Di4Vwp/yBHK62vZ4Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by LV3PR12MB9257.namprd12.prod.outlook.com
 (2603:10b6:408:1b7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 14:03:28 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.024; Wed, 30 Sep 2026
 14:03:25 +0000
Date: Wed, 30 Sep 2026 11:03:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 09/11] iommufd: Add the vdevice TSM request ioctl
Message-ID: <20260930140323.GS1616761@nvidia.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-10-aneesh.kumar@kernel.org>
 <179027891417.104879.282447770434616733.b4-review@b4>
 <yq5a7bk3upx6.fsf@kernel.org>
 <012d7ccd-ecc0-4105-b386-d83508ebf891@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <012d7ccd-ecc0-4105-b386-d83508ebf891@amd.com>
X-ClientProxiedBy: SJ0PR13CA0231.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::26) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|LV3PR12MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a88bcf6-68b0-4418-2822-08df1efb988d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|11063799006|4143699003|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Y8UY8IE48CskpK+HfYwZuVkVDSNtRPHGQ0/tflb/b/Zv9leOvVT3Xwf3pv3a2Vw5qvjjqZK32tIYhbVun0k0kvnpXsj+2cQxtXK8IeANpb+Wf2ElBaWm3YWLWPjyf+WkFhsnFBPCkPoICwLlzq1Ndet14iSsfFEx5f6TGpIO8EkBV29VCApv8UA3LobOnBoBYXdJ0tX+QjjgGOOwJpTg4VoGjZRze+bZvxJzQo7VH810Q5AE1Jpw9ITXWX3/x/JK7CFC/PUJ9IxZt1onEoA5p83llj6seQckcJB3tI0ddpM4f41TP224trqCtPOR75q0mZQAfxOIDATMVo6Nnz3iYpguUuL+tqvBj6JeGKGdjIv8j6HXcGdM4GsRS+WE7ZLZRBn6IXAGBlaokeUKY3LfZ0GwJJ5eyjHRev1DikCNoZ9de9E+XfFV2nTXg0Qx+lj1uLPbb2+uDp54+oEmVi+0r1CAvn/J4SaqDXWCy4faZC69wom4hTVAMQ7zE8vzRZRt05WRpe7jJxL9Axl/5ohcdibdbGRctVBdmNF/DMJbqJ1PDhjBUy2Rcvgzn2tTbF5QifEGUKSks2+RViWvAjIptNYaePBiigiQuZUQYxIx+dsbO21v7I8UhrePmQ/HLJxLepy4PnmZq2GJ1lc2uSAHhy9coqsChVmUUnzWEAAmx7U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(11063799006)(4143699003)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pjF9AWxN3Uln3ht8OYMHXoESl/zU30TVdRlLOkRaf5r1xYges9UngOPhoQ6c?=
 =?us-ascii?Q?vDreN60Do3+Pkj8L+b3jrUMQV1Jjbwf8ZYnc0eknPBxnOSdM8vl3AZJa7RXf?=
 =?us-ascii?Q?PoPPKj5MID5lUQJlm2SdgBQc/bCeaWvZvLDGXXTI8Eft8SbudZ236UYgICgt?=
 =?us-ascii?Q?bzp6ohVRnqwi+WaxFED8RVyrHlZEvqxq0aHkIMgiTLX4Rk5Dro3uPGnPiVHO?=
 =?us-ascii?Q?/QYLYOm+UiNYpD8PswjhXMmGLMB+gnnOBZhSI4HSht5Y04ttfV1ZXakO/8F9?=
 =?us-ascii?Q?alry+vqAo4fgpnN/2JPcwZC07RPkCKKq2Jvoi9uLjP+cEd/n8Fb3JDtzg9kn?=
 =?us-ascii?Q?YVCAzbgC0Pcuz1TDqK7z+9p3M3kGPfdXExVdfEOLztwTHGnL2tVJMfQ4SmVD?=
 =?us-ascii?Q?sy2hzmAcsDrAwzmRglxfEkzztpINFLbvSYW9EpU92aQl1dcovzK9qmI6nFZ3?=
 =?us-ascii?Q?62ZUNk4ErlyNvTGY7nH4wua03hFLZ9vbW7rEnE1bc70QWQx8L1OQFlx4AlIC?=
 =?us-ascii?Q?yrcoXQ5uri5/Co/tpkj1Xo7PVG0xWm4zqYzJ95bYZ88gS/1SP2YzuWZ8emsx?=
 =?us-ascii?Q?VqOXKC2xOhiYaoIA9nkn0XgG07nd8YIqT2+QGwpjLkr0TiB+mJnbTme2naBx?=
 =?us-ascii?Q?BNxFnz80GQpGoVbQ5h2oOgIkzr5cnuHLjelv679mDVMoFS7OVDO2pHw2qCf8?=
 =?us-ascii?Q?0uuy5jE8/haxZVnfsSBT1fn0pR28G7gSp8+HESy+Vq0s84jRf6famg1kOMDQ?=
 =?us-ascii?Q?nzeF5rBZYuYfnYOXKsyKt/h5F6g/KX7zPgyYUXj0mt5zctsZCrojG51xEUqa?=
 =?us-ascii?Q?XxXyxCkYKyYMyEIPm7qgQb+o0XUo1d4G+tC8gT85ouAJzazHGAQT15QbSRjK?=
 =?us-ascii?Q?UINV6m5fBqqsi67qrRR/ef0UZiQm7ipToCeDEBb88hlT2Op2ZQRg4mq9jwGD?=
 =?us-ascii?Q?f7HhE7P+8lkG/1pqGJuNNvIhnTOpFY8GfH+YRQmiOKhg4q2TgB2QXkXAWSTm?=
 =?us-ascii?Q?HzqjJU+dqsFPud1K84l6/3qzPIHS1L55tp4KnrJVdlUu5NhEotjP4l8bxlM9?=
 =?us-ascii?Q?l4b+IPnJPtXD3KHEfqwT4EGq1x9kuNiFHcJjoKlxl5oovQWKmKyYKWR+aQTY?=
 =?us-ascii?Q?+akXvTyB5jNNLfBD+Ohx3n96JzSSCln5otPNHxFgwJuYmgd84JlCltOpelKU?=
 =?us-ascii?Q?iJOXmY1YlBm4lOKBh2OgENMcHEgFsnSGDbk1v4hiGGgWtvEvOUSAec6GJ6Y8?=
 =?us-ascii?Q?6hpwtHNh7gHRZ3c9cFEUBrwujevcc5Fzjh7tadaxklL/fT4q45zU1rCe0k21?=
 =?us-ascii?Q?ArH4MJJvLEX7zkOLGbYhLRBdHbvB9mKe0kNYnPHCHucc+hXbvPirwsVj2uRU?=
 =?us-ascii?Q?Jkw9LjtI/KjWRBI6QkAUw5/uXZKXuSPOWX1m9TTRbPDwsKmSis1HyJqEQicK?=
 =?us-ascii?Q?Q81Y+38vCgRz/4PI+e9zgXsJIuyu3ISIUw/ScoaEqxAjLQ43+S3r+jI8usbu?=
 =?us-ascii?Q?VJwzlI63qYisl82NYfRjn4W29clwYj5/YhU8aZ0g/FDNEUMJ0g3zIl5/GqzR?=
 =?us-ascii?Q?MRaNwyc4wsDo5Hp2maY5jHuzMDB1JIkcU5GHZO5m0dULO4Vo8rgoOMNnR/cc?=
 =?us-ascii?Q?dgFdvh7FT0cajkkcCp4z0H7UF/E2NFV3RiYwts3Ika4eNtaTL/a2bG0qmhsb?=
 =?us-ascii?Q?k/MBMahi5NM+U+m/nyQfYth0wQxKe6FM7rkDBNlTyEbnZEED?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a88bcf6-68b0-4418-2822-08df1efb988d
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:03:25.5933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4yvI2w8gIPiRi689AVQnmTMn7H4sB/FKAkorriVTu1BKrk0bGUPutr8MozOtH0mx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257

On Wed, Sep 30, 2026 at 06:56:03PM +0530, Vasant Hegde wrote:
> >>> [ ... 34 lines skipped ... ]
> >>> +/**
> >>> + * enum iommu_vdevice_tsm_guest_req_op - operation for guest TSM requests
> >>> + * @TSM_REQ_VALIDATE_MMIO: Validate MMIO for the TDI
> >>> + * @TSM_REQ_SET_TDI_STATE: Set TDI state
> >>> + * @TSM_REQ_SEV_ENABLE_DMA: Enable SEV DMA
> >>
> >> That seems wrong.. The hypervisor should not have control over T=1
> >> DMA.
> >>
> 
> (Still catching up with entire thread)
> 
> In case of AMD IOMMU, before allowing DMA from secure guest, we have to update
> IOMMU host (nested) page table entry size to match the RMP table.

Okay, but that is not "Enable SEV DMA" that is "something something
RMP"

I do not like these obfuscated names that are still architecture
specific behaviors but obscure what the actual spec defined underlying
action is.

If AMD needs some RMP maintinance then have a clearly named RMP
maintainence op that links back to the specification documentation.

I've never liked this approach since I saw the first iommufd patches.

iommufd, philisophically, is about providing truely general APIs that
can work for everyone, and very device specific APIs that directly
work the device's interface in the natural device specific way
according to their specs.

So I would hope to see some general APIs for the SPDM related stuff, I
think everyone has that and it should work in exactly the same way? Or
not?

Everything else should point down to arch specific stuff. Like if we
need to do some RMI_VDEV_XX then it should be called that here, not
obfuscated.

Jason
