Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DD219F134
	for <iommu@lists.linux.dev>; Thu,  3 Oct 2024 18:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981378; cv=fail; b=YpjnG8aM1S1CTf084/TFYqN/c4N+X2fcY//8yvKsoovL2krNKgCNkAnSO/Cw4uJg+kpzpEesLwmYuKs6cs2TZhqVBy3ApPj1ueS2Q0OTGZa6IjLKonaWvIeNQIygp/LzlHaDBREDm4SLeDpeDQRU03f9JcEryO25a3/7ouTyUvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981378; c=relaxed/simple;
	bh=W065mexbn9b3FYF2YscYp2NRd+a/Q8idhAHcu4OOOp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RrFkH1qCc5NNz11+5u5AHnEfheCYtjC4x5DX8Q2dYFXAlDMklHxqMfYhbQdXCNdiMWptL3M/IAJjjscHkquBhC8ZP8EPqWfPZ+Hda7HhSAXWqr+YcRxjt+E1nRKFveCxJ1oUPVIVw+ciA3DJfbas0DokDOnBbWPMzGXYob2UND0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TxRoJ9ng; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TxRoJ9ng"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XE0lIyi2r88IuReTGzhhVAAFHODc2LlUtvRRNq9hFJOo279Ytg/7TnF77XvVkhOOnkhMA1tt0SYNe5RmHWlTaXFxXY/d4+j6nCaqqPL8ANr1Z0ndhHN5CMKDATw1HN3PzKaLo+dkTsf14NwGCtI8T8bNLzDK2WuQOUWopFgjmyD9mLM4RBAjHZcDULfGa9lYSGdJmwLYcBF+vkNEHXVz2/f4NutsIUXbh+GeXy/B5yXRedqxZueW6ocFgudKd78MBHiWsLPAP7RkMJOVX8rgG1iZWHcto5uNZ6qg1P9aXUlGIY6dqOTGQqzim45+DeKhBoTHfy7WwdBGRwAsepdX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LL4NFx1bvYAMz3+ktljqB3QDPh/Jc8HqKxR0fwFJuKA=;
 b=W9JlYVlZF1SgTr1EhvAISFTFv2sD7Y6tqhBzupm9tmL3siBYUWYRRwVja8+c8nOuFAcJp98jJET6oosCW6uv2fuW2rBCElWo5oUtrMsWWjQrL4IRimcH9Lzif8A/3CObK70zk5gVOHCx6i+ycYItf7+NDb/tXVMP5c59ZwIBt7NX48K2L+LUT++VzjwLp82j8cmw3nFm06H7WIFGjoxm/YoGRkKWhF8li4WeGrzFN3XXwNOicouoGmjJ/5KP6b2UwRf9R6vOtxSsuKK087OlpliXGoNh7fEV2XlHJsKl2bS2dhyB7+ApRr2sjNeCBHTRgRPZg2s2QxcxEjaJdmiNyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LL4NFx1bvYAMz3+ktljqB3QDPh/Jc8HqKxR0fwFJuKA=;
 b=TxRoJ9ngYveGMJKL1Gh5ISytxS4exTBRpjWQCB2CN4nYQ9fcTF4hLnJdnj4RL647uTfM4werRgZMdokWO+oSxBri7juzPYoDXsQebvKUvMEph/yZ5pu3Ul2ymb67R0m1nYjhBpW0y73NaluoAQePjQXg+CryzYBMRDZQ6aNHklrq7nA6Cixzf3ro4MnQiXJa8hNuJkr3fuxFl5yQvzY/dvxXTme3d6UfSdEbIufrFAbtUeK5J/rIeZHHUTTJ63Mxw4xyJpiG/IxKQzj2Dll8g0IuvwvC46XpyCjZUnZl6fdKuyhjy9ZO4voNpHrVFEhsmxbbNuDwCeMH7TQtEyuEtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Thu, 3 Oct
 2024 18:49:32 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 18:49:32 +0000
Date: Thu, 3 Oct 2024 15:49:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v4 3/6] iommu/amd: Modify set_dte_entry() to use 256-bit
 DTE helpers
Message-ID: <20241003184931.GC1365916@nvidia.com>
References: <20240916171805.324292-1-suravee.suthikulpanit@amd.com>
 <20240916171805.324292-4-suravee.suthikulpanit@amd.com>
 <20240926195648.GA229871@nvidia.com>
 <aaaab5d3-047c-4d48-a4d9-cb5b4adc733c@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaaab5d3-047c-4d48-a4d9-cb5b4adc733c@amd.com>
