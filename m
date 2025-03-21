Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08C022DF84
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577961; cv=fail; b=pc8LsknAe2Jnk6WvtA4p2D4Xgz/sslynuKPsstA1gDUQnd73tkPlXf3AYkZhrM5mr5oL9Qn3SJOZPpvNZTbD6N6aTvC6BJUkHa2G9Zn1SW1vA6y3/cCeSdmCWQZHjuaHAeQ5LYoiVtv/VR/6i9UDJdONrw3atIhK1urQkWbOQqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577961; c=relaxed/simple;
	bh=T2oia1qtzraeU2z0zwFs3dW6sub/rXl4ZFe/G2yNVVI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ac+GFRtmKInrOn972HE5YXNLr/UxeIqMFYZcoao9bs7Pm+peSu3gQZjiXpkHQMejr0pPDW10EaU1gC50cGpTcKH6qNwCIsSbG9TjOo0JmrMMBGSeCBb/w9eHGNkoNP5Q1FcsQKgP8ubJCWwWlWxKQRUimXSTFOBv5vAdPBsPf6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WEwsYrZM; arc=fail smtp.client-ip=40.107.96.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WEwsYrZM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZwglNvm+MnrBWi3fuJ/stP1yIswSHo88o2OipBR4fhjn0duFoLDTS98ykvT3oqk4XHhQcVDV8SDlfGMMwWVRs/+sghbKNp0AYNX/apkWJeeQPsOUxFw5gKanTmSOCnYc9Ygizt6qUhBKHWOuNbfHOhFo1Gv7QknPS4elxuWGlVCskykc+Mx2w/bCWFdAjvA5P6wHVvcGEwSqpUAWAiEMvJEYrG6ljoVMqbSCzxn0wuXlBAeuHMYDPsLeegh9Z5PaiCuLRDa1H3b0x2S24vHqj2znf/5JHL+gfKc7Y3BTAwo683RFIrolGDb7mZ0e9MlO/GiQVAEMGYILoknZJyTAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=av3W9SWb8p3hsJHIvNordpdcnjscPhrtIyQ+yd4rOA0=;
 b=qD6/xGmqg1pg+D7J5pb4ECLpJItCKOl2HWTvFdx5Rvc3n5AyGkH1w03cqlMPIw/pqukh4KYGj4pWg51zhILj40LNiamcj8mMcNmOBbq7UalHsAJNnWpgrbF5nlrJeQCJsS9cDmoskJp4Cu/KJ3RNqdxxI3bApFWTYhuA+WtmRULErqc+OZm/RsMLrCsHZRI05VAfd9UDUaR9sf5a+Qq7iVxweD9dxHfgIjFu96e5pDtCO++MfFm9hG0vnJS5d/7gokbWbRVQNzSfbiI8SDWcSF8OxIkL97Yc3dV8PFa4mQYS2sV8EaA4wUbeltLXWudW50+rEPdCtn0bzxYKEEARuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=av3W9SWb8p3hsJHIvNordpdcnjscPhrtIyQ+yd4rOA0=;
 b=WEwsYrZMTkCGP59m8YReIaT1DjCiOzj15qhtokcXTTUAcxxyB40IBTqtTHOs2jzU8+DrIGjHV2u+rs+bBRVo6bcdObEUvLhXoojkUmUGctrp0g522317RFDW6joAKuscqHt6s3b58i0LxU3nC7KTl4FZsmSlyUMD3FKyh9ClDQCvPXSB4uQFSVJMiMUOUa8L5y6OdJMuX6gJtRS9cUQY0UZH+u4Zf5+Y2QTAuDey5JE40lqCTZtgWUjA07GzMseRuD3tdaftr7YKIiSeOZwka6IcTuYBwNLk0f59xNJ4fVDPCFlzn+GIMk6DFxY5//WRpp7ZKBiHgBl/p9zehAB6ig==
