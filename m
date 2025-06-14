Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B341FC8
	for <iommu@lists.linux.dev>; Sat, 14 Jun 2025 00:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749859773; cv=fail; b=rn+TE72TsBkl8P6GJfCG4vg85saKkVsAWRqbrrfwkvNKuoNH+q0QWDKQmsQSX4UckQbVaakWG7OmHA245hsDTLrnPmg6Y5SGvCyLzgj+Q7Rmpg9FMqoGiyZ9JaB6lqgrjgtX1qnRWcnGywVhCJiGJDiMGyWpLSTKsLxPtin2gug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749859773; c=relaxed/simple;
	bh=lBxRC/HNK38T196BEf4JZZXM0KL2eHPba7xtnF6UbR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Df8bb8Q2KYYidspLnYN9PipQrVlSrtqWV1yRmbLUlTnYClUnihqzsAUrK4+w1kDSN9URDXTipQJ6NeNNdwmzXUFTSkuqNOta4xAecswLrpF+f60iA8+dZut3OZfti+dSC5L4E/v/iTAT0I6/lDrCVF4E1cp6/4JcV/rPmcQPN70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I0BCV9NG; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I0BCV9NG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNjcc1EMumICqHoL/oKytjdA5yqZE5ONbrilFSfO0nFGlpaQSJ0A9Vp5iteXcVGwsDxJFfMBl4hFKG6N18fLuwGarktzeQIPqqL1CVJ7tQggaHlGIZuKAsEqlTYrK0uXVas+4N4gl3QxNexxLvYIdZHIfW3ByA5VFe12uaow7g4mjnofSEfAPFc7Qw4iZx3/Klx1yjSgBmQoigJQlPzovgrihlrSDguIfKzeK4xcGVJEuLac/aaS75fCktisbcG3UE13g3NNJa9YNTUcaLmHngyHpEH+DfQxxl1yU1joIaw1bXqLOdLiqgNw9CqtNhdwk5ZiTl4drORwv0x7d2KTTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3YxZGJE/1HqlgzR8bJDzPE8vTgh70n0xqYlSc+18Ek=;
 b=r5EUeOVmVMlXeTKkj+A89BZiBcDd5tQLHDm3byB9ktxaCFPVDHPPl+fsWcIog9mCh8rojxcD/V0CxwJcA5hG3DYm8s/oPNFn90QMHCZAOMfSXT/9mayEEE21w+eDoWx1x4Gnc/wpjMqiKNi0R22MhgpT64WProyhrFUtb8pINRDpzisgPU0p6PD0AvQasgNeqIg8nkjloKnyugWFFOl+d1T1TpHApJ/WYsjSvCK8Ke4ZEVTBnebrANHSYvVIUMOtVGXPhTKH+Z0MWEgyeChmbDznjc2Tkfa33ZFaSbryD/rSwetYW/brKkxy3TCVQyLQxvyPTTrBoTbvioD76S1mRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3YxZGJE/1HqlgzR8bJDzPE8vTgh70n0xqYlSc+18Ek=;
 b=I0BCV9NG2L7Dfm+2xPMHCEth5Iu99T+n3M+0Rgp27vA4+k73nnDtgof0EA1h6r5mLztPsK/aeoooFEDrUCdn653rka4PLdTrOaoIkhudP78HBlqFdrgTEGHGUjq8zl7ofnKOzhnIIK3oOdmGAAkSFiwzZY3gYni5rVBfoRF6MR1xDGOrDsQQYVbLR0GAquIKTiHe0WPsJoV0DvR9ZiMIPvBS+RcfkBNlA3ufqHA7iCdzHCH1EJ+aAmNE2qTkDKU5Fgp0LZfrbOBjUT80kAHDJ4CMZ9oNe6JUGfmL6NcYIH60O41ZIuhtmwo3mUKKzfEa5wSuoNY1CXeYW3K48339kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Sat, 14 Jun
 2025 00:09:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Sat, 14 Jun 2025
 00:09:27 +0000
Date: Fri, 13 Jun 2025 21:09:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"Liu, Yi L" <yi.l.liu@intel.com>, Zhang Yu <zhangyu1@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v2 1/2] vfio: Prevent open_count decrement to negative
Message-ID: <20250614000926.GQ1174925@nvidia.com>
References: <20250603152343.1104-1-jacob.pan@linux.microsoft.com>
 <20250613163100.7efa6528.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613163100.7efa6528.alex.williamson@redhat.com>
