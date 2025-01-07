Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CD918C01E
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736272923; cv=fail; b=HBsE9JqUiLwzbowG7BLbtWSn3Raoyv7jVtW1qt+L7l51m3hgvE/E1ue286OofwViyWYA6XFHweLTp1vUPJb+Bh2DA2QP85Dzw6AYuZ4vLhYyyxRDwhrFka89SJ8NCcEKLB28XZnClIrnYV3rRW/5C+jOq2+79Aq84WP+FO0m0wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736272923; c=relaxed/simple;
	bh=Clv38ppfNE+onLNcwfoo+NzuHm0GwTUiquyWpBgHB+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h1R42SDa43t8QDXhAhO7vwsDqYttNtYRdaaSYqkdQYeH6c5LaKJWQSM3zmCfOb1w3n6GPPLzT4D1ZYNhGuqUOXhLIiwKxnw3JBpEDiyalzjORgCfyjz5c/2mvARQ+zFreR4juYsJN1xiosSpE83lAdHiNwj/0BkO+HO/DtvT1Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NwzbB3qx; arc=fail smtp.client-ip=40.107.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NwzbB3qx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNY1x0VwkcfKzRi1mTKRU4cka7M0mbXxww5ET/25MgoZmTnvs649flW9+Lga19YDDnNeppBfWJ+uupUAG83olKAwc8vMMl+D8sZdgMdtI9Vk2iTM/9ajiEnlXvV5UCZn2jcnKHkMAnH5tfQpboR9ToK2yeo2KyuDNXHWeT8Q0DCBq73WpMtofG4BrfbBHJyfUOohsy+8EUu7AW+PWySWgTBrNaoH9s/rvOB1vBC8auU/KFi07kgbRPMYSfS0eMvbSo43X/39hBqI44DmqAtRbYRoepwuvprxS6u6clxCFaF352ccez2MwltN6I47l+KoHDp0ZKg21nCI89x2K8HC+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tW5+Hb/xttEZkTobb3C9R/Ks4osq3udjYq3SUzCdMG8=;
 b=gFFjlHtCWEr/PjMXFc6+cLA2AJaTzE3aJywdmKE2XTBZQKVVHfgiQDj1/d4KkIyeZ3pqSs8yT0G+lPbaLn4yegjWGE/30kc5VyBVQE6nfwfnf1dLi8rUacYby27XYhnuOHsGtBSd+zJqvn7JXLeGfCJa9Jd9tGRVp/ZFYv3MlURJJxci3TDYRWkF2vCH6uhmrrEZ8XEOAm/WutHZch2dTNMHfL8kO2OA3FEGT8406/nSA8XTCLImklNsF+FtWdxQQ5urZTUfpmljYicTPYdLBRIYG+WNcQroCItuJkgE8yp5WvkZquFAQk6iL5Hy6GgBDJ4soTn0josZw+FfuxBQQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW5+Hb/xttEZkTobb3C9R/Ks4osq3udjYq3SUzCdMG8=;
 b=NwzbB3qxYycxog7Yo+srvjTuO4rbFXGHWkGC6oJr3YvYHBKnvJQsMySUWlldAhImMrrBW9ZjoaLyWYjoYDtUszISl/echc98SKOqfi+0Dq/yhD3CC2xgjlmGLi7ryZAVIoJw1PCQVVqYWSxZMnqsJoBXOxlqz2fjBFo/WXQP4/l2mz8pr/168gBt9rSQzU/2Zyn3kOTgVBY/hA1PDIBELXxr1uahaUnnBscqsHi4MSQo4xDMtcf1GizpKhLQow6lpxwts9t4lwTw1IIHcK0J6RU2rrbMasHef4G95WiUdy7CMk0R15mSMUd3sQzHpH4FAB+HVgISvHjNtJy5kWYj4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB6120.namprd12.prod.outlook.com (2603:10b6:8:98::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.16; Tue, 7 Jan 2025 18:01:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 18:01:54 +0000
Date: Tue, 7 Jan 2025 14:01:46 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
	joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH 1/1] iommu/amd: Preserve default DTE fields when updating
 Host Page Table Root
Message-ID: <20250107180146.GO5556@nvidia.com>
References: <20250106191413.3107140-1-alejandro.j.jimenez@oracle.com>
 <f87e897e-028f-43a7-9557-e65778267fc8@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f87e897e-028f-43a7-9557-e65778267fc8@amd.com>
