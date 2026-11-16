Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794856383;
	b=E5/2+GhFTATYR0MGPB5W+3tSXkguxSI1Vv66e7g+quOuc/dYsyD7H/6LkTlFgLweOlKc
	 6aGQpwKq1YjrPax6G+SWWYTYzirC40u6Fk1ywQMuE4JradRjT08LiLoVx1PnB9JwceqfT
	 mrQ5SR+mB/zdve7/cC8ELEghhtnuoDRPjiPcFFaUd1Hfmx9eDzPJAT0MnOArfGGvPFK4W
	 d7lhB04I2pRUoAz9FA8kLFZ7Mf7zPAW2gm85nXlg0hrd0b32WvARbckNCHPkVVW/q0Peq
	 MqFJ3m16zlNXOrD52b0RmI3kCMYG9onB8h9/GZ6zjK3KyqtYVDh1PiiWI50EEkUQcMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856383;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=VzGxpf3QyLCfQz/yJS9489cdcZsPMoZDXRFQcA3h93M=;
	b=PJTx3g+k/U5nOuNRzLEzEC2T6OmAKM40ynqiPowtE7w7SuANFo/DKAlO7UoAEL1iTacq
	 gN3OgauAn279dyWZ/ppuwhrX8i6WOwv51mRASSn2XYlS+VebWfavu7ZDbfrFIRVtH1jTP
	 j0efsbj3pwDk6hiCNuVqLJJSOeKvGCrtKMCSQ8htgdl1bEa6x6MAtSeOKD9Yv3jBXgN01
	 rSf72/EuMU5yNCpFLFo3TCNzYyics5LReMSZmp+PW84ecwlHXKLcJGr4krytG7REMsgUp
	 vAty0DtYRmRuEQWJt+fwUbgcTmdpIAvWGy/I8BUFavV2FNjnFQdaNX/OekH4pE1nKnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eSg6EBQ0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.26
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0539606A32A
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 19:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0539606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eSg6EBQ0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnrOMHDmdkPPbThZKDkyge6udHE/Dw4KIrfbOzVDtrAee+MDeYLLqPG9l3uR7kBAR5I8P0ZoDISB4+MDL1QX9Z9kV7Cc1DcgJUyX5qfPMo5A5dJejLv+kByNAu87BbJWcAIaz7ytU46iJ4CSr2Gkjth9bg49MmGzunB0aYpYqoi2qxV4pOkBfWdW182eFBlTfKYwvgr1brU4o6md04ecy1ymIY/DqS9LBxIbOQ0nxVRju520PZ/Cp0RG/Qz3nNAZdDrPF5LTWC/mYmCIQWxEh9E64n1zoghoQPhXjmWQqzMhn7YosnFyUR7c4CRjVC7K2ZvyTI798/YDEKQGh9ydyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzGxpf3QyLCfQz/yJS9489cdcZsPMoZDXRFQcA3h93M=;
 b=Xzqk9maz1dKj15duE8GHuwgzb1dPjVxiYP6EcoWq8fEGIpQocZ8wdX17jXEiopVfzSD0uLwTgmNxH6DedFsuEDo5ev5rCJj5O43nVLSmQnFwxnmrqioawCjyTY58e5MrjX3cpLFKUoeknBIu3KgSFKXaV2m1ibz1UMId68AbQ5GZ7HANcgNiMolR1v7IaM6zKv0uxvmJY+Ot+yb6iMNmiZ5layVzUKFcNrME9sE/zlB2ig9WU05pvB+G3ZrRyY5V76IZacuUIalt1xekcvpvFutTaO44IPlzKsGoQng3AhI8s4IpgExREtFGfg7KpKF7m94+97ZowbwLQNlHvtPanQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzGxpf3QyLCfQz/yJS9489cdcZsPMoZDXRFQcA3h93M=;
 b=eSg6EBQ031hdcPP1+WT8y96oSS1fkueUrFQ5GGs9/mGpRs4O76xeV3oAL6Pv3sj+KmLnwGnD65M+/ml7poyuTczFBIBzn5BouHcr9Rd1e1OlMPm9jp8WrzPTIAf3LgyaLW8bGjkgTPT6G1vG4XzEab5vTsk9Sb1wMRw2vSo97aM1+JNIOeZq0hbKoU8O5qRRyrWk8VYha1HXfMuxH8HrGl3bkDb4zr5qx7T/ID2r9Kz53zW/PSmUb16M3bkeKNvWNfniz8YBMfPUWVcpvFLq7K+SaTKhILVyMm16CE1q7uMNH1KLu/RM3UUQAAPLIB9k8p/FJk/r2ZZW4o6BKfRDGw==
Received: from CH0PR04CA0092.namprd04.prod.outlook.com (2603:10b6:610:75::7)
 by SA5PPF37951B1C9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 19:12:55 +0000
