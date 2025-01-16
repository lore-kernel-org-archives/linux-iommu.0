Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156F022C9F7
	for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 20:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737059653; cv=fail; b=mT0oOuo0FpwD8sO/ydP+WTPBQSAQAZHfdjVTMj8SO6zDIKkUE1L6d2DhroV1QX01K+T/z2Oh/ubZvsHOPnYftIgi4zQhJNAUFOEpD26onaqs596qq4fjZM1FTPJ3OQnoYnK+lM4evovEx18bXYYAMAW8K8hJW1aGjwMANpid1Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737059653; c=relaxed/simple;
	bh=FBT2u730yuI5thMAcFsOGGVaCifWvBr6i+QkCvjQ47A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WSls4wAo2ojUrhCL/bCyVdyASoMirkBe+ZaD8TAsvurxhAQvEFOjzcE0ETAi72+WkE5yvkxQXGpfqfA646kXKnxohnv0tMHC6m6ZfPzOBYRx46BmykK4uvW3A3J/4CLVDFAKF1WPxiKUWMv55xj2t/jmY6E2ZLL+OMUtLWfiTMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gXsMawVp; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gXsMawVp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLZqlOk5zwqG1hA1XeDeQ808At7/qnNRgnGFvkmOIDGkZTZh+ir5rL8QWq5McBB5ckVgaXo4wG8U55SLd4sZWnWSKa6n3nKi0PMLs6cFWe24YTW8gMQ/YyKLVswW5feRcp57xMENxYYEoiB6M6bK7gxW/qoIDqkOLHFmAxxZOOkPs8hhg+zHlv71hIq+mc+2jucd4kjRWXJ2WaqZ/3tIBz6emAE+r+lNHKOPatrdbJQDKJkjdu4q6mNjkolioCzK6BVSFn/sRiw8qfp/ijrRGdT7/PhiC8sGABK0BzeLhx+CATMvHpS/I8DOuHT45Jxwk9J3PDsakDByll/FVRNuSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDuHa2JKGtYaWwMNPtw5Lewu+kBBEnPW5Jap7kAGg7U=;
 b=K/wtwj5+vQDWOHIvLJBJvMrLtjoF/P5/ABBYWUSltXkf2o5UHorCB+75B6h4i5kv59qFUBPHUUg3OnbBc3lZXXDRbs14+E4iFjy6g0qmkrvJCypZOdc7rL4EyHuPZApSmU69DOOd+JOhV6xSZO2fYC/N2fbNeHBEmVutqcLWx4hDkl+FddBYeVcyNzokFS3nbIc5Wm36HQmMU5DfcrjR2u6UlDiuUxAAcR4bkYc/TEOLf1vTMiZgVOB87g3mXXXVZvJyU6Me16uOu07HC00zh91V6uXuWWc0zMu4HOXjC7oCj1kOCmSiwJxio0xhgvzFpEZRfvg2gASHqz5t8xshkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDuHa2JKGtYaWwMNPtw5Lewu+kBBEnPW5Jap7kAGg7U=;
 b=gXsMawVpuIZ9NJWlSV9ouZEGorBD2OHoX35aEOMLOIGtFhNL6PP8ZOpxQWL4QdpWX6MygJDkUtDZeObIpOqT5AugXkIrkkPk7GvhwFMdHtWJvOhR/UuOupAgGgc5O2dLO3WByshnV/csioCrMgxAyuTil0g9rPZHYRPaMa519seEAsFAr+m0JxLTOl7VlairPgXWt67HvZKj47d/FfrXmsrNU+tLsdChMiujSaJnMf03CDAxRDSVDeNnRXlRXu9PEmR6oBzScLZgUQra5vZkIeqk6cQflmSiXK+IiiZfpybyUx+0g/GwWw6mvq9LAo1oFHbfg7W//9tDBf6+64arAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 20:34:08 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8335.017; Thu, 16 Jan 2025
 20:34:08 +0000