Received: from CH0PR03CA0048.namprd03.prod.outlook.com (2603:10b6:610:b3::23)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 17:25:51 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::6b) by CH0PR03CA0048.outlook.office365.com
 (2603:10b6:610:b3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Fri,
 21 Mar 2025 17:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 17:25:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 21 Mar
 2025 10:25:36 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 21 Mar
 2025 10:25:36 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 21 Mar 2025 10:25:35 -0700
Date: Fri, 21 Mar 2025 10:25:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v10 17/18] iommufd/selftest: Add test ops to test pasid
 attach/detach
Message-ID: <Z92hDhpio9bQPb+4@Asurada-Nvidia>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-18-yi.l.liu@intel.com>
 <Z9yiIEaWyMGyyc2A@Asurada-Nvidia>
 <d9d9b35b-0c28-4562-88ba-dad9118fd3ea@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d9d9b35b-0c28-4562-88ba-dad9118fd3ea@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 852774fe-e7e3-4c55-7fde-08dd689d6cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iao8cEsTx7OuMHUHLRxgyBVsWxyQQAv8AOgp2yAgs9HLCTQCjlIazm9iUchM?=
 =?us-ascii?Q?ryhCP0cs3z7bIv487TAn9+aUjw1sli8s08YZbd3gtVTJrG4XhFHFRn11XqyQ?=
 =?us-ascii?Q?8joIixezqGRDwDzMzrEi0h94I3/0f89XYaPYmWHySN7+zgQ8myLZ2kNr8qq7?=
 =?us-ascii?Q?jfhz3p9hAvwA8GVQcDPvv/nxRMgkUlJ2Lwu9pcdqM/b2Wj45KVwsXngD+jFx?=
 =?us-ascii?Q?1onAPuGcL182BjYaGc16dm1J/FFEfjfnG/WP2zZxc8Afpu/fnJxr2PvenfnE?=
 =?us-ascii?Q?0fU5tbuHHODuvhRA7rKWZhhqkSrD4KoHnQrYJkHIUjo8RPrGMT83u9F27auR?=
 =?us-ascii?Q?QjJGkDehM1GMYFARUkTqPc5YPcxvdlvLwKMIqrqRj5FuZmJVVIaXPxy8A7wi?=
 =?us-ascii?Q?ZwZQV4pGwj+RsGtcPiEbVejulNJttlWATcSdhgo6VOB+lqtKfaeJ6e9Vzfuv?=
 =?us-ascii?Q?o7Kn4aVRejdwABIMuYC/ZtyFOS3/Nw9SxyPoNZn24cjC1PaTYEVFtIfplAyZ?=
 =?us-ascii?Q?L2AqDWiD2QQJ3VpzKEEhfi6wYMMXXRx+WNfGCs3df5L5LMv2PyweW7tzLVl5?=
 =?us-ascii?Q?pr1vDTfwKDvL1VZ4T9wu6RPGsbcH3WAi6ZHexeQGeVYOGYF4+lY2E8TGGcbg?=
 =?us-ascii?Q?2S1W7xBqwD9DadVLwq87xplUcmmOPILtEfHCeXBPfGaXYA5KcqMp6G+4GL0S?=
 =?us-ascii?Q?FO9GhWrhK7CgrjoituqaV4I3Tg2JDMbICzhZKACvuuuLdVqX/L6bJFLkCPJL?=
 =?us-ascii?Q?Xs5D9ZLR3Mnh8uMLoVf41DZoQyhz9y+6sGWqJvVgUOEoxgyT72CT1qCqADI/?=
 =?us-ascii?Q?LCUkOZO9PxLRehC6fIgFywcS/42ddG7sZy461tNUJMXA8fgndhSS+1HgiIrv?=
 =?us-ascii?Q?nTLRVUwUAJ9dO/XT78g1dhWbN5i6DW8Zin7QIKHdoAY/fpoEKWEYwFAjPMQq?=
 =?us-ascii?Q?+9iTygri5eyWfjnQXsbHuSw0Id1ZvBEHQ7C4CqGWmpXNYGvuFjZXO2t27BEX?=
 =?us-ascii?Q?3hAgT2o3fZpPjMilmJkKe9E3BqIotNXJRxXhpNOfrDmY3Po9e8nmBte3qAXV?=
 =?us-ascii?Q?jxieDUz2tKVpPw3u0jOVJoADySASQH03LOQG+OnKWYKk3ouCAMGAN0H2vt/u?=
 =?us-ascii?Q?C5J/Re9ghcocVvI20f6lKP89pnp48inRRIiXkwumqS52Rcdx9zpViP6Of03n?=
 =?us-ascii?Q?MCFC1g57T+gW1JAxSJprswBuvdG4Stji2aHTNIUBDFVksJdYte7MJBCDlwQ8?=
 =?us-ascii?Q?jaF1Q6rnb4Xjx8g0muYZv5mI7s2NtgnRO2BKT1a85Xcpm3H6Z4aLZV2KbHMx?=
 =?us-ascii?Q?ANKM7GJMDR31zriH4MunHoTVcavrg/rKLL3Rt9EXSauPXhOdYWmI8+0zc4ww?=
 =?us-ascii?Q?H1/AYFqZluQASfE8pcRepp45uF0jwiIJQLWtMhx8YL+9WkNDCBCIfBVbXb21?=
 =?us-ascii?Q?ofp43Qb4WK9wP5AOO5TwODngK1UAdSnK4p/ASpbPnHS8WJXsCJsSxduwVT/P?=
 =?us-ascii?Q?I23ifPKfMNn+PoM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 17:25:50.0812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 852774fe-e7e3-4c55-7fde-08dd689d6cdf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075

