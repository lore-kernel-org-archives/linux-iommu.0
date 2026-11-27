Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795801343;
	b=0u7uUlVtxXBrNsTusH5q/9QtYnzKWIr8+Vk3VHPuUGl0Cwf+qTqyyt6x4pVHBfV2SrI4
	 2vychvlHDP1lALc3AKAnc0ASOXvwfXQPUJ2kjN75Kx1m+CbdwVISrw17Y5PsXD1H74WAv
	 OqqjEnqge36va8kpKI7YhmT7blEpNahRu182tnYv/v/XIY3CyxfT1lhGnHFP0ZmGg7fgu
	 ih8vXWCJocrDqFwlw7mEAHx49JzIZ15pojnn1yAZk6Wh3JRk3imaN0Psur6IV6/hsguDw
	 WMRFrcW4HfVYLVWVwvKJWcF/M3kLuwgKQl9UKLD44Dox7Bo3//cWYx4qH1JTWzUjrkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795801343;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=VDj2O8t2KRtpKtNO2GYr4XrWk3I2MwZ6ODw2VPpRnd8=;
	b=nTk0jSFkQoFR+4T37RLeSgoyLP1tt825kUtcCNXp45zOj24zhYcz2N9FgBCFKcZz60uq
	 faXTn0kGA3LjJBxJv6xVgdfJIKycG8SG19hKhd2WNza3zDzuJVFfSQi4jU+nsoW8JbtqG
	 i6IUnr4gGroR8Rx5efEkLm5vI67+Uq8yFG+nJ0Ka9MxSygT594i0IC0SVKmDMTRO3fFnK
	 mYcqIsHzLz1VNqk32mgslRaL9VWUtNC/vFCKGiDVlVAs88csCKO9c2e2MYKUoU3KDPiBP
	 W8STVXHSMTmGzD5sqZmbd8W4C9UKemJuz0iA3l3LLrGls+FDdXS0rZq6FK+ayvVxnSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QnWwcdwh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.52
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011052.outbound.protection.outlook.com [40.93.194.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B358D606A31C;
	Fri, 27 Nov 2026 17:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B358D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QnWwcdwh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pk413X7811LAKteYu9UiYkTqyQ0gSt1lB+Giz7E3hr4xjz/vkdeWl/+2jtlMWJIAVk8QQPfqhqm6ih2Q1UujWZDAQ6Y4idp4OUyQ1YdlxdYp4qkztDGMucIBOoIUty787Y+W34RCjfb/rguQ9ZOxsj0joHXXG8sgcM2iPISuTMiEt4MvMiGNzMK5h5vxP4ny6RlXx2108xDWR9VmUj4I75fUWlKH5cB+yS8slaTuGt7Hk7sTeJKBQBTU1Ea+k5JbAzsNF8kqICJcqkZKq0RzS5JfwWjgbioz+gXljY2O+wqL4z/66ZuLCqOrmXktCojfIdaMX7zdjuOUTxv5uEiyig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDj2O8t2KRtpKtNO2GYr4XrWk3I2MwZ6ODw2VPpRnd8=;
 b=Tiv+3v2n971hyAcJjZ+VO5qUV9ZuSlYcg3f7xfyZoLfFKwbFk2FJ0nNkuklUeSXUcCOS2gUVaYa5tKTKLVhAe97Fx/a9eoKlEL4CobhldYdo/SlBFiZ+rKReRM4ljLylTtwaYRpbjgXv1qv5CHSGUZzuOy+vA4jbRsk2ez+qqidfz8H+gXkRePNZ1unHFeqDTURNNF54MeBG8gNyPNjmIL3lCcXhHLsCwfaXdZkJsM5vUcxWihGa8ETKj7elUJyv2AgLZKDhnNxFSCIjahROapJ0Q7dWp8DgCGyDWpqyHQCaAk+74b6XFqUcjnqqQIOKWZcagLCf1df+kwBcvfu7dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDj2O8t2KRtpKtNO2GYr4XrWk3I2MwZ6ODw2VPpRnd8=;
 b=QnWwcdwhj+IdunwUmS2uHYf1jom5G9AuBxEOja9nY2GMQu5AEHuIcQykzIwUO6Mtizn2QaBKnDu45vzCCuiPDoveqA+0v46FAjwWH49rVDh2pbasgp6j4++FEUVVWa9fyff40hZe8SL7EUNePxq9NQnawsBuUnaB/eEkEH4SO4OTuaaQKASeiL3QtL8Gd9dG7l0IyuPejXY+zvDqkm56EWWarHHJ5rHRJU+gaAT6C+drYu8PpEmMXAF6F499HyvRVIEsk3Xs4jms7hOR+K/GAZpQk/lwA1rjmmataELKA9QTpqnAFykt3AgFccTmR5eCRGF0KVtJb+Ivy7hDFC/QUw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CYYPR12MB8655.namprd12.prod.outlook.com
 (2603:10b6:930:c4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 17:42:18 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 17:42:16 +0000
Date: Fri, 27 Nov 2026 13:42:15 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: joro@8bytes.org, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, driver-core@lists.linux.dev,
	Sonang Patel <sonangp@nvidia.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v3 5/7] iommu: Introduce TDISP T=0 state for confidential
 IOMMUs
Message-ID: <20261127174215.GR114472@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
 <07ea92910895a2b0db33afefaa3a0ef182b2968c.1794343501.git.nicolinc@nvidia.com>
 <179563006502.253973.9155049351516451537.b4-review@b4>
 <awe6WgoiKaBTgINn@nvidia.com>
 <20261126145715.GG114472@nvidia.com>
 <awiLcoPfk0xxEL4A@nvidia.com>
 <20261126195346.GJ114472@nvidia.com>
 <awiaoX4RrQPP23OY@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awiaoX4RrQPP23OY@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0273.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::21) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CYYPR12MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c739568-7dd6-44e8-8f17-08df4cadc720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|4143699003|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006|261028144727099003|261102123227099003|261026121527099003|261022105027099003|261021121427099003|261021135927099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	FTM0r3Realu8ibMv0xYl/COXbbazcbNtVd3Foi3vAzR+o7EviosWTNVYTThQUw87UzA7E2uOILkmHeXZqDC6CnnzIlAvy9GPnb/1h90AgxPP1wHfcutlqyKBh0mIBR3+bkLZKnjhxvw1PpGUOzjiPa2MCL26CPURBZd5iFIjmr+dJK1OKx4JtJTPeVpF/Nwttw2RgXSRpqHSfO4mA3T16SqQAYF4kxwyQb5QmMl9wsSuvbFWfR8gxWsSlGjqld5Iwc2HD82MxfOvRf9K2KNdJN2gsmRTdzE9iHWh4mfkXU3yu10Ox5qXvBKukpzA/Mzm13CNPTOfLARAv1+q6KtwmquPOYsU3FkOOi127+tbBh1HcVrA7Q6z9DvrHQsms1zso/VNrg0BerYlT4+yy/V1B7yuDi0qh71XI2+G/TeE//p3jUy8hWer8eyDhNdPRfH3SWwPnyUMv/SV479NTnZqjbDpt0Wh4Qwal8Dak5RIoxuJb5Rz+x+i6zYfnQNsJbBwi54j/9G9k2hwQkUHlyVYK4jzMpPNgStrH0wYD8xcgmyzSv6wVJ7f3wpetcjxWNc94nD+B00YyxNI8DohUm7J9DtHsaqwzuO+WHIK+DlXj7pkTd0FnZ7Q9b+vNnONlmJOcugsXsrPicB84NJEx+cdz29aCXe2fzcARox49jRBZtY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(4143699003)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(261028144727099003)(261102123227099003)(261026121527099003)(261022105027099003)(261021121427099003)(261021135927099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?keryENBlFIASYzLLPjIMbqtIhUApjuYSrAxjJqm0jaZ9qHmW5hSylUaDxAA2?=
 =?us-ascii?Q?UABkFw3ue3bo/RAIriMwedg+Cu9NIL48Lx6BNh+WBN3G8HErkYzkFoAkgQxo?=
 =?us-ascii?Q?xBr/IDQ6aF7+kJ9+CxvFWHwqa1fJzGMLY+ChAc0uEluVDLfbrESn+TiSYnQM?=
 =?us-ascii?Q?LXeOF2dbcK88YAAHcQka2ycwmOz4VDhH0/8bKLvaTD9LPOVPU3ULko5hfT4s?=
 =?us-ascii?Q?5DpzqGgUCdNQtolGwtI2tReHnJTy6dJ5wDRDN8RAlEFSwu1KH1TfATXceaZR?=
 =?us-ascii?Q?Kfs7UNLJpDkSRpt8PBCM77xbIZsXfAW6dD6ci3RG5XAwB0wL+Y862G0USXXX?=
 =?us-ascii?Q?1nFIXEgcWIkgz+Ytf767MszvpoF0v/CXHqJ6OpABu9JKFw4aGDkXyZBOJQ/S?=
 =?us-ascii?Q?CcyNhTf8eUKoT7qPHEEyAU4BZIAdHfeQOlrjtwEjRFaRSGsGlRkRr+84Lix3?=
 =?us-ascii?Q?HOxJihPFOtyiZoLBsV4OoZVgBjrTU2nOOP8RNZte9vTTR40E/1iS8s4NCwuX?=
 =?us-ascii?Q?IfWa2M3VYW2qbexJOEr+i2AEGX3k17EpjGv8hFqSM2tcZSAgQY5H4BaYdp1m?=
 =?us-ascii?Q?z1qpMfP0ExEJNceV6qybLXnDyrVYkP1S3LCUhNpRVKc9MY766PaavuGWKvRe?=
 =?us-ascii?Q?1Sice2p3Qq6ficdsF5KGD0dqEdqpZbF4hD4SKsz9jWz3Yo92SQO+viN7Zl5k?=
 =?us-ascii?Q?Pk20SQP2LysAMQc/kZlLVZcWEOOVSepNTcFZg5zwsy0+OMVMMS9BQB1KOB6a?=
 =?us-ascii?Q?/jWnm9kfc4GO9TM0Gs1v/Kf5TPR2wzsgEq/qRlgspc3LU6EbGjbwtMGXZlXz?=
 =?us-ascii?Q?BHHTDgiATSHkHAD0IYX08oEXX0k8YO+nXyYLqK7H0ZwvlRQEgGVKocJLavGP?=
 =?us-ascii?Q?Vz5ndiKwYHtHCjHalz0KNvpuClRce1Rq2zKIyVS64HkBT92bdQkekSeccJ1K?=
 =?us-ascii?Q?T8VAyDbtH+tfU1oVP4lq+FAzLH9SKeowS2LX7jH89mj5hgbyiU1r9snxw2m1?=
 =?us-ascii?Q?+uIkN4HkUOhUn6x3gBVguSca/RuPe2swDvmHlS3B+vZNjGNixbcKCA8oQH3h?=
 =?us-ascii?Q?gxO+soqBgEiot49ZlZwo8+kYBPIPI93fRN7ArIXodJpG5htgW/W48i6Qr42B?=
 =?us-ascii?Q?vfx7zqrdLHn3BAlqQORA86e/mKEf1Vdbvko+/ZhJH2CTCtx0FPh3lqlm2JvY?=
 =?us-ascii?Q?L0r2xNF1VYCPeIAfDk9LEOjwLS0SCbdT+kK9mKwpwF0pwlSsGwgW3UPu38HJ?=
 =?us-ascii?Q?bGWKThJnyVBVSyfvsW/yjrFpXNTnsBXApbHUOZ2sPuR3TrYBUPTjd2l02nwW?=
 =?us-ascii?Q?4fqobqe0S0mlX4/oohbrMRThOblRPzKOE3zJt2EFSClcTeGECD7s1QrzyuVo?=
 =?us-ascii?Q?omg6KlfX5li9eAZTYLRVAB7iosP2yF28lHhvt5l5qwIPaHaDSpmje+/n7a2o?=
 =?us-ascii?Q?xiTUhEhT3drE5uoo4PNrObQqSUBo4XkVnOZinXMU+7OEawpXxVjI0iGBQI07?=
 =?us-ascii?Q?FjmEC4fir9CYWuldCugzM5LgQAlC1tMUCR2FjMNsi02W39D4LzxTuJgpfC5m?=
 =?us-ascii?Q?1c+sxodIWTz/8TxOJY8bAskMxLLeHM1KHUiYEz/C6DakX+ntWLZDSe5Z8sOb?=
 =?us-ascii?Q?2zcFywe+uKRXHV8KCJ1hzjd4fqiX4TxodLXp0U5mtfbwHp8u5eMBU1eDQ3D0?=
 =?us-ascii?Q?NtueuMy+mOwcgL3NVa9UXt/ZbzpEV4ifML9RdYGZKNIjeloj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c739568-7dd6-44e8-8f17-08df4cadc720
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 17:42:16.4961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LH0ror3Lt8buqf3Nw7QQLSFsGz6wAA1KMkgOI5KIvPVnyJmnCwWomCZkCFn6DvO9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8655

