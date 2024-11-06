Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E3E1CC14B
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730901591; cv=fail; b=anZCtP7ApmhmCnpiyS9552xMoS1O7CZcsk+yrMspUQhZmuwUMpI8rn9pXCZ9BnFwrlHLVoMee/3VVsSGyTM6iedhAqJUu5Kownsdeh7z/ZksL3IFEBe2xQJaZ4sPmYXcIJjmvZFvOlxUBsG6eZVexyWK76PmQnqeM7qqPfoWbb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730901591; c=relaxed/simple;
	bh=6b39FudWRkX4y3kaKy3+bAsIbr+5oeg/Poh56LJo6zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bXhe6pYAP5mYexN28vS+g7hF7eAR4i9XMlWOBJonJguywRC4m3VSBAuRQoVDOxIusfOdqOgVg6hHtIW0Er1lG4jn8lIrsJcjtg2Bm9048MJ3ql9FjjdBnQSeyr8UAuhXr4MoHchL8OgsEDlhtaTxmDGhwqt5fCImCJIIG2DgdbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F7dbBtlv; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F7dbBtlv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxWVfeVVCWk/YnIl4BMACtPD0iCIWl4T6XiKk+E3Lg297IjcPLpqkLf4GnKs+KCBM/FZte2ZVzK1dive3Tzaad0IMuMXKOI2FVIoYBxEB7PQ2EiAjE0RCri+JBFRJqJN/g7xRuIS4wH4hwOZyG2W8jFFy1u6t/AnWNAsxIedkHbV379uWukJB9ppWxA8fUuQWqQhEgIodTCTZMbPZ9/EEWKutF8HAu11uDRGYre1q8Sy+0iu+ZX4rhXqlcrp53choNt5v/Wh+LN3mhGhsmU04T6PFoDRcLnA1YJR3Hr0zU6rgfDtTKtNEb+p8p8Jszz5Ai2vphuedjACDg29UwtMdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9k4PidC5JdIKY6MEKqYL6sYAs3JWw2YPt4xDsUf0NiY=;
 b=Xe6wdsEz7wo6nU93hSgfySiJdCLuDqZaDSwjrDxXkiAw6eFYw6+I0Ye2Oc2NUp421VbgIZj96TPMngAnt7S1asXVBBTr8gf6Ot9pO8eEYqBdxnGzAv3AlOd40oxWU+4JfsBes5cJLqUe17EH4hC0iZsIhEbgcfUuGJq0YDzdGe+i7/UkvjGi88ImPbKsutw/UtDdDQsZueiLNP/QRW6pKBGiocxaobpwwW5rffmGwVaHtrTI/LGbSFwQjWiUwdJFdJkNMkYxob8K8lH5TYZOGdWN3k7m8+QLQSOtAs0AdXiOHh2LDLmcYQ7iwyrSuLXWSIr5wV+qWtbVwfbmA6lflg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9k4PidC5JdIKY6MEKqYL6sYAs3JWw2YPt4xDsUf0NiY=;
 b=F7dbBtlvTWnCpXC+/65++21+isFilAffqXhojFthcws7ZwAao+kZR/WIOEX84tJO2JW6rBBAvo67hCLmxtI0fYnexWrT5lqQomFmgwb/zNg3a/ciEF6W16HqA0FjLerZX98Lc9FEtr9we/dPzxD5n85HPQe03J1WpgOlz0b3Gjdlsnbg+EJGUlHGbc8bCuKdjM29GP72eNwCeLk811UYxT9hH+Nrxj6AVKvmpM2EBKx8V0zE4njFNJfQwjF+9xWuav6krX0jRuK6sgOjeuecmORXrGetI6iKKo2SH5J/VePXSwM3zU2kC2I1W++FX+HJFx8P0gIzQJGp6h0KD6enbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB7286.namprd12.prod.outlook.com (2603:10b6:303:22f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 13:59:45 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 13:59:45 +0000
Date: Wed, 6 Nov 2024 09:59:44 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>, baolu.lu@linux.intel.com
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	jean-philippe <jean-philippe@linaro.org>, shamiali2008@gmail.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd: modify iommufd_fault_iopf_enable limitation
Message-ID: <20241106135944.GP458827@nvidia.com>
References: <20241028113209.123-1-zhangfei.gao@linaro.org>
 <CABQgh9H9HWaKRP=rFvXf90PjfVP1M6YpwfLcYTZH1hWET6GPsw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9H9HWaKRP=rFvXf90PjfVP1M6YpwfLcYTZH1hWET6GPsw@mail.gmail.com>
X-ClientProxiedBy: MN0P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f50a712-0b4a-4a01-5af5-08dcfe6b44fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VuvLX3OFDJxv1jSQE/7OSFJnfSgvhM9h53WvKnVUkWhlR9CzX/M9tW+BaFr/?=
 =?us-ascii?Q?l6ZjtVEE+REoc0xR1f7tptJ1eNHOiFImnhDaF4mE/4ezMPX97nXETcd/Qt8c?=
 =?us-ascii?Q?r6p715PiIGEtSwhNYVu1TETc208COr63xkvkQX13HvttxZ7VDpEqAXF4E5p9?=
 =?us-ascii?Q?JaZiPM/n+QMAXF+2JwTt+ixk16CvrGG6sctxqCLJhmVJRAEoSgyMFaXu6gm2?=
 =?us-ascii?Q?gDtfl5EFYC3M7WKBOwzi/KRa5Q8LhYTY1gmCNgDj4B1yeeLTRChcRVOzMpx6?=
 =?us-ascii?Q?lF3PYO5cF/9JVQvnJWeNDO3m8I8BbvcUPKab1FR/eaBLmEpuLBgIiZuUkJRw?=
 =?us-ascii?Q?PWQAiAYs9A4GThQ8FCWY/blIMfTmd+cPRIH38jIQZDSdz/7WmQTSu+tjVL9I?=
 =?us-ascii?Q?7ewsJGfRZ3iWhhEodFmnUrC46yJQrcCZGGKjT0tfDhclsOm5URDEcgRnq1AS?=
 =?us-ascii?Q?x1wYCJ7doXdqRi/fSXaQnusmEKlVelfhEBI89zL8jQsOuTTUhEjo1UZ3q7BT?=
 =?us-ascii?Q?4oB9afyOv0x95L/rxlxgJQjJhT62gCjO5LtplcHWfEvG/XITrFppE1d9OPfR?=
 =?us-ascii?Q?rKTsBK5RTymPBksebs9TvtvUUazH7P3zhsoJQOFXv/fMXJo39rK/cxlxPLHQ?=
 =?us-ascii?Q?kBpUnBJCqM7Tt7m6RxKymKBGv0WkrdCiGwNau7l/SzEK4PUoAc5Aa4hCzmPE?=
 =?us-ascii?Q?Zk4tPAeYJqyS6fGEL6rkfGrGU5U9Q0PIJheEZEdP9AFUK0wbWUPczzGRynP0?=
 =?us-ascii?Q?J8abYsYqNQg9WR6eNZgUeDLGD9uQGBccg4novRG8oLavJqfdZSoZVXtS5dq9?=
 =?us-ascii?Q?txyNW7Xj4dvzsEeEgFR05r6AUKViudAGPieSycW2fs5ebdmftbJkC4uLI7Vd?=
 =?us-ascii?Q?hHDMpWX4l8BwvDB7mU2h1jaT4mgS1wfguCJOy9MouQa5mXSHzIOqkBSDX9Zy?=
 =?us-ascii?Q?EDIVvlIKT+30DGPbJT2n+qefQpdqt0jWWDoYZ5qPQU+u6LGhT4x4IGJgyDtM?=
 =?us-ascii?Q?zYV3Zx8ZBeFp7p1lsmS73D136tkKF10xc7K+b52VAReoEIeqtEi0ky9tGhcU?=
 =?us-ascii?Q?lNUfWuj0xvjjy96+Tpng5DF+5YjM0AQQqZttIFqm75lHpwYsMHxV8akPYdvp?=
 =?us-ascii?Q?6kE5jxTdw1oKMqRDs1pvtGb4N45yKTkxJaUgkPpNH+z0UtlQ0xREAcFGRcoL?=
 =?us-ascii?Q?nOT2ExHxiRTZFiDr6sLJ6NlWf+k3ql6PlZUz0DAr8CXzztoJrul1OeH1T7lH?=
 =?us-ascii?Q?alT1RTMXr2xjwtwAAniHIxP1VGzazG77zDqDTSqOoTegmG6iHe/yN9j9k7DT?=
 =?us-ascii?Q?u5c2Um1gLxIGOfQBiMvZUGyL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?73MM7qPB228AZ8DPPqF9e3+YmN+YgKUYs260KCPlIhvRsjhkSce8Ke0WZ0Ac?=
 =?us-ascii?Q?47pkC1ASwoTfq5n/eXFSyxygmdbdNiUSRyBezBJpolhKBGNEJiPViW1s01xO?=
 =?us-ascii?Q?DPvNypmAMck4f3CYNAWfrIkjpeGvfIvCcSjTiLMz9mhWFXy9wPbtK1U9fT9i?=
 =?us-ascii?Q?IsywGaXU/fPFwWFvqnOUr2VlmdkSd4kcVZ9U+WWVX+YUiGJS8uyz4dM9n9ew?=
 =?us-ascii?Q?NRHdmb+nSNpM9rZ0y5W0Vz/NoaTlDK8pUw4t5pblGp3XdOt7Fz4c1yKo6ori?=
 =?us-ascii?Q?qG9tJ0VDXqLYPurmnlwp+CjgxfupqteSQpcpKVX/NWZDP+AG/VBSoqdm9zuA?=
 =?us-ascii?Q?zQvqK6RWcOcQYr4sc9toeYgf7TkYJSUSgTcWhDj3cIYsmXi+p7Cw6zc8DAS7?=
 =?us-ascii?Q?aEd2oEI0YsuelqX+++aDVkEDPWdeNKeSBojZ7eVab3tmQu796B/1K/WTSa/7?=
 =?us-ascii?Q?ZJcFpP0TG9RGahUM8NyNlaSB6xErQI08xAPyHZRqjAai/gxVzP/4qmoj43O5?=
 =?us-ascii?Q?0YIGblWhM1WEidUS/4u7XpS3M8tHIAfL6v3GejZae7HRAoFUmNf2morDcoT0?=
 =?us-ascii?Q?026bwW5r5A9gLsp5B1Dw0H4YXiVlg9jMcnjQKWZUjlnc8Et/4fVD1DHyW2Zh?=
 =?us-ascii?Q?OKSRIkJfayDvM+0GBM9pb4LtNzIMA96oAvJRCtstdRlRsTMDHEEgdFA9Ss6D?=
 =?us-ascii?Q?+EGcu96e5TC7GYn4+mvIjde5WhLiDn1R3M+QykH5v3HIu9IEtlLmRaRI2ZYT?=
 =?us-ascii?Q?tWl4+h5VSyfqrqNr2py4exwSIOFYbrHcv5TEdhsIwfNQr1j9tjKD3FmHxVAg?=
 =?us-ascii?Q?B+x/DlykyGAbnsjeHWr2JHcY7KrTdseLvLoBTSf/SO9AU6/smevf6yz8D75L?=
 =?us-ascii?Q?RNvnprRpdheRoyScRfcMk7fSwiestabdyX+1ipFFp3fhuw4Z6fM6wV6uNT4u?=
 =?us-ascii?Q?SEZDbUiHeMlI9So6fzcAhfrJVSf8K29H8AJ7fAdPgF35p80P8MGz3bqvXZ/x?=
 =?us-ascii?Q?G6s57qIG5Aw8aVbnauAExb5jZGZsiIUVINKyUUwoTvgHgRrmSij5ivzYevWT?=
 =?us-ascii?Q?InY7Jf8iI3J517k4+Q6IWizswC9dv6YGdIRTl3Tp9L/0V1ecUL7Rm44Lv1rJ?=
 =?us-ascii?Q?YgQsvNGsN7K+8ZGaiIzEM8uZ5CiqW0+XXYCTfDULyeSynnLxpdyWUka6AxYC?=
 =?us-ascii?Q?Sr+uIeCI+fSZl1AWpS37HxBTqKeEVv47GdTFvIfNdVNi12ii1Utcar9gvK69?=
 =?us-ascii?Q?Eb3B/ceo76E3Y6a4yB6PyuIfwWfXbTkI8L0X7YeJBdEon65pDcsFA1lj2nMR?=
 =?us-ascii?Q?HVztaVb9RmKHBNOZSsHeQVkUYXGcZkbbbCYIdO5kemn/79+TOP/AuX+QPMU6?=
 =?us-ascii?Q?fEnpoDjTuclcJUppIZkguwEzABpjCLj53CwRLChCabS5SCIFHzt7oE02t1Hi?=
 =?us-ascii?Q?RCicasl5UftCHXhNBvcPHNUF6hP/sl87A+WCWNQ1E3ogl2dPRd5nM6yGK7n+?=
 =?us-ascii?Q?gp4ETIEf7PTQ0FDpf/2M8vdWW8Au2x8DufVkOMch2byLri0QRd7CTfp/QPmW?=
 =?us-ascii?Q?TBBSOYDR3mDQ6bT5wKcLIsP9OzCuapS6BjlFlStS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f50a712-0b4a-4a01-5af5-08dcfe6b44fe
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 13:59:45.4193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nq208ayVSBNl+fAA/E3Ix0YYQ/yLZiLaP1p1lYTt0BFvxkcJMe9EveiehoBus3qK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7286

On Wed, Nov 06, 2024 at 05:47:09AM +0000, Zhangfei Gao wrote:
> On Mon, 28 Oct 2024 at 11:32, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
> >
> > iommufd_fault_iopf_enable has limitation to PRI on PCI/SRIOV VFs
> > because the PRI might be a shared resource and current iommu
> > subsystem is not ready to support enabling/disabling PRI on a VF
> > without any impact on others.
> >
> > However, we have devices that appear as PCI but are actually on the
> > AMBA bus. These fake PCI devices have PASID capability, support
> > stall as well as SRIOV, so remove the limitation for these devices.
> >
> > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > ---
> >  drivers/iommu/iommufd/fault.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> > index bca956d496bd..8b3e34250dae 100644
> > --- a/drivers/iommu/iommufd/fault.c
> > +++ b/drivers/iommu/iommufd/fault.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> >  #include <linux/pci.h>
> > +#include <linux/pci-ats.h>
> >  #include <linux/poll.h>
> >  #include <uapi/linux/iommufd.h>
> >
> > @@ -27,8 +28,12 @@ static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> >          * resource between PF and VFs. There is no coordination for this
> >          * shared capability. This waits for a vPRI reset to recover.
> >          */
> > -       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> > -               return -EINVAL;
> > +       if (dev_is_pci(dev)) {
> > +               struct pci_dev *pdev = to_pci_dev(dev);
> > +
> > +               if (pdev->is_virtfn && pci_pri_supported(pdev))
> > +                       return -EINVAL;
> > +       }
> >
> >         mutex_lock(&idev->iopf_lock);
> >         /* Device iopf has already been on. */
> >
> 
> Hi, Jason
> 
> Would you mind also taking a look at this.

Lu? Are you OK with this?

Jason
