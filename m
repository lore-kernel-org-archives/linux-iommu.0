Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73B715ACC
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="SlnI7C71";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="SlnI7C71"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Ne6gsva7ICUxeCex2UBHSzoLuUCRrnJMytXeGhjy2s5y04t4bFs3DP3x8l7UW2okUyiuze87Sy4iRoXMsq1iP6hWew6jF/P/ofuxZF75bPUGSlTi2Y6KuTQrgDbqwp51ZovCDdmzdtxA5LhPYLuZlSgnGg8KqfcZjo+CqwP/S/IbRCeMNXxCGxxq9/VixMt+LVTaPSZDQ2SnrxqGgYCXOT5H4E8cNtCTWzXkcMIbVQB+FYowTK8sVPzH/8gooOZQntIESR9U4SHI7K6xCV+6G5f/AY25/wYhU8zxhv1m5ivvacpe/hFUaiDHICdXjDkIo4A2E61ZJGW+vVnDG9MQ+Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6Nf8DQvbtM6AjNiKhuLU6kQW6Z80j3H6FDMmaPYuiE=;
 b=L+T3nYesQgA9c8I4r+oIA2fk5UW0TLQdqGeRsWJJOWoXq6mfVQVgAAnl94CujW2JfFbr8Q8LVub9jyPo+HV64qj2OOuqO9Ii0A2ZKtX63kRjREUkP9zScUFocF040lKMcPzlEO2lLyjCCF2vt8P3A6tjonmcMMOGKtRIBv/qan61Hdyt0MdZ56YD+pZkK/aIFicvr3O2Ghl1vaw2HfczXT3/Tvr/a/P04cLmjrFEiivAVfQB8QN/0p7B6MDJu35fL6Fhoo9QN5TqzE2tLHK258JpIc9yq5VjYV2oQq/mUKA7TOkEnZTUWtFs1viD6GjcOzm7S91b9DSPu1HV3LLnNQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6Nf8DQvbtM6AjNiKhuLU6kQW6Z80j3H6FDMmaPYuiE=;
 b=SlnI7C71gCYW7BkvB9BG9XVmXRUhhWC/0abRSx72g2j9UaCJFsL+xzRNUlZZ6CZGGWf5jt5QSW/IpC67B9oYIrMaz+cxleZObQkGF2/jmgcuIW2SJAm6QrgnU8B/2RCD7PiFXx7lvGpsLkL9TR7W88ZcNLfDiJG+ANNbxif4c7Q=
