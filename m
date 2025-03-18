Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B2820C015
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742300752; cv=fail; b=BWW1+arn8RGEAhVz8stxMY1ZJKXdhAasHqIVb3eiIxCXP/92QuyGae/6Bqxuhlqyx6EzGn7SP7PPeiwhs/kG7cpojmw9gbCoVINi1VFZ/kBCnZqXeSHiSoF1D3F66Cl1jDYnsJZL5CfYaDvZWXqt6vVRjVgD4XqrYE5eN5x8hfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742300752; c=relaxed/simple;
	bh=TrOBI6TNhVsAW2jf5LsfIRNC7wHOY/Hvy9fOM+es41M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ykd9u/NdY6d2qhmfIRnuUCkz51g3kGClbIX7dFms/vxe7/Hrpyo5LY2p8FltdqrYyLp4Jq2kQqSltyAspgSh268xijw2jYk11hYt2HUgHBOjkWkMZDicHWhoqU6NmSsFk6k9PxRI7rPq8fy7Zj1Jscp7LfucnbfXdQKrST2Ux7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RSpqfdy/; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RSpqfdy/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDRgEwnKpALNfH9j4nZbEpQ80LnNxPf8PQn3OuXkpUYNkcDIuXrSYzok+mFtBGsKup443VPmYvEsxwT3AagNzw7z9fa04O6m+13QWul/xBe6yP6mi1zecIBYNZYr9IqUN186LN/gAWOLkqRBLN4O7ejRfkDNwzPsjhyKBERlD87x0w+BZi2sAJbBZY8arRjMy8UnsNlFut6n3b2y72f3K7eIVbrTjHImNRzjC+b69Bs9fW29mpNfyvzju2eC3tQTahv1j2QBKE9XIz14z+PgOxSVrmrH7h/pJQAvo8boNMieYbJfO0RDQqtAHuvZ1WJjGA4o5knkuE22fDB7kVeiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPmis414J7c1kQXAiFzbyoASypLmVU/rEHuEOWLNG+8=;
 b=qzPgz85MY9Z/qRVl4fcqNjcknVBD+5G7E9if6Q60zQd/XWAejlOHSr+2NUN/IEG6W/wLrZQUt7BPNzVpfiYeidKgwFXDVxMbVbMYrDK9w0S762LyxqHJx17KRUGhGkNCqaIArzj0Qq/o0hXUIMCeR4Pog6O9adyw3aPItESL3vFRtPpxYaJVGAKlIuueZUsoJSYHqeZWtl1yNIR/VPjGXYKrpYoz3ISORoRMitSUVkQMO7jaLCSaUYsuapw6piY8jrg5/tL3MaYojz/cpTwZrB48P08FH6ObM3vEgob1TDc3KDK0SXzQ8tb9cBHmg7u3pnGODgolyoqbeevxX21AFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPmis414J7c1kQXAiFzbyoASypLmVU/rEHuEOWLNG+8=;
 b=RSpqfdy/L+l075AdAt+J0qUbzPDO2bFFyYx0aFMx5otDhE7wxiOVPYBrxA4rMuRhISp+WJMimnj7OgHRI6smBIX9FvjgICFMY8QVGaTPmASqx7DteM7bK4k+ObkyOFQYgiKHjJg0qOUuSi7OqA0aLhNtc0vDjoxldQEq0Ax3dSpxnuaOHdLvsUpzUPYYcxcKFESggC/fjkaj8szxXQw7ui3qKnKmLtGdf7XJZ1J8N83RpyU0GeQY7Nq4ZaNf4X8Z9lhwiqMgr0RKCjh2ZUz/sWH5cu6B0I4ylquWxe1r6c0Tj+f3v/7VNZghiqcnvB82HLEJul/ZV7U9SEyYRCFZ8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 12:25:46 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 12:25:45 +0000
Date: Tue, 18 Mar 2025 09:25:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v9 06/21] iommufd/device: Replace idev->igroup with local
 variable
