Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4CE3AD505
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773315886; cv=fail; b=HYnM5B3vVhNA41Yxj8ls0mDEPa5FVU1AJU3maN4QjNgVb1HNLR/YYdidDAqop+s7VdoTm+vkLoESy/NWu+vXq6qzigKN6h394GvQo3iEMWtN7JLMKYz+qkrSUQtoWqV3ZJgNocp2o1YIEKu8j9LAxQvRleHmsQYFf7esOh0JWzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773315886; c=relaxed/simple;
	bh=wxdqHhhsPqkkYKts6QXQdukiblmEzeQK4XUoJKF7d6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tfZBh/1oSEYDB/jTfWjd0AA5C4V1jXQsAsMIEbEyycfWK1fCFSOwNEhF06oGFqtgFcebTvbDkTCKKrOx2/W6f+YMEnAb1C8EpdLfjAjrh6i5cq2Jhhz4IkvJJbxsEDq4/44o6R0YkCZgSnmb9c59d6S9vwgGvOhayGnqhszQchQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i0ae+A1c; arc=fail smtp.client-ip=52.101.52.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i0ae+A1c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyizwgLZwHf1jEx+GHMKLUBXEGUAAedr6wXKHmUOB7pgiovE6Fl3epP3ETrZGEL4TOPkBQRS23hpmp18v7FSFCVj/eu761oCoCnanPWfCCbthTPEdSwG63VSS4MXhpY56h/FdphcE1D9jk0iFmEIkdnYFpq/Kmg21Z2PcLKZeqvf3T/cxMDXfxgejmIsM/AXRKoXa3uoc8kMX4iOpQjxpzKcPXvFSVFd+Pd2zE6//876FX7BUnDP0CYN1Af7RGUGKC5KbgfoNYctZo6LIqkjF/kKObT6wknkuS5slleaChGEBwXbNPCX0EBecXF1pW9rm58qt7FoJZJ+Fjo0Oro+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NavJ1/6jwMlcWGH2Ty4yPwRU8MH+aKZD62eGg4XWLY=;
 b=Vz3iZzCT6CfH3Vx6DmtNqNASao8CIyVvbcesr9AdFcr0DahkEXzWV+xo86wigEvQUAFi/UTm745/O2QaxMd3Pj50gyBghqX16GJXQQAVxBCWixH9JhybW4OeFHk8GyguwwZw/tnpGRZ5LxAbtIyjUDGmvoOqfczvnYYw3ZlVfDyHwlhttao0GB3QaMVDveI0szjD7+edcidruAfvjyyWnkvan/DxmQLqx/RvZGIyYJymAIvpvQ3yhx2VBENHm0TaCApcDzSGzcFd3nkgph9RLhgeKIsAmwTBMkpNR0agXhslF6+/7qAx2Rmydpm7ZrSwf1vvuL0hX9Zf7j7iojhC7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NavJ1/6jwMlcWGH2Ty4yPwRU8MH+aKZD62eGg4XWLY=;
 b=i0ae+A1cuEMuIn4ScjKowbwqy7IM+4o2nJWO8qoMHNjH0xWZCtp8ozNlDNDf7fJaOtFkyMnvldQ9s7IEMydJnJNrr20pjPUPHmlrzMjEzkS5Gf1nGcoegdL3YC/HHNJQya7W2w5ilisQshFmz+edAzS9SVjAGEr0ONZLKbs8U2uNHY+AZ7ioAkDuWTMCxShEWxY1sMbntTwYhXpc5WSXXzQN6jwReZo4E3yXGtevENbv8IakqstWXr4kwgkpwIAqqtBFFcZORICY9QeYqSUJaaBVVpjIOCF0rEuKNf8TCVdY2ehSRbbFihEE1VVViuENZMsLCkLM5W2tvR8AqwpxtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS5PPF5C5D42165.namprd12.prod.outlook.com (2603:10b6:f:fc00::64f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 11:44:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 12 Mar 2026
 11:44:39 +0000
Date: Thu, 12 Mar 2026 08:44:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>,
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] iommu/vt-d: Add entry_sync support for PASID entry
 updates
Message-ID: <20260312114438.GG1448102@nvidia.com>
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-3-baolu.lu@linux.intel.com>
 <20260309134116.GE3717316@nvidia.com>
 <4fbe6dcf-1105-4efc-b755-81a5bfb74090@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fbe6dcf-1105-4efc-b755-81a5bfb74090@linux.intel.com>