Received: from DS4PEPF000001C2.namprd21.prod.outlook.com
 (2603:10b6:610:75:cafe::50) by CH0PR04CA0092.outlook.office365.com
 (2603:10b6:610:75::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Mon, 16
 Nov 2026 19:12:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS4PEPF000001C2.mail.protection.outlook.com (10.167.23.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Mon, 16 Nov 2026 19:12:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 11:12:36 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 11:12:36 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57 via Frontend
 Transport; Mon, 16 Nov 2026 11:12:35 -0800
Date: Mon, 16 Nov 2026 11:12:32 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: John Garry <john.garry@arm.com>
CC: <will@kernel.org>, <jgg@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>, Cristian Prundeanu <cpru@amazon.com>, Breno Leitao
	<leitao@kernel.org>, <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v12 10/12] iommu/arm-smmu-v3: Retain CR0_SMMUEN during
 kdump device reset
Message-ID: <avtVoHxU8IXWi0fT@nvidia.com>
References: <cover.1793593923.git.nicolinc@nvidia.com>
 <f458ce5587ad991c85e65ee12e8f5b271e5f6745.1793593923.git.nicolinc@nvidia.com>
 <1ee06735-d651-411f-bcc9-783e9c016c84@arm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1ee06735-d651-411f-bcc9-783e9c016c84@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001C2:EE_|SA5PPF37951B1C9:EE_
X-MS-Office365-Filtering-Correlation-Id: 595fcbc8-dd88-4835-47dc-08df44159e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|7416014|376014|22082099003|18002099003|6133799003|261009223027099003|4143699003|11063799006|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Aadv7SwexKd4gdr6GCrXH4CA4mLFqNjp+XyQj1juvs/nmgU0W5RnWkrBCLo1xEJn8a3Y12WG+4mon8hr/6E8zsWwow2hhqBra8XkTOdDYpM8bIK01C+kT3wHge+egisXVJQ0bhQb1FcVmQr3yZnvniblUpwUaAMzoOUC+76yy6IGaWkaiOEFk+y1qphMb9wx9zqfkJOpxPOH4R2lDsT29vXJIpayjMbpWFltncnvdBG8jvTEShfhY7UjYAeBi7CvWVPW2SDx69/KmiPv4InJZc7G33CnGMPyseMuSavSEHRrXWGjaJSv9U3FrPM7SdX+4VRqpk9nXhzSpYId1l8zUCeci+7um+jRa8OZpAVvFqdfAJsFodoUtGvCvhPcqGT5p4TQlA85PLrfq73jgBScHtcByMJJmxS50+4CWx6k7ncupDVhj6C+Swq41oYO9SO/VEXWNNLlYSujz7rya1vnTMDms7tT27pF4D0QmPHQ6+miDAPYZngfMOQ4GdaOM/QoBcxNsbhjAFyPNgwBkkl+BUT11tPww94NTZN0Opralk5Vgv1sKzSaWxsKgBgaPHbIaqO6I/0M4GAB5XF4zLC91tNcTyj4dH1oH4x8aiIVpSBrZpvusTyKFZdkmjSkRXeuv4fYL3Ax0+A/GS4FuUxsr6Lr1Y4ccZ/Z8GSZ8NMMpoUVqiKbdMrx1a5obfQmXD0mULXZRK1RsyGXHMsd/XOaug==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(7416014)(376014)(22082099003)(18002099003)(6133799003)(261009223027099003)(4143699003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021135927099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w+s0AzWuic05qKnMJEgN/czutl4XHMVJb9bSoPDzlLXXQmMT0O1rUeZNizqzu2mjkd+bDwc9dOqKkh0juo9PM54Lse8QOlHXu/6XOnmUAC6NrPSZyXzXyiVkKlfwga3MBGUIVI8gVEft+prlfCF+j7O0ZTTNOgPO8DewGvmudcWSnlNA7wJlB2JVWgqSzbZbUy4TOcvOa6dgxFrS42+X+sWn5kCo1sdpQKLX79vfr6blKvbhz9fYODaVJvK54aC5sOc/y/KJAOn3Il7OjulLSoOg+t7OEtY+jhtLhgmg5nhP6T+fdoFGjjM4IzXL8wHIXpMQ34KiOGK0aebjmA37ohYaEyL4liNoplHyBnwVofwb4IWJgGOWiOX4mGdyHCzE4AacJVEOGBiU5Eu0yNlYlNfys6qN/4eW0U53UzkwK8MettpZ4E+VJ+UCzJj3Wjox
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 19:12:54.5904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 595fcbc8-dd88-4835-47dc-08df44159e17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS4PEPF000001C2.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF37951B1C9

On Mon, Nov 16, 2026 at 12:19:32PM +0000, John Garry wrote:
> On 11/2/26 05:19, Nicolin Chen wrote:
> > +	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
> > +		dev_info(smmu->dev,
> > +			 "kdump: retaining SMMUEN for in-flight DMA\n");
> > +		enables = reg & ~(CR0_CMDQEN | CR0_EVTQEN | CR0_PRIQEN);
> > +		/*
> > +		 * Disable queues since arm_smmu_device_disable() is skipped.
> > +		 * CR0 fields are independent per spec, so the queue enable bits
> > +		 * can be cleared while retaining SMMUEN=1.
> > +		 */
> > +		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> > +					      ARM_SMMU_CR0ACK);
> > +		if (ret) {
> > +			dev_err(smmu->dev, "failed to disable queues\n");
> 
> "kdump: failed to disable queues\n"?
> 
> And it would be nice to say or hint what happens next.

OK.

> > +			return ret;
> > +		}
> > +		goto reset_queues;
> 
> nit: goto could be avoided, but that is a taste thing

It's neater by skipping a number of inits here. I'd keep it.

Nicolin
