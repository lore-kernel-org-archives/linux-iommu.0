Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1576B37289C
	for <iommu@lists.linux.dev>; Tue, 26 Aug 2025 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234146; cv=fail; b=R2OkFmA+rxRXXbR18oSjtG5RgrYuvcRWDv+n0kcR39rIvfkSCN9lJEmJBpraWoZSI2+l5vUr3tUKT4ucVp5/8TqcUfEpsD+pZhrJ6v/blr0RVrO7nYnHDcBu/HA6UyHflfofWSH27aFQ3KG+E9CLtjTi1DMBO7ld9LUTQpvL3aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234146; c=relaxed/simple;
	bh=co4YQo+QwwhhvU6FZMk2X0+9D/pm65EF79fnTwL36G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JYyH6J44UShDsZN1SNkZnu3wF663b7tcAExIssRmuVFzj7IH+TibqA3Tvc+KUCumZS5Q1ct9i9jB5hnnLZeQ7Oe/FOwhWUvBxrM0sdkFBArO1gCigXnOpaLZiez/M07yIbzGwUAZPD3xgPw106pJJIdyvim9gEuoaedN6MJ/2kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k6pZyxn+; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k6pZyxn+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBi3yZL7Aspf5aAqT9mjPmnl9b4nbXqXEXwpojweTT8qkBx7dWS8tiTuwxQIoJPTgnYPBCb5fNJUYUmomDNE5hxSzvvMsAJfpzEPo6F4OJ6XwhgqNFvius7FN2g5j9E1/XT6BjXcSQBWnRfLxUVrdg+SV/d0O7EKbTUib5xObyZzvdkymC7r5CYNdstb/68Tfvx4crKxv4MnLFZ8p4Yoc8zCIOIKCv9tlrUQuvT6rHyWvnCa/0Edze30nVaGuTx/fuvV+cJyPD1UCC8P1Mwr1h1eJCA91bv3jbdbeW/cDgMENGg2JH1fyhdNgGDZEB9Cq+16Kdr94U3c3JfW7/tuMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLlGNFQnZxmeJCEa3V/5v5E2uArzELWTPTAB731kUvQ=;
 b=X9vRcZpDJ+dz5VR+88+r6/McDo0pG/i2PMzlw/7pV2g1+vIdrMrQDiad8029t2ZLpsyGgSjQtEGu3zWpVzW0kz1PcOV/SiLBMUDldfMP/Yz2EwCssCgXxuDL/XVzrC315Q7nSG8JlLYVSLK0tJA6KGs+07WGo4yV8tB88SytJnU4JAjougBtt32hV8jvLsCLTWGdPkuErN60gje4HMpk/mME13/2SWxi9RRwU/W9mZViF5Cw7rvRRFdVe+08eUUYBnijYA6uLUn4/dx7egtfvJdXc9A1ToTx+FgyiMXTPgru1C3eSZpKqtcd+pnGn22w099ikTlYD/LyZBEepKKmRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLlGNFQnZxmeJCEa3V/5v5E2uArzELWTPTAB731kUvQ=;
 b=k6pZyxn+0j8H+SUOYcbcbztDxelFqs7+j5J3jPwcLwyYaATJdOMcJhAz73hYWQ0L3wlb7YufbeSmYALq2kxVuxMsesUYkW9UBa7RY4m45q3T1796qOxUuS+lrTp0zgYPGA0TuITbH8KP9ONCJyHTJMZ925Xhdf/rUKpZicbG8rDe5fTvZzbdqm+SBHAd+faZmHHE/IPcuG7+LP8NUxtBiXYqEHEO26Hlwi7RmJxNMhSPNXO1NZFRxK2ZWScb3Fo0owqdaTRdr06dlQYgi0b8xRFPSbeNDk+RKLGw5NKL3q/ADmyMRXwNXyThX3v3MuoMEEm5lisTz3yTTQ1c+yX9ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 26 Aug
 2025 18:49:01 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 18:49:00 +0000
