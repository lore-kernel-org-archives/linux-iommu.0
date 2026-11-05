Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793852193;
	b=z4NLSzJ3WlyG7C1l057F6UobzFCa69CP6wsjIHtMsj+ufBknwcf9xh/C8w99+nRkZf/b
	 V5ZP/9oXfaGpEL8gdJCw+W8zYqqUdk9jU6w9bNWOcHFn+mHm1pf0zRJ7ff6ynE5rcW8kF
	 mMmTmr46PhLP5LWrdKJSNFfvDjf/I+hyEYNxxSkZ7ZD+0zHUbZU3eOI8wlgI4SljOKdih
	 iqMAtZD9XzyWEpidkKJyHat1h4Mxvsr2tcIdH0a+KT26n/qXn5dv0Geqj1ewrYASMhuwr
	 Hx8H/YkJmgJYWAVDzemvcOMSrmLldE8IpptpZJyZTA1xOCsUW7TCV8cUDnnNp26rOFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793852193;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=HW09rZRj4TnFtY9y6ACLRyMv4JL+6LDbZWDzZYbtoNI=;
	b=xbBkTDafe+T66NsI8cG+ykUhZ1iKGt4Yyvyn2tgHtX7jY1sR3h0RIR/9ikwS1uOZG0gR
	 /JfYFVVOnYOxOBB+6YMkCCKMo3DLRj1SAOPSjTzCWfY1lZGUmA0kPB2et4Eso5PFyOQJ2
	 lLqoH2sGW1U773Z7eA+7IrfKiFRAX9LJbRc63Cb/SHcywZ34g9Xq9wtCR1vOsO5mI2C82
	 bmZ13lCCfIbmpjqwPckrPyDuGnPSfaGkV81CfLtEDywoL6/M3uMk6zgaxzaI/4x3yky2s
	 KHtFwODT4RRBfjBy5LgfrjSa49CnPc88DX8L2qu6rjofNBCzky0nog5gljPs8EA8DFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0oPZrSZd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.9
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8221E606A326
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8221E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0oPZrSZd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADh6dAf/u0JojgCMZwcC38iEqTMyv8xet3y6H5gxBI5wCKBs6haXFR8yc8FfnIQFD2vlo6K/RESfJaMdOzm4NcxFEHNK5mlNSgFhj14mWVyI0OYB7Y26ktUzV8Uc1fiskfqccvs0crf4elehtwbAT/hSJLAEpQSJLXBRH3SfIgNntQxlWMkEs9hEb2+eTkiSgmK0EGLK4BMIRrRrUG4Aih5rE1qH7b6uODyqsllc+YZGoO/36bds83mi3C0hf2IWsTaLayBTasTKYBXyS2CMuepl+TQGyjRn5HRjP54EDpIB2pWBSpA0xHU+1e9HVZ28k192HmOqzq11AOKZwMt+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HW09rZRj4TnFtY9y6ACLRyMv4JL+6LDbZWDzZYbtoNI=;
 b=Dx8nM9/YnAmDIMt16tmtA+8wLj1BdK8aqidG+VxuxNeTVTFhPXBA2hj8Y2JKz44xVxR4qOhb2+5PjB0fj5XvciOvYcCmGt5PfYHibdbKE4Z6Y3EgQ5KKab2arWiI0rcN7HcKLjW6hJ9I8blC7CoOT8XsUaS9NwMdL01jky1WAK0AnMorido6gz/TNAIfmsvLXf/jrLjadFMfj7kltgK/UaS8N+Hu6sz0aBMQFJ9WTWBF8NymzAHDPKleAkPIAZlzNAqn80HocmtNQ0yI0M4SC+NN44lkiLwE8/wj3dEGIruc1hIt2JfhSe7xelyuY8AoPgrvD2VrE/d6mD4nlI/7mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HW09rZRj4TnFtY9y6ACLRyMv4JL+6LDbZWDzZYbtoNI=;
 b=0oPZrSZdYfk8j4/DJVnZDYJEsaBMl8EMvBaV1Ic1FLs2g4TqP2ao4LTqO1xqi2FK+JPVJaHZrJiGdvos4RX+MvNHXgFwZYNaOpwwmdc9uUmeJCBGMna//IoGIMyxxRcJv2iHGZWKjGZMXG8ifACUQ7gl/s7KbVAk6wttI99QvS8=