Message-ID: <20250318122544.GG9311@nvidia.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-7-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313123532.103522-7-yi.l.liu@intel.com>
X-ClientProxiedBy: MN0P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 60872a0f-57ed-44ac-9a12-08dd661801ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h1P2rDN8OhJ7ss1o4ityCnHd+JB/hneJK0BTk/G21Up400Xnnf3RoyIxV5uJ?=
 =?us-ascii?Q?ehst1FqQ8ZVh+ONXjS/QnM5bZTc9LkOaPfkaNxTYuiL3h9/GLzcJYOZhVNmu?=
 =?us-ascii?Q?utBtRmTvVYnxepW1sh03m1/jtRI4p/kpXst7VHaVzIWx/ZlRjqah4i5DSKL0?=
 =?us-ascii?Q?hLpUKYVBpplGYTEhzOqE2k3lABr9+Dwj34+actDTjcz3jsgWaWSdoKEaCq62?=
 =?us-ascii?Q?6OuCJRMpneuE6Vsm23H9WxuRFhpETyUXgg/EqXVHRAL/YbzCPxnoAw+knaqY?=
 =?us-ascii?Q?3FTiv3b0dC2muwDzETJzEC8lKQrJbJswCPxSZtB7+ytofdmNb2yArGPeQgYF?=
 =?us-ascii?Q?Oe8nUfMjRaTzGFfdDNj5PoxW9zJTGB/4sCQFR1Hr8aRxrVEf5yS/QaWJqCpb?=
 =?us-ascii?Q?+liRmtkaxXGf9b47T4HO6x6jzQyH7xT3wu4i3og2iQq7cDkwqkM82+WHVMMQ?=
 =?us-ascii?Q?HoGMyAw3Drqplx+gj7jfMta5QWfzRtANbdCImtZ4XmKlK8dzJjalb8ktCu/U?=
 =?us-ascii?Q?QIbCm+wDUWMhZF6GXIxKmvQvdwF9ZadJME0+H1a8ZZL6eOCA+eXza+I56nqA?=
 =?us-ascii?Q?iiO067TYkgjr7d+QxB5dvdUOBiufH5Lpi0WLfl/krAkp6OkWhECnMvfGfWNf?=
 =?us-ascii?Q?LE1v6wtrBujC2ZyQFVz+VIFKbG/rUe2uGPMBAx/KXy3+UC9mRKXNvGhOpG7z?=
 =?us-ascii?Q?W8Wpv8x4rzxUZxmsesOuckpjL4guvpmTUnJFbXizlyFzUOyodV/Rs6b40vvk?=
 =?us-ascii?Q?QC38hoJ5XXiWxByHjCAMZakjJ4H9LNmycc1F3ZKqOqwnjn5cs8Ba1+qntmVr?=
 =?us-ascii?Q?X0PcSNle22EvJOZwRPcYd9ytgPpm7Gc4dDxLfimm4JnC7ZTHadYDrzv+p4Id?=
 =?us-ascii?Q?yt95rOPicrP6VReIXEW06WLeZ5QgvhSrMXxmOq7V8ZbmMAo7HTeYIer1Ad5Z?=
 =?us-ascii?Q?pk1gI4fA1YVsjU8FdrlXwG0gNrFpLNFeeRiDGpnY1CDitcbRHWgF+mKhByQa?=
 =?us-ascii?Q?DjlHOFM0/3RcIbVEf63jGv7g19OPYa8KNZCdmeruAzBRwuToARoNe21hGu62?=
 =?us-ascii?Q?ZnYDiBwO/ZYUh3XuO1sR/q7ks3pQTUbYSkZ6wjXRJqbmAj3OCq+dOKgX3wq0?=
 =?us-ascii?Q?bif6RbmqtjHW0lmvnava6f50pkFA2XxnIpKaWBY/yj3xX1Plhxgnf89Gfzwq?=
 =?us-ascii?Q?K5y+4WN6/uVD7ykxumhNXDLEFIcwqYZDm2orfG5MHN1gm/WpSEXeSYHlznWS?=
 =?us-ascii?Q?3rSMr7ekT/8lGaUCnD253bhur7rj6kVMvTRxp+4IWF9+nMrb+UG2TwK45Rtv?=
 =?us-ascii?Q?pNNBaamR5iZP/XjN9PmFcyrQ7Xo0nh+ovOK9zP+btH07JDkPBPS+iLGhbFU2?=
 =?us-ascii?Q?Mq3MBDXzf1S5Nv+aQnEHfwAYT4yP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Y6jQOU3SAqyI7JB1atMACHiLPaOqL5k1+tASLYX8lSiQs3V/uScJXesKwOb?=
 =?us-ascii?Q?BP+avRjrd5k/MaqQVoL/aIBXbFnpa6gyO829Xi/SWCQayq8LnX7LgZhYZPVx?=
 =?us-ascii?Q?jOYOU4sgw392ZBZHVL15qMP/t1PRz71BZj64VR5yuQJeYwhcI1K0Zvwx/SZh?=
 =?us-ascii?Q?fPys39kN3KPvE9icByLNIdmZhK8DS8Nd+iN2/eWphZqsp2nhc3ZrwfRAA5Sw?=
 =?us-ascii?Q?rr9nvhL7ZQsyF8irdr/ZZscWLbAWCPaOESxRj9LIaZd5E8K+GJCOhmZcUqkS?=
 =?us-ascii?Q?BD85CTFI/XEv/hcXEVCj9kJiyyKaIwQX9824bPlAyW4rvsOSEL21NgwpBbTN?=
 =?us-ascii?Q?BcjluqR5ATvdFxLuFbbW0Hksauthi7Vy/ZHwjCsHG2M1yW3Z6WMchcniMQRm?=
 =?us-ascii?Q?Jt+X3kqx1UKs1OwMDIMxah/8+SxlURTLKLce3zrRBvot45oFPYjeommASGTE?=
 =?us-ascii?Q?rBsxY1E/MdXunvIXjm8EAJRUO0UOL/bRYFv0Vyg3TqUvsJlv4dHnh2q4d7DY?=
 =?us-ascii?Q?6vEoUtn4FzriBtNFQd5b26DVDn2PDF63Xayf2j9KWvZtMBCbhX9lNkfpnkTJ?=
 =?us-ascii?Q?SSL/xpJYwFs1M77N0JrwB+UaFmgbXomPatAFpLlBNXB1TMeyldatpF7PUDEQ?=
 =?us-ascii?Q?R4kLQ4hdt4AUp29UO+HG/PdJR5VmGswCazmlWlJU1DK8cdOFtVpipvSco84K?=
 =?us-ascii?Q?nhl/RlzHNGqHilbKET/evwdUa9jzE3UxSC+TY6DEKpVdEb4No162n7xVVkrQ?=
 =?us-ascii?Q?RmL/l3qkBHB19iIHtM6qHbUfADaTy9XZhWfj63F05ilC3epl1N57ePAeITpK?=
 =?us-ascii?Q?zAByrCslFWLRMtdIgj8cRzDhf/9bWfUL/AiaCBWvxWiN1uyju67ZGNfGWNCV?=
 =?us-ascii?Q?65zxeepAoCsPzMzHH0oK4ARUSKT0BtJ2WxmCT1FrYzpcgVfV75wnpAeqqXxi?=
 =?us-ascii?Q?XEXq6iwEwvBBKBaebNKZqdjOKwIefkgeb/oO/6CJAXWddpCeapWmStMaUSiV?=
 =?us-ascii?Q?1x/nwBPcAACkSzdRGEbftzg1915X2F840mfjNZqKOy3WdwUu8KVSi7M1oRsq?=
 =?us-ascii?Q?rgGQW1/RENB+sb5toH0P+dL41feFfrVZ4f+ywk5r6lijSq97hrpaY5OQ6GPG?=
 =?us-ascii?Q?kZeu/oatd5+JWIO9QEvBmo83JwDpPeBxmSuXrFiI2vyD0hQ3aFgWZTg7SJkB?=
 =?us-ascii?Q?iOD3cqIgdcukqxCCKrU/GdtRbkyHYoTtD6bjs1cvsZBzutKszRtPy5F2SgMw?=
 =?us-ascii?Q?2FvXEWYc+kF4XmLxtrYJVpSQIW7XGK+4hLNVyW+Lvs0aD0O93o97hUm3zidU?=
 =?us-ascii?Q?sYuC0UEyy42AdeFcZNDbtbSarajqRsMvHigFwAsDwa30mHF76dXLVUSCCX2a?=
 =?us-ascii?Q?+GUrdniXPbzhqMahEUXN1gFA8uiWbshugtFhaEYiLgzjRpBRja6nb2w1QhC3?=
 =?us-ascii?Q?7fNzIyGUp1zf9x4x7QprPDKQ5n/rKh24ycp7hEZh0pec6H42UlBaaRHifkwd?=
 =?us-ascii?Q?IeT8WFtuVQwlrcYsFtliqIEXsFWkwNpWVe31v9P9uLPBnNMkPJLvzVDv5uOj?=
 =?us-ascii?Q?7sM1KrlNxLaRqa78trjfyQGj61Y5wYo7tP46kIO+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60872a0f-57ed-44ac-9a12-08dd661801ff
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 12:25:45.7347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWuFG0fpt6CwVf4w8wucK/kB03QCcqiu0y6jrVkP2gI+PWwOq8iSDID8Z8LU5bY7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731

On Thu, Mar 13, 2025 at 05:35:17AM -0700, Yi Liu wrote:
> With more use of the fields of igroup, use a local vairable instead of
> using the idev->igroup heavily.
> 
> No functional change expected.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/device.c | 43 ++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 20 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
