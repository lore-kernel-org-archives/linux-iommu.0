Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5202D29AA
	for <iommu@lists.linux.dev>; Tue, 24 Jun 2025 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776835; cv=fail; b=Ts1SFmcqS1t/bAzovqAURrBBMQs7Cm+WNLTcUSyQAsqdHotXdhjV7hzPM/agi1Y4iSS9bsvrrsxSWLsUN/0feLgLqkK3ZWdUeGgpfFz62I7QbTB62tRRws3WO8Jipokr+Xz3zEgMMYl+vJIlTzaN8uZ/Pkp/xyidnVKYCeDxHBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776835; c=relaxed/simple;
	bh=uLZ614ST2EvxrHGKqTEtmq1UDAaOvJrp2ae/McDu8w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u1X+0bDoOW0Dhh5xbcFZBBjvDZ9SN6qr+0bQAKFIDxZbHH0hcZhzECdCj25Z3+UZ/5YczdhdNZCipcDtjxa9R+92yLsu3jxOFIG9DZaEju+u9V3C94AyIyQSg7PaGzhqwlcaMOprGXZCwM2lhbiZ1OEhk0d/05MMgz/FXY713XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Efq9UJDD; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Efq9UJDD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OyRZc0LYlcbvWWmRD+gNqZufYI7+4DLVDU+oHg3eHfDczTn3DsK5BUT7VbQDMZPJu8GPOfEVgFW+L/xTWt+S/kMOYMM6B4EGW3omlE3L342kysWILhhGKw6y5kIIViwwmDW04Gix2ebV00inomsN70T+KJlhyMSjCeV2IbknSB2AOLrQb7Vn/qrOdGoMVuyg4H7sags8CSMiQ3MPCd+3qhKcLN+O8TsMUpxJYUCUgTEaublnAmOxCL9+XzZBpuEApyRapOHH/uRxlifLoGYGIRdsRP3oq+O5RtWMRQKIzSEkZ1tj3cydFJDn5eA3ZipRVlhZwP8debabdFonid96Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgePEw4az/qhPk5FhBt863ysEizt0g7wuzUW5rz0u0A=;
 b=yHpPHN5WipS5QNge5y+YE5Rnhp7gvOMv217UrOhjKxyvJFQ7mApp0cp0qORLSlu2XYdr9NS+uIb/EK6R2b6ngdI+VFCp3nmpO4R5JExVaxMnfv/8ughIlL/9+//RiKQWDL4Y/O6SdZLyGDvaijLISeUHvQQ4nUGB7x5raJr8f0XXuOurByzVVDCxosam74AMAOBPP/KwWfWMRUF6fEARv38uH2nBDwXv4EwHbUuD2OQQfzksnWXh/5K4IDzK/1Su9WxqqgSrVc6desunlYT88GuzxfQ3JJ8i9vMGEwcw+ftPGTEzr/mQFUBCma5DhA/dRZTpYrpXwixlrn+jzq2HKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgePEw4az/qhPk5FhBt863ysEizt0g7wuzUW5rz0u0A=;
 b=Efq9UJDD6/trUgG7yQfVIqStW4dgm7L3atb9I+BFITf1pe8zzxZWLTur/PBEzbfAQCSQ5qXXiDqZ98m9od1NE1xYck5PC6Or/NxFh+4cBLqWb31hdBih348blM3YgCROF77K9na00H4UZcroNjO0bbJCBC6YnxNhJqelz4o3avLVbu9Jk8xHXxf9ln6rIKbDok9B3czjC/YpyBCb5BUBECiYJW8ILwr7OL2rppW9yK00danYFCFJHI107VLqA6r/acabi2SHL2HLM2mNYBHuAVrF6kSpbcYqm2yH3f1jkNkHGu/9r1N94s3x+b4NskX0EUFAu7JerwBuTpRG4D5Xhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by SJ2PR12MB8182.namprd12.prod.outlook.com (2603:10b6:a03:4fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 14:53:50 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%7]) with mapi id 15.20.8835.027; Tue, 24 Jun 2025
 14:53:48 +0000
