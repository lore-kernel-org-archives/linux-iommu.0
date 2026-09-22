Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B823F9F5C
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099260; cv=fail; b=Ujcn/xsPYl0kz23kGGB+LeEUNH/+1/COpXKLaimaovvio+c63LvSStDUUYi2nysmz/yDW8imCtiGHQSKI6M7GZtwG0Mq2p2B7BnFJTosJeTAxrFIJRnjRvQOMwnYay98ii7+YJpdlxuRr0ni5z8l0hiieUzZ5go6vnqMicKJ7TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099260; c=relaxed/simple;
	bh=BwjAP/WcvpjBcVtKgmX2x//iH7ebBAXxvSDUbPor2gM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xyg2BpyMfFJmBycR9kZsDLgvykGzNJso1OuyzeARIbRY0fJzPuLb7qTDXz9mh5Z4G+szrPOCxj/WcGFACuPbn5Hl7c7iocA2G/xO3PlwaMjXGS2qC90HgyIBZNhedFW2sxyBOc03LQTDVwm8oirN2u0u38TzL3CHiktEo38ur2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AuMsi9uW; arc=fail smtp.client-ip=52.101.46.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AuMsi9uW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZr3Bc4sbq6vZnJA7rU8vnHhpb8DGLp+x++AvU/7uJk8eg3V/7+80MzTDgSswdW3gedYruhlNFRhwgcpUpPEhWvqhHMdVo+rgH5uUGxaK7U92CJRLBpFjVuS1hFdQ8vRrjemxM2o5XHV3iKJg7NNH3loo0FJ5yoFS9vmstVUdlS7948xWOQ1zJKzi62QlB8524Ywnxj7QZyhPrWDzW3/AcLJD7sqcInaWXb/d5VE73mzTtujkbVcLFrxPF5Ww88qlznLPqfHScFouW9HxuDbWHfBWd9sW9sMRm0JGggN32gZXf03QG4kahKyZSljRiVj6vNwJ1MEvlMsfpQVpiyrGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYy57RCaIbH8AQuOVsCUXkefx88wksD4vGg45jgoXOE=;
 b=fbWnBt+G7LPNN0oM35mnEzHxbSupyI9Ftj16M1j6MeV/a0ffb3+sUCld0fzC7tpYRebfS0ht+0l/qBjjhkSwNJdsvAAD573C/T2suVTqZl68JukZfALOVXMgHamhZu0BsY238Cz2ESJUQJotRE0uUS8fzbA6/SJtA5GmOmE7OO36Qisuu0/3cxZXwEtWd78FOkve6VQ3nakcEiWwECg84bRjia/kN+3S45WufCoYZR+irNI/HbBCVNZMI7iYPy4k8+KZz7ioh9IEY5mRs1NRxw0xCKevUPjEfxMPzx3OWY8UskcrwXGhfhhL3x8ROV2VxNe7uSK8P8GjmSKewPA2dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYy57RCaIbH8AQuOVsCUXkefx88wksD4vGg45jgoXOE=;
 b=AuMsi9uWVMVXopwKrttUrZuGxljdXC7XIr/FWTqMGO+p68Fy6HQxQRl7/I2NwK8jJ71zLlvu6+lb2rCTUFNDg8y2KoaytW2/hltCdw5cnTVg7SUnSV7FYhF74L4dyCVnL+/Ml42k+011lcgBysmgFnIFQ2gHcu005C2rUR3e3OJRJqBsgn7Wkz//HYjFDtlQoLWhfTWLncwCycMd+EjBOQCpbwwnHNt8AHDFeo49ItWHR9rOcP0J9hzVVFWUVv0eSLeItylfV7zeeN+7UJm1oYQJAToV/bP0epBfQ6JFgFS0p4UfmYEkyQGGgwnIoTaXPO68QE3W4UqOmrlCaIyfQw==
Received: from DS7PR03CA0280.namprd03.prod.outlook.com (2603:10b6:5:3ad::15)
 by CH0PR12MB8531.namprd12.prod.outlook.com (2603:10b6:610:181::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 17:47:31 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:5:3ad:cafe::51) by DS7PR03CA0280.outlook.office365.com
 (2603:10b6:5:3ad::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue,
 22 Sep 2026 17:47:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 17:47:30 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 10:47:06 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 10:47:06 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 22 Sep 2026 10:47:04 -0700
Date: Tue, 22 Sep 2026 10:47:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: Peng Fan <peng.fan@oss.nxp.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jpb@kernel.org>, <jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v2 2/4] iommu/arm-smmu-v3: Support shared SIDs in
 insert/remove_master
