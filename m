Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12E31D5AB7
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742557549; cv=fail; b=H8jOL6tLhGzNTwVU1EtgXhaQxtti2OngIg2FcpjXTp1U025NEmCIzcfyYaPd0WG85nF7pl1LWaGBIStcSeEcff6SW3owxO4NNvb+z7DozVkcMij+m2c1tnNdjQOdXlAcrUIOZA1b5prjgg1r+DPyrCjf11EHZUX7zT9tfqd4vWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742557549; c=relaxed/simple;
	bh=+F77vpp5E7/Y99UMlbNY9JF1xoURAU24FmOYH5WV6Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nZk9cObcEDVDHbAz1b6PdOpemW4KVXVBbarF6x9r1f09izmbet+7J5u/Y0EyZX9I2mi4zkvnia0tz92o9YHplDJvHVf0Cuhiqtko3KW2Kh2ckQE4dDQ9SXM3pqrg9RBX/Av0SzRpCrkxdF8IODPFTFWDTGTPP3aM+46pAkbkupk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HKGj9vLb; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HKGj9vLb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCbzCILva4/up8zf7CVZyCWGvhGGlTPMOOG+FzObPgPr2KbJz9WhcS6I3CRVvMzSYSct6WaIyj0kBGgB1hYy1GR7/iMV+3i1MNx+GHCTrisOgvKQpbIoMoWRhrf11b9gXFdOAQ0ckVvViNFr6f+AVfEvlgM/gEsFZVFtPzB4N+wGF2DTrwDdZv4SZ4Gty20HdvRjaA2Hj5p+NgaNgMJ1AWDNSE1u2JHAwHTwV5RLVkdIcvNL92C7cSio9+FBRVgO9r7f9OmQ0jEQjdr/ieeXf47lXUbquq9HFsd4lu+Tm5MIsMgSBTAJgP23vRGVxPdhW3OsaxNpz6Cxv8xXFFVvUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8oFfagNHYXq0qtb1i6jxn4XcHIk1jIFli6esLoKT1s=;
 b=ng8qR30zJnwsrTLR78r8ePuam5P7mSNfolUPX1Y7lRRpR9QbaHA2Bgx3NraERmAif2RIvVYpk0mbFkgJ7xQFIU2oaaYHYK0PbOUI7iLs+47mVhMiQEzOdmwi+06whXdvV9K0jHTpx248Jbh2vR5Pb7qjwdB3xLIFd7ARqVBkp3cwH0ITLQ7PL11/nR6zmIZ+h7zAylY9Urtuk/5G+TgmUkaVlgK5zEglGD4XsQmD1LtE6RhxZ7ufHbti5VmirPGJyimziGr6kCOgl3KG/LO4C/+rBI0Te8PPHD2B2QEYiJ9UB5m5h9efnLadr3bn2hdhffQ5ZsguQSUuMLAVdoMkPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8oFfagNHYXq0qtb1i6jxn4XcHIk1jIFli6esLoKT1s=;
 b=HKGj9vLbObEs91ogmUWc/6Y/QI5jCTITihaXaJ0WoBTQCztlbxBF2ZKlNUmY1B6JnBNrPO6jG7QNOIetjfvjSUXqoOVGEH3KBOUsqTIlls0uhvb9Kker0hkSO4xikkW5WU5FsgwQue/QNLdtRF0kdjDk3tLgQzukWjz3u2yYDYchd/InMODHZ6z86k8BLyoQ+qqiWuiq34z8hYZRWulP2jvm+KxhoUq59rmk1j8r4D9dJNpGzvTWpREt/Sn/M2f3iS2Wnt2ZfQsNaKM2oTHZHGcRYJOm/fnBF/BnpMFRwdv1DVPpczyiWbVsjsiwGRwAbWyABw5N0YIXTV+NiznG8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB9011.namprd12.prod.outlook.com (2603:10b6:208:488::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 11:45:44 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 11:45:44 +0000
Date: Fri, 21 Mar 2025 08:45:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	joro@8bytes.org, baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: [PATCH v10 11/18] iommufd: Support pasid attach/replace
Message-ID: <20250321114543.GV206770@nvidia.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-12-yi.l.liu@intel.com>
 <Z9x9sy7s2u18wVrG@Asurada-Nvidia>
 <783d69d4-5858-4699-812c-b8495a36e9b5@intel.com>
 <Z9y0WzIo4Edu0D9H@Asurada-Nvidia>
 <78e022c4-c971-430b-8621-be6199b7f3ce@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78e022c4-c971-430b-8621-be6199b7f3ce@intel.com>
X-ClientProxiedBy: BL1PR13CA0252.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: cab7adbf-f5a5-4d06-9698-08dd686dea29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?04nt/fDR31MyZzN2gNDu6wDEGPHyd2M8TRfvhOxgKMgz5mR88akr35uy3Y35?=
 =?us-ascii?Q?vBNh7ApKZCHv2B1ivFUE3SAsGxnOSRypTfY8B6kcUcGoZmzGVjSEQfWQ8m9W?=
 =?us-ascii?Q?61dCaephtpyxyhSEfP2ErFpWEhS3HRUohWvSSoyNPzqYotxgpPpyQEhemLFW?=
 =?us-ascii?Q?4h0RXgrFkTWFW7EGOdCQE+ddLqB5Pbwje61QyDfWsBNiBmdFtR+NGsExOZ4o?=
 =?us-ascii?Q?NkE/Yy/Tp6obcx86q0NJ3LgyM17fCv7+Ybnrw6Bl5Wd/g1Tq/NhoqnLjWtHQ?=
 =?us-ascii?Q?Ec3BujGakU1pDNpLVp4XNHW955av7SlXA6wjh9BLnPb9aNUFxcsrUD1/6g3s?=
 =?us-ascii?Q?1wKFShLwfclIMGB7V6y8ePGOAJ9paXnjN0jFK2hfmTZxz6YkfwpuVyFmHMfm?=
 =?us-ascii?Q?wmNgCxoDEyNcfAtEg8nigGS08pm8//6aP8K8ZPLg2dW/FNBB2b5NGomxd9x+?=
 =?us-ascii?Q?R8VJUE2lAO3VxuKxWCjuyFRBErVsyhWWNVOqsngogrdzFtK+P5nHKR+aNvoj?=
 =?us-ascii?Q?+ea5F7Q9kQKeJJg3gfFU2uIDFjPahGg4Jv2aKfjs/COmRmmUzZF1ZOdgXzmK?=
 =?us-ascii?Q?3rXni4NTU/zl8ftn9Oy7aKt50r9E5hlCaoBZmZbrxKrH12M+uocm8N5WU8K4?=
 =?us-ascii?Q?56rfbKRGoTUod0C96pIhVouyp+SzihfHrLDdM6+bBjam0YnfHdukBBxUG00T?=
 =?us-ascii?Q?s2TKCTrtvOpap0QH/vX7KpDxLEintUaBo6xVkW9sW3TdI3Q/IR8JBl5SFzPn?=
 =?us-ascii?Q?t4FE1bMqWeiUtf/LLaDSxfLjPce6t3ZfoIHix8509lxqg/loQ/pcrXSAe4+h?=
 =?us-ascii?Q?uHkdxg7kDV5n3lN3b+smeBA2r5y7tqAHNCwPW5QXDvsXvoNHa1jFYoVfFZ7J?=
 =?us-ascii?Q?jX6K5Vl/VeL8ZAn1H8Fop+og6HudWS/HpFBnHqy4A6x2Vcl/Cc+b7wzXDB9d?=
 =?us-ascii?Q?fMicHyVIrKP2d++pPRvOg6bIapEBMEj5VAygJjuC/YnJpkPAif/PKxxWntjp?=
 =?us-ascii?Q?7jbKRdjTxDVkiWAjpQ2L3MHb2e/kgAhQAqFVAXtoOo9JHLmczEJsf8yqNLhp?=
 =?us-ascii?Q?e3NtcW101wdFI0gmh30WqmeAeiVD3Sh4nQWJU3F4gOEJ8VCWg37/CutaX0Mh?=
 =?us-ascii?Q?/5zs1UYXk6FIItNutmlSVp4izk6enA4LfAFPm/Twbjoc+726phPGLUOJl7aX?=
 =?us-ascii?Q?2N8LeEzkWddlowiSuVzEXOd1o7m6dwpWTH6QeYSUqTlTl8yjvE8QmdLIPrqI?=
 =?us-ascii?Q?nbZuXwiIqm/saihhssh3B4LcihyG6vsUSaoElvUjeBnJXDMWeiCcZcsuc9Dy?=
 =?us-ascii?Q?tFIzAM9ZM+MyMZRftZZQVRERJdWTDKhoY1ka5RpmTG/DY5i1Hvl3ux+ZVgJD?=
 =?us-ascii?Q?sEdPInOyJNODDpt0yYJRRO8X7QKa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yNQoXfZ4Spr4Z97TWas+jYS85/oGpE81H2EK4BF3plCum4ZNoc0TdiooiSg5?=
 =?us-ascii?Q?xp5aDRTzpqGebRfuRJ5iOJtxP65B66v+fqiJ9brOV4F4HHrQNDzCVTwOBM3k?=
 =?us-ascii?Q?fRzMXV6BsYhkyovwn1JNC0NEAHBE5OqgNcfWK1hprCFeMSVrpMhM50Oosb3C?=
 =?us-ascii?Q?zhJ1CfSdVi6n+QgZ9mE//BP9wROA6/Lc0Cybl7zZXgMzx+VecD6m+nTvA51x?=
 =?us-ascii?Q?FnzWVqD5JzVN5emft0mxF4T30tZbxwBGWmyiGl4vs4BQRtO5/bS2Ik2eQUim?=
 =?us-ascii?Q?MaLoCoO4gtOYiIJ/IRTukhaqqKp3V6kRe9DSbyaimkYntgcVuXS9sc+kIftW?=
 =?us-ascii?Q?0RBUmiiwgXfxCH0x9TK30o5SFm4TJzoLeOHj5h8OoYZEzlWGr2VeP6+oaBVt?=
 =?us-ascii?Q?NK4Z3S5l8GZzrxJ4kU1RcSkqjfTS9/XszjId+crfLYJkloQ7MxOfyyskHM97?=
 =?us-ascii?Q?SzZjNgDq5oKABzpyfMB21AyYinUyRfWzrKaoNCjYVACjMtKM+2f+tSjtN6vK?=
 =?us-ascii?Q?rdS3NbIU8BVA1G1q/PphUCoVqcdmB9p8MMNGJexpwPgC6SmRNM8veWPwsml3?=
 =?us-ascii?Q?tJLpKTmJuVmhNWNvoOsO9+w8gkbTvL2q143cSJDBK6b8MVJIL2SEKyhf4ap+?=
 =?us-ascii?Q?TUPY2jmhenXV7ivlHHVTJu60cO/OpVPH6i4HypHrkdsIKhn/Eevq35n2fscq?=
 =?us-ascii?Q?4/4tRQKUiOV9O0qtki/OXOxsw08n2+wed1wbauA8I7WQXGIMjOxzgN7JQb5/?=
 =?us-ascii?Q?VPq+zDXjb1zdIgtOQfWjU2kkmNazWVWR2d5AEOY38VXqxIK+K0k8tVD0fdm+?=
 =?us-ascii?Q?Sm0P0yzjGoERzqNiCIug4WCN6DzPTurayjVX6gZnSEP0iZFT6y467KIZc7CL?=
 =?us-ascii?Q?5z6Gx+EdjeAMaKvhVIWXykqJtmlhNvDIE0Cxq8AR/RftZQ8HFpv1aZQBUlbG?=
 =?us-ascii?Q?LBe362p7uJaynZPCEVT54O5JkhSZyZaA21Epp5mjOpTHYzSm4XevUxGNAbII?=
 =?us-ascii?Q?/i9ZsygsiDzXoC66fb+LAhjhlg9b4cdQbHqPHaS3s7LSa5RonCDU0j2wSm5I?=
 =?us-ascii?Q?2t1TFE0RWq/THskre5vBXDxFSn8Te0Tnl3r8WeyQLCfPojktm1xTdA88qsej?=
 =?us-ascii?Q?LpxfAKrSoTpPbOV9ckAWRg9zMwJZNoQwIfS2sH6kx74w4QxOMZLzTSleWq/I?=
 =?us-ascii?Q?i1p0dp+2yIDjc+o+iRStX2BV+FZVDiQ1mGgkp5IG1yFGSyVJEh5jZZ4h45O1?=
 =?us-ascii?Q?aToQUcg3MpeGQorEkw17YKD5ALv2MC6mYwrBcTYZoA2Oa2tAmJ6MWk5g5/CY?=
 =?us-ascii?Q?aymTbtKfRbOR0oQ/i82rad+RNkz0z3938WKq5mkbbnl3BZo+lg35OUXSaBc7?=
 =?us-ascii?Q?OSqDm1nr/9ieRRbCx74uiuJjARscn/d1qOnQ2oKbxLH0XBoS+lLW/wZymU2c?=
 =?us-ascii?Q?XNR6d+XeLvPzpgZgV2+hu7kYaU6oej4w1rqKISb6O2B/XX5HZFLbIQFlJp3o?=
 =?us-ascii?Q?giecEqkBJQUI048o+sKXWm1hX33R4oGwD8GDOCQFlwCKnfuxKAwZNQnxNhBk?=
 =?us-ascii?Q?Ip+Ae7MZ7IQBa/ZVTaKaMdChPdj5wHOL/YfOW4kH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab7adbf-f5a5-4d06-9698-08dd686dea29
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:45:44.7167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YyyATNXJ/8gogYN6e6ZzrbmRDPDW8Tpy7Ak6zmWR1BdORjiKSeEKPqWrGZU03em
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9011

On Fri, Mar 21, 2025 at 09:05:45AM +0800, Yi Liu wrote:
> > Would you please also see if this could be covered by the selftest
> > given that all designed tests didn't catch this?
> 
> I suppose it can be caught by the iommufd_fail_nth. But the fact is not.
> I think the iommufd_auto_response_faults() should be able to catch it
> since it parses the handle if there is pending PRIs. Maybe I just add
> the below line between attach and replace/detach.

It is just a memory leak AFAIC, the tests don't look for those unless
you run them with kmemleak or something

Jason
