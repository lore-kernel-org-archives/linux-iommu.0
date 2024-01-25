Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC7A5A119
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191420; cv=fail; b=EJWttSExL93C9uOuZNGWuzK2KVWYhClgqUds9bJeV/Y0LYK6iKA1AT3X6lIcsKKVCCie2GtlvybRyQdt+U4ju2mISQThsMmWO1uJNwmNKfAcpIz4yolKCDRs3+36UBainKV7OEqJqdlNFpp1E8AnusWXNKWapC+9H5yNZUYdgvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191420; c=relaxed/simple;
	bh=J+L3TGVZacI4Lk4eySqoWXCA00LDt7lxPEsiKu27WYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mrDQZW8CNOXemv5FPl63mFfdtGS8ctBeKl9iEEAhuSfAoxaWP1lliEaJDCYLEcKrWNSAqkjQD5DXNgiHBtNfmWtXKcpBYbPSziZVIZRX0VYdz1FCmLcNa1NK1Y7aX6f3lnrKpvpZup8VSL9u8ZmULxuf9820lMQcnsymWFFZth8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bjb6IAHx; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bjb6IAHx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8sAV/NJ6quOLz7Jn33pIxXNF+fQFGgh+xKfCxWQ/MkFzqGi7K/Neg0eZf6cI82DYSo8GOx+xQFgY5FdKy0L6OKG7zA2+rkuVJjQImb2SQPjoB8zglTeeQ5tTdL6i/+NQI/27cshzWPCy+Kqh2ziNdwUaly7SjBvNIR6wo5u9+UVG41mZiSOQKuckqNff0dBMAKByGeJ4I67qWA0Ab7VQ4jnUsqYf3Uf0fZvLjCdMKyXWYhbBBV3tnb5WEq7KqVtuJPGaQlIemmJ+cGmKHUqyPQZxpAk5c39KKwkexu8CiGq0TH5vwynzOqmFSZ8xDFufSfobVhpQp8uXtxs9BBggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBRlqtoMH/TdjLaSOLWjXlb7LpIMsyJjytTOkpRELN0=;
 b=NFpNZj03IDtDVW2K1Kp1KNjN4DM03jzj5ildK1PT8lBSxF/pnT97RHnMRG5Vto9Xi2qC71QZH+ylzLMR9GadixogPUY60ejwd00LqWqIV6gS/BxmrrD4ODONCalPQTamCcUy+6VGV92hxalkpiGFhsAwJ30JPGz+NBPpOh2CP62gsk//SLCQbiMO3FJuufkScim9e8NEFuKorPK7ML3HjRyMRWltkh9BnycX9MbLo9xj7PUZ8Vj+Xy+40mz3NpKQjBiK9PJS3ijvkTnYSwSgc7TkaIvKWgvSd/FTjnYWCYUZLrmT8st16//esG4p8PukMj/33QthB5kyX9FZJ8ARkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBRlqtoMH/TdjLaSOLWjXlb7LpIMsyJjytTOkpRELN0=;
 b=Bjb6IAHxY2YgX2uZq80B4qB1bmoTYKqGgq5pi2VWDyS6B5hKMA87+vqLpnPtYhbArVN+QB1WrKE5RAK8fNxjWLfDy01glnCJYtcU5jjDPZioFjDfM07VfrKu1VtoN3DDsZbKpJkZVNQ5FpF+XSzwg0WbGTKLL6WK2HapxoP4fyDO5FyTMBh7dKxzjAahHduTn2ryhPfj+OYNA8WC3Z0t03CZ/y4mAQveJb9k1F23aqQ9gOHmwrzMahDUHblNmS58JtDQAeDSbdOvntjs2MvGGxpwzCUJVEGtqky53IIz9lRGok5GP1PJb8Ai2BtYxUzZjMvDC5dgaEy6+7w3JWU7ew==
