Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011062.outbound.protection.outlook.com [40.93.194.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAED6331209
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775754425; cv=fail; b=egmCNY7uwDPm2+wXkp1DLcv1r3wcf2Frfwu1PQk8oB7QbUc+t+ol41w1ejcjldNBIPR/m0HCAsR3w1mmAOVpuYXdc6DkwYTFiMiGmshXnb74RWn0lyj56IMc8grrrzMhuY15DS5Gmn0V55rofGEVhnfAhrdEizTOfmIV+e1G2xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775754425; c=relaxed/simple;
	bh=G3bBKEYpnYRpDh6gZ2mTsM+4qzUTCLgIkPsQ2bVf8GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ScfeejxmIR9kd7yqQ5B6zMh6xWzmdn2+3B6Qbb09XAM5nCf8V20b0vvsBZ6VgH2XYetMOD3SlrZjP32kbZMkPwV8hwTSP4cGZXm0ZhE48Mv+XPkKE/gnfLAsQYJXjrBeFFCHJKHbOjtIjzVEIhAey6d2b6zIDQTSdaInYZPBp6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iT4s1llw; arc=fail smtp.client-ip=40.93.194.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iT4s1llw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/xITPvmoMGTnD0n7CiAQRrUOE4M8H1tg+9pDCgVqF4Oqu8PlIAYwTGBAobukzE8tO/BL9clNMH89qSWfZPyo8oY/4OurXW7FBSY6lqvXqAMcbniqMgam0Vtp2DNa8BT+JZvxp4RAspOWhOMFyWQZGgjAvNm2X20KyYhcr0BSiUsRx6yl8WV1UcLSBkAaOl6ASZZdBkmvZd2F/i6a9d6mDurl606JbDV2wakOxP44RW2MdCGbKmtUXbQwfiGvuTkV94fMh4s7w9xX2pPXcZfDXEJMBmCqBcW5nEHG1P+6RunGzyp8k58Zhzs0GGQifikVN3f1oLVYTFnx1aNo6H4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MmQazunH3Gd4LWJtX/e9MITAOObm7kV4R+ETXblfvg=;
 b=BTBJ6r7xB9r1EBs/lp6Z/gecv02p1LJ4yFKTIF5PqallsB9q8Cjobx4si+0817S9z8wbNgf/PaL1nuLgTGD7rEEg/PNBJ3i0wyxbsJlkhdKBu81oQ7lBx3gLptmYyhU9quxo8V4YGeY8LzaVUtuPNGfv442Q0KQ9BzYJTuJzZbmIWqbQD3VzIpgmqipemvx49qwHzQ44WrE82g/geKVCgjHqUJKHQXXgHIFnNf/1RUU1I3RbTSlRgvKVpVq3H074bxw4n3chiAS3SocL+JOQRmpmwdNCvNCMO7sP95Eopk1mPYLNKdVN3yfY0Z/FlcHEZwaGeuWGoiBL7NEA48S1gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MmQazunH3Gd4LWJtX/e9MITAOObm7kV4R+ETXblfvg=;
 b=iT4s1llwLE6eFgaNgRfDmYtvcXjFZEtKsJeChLHs48L8+KO/eliab56YZH8qQ5H/1vtXqvHbPA9D9djn/0CdWjUUAf+0KfTwbYEccHfd/LucL8/OuevLkHTKvHEvUYpB6Gmwfz8f7bdWyiWyxC7p27d0rX7SpfvwsJpgk3sHPEsgM5sf/75wy7Y9F5mMDW3+ng5+CeN1GsUSyGra86zMoWeLO+LD0NcKyPUOKskr5Bj6z8vDQhSvgc3ndWdUyWnJlDTgst5Zb6uKYYGQoZWCcacXlXCmKfzkJKWVI3ut/EAJbFXMaV+U/zEFCTFwhRvuGJGV9hAJJBii/TRUpJc8wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 17:06:58 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 17:06:58 +0000
Date: Thu, 9 Apr 2026 14:06:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	skhawaja@google.com, pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V3 03/10] iommufd: Allow binding to a noiommu device
Message-ID: <20260409170657.GM3357077@nvidia.com>
References: <20260403051146.10210-1-jacob.pan@linux.microsoft.com>
 <20260403051146.10210-4-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403051146.10210-4-jacob.pan@linux.microsoft.com>