X-ClientProxiedBy: YT1PR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: b8d5464c-1f73-4f08-107b-08ddaad7ba0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D/sq6heOwixLo0oDvJ+AYxsg0V+gduM/FK8J0EPn6pCytbJBitkDm3NT5JoD?=
 =?us-ascii?Q?45WDZVAiBvxDS8ipmrT0wfe5RrbFjZhpLIN6hgqnoPWNW095aYmD5PHJPWrI?=
 =?us-ascii?Q?C3u1g6xJci7wz1COaUUg9hC3qdNgZmR44ETYODEKYF8sc+5P7Qv7xZhr8wsT?=
 =?us-ascii?Q?26GJn6HtvpKp+10V8olSpM4faQTaQFU6P3BHbbTmjqs259tK6uZp5x9uQRiy?=
 =?us-ascii?Q?KhpO/bqLgNtKm9Lq2dmTk+qb/EEfTlNKqxrzvS4nWD5UqTFAv9iPOYzg+RaS?=
 =?us-ascii?Q?52BTBCWO5QCZSfjbYKiIYKaCWZTtk3pAvPZRnqnHkO36s1ZoqabLweSHyi9A?=
 =?us-ascii?Q?rks+ktwoC18H9y+AyukddZexdUZKRyw16P9lCqAjy1T5wWugSogUFHAD8ry/?=
 =?us-ascii?Q?u01SzPH51RNjxIkTs/rbVCtq0Xe2zVeMOAIw6dhaMM6pBKC+hkoFmlUJrwhJ?=
 =?us-ascii?Q?QgILrtEM48Ib35rjwdptN2C7Xt+Huv2WrUnopKjMnohUo1VbORa83p53C8iJ?=
 =?us-ascii?Q?HwXAmFg034R9o9FWrHeTUegBp+YZ2dWhMUOSDxJ4KtiyW/loNWh3a2K+e8aY?=
 =?us-ascii?Q?bhBnVtP3ofgmUXKdEiToOrXCUbWmDV0S2WQlhfjcqA/pQrTIcwSKtH6hbBcM?=
 =?us-ascii?Q?mRokniSFkt8Gb4PnITax9k2A7Ll8wwg9Lg4Alk+emTZBEzAhGL+FncHJw8G9?=
 =?us-ascii?Q?iVtU/a7mh399vGObXMlTrQutHzKjt1jmi1OrDtvsArmyTgrduvSil6NA4xI6?=
 =?us-ascii?Q?CDIVowYZXTe2H2OzVWz8xVWFfp7NoPASLsAtse++3pKSVI5+Q1SRXyracI1V?=
 =?us-ascii?Q?IRbwtSUA62TC5uWxdX/9ujmx/E14xxWARvizzoSNxGMxpoRnWHJmT/99aF0B?=
 =?us-ascii?Q?PXw2FpyjBfwKPFek4Kn0DdRGj3PTnS+5ci5aY1A/j/eu1WH9snQ2gUv1PKeG?=
 =?us-ascii?Q?+Oovo2GYDCc7dFXtarNg1mdIO1TDczPHmKvwluofwppFw28TM9WGqOjeON+y?=
 =?us-ascii?Q?DxkjrTyZ0y47w4jsUGAcb/ioJly40czjTNM1SgeA+PpEusTOtamQTF2qpR7H?=
 =?us-ascii?Q?qknuRY/vNOc0CZubkk0olMVz3HEQWKJtVZEWy/JyLjpyHrD2am42npCXKNDy?=
 =?us-ascii?Q?WuvLLoE3+yqMVXoGpjt/SRUOWyI/hTST/pVTfLcvBQwFV/n2oBWdev5wjQNn?=
 =?us-ascii?Q?CGK0UZ9rEZgU9Z16bWCw9dZdcYCro7S4pkwAUnWjnss9WSTRrBvatcNxIeTI?=
 =?us-ascii?Q?Z4HypssIzAUPQW+D8pQHJOyxeSMEG22DWKczgiaUhTiOc1sPWma6MEP9rdH9?=
 =?us-ascii?Q?OsEKt8/3IJP1iArl4zGiSEd68u1FwBWSNrLLS8WZC432UOzx2xYZo/X85Nny?=
 =?us-ascii?Q?LRvC/y7LvtaoGWG0q94GvXi+5tS0oIr9LqHlvuCM8EuXvVuZMlFcz15wSXlk?=
 =?us-ascii?Q?U8wwxHGOWYk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CDlK2X4AbRGEUh1g6IuyNvXEb14ei0P8mMIbw+66Ywp3Yh9LUbeTvLesuAmg?=
 =?us-ascii?Q?WUsp6UbjDzPSwugZKGlGfn4Z7mHYnvun9ufQOOeQ/tQMiyTGko2lKp2ypaz4?=
 =?us-ascii?Q?jDKs8/qjOU7IcwdQiOMnRvcaGnFTSpnTZo6GG4u4+pyGFBym+zpXOCJfura4?=
 =?us-ascii?Q?Jh7TEdgAtJdONEpjzlnZnIR2Y9SwxDRqWjPV0MEsLOX4O8TS0Q5NwaoeFti1?=
 =?us-ascii?Q?+vqfZlmcGHpBEHhplBeF7DuBdT8sRRBeFaj694TLZs02dkjiuIrBzIh/6cZT?=
 =?us-ascii?Q?H5NHvdPfNZzjeE2Tuah3jOElDuV1/Wt5VUboazvqeyo12BSGYry991iuiJd/?=
 =?us-ascii?Q?dtOL3sUbdEuM2Uy25+5CYBirpF3RF7lu1R3QsDLHZoKD9KvXJjcpr4L+abf+?=
 =?us-ascii?Q?WtwjeAkE3xjvGb6/k0otKnzz2x8aGAWmTJattXNcsHEP9jvq0Z8MeEbPa2e2?=
 =?us-ascii?Q?iCvtP1JpQZ9OrtWrKl/Nqx8ID5ZVfIXCdUz+Ja3tda8Gs0DAi5CbzXCl1J6L?=
 =?us-ascii?Q?Re/wwA37TXaAob9KNHdz0t38rHYK5m2qABauzIUFAQ0g4IusBDBdH+oEIaBO?=
 =?us-ascii?Q?lKQQrt81Y7rE7km+c/oSZvX5B62OhmoNht2XfEzebU42t+fBqc4om7ppIHUT?=
 =?us-ascii?Q?bZX8v74RMEwsptnMINHc+IeFgtKElQXWG6fU9BGgCH7bcE4S4DpfhWxi6SnW?=
 =?us-ascii?Q?jqecvqyD8oX5miILL6mzzZcrX4MhGxVZmFe6EcXQ5FeZc22UaucuagBOxN20?=
 =?us-ascii?Q?ejaiEetHDR1Q8a6r03faihY4RXUrXYlCvSDH9bWRxqjFCasA/LBeYClyDD9d?=
 =?us-ascii?Q?iBblYsAr80cRxdSGb47DyzAG+eOhyczjLSx/LVRomZCg3iOn+j7AYNZPOK7J?=
 =?us-ascii?Q?7O0CoMYStI0Y9/cs3EltNB8zE4HBLdsj/8Xzs+8WL08rg1wtNt/s2d96QCW9?=
 =?us-ascii?Q?Ru3CwPrYhiRoFlGBwRNm+uazgO2dYtilUEXYVIi1aLeN14fj81gE/ck/wpvf?=
 =?us-ascii?Q?fGJOo4MeGXRxX/A7URvgYqb8f+OxgojlHKlhT9LHd/skSUKKPkZ6xPPZS/cA?=
 =?us-ascii?Q?2AYkg3MW3kUGcCzvLU3QuUiiqESZMiXJ7B6iY4ehmW8vt5nfrwzpdIXfCLeV?=
 =?us-ascii?Q?PKCjs3ieEtuY9QQXgEHqv1N/VKLA0Zqc341aJ0nCPYHmLpjlu5ztCF8ut0x/?=
 =?us-ascii?Q?cyisdNxXgdQDpEiFBfEV2XMvdj/wCZ7pzASHs+hqpX5dLFHaIlaP6CnEnugs?=
 =?us-ascii?Q?1UVNRgcFk0MCmxTKxVq4rvXtUs9E8XRvTzI5lojT+YKomOSsRbi55W1MgSFI?=
 =?us-ascii?Q?pcobLe638D6TajZoEjXKb4GXwxltk5G1uofjzpK3aYfJoiCHw2lnKQUZ2tyr?=
 =?us-ascii?Q?S6jJQ0qFXgVJO6X0sNV4M2lIFfqyMgcRimqj0HI8Z48DUIUxJOi25POwRraV?=
 =?us-ascii?Q?DwaWU350ikhhLPba+k9qrkz/9vBwrr6HgMT1yDi3rjRgNSU5zi3ayMhBrUl8?=
 =?us-ascii?Q?h9rhTiknXosBNGNfWoOqLZmuHk6KpihMbYY2KbwYje6EByYPw2Rr0ohXYwop?=
 =?us-ascii?Q?GGQ91DWdPU87P9kmJVtjKjJM2MnOQyaIIj+fxets?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d5464c-1f73-4f08-107b-08ddaad7ba0a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 00:09:27.7209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6SSIvQckn8Tr1edi+N7NAwgLvbiKDF37rkdvVxK+aBXI00qL+WXujsJHCUV5Vec
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7705