Date: Tue, 26 Aug 2025 15:48:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jon.grimm@amd.com,
	prashanthpra@google.com, wvw@google.com, wnliu@google.com,
	gptran@google.com, kpsingh@google.com
Subject: Re: [PATCH] iommu/amd: Add support for hw_info for iommu capability
 query
Message-ID: <20250826184858.GI2130239@nvidia.com>
References: <20250820042533.5962-1-suravee.suthikulpanit@amd.com>
 <20250825134420.GB1970008@nvidia.com>
 <85c544d7-b274-4696-9fc0-829033eaccaa@amd.com>
 <20250826175813.GH2130239@nvidia.com>
 <a4260493-9f75-4446-ad01-61556ed8e034@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4260493-9f75-4446-ad01-61556ed8e034@amd.com>
X-ClientProxiedBy: SJ0PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::6) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2005be-0b56-43c8-7fc8-08dde4d1381f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eH6lcLNCuH+gAFfAP1OUc7k/fjkqB8NoCjJjGCnWfFwPMiaVRaCgNQcOjAje?=
 =?us-ascii?Q?j86s5oV9pPMKVvUKQ2tYMwtONC2t1fRlJ9EqXeAjlS3qFt572f/Kn/RBTVaE?=
 =?us-ascii?Q?S+b+TUAWKws6lykU6PfCV0EmcXL2XbnC33dysmAqMk+fWIvIRsjbMjXTQKDG?=
 =?us-ascii?Q?1Oq7D1vi25MiQ+hqeErwLGf6RDWbPCM04gvWtSmy1S+Es/9Dvx0O+Mtulvt4?=
 =?us-ascii?Q?iK3zwADChFDL66E7LCVBf4Stg0XvgUraXf8Hqk8JLfJroKr1iyTnAbKHd8bY?=
 =?us-ascii?Q?qzN+gx/kNThn/xLc/Js9m1W/h06Ceqv4oIjYI2ctM++MIOeEj8Ik61CQ2Ppc?=
 =?us-ascii?Q?UmBWdLKKgqXW23jX+hFuszJq9AMzq0CP+MULrlKpstYqM1Q7qzqsnRDh/3bn?=
 =?us-ascii?Q?VzIGkz90BDTIjqYy/aqP4/9KKLMYhKZyleDL1AYeTs2Kfz634erImeOYW4fh?=
 =?us-ascii?Q?dw/qiinpZ+spJIP0DHjbR8tp3igXEzQICoX45VdVBZs9/ExHCz+HJww1nvKI?=
 =?us-ascii?Q?HD//r1YTyHdUkSqPvewynF4qnyAk6IeQMsBqZV0HVROjkqR69HPZ35IbR1Il?=
 =?us-ascii?Q?CSxMOK1/wYKzX3+cf36UIbOHHOAyaJae1GP9x0zlV/MTbE/YvaRvKfycdB2H?=
 =?us-ascii?Q?Bahj3cKKocRIchTkOjXhEGH91zJiaJQOlnD260Njv3zGXuPOTzzr/tV/ml40?=
 =?us-ascii?Q?g5ErGZAHO24RTTq2FTSn+l0E03mU9B3KT29rdBFS5aRdXklEYC9OrykyW7YR?=
 =?us-ascii?Q?gl1kQt5AufX1NuL+se7mNOo3SjlL7jBeuL/0YLtzgCtQBP0zXaiiKfoU3cn1?=
 =?us-ascii?Q?2WmogfO9Pg6/74hDPxCaQ+xMOu7Iac1uG4tnXQT4pmRINO36oKlJiBv7wuc5?=
 =?us-ascii?Q?9kvBWHKZbcJI7eCPqa6xskL2FZhK4xAYGgHvIYwk5SObxgbQr1Rx0EYhwwAs?=
 =?us-ascii?Q?yDoJmSY5d5fDzWmCpFiVnRHcJGFAfIwQnywIhn8Dot45sheLG1jWCbVDSWDt?=
 =?us-ascii?Q?7wTBu+CCLO6oN2kqz+wLcZ0KltfVZp6TUnys064iBcVv6kMNmbrCATbDxor7?=
 =?us-ascii?Q?awwL/DbwPPHMs5Xmgp8qOxVAisHXYf9JHV1NnwHz55wj/zSy9geJ11xQCiYz?=
 =?us-ascii?Q?3WA2tLFch9vtK9MGPG7M/D8jL9s8bKQPr18yIRWfMoIJDT9kG2aQVOf74qdS?=
 =?us-ascii?Q?DpWdU31W1aX00VLQS+S1nxg/qqcSUUgeLyxFpm7Q30ZxnV0v3LRvxBbpghuu?=
 =?us-ascii?Q?YewaBR2NcrEx+ZxzHda3RMCsHG83VyFziPoLFNsfl4GZXTN/Tj10P3JrBZuM?=
 =?us-ascii?Q?8j4iI5KWpUG9/1dP5AJRB/+dE4HzoqJ/wxz3hJFKI2grR1k94tvNT/4I8MvX?=
 =?us-ascii?Q?6HihVCl0qAlINLeJzwSFtF0qzX3F+zKJc9o+5ygoT8tUH0RByg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u35K+AxZvfWU/jNjjq2sNd2bEBNAkdbyh8lNFLqzt9CkeyHm+pqL/L0YHReL?=
 =?us-ascii?Q?lGx8U4a8eKfWMl+APAKXODYTDCtv3TkLsB1YlZ+cnPZhxGuTTN4k0kMGfnFu?=
 =?us-ascii?Q?5aZZ3W7t4p2gFB7FnH6lKlsBpJo91UJnxUbBemy6AZdOSWXE4566AKAKFTyS?=
 =?us-ascii?Q?cLU39ESsJOPGpgfG6BwtzI+HX1gwv9ZyylVyDep9hji8FRQn+eDGi+Lcu5Lm?=
 =?us-ascii?Q?aJQRFPp4p+nvFCt6gKlJ68Ka7cpJNWVd4SCmN7kSBB//eRJfdCHdgcLa8HS0?=
 =?us-ascii?Q?k66myVTtnOnVq075jIwy0Kgi4AaJyOsSLTWOgp+fVWaHVoigeoQdYssa3kRa?=
 =?us-ascii?Q?FIMMj7ONQcI5HuGc4DlLV/OiBsi3JqB027lLQMSLbgZkMpI88Kdlr70ZOWpP?=
 =?us-ascii?Q?a8RXO9c3yjdb5BcCeZR6rZ3wQvOX1GGYbF7XHlJImm2vHMt5Knwko2UTM1OE?=
 =?us-ascii?Q?3BsXLU91d5zlNV9cRmLDpV9izDC6QD2U8jZgGqHPcDvq18RVkh5Zs3Gkk5T1?=
 =?us-ascii?Q?1pFDASnCjzJAjhr6HNkIwobqy9QnjRhEibkzykUxkrIqB1WT++deumTfZvR5?=
 =?us-ascii?Q?ETVCxfmVMq5/oBxR79wUG5vzDCcnMtiP6nByUunsNmZSxmlXPXiFrffcfPEa?=
 =?us-ascii?Q?+wioyHexlbaX1Q5LwyLbBs1C1wPVRllwZhyC7Msq5/Fwm2QE3Uaz5g8ss/PQ?=
 =?us-ascii?Q?j2IlK0y0AiyUYFiH/NTQ/moVb5NJJ28O2WI3lQxIRGBypdYnthQ/fwqr9+8h?=
 =?us-ascii?Q?vlcNObQrWrnGcZov02fh+jshtpedrVXFEkp6S9F3f3lJ6ogqidDBuZY+YKWk?=
 =?us-ascii?Q?WBgEYZvShGXdYt7/ALdAAFveVzAQ0YiUyHVjF4y+IkXpzRJTNoGYr12in+6g?=
 =?us-ascii?Q?pL/cwGyi6THWmk++Zyu3Keb/vpWWx/qvlOcrMxd8aaaQRwOZGK3t8jY0tflr?=
 =?us-ascii?Q?9ro4ReqI5ivlcEnuRqUByJlcc83gbMkkd6EzZpMGV0M1ObSTLXNJNUcNs3Si?=
 =?us-ascii?Q?cZrw/UZX1+nHWiuC/M2g3PuOmyBxXUMfEZ9ILOD3PHcBN8IXIjU6sy7/EP3f?=
 =?us-ascii?Q?/9P46hxjeUaQkdNuRyEq0snievYKmJ3/hR01PffyxyBcNGmgWDPMyCZ2LVfR?=
 =?us-ascii?Q?wULcSJmLwAGXUGVmSOLBvv3dXhwec1mqyRGm/9V+f/m63cHxIUFouuL88+qD?=
 =?us-ascii?Q?FtswLJBqHVM9d5Tk2x09nBLZxOEMR/N39hHrcrX6aLSjjgONKR4YEkq9UD2u?=
 =?us-ascii?Q?8gcGs6NNE/aJefW5Kh6Ce4Qvpsem13EvXsVoA4w/B/rYbh2X1gOToXAz56M+?=
 =?us-ascii?Q?/ToVs4aQXqOX/Bowfc47fSHDCXkDwvFDMhxEmLYFCD0G3i4uTgZ9/Po+XbCJ?=
 =?us-ascii?Q?Y4RMLAB4ei3HdzbedSFzGDibizAUKYNObsMHnsCt3Yfu20Fj9SB+HTIeQC/D?=
 =?us-ascii?Q?7sw4y3S+cVaOct+xJGr661RDzIfGvT4IqzOvfpht2tUWcqCdaHA7xC6oraDe?=
 =?us-ascii?Q?yn+cqZxjkKJtos7u6Kd3r0iBFsM1St1oQiDjpUIG7znSk2/f4G5mb+JG3KFI?=
 =?us-ascii?Q?kLE0Iwo9xA6euAkTjfLRvFMfm9njX8XOND/mrhGp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2005be-0b56-43c8-7fc8-08dde4d1381f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 18:48:59.9230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7w6zclgF8U+bzaW+9F44oyfONZQSX474rC+1mPLssu3f+h70q62F8tgZz99qquU6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484

