Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A508278F5B
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 03:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742527328; cv=fail; b=L/dyCb3o09JfKGgV2S/Xq9nCrNk7pJF5bX/+MESIV8LW+GmSad9TCogGZcVOs46CPyNARDYsDJWVa9DKXpsgPOE9EHw+0tNKlpKDjVf1RVF9rD4rgBHclrArYwZd9p4HPCQkef5oLClKcmw1Zy/LpRyVfw0Y2RRUd0YoBm5Nda0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742527328; c=relaxed/simple;
	bh=iq/pZvQZMg2+3yikSPBIO8pWIw1PcyltZtzL0cvbWRw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSUu3TF/PLDukPEpa7OV/YphIiiZ/JFFmxe541RghQU+VFQuw+F1OdlMqQSYWOwnoYUoevSKzGPtaTpqF/Rwvd0zrHzk6RVz0iho+gdaMGJ/26Fh8DE+An2hLjLteaFrgBUGXzAHWjaAkiyGbtMPXZpy0x9zQZT2O/0HpN0/D+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JJ+LlcDP; arc=fail smtp.client-ip=40.107.100.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JJ+LlcDP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8lfa/mJmcc9Ts2E1QGyAcGYClHpyuTHglMLP8q+7j2YD7aNWAMmGQyIudsPWxHp40OodiIiZ8SHwCGvO3tdKda22LdXjJe5/JEP3AX8Klhy699YOzSTo2SSfWl6QK6r3Kp95tizGHJUIQN914ZxkB3juVeLdWKBQLIjD+DEJ1PjwnDBJ8oCD115a4cB+kN/feIy0+lsA4eAqJm6aTm3ZqSlz/DBTrje6hYdMp9nFUZLQijZciA+gSnYHfLxRtKj6a+c8vDb9L/K188e888Clit0s4TKKBjdtASA5fxh6WtY8SFnxLR0KGuDAw9tXi08VMzajVbIYn7wUC/tEdVbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmHT4nTHJCyXTSTYxlQqJv8L1wzpVfsDa9Sba1QSoGk=;
 b=pv6Cb+DqNGcc2lqa+YY7DEJy2HSrZgDWI7nmAl7HYdMYN+tA9dczMcDar6fjSgPN5NIGyu3xGmSCwG6auuS2tClmL3aptHTTd+vvVYHZeudtKQNR/YzbfVGR3ilfUshfdm1qC/njmakBmNIPKArg3Brim1doWGi/UyIORLF4QSwM2e5yYseW5pXRmgkAE5nJIsgpXVtyVOtiRCbve0keNcu/bKyWJ6pnVuS01imENsBN1NMFD88VZTxAGUwt3b3d4wxGsyHjPki6SDKA8M2NSYqaP6M+ol5DTaGCOWyKaG8aB0rYroYqZOFL8vUFCYeMJWO7jzlV1RF2EhEU/bK42Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmHT4nTHJCyXTSTYxlQqJv8L1wzpVfsDa9Sba1QSoGk=;
 b=JJ+LlcDPkEG1Jrxy53djO1awdxRA7Tgv5IYJnqzoQkf6HXf846X6PU9zCridvL6svWTn8gN5XAutl+fEk9Hg1ttq/Dalm5iOaINZbYvdMcuyOU1COeJgZatvO13A7f3M3Bl6pLjFvQvjU3nTA92zYkqYRaXltheN8Zx3Ik/QDW+wqkSr8Mn7LRS5wit/85AEjqbRi+zuZa9fF0iES9ylhCd5rWZBntjzGdlWGdHgQKcxZ9UsmyW8rgGZMjhZ6WxthN938yUzjYUXZwVl0GB00bhAZaCNd6N/25zaGgNczhHLMuwYE74ymYlXo3f7CCD5/g0YpYsCa2WXSEbAohhdtQ==