On Thu, Nov 26, 2026 at 12:46:25PM -0800, Nicolin Chen wrote:
> On Thu, Nov 26, 2026 at 03:53:46PM -0400, Jason Gunthorpe wrote:
> > On Thu, Nov 26, 2026 at 11:41:38AM -0800, Nicolin Chen wrote:
> > > On Thu, Nov 26, 2026 at 10:57:15AM -0400, Jason Gunthorpe wrote:
> > > > On Wed, Nov 25, 2026 at 08:49:30PM -0800, Nicolin Chen wrote:
> > > > > On Wed, Nov 25, 2026 at 02:07:45PM -0400, Jason Gunthorpe wrote:
> > > > > > Though I am wondering if we really need the ATS stuff. Why do we need
> > > > > > that? The pci_ats_required() in the hypervisor should force ATS since
> > > > > > the hypervisor is not going to construct a vSTE or use a nesting
> > > > > > domain that would inhibit that? Can we just drop this whole patch?
> > > > > 
> > > > > Ah, you're right. It was added for non-pci_ats_required (non-CXL)
> > > > > cases where the ATS state needs to be in sync with the hypervisor.
> > > > > 
> > > > > However, the justification/usecase here is pci_ats_required alone.
> > > > > 
> > > > > One small concern is whether VMM always exposes the underlying ATS
> > > > > state or not to the guest VM. QEMU seems to do so. I did a test by
> > > > > dropping the patch: lspci in the VM still shows: ATSCtl: Enable+
> > > > 
> > > > It probably shouldn't do that, but it is also not harmful. The guest
> > > > PCI controls should be fully ignored by the VMM..
> > > 
> > > Would a PCI device driver (running in the guest) check the guest
> > > level ATSCtl state for its ATS pathway?
> > > 
> > > If VMM is not supposed to read through the physical config space,
> > > without this patch, I suppose ATSCtl would be disabled and ATS on
> > > RID might not be functional?
> > 
> > VMM does not bind guest vPCI ATS Control to the physical ATS control.
> >
> > ATS is controlled through the vSTE only on all arches.
> > 
> > Without a vIOMMU ATS is controlled entirely by host preference ie
> > always on if available usualy.
> >
> > There is no need for the guest to read or write the vPCI ATS config
> > space, but it does anyhow because it doesn't know it is a guest.
> 
> Hmm, I think we are talking about different layers.
> 
> I get that the physical ATS control is decided by either vSTE or
> the hypervisor.
> 
> But both the ATSCtl state and pdev->ats_enabled, in the guest OS,
> reflect the vPCI status.
> 
> Since VMM isn't supposed to read through the physical PCI config
> space, the ATSCtl state would be disabled.