On Fri, Mar 21, 2025 at 09:43:48AM +0800, Yi Liu wrote:
> On 2025/3/21 07:17, Nicolin Chen wrote:
> > On Thu, Mar 20, 2025 at 06:47:43AM -0700, Yi Liu wrote:
> > > @@ -150,6 +155,32 @@ struct iommu_test_cmd {
> > >   		struct {
> > >   			__u32 dev_id;
> > >   		} trigger_vevent;
> > > +		struct {
> > > +			__u32 pasid;
> > > +			__u32 pt_id;
> > > +			/* @id is stdev_id
> > > +			 * pasid#1024 is for special test, do not use it
> > > +			 * in normal case.
> > > +			 */
> > 
> > How about add on top of these structs:
> > #define IOMMU_TEST_PASID_RESERVED 1024
> 
> yep
> 
> > Also, the coding style of the multi-line comments is a bit odd.
> 
> yeah, but it cannot be finished in one line. And I think it is necessary
> to add it to note how userspace should set the id field and pasid field.

At least multi-line comments in general should be:
 /*
  * abc
  * efg
  */

And I think now we have IOMMU_TEST_PASID_RESERVED, we can move
that line of "pasid" to the macro, so what's left will be just
"@id is stdev_id".

> > > diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> > > index 691e7a23f300..37c9cd285541 100644
> > > --- a/drivers/iommu/iommufd/selftest.c
> > > +++ b/drivers/iommu/iommufd/selftest.c
> > > @@ -223,10 +223,29 @@ static int mock_domain_nop_attach(struct iommu_domain *domain,
> > >   	return 0;
> > >   }
> > > +static bool pasid_1024_attached;
> > 
> > I recall syzkaller would do multi-threading... We might need a
> > global mutex or something atomic_t?
> 
> maybe move it to mdev as Jason suggested in another email.

Yes

> > > +	 * This is helpful to test the case in which the iommu core needs
> > > +	 * to rollback to old domain due to driver failure.
> > > +	 */
> > > +	if (pasid == 1024) {
> > > +		if (domain->type == IOMMU_DOMAIN_BLOCKED) {
> > > +			pasid_1024_attached = false;
> > > +		} else if (pasid_1024_attached) {
> > > +			pasid_1024_attached = false;
> > > +			// Fake an error to fail the replacement
> > > +			return -ENOMEM;
> > 
> > /* Fake an error to fail the replacement */
> > 
> > While failing this, why does it detach pasid-1024? Maybe some extra
> > comments for what's doing?
> 
> do you mean when does it detach?

So, this after all is a "toggle-to-fake-an-error" thing, right?
Let's make it straightforward then: "fake_attach_error" or so?

> > > +static int iommufd_test_pasid_check_domain(struct iommufd_ucmd *ucmd,
> > > +					   struct iommu_test_cmd *cmd)
> > > +{
> > > +	struct iommu_domain *attached_domain, *expect_domain = NULL;
> > > +	struct iommufd_hw_pagetable *hwpt = NULL;
> > > +	struct iommu_attach_handle *handle;
> > > +	struct selftest_obj *sobj;
> > > +	struct mock_dev *mdev;
> > > +	bool result;
> > > +	int rc = 0;
> > > +
> > > +	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
> > > +	if (IS_ERR(sobj))
> > > +		return PTR_ERR(sobj);
> > > +
> > > +	mdev = sobj->idev.mock_dev;
> > > +
> > > +	handle = iommu_attach_handle_get(mdev->dev.iommu_group,
> > > +					 cmd->pasid_check.pasid, 0);
> > > +	if (IS_ERR(handle))
> > > +		attached_domain = NULL;
> > > +	else
> > > +		attached_domain = handle->domain;
> > > +
> > > +	if (cmd->pasid_check.hwpt_id) {
> > > +		hwpt = iommufd_get_hwpt(ucmd, cmd->pasid_check.hwpt_id);
> > > +		if (IS_ERR(hwpt)) {
> > 
> > Do we need cmd->pasid_check.hwpt_id to be optional?
> 
> not intend to make it optional. just wants to use 0 as a special
> value hence no need to retrieve hwpt. Hence be able to check if this
> pasid is attached or not.
> 
> > 
> > > +			rc = PTR_ERR(hwpt);
> > > +			goto out_put_dev;
> > > +		}
> > > +		expect_domain = hwpt->domain;
> > > +	}
> > > +
> > > +	result = (attached_domain == expect_domain) ? 1 : 0;
> > > +	if (copy_to_user(u64_to_user_ptr(cmd->pasid_check.out_result_ptr),
> > > +			 &result, sizeof(result)))
> > > +		rc = -EFAULT;
> > 
> > If we do want it to be optional, we can't unconditionally check the
> > result then?

I have the other reply that I think we may try getting rid of the
"result" and just use the ioctl return value to tell user space
tester whether everything is okay or not, given that all the user
space expects is a succeeded "result".

> > > +static int iommufd_test_pasid_replace(struct iommufd_ucmd *ucmd,
> > > +				      struct iommu_test_cmd *cmd)
> > > +{
> > > +	struct selftest_obj *sobj;
> > > +	int rc;
> > > +
> > > +	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
> > > +	if (IS_ERR(sobj))
> > > +		return PTR_ERR(sobj);
> > > +
> > > +	rc = iommufd_device_replace(sobj->idev.idev, cmd->pasid_attach.pasid,
> > > +				    &cmd->pasid_attach.pt_id);
> > > +	if (rc)
> > > +		goto out_sobj;
> > > +
> > > +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> > > +
> > > +out_sobj:
> > > +	iommufd_put_object(ucmd->ictx, &sobj->obj);
> > > +	return rc;
> > 
> > If iommufd_ucmd_respond fails, do we need to revert like we do in
> > iommufd_test_pasid_attach()?
> 
> It should be reverting to the old hwpt. It lacks of a helper to get the old
> hwpt so far. I can add one since we have pasid_attach array now. But it
> ends up with helpers used only by selftest which is not so positive. Also,
> it requires a mock_dev->lock to sync the attach/replace/detach. Then I
> found iommufd_test_mock_domain_replace() just returns without revert. So
> I chose the simpler way.

Yea, I see that the existing replace() doesn't revert either, so
I think we can be fine with this too. If anything bad happen to
a basic iommufd_ucmd_respond, the test wouldn't probably finish
anyway to provide us an accurate result.

Thanks
Nicolin
