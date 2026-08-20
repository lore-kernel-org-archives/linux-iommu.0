Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013009.outbound.protection.outlook.com [40.93.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98EA31D362
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 22:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787263759; cv=fail; b=ZwqQG18g8fPdYcCnjQvlz+pIF/qtCc5p2RUuYCqYyT+W1GHlX+yoBuVDtUh8vqKd1GKymBk0+wclfT8rMwfnU7FlR+/s4tLfYf3u3BtCVV+CFBoczHG9mwImmx0UXD+5YOAydsiJaHqOhf0Z8fuNxRYGrR4RhXCznSZ13D5I/U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787263759; c=relaxed/simple;
	bh=O/XMBedvnu0FcNzs8oaQPuNX+I4YztwhhsaMiLDbKHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ohxP9+CetcynckIfTPuVT+EX84mnKd8gbzr0TYP/skhClXSNxbdAveo94AL69qg+6IQjFUPj5++JEwgg3kGhd0TaZ5XokOpgznvS26VEKmdb3nHiplpyPiU/b9OcwETcSef4DuwcDoVMOYCFAUfn3IynaLsx0r9mR/q3/yrGYnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nti2cqcQ; arc=fail smtp.client-ip=40.93.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nti2cqcQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ubr15w5AGUzuIHONFjMPE02czilMBLWHTeBhoVXr3mNfVPHCQP8g22DGX/QHYjZYZcTxi6fboGaV/Cqgow258uSwgpRE0wdshtpXZUQWBUpmkRbVK0sPA3AIUE8fftXi6l6J3OkpymP/nq+D5AdZCjY5jTCKf7m1c6E1Yo6kGNIEdnhL9MFYClJCT1gfppPbWypKhE7lgHqLsjUvVAVkZh0ZzIna9ynxS72dGvMe1ul6iCt9ueBixvn8v/dx+hrRHvjZYvMB30bpCQ6HOXQcLrYzDjnqNOZ0LMWigx69/y99EilCoZNTw6+C7JHNJcwCZSc73fPnRqsrKYxSBV/aJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cKm1pLw8h5FSO9+yHDtKKCNvNIrkWLRDbslB2U2YZY=;
 b=wq2iKe1uDE/ZDQmX5nqCWXgUXfTEpwt65I/6Jjm4+9gMeZgORec8BWDzdFwaBQzAHOn37u4iKA+9hHV5lUgqdOl1GdwR79W7bS3zXQr/eCC4RhZ38c2xo9tIsUJV4vywTkTElxz6paznfbZhVqBv8auFH46oH2m47/3LYP8AVVS+JCeIhMOfb0RNUWZM4yftGObRtl6rvBvsH6tOe9v8hII9V4mlvQTeH/fUb9oMWiA7g3yduW5CsoJzRbiHWmEu6oysdcNLElMhpwWyQfKxMxxCFz9xXghp6jXn3uuxGfAvQGgzB8lODXPs+4OCYOHNZpyr54dA35iGMne771roFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cKm1pLw8h5FSO9+yHDtKKCNvNIrkWLRDbslB2U2YZY=;
 b=nti2cqcQh3FAd9GS13vEy4y3pMF7OZXk6rIHYyTP1pPCxejrQc8N9M45hLR9BcCVHs6qGblox0VVj2zijRlqcZglEkC8heyNOfHnC1rmB4qEQl5wvsiGWKkLUzcluHnAElzP1tjPVvmQ7IGi21H48lN0tiSdCilwupejZJCi5daYR+w4FXi2UxMHTjpD633ryffN/o0G2hpo4mUIazczTtTpG5BcrzdqI+f1ISxAbRvCy3fT7OdAdGVJ0AwrtxwWW8r9LTApf+nHRzm7IGyXWYGmlHuJvGrT5IGIG8Q/abKu7yInF2UIFSt88qwo9eq1jXdT5e8lOrQly/gFLgc9Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by DM3PR12MB9415.namprd12.prod.outlook.com (2603:10b6:8:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 22:09:11 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 22:09:11 +0000
Date: Thu, 20 Aug 2026 19:09:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
	tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
	anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
	fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <20260820220908.GE244917@nvidia.com>
References: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
 <20260820214150.545737-3-andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820214150.545737-3-andrew.jones@oss.qualcomm.com>
X-ClientProxiedBy: YT3PR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|DM3PR12MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 30b0a75b-2d30-4c3a-9f9c-08deff07a879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|18002099003|22082099003|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	98x+v/OgGphrdgsmz5XFr6weqbzYrIqS0R59IeL/OIDNR7IyWi7dLnVZ8THAD+fRfMpbjrq5Kyes68DeylES0j+YEKyHNKnI3n09Y6CCUq0P6yGf16Sy+etTIn5dlPYFMiQVUyPLtvvwjIPQGg5s5BCDeRMAK7Cj8T/eUf3GksIf9cCNix2XGyQTquxOzrtO9kwr286SadwnaStjUsR3tbhaYT26r4yKWxDQR5ZdkBubyLj2m8HDPjP+AfKlSO0MTtpnRO6H2ARPktkqaJcrwhroHpVZuhM2/A2NAU5WQyIBEh09LC4JKJwT1+J5//mT+fdbi9Yex/ZhWuq0rw8SuRp3d2TVlpQWmgEQ6huMaslJOBz2k2c2B8g2S/w6xyIpJGL+HjBuAjTDx8GTHC5BhsePI/P5id6Xb6RkuEDRO0E3jEAXVHst5GYkQLd4NjLtaYWeqR3zNp7oqbCKZMLZgCwh5+wD0e5LbAV9FSynNmzpygsMBXuWbVfW5BLCat5Dve189JAjix7/9XF9lJOsMHihg+3BqnFrnAx9KqwsLZiLw8494/Mg9w5jCaXLVcvWVS5JTCY7rSutL/yZzWV07sfQPsU8/dtrg7MFtaG3Lcu1NErnvOjFL3Cqz5LSSrn/zmTooVODAT4CcbiLLrAtPmijftNTkqSo4NIcgwTbX2s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?85zsTJ2AkFpn9i2mG6Jt2mXTCTVl66aECRtP5gvkVGY74VpY5jRHMEpC2wIc?=
 =?us-ascii?Q?m5RTwD0xsPp+UAwr5qmVEjQcxnl3Z5xuhm9GkV9imFS4f+zUf3RcXC/ldach?=
 =?us-ascii?Q?tdI2oHun8Le1TSlsSmUAsfFqTywRt/gEnCKEA4mLmKrA/RvvxdzgwdSoPi9b?=
 =?us-ascii?Q?dHPl07XuRIls2zuMexWoMlntk0ivyW8c72ch5WHwAHSg3ybhL+Up4IGQJbvq?=
 =?us-ascii?Q?6OiuxdY1eRgInQ9bHxncSkyiufRAOVBgyUgceKomtED2nuitwYEfQWPLCpsg?=
 =?us-ascii?Q?1W8ASANoPTwprb+EbJItlRcaX05JMB2SNPRQRlmeymUJeGyVVikTGvSieNyL?=
 =?us-ascii?Q?y4CvxCdCH33VerMT4cdCbobCIebs/sFKRxHfV/BA2fb0g16Ztewldkc1LUNF?=
 =?us-ascii?Q?/Izv52cnDz0MV/LjWxawI1QHye7A1SZTkDxjHMO55KTzVwjj9RTKtK7ZQqT/?=
 =?us-ascii?Q?9CLUHiTk+Vhd5SJqqQtsvkjCjWfl1CXt2tmnpg3/i1/+k14nBo2VDSVAug0r?=
 =?us-ascii?Q?Lwq5/wxQvtq2Wj3+O6KYFlpMbpaKp4cNtUOnwV4S3GElEVhkIzu1Uka+FocM?=
 =?us-ascii?Q?UuVM85FN5P9oi83Y7J9PM87HGB/mysD2Uod5zgGH6wL8v8cWmh9QQD/9gfQ5?=
 =?us-ascii?Q?xYvgFf2dKtH9sDoEWQzZI3rf3GpZ7KyTCITbuOEhqMRpi6n/yj3zsi53QKZ9?=
 =?us-ascii?Q?1U3lDSm6bZC9vpA6SQGhxXfBNa+Y+d+qJ3GMo8eEmFckzg49IU106pYA0HUN?=
 =?us-ascii?Q?ApN/rIm4HVaQTt04sTqY9lLXKLvJH3PJTtcAEP48cdJN/SCCKKtBV04eR+t4?=
 =?us-ascii?Q?Mfjr8mujusjbQEwBSnTG/iRA+zlbRhxjLsU56SsLsglxWN/rdJ/X+TEgyd3z?=
 =?us-ascii?Q?JKvoj8z3OSTdsYqQIIOonHyl7p+rAPGNS62D8oYDueXVRJZ+qXhUBYXjPE+f?=
 =?us-ascii?Q?WKDS+uF1Eb2JYm/IIk+zm1rixYQhive3b8WcrUVaRK54xbB+HT78OKo1m6By?=
 =?us-ascii?Q?Pm3C/B0nRVVjH0O+aurAObFPB8Mw8+9G7/pOYQU5k9vZGEviXZtsOdkdit8A?=
 =?us-ascii?Q?sMjeH2xByOLdCzcZFsZkYCsnAm1d3+ObWpxigTqmToB2C4mp9Xxaie3X+bxf?=
 =?us-ascii?Q?/N9PqH7wArziR4nAVj1vDd3sqNUhUHHqHCnx5SX0sr5LnVAOs9+7T4Fb0NAq?=
 =?us-ascii?Q?wa+20aELYHQO8Tok5ya71PRFkAPE7SyTl7NIkrLqT+CmYIXwJbJ6OoEKqWTJ?=
 =?us-ascii?Q?FGKjO7JWPTVzRXl5tbtPYmAYkzgd+FJIupd+VsmDEmOv2LPrOYjAKbF3lz/2?=
 =?us-ascii?Q?S5J/ypLvhm+8uMJXEW9em0f/8vdc/OfyTjxs+UEmZMGD33shTTICybtkN0tC?=
 =?us-ascii?Q?aGxCbGmBPQgYhC1def2UfIqjMpfkJ7Lurf8bJa8w5RLFZZE1M70auOZjJEPU?=
 =?us-ascii?Q?TrJIc4Bq62ny7wkc+4lq3gRhgcYOd43sfy1O6UvdGt8hVr9HFl0Pa4EBoQvp?=
 =?us-ascii?Q?QCX+wNbJHQNUbahXIo/FEHKjtbzCROtgkZ+vtC99GoOrISxOalgJA7L2CefB?=
 =?us-ascii?Q?V7KlpkOI0wUA25TFB/rzqd5udxEOhGyWWC9krFGgN3QoI/+/WSiqgalGkcGW?=
 =?us-ascii?Q?ZSEeZnDHtP9PBsyqCqDVjb+Tg/iwVy+FC5p8ymGZDv9vdaf8mcsACHFDZwgx?=
 =?us-ascii?Q?7eIlSDXbz4QL/QWiKURMHbHYZz89n/bkq2MqBJuE4BAz6vpd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b0a75b-2d30-4c3a-9f9c-08deff07a879
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 22:09:11.0364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wN+qhRVTajueCDcQP3MneSZJpvwr90rBhJlZcIPWrQAsnKEcYsbMtxJVQ50IuOju
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9415

On Thu, Aug 20, 2026 at 11:41:31PM +0200, Andrew Jones wrote:
> Add a descriptor-free counterpart to iommufd_sw_msi(). The existing
> function is tied to a struct msi_desc and stores the result in the
> descriptor. This variant returns the IOVA directly so callers can
> pre-map MSI targets before any descriptor has been allocated.

I haven't grasped why it is like this?

The cover letter says:

  ARM can map a fixed doorbell PA per ITS and cache its IOVA on the
  descriptor because affinity changes only hardware routing, not the
  composed address. An IMSIC target PA changes with affinity, and MSI
  composition may run in atomic context, so mapping the selected target on
  demand is not an option. This series pre-maps the supervisor IMSIC page
  for every possible CPU into a domain-local PA-to-IOVA table when remapped
  IRQs are first allocated, allowing composition to select the target with
  an O(1) lookup. If iommufd replaces a paging domain while IRQs remain
  allocated, the incoming domain's table is rebuilt before it is attached.

There are a few confusiong things with this statement:
 1) Okay the IMSIC PA changes dynamically but since it can be
    premapped the PAs required is fixed and known. ARM doesn't change
    the PA dynamically?
 2) Why do you say mapping on demand is not possible? ARM's
    iommu_dma_prepare_msi() is not called in an atomic context and
    does do the iommu mapping.

What I rather expected was for riscv to have a PA window that is very
big and not just one page, eg adjust iommu_dma_prepare_msi() so you
can pass in the entire PA space that you need for the affinity
changes. Maybe this is a list of phys_addr_t ?

Then keep with the ARM flow where everything happens at the same
times as today. Instead of just mapping one page you map the entire
list.

I'm not keen on this design where things get pre-mapped into the
domain by the iommu driver, the ARM version is much easier to
understand :\

Jason