The VMM needs to see that ATS is available on the vPCI capabilities.

> And pdev->ats_enabled would not be set, after we drop this patch.

> I agree that there is no need for the guest PCI device driver to
> read those two vPCI-related states, but if it ever tests either
> of them and gates its ATS pathway on it, this can break, right?

Normally the guest without a viommu will not do anything with ATS, but
the hypervisor forces it on for the guest. This is OK because without
a viommu there is no invalidation to worry about.

So the ATS state in the guest was never correct anyhow and we just
happily ignore it and appreciate that the hypervisor forced it on for
us.

When we added the viommu then the viommu has to control the ATS
because it is responsible to issue the ATS invalidations, so now ATS
is controlled via the vSTE EATS, not through the PCIe config space.

When we add CC we create a new problem, the VMM no longer sees the
secure vSTE so it cannot use that to drive the ATS anymore.

Instead the VMM is going to have to emulate the ATS enable bit and
route to a VMM controlled vSTE for the T=0 translation. When the
device is in T=1 mode, and a vIOMMU is enabled then it should reflect
the ATS enable into EATS on the non-secure vIOMMU.

Otherwise, in T=0 mode, when there is no vIOMMU, it should continue to
rely on the host kernel to set ATS to whatever it wants when it
attaches a simple S2 domain.

Thus, in T=0 mode there is no reason for the VMM to manipulate the
ATS, just like it doesn't manipulate it when there is no IOMMU driver.

Jason
