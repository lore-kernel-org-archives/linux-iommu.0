Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6145338D
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362098; cv=fail; b=l+UFNb4yI4NGED95nraZ4CsIOqI3E7Jq/cxGkQ1O5Zh0qhrAVIdlJSJxxnTqkaJEYJwHdIFyzvUElg9pVveNJ/CJNuQZBBs+XjJxNcozrDvvz10H16TEuYgdKH8YOUf2CVX6Pjxeq4inEdDgrH9bETaKJJc+nexUOWslgbc5oU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362098; c=relaxed/simple;
	bh=oOyNImsUvHxYsLysfq4stIJSCYrEFc0i1HXep3FPtfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s4z80pWR/gyEB+Gpnr/rrqyTx+MZGWjjj1jEzWKmbKnmjI/ChVBMPzPBlEARiYPpWideyvYDxbZG1in1HvxUUHZKjOE1rJ8tuoAVrPz51zy6SSEW8ttRy9RL7YyNdKTTRvsqXPJgXh4pP7PmuKOx/6uLWSmGwBIJIpoQdHuaXoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jhB764we; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jhB764we"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFpf6VK03kjpBqN0/R7/oroDanBzIb1qyCDhcXXpbJDr2vtdwrTOE13x5tlw2wiRvHVks9ihNssHqUYQJGY2Whfosm/bDIYNV9nApu/dEe6NIuU9mcMkaVq7Ugbw0E9YySG+seyGpLPBBHJjYAGgM3md2ORUDq23ushFfkt3fKAwZuZ2Il9hlIaBjTYl+oeVDNwvOBvB++o3AAH3npwbfDwlJgy0D0MMcAlFHauRKXy2XyR8frwGV8dMfYcWwvDtonXkPamFB3AG5Y5RTkWt6JtsGMtXik4qcqhcRHicK5kjWRvq85aUVrzC01wEq98Rwu1IU8AZi+z0nPdZ1JeJkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vm9Zznf44OguXJswHBJ7mgOP5pWVWXLB+XsSV3TG/LM=;
 b=Yiv1lt3+XSZhENmaPrBaWOw8CrFsOzunUGMtO6ZbR04YGzBdQeUVtkjem4+K1Ks8dbwGUywWmH3gMmT1mOS46nncj5L4jiNqzcJnM9XgFIX4qcxdi9JQISTs9wSPP+h2tAyqgCC2CgrrvOQHqv0td6aJlgDmXYIQOP8JG+1lYBPdmTPoWMBWuFfyTI/ip/z45OVGAmrKxhw+h95n617jmtAvBbqW55Nv3gvrz456t56zWZrc0ExCXCDLnupMIlOE9uRUuDuniw4M6hAQOc7YEoYB0RpVov6X78bkOIOtzGHUG7k300hKMv2tuDDSkEKAgNEB0wzI6B4uLdr+hW0QlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vm9Zznf44OguXJswHBJ7mgOP5pWVWXLB+XsSV3TG/LM=;
 b=jhB764weAfhANQaglJ/D9+gh18rI7bJE2Yk2rju3H3mgGEGm68p6Bapcs3DZnOoYj+VoPKYop8sYwkdUNSrD6VQ6awuDETLRJRdXFqUdTYvkQt7MP9H3fjONmjHMf0hZFsmlq/fvzBcIJkXI814HnfyMZ6uNbcCoox4mG0dYvdG5wWnAIuYRctrmOG1CBDLB5iAySJ9Bps/oHuQsQvJssVh/mHs1VOk5c8RH5RKI/uDiSC+UuiRYG+3spBB2fINXRGbTlZxRaC9d6laOqrWYwgLJKLOzOuW5h7UANYUy8zzQjSv1Kvwgrp0jZOf2zc1BJkHhYhi/R/beKNRMyzdrSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 14:48:13 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 14:48:13 +0000
