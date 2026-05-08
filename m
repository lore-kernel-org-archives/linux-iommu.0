Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011049.outbound.protection.outlook.com [40.93.194.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542072BCF46
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778283438; cv=fail; b=SW31NpcnOna8taFc1KforLj5SY8wlo/Z5FoDI2KgRVSGpUwpRibFr+NcFYja/Ot/zkrGHSK8OEHiaYnZVLI9hP60n3Ox8+DStXepImv7jW7V6VBbaPCY9K9mbAMg/bnkgFCC8vIbajeXY4jHPHD6/OtP2CaJgPI/6P+/t2Um/Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778283438; c=relaxed/simple;
	bh=qgWDOc6LQCFk/a2wdjLoqJsDgNoFFvJe+6gIJ5xmCwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uGpMted2tnPQyDB/g5Y6mPVVOYlJx1ziLkKE9iznKxRUgKkvIX7TDRKN1jrGNmgAPJqJGDWcOSLKbZi+F7jv4hp9ayOc2HKCHjK3JMVRcDJUyGJp5l0iCtBtcVvaULPhDVFRIA9iRjbIysV284JaVGT+IWnx+KSA6WhAJbaEbfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qlDBMAoc; arc=fail smtp.client-ip=40.93.194.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qlDBMAoc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dvepow0r4CZDohSfwcOT4RmdQDtYfJDj5Egvr+SUJ925QKkFovFI0fW/AJRCF59pwNwLDZcLoHB9+bz2oNm8zWbNzsFGbqm8a0Z/qqtrI/kd418D7XbKbOseGZOiyL664Q/fPbUfO4PlxJbaPz0q33qZ/6qVKXJFw0NLcrJ/z9Mw2VfwQ5Ma9lKVdCZG29DtAMMSuKdeO6cSXSqgsnYRUzfef+IfrXjFTBitPpWvr0AIsSD4xuaISv2Uc7o8//TC92C2Gteksn3qJgOO5DamqxxZlur8MFnbIBgaQOBiX+xHAtMlSPKmVEgj5Z2MWAaxxrbop3Xdd6Yvuif2u258fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/xLX3mGyG+XcyDuIRjPGadFzhHsSUjI1No1m2aZHfE=;
 b=j1atHvlGM/N5LbSTOWT6a/S+nMF4nEVWJhiJrPY7KGPyrCcPV2JAN1GXaaNpkTLAalB4NpLfJYUECjgTWs1s8gBJWBxY2a2/cuMx2JVZzKOsWHMCe7b1YZOTnzhJcQgwFZE4DcmAyWrQks5XQfpkVyfv0/iv8DzkgqW1KPuGPRHSvTPIC5su+F8n8NlUAbopCkEjbB5/RRL2MIE/uGKC7YJtwqk6Kze9hKjbfdNzQ92q+RMjE0BTQvpKErCfMEtwIwthc7yVVq6GLLY9f68Zss21hHJGh2yacJrsy5R0r4m96qTDLce8MOlYyidH5nvo06Tn88iViXgLipOxac5MZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/xLX3mGyG+XcyDuIRjPGadFzhHsSUjI1No1m2aZHfE=;
 b=qlDBMAocETC2qoXJ9zD/TY3Ngiur3h5B1j1SbR8BmRc6gOMtOa9t9dsHm6g/7TDjY2mHV0W+v8w7ATTtrydFhDh3Wr4foA7hAFmkdtnGcrjBX/m/9ZG1oFXMnFD2qfRazwMfOGZsWR3SPXROwXkKvaJeXiy5UmPc5hs0fAcA+9bjPkUgfqFkXXtrEkOy+LLCYiktHMXalTH5JTgR9Looa+D4e1eNOl65cKJ7qFSKPnfZZgc4odr+hD32GlAmveI0VuDUnX7ZVahadWprJ8SmACMFGbwxnzukG8/qte7sgFqIQDX4XGwLdZGH7wfUkUluawoOy8/8RiL3Jhzmj6+ytQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 23:37:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.017; Fri, 8 May 2026
 23:37:12 +0000
Date: Fri, 8 May 2026 20:37:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kai Aizen <kai.aizen.dev@gmail.com>
Cc: kevin.tian@intel.com, nicolinc@nvidia.com, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iommufd: Use sizeof(*hdr) instead of sizeof(hdr) in
 veventq read
Message-ID: <20260508233711.GJ9254@nvidia.com>
References: <20260430175630.67078-1-kai.aizen.dev@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430175630.67078-1-kai.aizen.dev@gmail.com>
X-ClientProxiedBy: YT4PR01CA0241.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: c94faaa5-cef0-4fd3-f763-08dead5aba76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	dP7rMT8G6zzDSmzhvN28hvmuEPKaIw/TSYj+HL2nt0lm2DdZpXHu5EW0h8xUmtArpyU7PtBK/a+Bkx4Ld46fVkVm9Hbf04YS1vdhwrNyzVZZ+swMuKsOr4bxrx9c963htRtxUFWn2/3Q4d5s+hVpgnFTlWNWQzvS4K5a9f0LH/pfCU0CoNtsGTULvCytA3IMinuxrdCTG0o/kVYmA1HYbTlVa7dIFYJLtTde2LZArV/5U4w0EFvVeDLAiMbDoYGWbhyCFo35je+JTmsyQPLh4O/oKXtaZcoaPqRqOtz0J1N5tp1KpqyKoYRi2MRkW/w3xvfdIuJGfhfzAHsTFMQYWtjNgQaT0ozEa/4AUzdo/o0e6XLn0zTFdxNeaConlPgiy56+rH9oFvqG0TrCz2f2+t2dDk60ssZ5DjtXpyjg+U6q35DKS8QEVY3Ok+6AcFnLLHtU/MorN8bGiWB20/hVSEVQqy+KSwkKxtwg4A1rrDzB4StalUsacd/4CJXLhhG+rQmmU5m0DLeYTB9FCIFGxAc9REO6AJWx1pzViOuXUWOenaP+H+QkY8Z4PLSm6WVWcyx8Jw0PdOR6etFy8p4u5373ELqp58sXyBCq5+/hoYZmpYnt2LurNZJFYX0V+6SS9z8lVpBvYwQ2w7KC+CHD+qgST7ptFvBcFqA0UruQuRQHT0xeCKQ2YDqCsKblzGKm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pB+sZZJOaAYm/zVUM4ZTABnMk0m03hyTtP0AwAn3Fdhh4PUhOpaWAdkg7JoG?=
 =?us-ascii?Q?BdlUcBK+P+wvpeLm4bI1BBThGSl4sb7uBQilrkpwV5BxZjwTpjK0jwCMDf+w?=
 =?us-ascii?Q?jksGcKFs4IdOGv00fOsX9QBBOP3CenbHJ9a793VTpmMGXjMXLBJwG/E0FZwT?=
 =?us-ascii?Q?Q3O/HlsWZKI7vJ7GTq6/dIggk4mShkthW+s0Sf+owMMKtW3rDVK/V3/J9XC1?=
 =?us-ascii?Q?qi4Yxum8Y6vzzUzmopK3yGZI4Z0CB5BnHjhnhg7pzQaZPx0YtmB7WeEt8OBp?=
 =?us-ascii?Q?rnTxlUyKcIpVib7osETSRGxM8TE2LCGkQv3LIPnJeMATYBDRucuy2N/tVVSS?=
 =?us-ascii?Q?wvneJcO+Lmc8plSEU+e4Sc0fcwFeoZCC6uux6h0lBhgH4jWTRNkYx705Ajnr?=
 =?us-ascii?Q?YNjqoC3yM3GFfkNvGuz5HwHKYzi0Cb60r8wA2ZMKM4jJDrMnykKqWvoWC+Xz?=
 =?us-ascii?Q?MsqWHfd1kU0im9mIEi34zWjYfv8pPfAOZ0gwdRXAhjMmSC1D0vxrAfy7VAxM?=
 =?us-ascii?Q?pY+W0BqX9AJwV6XghJWq5neWEjfQABLZWr8PYbe7Nbvh7r8VIuw5ZBgGuk0r?=
 =?us-ascii?Q?y1JHVZjieuOpX01JIDbZy0moGXzOY4GTa3sNc/daKqnX+mB2csQRbpd5kpV2?=
 =?us-ascii?Q?N3gvd+SiE7hplkpRpqkV+Xa822tNPPAKjxVB2BL9kh9GkBS8WXRXZrFC7H+q?=
 =?us-ascii?Q?QEn8gvvseKbHtMS9tojSfrB+7kAd+gqpzxS4mbhW2lxYcgxr06z2hsG7Jaxf?=
 =?us-ascii?Q?LHNaDOI8wr3lea8F0qmELR5G65kyPqAlVdM2WQwQh+zWiiIoDzeg0YFcrg4y?=
 =?us-ascii?Q?JuFl++XYPhdzkUFWujuV562/Q/2dh1q+k3XH0FutRHAjLgRxStCIPF6V8Wyp?=
 =?us-ascii?Q?0qSLaLCKUM8fY+maQM7YIZ/nekEZdhlrxs42P+lBXMZVP818KsWnkoE4Vg28?=
 =?us-ascii?Q?/X4G/tRPhPcbNqkf0sO0WhcYNjEEdtEWVOB4KGKuMby3kNfAZrJVRTZM45KB?=
 =?us-ascii?Q?O8dmgdjwz0nCPD6VZUXRaYqvRN127LsRo8iCyQc/PRgBswGyn/aHQnJSnDU4?=
 =?us-ascii?Q?q6W+0vPXyhs68lhd4s3pWhv921tV/IgTZaw8DbZPRSFhdRGv8eTs4D/MuYwO?=
 =?us-ascii?Q?ypG2653d2bkDtYgIeI0G1e4WuWmMIEJQib1CY1bxu9SO6Z/iIvKpdHkiGxQn?=
 =?us-ascii?Q?FnPPeGm+gM38IhQ/adxICn49h/XkTRBPrwV0JsIh3a3STZEZ3l+Ps4oYRsEo?=
 =?us-ascii?Q?1QGjcMEv5d+4n3urIZVjt2fR3Sc51d4tq9Z0jg56VJnUwmq90bLg0IH0kEfP?=
 =?us-ascii?Q?9F1oz2jJ+Qmw15hZZL1eMuqUMePclBluHUgYMUnvx34DJDNX5D8SQYLDiYe+?=
 =?us-ascii?Q?DDBLZ7e7muIhf6DTaMs477IDlvqySpQaKpwfvOu/L8iz/iqm+p7juuBWhoYi?=
 =?us-ascii?Q?W4qdTQZBZI8KSHVBa0ZfkyH792iTn1m738kcl+GcGA/nna8loYExNn7+2lZX?=
 =?us-ascii?Q?tYa5/KktjjhvQkOq2FRnS8UyDDxP2bJVH+6czmtoB/mpgdNxTbPtcVOdqSee?=
 =?us-ascii?Q?NwIbww4+aOWxaxgbMXoDjKBApJiV8MO6ASUzTEg+bPil1hmmfg+wO9at9q4o?=
 =?us-ascii?Q?S2lGsjRDqP4kkDTFtgZ5h5H/r/paBDuOEs8hee1RJP5ZqKa60cta7tIAtYtv?=
 =?us-ascii?Q?akWhQXhnJBvjyPg1dmfzu8qbYiZhvxzDpt610tzogzxCJMi8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94faaa5-cef0-4fd3-f763-08dead5aba76
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 23:37:12.1530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMy+YCoul6ZR/Hx4o3EMrsvR+SzTuUnB02MdncGEu9RfxOPHCBI/BGbM5x5JenNL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622

On Thu, Apr 30, 2026 at 08:56:30PM +0300, Kai Aizen wrote:
> The bound-check in iommufd_veventq_fops_read() for the normal vEVENT
> path uses sizeof(hdr) where the surrounding code uses sizeof(*hdr):
> 
> 	if (!vevent_for_lost_events_header(cur) &&
> 	    sizeof(hdr) + cur->data_len > count - done) {
> 
> hdr is declared as struct iommufd_vevent_header *, so sizeof(hdr)
> evaluates to the size of the pointer.  Surrounding code uses
> sizeof(*hdr) consistently:
> 
> 	if (done >= count || sizeof(*hdr) > count - done) {
> 	...
> 	if (copy_to_user(buf + done, hdr, sizeof(*hdr))) {
> 	...
> 	done += sizeof(*hdr);
> 
> struct iommufd_vevent_header is currently 8 bytes (two __u32 fields,
> flags and sequence), so on 64-bit (sizeof(void *) == 8) the two
> expressions happen to be equal and the check works as intended.
> 
> On 32-bit (sizeof(void *) == 4) the check under-counts the header by
> 4 bytes: a vEVENT whose data_len causes 8 + cur->data_len to exceed
> count - done while 4 + cur->data_len does not will pass the check,
> then the loop will copy_to_user 8 bytes of header followed by data_len
> bytes of payload, writing past the user-supplied buffer.
> 
> It is also a latent bug for any future expansion of struct
> iommufd_vevent_header beyond sizeof(void *) on 64-bit; the check
> should not depend on the type happening to match the host pointer
> width.
> 
> Use sizeof(*hdr) to match the rest of the function and the actual
> amount that will be copied.
> 
> Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
> Cc: stable@vger.kernel.org
> Reported-by: Kai Aizen <kai.aizen.dev@gmail.com>
> Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>
> ---
> v2: fix From/Signed-off-by to use real name and email address.
> ---
>  drivers/iommu/iommufd/eventq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