X-ClientProxiedBy: BN9PR03CA0572.namprd03.prod.outlook.com
 (2603:10b6:408:10d::7) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|PH7PR12MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 269dc1f0-f06a-41c2-7696-08de965a68cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	q4TXbeUjvOKLUVcYadZE3IwnV/RyL1V3/UFQKrOJCtdxUvFkltduZeNExjIAjDJh692CnIQR64WcaV5KsgZlHlmNLTgcn/m7ECYLnsaOCqUEN0WMyElBtVRRe8h1KaZjWIoT19zfIDt+4Y2Fo4tV9Ktpn35M5/xTbnrE6ucrKlEhebWvOJhjtk+VsVTEB7pxhEGLT3g6MbUzn2+hQNl2WTeEaAuwytfaaCkmoRbfndcJ+DtVQ4U5MxV3hSnn9wZ2BqKRqa8f4mId727cpQ2J2Kcbp8iqhFmWVLWFM2v34MAoe9dyUteKO/TnVwb/AQnR6fNp8501BapuJh4UDdD+ZV5KImJRuF7qD6r72CLC0W3mtptkEwwYf3yIvkr3j9fVP0SOXGtzEm2GNeaCO2kvj9l+tMqyK0XS9d8gpVCPyar5MCU7l9VT5NTGumaGBbpoVwT1cxS9qUYxUDhfJjvcwE9azXQB0gCBThV6SpQk7kXWOdDGEHJ7Ka0155WOm2DFKAPo5FiuWFLoJQjv0QReiloN8hAl5cosf5/ksGzyIuTntnW0PUz01phgglz/Amk2SNXFGsRwlPdP3f1CZxWahT7TEU3ryZaSmDM8DHUA7sSOXcOx90BO5zqLa/EJPP+p51dO40VcizouJoay8ymQ5yx2WIo8eAIkmq+Av/Ra6EaQp84aE5waUla03E7XTR7bUKzjPFoTXplIliorUk08J3JYq1VRLtPk2DoBgptRh6Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EifxrTcs9o7vg9cRvbMaPTM4Pjv8d9fPy/vRboS3i6+OhYn5m+l9HaRT47zF?=
 =?us-ascii?Q?5FsU/uj+bpJJc670RFEidMywlBfcsDym3vN+beSEupxDmGr/uyLNjAd/NBwP?=
 =?us-ascii?Q?dwmm5YNnpxUACF637tElAzH1EQSjW/kS0fZXrzXXwWkC3vAbwITV9dcqj2Pd?=
 =?us-ascii?Q?GjiusrDh5EXwzIM7GgR+ItjJA8h2AQK4eaVX/qgHICtFFjcYmMUmNjBBcGS1?=
 =?us-ascii?Q?8CycX4fK573PD4bRaJl3asw+Z68bB8ut+Hltc/FcLuUgI/+6E1kghI27D45i?=
 =?us-ascii?Q?WhMmc8C8Pau4mHG/NspBe6xqcD4AjV8jlhdIkE6rcJ3dYg06S9TCq0wlVZHF?=
 =?us-ascii?Q?Of4d4wxapum5wBnG2NQHS3MBgklPSS9i03o9Wi8uUpav5sljtKYk43M8+OCN?=
 =?us-ascii?Q?dscaY9bTOzU6fsvaKN7/Z2Kd/U4xAG46AyYI5saXxr+alI2u8MNeMThXAtSL?=
 =?us-ascii?Q?cpB1T3lD6rsEhuUI66Evg4OP42BQcPz/xHcOerrSX7vDNGaUsEhA65HUiXsG?=
 =?us-ascii?Q?dmYe8WEBdMaylkdRWaCjzxX7q91TDgr6dGjn83ZI9rTyHffOXAv4TvyYUbxR?=
 =?us-ascii?Q?0rKofjy4f4O31/bOC1Q7Y4HpDcak00KO1QrPXQQATuzlj0HAnhX9zIBwrhwL?=
 =?us-ascii?Q?tK79FGlzW/BfrvtRvL7i5WO+nW1O+LW9rISjGanwCXlmIrb20PNx/tRbTeuY?=
 =?us-ascii?Q?TWh5DHR43epOmJY2WIrsvmeuLrGBeQVBt/Tx8Q48jVwsjUHB7i+8RIB+wmXS?=
 =?us-ascii?Q?cIUeLvL2LMcHo+XaVf2N6VUPWU47vU5W2nBewLeSEo6JlkXD3IHSq2T3Bc5j?=
 =?us-ascii?Q?ZheTOpkjY9g2YAYJxIcZ8lqOh8/lwSXFq7u5+xh+5M1pRpemrcHhgLRzqLNe?=
 =?us-ascii?Q?2u6JHUaKwbQQy/zPCpXeP8NbkT3TgD8/540EMstAHA3QSqLco1G6W8bbN9+O?=
 =?us-ascii?Q?KAQUK6JCnNADTRvWWDvZxorDfoRQuScD6Y6l8hDGkWtXmyqmtPT5IztC/0+B?=
 =?us-ascii?Q?5HUX/UOsl9r3iqELi/hrAmiRWlJYORzhuPecCvVZgSc4vkqiTYEyB5hRxP6q?=
 =?us-ascii?Q?XpoDlGVOM1bY6PTMA2F/SeonSeS1BiV+R02W1IqaroENxSUcB82p331PQCE+?=
 =?us-ascii?Q?8h1lAMqoAhbSmCjV8PudJ3dFFVS48yfDj9GIpzcSvtiXujvZ3Jr3CzcGVQLH?=
 =?us-ascii?Q?FtFFbGPkJ4AgmEfBlVFUlJ8P+HrdI7AkWt0S1C23odU3RCe7BVCrG71rg8vo?=
 =?us-ascii?Q?asaI2n5M0yn2+POy3TOPIYjt83XDEsVcZJignb7Tv30vlLJlBdpW1g5M4idV?=
 =?us-ascii?Q?0kvQCAIa/44fmm7TSNkrb3P1LjpjSxSVvZTZqEVsly/9fFJuP2JzGgQWbHYA?=
 =?us-ascii?Q?Wn+SrpqB3q80a7xFXaCiK1dw49Qp70ec5VFLrp13HoHq/d4V5sSbRjrsu+p8?=
 =?us-ascii?Q?+XS3rK8tqfS/+/bvOA8CNofRYPgC9k5bRQN+6oi+Z9UEl6ZDXL72RkAVNmMA?=
 =?us-ascii?Q?MUeV+iN6eexMSQTq7EMdY8UMVgzQmvStW/jwPRzkg9jSfS5SQ2+LUt4k+/Zj?=
 =?us-ascii?Q?Q36rnOdvxcA+2kwavb4aLjdSpfVwoATuWLGhVws00jktpAZWYFNpWuuAmH5L?=
 =?us-ascii?Q?fzFS9Jel6boJQz9T33VcKr88RO0/dr2RUGWWql3jFck0K1PeGwVndCFVqneq?=
 =?us-ascii?Q?Pmm+jwUk046EZ5uNa2QcQt669TBCSiVK2PW0e6qUMba3UKq0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 269dc1f0-f06a-41c2-7696-08de965a68cd
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 17:06:58.4697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRX4yOobVUqt7QGT46AKbruszeYVmueavPc4zPrhnkXHYwXZZac38f4AaR0hkoKd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940