X-ClientProxiedBy: MN0P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::34) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS5PPF5C5D42165:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c376c27-7fdd-4edd-d611-08de802cbe4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Lrd6VfKYhzku8c8ZdN4AzroWA26rpz7uqu85C5GfiN8+WS78vbkW5w/oFQjvQk8nGJPHUgt3NxXNy9wetZifk7IXdFeWz3csPYvt2fc1Tr4g+p5Kj+kZZUD/iJkAR4P4QwNz3Gu0bcrKF0WGs53Uc5Eebjdo/mFN9jqvN6E51FClb6OqYVsGhUWPMGDAjh8Ryip3KLta2J4BX9+cfBM4kesDoy+I39lLtjZT3eAfHoG+Ln1jYsO5RS+29kxGsf+I1J4qN540wkp4k8/x/vzPno5Hyh2/fznHFFMwMGbCNyxwBx8bSSGccL6wS1CasNamI4fUFm56QxBXNF6SA3qvtuonVvWDr6RYQ9FqfR4mdYuSrHTAhmVY2gGx8sXpkQ7wx5lSJVETFmdIKsPqYSKfIde6JqZSMWdd9UIIzNVJwvICAlbVB4P2fYZKQA6sx32muPxczHfoQ7/mvaJkvnPJ3Ta/aait74+ed/WB+Da8GwE2us8/8KRInTs7i5tz7cfRaeyUrCV20ViNBmR1mrDz3oSMqahbxbiTU9qxX2oAqJommrhyIMMnwPrJetbYQb+nxllrw32vFzZK4t+N/lkbF65xxemqO3m40IyWD+Lmp+CW9n6rtno9JoskEBzeUh6TIsQRIimSRoemW2T9D6c6bNinAGs9ygU/p5eoczfOCt5lNWySP3Ch3b44J2otlKDJ3FKLjQKtA/cKsNaI9WWJ/+1EGaUeFCUU8xv0QL480N4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VFBKGxDTS4VjwzFjjhEmt3FWpFPSFXLnpwcoNKRmwQy7nlrjUlLzXL5Rmvzz?=
 =?us-ascii?Q?hxmBFe+CNhCmljcQz8qPI9hp3d8IJzmqMMBayZm8gJZ/Fwyh4x0AwtVTZCMM?=
 =?us-ascii?Q?W2G1+QJbFtCw4+FrdJYJ2HXkNLqyb2tRlcKM71EW74s5oCaAElsxG9vLimwu?=
 =?us-ascii?Q?yczu347TP6ZAjN2eED0kTM16X4c0AN52IJwrDgfDUaNtx9QkegN27FxOxBmv?=
 =?us-ascii?Q?xRWD9oHsjVd3wIrwwSLDNp9a1vacv4LAD9MxoRj8hzPod+0VIZ2TiEoYN+VY?=
 =?us-ascii?Q?n8qPtd/ZYBoqMH34c3aBVYDlAXKlCyyaW140IlJ54XRseb5zjsV2YiydvUGa?=
 =?us-ascii?Q?2Y19HKb9dqt/qmvD8yn/ydNcWPaSFM74VXF0kRZ7J/Irg/sALTJJXU1/3e9n?=
 =?us-ascii?Q?G54Z39lJ+sbNvQvdgkfjAw3ZPRxuKQPNuSspULH7TVf93JdQr/eqzZt9Y/V4?=
 =?us-ascii?Q?A+wX06vq9sguHUQbFfyBlFauEai0/RS53Wk//SR27TbhcBPKENjR+O+e8e37?=
 =?us-ascii?Q?s9+xACTV/X49OeZ6DboxUULIc4kMr6sd/r4sb3QdsOWnH5Uf3L+pz/w6nECu?=
 =?us-ascii?Q?H9xUaqkPu+A7rOYY2Job/kFhJpb0EF5UaPcHLqIPXc34lfII0SvXVST4gQaR?=
 =?us-ascii?Q?k/0J5NYKmXKFDQpTYZ5+wTpbWMPQsCwgyNRr4erobldKbbx4Ozi0BCyIsoyz?=
 =?us-ascii?Q?SvjalIgCKXGhOIVvocYE2jtQCbTGsbYK22nQcktm0CxI0cdc7M/PrROnIOWk?=
 =?us-ascii?Q?aFlCS4fJcXfBA6Qxv++E69zA6dOYnZaHSqqVMPtgvYfsGzyYJXd4Ex0wCljD?=
 =?us-ascii?Q?W3NfnA7UfIjVaiR1UrLqh/FnrGbElQwy2YhQaZpYWn1RftzxLQvSqwaZdkrb?=
 =?us-ascii?Q?VCOmzSm2DQi/3RydVfHok6vEYxEbeDTmDEEEULvKoG4K6IZPt8xTsWmM0E9B?=
 =?us-ascii?Q?JM7BSaEDQJwlFLCtR7wi3OF/EQvtCrMo+Ke25LH2mmunKqy727nYJKME29VA?=
 =?us-ascii?Q?IBlE8ZqQDs3Kupb96mssnT9SwgCKrBTARWYGKHJN1MIvhuop4p4LPJ6fk/Zw?=
 =?us-ascii?Q?OKt5V0y0QavzYOKNykwdg1OPyd1oA+DaPCaokVzTWV0EYIiKSrQ8VZ59R4Hy?=
 =?us-ascii?Q?vnH2ZZ7+QDM41F3VYV6GdqlWemLSFnXLehyZpjiV/NDwFWzLNhD6a43Pe//+?=
 =?us-ascii?Q?ZqnFaU7lCMAXTC/oavrE2VQJsIcAoIuCcEdb1tGEQx+yE47IicBYohbwzTbZ?=
 =?us-ascii?Q?Xz4fAylMBd3lah+8X7XM/HVW0TIMBYadGp3h89hJl6anHTC/YdtfkD3hLefg?=
 =?us-ascii?Q?KZSLnvsvHaU9wWO6mjsAWcbrC4Dxp1U6BSNGW5XTnJh/3TPQMmEXjqNdtCC+?=
 =?us-ascii?Q?lnhmJptucF+dpf+oFz4LEHVkWfaXpSL0QPe73PpF9vbp4+hr38seDtTIeZ50?=
 =?us-ascii?Q?tf0Y10ztaNDI898T2KS+rzHQOc01qk9jC7uGkVBDMKZhhcARE4rnock5phv9?=
 =?us-ascii?Q?gPZNTpZCFWzDqXPv+Q9JdaTNxQTzovDXuP+FgDWjFup6StXNgITZxo2k7QvO?=
 =?us-ascii?Q?wDhV/+gvHysM/QvI4kX48E4Oh8qNK13rmVcx0w+Q5rCa81Ih8BwwQyGxQQKh?=
 =?us-ascii?Q?BSQ1Jb0aLMjd0JwUJABBVYtuLRzzDxOC7yY7XjiW4FhElbAilUNegblfvcZu?=
 =?us-ascii?Q?hlq6f6YYssKniNFiYPeD3+MGEfYggcmLdb/6MbncWLL4XzI0u8e/p8rhNuCa?=
 =?us-ascii?Q?jUjx7OeMHw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c376c27-7fdd-4edd-d611-08de802cbe4c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 11:44:39.5393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2ZMUP0kHjFpZoK6cFsLMFhdeZlWZYWWJeKnhj4nVrGcFykFSlYoybAFO0PPkgqr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5C5D42165

