Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFDE21C169
	for <iommu@lists.linux.dev>; Thu,  9 Jan 2025 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736434289; cv=fail; b=koVtuqkKFuXdwusOWED/lQv9SiIOE6EIA0cOHd0iClCvmtq7qifOfTZEuOkYzQddPXRVgNCkOlkYM8QBIWD8LxeC68+amz4JMkf+5m+2H8A88LpCHxkq+44yXaAC2gAqNyNc9zzTiAnrkwrHBeIFLU40AdhluqHpMpPVcx2xePk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736434289; c=relaxed/simple;
	bh=KtdWJmk+20aH7bCNtWJLs5/VOdYMl+IU3q26wYpvtQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nwn4SX62WTqOnwmqUCQGjgFiDvBB0tcVRBv2jDXCmb9qcUHAkDollHKDEXVv88hcZ+Nxq25NxjxTwGGAuOFOwuyB+bAL/wGs2r62VQk8RqHNtYmU+WNUWrIvrxwnWKz0msG+V76i6KDcIa41/Vho33pD3ckifV4OwSG7/D/fL4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VOnthmiB; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VOnthmiB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXszefA5BWqpR6PPKYye8ZcWtTbxWpxungEYm2ptaVYqOj6GTyQY9Ura2K1h4j9U8/xtT5yhqyG1rhxPLeh1oZX8bPV32LnYWN5Nwy+Vcc4c/VzlzWaibjtIeLzmwhwDhMUCFnF0ETUgqeEpi4Fpk2TP6e1xK2afCyuu0+RDI9JO0n842BVJlN1MlNO7O+kh6oT3QUbewB11xXbCujSM2R8vmrHtmf/jo/ss88pgjSPLBCQJ+++2gxUmH4c1xQVD45Zch+gdICddwzPG/28NY0T1LsJa4vfFddTO7THLM8ceA/vieZBkmCdnnjGYXYvijbzfPbrcc+RSZ7NYus69bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blQ/Dk2nr6CcQvVQ9mRy4VuuRuh9O7b8tixbfoBpU3s=;
 b=GK3Hm6Vf3wJghs4gaMOq0h0I8tgQsWI8WfmWoQiQaRrORajGcasiY6Fs41PxL4CTzdrB0Dm/cSZxFpKylE2QXF/zzDi7TfRrSD2QxNqMNoIEX5wrVfm2ETA5ZZQrRpaUNeQmT3A0YtjD2wnwO2vXfmN14ZF8Z6uniz1XShHOloWFCJkI0SZnpR+l9dCb0uzK1/sMlImT/tk8dsb1XasdltBOY4G/WIndnZUSCI352cpJVYEHqMQCl3WjaWXto9f2nU61bvwyxfdj9y4/SH9h8OQXzUd3tFZyPspvSbrsIYu4CKsTQ4JbY9aAHtbYK/wG/2ImdAp5wB91Dy1pwlY5Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blQ/Dk2nr6CcQvVQ9mRy4VuuRuh9O7b8tixbfoBpU3s=;
 b=VOnthmiBsOdS2U3S6pOdYxPLLubjBFz8gi7nlq+Bkts3pmAfC+tWIlgVxylrHTy9NqXJhzOCGfOiVB3kbyZFvCNGlZFG6GkrqSlcIfeUbUfO9Q3s+TIcuoUhOVndj7mmGv2q/pRxFvIKbbQYbHtUbCQMROv/7KL42sFtwSBZxINBQoZGdUyH+qrnL59qGMVC2Y6vxyT2NpzxQm7WHpDyn+KMSRxl6wX631XFgmUWnX7eOn8eY0QzBIKf0MUN4VkaNx4wzVAtb/7G2+PTdj44T5ZVKhrhqE07dGOtKq35srlex6czQy7C6LieqdHYmc0YpTFzVF1IzJdIr8J2ZdDLtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM3PR12MB9350.namprd12.prod.outlook.com (2603:10b6:8:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Thu, 9 Jan
 2025 14:51:24 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.015; Thu, 9 Jan 2025
 14:51:24 +0000
Date: Thu, 9 Jan 2025 10:51:23 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v6 05/14] iommufd: Pass pasid through the device
 attach/replace path
Message-ID: <20250109145123.GZ5556@nvidia.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-6-yi.l.liu@intel.com>
 <BN9PR11MB52767D0A44E2F75F1641ADF68C132@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52767D0A44E2F75F1641ADF68C132@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0150.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM3PR12MB9350:EE_