X-ClientProxiedBy: BLAPR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:208:32a::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bf1d613-236c-44bd-3b08-08dce3dc1e99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oxK8AwJbhXWIOuMKLjr74g0vrFkCki/Zpk1sm0fYQt7LDKECfxHOcPTu25OK?=
 =?us-ascii?Q?i9kBlernjpL0eBv8Ujoqdbr8bXJdJ/KlZCHa/qKfIs+k+RiRmWxNPLgQXth4?=
 =?us-ascii?Q?Farcom3opvCjZhxwP0+UfNacaLzvKy3RgSvvGN/+CDBhDQOPqRzM2X+Xae0i?=
 =?us-ascii?Q?MaXGLT0foInUTzzpygRVe1AdIqdfU7kUe4444Hrx+sKFxRYkIjSosZAPTbRe?=
 =?us-ascii?Q?ey2Gdo6r1kSFCUIoI1qet2CVse0nbdWg593mx/H66+xYSPBMUgdbmU9jNiBN?=
 =?us-ascii?Q?hcVyAL9SufdympRXY3etfe+rrwQ7TsHLdq3jXQIVs9em4jmjEyD1IOuXLHFY?=
 =?us-ascii?Q?DCqry5sN/NwTbqp20F/8Z7Qlf8JXp59+akAR4ciYcW1rZELuH7KnP5Lm1ikv?=
 =?us-ascii?Q?ESX/wIYWmM6oM1j80swILJoqSI452j3LlMFkxJRk3uX5KL8m6BiuInf8V2iS?=
 =?us-ascii?Q?4FrK6svv2KjLUN0iDf5ucc1/Yn92RrGzeLWZFOZZ38HyG8vsFMKKOsmO70MD?=
 =?us-ascii?Q?volY8DmjZZjBMS2B6CQv9+rBGPyLnk5LTBiNjHm3qTrByOZROdMDcumSO4XD?=
 =?us-ascii?Q?Nrss5/+sSrMgDQO8thQ0kHohXFjLa5qYpvsZ915Pc9tD+jqb2tGq9oZB5Yyy?=
 =?us-ascii?Q?qKlsZR3oDPMZ4AE5GRPutJhj8+ko+ooo+2NBwMfVwGMeyUMsdlP0ofDDyUW3?=
 =?us-ascii?Q?WI/MznwoJlSNhzKC794M5arDZU9z1egRUKxSL2p98wrNr6jRYt1VcB7hLRp1?=
 =?us-ascii?Q?T3BT1xGKtu9zSM9yMcvkjckP2kTzQFWhJtRjdyIaArVV4aj5YjEL0kGJt+xn?=
 =?us-ascii?Q?WZucfIcEz4qOHAsgviNOc2yJCcw0vKWz3ftHL/+2pFVNzRKkoaCrjpFOZqTv?=
 =?us-ascii?Q?mvVEyNVcErFAFgGqygVCMzvgPfxxSKsxbvL+4aHdHUzNA3mrTsApSIdaSh0S?=
 =?us-ascii?Q?MMlSk+PQOwIqS3c47XsXsTGtTEW1MjTirnkRNJEjzSaevvuqbANkpGu7mFkh?=
 =?us-ascii?Q?XtZZRbV0k+86KscrOv2FFUFoGP4goWawMGeWloo3My/Ae1q2z+W/xJlmi53f?=
 =?us-ascii?Q?EWMiacV/YIp790BAERBsm5DwdkYej6cCMLzB/kGBkofGhJvH+6/IX8HQGZsX?=
 =?us-ascii?Q?uLbkg5DbPClkEc9IzanT3fUC8LhCEwVMp2Ir0CuBx+eQ31zbO7JrS4eMYX4p?=
 =?us-ascii?Q?1wsgQrI5uuxwqif5A/vlrA860WEW45Y2/6lsFwBwKRbjIk7/UpsvWUdNooHt?=
 =?us-ascii?Q?Ky3jQg/NPDm4UuM7zcP5ehVt9A/ARhfjcwF3qrEepQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cOzjIUDP/limX3VeYKHjS6bKRImrxIzZSNnIJyzvBX8/7onI5zPxylTAANxr?=
 =?us-ascii?Q?RLI0Ghh51MxoOHNL0pEIJoPSrX1j5AyKAGnufywx/dzMEWzgL6qDstdTh+D9?=
 =?us-ascii?Q?CQKFOqZV5i4K3xYq9fKa3s4qlzwz0OjaRw6L6b2N6boDM+9vRDLlYzx9COqH?=
 =?us-ascii?Q?tNKqBP+KZxAb+N5+gOw/K3xJWHMIC9AhzVDi2U/QOMD3miES0LmJcikJNka+?=
 =?us-ascii?Q?ZOMmmV5+M3T+/J2cU6I1h5hX5hoORvpIy6LK9havbwgj8nJSikX+WgzRW/YS?=
 =?us-ascii?Q?seL7OtJzNAdHvNAfW3o44OprVozURttPkiXumUzX2w40I1roRyyjimeKVbG9?=
 =?us-ascii?Q?esamXkDXcATatHvYN8ljQ8Zfmodia97CUak9RyyrK0RukwUmFzznQ/UpNca4?=
 =?us-ascii?Q?yuD+lbnZ10WC7r2WQq4hk3x91X/RPULkO7fEPKlnkeeMj9tYorq5kpwRuOb9?=
 =?us-ascii?Q?dd+6fCLf0DbsutM/IIcCUZv75gPCToSLSM5Vcc5Vxysl84c6KPTQlh4PjuLV?=
 =?us-ascii?Q?hmxT1nOkU6F4beM3uOeuxBR97d4HojABexfngiNxnGk9vzon0sHaNr0ifLGX?=
 =?us-ascii?Q?MjUJ9vi5GFp1MDZBsEcMdCEWLZAovMc016kkdCTO6GuQR5xEWt8Rh+JXkRIL?=
 =?us-ascii?Q?Hl5ahID9QpXhm9InJW3vkK8mdQHDiRxL95OXcC8S8e5NQ8ASex4uly606Uh4?=
 =?us-ascii?Q?SC5sCYtFhHoVKtL8XOCSzXggfWqf64yZilJXZMRoq5Rt25qPBbYu7Rqu+Jes?=
 =?us-ascii?Q?QuVoxiiIfROlMGHHw6BAn+CZUy1CU/2y006rfyWESsAH0TdV86uIYhtTB804?=
 =?us-ascii?Q?8vr9aX6BhskSCuWnJsyZz/r/9G//Dx3kZBK4OwTNIKFCNDv065LBzCBAGfq7?=
 =?us-ascii?Q?DTCvUQpLomiZXRcgqXECXMuYZoA68vtXsPRtJ+qXU80ily22BULxVwxXJRYX?=
 =?us-ascii?Q?yrx5H9H7YWsfVaNvLNzIUJmK7lPv9nF5kMCXgSc/L8S20gKLsgmafgOyl8hP?=
 =?us-ascii?Q?0yGmBaNArkbz0JonkqC78DLr9kQk4qGWZGvRqiNWoVFMFt+cKacEcwSLR+go?=
 =?us-ascii?Q?tkCOl67HqQfhhlk73/HDdPPCDMVFfDmuwnpNs4MZllurhgqQ6fPezTeblQdm?=
 =?us-ascii?Q?oUiv6E1joKC0LtQf8CCTfhR/EX+Mix2CNsjQc52svrjv468AylUaxEnmNW5c?=
 =?us-ascii?Q?ZmAQuRb9mTGHnUZTtrvTDPsWNMJypn9YGjOm1gAvbxD0w33UylBq6cwvmWyJ?=
 =?us-ascii?Q?en0vgjpq5JEielwjPFJ5rjXxYViLqb70TPbRE+ncyiNHKUW1CkYzGO++nluZ?=
 =?us-ascii?Q?CH6ovAzGDk89tjScYuyjXZJuqC3SbalP7hSgPuJdiUe9Fbv/hiYGTER7x2Lz?=
 =?us-ascii?Q?fzdKOkA/mDWyUkuaDd5oo3pCaYp16DxnWfogYa6REwqQD/MNLn/BlUhXUWm0?=
 =?us-ascii?Q?BItqFZ5HRxEXDwWbhszlkIZ/QOTPKiO+pbB/Ap+At8gZOgyQsUdBWqFx7m6/?=
 =?us-ascii?Q?Wj6aSC0SJu2gWSFer/4V0tZIXnZ/ysMWbw36KLXR2cZ6rE6WrHiYBUyZqTGH?=
 =?us-ascii?Q?KTZV50rL3KGK+JqKcws=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf1d613-236c-44bd-3b08-08dce3dc1e99
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 18:49:32.6758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hlKOYyJ0MdU/fVkpD+jWnuX9+Hjb9I/eYXDw3hj7qg+gXwmqS2tPIqgXBX03F6P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954

On Thu, Oct 03, 2024 at 11:16:19PM +0700, Suthikulpanit, Suravee wrote:

> > > +	tmp = gcr3_info->glx;
> > > +	target->data[0] |= (tmp & DTE_GLX_MASK) << DTE_GLX_SHIFT;
> > > +	if (pdom_is_v2_pgtbl_mode(dev_data->domain))
> > > +		target->data[0] |= DTE_FLAG_GIOV;
> > 
> > When does this get called to install a gcr3 table without a v2 domain?
> 
> The GCR3 table is also used when we setup v2 table for SVA stuff. In such
> case, we would be setting up w/ PASID. Therefore, the GIOV bit is not
> needed.

If I understand the manual right this should be written as:

if (dev_data->domain->type != IDENTITY)
   target->data[0] |= DTE_FLAG_GIOV;

Ie everything on the RID except identity should be translated through
PASID 0 and if PASID 0 is a V2 page table then it will translate and
if PASID 0 is non-valid then it will block?

Identity needs to not use GIOV otherwise it will be blocking?

Jason