Message-ID: <arK/FoWsg5qJ7G3T@nvidia.com>
References: <20260921-smmu-shared-sid-v2-0-4b656ce68178@nxp.com>
 <20260921123846.1663580-1-peng.fan@oss.nxp.com>
 <arG6hmng3NddGEHm@nvidia.com>
 <arKNJH2YWQT9KL7x@shlinux89>
 <31be5621-92f6-4101-898f-806335d56155@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <31be5621-92f6-4101-898f-806335d56155@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|CH0PR12MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a5f58d-e3a4-4051-dc30-08df18d1932f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|23010399003|18002099003|22082099003|11063799006|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	PGUi9Uz2mmJ5ioLn7xC8wJJ+2HgB1kQCbVpoQIitJyLhgTsr91cNPcwA2dqxW/LeCCqHG3AI3+up103mpwmidCyb0kCrcEx1vBPbzHR4Td3VA9G4elZoGYzPai9d3oo9eY0weJ5BNw6QhhyTMHN6I+VbpbmKycAej+qKcpn9wzRATlm0S2UO7hMfyGIGuuFFgBbwcj5TBiqatDIyEEUbExRy1lL6hZDWKNy0vFeXEa2poiVkekDjSE1wPTr42/FZ7QSOINq7xciM+abUzeJghhS3yi9NqAanYo2NHQEzNO4PB7xrwVXBux+DRF+8Au5nfdVaLAzLffmTHMeNoiSzqkBRTJdpJtF6IHIs0VQgbtfR2/C4myPh1+twc9KDSokIcC5PYsgFQR7q3/qCaUKHAfvuz8y3wBT8oELbfKhA+B1bajQRrOkwQ5Bg+X42o8Ai5Sd6kGnvpUtKVqLBvtIm7dSKrwxTVIAHOLN4KIBX29COyP02tvbsN7tSJeY80r/NoLO+hI3KB/YAqadLcD6COu+QVfMXShcR6JX7HygXcRf5J9ibH1N+D33w03EJitBs+Y8OVxX3Gz9RcbAkyT3Nf2J+aB8BY6c5mpSxDuEobkWTJr/VZMJ/mH2kyVQBaaE2BQn/gT63e61bBmlj47FzVQxYhwlMTe8RZm+UVVmWWexpfr+DYTBc2GHHFNoVEYyMpcGSpxQac7MSjFtngwnTRA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5OD6U2uFaYWqZF0A8wRHkY5Z6wyrrR+nB5Q5lUfW4b+BpC9uDu9DNgaKz1CSqP7LKGcvCVWnw1qJjoKCNVavzRmnzEigkDX02D5ygxkJcjoxcQBytLZpOSs2iG8ki6RAWknMvIkWe3RbyuSgiTMgtgpFqtPxX4LsztF8/tC1zC4n6UqmZ2r56K9lST2M9JhdQCUmN5zhtdJpByGmR/qSWFx9naIFwzQqxp2P6yzImd3QSpyAYQ2HW7jAiPw/bFMhEJOtNKuxCzyfLgEi8EY+iDMunfljfQwa9eZKWkex+GheNRv//L+mZ5TwM91RF7HqRhOtzG2o/HS3fS6SvVx0AYkuvV3HYpbdIbk8+A8sDNRGko8ck2IJ+q3tCo2JlgmAH4GA46SKJTHQQeAY30dfAFzBW4DGEe9v6z7Q207fiH1rC+cNuPWH3pfRl+M33ydp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 17:47:30.4864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a5f58d-e3a4-4051-dc30-08df18d1932f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8531

On Tue, Sep 22, 2026 at 04:52:35PM +0100, Robin Murphy wrote:
> On 22/09/2026 3:13 pm, Peng Fan wrote:
> > On Mon, Sep 21, 2026 at 04:15:18PM -0700, Nicolin Chen wrote:
> > > Does i.MX need to support SID-sharing with multi-SD device? If not,
> > > the master could have only a simple shared_masters_elm:
> > 
> > For i.MX, there is no need to support SID sharing for multi-SID device for now.
> > Not sure, in future there are cases that needs SID sharing for multi-SID device.
> 
> I have a system meeting those conditions :)
> 
> Specifically, I have a physical PCIe-to-PCI bridge board with a couple of
> ancient cards plugged into it (such that they each end up with their own RID
> plus the common bridge alias RID) just in case I ever got round to looking
> at this myself...

Though in such cases we cannot reject num_streams != 1 any more,
that bridge can still end up with one single shared stream, e.g.
 alias  = PCI_DEVID(0x02, PCI_DEVFN(0,0)) = 0x0200
 Card A = 02:01.0 -> sorted SIDs { 0x0200, 0x0208 }
 Card B = 02:02.0 -> sorted SIDs { 0x0200, 0x0210 }
?

Hopefully, we won't have to support an ancient PCIe-to-PCI bridge
connecting with another ancient PCI-to-PCI bridge...

Nicolin
