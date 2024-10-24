Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FBA204920
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796024; cv=fail; b=Rd/nEcYgj9f3tlWozllsqq8/tU9mIFbw424RKmJqGX5fkngMzEsr90o/Yl9H8FfiKUhtGfPudBb3UVyZcAbgi4J5XrbsR6qIJE4Tp6OaC0bPEmoHiViYP5X2LvYFL+0cAKUSwdIouVO5DL6JXUOnqBG7Cxmn6Ic1Vfud6H31KlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796024; c=relaxed/simple;
	bh=E0YE67BcTig8gWd9/hjEnZ2NFz2fRFqQLGmWk2aoocs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhV/OYDJpUQru1qhUI/7kZTcYEfcWOBtgnGyte1PcNUNXX9Y8N402mHzXiBv6Skki2hlpg9YNYap6+VJwmad/VF4lgmroCI5y/gJhJ6SuUfNQs8jFY0W0kmHdPzIxxC8o907ed8dz6h/A0Ja0e36xj47PkkKBVVeIOI6arbQ7w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KWr1i4qp; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KWr1i4qp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOqTGWL5/yYcOVJUq9J14FjuZT8VDF/Fb9E5QBABnLg5POgNmackhu5fi+ldobsVOf6PWwuLb9O1yGjy+Jod7ETJfVC3vXpEW3j8dIrTRdT/QuUd5aex89QtI88aYsFqi54fGXVJxoeRFEOasUFZcv/oB4BGmM485QxScJRv4pXARWIvD8L4hUB1mLK+o1r6rszHOUoX1kfOCA0ktxCenEpoa6Fye9n1DsqIyFHDtpMjsIol1d3cc55MzCxdvfhID4tyZLI+WJ4eR0ut2q3ANqdMXLHfPhGGCKFAI2WnoUOS62lfqmyLQ/utq5QAyAI5lCy5y2S2acvYdi7zdehZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mx92O7dIxPAQabX2CBXP0TnVgBpefDdiqNvvDVqQXI4=;
 b=VUBRHZM1XTM/H3q41g4V3q1s/PdK6IwnIWh1f2DSmkPMJBUiyW9bqx3IHczsQuFN5IayCcx2NoPcYxY3o5QcQip+7p/DLrbOIhpB662mre1m/6gkuGz6DQwAyVEd60ZcQTa2UrgJHLb9M0yDqPQzCRYcxjIZ0bHGt423yF+7Se+GS6OXwCDdOJr6NMCUC1xpqRUrchGnzoB51WAWBb/psyTdb5rrzsQ1zzBQvWa+rfAs/+lE9ZE2ERCh2q/o+0GRWxPbb6v9hSPBKozqVGb6vpLu+KEcmyoCn3ZIIWGcHw9VcDEgbhG7UKEeNGYfx5ML3ByytxeM2V/WaqRft2FCAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mx92O7dIxPAQabX2CBXP0TnVgBpefDdiqNvvDVqQXI4=;
 b=KWr1i4qpQmYMiHSNxeroRqn3tI9kd+VOp0wkClPRtUggs3Phw5x5BaqECHoGetHt6gioEpw1tqyk+j2zibqrp5i5c91x/9o6vzprkgNJ1cW66FnhEPM6W2gHGffMHMQ66rvrof0gcK1FgJY+wIJptB7OS/ln8dWJldBMOLaMF0R/NTU6PLIXF7ZVawBRK9lOvRZO3kOnPPuhuLtJ7TTfGeVZCVPBCDAXfKY1/66MTA3U+HT55+nJDwc2PIuuGB+yIrqvjrIv3dWG4DGWCe2c0rxFxYnMf/+X1JZkZ3GwnoiJY4itxrMWWAkWVq84uTHXvsXKLvRw7/bA56KrbSFkNg==