Date: Thu, 26 Sep 2024 11:48:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH V2 2/9] iommufd: generalize iopt_pages address
Message-ID: <20240926144812.GA9417@nvidia.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-3-git-send-email-steven.sistare@oracle.com>
 <ZvMhqXo5MQ24xVND@Asurada-Nvidia>
 <20240925224322.GV9417@nvidia.com>
 <ZvSW+laS3t/16zEi@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvSW+laS3t/16zEi@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:208:239::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f577126-dd20-42ce-754d-08dcde3a3f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r1UoFU1X7oL5Dx++OE+en4l+gQHiTEVn0j4QqL/2ORStuL1UHKk5A2ssZbnc?=
 =?us-ascii?Q?7do425KNmQ29KUj/aqAS2LtgoUxzZY2ASO/icjtsdPemC+ozHXoMkYdoifnZ?=
 =?us-ascii?Q?GR1F8Z15SuxU9kogiNMsBj+JTfaJYHMmiUxeIHLnQC6x30gD8kb90oVCuuzK?=
 =?us-ascii?Q?1q52d4bSWJL/f4DCXUa3uHj5wAcapwrO+u6wfxXfzcQ4HThEkaaews0Ag3zP?=
 =?us-ascii?Q?Ws3SCLFUG1aZxJXKZAWUKEvHIvN4NMyBZ9UNLV1zuHyxYyc2UW+vYedh526B?=
 =?us-ascii?Q?VhWuC7sHKT6cqbpd8ApbzM5PrlvBUEniQt3laxsmBVe4vnS6FBh/d4NHDOD/?=
 =?us-ascii?Q?M9j8+dwTZpAV7AoG7iWOlqkw+9Dhu+gc7+NX7gO7Eccn93NtYtplfH433rWw?=
 =?us-ascii?Q?3jpVEbSBjXFdKhDTWeVR/SzQw5TCduO/ARgDb4x0VHPrdUn0Eg3dX5mW2JvH?=
 =?us-ascii?Q?CBVQCNn9ucGVWG7S0vN6A1B+N1wFx5b8YEr/35d1/9zZ1SasZ1ffxhjGDtEq?=
 =?us-ascii?Q?UH8Pbyg1qRjSv4fB4Eakf9+4j5NzDzg+rGQoS9yPM71GcHOSn3tfLkWROQ3f?=
 =?us-ascii?Q?flcHrHj/l3n7ePQnZMfeBx1QSszFC3TDwRlEp8szuFVS6VAhYj78AtqY1RD4?=
 =?us-ascii?Q?7XISD14Y8jWLGa4AEZUbKssRtZisXJQliVWbg+MDNIf9kOUYIsWUR1AWxMx4?=
 =?us-ascii?Q?sjzayOIqZxGLXqexxZv84Ml/V/99+r4eDaLsQIsYJkI6LbR09aiVby/XgyTI?=
 =?us-ascii?Q?wglqgea2j5mAb7ZLzMQAopv+gF+aUdNU+zqeGzwtenx+6BPfjAlkeHNcDdm+?=
 =?us-ascii?Q?MbzpHfZLGbPqTCszUb1u16t6oNqf+3UU6WPOco52yYpKXRTDrvZyC3aBFGMJ?=
 =?us-ascii?Q?XssoTSowG+pPGgDmt0qhv9Fg6dhQU8DRzbqxHCF6upw5nhH6e8WU3bVe+LF/?=
 =?us-ascii?Q?ES0O/z2fK4kVKVFuuLLxP3drqRByyG9GVi4GAj1iu8YOEs0wfv7RySExcSbl?=
 =?us-ascii?Q?TrSwSb9g48tpIqwoh1w1WX0uqSNvMpoDs00Kt+sMOutjKO1x55WHmV1IIfIK?=
 =?us-ascii?Q?Mwi/jYanSRC2qEXwkBcqWeTiu957TFSm6u8yb3xUeyJzIXGyLgKFAs/YF2SG?=
 =?us-ascii?Q?4QKgbN2ZmyrKNp9hZRIDKrq9sz6GyhLy8M8yVMvZc0isVwmGOMGgYJpaLejT?=
 =?us-ascii?Q?Ed46d05AjxcgoLO++BtM/kGVOltSJYbuRdA7TgAJ7OwfqC23YRJgvF+JPtdA?=
 =?us-ascii?Q?JsFttOHIg32gy705pQRjlnS6Pj8COrxGlBKNIezSc9KgrnxpbLi8PC+WH8CM?=
 =?us-ascii?Q?zb7SlqnPARr690UQBA8ZBWJzlJvZC6BT+L4nNdpu9W40aQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TjS+mDPC0nUyJkfKaf0ZbPb/bgY526KqB4q3HmBvqXa+cCPMd8/TJjvIhAqS?=
 =?us-ascii?Q?2+1Rxa38/gbwNw3JvrHpGx38u0kUm7PSJOH/wbfVKORrHFzh85Olc/+KBE5v?=
 =?us-ascii?Q?n8ZOUe2JawT7LgZho1SOuPb5uF1j+V0CsC9q+x2UcDluujXgYCen8TJPor/X?=
 =?us-ascii?Q?HHcFe+b2w7zXZf21pukHeMxVACasQUwOdLi6g9Z76chEBT4KlEXTDifEOnUb?=
 =?us-ascii?Q?3jrcoot4Fy+/ZdeQjvI5ufEefn3hoRkUdRjuf/SDtVmMrGHg9aRgDaKLZDOu?=
 =?us-ascii?Q?cG4S4mkREg7K3qJgLzk3WASv6zUqMt1S1KNRdi375/1XaOAlsUMnLxaUkjZg?=
 =?us-ascii?Q?1Vnbj1QyZyxhrhjIPodDAeLqUB47E3vrU9o68IElLNvbIly1HkO3wKH6EF7l?=
 =?us-ascii?Q?mEnTlYiewoCVgUOJ6534tUG6zS8mGMQhBPi82fWUx3IIoldlEMtKqF2Zodz/?=
 =?us-ascii?Q?wRW4XrK3dV0C2CNPwRF4MrwGWI7SuT/CtHGygd2Rk+BUdIkI2qYUbcikJci2?=
 =?us-ascii?Q?pu0AuYXBm1wJrWlHwmFGERTdGycZvvrA7dkra0WZOjqcPIJCzGnQ7yVHVHeA?=
 =?us-ascii?Q?6BRhlnhHhVl3pmBiatHCWVR4UMLjrl8zREgCn/+qDvbSWn8fuEiWWvSrXRtp?=
 =?us-ascii?Q?lLLMvX+O1lQ3psC8mSdw8KAp+DDlg69Sf+6foxUryzgs5Ubb9TOuNXU0hMrC?=
 =?us-ascii?Q?P21Mj55iD0ey+8l3D3Nxhd3YDSLVhkVJZptuUKio0s7LgTwCJsZ6GO/WhVk5?=
 =?us-ascii?Q?C8o/ypBGTNL7AEPq7NfOGMipZyc1elWH5qwg1JCGbfVsUn4QbEiQVvl1DiNN?=
 =?us-ascii?Q?CcGIRyR1nsxhj/zD6+2RsIBPa2mqUM0cNamuteCk3O+lPv2aGxvQD2FxNjT4?=
 =?us-ascii?Q?0Ubh5WBT8nJz0SlRbIpyTHy2Su0IehT8/ZH+FRnj/MpsSPXS9LsNSZa4YCt5?=
 =?us-ascii?Q?5atDmBNc2sE0r0PSt5f4VErZArHc3Zw8qAL+xiOLT05VE3jL86cGDoEjkilW?=
 =?us-ascii?Q?6ayJ0jNXPiQwHaqvA0WWOd9UmvjTx8Hkn3+0aGu0AZ23ocHUOusfZBeIZk+Z?=
 =?us-ascii?Q?GOA/nUKEQKMH32JXAD22IjqNO7R13O2qKupjaTBFKkDS/90SP/Y1x5x6axo9?=
 =?us-ascii?Q?u6s9UNUh1UdpcvuFQifniauDMmAAHIRpG/UuP87NrBE6YYBr4R+cnsSOP1ue?=
 =?us-ascii?Q?ijnc5IZCCSG9RFBQ81A3m1wGWQQ15avWLjWlIHpIm0Op5EoDPxjtJLnKz8JT?=
 =?us-ascii?Q?8gl72YYqfn6XG+1XBq2W0u20Anncl0/Mh6/nSKyfdKlGcOzvbpyn5p6dswNT?=
 =?us-ascii?Q?U22PNhyDGGNMlU0Xsaep5u7mhbvONylDuOLA9RSfHqa03MllZ24HBw7c8W1d?=
 =?us-ascii?Q?A5S56Ab6BWYLpHTRg0eREjWN8hraw9h/PQpkoCigynL98kjj47uBiOGs2gE3?=
 =?us-ascii?Q?2TenSVY9Vvvr4ypE/hLRu3Q+jVTPTFHnDx2ouVSga/lqGAF5V81TFzjZtc01?=
 =?us-ascii?Q?XpZJUUlBy7wXzrJHnfM5HTePSWFBWMOmYnumFAMCcTj/wcUjTBCvl8vJb3ZT?=
 =?us-ascii?Q?9jkjzt8++XZUI0DD2NM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f577126-dd20-42ce-754d-08dcde3a3f62
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 14:48:13.4397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQTdyhCsfW03mmHNFMOdMatmt1mn263sow052omb+6iG2uq6THL+ut7qbqkJctw2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6087