Date: Tue, 24 Jun 2025 11:53:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: kevin.tian@intel.com, will@kernel.org, aneesh.kumar@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, shuah@kernel.org,
	nicolinc@nvidia.com, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v2 3/4] iommufd: Destroy vdevice on idevice destroy
Message-ID: <20250624145346.GC150753@nvidia.com>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-4-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623094946.1714996-4-yilun.xu@linux.intel.com>
X-ClientProxiedBy: YT1PR01CA0120.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::29) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|SJ2PR12MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c6aa59-ce3f-45f9-08ad-08ddb32eed09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yQPF2q8qrg9eXG+remF7VlXIlprYw/Qa1Hyt5OQyNg5cUmrSuN39HbKWm9tY?=
 =?us-ascii?Q?DHdlgLrC12k8acHW9zXczouTPgpBWn6VNBBnsmKs2YWAMhNmC7OBXTHURNsq?=
 =?us-ascii?Q?X/k3rROBM5Yy7CNB2oGtMe0KpNb2IEg2qKN3e/HKB7VgfIy9n4D1E2xZ95Qh?=
 =?us-ascii?Q?QnoRzCKUO2ExUggCwTC9MgQgodLIq/mFb1ra46Ppv80Te5Jiv72/c3niBq2k?=
 =?us-ascii?Q?EqQtSYKl48x6Jqg2ItWfTC3knU/MEDJRtUMEvazyDpfv1Vfo2GYXTo1Dmz6g?=
 =?us-ascii?Q?Ve5NaH9G/DAZITPZtXj1uIuN59M0aoqLV+Kw0fR+QWaU1AFu9uSpZfGPlJnc?=
 =?us-ascii?Q?CIKRe5BtPIZf0hQTOW41X+8B5RuwG3dpWEATuO7OPY99AWhbibuVzlRuQV7T?=
 =?us-ascii?Q?EBidCe1vdPdhjlWJ862Ns1r1Rdx2dOVe/bCnxaR9A6dpByeLIVOIjhgy8m/f?=
 =?us-ascii?Q?1eK+K15PBsyKXobfcN9ljIiQDD6IcXpUHqSkpbtTpo9zY2Lji/NGaXcfOk7c?=
 =?us-ascii?Q?Q7UuAtTyxPWP++8BHQx9rVbrcmtBnmXKA3K9wV44GYLcQMM1eH6PXa2+KoUG?=
 =?us-ascii?Q?HwoPKUgMjBTNl/OqHVuWzh2umVIBXIvigePOieiNkXYuY1LKNjRKvBTdyAGu?=
 =?us-ascii?Q?JML4a+YYlCO8gvDIJ1M/27cr3eielI0pSYbopmcHE7obVAmiU37L3VfeIE+F?=
 =?us-ascii?Q?b5tfYZOUE9ASgrFi2VD6G6EOCnDJwpdonoZbdw9NdJUjD95Q6iyX3sfNICMm?=
 =?us-ascii?Q?z1m0jEp/eOuRjk/M1XtayXhOnfAcE2xEUfmSt2S0XMJG80uuG4EFU0/zXVgx?=
 =?us-ascii?Q?vY03R0Ptv1QLYJ/C2jBpnc0+1cEn0IWa9+QqyeCyWVmp+HBuLHZsm+PGDSFc?=
 =?us-ascii?Q?tDajM7iF5WRcrHefQ4yEunGnaObQIKs3ECuzionJuj1xGOMiXZ7762y6TONo?=
 =?us-ascii?Q?QQ9KMqF6CAQ6YEzhsRBMsdl4QWGsBRrypiEo2gmMg5nZ4G+SwIzTdlSnRch0?=
 =?us-ascii?Q?B92gjozQ5rkkbm6qfhmV9lgcQlLuW7eJbSJey+qiaDv40iG7wWnSEkxVt/q1?=
 =?us-ascii?Q?cVxUeoemez8bnD1RM0qZ6QbLMEQTCeGj8ZZRU+lCqtc86WOS6UW4ZIO4TqbU?=
 =?us-ascii?Q?zkaNUCHn69+eBrPxzMbET1EEw7uyFbt7211V3xDog7+KiwVC5n8skg2u43vC?=
 =?us-ascii?Q?00PfommUCDC6GmQF29Hy4EXZM0scUIEiy7OjBrkfCPmvG4SnqqdqETb/1mFB?=
 =?us-ascii?Q?ZGM+/dyLB3Py+egNe0ouozNMM6aXBwQuTvFlglyEk0xMxb9MAY1z6FSLaUKT?=
 =?us-ascii?Q?wWzbKTdOsAo4aTWKx22Z3am9sMtpY789HxnolPVdSwpbY5dHT+2Ws2Dltozz?=
 =?us-ascii?Q?kfJ3ZaT5f4BlHa/jFM3mPx4s25edxi8fnynWO4dkHQ/1e4DuW5QnxAS6zr9k?=
 =?us-ascii?Q?8jDfSWVsgmg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4JzGfQsbshJLwTTuLE3HsSaPSBvI+nCodBnD2D+YMmrmxkudDCoTyYnyLXLb?=
 =?us-ascii?Q?hT4s0IXiHGHUz/pmSJ59FMLZig1g6XnqHHh5u9z8xdzL0yAftsJVF02j0PtY?=
 =?us-ascii?Q?bS58ef7IWhCe7Eg9/i+OrhhkLiTQE8Ex1vkxjC+7Uiysdzr/nAaR+VSS5V4m?=
 =?us-ascii?Q?MLtFE1amxKsYUon35IqTE5bVuuU7FOFIuDyAQeiY5clp7jvLiR9VMe5t+aR3?=
 =?us-ascii?Q?ZVur+WLXwxhZokob3hrngnUj13OEOBZ1e1NsnNH4/thffbBXccZ/zCHClpWv?=
 =?us-ascii?Q?neQsSMJQADcJZm/RGZVz3rDQpGsUpEwRb7ESssxSw6sS13XrHbAqaRK6niz4?=
 =?us-ascii?Q?kPLO0ctGSnZ2e7QNA3zYKZL6WX4rgfCz4qSh0nO7qRc09nfGJujvyhGbw17G?=
 =?us-ascii?Q?Ax+e+FpU4SQnwA1QKrdpLSZiJqkf18LgXPJAy9NSzd3C+zCeCnhY09zRroV7?=
 =?us-ascii?Q?BZMjrUNDaktb3l5LszRz4QJLG1LYupBeXXz8MyIkCUaZmTAHl+wq5La0LSaU?=
 =?us-ascii?Q?oM2AWJv6mbPKLiROzmHzfcGzMc3hl0LkyGWe/M0dmoZq8poZvgqoilXRVO5m?=
 =?us-ascii?Q?qdOvaVd4grCl3lVGbhrVO9uKOefn97Jog1LLIdu/OFd0kYjFDH74lKUtp8RE?=
 =?us-ascii?Q?nqyzQvHA02j6G+seD4F600G5/gqd2tGC8sxuRQ3YTDv7ugYgi8po6gbttzr0?=
 =?us-ascii?Q?bdGuQS2BEHsuIDK3/uUNKfiHu1tmwLMcO2pehl679YZG3adtTwwWGZqpk1Wd?=
 =?us-ascii?Q?q87jqONOqo9PkuBjIFItDLVWMPvML6GOqRo4B8yZrjj9CzlcJ463dm0/gL6n?=
 =?us-ascii?Q?QEC82MbPkITVi2UWeD/feIPtoWRovvnJa3B68FxUzo/hONX8NTPGK5/DJMl3?=
 =?us-ascii?Q?pWVMLDDrx1d2aUu0dsZmARI1M80Hxtszs78zacQhIQETW+GcEwXckG4Xv3cG?=
 =?us-ascii?Q?OMZ8YVj1L01iBmma8SvawN65dVh8K75R0/71aq1k+GqV9lI0dYdnPJN8jAHP?=
 =?us-ascii?Q?4IJmfKBiYm72kibDzFqOFXKlkXF2mSPS9U/QRVEk/naoTInpuR8Qr6H6ADuM?=
 =?us-ascii?Q?ASEfGGM+I8KMorpnFf01EmDUMVOzgXrwCk0/FrW5L3GwyPj7/t4tYho11AWZ?=
 =?us-ascii?Q?va2kfnplJZ7Km6ZXureMZ0aBpOdirqD9/6imo9kDRH0egYbxTxk63g6zq0uO?=
 =?us-ascii?Q?G7mOE9iFevSK16ObkkAjpuc9PMWMoU8JbA2hi+KkfjJlgYjZsA5DPi8LpnMv?=
 =?us-ascii?Q?5Y4wNTo3b5QjlInGSZaEDad50zD6e13cYjXbL0X4rBfzXEwpUypU6XPItSDj?=
 =?us-ascii?Q?cbtLpdpi2o9KaG4vxV7PKFGpY6A0jrFTUbz3XaghHgpCQH7qXVaX3z8edN/U?=
 =?us-ascii?Q?uVFR/Pa4aTkB6r2AayDez5rrd7lGgBjHjohEzZucZv2YNTyS1UuAOyUNX9F0?=
 =?us-ascii?Q?Dc/L24vqfjRZ746XStm8v/XvTuvebUoke4GElxmn/UxL/sgmEnnMHulS/SiT?=
 =?us-ascii?Q?qQojgosQYpTTS0RE9zO4HtWSAAhFbNqklyPPpDxBRBJ1jeiRLbF1jlCOtqXq?=
 =?us-ascii?Q?LEijbmsz/eYRKEAVtuE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c6aa59-ce3f-45f9-08ad-08ddb32eed09
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:53:48.5894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pMo2vADLrlK+vPygMb9PHxlzH8Ap8Q7pD1ten4d/t8VEiqeHQ0umgHZ9bWq161+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182