Received: from BYAPR02CA0062.namprd02.prod.outlook.com (2603:10b6:a03:54::39)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Thu, 24 Oct
 2024 18:53:36 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:54:cafe::42) by BYAPR02CA0062.outlook.office365.com
 (2603:10b6:a03:54::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19 via Frontend
 Transport; Thu, 24 Oct 2024 18:53:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 18:53:35 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 11:53:20 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 11:53:20 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 24 Oct 2024 11:53:19 -0700
Date: Thu, 24 Oct 2024 11:53:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
CC: <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>
Subject: Re: [PATCH V6 9/9] iommufd: map file selftest
Message-ID: <ZxqXnnANqpeFq7XA@Asurada-Nvidia>
References: <1729783554-56916-1-git-send-email-steven.sistare@oracle.com>
 <1729783554-56916-10-git-send-email-steven.sistare@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1729783554-56916-10-git-send-email-steven.sistare@oracle.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: 536806dc-26ed-4062-627a-08dcf45d2a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dllDVDRpa2ozQ1ZweWVMdzFCT3NEdUtHSm00RXpkWlJWdXgyU2Y1bVRPWkZW?=
 =?utf-8?B?YXk2L3UxZXA2ekFrakl6Y0dTVVorZm9nUjZlUmVTdE5ZYlhQUU9WdVJOSGdI?=
 =?utf-8?B?SlowT2MrdkdKWFN3TTFXbVBBalc1QndkRExWaExvWktWR2RKaWYvT3Z4MldG?=
 =?utf-8?B?aHNLNHlvc0dUREFhNmhVRTM1WnJaVVk1SDUrcW9hTTJ4MEJWU3drZFlkZUVT?=
 =?utf-8?B?YTdxN2xFdzNiZkJXdWQxandJUW14Qi9lTGxscklHWFhmOVFKY2svL0ZDdFBF?=
 =?utf-8?B?WWd6Y25ob0FGRHQyYkFESTVDN1FWZjBTUXl0YkxVK3FlcTVJb0xSUE5pYjlX?=
 =?utf-8?B?d0xBSnRWUWVncHBld2E4WXpzRGxId0Zkb0thSTZRcmFZMHpaeDRlMGhxV0x0?=
 =?utf-8?B?UmxLajVzTWhHZnFJWW5saHNINEh5WlZZLzRJL2cyUXZjRityekZjdWJ5RW5E?=
 =?utf-8?B?ck1KVTYwc3Rmb2tvY21pV3c5Z0g1TW40dVRHZTk5bTNYWjNYMjdlZ2JlL2Y3?=
 =?utf-8?B?YlNpY0VhNGJBWHBVZ3oyWi9IR2RQcytrekR3MURqc0x1WFpwMmpDR1o4eiti?=
 =?utf-8?B?bngrNGNSL3p4SnBKeWh6Y0VuQTdOSzFRN05WL3FHYVpxNUtTL2g5UGdFTG9j?=
 =?utf-8?B?WmVERmV1N2tqK3NmZnVVcytKZFZEbExsTEo1eUt0eWRFZFRrbG1qMVdmN1Vs?=
 =?utf-8?B?SHZQcXNuOGJmRzJPQ3MwaXAzaDlIaTFZUGNFQm5VV2FXanRQNUxYelo3MmRm?=
 =?utf-8?B?Mk1ab0d3Rm1NZEFVTEl4LzJ6S1RYTTZmb0dPblJML0ZVdzZFTk9qR1RvbHJE?=
 =?utf-8?B?eWVDejdVdHBnZ3FMUmM4TlpLM0xtRWhyRjlYajBFbDVST3pHRWVNZjZJK0tw?=
 =?utf-8?B?K29mSzFJOHFwdkV6N0ZveTlDZUEzS1l4N3F2WHVJdEtMNjVoOGhVaW4wOUF3?=
 =?utf-8?B?dkZZTE54d0dPOWtmckhndXVoWFcrZnZOMGJSSGZlUVQ3WGNBNUJiV3czSnR1?=
 =?utf-8?B?VktneENoQVBJR3FQakxvbFltSVBvM0lSKzdpOUZKa2o4VGU0K1ZybXZoV1hu?=
 =?utf-8?B?c3ZSK2xiemJ5UlF6VFZDWGFhbDlWeEFMY3Y4N3Nzb3J4emVhTFVsSFBtWHJB?=
 =?utf-8?B?cUlaVG85ZTBLR21zQVdDM0lrV05SVWRUcSt4NlZBTFN3UUFVNjVvalZOcGtU?=
 =?utf-8?B?VkN1Q0Jkd1RKYU5hT1N4Mmtac0JxeFFJMXYyNnNKU0VtY3hMSktGYkFPUElB?=
 =?utf-8?B?QUx0emdnREJrdjg4bU5IY05rczU0aDBnQVFaZloweWo4SlM5RitEUlBqQWE2?=
 =?utf-8?B?OVNOckVnSEVzR0RhbGZDaWd2dmdsb2hMMnk1WUd4R2FrSzVyZkxocnd5TnBH?=
 =?utf-8?B?cVp6Kyt6TEIwSXRGMnhraitBbzdJbVBKdE55NjlFSWh6QzJ1cWRIc2ZPOWpK?=
 =?utf-8?B?QWNubnRySE5ZL1BTSFNWemFpVXNkUnBxSnM1V3p3N1E2MTAweTBRVlQ3NlJt?=
 =?utf-8?B?cFpOOW82QktMekpVckN0S05xRlU3LzRwRHB0TllQMngrTURSSXEydmJaKzZp?=
 =?utf-8?B?cEJta0FuRFlkVzg0bjRDRkpZbkJrT1E4ZDd5K2RmaVp4YWM1ektYUjFKb0wz?=
 =?utf-8?B?VWphbVNGOUVuYVFSak1BWllHQkhGaE5RdGlBTzVsWGFXVEdGTkc4UWVIQWxp?=
 =?utf-8?B?L2l2QzJ2T2RkamdUUERncG5Zc2tKc2ovTm9Ra3lRYjBPZER6dG1pc2FyL3lV?=
 =?utf-8?B?N2c5TktGZXhqbzJNcU55cGpUTnM5V3J2K2x6cEtYOEIrREZSUWpLWS80OWRw?=
 =?utf-8?B?b2d3bGJROGJxQThJWk5WZDI4eCtJSXp6ZG9UMHFtSk11SmVWaSs4ZVZCQlBX?=
 =?utf-8?B?MktQRDJuMEJYVytwcDQzS0Nqa3RJTTRmMmwrMk14RG5yTUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 18:53:35.7877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 536806dc-26ed-4062-627a-08dcf45d2a50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146

On Thu, Oct 24, 2024 at 08:25:54AM -0700, Steve Sistare wrote:
> +static void
> +test_basic_file(struct __test_metadata *_metadata,
> +               struct _test_data_iommufd_mock_domain *self,
> +               const struct _fixture_variant_iommufd_mock_domain *variant)
> +{
> +       size_t buf_size = self->mmap_buf_size;
> +       uint8_t *buf;
> +       __u64 iova;
> +       int mfd_tmp;
> +       int prot = PROT_READ | PROT_WRITE;
> +
> +       /* Simple one page map */
> +       test_ioctl_ioas_map_file(mfd, 0, PAGE_SIZE, &iova);
> +       check_mock_iova(mfd_buffer, iova, PAGE_SIZE);
> +
> +       buf = memfd_mmap(buf_size, prot, MAP_SHARED, &mfd_tmp);
> +       ASSERT_NE(MAP_FAILED, buf);
> +
> +       /* EFAULT half way through mapping */
> +       ASSERT_EQ(0, munmap(buf + buf_size / 2, buf_size / 2));
> +       test_err_ioctl_ioas_map_file(EFAULT, 0, buf_size, &iova);
> +
> +       /* EFAULT on first page */
> +       ASSERT_EQ(0, munmap(buf, buf_size / 2));
> +       test_err_ioctl_ioas_map_file(EFAULT, 0, buf_size, &iova);

I am seeing build errors:

  CC       iommufd
iommufd.c: In function ‘test_basic_file’:
iommufd.c:1529:64: error: macro "test_err_ioctl_ioas_map_file" requires 5 arguments, but only 4 given
 1529 |         test_err_ioctl_ioas_map_file(EFAULT, 0, buf_size, &iova);
      |                                                                ^
In file included from iommufd.c:11:
iommufd_utils.h:636: note: macro "test_err_ioctl_ioas_map_file" defined here
  636 | #define test_err_ioctl_ioas_map_file(_errno, mfd, start, length, iova_p)     \
      |
iommufd.c:1529:9: error: ‘test_err_ioctl_ioas_map_file’ undeclared (first use in this function); did you mean ‘_test_ioctl_ioas_map_file’?
 1529 |         test_err_ioctl_ioas_map_file(EFAULT, 0, buf_size, &iova);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |         _test_ioctl_ioas_map_file
iommufd.c:1529:9: note: each undeclared identifier is reported only once for each function it appears in
iommufd.c:1533:64: error: macro "test_err_ioctl_ioas_map_file" requires 5 arguments, but only 4 given
 1533 |         test_err_ioctl_ioas_map_file(EFAULT, 0, buf_size, &iova);
      |                                                                ^
In file included from iommufd.c:11:
iommufd_utils.h:636: note: macro "test_err_ioctl_ioas_map_file" defined here
  636 | #define test_err_ioctl_ioas_map_file(_errno, mfd, start, length, iova_p)     \
      |

Can you check?

Thanks
Nicolin