Date: Thu, 16 Jan 2025 16:34:06 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com
Subject: Re: [PATCH rc v2 2/2] iommufd/fault: Use a separate spinlock to
 protect fault->deliver list
Message-ID: <20250116203406.GY5556@nvidia.com>
References: <cover.1736923732.git.nicolinc@nvidia.com>
 <b727b09df331658f9bead42d6340e942e71a4cb3.1736923732.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b727b09df331658f9bead42d6340e942e71a4cb3.1736923732.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: b02041d1-626f-4056-cace-08dd366d205b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UTR4Jh7W1/a/rareRnmZ9gG7auhh2N+SwpGdzARJeneuCr0aUSz5BCjl7koB?=
 =?us-ascii?Q?0mZ545e3eBpruROmUY+EM+ZIcnQWaGee/37eHoE2SrCA0nVcbujhLYnSXhSL?=
 =?us-ascii?Q?qYya1oBpSMukv5NpjNqM2RqUWz6CVi/EpPlLZzmyok4BvKoC80/DzJio7Rmi?=
 =?us-ascii?Q?ZDr15lnnGtklWsaC4fcBG3kyZDAiuMQRps0cOtPqkOl8cRcYJgvalsKRtWnL?=
 =?us-ascii?Q?7eKSllwrGn56T6YmEmxdgF/vZru4Q0uHSNIVGfSBE61W0/LcJDiiL8b9Ub5s?=
 =?us-ascii?Q?ixojb8C+ALQfJJpWa3Bt3Yb/ZdtQSwULmZXdA1Ygprug+r0EAF+NJ69GICj6?=
 =?us-ascii?Q?XsyM8SGLKD4Kh79t5Ej8UWsIPeA7PxqKiYMLNC7bKCXJXNaKQqQrVwCCxvYf?=
 =?us-ascii?Q?8qp+wNJ5j44autv05eELLtFeqdI+Oup/NPe2fcqgXToTG1rlXeF9Y6wLxsUK?=
 =?us-ascii?Q?il7annTmvC2WoXNiF8/FEpg1KkKRdbyT9HHciphBKAkehZGBovD0smwwzt7j?=
 =?us-ascii?Q?yIY0XI95f92XobT5tbpoIuw+Fe/3JuTq0V6qDJPlZSqVI2ItTotcnKPnoh12?=
 =?us-ascii?Q?sQ8yX33UuzOGv4mTX5gJrkTxclrq8LiTP2hlIZdW8QjStVWGGeCZdKtFgt8H?=
 =?us-ascii?Q?CV2ekZ1Fv/dmciGnR5Gy1aQ3ECayPkzB1i1LsC5BMvV58Vb8gBxqprIR34Nx?=
 =?us-ascii?Q?kPdsxoFIivAYL1dlNQZXdMzbN/ku8HdEXl2m0Poxz+iu1IpuJd3vvlylIXTo?=
 =?us-ascii?Q?ZrNbqpvvc8WnW90CyD4EPu/vc/pD9xOpX8SH+4r2yFjxnnvzu5JoCWgFl0fQ?=
 =?us-ascii?Q?M9vLeUgO27tfxQq/Vy+GUKZyy+P/wvz/cKLBkE4s7jTF7wnkSqzSleIkhcX5?=
 =?us-ascii?Q?BjY3r7URGJyMpB39lWzzVnboBLWxwLYpptQvjdmiojA+N/8536MYBX2jBJhB?=
 =?us-ascii?Q?jFbpKvqEzNtZgIIMraS0yPioSTwjn/tBFUZex68VYh7cJdXeykZUXVByG+bj?=
 =?us-ascii?Q?5e/yVPyUE01cG2L+EeOXCMVfRXXl2ADDQ296KWbCRP1GOnR+4f/kWDyzSE9A?=
 =?us-ascii?Q?EOKdBMvpHe25UNC9n/gkZLOG1xddrMyfAXlCqHWYg9TqZ9dyObr7woThUjpt?=
 =?us-ascii?Q?icov21ubJ+Dm6euW2i/TxBRz8a1RMiYhtPEBABBR0E1Dl735X+59iYmdmblf?=
 =?us-ascii?Q?B2iKxVpLF5VZ1bz0gSx4DVjp++Ju15zwO4Lr90Ay24gfA1BPxys1y1l+LZ2u?=
 =?us-ascii?Q?3i1SU+nMv13E99tGnvcGcc3o76TFoLc+PZbj+YgKv4wTxLFrvgXCmwiLzY50?=
 =?us-ascii?Q?VSZTKWmEh/8SuUM9b2HodxDIj8VilaDoSrZ0WWcxPhPY9fbv9j1nZX33yW7I?=
 =?us-ascii?Q?3XWsOmbX697b4hHN+rk0qbDWpps9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uPRrpxXVrSEJMs6LI2GMm0ss8Ub70CZwVTvAfg8X2vZX2NqGR9nAcz7vY4Ur?=
 =?us-ascii?Q?y5lPoAtIbmjSpi093+ynnEiZcT33GXKoQD52AItibyA5iXPsvb95LiWgOohx?=
 =?us-ascii?Q?m0lF/WpVcS8Z5s6MLhBNCUkB80drBe9b/co8yqnBxiniqjy6vKdpG0hOmwLV?=
 =?us-ascii?Q?2hxdjN6nQUbI978qhQs6+9DsZ8et3qnO8N6Bk7ZRHjaWtN24tHJaghHbMdYl?=
 =?us-ascii?Q?ThYek6bcYp4b5HStbc92KRdHU2V1YdmB2JHIegbaewCW4MbvKUhKXCdv69Mp?=
 =?us-ascii?Q?Vh65Ic9GkdT0XdqoDTYgoRBysa7Y/YJAbyAh3Cn/tWZmvUEHsH+7OmskYO6B?=
 =?us-ascii?Q?Rdp3cr+HCY+N+8W4h3bwcg3ETgGrxmBQKxbMu7astkNITOPk5IuXeP1Eh4jY?=
 =?us-ascii?Q?SVceknAxA+iteE7k7bdtCUtpWLIEykutpNhZPrQAVjGc+FTCdu4t0h+EJGGF?=
 =?us-ascii?Q?H0+ERr58lVCPsfRhgewwS+8ANqMY6JzFomE+J94mWddFkrsXR/wRBTsCgO2A?=
 =?us-ascii?Q?QpXOsb1u4LhLPPXkaZGIK0j+MMgG0czbJ7rXZAbXroGncXoznV01SaXwC6RC?=
 =?us-ascii?Q?+OwhYu49HyNcX1ky16EJNlFFeODrJC2HTD7f2Wb1LNSscrb3+c6iRM5yTeJ5?=
 =?us-ascii?Q?CVCrxxxXS93kgTxjiBmL4Pqg5eINEl5Yjr5qIRxk+oc6XyYbM8Q3TMpL2gUr?=
 =?us-ascii?Q?H7dlNe2ThAEguWvko74UDa+Nvo49sq30sySju8Hm6zD4g+JvfnqUAtIFQ7Vp?=
 =?us-ascii?Q?A9JyxYV5ghQEQyat0da7g0h2ZC6r9SEgpEJJVhqYbsAdKL/t/KNsbhNZtSrl?=
 =?us-ascii?Q?09deaRBaTgQSSJ6xxOPFh/fYZBZTk+4w3mPGC05Heu0/Y+sG+C3ZmAydImR6?=
 =?us-ascii?Q?BxDD6P66xMYgdP+wo7RAYBsoWNhXN+FcxaqawrIAScvj6QJX1Upat/b25Wld?=
 =?us-ascii?Q?gFeCML0PSMWwshA5Q6GPqnpfK6HY0PrWUMOWcgtSvo/Fq2hwhSnlkEASoVYu?=
 =?us-ascii?Q?/Ap1iLcSaBoJgZfI7dGZItB3grSybdwcSWBtMBgymf0C/tiWdY3siDDZlyet?=
 =?us-ascii?Q?SeQwxfWZDDlRgfT8MDhk8Fq4Sv22+uyQSKctnkyjlO7Dn8tzp9KNU+iACckH?=
 =?us-ascii?Q?uShoDoRlW9eK7+qswVJ7osurpLpGRPmL7j9h+mmut7alqYvhF8HItbcSRbby?=
 =?us-ascii?Q?1sUzCWj7bRwQMgn1IpphquiUoIGI3J6f1K2X6VrBzI0aUlGkpQiSgeEDuzV5?=
 =?us-ascii?Q?uC91dhbdXrrAyxeCuc1bbm0vfmiQylLKejekS5hDwqs8CCFymk3CSbLG3BMR?=
 =?us-ascii?Q?5ENuZpSUTmRst7sdxI6DZO3SNAcz5/Im/UEOn/fpC4C16t/L6ykGGgJ3eoZz?=
 =?us-ascii?Q?w6jT1jjKHu6/0yHq6oNlXZNvcG2BDkk1nJlNm2NYrOX8Fy+QtqKTobstjtKH?=
 =?us-ascii?Q?xo1tfjrpMb1E7riXB3gfD1U/OYDWF0N91j5Dy+rzO7giPK74ehM+cSUsSmIq?=
 =?us-ascii?Q?5XNVO3Ou5DxlX6qCt9E3884vKbNpo7/dVVllwoPBqFshlfV5tPTVIpO16ziu?=
 =?us-ascii?Q?0df0GBcLHL8mc8gR0ByX8JT4+Q0CbAtDp+4vVvUd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02041d1-626f-4056-cace-08dd366d205b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 20:34:07.9917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycyVplfIRFbCttv82iOCywqVIwj44JJZCcMEI5p18izKTJLGGolHDtllcYT6alpx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258