Received: from BY3PR10CA0004.namprd10.prod.outlook.com (2603:10b6:a03:255::9)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 04:16:27 +0000
Received: from SJ1PEPF000037AC.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::8a) by BY3PR10CA0004.outlook.office365.com
 (2603:10b6:a03:255::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 04:16:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AC.mail.protection.outlook.com (10.167.244.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:16:27 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:16:23 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 0/4] iommu/amd: Various fixes to interrupt handler code path
Date: Thu, 5 Nov 2026 04:15:59 +0000
Message-ID: <20261105041603.399016-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AC:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: db049bf9-4af5-4a64-5ae1-08df3af38fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|261026121527099003|11063799006|56012099006|261021121427099003|261021123027099003|261026140227099003|261102123227099003|261009223027099003|261022105027099003|261028144727099003|10067099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	qXSR7k8KUC4OsHCnpehs5huZ9Y5W67FJZLNwbG0BA7LiVIa8rxYA79iolWgzenz3QQaQdVs9NkmdDeMg9PHBCabO3YLIg37C/4nwOmx9XADLBHVD+5y+SwEHcR+2yrrQ0QhbYYsA8CE8tCEenuX7IVw/u4wgPCCFa5ynEESbSDaT+iHAq1ngSgGzBjhchI1OHCBAZtUnFr301QNvsGxlmQXIsosoATeiX4NtWqNjYJhh1OBXr6JSIiu2ng4Y1JaqgWyV/SlxONLlRkH5cvNxC5yvUfFnii5Ja8IFNBwcCAIfZwJyxxj56ytDBdd9GkG3qAiK8T2Xt7a1bM8IrT4lP1IdPQh5eNiD3xqIN4GbSDzHGBlIty7/Yqg7VVqpLbAwZTyclga6I9v0mVsCrF+w+eMwR3QTgfyvBC3aOhgH6f7lRVpzE8bXCLEebWaB89pSjwTyzsMu3CSotN0aicr9tKkpcEvngW1nxXeNMC5n1fISx/XpDdeZthrldT1BQt9U0JSz5VY45Vzyh06B0Kan8HkFCXyaJqwgawUax7E2m4V28q637YKvKJu4T29YyPUM/pABzKbpKHHOXEHG4xf5IAufwjYw0e1JVkNGv3+PDIn6S35I9xaFin/da9Isz68unfgLtSmvuZYZW5/RVi6Ts2CLhV5wpzwj3KJUdztmzmbECvHfZXkjR0XsgLFI8ILnD6UsXEpJysDa82LSgEQHxw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(261026121527099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261026140227099003)(261102123227099003)(261009223027099003)(261022105027099003)(261028144727099003)(10067099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QVxy8wU7ug5wurgF7tNMCv9egulpXUfQUhcTZIZbr431hh6XIwqKMmAuJU+Rc+LtkbVuCST3Q6L9ixWyxmGB/Q4jeg6sDQKJ3DOAIfBjWuDwmFwDUWFp4LGn0ycfNbQ+GHF7zWXptFJ77noI9A+3/m3fhtOtIHjm1vgsn1OYYj5pO2nYDBxXKRpKoNYohqQIyNnDiLbnV+0uH9d9XON+j4oCf6rQ6ouNs+XgiPCKhOGqMIlqtajanLQCm9SS4kKpnZPtHPoUYW9Lr0k4Q6w581ORYfY+toEEzOSfKljUs+HTaQIqYeUOolhUO/TNE/4vmrQc7uW4PsuOBUJzg1pKN7ddZ0nfFUisYMQtcLpmYC2g6bIZqbpAsFCYEBRqOkq4aH2b0HnvuauQxKkbQC4ndDATzS5sGJ4mIjH49UE7TFFGEigjWGPIfjOZzKCwizes
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:16:27.4011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db049bf9-4af5-4a64-5ae1-08df3af38fe1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469

Two of the handlers race their teardown. amd_iommu_report_page_fault()
reads dev_data->domain with no lock, while detach_device() clears and
frees that domain under dev_data->mutex. The GA log notifier is loaded
twice outside an RCU read-side section, so synchronize_rcu() on
unregister does not cover the call.

The I/O page-fault case also returns before the event slot is zeroed,
so the entry is decoded again. Print the raw event before decoding it,
so fields the decoder does not know about stay visible.

Full series including other cleanup is available at :
  https://github.com/AMDESE/linux-iommu/tree/iommu_code_audit_7.4_v1


Vasant Hegde (4):
  iommu/amd: Clear the event log entry after reporting an I/O page fault
  iommu/amd: Hold the device mutex across a page-fault report
  iommu/amd: Call the GA log notifier inside an RCU read section
  iommu/amd: Log raw event log

 drivers/iommu/amd/iommu.c | 56 ++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 19 deletions(-)

-- 
2.31.1