On Thu, Mar 12, 2026 at 03:50:03PM +0800, Baolu Lu wrote:
> If I understand your remark correctly, the driver should only need the
> following in the sync callback:
> 
> - clflush (if non-coherent) to ensure the entry is in physical memory.
> - PASID cache invalidation to force the hardware to re-read the entry.

Yes

> - Device-TLB invalidation to drop local device caches.

I have prefered to keep this outside the entry_set system since it has
nothing to do with updating the context entry.

There should be only one ATS flush after the new entry is installed.

> > ATC invalidations should always be done after the PASID entry is
> > written. During a hitless update both translations are unpredictably
> > combined, this is unavoidable and OK.
> 
> The VT-d spec (Sections 6.5.2.5 and 6.5.2.6) explicitly mandates that an
> IOTLB invalidation must precede the Device-TLB invalidation. If we only
> do the device-TLB invalidation in the sync callback, we risk the device
> re-fetching a stale translation from the IOMMU's internal IOTLB.

It is a little weird that is says that, that is worth checking into.

The other text is clear that the IOTLB is cached by DID,PASID only, so
if the new PASID entry has a DID,PASID which is already coherent in
the IOTLB it should not need any IOTLB flushing.

ie flushing the PASID table should immediately change any ATC fetches
from using DID,old_PASID to DID,new_PASID.

If there is some issue where the PASID flush doesn't fence everything
(ie an ATC fetch of DID,old_PASID can be passed by an ATC invalidation)
then you may need IOTLB invalidations not to manage coherence but to
manage ordering. That is an important detail if true.

Jason
