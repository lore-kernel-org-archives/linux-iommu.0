Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C848481
	for <iommu@lists.linux.dev>; Sat,  7 Oct 2023 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NjvXQRXB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696664940; x=1728200940;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=UN5TH7qVu//AcWAyMcbP0zwBU/mTDs8PVypas9+yQ/c=;
  b=NjvXQRXB8Dd+77giV64gnbjhm6CN35qEMiKfIWnuqtdMQcjOLeQmBw34
   MpwiCVEc5qc5wp4gKPvSoWmiSMTq6vjQDK4f9yOxt3vaJlXMgxO0B8SQB
   OO6WHKaoyfE4D5LstG9RGAM4/sWQjZa9ZmCE7ztzrvfoDW/1C7Bc6RVpe
   rHVxDS9KNtrr9k3MztH9rXfRVbmth/8ImXtTNsU9eS9QV07dD4komx89N
   wOGwMmdj0hNLn0UThdPDkGmrKkyc36FiL25P+kZ+mZTYReWp58jL+rfSM
   7ELwaFnJNJToAT7r4CsHOtTgsbL7KCN45e3MidmYtrNHVJRmQbIYJ5/6F
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="5461813"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="5461813"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 00:48:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="818283937"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="818283937"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2023 00:48:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 7 Oct 2023 00:48:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sat, 7 Oct 2023 00:48:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sat, 7 Oct 2023 00:48:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3upamJK5YgyteOM99zlcoUrp8mClZkhHu8+hoUXX+H3cbAzj1lGyhTLnUgb6AGD9XfslHiu3cdUZIvqzUQQZW/ju/3Ql41Nl7ZRanKHRInj2oCBSgk8NSQfJWL4rrWTzwbZdtZnI96kwCyporgC4iPukhkyoVrpbZUyjEtLl1UnsQCL9k4u8q6szgvdCFIuw5KqLAHfG+CW6ULV7tjKkNQGs0MO89HfA3M7TV65nab8w4+hWVfdcjWvLrCPFZl6DCsTi8wIw94SU+QddbkpDtVbsb19OFomK11KnVTPNDZ3PGhlNhUWtoKX6r17wFaltppKpIFJVl5JU4vjeD02XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kujhkhGcizF7w2C0ZKItRPXW6UFAkCZAqVzzTBCF+YM=;
 b=MG+YMrHJKinw/wy0cp2cQ+scjJPSIdio0H8tSFNu/ACrP+FzRsOkAjW16TXB5uYRfs40hV+EQFAEY0p2rOJEpCJQYUFP1YJTqqkXfpCwN1dBR/2CzskiNgNoDXgoLz39JKQZ235lbHbkwB4QBGaKWsHPk+mW3QkbQ8aKO4uzqW/wGKuTCD+pxl30ZHc9CbbT5P2Jn5vNUMr86bYClDp//4Y1UoiaTFOUpeTDO6JnoDNnoNCLOk3gBJmP6xcZUTgPEK3zl+s1aE/mnHMe6gu5hQu/V4NFxZQ9RTXnVnDKrw+xlqmpqOjbMcmAB2ZuEdKmF65W30EIQk1K3pV6zamabA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.38; Sat, 7 Oct 2023 07:48:50 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::5e79:2d52:51e:f602]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::5e79:2d52:51e:f602%6]) with mapi id 15.20.6838.033; Sat, 7 Oct 2023
 07:48:50 +0000
Date: Sat, 7 Oct 2023 15:20:41 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <joro@8bytes.org>, <alex.williamson@redhat.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<cohuck@redhat.com>, <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
	<kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
	<chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
	<peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 09/17] iommufd/device: Add helpers to enforce/remove
 device reserved regions