On Thu, Apr 02, 2026 at 10:11:39PM -0700, Jacob Pan wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Allow iommufd to bind devices without an IOMMU (noiommu mode) by creating
> a dummy IOMMU group for such devices and skipping hwpt operations.
> 
> This enables noiommu devices to operate through the same iommufd API as IOMMU-
> capable devices.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> 
> ---
> v3:
>    - handle new error cases iommufd_device_bind. (Mostafa)
> ---
>  drivers/iommu/iommufd/device.c | 126 +++++++++++++++++++++++----------
>  1 file changed, 87 insertions(+), 39 deletions(-)


> @@ -294,11 +334,10 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>  	*id = idev->obj.id;
>  	return idev;
>  
> -out_release_owner:
> -	iommu_device_release_dma_owner(dev);
> -out_group_put:
> -	iommufd_put_group(igroup);
> +err_out:
> +	iommufd_object_abort_and_destroy(ictx, &idev->obj);
>  	return ERR_PTR(rc);

I fed this to Sashiko and it pointed out the abort flow here will call
iommufd_device_destroy() bit it isn't prepared to handle a partially
initialized idev. It looks like igroup is only set once it is
sufficiently initialized so:

@@ -211,6 +211,8 @@ void iommufd_device_destroy(struct iommufd_object *obj)
        struct iommufd_device *idev =
                container_of(obj, struct iommufd_device, obj);
 
+       if (!idev->igroup)
+               return;
        if (!is_vfio_noiommu(idev))
                iommu_device_release_dma_owner(idev->dev);
        iommufd_put_group(idev->igroup);

Should fix it, but lets add a comment because it is pretty fragile:

@@ -335,6 +337,10 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
        return idev;
 
 err_out:
+       /*
+        * Be careful that iommufd_device_destroy() can handle partial
+        * initialization.
+        */
        iommufd_object_abort_and_destroy(ictx, &idev->obj);
        return ERR_PTR(rc);

Jason