On Tue, Aug 26, 2025 at 01:43:59PM -0500, Suthikulpanit, Suravee wrote:
> 
> 
> On 8/26/2025 12:58 PM, Jason Gunthorpe wrote:
> > On Tue, Aug 26, 2025 at 12:36:23PM -0500, Suthikulpanit, Suravee wrote:
> > > > I think you should probably just pass the raw HW value through and
> > > > require the VMM to figure out what bits it needs based on feature
> > > > flags elsewhere.
> > > 
> > > The problem is some of the features are virtualized by hardware, which needs
> > > enabling from the Linux AMD IOMMU driver. We cannot just provide all flags
> > > since VMM would not know if the kernel has the support enabled.
> > 
> > The VMM is not supposed to forward these flags as-is! It is sort of
> > some kind of maximum what the underlying HW can support.
> > 
> > If you forward as-is then the VMM will forward broken flags it doesn't
> > support when the kernel gets updated, that isn't OK.
> 
> I got this part. That's why we mask out unsupported feature flags before
> returning the EFR/EFR2 to the VMM.

The kernel can't do anything on behalf of the VMM, it doesn't know
what the VMM even supports emulating.

The VMM alone is responsible to build the efr/efr2 values. The VMM may
choose to copy only some bits from the kernel, but only if it knows it
can support whatever it is copying.

> > Each and every feature the VMM wants to show in the EFR has to figured
> > out on its own if it can be supported based on other kernel features.
> > 
> > The utility of the get_info return is for HW features that don't
> > require any special kernel enablement.
> 
> Not sure if I got this part. Are you referring to the struct
> vfio_iommu_type1_info and vfio_iommu_type1_get_info()?

Sorry hw_info.

Jason