On Wed, Sep 25, 2024 at 04:04:26PM -0700, Nicolin Chen wrote:
> On Wed, Sep 25, 2024 at 07:43:22PM -0300, Jason Gunthorpe wrote:
> > On Tue, Sep 24, 2024 at 01:31:37PM -0700, Nicolin Chen wrote:
> > > On Tue, Sep 24, 2024 at 08:05:31AM -0700, Steve Sistare wrote:
> > > > +static int iopt_map_common(struct iommufd_ctx *ictx,
> > > > +			     struct io_pagetable *iopt,
> > > > +                          struct iopt_pages *pages,
> > > > +                          unsigned long *iova,
> > > > +                          unsigned long length,
> > > > +                          unsigned long start_byte,
> > > > +                          int iommu_prot,
> > > > +                          unsigned int flags)
> > > 
> > > I think we should follow the existing coding style by combining
> > > lines that could fit within 80 characters each.
> > 
> > To make life easy the "coding style" is mostly whatever clang-format
> > spits out. "git clang-format HEAD^!" for instance will adjust the
> > current patch.
> 
> I see. That's useful. What's that exclamation mark at the end for?

Manual page git-rev-parse(1)

REVISION RANGE SUMMARY

       <rev>^!, e.g. HEAD^!
           A suffix ^ followed by an exclamation mark is the same as giving commit <rev> and all its parents prefixed with ^
           to exclude them (and their ancestors).

It is the syntax to make a range that includes only a single commit (HEAD).

Though HEAD^ probably makes more sense since it is computing a diff
from an absolute point.

Jason