On Tue, Jan 14, 2025 at 10:56:00PM -0800, Nicolin Chen wrote:
> @@ -102,17 +102,18 @@ static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
>  					 struct iommufd_attach_handle *handle)
>  {
>  	struct iommufd_fault *fault = hwpt->fault;
> -	struct iopf_group *group, *next;
> +	struct iopf_group *group;
>  	unsigned long index;
>  
>  	if (!fault)
>  		return;
>  
>  	mutex_lock(&fault->mutex);
> -	list_for_each_entry_safe(group, next, &fault->deliver, node) {
> -		if (group->attach_handle != &handle->handle)
> +	while ((group = iommufd_fault_deliver_fetch(fault))) {
> +		if (group->attach_handle != &handle->handle) {
> +			iommufd_fault_deliver_restore(fault, group);
>  			continue;
> -		list_del(&group->node);
> +		}

I think this does not work, if we take the 'if attach_handle' leg then
restore will put the same entry back into the front and the next fetch
will pick it up and then it infinite loops without forward progress.

To make this algorithm work I suggest to do a
list_for_each_entry_safe() under the spinlock and list_move each
matching entry to a temporary list on the stack.

Then you can drop the spinlock and run over the temporary list doing this:

> @@ -221,8 +222,7 @@ void iommufd_fault_destroy(struct iommufd_object *obj)
>  	 * accessing this pointer. Therefore, acquiring the mutex here
>  	 * is unnecessary.
>  	 */
> -	list_for_each_entry_safe(group, next, &fault->deliver, node) {
> -		list_del(&group->node);

The comment above says there is no concurrency so no locking is
necessary. I'd leave it alone and just leat it be the efficient
list_for_each_entry_safe()

Jason