Received: from CYYPR12MB8704.namprd12.prod.outlook.com (2603:10b6:930:c2::19)
 by SJ0PR12MB7473.namprd12.prod.outlook.com (2603:10b6:a03:48d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 14:03:34 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CYYPR12MB8704.namprd12.prod.outlook.com (2603:10b6:930:c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 14:03:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 14:03:33 +0000
Date: Thu, 25 Jan 2024 10:03:31 -0400
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
Message-ID: <20240125140331.GQ1455070@nvidia.com>
References: <92f8aaca-093d-4161-b8f2-5ab1680df769@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92f8aaca-093d-4161-b8f2-5ab1680df769@intel.com>
X-ClientProxiedBy: MN2PR16CA0045.namprd16.prod.outlook.com
 (2603:10b6:208:234::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	LV2PR12MB5869:EE_|CYYPR12MB8704:EE_|SJ0PR12MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 29958258-0b95-4f9c-7026-08dc1dae6a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fcf8yGuTMOj8WmYUrA3GgCLXjSiILOEG2FBiYi+G2ONmzjb5LMZUHNbXxv5MfM7kui0Rlbgc8iFxmzOKnuSopd4N+ulzSSr8VCNQfUdP8jLS9UGcGVwRreqylbmIqXuESfeunnv8Fw5t5P3Jbe705oPXCLh+2PFQgA3Rf1YhjEObEl8Q0v2C1/aF4N9DCa+fYzLZtqYqAc+2r/Rz9PXm4yve4FcKq0NhEm0i+oZ5bG/oUvq7PDEDtcAxjhOiYpLM4DS9MyejKvRfIMgs7AvfIAEJpHInmQJ0gP5TXbTRqk7CQ02DwUXHjns+zRi8OX/8SpqqfU01pp77P1fs3rYYpvAeoRdse4EYYoIo1Bmtzsl0TH+laQwHqETna1M1EkEj60Qr2QR8EcnZ4jGHB2NaKw0Y/TPySYeL9KM1IoTUTubYATpNXpktT15i+uMZVqpzhAasZ/wPfgIQbZjCKKpns82su9AmjdzS7Z/W9rrhtff87SdXuPDjaeM3u9+lWtXPGG5UCgeqYAEjrrZYwIcZP30ffAUNsCoxElihsyAPx0Bc/bQM+wRSL/lN4MNzjYDDLryfqdEdBEQB07a6sWqEs5jZFdskHdLHp+mCUm+mylY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8704.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(83380400001)(478600001)(86362001)(33656002)(36756003)(38100700002)(26005)(1076003)(2616005)(6512007)(66556008)(66476007)(2906002)(66946007)(6506007)(110136005)(316002)(54906003)(4326008)(8936002)(8676002)(5660300002)(6486002)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aEcLXZVJ0eMzUZ6f6V7GOcNjV/BNjvXgkQdUT3Uqj5o3n/OLMDHN71gh1FXm?=
 =?us-ascii?Q?RHWt02jgmQwDAHSx3F02S9WnssZRue6M7X0iZCm6PS7B0spQHNO9vAVt7Pg1?=
 =?us-ascii?Q?LC9bojWbkgN5e111JMtslGgS1XMENrTs99Tc/mFnx+/WQca2+LN+7aQaBV6T?=
 =?us-ascii?Q?j5+JadxFQHLpPqM2527c2GAFVwf85PVNzlx9sfe7QZ6z0zXwEdyth7Cj4bJ+?=
 =?us-ascii?Q?n4eNQgijrSc4kbcdD4LQJ2QR4vjWKv86XmF43QshStHMXPKzB5ddhA2TXMIF?=
 =?us-ascii?Q?I3mNHTkn4fq4QaleKKKEmizn6LZ86RXPz7Ww6vy70Wna/yF7nhPY2s9BGVIW?=
 =?us-ascii?Q?mlZVAq6Gq5Y8mr6WPL6WLvZFPHOPNRxN2oWarOJSiDkDNcTr2nJP1SGM3yYf?=
 =?us-ascii?Q?oH6J+a/+SRw4ZCJ5yeG8dzoLLH14MA0wJA16YRh97hi8cCUO2oPCg482VY+M?=
 =?us-ascii?Q?A/Wnd9Pju8GwsCMgsiOZGHepWUj8ADSKiSAFbiJHtTpNs2FBagJCemAwy3Ai?=
 =?us-ascii?Q?42GIPsDnra39faUhKbrN+LXbBlTX0dMz+S4TM6WQMJP/pplKebIDuFL8Xeza?=
 =?us-ascii?Q?EBJQl1SXbd1Z+B+pWW/QsGNz38QsnrUFMKpk+2FeRxmMrlW0rTbx0sxZ4Rlc?=
 =?us-ascii?Q?+D1tr4gLYkcYC/SVqCs/7cpLMQ5LCTZcTFomJslHhrXq4w4Yq94UXa/pZnM8?=
 =?us-ascii?Q?LNlvkha1SMMKw4DIjbUvjWAl+GoV3+5r0N+GImrWVZ+VO9DuXfpJ4dOsNV3h?=
 =?us-ascii?Q?Tm02kNZgwfe9QjelXmXevKMJwbkatHZBnjq3SbkopWYk2YX0Uaojpzweuu8G?=
 =?us-ascii?Q?w6RXZHCyigjoyQR+WMjBj3xnFHKHji5GYtM+SYyMeJ0REVE1MH5m24K0f+SH?=
 =?us-ascii?Q?Zhqf3IvVKPX3ceuzr54C7xui4tTCsL5QgQrTz6qKv35lSh4UOL2rOZbwQ2Gn?=
 =?us-ascii?Q?d2O8is8/Mcv7bJhbumVzCr8aXRBlNsFHZZQGN78xsrIZDzwlmRO2TU54iXTR?=
 =?us-ascii?Q?hwh1PkPBsuW8zdDEuUca2tNopVfSYh7UpVCvXsaTTT2fzRdTod6RUW82AMEf?=
 =?us-ascii?Q?khNtO/9nsc49NXFLM5kyA/uVK5fuJ0/U+tiKXI6zVWTTy7dhgYetKyyXw74x?=
 =?us-ascii?Q?0nYEDOV5l8l+w9v2TttvTppQWGwIUmwzyT8+EUGjletiB7j4YuN40G8vHRMr?=
 =?us-ascii?Q?1TLfQvs9tob+cksFn7YQC+Dfxhi1ywQ45uV3X0vD8guWLgSHhaDVtyvxXpsa?=
 =?us-ascii?Q?lJIg72jFlqYwxVA4Cv3ScGfvOJVn4v2PEzIGgZXQrwxKUsZcVZN/gC3mE1nt?=
 =?us-ascii?Q?orLOIzLSVxG31DS/wst2V2pEcLXY2Jz9jk2ykyW09Y/364JtM+XaNU32SwBr?=
 =?us-ascii?Q?n6HT8379Omf7nqckwYmWzufIve4ET8yQ19wUKfDy1cRHSdLLUNL/ygvzgUGN?=
 =?us-ascii?Q?OiF5lLT7i0PPPFFdIL/qQDRdiZlIONV21GlFHaknZ3iuK+YbbtWex0zYGiKt?=
 =?us-ascii?Q?O0uilsaz1v2Z7kFn7VQx+eNmEr98pIM1Qb1zIvZ4NIbvvjup/rOmIxdTeVLN?=
 =?us-ascii?Q?VEjmKd9xUfpGMMCttTRi/jaX+oHf1etjwdnHX32P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29958258-0b95-4f9c-7026-08dc1dae6a6b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 14:03:32.7641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4X30SBeogxeb5JK/hNcAIrrV40c/43j60rIwmibLAMB1oJCAoiwu5bEV6JjCIwV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7473

On Thu, Jan 25, 2024 at 09:55:46PM +0800, Yi Liu wrote:
> Hi Jason, Kevin,
> 
> Today, Intel iommu driver only tracks attached devices/iommus in the nested
> domain. While the nested parent domain does not.

Heh, I was just looking at this bug on my ARM implemention too :)

> This makes cache flush on nested parent domain be a nop if it's only
> used as parent.

Yep, this is wrong.

> 1) Do we want to allow unmap pages on nested parent domain? 

Yes. It is needed for memory unplug.

>    Today there is
>    no PRQ support on the nested parent domain (stage-2). That's why both
>    VFIO and IOMMUFD pins the page in the DMA_MAP. As a result, VMMs like
>    Qemu cannot not unamp pages in nested parent domain after VM is
>    running.

No, qemu can do an explicit unmap command to iommufd. PRQ is not relavent

> 2) If answer of 1) is yes. Should the owner of stage-1 be notified about
>    the unmap event on its nested parent, hence owner is able to flush the
>    corresponding stage-1 cache explicitly? 

No. We don't support "mdev" "access" operations on nests so there is
no reason to notify anyone. If qemu hot unplugs memory from a VM then
it should already have some idea that the VM is not doing DMA to that
memory.

> 3) Is it enough to fix this gap within iommu driver? or need to be handled
>    in the generic layer? e.g. let the iommufd layer to track stage-1 hwpts
>    in stage-2 hwpt. In this way, iommufd can flush stage-1 cache when
>    unmapping pages on stage-2.

I think the iommu driver should fix it

Notice there is also an ATC requirement here, when the nesting parent
changes it needs to issue a full ATC flush on PASID 0, not a range
flush.

Also notice the iommu probably has to zap the entire IOTLB for any
nesting child if the parent changes, unless it has amazing HW :)

It would be really awkward to try to lift this detail out of the
driver.

Lets add Suravee to be sure the AMD driver is aware of this detail
too.

My plan is to have the nesting attach add the device to the parent
domain's invalidation list and have a flag in the master_domain to
indicate this attachment has the special ATC invalidation.

This will allow the S2 to be used normally as well, eg for the
identity map.

Jason