On Mon, Jun 23, 2025 at 05:49:45PM +0800, Xu Yilun wrote:
> +static void iommufd_device_remove_vdev(struct iommufd_device *idev)
> +{
> +	bool vdev_removing = false;
> +
> +	mutex_lock(&idev->igroup->lock);
> +	if (idev->vdev) {
> +		struct iommufd_vdevice *vdev;
> +
> +		vdev = iommufd_get_vdevice(idev->ictx, idev->vdev->obj.id);
> +		if (IS_ERR(vdev)) {

This incrs obj.users which will cause a concurrent
iommufd_object_remove() to fail with -EBUSY, which we are trying to
avoid.

Also you can hit a race where the tombstone has NULL'd the entry but
the racing destroy will then load the NULL with xas_load() and hit this:

		if (WARN_ON(obj != to_destroy)) {

So, this doesn't look like it will work right to me..

You want somewhat different destroy logic:

/*
 * The caller must directly obtain a shortterm_users reference without a users
 * reference using its own locking to protect the pointer. This function always
 * puts back the shortterm_users reference.
 */
int iommufd_object_remove_tombstone(struct iommufd_ctx *ictx,
				    struct iommufd_object *to_destroy)
{
	XA_STATE(xas, &ictx->objects, to_destroy->id);
	struct iommufd_object *obj;
	int ret;

	xa_lock(&ictx->objects);
	obj = xas_load(&xas);
	if (xa_is_zero(obj) || obj == NULL) {
		/*
		 * Another thread is racing to destroy this, since we have the
		 * shortterm_users refcount the other thread has xa_unlocked()
		 * but not passed iommufd_object_dec_wait_shortterm().
		 */
		if (refcount_dec_and_test(&to_destroy->shortterm_users))
			wake_up_interruptible_all(&ictx->destroy_wait);
		ret = 0;
		goto err_xa;
	} else if (WARN_ON(obj != to_destroy)) {
		refcount_dec(&obj->shortterm_users);
		ret = -ENOENT;
		goto err_xa;
	}

	/*
	 * The object is still in the xarray, so this thread will try to destroy
	 * it. Put back the callers shortterm_users.
	 */
	refcount_dec(&obj->shortterm_users);

	if (!refcount_dec_if_one(&obj->users)) {
		ret = -EBUSY;
		goto err_xa;
	}

	/* Leave behind a tombstone to prevent re-use of this entry */
	xas_store(&xas, XA_ZERO_ENTRY);
	xa_unlock(&ictx->objects);

	/*
	 * Since users is zero any positive users_shortterm must be racing
	 * iommufd_put_object(), or we have a bug.
	 */
	ret = iommufd_object_dec_wait_shortterm(ictx, obj);
	if (WARN_ON(ret))
		return ret;

	iommufd_object_ops[obj->type].destroy(obj);
	kfree(obj);
	return 0;

err_xa:
	xa_unlock(&ictx->objects);

	/* The returned object reference count is zero */
	return ret;
}

Then you'd call it by doing something like:

static void iommufd_device_remove_vdev(struct iommufd_device *idev)
{
	struct iommufd_object *to_destroy = NULL;
	int ret;

	mutex_lock(&idev->igroup->lock);
	if (!idev->vdev) {
		mutex_unlock(&idev->igroup->lock);
		return;
	}
	if (refcount_inc_not_zero(&idev->vdev->obj.shortterm_users))
		to_destroy = &idev->vdev->obj;
	mutex_unlock(&idev->igroup->lock);

	if (to_destroy) {
		ret = iommufd_object_remove_tombstone(idev->ictx, to_destroy);
		if (WARN_ON(ret))
			return;
	}

	/*
	 * We don't know what thread is actually going to destroy the vdev, but
	 * once the vdev is destroyed the pointer is NULL'd. At this
	 * point idev->users is 0 so no other thread can set a new vdev.
	 */
	if (!wait_event_timeout(idev->ictx->destroy_wait,
				!READ_ONCE(idev->vdev),
				msecs_to_jiffies(60000)))
		pr_crit("Time out waiting for iommufd vdevice removed\n");
}

Though there is a cleaner option here, you could do:

	mutex_lock(&idev->igroup->lock);
	if (idev->vdev)
		iommufd_vdevice_abort(&idev->vdev->obj);
	mutex_unlock(&idev->igroup->lock);

And make it safe to call abort twice, eg by setting dev to NULL and
checking for that. First thread to get to the igroup lock, either via
iommufd_vdevice_destroy() or via the above will do the actual abort
synchronously without any wait_event_timeout. That seems better??

> +	/* vdev can't outlive idev, vdev->idev is always valid, need no refcnt */
> +	vdev->idev = idev;

So this means a soon as 'idev->vdev = NULL;' happens idev is an
invalid pointer. Need a WRITE_ONCE there.

I would rephrase the comment as 
 iommufd_device_destroy() waits until idev->vdev is NULL before
 freeing the idev, which only happens once the vdev is finished
 destruction. Thus we do not need refcounting on either idev->vdev or
 vdev->idev.

and group both assignments together.

>  	vdev->ictx = ucmd->ictx;
>  	vdev->id = virt_id;
>  	vdev->dev = idev->dev;
>  	get_device(idev->dev);
>  	vdev->viommu = viommu;
>  	refcount_inc(&viommu->obj.users);
> +	/* idev->vdev is protected by idev->igroup->lock, need no refcnt */
> +	idev->vdev = vdev;

This can be WRITE_ONCE too

Jason