X-MS-Office365-Filtering-Correlation-Id: 64de3426-81d8-4da3-490e-08dd30bd1662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pr9t4sdD4iuO8NAA7l55hSyBhCvOtp1yl8ndZQUkm4rv0PpRhTgic2oB9RE2?=
 =?us-ascii?Q?woYOLDBqRgVOvFRay7qXPyr9uORHfpnMn6vGdHSyyUaFdsNFFTLJuOwpKGs8?=
 =?us-ascii?Q?H5R0Cf58T5jr4QpWgMNI0HyMB6F7oQxw96BKk4OrxObboXyVBbC8xU86XqYX?=
 =?us-ascii?Q?Ux7YeLrvyCFGTsj3l4ZJTsl5uoYFfuDhi7E484MGm3Q1GaKwQya9dBdHKeoP?=
 =?us-ascii?Q?rLkBmYIBpQeFVTpG/vJXA2vitTg5r75fr1WbZuVzCF6gef4dO6syzpi6fy8F?=
 =?us-ascii?Q?btK0dfpzp+tmVF1bj/d+5jIpRWFnsIUZYF+sVd0x5z/tFL9SypSxCuE+05uc?=
 =?us-ascii?Q?EB5iwFBcXL+5h1Tzlb0vQoXipycV/KvywCkXMypE7a2XbTkNpCIAUqKiSyAC?=
 =?us-ascii?Q?IkhktnDSIYN5tmsE3Gr1N6AirhwvtUhGI5V6Man0wDeLkJq8iNzvGr6GbmAt?=
 =?us-ascii?Q?miFZ10BBFzDRyqfMCQ1MgwJs03XEHst5mIPHyqOLNQh/jbaMve6IRp4sulBv?=
 =?us-ascii?Q?DtxjFRySgzUK7rigHfVlfLwD4cD75H+zCLprNYhKw989Kg5bZMWM+vrkm6Ff?=
 =?us-ascii?Q?wpcvoGNxbiSVP19FXJnQcPfMK4dQKXNeL7bHODz3p4zTOMgDsHrTlGkbeLCz?=
 =?us-ascii?Q?QRqzv/LgeK3s5o5tqwHRcKDl8afsgHmtPV/GRQGPGeIkHTELlezxTR2fAcgh?=
 =?us-ascii?Q?Pyw3bk4AjgGEhvc25PyAq7ShsWy1nbkQT2QOksBvUbMa6dU1g+CiuqdRXjkn?=
 =?us-ascii?Q?nrPyMBtJ95vrMrVWYz/P0IUFUBWUZOL+xK7gnYojNvn9u+Q2U9RPXIbxfTsu?=
 =?us-ascii?Q?f80EdKHpmZ3oGJMTfnSlyO29Qf6Mxj5XgYKWzxc/mV3ECRfpl0r7NPg8Wm+P?=
 =?us-ascii?Q?nYI+mO6Qp9IDY9XsXrlWsIC3Ag6f35O0PqIbvkjv9Hs5IMrFUX2UKXs5cQ+E?=
 =?us-ascii?Q?9XR9WMybWeV2MWKL1HzfHOQxy8hAdx9SCTt6cGJyMW/iZPozqyyAPOXh860V?=
 =?us-ascii?Q?Zuggw9wpdblQJP5b1t2C5iQjD8401DhIgjCLOcrOq8amnjOu2NYhtxBMWEdn?=
 =?us-ascii?Q?6Be/C+RV5KDUjmfDjEEW9dHpWTil0/tFO076NB+/4bruJ+ww7xBcUVzTCSrz?=
 =?us-ascii?Q?CdaOWmCnhl5XBQcoQnXfKO4DgFRjaKqaRRNiks1qTDxOJEqG2C9p4peNahu4?=
 =?us-ascii?Q?DE8dqJU9JIL8+8uKnFJm+kIYhSLTQdM110WpzDzBojrB1onGI9M86PvdZxco?=
 =?us-ascii?Q?kxZ5wDcSNlYeYUjL+TAha9C8pzmjHEtenMp0Uv2Q+/4jFhuy0oarGlGlAc7V?=
 =?us-ascii?Q?jpZfyHiZU3weyXadVHbWGuBkSEm/l17juT/2peTUZ02NYKvzxRRXThUffN9M?=
 =?us-ascii?Q?0mN+cNP26jXVHWzga9ykuLlZYzKM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JdioMbG/HQ2taq0BPdOCJaDDYrHtf4xUeq1AhHqSr2z7LEXS8ZUGch2b3RWd?=
 =?us-ascii?Q?oe/Ws/gwkNw8PQVDU8/XhSFr4v8QjKRUdx6CqU1drb5ZjAylSXrTRedLt7bA?=
 =?us-ascii?Q?lpT8xViwJPZr8d4fc19brzV9RGZ9odFqp/EFgIsudyiQ1ieiEZOcNoKGekNv?=
 =?us-ascii?Q?MwjhVqSO8eNP4mNIMEDoV0/xvGvbh6JMl50rq33n/EZFU5xQGuMSqzZgsCQS?=
 =?us-ascii?Q?p9nn7fOzwfEVYzPV71Mipudvpaaww3EQKAxNQ10IsIpnG/Uci01viqeAA3VQ?=
 =?us-ascii?Q?V6swkG8tPZ3CcIolcA3eOp2GxnVRoqf8MET+AFY61bG7du2l0+cDo/QwdHDi?=
 =?us-ascii?Q?Dpgxc7HXdZFFWmSg5bxQKPs/MoBktiIjNFzR2x+T4kgGSJpbVD0Xs9Vl9xGe?=
 =?us-ascii?Q?LNXwNFVc5lFj8GYMbe0hmJDIQ3nqe/FNY/s/WD9bT3uXeOJsDtxP7LcmCHj1?=
 =?us-ascii?Q?b+jqo8Gg7KDrHiUgD8+xUlO4sxqqPX3xKn0+GwYuP/rXB3CGV7TJsb6G4see?=
 =?us-ascii?Q?H6vr58N1BS604XlNYN5G2ZAuZzbdjUWWir3+0aVBTSVRDBSOzuw4Xzt1LRd9?=
 =?us-ascii?Q?BxZteh+RqVZJ3R1Fb1YKywtfAKvlzfZdjjDUaCSanRPAcPK+ivZe4qYwj7Ob?=
 =?us-ascii?Q?STuRc2NGmZZXd5GMLOXDwa9iXvP3tbAUl6NWm6y4AIfo5MhYogd8osyLnfNE?=
 =?us-ascii?Q?d9xJVPkdHjxir+fHIEUxkfZu1OFVJ8+tHCvKQ2+qYz6mNkP+Kh85TsTPoaEX?=
 =?us-ascii?Q?cP5jztuFTY7x7sqazXkcEsv3RsZC/l6mEbNqz0dmkZqScVuJhUnlvMJwHFnB?=
 =?us-ascii?Q?aooHCpe6fBHu3UVavvqaTOKTjJS2KUjw5BgA1Q3Gp45Y3NQzlHXwk2CmXzHm?=
 =?us-ascii?Q?Qidf0gDGvdGQGbc642M/Kqgn9u4k193TD07F0oFvGFENl6FwsLwR+xfT40Rx?=
 =?us-ascii?Q?WQpJ7VeonB77r1aSu581lBln0KYNIJ1d9xq9h7O5WIzE91R/4N/+Rj3IN7fp?=
 =?us-ascii?Q?e1Otg6pbCedsFlPgfSPw2GfMOTjfBq4Vb1pIrYZtHdeOaEPT2FZj+LdsSAEC?=
 =?us-ascii?Q?K47O78UpDFWKCwMQwFENtAzdYyXblz3PL8OtJUkUr8rOaL73zCOeUn+lRLqt?=
 =?us-ascii?Q?zubom7f4KdbJNdgmp0empwisSpe4CJWZIRiTliBl7GsD8jbTatJHSgaMFwe1?=
 =?us-ascii?Q?/hxFZd6BnrUhjx0e7H3HFyAiCli2k7JEjbqj1BuDuudhBU+bq502HBUFhWCC?=
 =?us-ascii?Q?YDQ+XvozUV/auIc7EKgwqPr/no9acXxB8QfNcGbDJx+yP+u/p6jk+kEt0a59?=
 =?us-ascii?Q?NOAzmFYtGqWNOdt8sNB+Kn9VVgFVph3i2qewCyjimMypBlJD+6rP/I4mifPL?=
 =?us-ascii?Q?J01ZG1Wu9QrazZ53N+H9nh0IRmynvUMoZWI9fRZFbWeYeb0EWfMNMjks3ZQv?=
 =?us-ascii?Q?xQVe2oTUmR72tghmwaox8QWgw7XxXZ6lfl4Sv+YUTk5WlVYfQZx2uB6l+uU3?=
 =?us-ascii?Q?GtIntYZSyO+letifX/PnqUIUvabvOgXidPYY3/Be9UsfTI0PYhWsC7vyLACS?=
 =?us-ascii?Q?TitmqV1ZNzepbCF8AiDr5L6y69gr9ipHuZ3zaKTK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64de3426-81d8-4da3-490e-08dd30bd1662
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 14:51:24.1432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVUPjDwTpWHwibyJXDwDLWq9OfYnba6dgSaniLXAsYXtjQKR1Vw3mZUprD4vYETU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9350

On Thu, Jan 09, 2025 at 07:53:03AM +0000, Tian, Kevin wrote:

> While at it, @Jason, is immediate_attach still required now?

Sadly yes. 

virtio-iommu hasn't been converted to domain_alloc_paging() yet and it
has a domain finalize function called in attach. I think this is easy
to fix.

arm-smmu-v2 is converted, but it still has the finalize function
during attach only (I failed to fix this).

mtk_iommu and mtk_iommu_v1 both have "domain finalise" functions
by simple grep.

Possibly more issues in the embedded drivers.

However the server drivers (smmuv3, intel, amd, riscv) are all now OK
without it.

Jason