On Fri, Jun 13, 2025 at 04:31:00PM -0600, Alex Williamson wrote:
> Hi Jacob,
> 
> On Tue,  3 Jun 2025 08:23:42 -0700
> Jacob Pan <jacob.pan@linux.microsoft.com> wrote:
> 
> > When vfio_df_close() is called with open_count=0, it triggers a warning in
> > vfio_assert_device_open() but still decrements open_count to -1. This
> > allows a subsequent open to incorrectly pass the open_count == 0 check,
> > leading to unintended behavior, such as setting df->access_granted = true.
> > 
> > For example, running an IOMMUFD compat no-IOMMU device with VFIO tests
> > (https://github.com/awilliam/tests/blob/master/vfio-noiommu-pci-device-open.c)
> > results in a warning and a failed VFIO_GROUP_GET_DEVICE_FD ioctl on the
> > first run, but the second run succeeds incorrectly.
> > 
> > Add checks to avoid decrementing open_count below zero.
> 
> The example above suggests to me that this is a means by which we could
> see this, but in reality it seems it is the only means by which we can
> create this scenario, right?

I understood this as an assertion hit because of the bug fixed in
patch 2 and thus the missed assertion error handling flow was noticed.

Obviously the assertion should never happen, but if it does we should
try to recover better than we currently do.

Jason