X-ClientProxiedBy: QB1P288CA0029.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::42) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: ac9cabaf-38ab-448d-dab1-08dd2f455e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2jAG24S8ZWvjG5Gi2IhAorB9DA1Bn5pfi1TdXImGlQEe6Kg9cWMTUkzWP6CD?=
 =?us-ascii?Q?EjNl+/EkBPL1AWE2FSX4Zmab9SDg+Hps+z9xIjma937DKEDYVaknBPXQiku5?=
 =?us-ascii?Q?pWXhzS1xxq5R9/spISd455DekM+OWf+01k3RkPevQDzA9uBV34kahdArESYc?=
 =?us-ascii?Q?HJNw2NfZJVZB3BkicfAjahAQ2+JfswxHjBQ40wGuP6HkXEpVoOtRXpQPa5Dn?=
 =?us-ascii?Q?gFFwXfUZk5Ljbs2MNXPy1jGBfOSCTV2kwR0/vWCFNquey+f1haIM+mDCB0un?=
 =?us-ascii?Q?KPcO1UK/A1C5WgLNw9dmN0TXgEDJejF914w/iRncIot2OGqqRg4jalA6Y9lc?=
 =?us-ascii?Q?Pc7FQfJBhACrGxT00XPkPqncr3JBfz5xgDrrkyhoj2aa/Yg1FYwhNxjOXUzx?=
 =?us-ascii?Q?N/lfr31fDaNoQ6MFOp5mB2XW5Hds7l2SkuAqRRS91lgkCpGwL/TbfLV69F+H?=
 =?us-ascii?Q?bWUSPaQ1XQzG/X962pO6h91PGrrIZfHGNSKnlbpkgb0O+ZwbYj5D1Zuq36aZ?=
 =?us-ascii?Q?J+HErKMr/zFYQL1mA5gVFpb7j5AhWiWFSQ2b36PL40meJRHqBLDSRISVzao3?=
 =?us-ascii?Q?fYBJyl+curdiOFOJ4+3y+6KkQvhHjLY3g3MAoVTFnIeTGN4VSnSWFrx3nZxc?=
 =?us-ascii?Q?ZlyfBwE3tCth0t/GnqeAz5AYxnuf2xYJjICqL/jXWEe9BvII5w9rz+57voks?=
 =?us-ascii?Q?MSjyQPa1KSKdW2nJ7EGV7rcc7kjJMhly+WwXH/qXW83QyR9FOMs0w9Vq7z92?=
 =?us-ascii?Q?vVJIbFlokeVulC4lY15VoKIIxd4ZuEsQWbQbPFiC5Kw0OXRraquIBxfb+7Ob?=
 =?us-ascii?Q?Fz0b0gSPQnml8psFupZAQGqdzW6d7i349s4RgAuL8btOQxcOo495nspQZQIw?=
 =?us-ascii?Q?RsNHvFx61DD6hygXa9HnW+arnx5boYDwvHSZU1OgutCGPv3+YXAdq/K6wXAm?=
 =?us-ascii?Q?NkJbHqE3xwfOMvZtSU32jGZj2e48+jJDdsPuoO76wvHZkQ8czAX+kO6kTBZa?=
 =?us-ascii?Q?UFyFF7V070T2+krUV+J4bDB6QGUsYq8rtBuUMLy0LtQfKxmmHeNVmaPm8dDA?=
 =?us-ascii?Q?qUEZbpLnMc56n3Wbz1O7vlSYQ6XncEWXRitKrZiJXWBysNSoChsGhu+XcoSl?=
 =?us-ascii?Q?UAwV7sFkIeA6RRajdy6ZCKY9pMtXcSB7AfIPvK5N8G5XNz52UiWQ+WloKryH?=
 =?us-ascii?Q?usSujve4AB17s/ucuFeYLvRt+REtM33EMV8TlZ98JMzDZ94kQ8luiOHplLEd?=
 =?us-ascii?Q?0TJQ0xH1eJ8xVJIHaYlzctgwhg5l7zKJJeSIOSF0v5L0vR33ZKlD9Pecv+/T?=
 =?us-ascii?Q?011jHoQpRWFnKD0I2YDuuDVhlR78tiPD9U6kDGnQ1HGfgkuvzgYlIpsLn41d?=
 =?us-ascii?Q?PzCRs96dKA98fQoK83Y3PYQa9WCB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0wFzJ/pk6A3/FZSxk7zEYjwenyrcUTI9cpDGylVvYj5rsw5pjQGPnfBYIMY1?=
 =?us-ascii?Q?i70xSNFg1yOExFMMD/MD1jEWTh0oHl6gcsolVzi/45cHiXdohgq8SJzZ9NrC?=
 =?us-ascii?Q?4IxcEkU4utwKXm+9ORlKecVrb8AALzDc0NjvyLAMaP03quf8PzR/ZCMHvsmg?=
 =?us-ascii?Q?uqD6JJq3Lg9i6FBrK39+ebwD5/+6j/Pv4Ft9lmqWyGOLz2s7amtK6Etjo5XB?=
 =?us-ascii?Q?wkYt8j63V3d9qlAuHwLeMVMxpRJiJJwf5Npfzycl5gaeuHG3SGEpPI5/n4Om?=
 =?us-ascii?Q?+2aAR9v0cFuqp2XheXiw+waZXgpXNHZQSeRZvbaa26CZQdh94gg1mDUzT+/P?=
 =?us-ascii?Q?bCt/ZQAg0633z24fHL1KuhDb6E36GxyZ29vg/4rtvacwoapvTH/lwHFnlFZg?=
 =?us-ascii?Q?X/3ECsbV1PNpkhsdIhCS8BsijHEubFVuS0j/4/CPnAOfR3q7tIp3lf9+MRSk?=
 =?us-ascii?Q?/FCLXyWUC5zR283TaSelAyZwDe8XRTjurIg8+62TRPP0jJ/OkI07BMsdqccG?=
 =?us-ascii?Q?8b9HqFBqifI5HyUmEQwTVlUHldI2Dwd0rIvgfcil+dCQXXzev0msoGx7OpDv?=
 =?us-ascii?Q?U3Glq13gNi03gQ/bjPcODoT3ryjhIW+eYhdW3G4n2PYb4wyeH+H+95YFyW35?=
 =?us-ascii?Q?BGbvNBBgQOw0j7zkfVUD1IeeoLOH1lsVYdyLK2FrkYhPI4DkNRJwn7w1elM5?=
 =?us-ascii?Q?7MWPsXt8s8TTZvdS+Zrg61tZ2fHLyMGCkncbfs7HqhWkKjU2xMbBdbQkPfOK?=
 =?us-ascii?Q?hOYs5wFbPuNpajlfBzc0jUIW+VxcztLVGFOMhR5ehU8gVSaqwGCOu52prV8h?=
 =?us-ascii?Q?W4VLIwjWPuJPQLkpCHtw0n+yRzGM0mE4kQke37YDg121urMQueBRTn/oik+M?=
 =?us-ascii?Q?3NifOCuvrMKwL30JjScZDXd5Z0UB30G+5KILcHDycOIRQLs6Eo1HeQhIaL3p?=
 =?us-ascii?Q?MwyX6pQvUl6DiC2BzmDLqLbL2ykHPVI3a2Fz8eI8f2g9QInWY27CtVQqr1F/?=
 =?us-ascii?Q?MItnFb8k3mFwi++/mOPQYZvtYEgeliy5x3Lmw1x5LlgT969DOboX35hSDD8t?=
 =?us-ascii?Q?VSrapuSOaJYyRiGAm4fO6PwKAUHlRsFeGfvN8lwg/FFlCa8aJIEQnjQl6UGU?=
 =?us-ascii?Q?AAmVGWsr0P7RI7tbDWVXva4odXVdr1qcQPpNMfeisgRxKsraRAoc9X+9MNp9?=
 =?us-ascii?Q?x/VF4vrKr8tfB5r6AqWk7hBlcjZcFBV0txwlx40OcG+oXW9ugkGK8KRwn2v3?=
 =?us-ascii?Q?KKV13dmuGjlLJ4P7zjmqiUExAoHUqVih4B0Rs6n7D/XXxWSkWc2M7aPXUFo2?=
 =?us-ascii?Q?uWrzsjMe6OUnDSPOmblbVqFaCmer1mPtqckTwhYv/fjpqYxk2LgpQCXhoO6t?=
 =?us-ascii?Q?MWquuMmgacZcz7iZicjgrkCY5bV0quKMH432PBkz/4kY7WFH9zbGsZJA2Vur?=
 =?us-ascii?Q?OmyJKIB1JTkFdt8MogUBbuYNVvjmUmq8y/F+3qRP9YtvRXmCn/45W0wrZ5/R?=
 =?us-ascii?Q?g9aSmBjNUlTF3UxRkH5tdILL+BaivK21Rv9z6fa2OddgWqvsdteJqQLHyXSc?=
 =?us-ascii?Q?S62XGzdrFWokx3yhtFqPQWTlPFNMkRw04063+w5u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9cabaf-38ab-448d-dab1-08dd2f455e55
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 18:01:54.0257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZghcE+GRgziIGSc9x6abZMl4StEB73SJAqJn9Fg4qW0TG/XP6ZZuD4GZaRenJfe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6120

On Tue, Jan 07, 2025 at 05:45:38PM +0530, Vasant Hegde wrote:
> > @@ -2052,12 +2052,12 @@ static void set_dte_entry(struct amd_iommu *iommu,
> >  	make_clear_dte(dev_data, dte, &new);
> 
> This fix is fine. But with all changes we have done in this code does, do we
> really need make_clear_dte()?

> How about removing `make_clear_dte()` and moving DTE_FLAG_V to
> write_dte_lower128() ?

The V flag should just be set by the functions building the DTE,
write_dte_lower() should accept a fully formed dte as a matter of
layering.

I'm hopefull Suravee will come with something like this:

https://lore.kernel.org/linux-iommu/20241016142237.GP3559746@nvidia.com/

And then I'd expect to drop make_clear_dte() and sprinkle the V into
the individual settings that already have bitflags for entry 0.

The one place outside that call chain using make_clear_dte() is
clear_dte_entry() which should call a set_dte_blocked() with the above
break up.

Then the set_dte() functions are called by the attach functions and
you can get hitless replace.

Jason