Received: from MW4PR03CA0357.namprd03.prod.outlook.com (2603:10b6:303:dc::32)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 03:22:02 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:303:dc:cafe::42) by MW4PR03CA0357.outlook.office365.com
 (2603:10b6:303:dc::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Fri,
 21 Mar 2025 03:22:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 03:22:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Mar
 2025 20:21:49 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Mar
 2025 20:21:49 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Mar 2025 20:21:48 -0700
Date: Thu, 20 Mar 2025 20:21:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v10 02/18] iommu: Introduce a replace API for device pasid
Message-ID: <Z9zbS8u5XDTgefOr@Asurada-Nvidia>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-3-yi.l.liu@intel.com>
 <Z9xPaGV8f7Nr1HGd@Asurada-Nvidia>
 <86dfbb2d-18d1-4f72-876a-edc131a8f47a@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86dfbb2d-18d1-4f72-876a-edc131a8f47a@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|DM6PR12MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: f22011ef-33ca-4278-26f5-08dd68278c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BhIXiM4RQvg7V/4xCiIa9OnHVrW9/wErJxOMFpApCgRfoRbMfMW4i+oIVVjw?=
 =?us-ascii?Q?XdeY+h3sM0XSj9rzKiIip9CP6CzDxDIEkRNF3g9qGOyACi5zc8NIIawXrVDR?=
 =?us-ascii?Q?nJIk/FgVEhEAP0P6pb6ag9Nc682nQSBqMOgB7DThdi2pk/MRkGhc69oLwteO?=
 =?us-ascii?Q?X+9qAgvFVYn19cwQc1Azux5xef6UukE6M6saDyZBNjD1lVyqT6mA6Pmk6vvL?=
 =?us-ascii?Q?WyEbh/fCFTNcft7OW42XgMJoVbUIRra8At+yJKOrtW/x5PqySYOAcQqAd26z?=
 =?us-ascii?Q?e7JbEFjbz3rIg79peSUEQtldswQWGDMEEYxveLDXoGcTwM/5fVqU54QNjkqm?=
 =?us-ascii?Q?vMIgFXzLoKo5N6O4gtyXe6ag1UOMJMXcS9KnCvAbMFvJFkiesU8FUsVA/MUp?=
 =?us-ascii?Q?l01xPKtoVIfZwLIhCHg9X/eBEAn6sxen4/nJoUbz8yUSw5KteeU1H88A37V+?=
 =?us-ascii?Q?rxU4HVvxNVO880c1zEuvg/+0pAdzceti8PNyjG50IcZrqX0tDnT+OaBp4rpr?=
 =?us-ascii?Q?aNLcR+4vMzdmta3CXRL3XQJq+NP5W1XQlO3BSlb45z4yjkkmjJSVLnaNMWF+?=
 =?us-ascii?Q?CoGwb083Bwzk68OaoceA7zI50voH4sY9QMLnbB5eD4+OxDxZ+UGt4rNeZjl/?=
 =?us-ascii?Q?xWz7+eJZiEE1gxYPi+bnNRoBKsI461vtF1O4eOu3D3p01iDSs/4y7YOc6oho?=
 =?us-ascii?Q?Mct7BKmGGtq8El35s/Gz5DMqN7WZnoHY8UqOfy+66R0wa28/Sv6IiaZvgbMy?=
 =?us-ascii?Q?U7s5EPP1VjE7U2ktHw5G/WFIF8Db6lbQdbe5WlB//S8yD4RAMuqrL7+A0z+f?=
 =?us-ascii?Q?fyFdADiHsIOOch17dLMA44qwPkjbl3r0rVGa+LGDav1/ylDvEWMbMxv3IYE5?=
 =?us-ascii?Q?EMqMcYtQdwDMMEuwEPWRxgC6yohcZNqeXpmoQyB6t9X37OGza9854Nei2S0Q?=
 =?us-ascii?Q?O8g5lNjtdQXOXB2K/MYoi6pLzOVN5qR8YjZnql1QMUBaSJ0kr2q8IMiBDi/M?=
 =?us-ascii?Q?DL6J0J1UjMH3r+AKX31JnilMpXiTKmRdr9RtY7zpQaxu0NCotrUldMxXxtN1?=
 =?us-ascii?Q?2dJJYGH8qBvhtC28Ea/6z4XuJHYC6FrRsa/I0a9efJyBVFk0ItMslVppfDW1?=
 =?us-ascii?Q?9gwU1kCURnMwiSE0uBOqdjPjQeRaTbutx+ouLUVwKA+0vgseEpQEDg03558O?=
 =?us-ascii?Q?sxdm0N0GnKWfRyMEDeEnzyzn1Gu2QYpODxSrjLK7lZ0pkNkPOXuMb+5Ey5kY?=
 =?us-ascii?Q?EHsw16UxCfAY7z5lh7PY+MwOFBLfh73u5Z/XlrOpiBS/ItZvpFNEy9JClUve?=
 =?us-ascii?Q?wSdhYBeBFsoCzGhWPEZNkZlcpbRnGg5U/UXGSIAOFDer4G/BCHaNOVxqIo9/?=
 =?us-ascii?Q?LZBznow0MIOjcVVsNj9N2KyTVwYMOhmgUso0lqCKqiF3A9BZ1qYrC6PiS16o?=
 =?us-ascii?Q?BzB5DdJCM88U6v7Q1OzXX3DjtCvZIgxcNWE78HCC4/1Z3vBW3ddiph3lzO5+?=
 =?us-ascii?Q?hzqwC7CG+DNaAPw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 03:22:01.9619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f22011ef-33ca-4278-26f5-08dd68278c27
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404

On Fri, Mar 21, 2025 at 07:58:51AM +0800, Yi Liu wrote:
> > > +	entry = iommu_make_pasid_array_entry(domain, handle);
> > > +	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
> > > +			  XA_ZERO_ENTRY, GFP_KERNEL);
> > > +	if (xa_is_err(curr)) {
> > > +		ret = xa_err(curr);
> > > +		goto out_unlock;
> > > +	}
> > > +
> > > +	/*
> > > +	 * No domain (with or without handle) attached, hence not
> > > +	 * a replace case.
> > > +	 */
> > > +	if (!curr) {
> > > +		xa_release(&group->pasid_array, pasid);
> > > +		ret = -EINVAL;
> > > +		goto out_unlock;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Reusing handle is problematic as there are paths that refers
> > > +	 * the handle without lock. To avoid race, reject the callers that
> > > +	 * attempt it.
> > > +	 */
> > > +	if (handle && curr == entry) {
> > > +		WARN_ON(1);
> > > +		ret = -EINVAL;
> > > +		goto out_unlock;
> > > +	}
> > 
> > We rejected !handle and !curr cases. So it should be enough with:
> > 	if (curr == entry) {
> > ?
> 
> we only want to reject the case in which handle is valid and it is
> the same with old handle. If handle is null, I think it is ok to have the
> same domain.

But !handle is already rejected in the 3rd if validation:
+	if (dev_iommu_ops(dev) != domain->owner ||
+	    pasid == IOMMU_NO_PASID || !handle)
+		return -EINVAL;

So, it can't be NULL at this line, right?

Nic