Message-ID: <ZSEGyVXXvNQstD/+@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-10-yi.l.liu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230921075138.124099-10-yi.l.liu@intel.com>
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|PH0PR11MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: c40b7604-7788-4c36-702e-08dbc709d82e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: boH9W2v+VcOMh42iInb3PeKc/CZpjR/51OGekszv/GJKzy6G6n9OEXYOfvfgZpVz/XFpUZVW45HyyZQ+lzbSrNp+J8sKlDaRFPrG7DzCAU/Or+zeaS7sTqeP5JfdPnO9rmGw3cf4B9KBlIvNmuyHHcWUKJHMemAnTHbKJeArprTMMH+ctGy5+9DT8wKvmhakrhygzhNSm5ZuIjk5BnldbaZ8P5eHgSfcPV2XkrS6G1CUN+BMTLs/K7MwPI/jeRl2w1onuXmw+a7UTjGycytyGFzjdOt5K2DQiXrdkHj/1Jpr3DqI1z+h1npswUv7s1gT6Y71xTWsECHeegQWY7Jo/zuLknU8P5l3GO+ysvPYU8VdGD8h1WQtQCZFWjb/Xp2UE1GbBa/LeW3yQZX+1QJQeKqkT1iVvYVDdlHfUP1kNscKLg1nNzH2t5De7AlFXVCRKLIjEV0rDl5uPVUnZR2BJmgc9lzcuBbO3ucWGFsN5TZm16DejzauxLWQDcIX4YyEMRXZKRgmG2sOwgruWbN20p/FRK818+ae9Ia6TxMR3QfTr5q/oGqHnpYoYZisrabu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(7416002)(4744005)(8936002)(6862004)(8676002)(5660300002)(26005)(3450700001)(82960400001)(4326008)(6666004)(6512007)(6506007)(38100700002)(6486002)(86362001)(66556008)(478600001)(66476007)(66946007)(2906002)(6636002)(316002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z7apEBmckQk/UUJkL39osn/v+jRwn/lpBEQbA6ES83ZR0mvNHdlezHckuGBU?=
 =?us-ascii?Q?YDmk8UqwSNpkzJWlfq4nEcmwP2X7cCdPWov6Z0nzzqB3uCdIxfqiy9153yzD?=
 =?us-ascii?Q?7GUo+emtxE2gIQsUv6jOMyMn7QGAATK+UiQKu7NlcMZVQWTcblv7mnE/F2vY?=
 =?us-ascii?Q?OQFWyQTrK58mA9M2NG4yP8w1TfYGPHMXMb08aurdw5yHGNjl+/V+m3fd1hLl?=
 =?us-ascii?Q?WxrTPowiHzuUObOM/SEYz0xRtw3SxPHOkMqGsMVdq6w+dwFc5AH0mK7QOjfG?=
 =?us-ascii?Q?9mtQ2bYYYz7hRrqwIG+1bIvPouOVFRfde87eMaXGaJucKTRdVGYLdU1BXBfU?=
 =?us-ascii?Q?PkxZ+Cj2RbOZQ30ad3joWwF4/lkMA0XaZ01hNJTCYuCY8/1QUrg8Nu0yTHMs?=
 =?us-ascii?Q?Me2pvx+mAcSmdG9ZeSBiUySMTNBTp5fyWE7Hclgl0uMTgLbkwdr9lQJ6w072?=
 =?us-ascii?Q?0CAjtVAGPRcOe/mAXU1zhLurakNc0f8hWGbN4k0cv7iqsCZynVcfBSnQFkQv?=
 =?us-ascii?Q?OpVGHbjR2S5ZUFdT1gwDBDLbXa3auv6jtVb1eKp18dNAPW9g2CIFonjSpzoP?=
 =?us-ascii?Q?0lHppKGVYDvmZwDHsENMn0RJbXZdnwdPZri7NXFuXLuggVKxfo70rLcccjP7?=
 =?us-ascii?Q?YDRYrtD2Yi2jpTO3SSiFlT+WfPTisiV1/L2pFbGjJmHkkjRIjEV66zxU+SaD?=
 =?us-ascii?Q?1LibEUvtwxRi07j3ALJhlQGmT6kwBvyF4Sg9V+bEbRPUjEc/yYxTOyl+wxYi?=
 =?us-ascii?Q?OGMPzlbYq5x/ubXSmCzPJkOg7lnxA+q6etlKJVcJ1iRBe8rbFoy0LhkPKGBd?=
 =?us-ascii?Q?2cENzJeeVXsPp/3kw9PUmfVQkJ0/9LkLuBLPaktVrAqDUyDltmuSasG7xKgP?=
 =?us-ascii?Q?PWEV2IOvgKn+wRulhYZIvbQRkwZlotXnVzusInGsSSPCMaNHzsvXQpT7vOP9?=
 =?us-ascii?Q?+EpFrm9NZQ19JahnFZnXUc0kY3UmcQy8rZND5nOcYgRqbBHDF7v5xfJCkczo?=
 =?us-ascii?Q?I4EyFCb+We6bmQi1XcjiDc5IrTwVZ4KMQYCd7eH/2JjhM2ljaJfH0xJ17fsr?=
 =?us-ascii?Q?+eU6xWHSBYs4WOWx/PXpJf722Mp9XNOdaUPZvvqw+ZjW3lzKjqlSikSeSSlN?=
 =?us-ascii?Q?A00tHna9TcdpvFIV90ZP7nXpRdOcsZBZ1VwG1z1tWOiAxtMvijIFH3R7Rd2l?=
 =?us-ascii?Q?W/+54MlpH2JRL+hAxtDk8vQS7Qbii756q4G+lESsxUxkBwJLyR1jxvwbCAW/?=
 =?us-ascii?Q?Aw834fP2Natiymsy9hwVwtzdDhJSFiJqN+acJ1lbBL0N/SaDwobwUH0Tzqfh?=
 =?us-ascii?Q?Wd3sTP3updnptl9Lm1eQItu5cWsQL9DwFZqOBfRBSPmDowTAMVdVCKfftzld?=
 =?us-ascii?Q?Wt8PpAX5Y//RqBF2vlaIRzEHQcWqRYc9jr++mm7ra+41iH76IPhPYI7wPH/J?=
 =?us-ascii?Q?IyPRzXtRrpBVDL2oLXoBbJW7Khyi4C+8ghsz9BAUW7H1Kgsc6I31H8KMF3zo?=
 =?us-ascii?Q?bvkP/HS+crgAqCU7+CdoilUD7rXiwLYmLoplpnZDEFbwfo8DKjIkSPzugZVl?=
 =?us-ascii?Q?1LcK6S1PBKmt1CQgb+hZfgTv2JRX0vgR0QZXRYzx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c40b7604-7788-4c36-702e-08dbc709d82e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 07:48:50.6859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBKG3vMFSR//eLobgUR7qRrKv5slxX17zJkQ5+tXPfmfK6/QLdKtf6PCOq5LH2UqNpgWnSrySKWfepw++GuQIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5077
X-OriginatorOrg: intel.com

> @@ -444,10 +465,9 @@ iommufd_device_do_replace(struct iommufd_device *idev,
>  	}
>  
>  	old_hwpt = igroup->hwpt;
> -	if (hwpt->ioas != old_hwpt->ioas) {
> +	if (iommufd_hw_pagetable_compare_ioas(old_hwpt, hwpt)) {
>  		list_for_each_entry(cur, &igroup->device_list, group_item) {
> -			rc = iopt_table_enforce_dev_resv_regions(
> -				&hwpt->ioas->iopt, cur->dev, NULL);
> +			rc = iommufd_device_enforce_rr(cur, hwpt, NULL);
>  			if (rc)
>  				goto err_unresv;
>  		}
> @@ -461,12 +481,10 @@ iommufd_device_do_replace(struct iommufd_device *idev,
>  	if (rc)
>  		goto err_unresv;
>  
> -	if (hwpt->ioas != old_hwpt->ioas) {
> +	if (iommufd_hw_pagetable_compare_ioas(old_hwpt, hwpt)) {
>  		list_for_each_entry(cur, &igroup->device_list, group_item)
> -			iopt_remove_reserved_iova(&old_hwpt->ioas->iopt,
> -						  cur->dev);
> +			iommufd_device_remove_rr(cur, hwpt);
Should be "iommufd_device_remove_rr(cur, old_hwpt);"

>  	}
> -
>  	igroup->hwpt = hwpt;
>  
>  	/*
 