Received: from AM5PR1001CA0051.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::28) by DB5PR08MB10189.eurprd08.prod.outlook.com
 (2603:10a6:10:4a4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 09:11:27 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:206:15:cafe::cb) by AM5PR1001CA0051.outlook.office365.com
 (2603:10a6:206:15::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28 via Frontend
 Transport; Mon, 6 Nov 2023 09:11:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Mon, 6 Nov 2023 09:11:26 +0000
Received: ("Tessian outbound 20615a7e7970:v228"); Mon, 06 Nov 2023 09:11:26 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2fd4e6ce7bdd9698
X-CR-MTA-TID: 64aa7808
Received: from e72ed4ec88e9.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id FE551C90-730A-4C5F-9B10-C5B9F18E7677.1;
	Mon, 06 Nov 2023 09:11:20 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e72ed4ec88e9.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 06 Nov 2023 09:11:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfWyu7c0Lc9flCJ/mwFziAU0yo91yN6Ay0WMifexdHQh7jwufugedM81oAs0xaSYfSDFJul47EPu9xoorW+Puvg7t0YIN5dMpgDvUoNCLxGzGGskjEvrb3VoLHDpg+9A8sheAmPNJaaeh2/QqR+ni9CFYPQHlUborDW/UrQcQhEnEFAFsQNzWzGfFhCj5iHwhJWRhijt6nVA+ghFR4fapie41r0PfZNn4Lj5ZzYwN4+CpsT5eKsZJvrb9jThuZ2llCckkmB8HP6r0JfOc8mszQveiWPY9MBAcCn8dDMjtBTTuFVe0NM8EjA7HWxBMKCf2oyQPW5RXNPxvumPAnGgiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6Nf8DQvbtM6AjNiKhuLU6kQW6Z80j3H6FDMmaPYuiE=;
 b=DqzdJHeacnB4RGkTbqjQOV7IJ4m8mwOriwF46Qvkx0M0MxOc9q5hzO+N4jtmx70wrSknVVKSk5C6xAbgx/jZX6SyYtWCnr3OQdQBM0N4zORnBGGeicBsFTAfRo2KxpOzvzdxOF9AxiacyWDnKCiUe+BARNtOgqjpw/O6VNJwH+vQYRJAXzjbx3Ai6s+kU1cwlppOPuJr264EOt+g+1aLu7xQSZsk3F+ev8TlfIwJ1Z0nuQkoKARSgTRKbvMytWcEB42myGzV5zm2di2rpBWlabUeB47vvwN6QOlh1NgDWR5jXQGtee4ZatF8jMfyQ8iWDwLxgmCZYBF01oHofz0RBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6Nf8DQvbtM6AjNiKhuLU6kQW6Z80j3H6FDMmaPYuiE=;
 b=SlnI7C71gCYW7BkvB9BG9XVmXRUhhWC/0abRSx72g2j9UaCJFsL+xzRNUlZZ6CZGGWf5jt5QSW/IpC67B9oYIrMaz+cxleZObQkGF2/jmgcuIW2SJAm6QrgnU8B/2RCD7PiFXx7lvGpsLkL9TR7W88ZcNLfDiJG+ANNbxif4c7Q=
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com (2603:10a6:10:d2::15)
 by PAWPR08MB8838.eurprd08.prod.outlook.com (2603:10a6:102:337::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 09:11:18 +0000
Received: from DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::1dde:912e:5599:2729]) by DBBPR08MB4538.eurprd08.prod.outlook.com
 ([fe80::1dde:912e:5599:2729%4]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 09:11:17 +0000
From: Justin He <Justin.He@arm.com>
To: Christoph Hellwig <hch@lst.de>
CC: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<Robin.Murphy@arm.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, nd
	<nd@arm.com>
Subject: RE: [PATCH v4 0/2] fix dma_addressing_limited() if dma_range_map
Thread-Topic: [PATCH v4 0/2] fix dma_addressing_limited() if dma_range_map
Thread-Index: AQHaCYh/HkxQHzgqYkq+Nqv+9m8GdrBs9PgAgAAaQoA=
Date: Mon, 6 Nov 2023 09:11:17 +0000
Message-ID:
 <DBBPR08MB4538F0C2E53B4EEE86582A1DF7AAA@DBBPR08MB4538.eurprd08.prod.outlook.com>
References: <20231028102059.66891-1-justin.he@arm.com>
 <20231106073656.GA17712@lst.de>
In-Reply-To: <20231106073656.GA17712@lst.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	DBBPR08MB4538:EE_|PAWPR08MB8838:EE_|AMS0EPF000001A5:EE_|DB5PR08MB10189:EE_
X-MS-Office365-Filtering-Correlation-Id: 62abb1f3-6a1c-43dc-f26d-08dbdea85b1c
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 Hpaqwg/xtdYdGQtI1MDP2bN6kaVAsEVS+Yp6i+OM9kaAWQjdzGq4tyIoydZ4yTRjRXAlI8Rp1iZ9VRIktP1wd1SPw8WdG5C7jiUvwjsOip8e6Yu3Zl3Lw5Qc/XnIrSgvRS/em7EHfyNCXIyUeklAIVUx9dvsWCloCIFWfe4NvdGTR7yG3QZFWJzNhvfevuyp1HW/IywHqeRwlikmNoDLHOuKquLI4/XIVKewH2g+3J9y4NySMsuCCe/ecbgIpH1mpiOhhsZ9GWxcDd8dDGUbTMFYFuihgIOn79T+3rjybhdyaP7wUwoLfIgM8SBUQv6M586l0+HFznwJ8o1EH+OldJ7DrM3B0e+kDAuIL6tn4GVb5bADo2UySLtU5fE9zoS8CfCrJATKzd6pIyi/6tQU43WnxAB46jL+HFToZs+nDqftdt7+gCrxCsvXMDCyiRFGtvbqllH1dGYNuF/BWdTsZdWtuMkLlKDTkETpJx73eXAdxmsTwqHdOTVHSR2I/EhzR0XPknRMPVnE7z/1zBovC0qFNmkRKhenS2/+ncq9QRrRPcfX8kT6+jhW9GQtoVOcGB1vwunJhtelz1qBEVmtoaOfezT/mPLAWT1pajPF4jqblju28lEMPu8h30xQyPXD
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4538.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(83380400001)(9686003)(66946007)(76116006)(26005)(478600001)(7696005)(55016003)(6506007)(71200400001)(52536014)(8936002)(8676002)(4326008)(66556008)(66446008)(64756008)(54906003)(66476007)(316002)(6916009)(5660300002)(41300700001)(38100700002)(122000001)(86362001)(2906002)(38070700009)(33656002)(558084003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8838
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b06cba9c-5c3e-4ac8-75de-08dbdea855d5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3JTHqtrp4wZXgkFZcXsZhqeN8bFNvqYAZKhfac6lhRg6vTcWaAA0tCr4xkedmLmv3MP0X5MXNt4LspigAmsfgJYgcJ3Jj3t6bw6XEGOzOxDxpWQQB7hKqXG5mSXVXjtgLdBAcfRc1so51qxEeNBSfoj1rSTbeWb6vdYVPjfVMRP75wSHDxcLo3/xlg3U+EnJBMFGdGZGMqSCpbHrjpM/+CvY61GjiRTp6afnqYx31MN7doxmtFGP3xCvIp7BODO0I0rT6cMuOqwVFo/xyOp++Y4MwFBvqyS7T/eVyc2WRKvPIiQo0CKujtNBYOasbWRMSsQ923KZ9qI1ovOeQQz4tbjuckRuC9MutnBABlxZ70Zdj7mCHHp3CkvsvSJu+sgdDUKo3BGt5f/mcHT+RFl8jlxhStzPXrWS7C68R3wxYLaJLfZVEQ99JHwvqE08StBxFNLegQpGp6JwOAceyrkDkETfQvt7OddbsGHoL9P5JiEiU3PbAAZ0ObNtw7xjYEAGY8iyQxgyYKTHsmOE+RnJ9xpOy4btWRdth0UxU1X1LC6ZaYaZqC3s41Y/QYOAXPIEVcr4CZ50pUrmb5qDnPnM4QrZI/sktT+E+06+uBmwQsFzVlajDXiiekYinKAkFK8xPkw0DPgttev1E0pT7RQhDdLugXNDpTPM1t3qCnAwp6HZdXyMDtWcawO0hUNCDDx5xMc0If/as/nJARpMqF4eew==
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39850400004)(376002)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(46966006)(36840700001)(55016003)(40480700001)(9686003)(7696005)(6506007)(478600001)(36860700001)(33656002)(558084003)(82740400003)(356005)(81166007)(86362001)(70206006)(5660300002)(316002)(70586007)(41300700001)(336012)(47076005)(83380400001)(2906002)(26005)(8676002)(4326008)(6862004)(54906003)(8936002)(52536014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 09:11:26.7084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62abb1f3-6a1c-43dc-f26d-08dbdea85b1c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10189

SGkgQ2hyaXN0b3BoLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IFRoYW5rcywN
Cj4gDQo+IHRoaXMgbG9va3MgZ29vZCB0byBtZSwgYW5kIEkndmUgYXBwbGllZCB0aGlzIHdpdGgg
dHdvIHR3ZWFrcyB0byB0aGUgZG1hLWFwcGluZw0KPiB0cmVlLg0KVGhhbmtzIGEgbG90IGZvciB0
aGUgaGVscCDwn5iKDQo=
