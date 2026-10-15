Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011048.outbound.protection.outlook.com [40.107.130.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5436F480DC4
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 10:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.48
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059360; cv=fail; b=IG+B3oLOrDWW3Ks5JURjX5ax0Eh7/EHM7evo6VbWX3tsw9Ri6LQ9vms0+jvCncwuX9I2VI0LgLJrw2EAxG1dvSohngojLEmvmSLsvh3DE6xJDqPjbRIa/JDkhn5+BGnhLdub6bUDOtpDuAnE2J23zE7CnB08t3q8owQ6j0Q31Ds=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059360; c=relaxed/simple;
	bh=5eHoKUpuTm6WjQj963CEewZZN8h7BnwAUXWfV9HbU5U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WE844PXAG5mCbWQ1ewWjGOrQu5/6huJZj4OvbwrtYJR9RWEj7xOxnt5Zg5v68UrN3iC40KtORDSfKfoDp958uDExk7mQlT5nL4CGWjczSk1RSDo4dB2YH/auJW8UnZTRbYUhKpcec+IEw6n72I6WFsUFyRFwSsttEgm0hQUmIzU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fW1K7pZH; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fW1K7pZH; arc=fail smtp.client-ip=40.107.130.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fW1K7pZH";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fW1K7pZH"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=q9m8mZa02x9K2MgCHtM7O25zh09dZIXi+cN6tDBvbCyUCzwqXUAmuOm4ZSoqSCLtFp3OxGyWIE9862ZcNw1pkVZGqdfDwCvogmfSYo9bn7JWmqyUCb28zIvyD6xdmxetv0MAINpXnPJqhAxuVHqer/93UWqQPFuk7nI3E/Z+ICaDhU8BH9jgiQS1Y/CVPLqIcFJ8M4Nkwgu/mUId504Up7FdxC/lF4V1dyt8u+HUBUtUbhh328p6V+kaOgthGs6i3wlJEt+RkBsygYP4dhQDJ5IMQhR5fXl/l08K/8djCPL7AlqW3qZd2bh/yY8QsT0zrmfMSqNH9MP68efPOtBBag==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OadGGHs6xbkUickxRswuYqGNcMPb0f58g4tB1SefJXo=;
 b=e5kwDv6e7eGPG+ruZOeWb6amZJkcZSUfsstbzoQPGjPHnjMNtCSB3ff5Z5jZr1CfoO8j3xBNIcJGbJRer1UpaAZ0IY56OFMKG15rbZQx+0Xolhxa0FQBp2QoKfkgh259KFOTbc4l/McEHi8sWR/RfHGg5f76kO83She+T22ZlDjrL68ZTtVVkj/ZP4SIjnZWjTQkRYylIz4kmudJpO6rLWw8tcKpH20Sge1FnodYsfP+eEMfCHjH/PmsjMSDvtYGV2WZl8Y+rTS3Nmf5GNyJ8qQ5nGD+PBMrDWbxC6Bc7AFUraWsxkz6JMbrAEjCHNbshn4aZfGmBLlzLQdn8yGqqQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=qti.qualcomm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OadGGHs6xbkUickxRswuYqGNcMPb0f58g4tB1SefJXo=;
 b=fW1K7pZHEADdFWP1HAT5nCYr5IHk9gx7527rsuYCY0+BA7LTtmz1ooP4usr/PupI4iYxCVqTCb/n3volaGWzFRvU1K5gcQUIGINXD3zTDSCsKnOQx8xjfcmQtBEldeVrlgeOBvvfiiomHvrLe8Eo4xtQwkeZZ1sfA7/wA5i9a+E=
Received: from DUZPR01CA0087.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::18) by AS2PR08MB9617.eurprd08.prod.outlook.com
 (2603:10a6:20b:60a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.9; Thu, 15 Oct
 2026 10:15:47 +0000
Received: from DU2PEPF00028CFC.eurprd03.prod.outlook.com
 (2603:10a6:10:46a:cafe::18) by DUZPR01CA0087.outlook.office365.com
 (2603:10a6:10:46a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Thu,
 15 Oct 2026 10:15:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028CFC.mail.protection.outlook.com (10.167.242.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Thu, 15 Oct 2026 10:15:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFD/q5p5PFT1qpOBBdLwiAtGcwDQxtvi2cgTKmHKp/MQyZxDYzXXCY+9pMaQQFMwPZ3NfCtzNwxUwMu/JWH0ZjVTuYyN1OXprmhjAK/+MZFkr+5Ub0WbdpyWYKgjowe2w9GUehz4IrMkahzOhMmN+cHZ9B0IAUXhji4xgFJNREvN4/L14e+IT1EMR0EVOa3QvbgUzspbJZGBiiQUiqi4+X+9Syru68B0DSTSPdTc2vOx6nc0L7Ryj/g1LgTXBJIDF0is+sY7im5jub28bPdCgraOY7SGv6I+DCBqirClWZXcsEeJSBwTY9K4Ym7COOo3+YmFvlIMTKbpLdPwGH/lAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OadGGHs6xbkUickxRswuYqGNcMPb0f58g4tB1SefJXo=;
 b=C1OMpP3K/DjXXQK40z67jAjC0R8ozqdmZhepxGZ0BC8WwC9K9T39xU96MOMIcpCO5iKUeW+J2brRlenvR63f8EHy4v3e8G+UpZ1h73poiLQ8mv+JZtKSbdb/yQTTrjvusAo+jYvQQbK2J0tezOCGx+2XjU5qaD7t9LTDhVpoIl84bD6zvgbe68rgUPW4sGW28LcFZgThNQzMQgCEKJZ9c5Rg1ylrV1Oeat5zOZgPCzPbdC3tnjlLPR8H8GkzJM6HrVYkBJrhMDB4nSWid3MNOZhAAb2ThdgsbNaVIZBtuIEaLRad4LQXPZugTCzZYMJ/gMiwehuzVrJEj3ex8/poGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OadGGHs6xbkUickxRswuYqGNcMPb0f58g4tB1SefJXo=;
 b=fW1K7pZHEADdFWP1HAT5nCYr5IHk9gx7527rsuYCY0+BA7LTtmz1ooP4usr/PupI4iYxCVqTCb/n3volaGWzFRvU1K5gcQUIGINXD3zTDSCsKnOQx8xjfcmQtBEldeVrlgeOBvvfiiomHvrLe8Eo4xtQwkeZZ1sfA7/wA5i9a+E=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10691.eurprd08.prod.outlook.com
 (2603:10a6:150:162::11) by VI1PR08MB5456.eurprd08.prod.outlook.com
 (2603:10a6:803:12d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Thu, 15 Oct
 2026 10:15:14 +0000
Received: from GV1PR08MB10691.eurprd08.prod.outlook.com
 ([fe80::dd4e:5d51:17f9:9375]) by GV1PR08MB10691.eurprd08.prod.outlook.com
 ([fe80::dd4e:5d51:17f9:9375%4]) with mapi id 15.21.0546.006; Thu, 15 Oct 2026
 10:15:14 +0000
Message-ID: <9c1a9f93-ab19-49be-b17a-40d3f0e54c06@arm.com>
Date: Thu, 15 Oct 2026 11:15:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Support for ARM ECMDQs
To: Sukadev Bhattiprolu <sukadev@qti.qualcomm.com>,
 "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
Cc: "tanmay@marvell.com" <tanmay@marvell.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Patrick Daly <pdaly@quicinc.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <as+Mh1Ah3FFpCZlK@hu-sukadev-lv.qualcomm.com>
 <30683c6f-08d5-47a9-ba0d-24622c3a54bc@arm.com>
 <IA1PR02MB897091EDACBBFA6063EE1F8AA49D2@IA1PR02MB8970.namprd02.prod.outlook.com>
Content-Language: en-US
From: John Garry <john.garry@arm.com>
In-Reply-To: <IA1PR02MB897091EDACBBFA6063EE1F8AA49D2@IA1PR02MB8970.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0389.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::16) To GV1PR08MB10691.eurprd08.prod.outlook.com
 (2603:10a6:150:162::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10691:EE_|VI1PR08MB5456:EE_|DU2PEPF00028CFC:EE_|AS2PR08MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe51461-a2fc-479b-d09f-08df2aa54785
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|10067099003|18002099003|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info-Original:
 hW9yWSv2lujNN5P6ZV0uo1HzTWnPPO6bjHWCoBVXotuSONpvmoKns8Jb5CpKO7zNlSLnuhhfgGcWY9lPEXqFbYwnm9Npm8yA01wTtMW5ANKjimQ42kArlDx4x/rXZvRUrTUyw/EpnRNFdmoLexJ92KLrTeMQLRqLNCxWcI5MUkbj39S09wVBpK1S7293bNQWDE1MzE5ZX4koSRrmMR962QJW15iXLCRmsZkSC9RoWqyAtFXr3RsaWCdD3/uqEyWUVmf96wq7wak2IU6iDx+SvxvSyKWk0or7mhTfxyD61s2z6NM/1/VEdQWixF2vePbIH33X4/yN9PFwJ6JfPTQKRT+5U2Q6WACRQv87LSV6fBv9j46yNJ0UBQNwqxEq8vOIlkamggsrj4Ly2jfXKOy+DEy9yHr+1SwHBEfrLX/Onn8cyLOhkua2U0QfrX24ge5IuZUEykA6KI1RVmLsJMQCxhmEQ6UE+7aEp6Xys1wPnpPQnwJy/MWE49Ub0IxrJMRxWokdifsb0+WXI01+Zf8fdKj1fj3/AZsx09YJ1SSg5XENEgTv9h/oCWcfP5acO3o5cdXikyoHL5oT92Li0FTsWxFp/lPtsxKxZ0KApDApmxGMOFpH+7liPciDU4AUadyt/KE9LH2XrxeonwIK2fiatlQp0NZEkPQl6N1wEJocgg4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10691.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(10067099003)(18002099003)(11063799006)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 1PAynf4g9/odCLcIRfL7hS7limJeyUMTAIgBnFR0+1kj8EOwhLadu2MpEFKxZhRAaOntWQewmuWA8xhrdMdUThW5VNdbNBaMaijsSDepRrn3Bx9AYFRvW+q4/QVYOijV4aZOvpyhcXsjvCjtOsGc55tr78PlaRTyT4Mm1QcWmV7gdbaIL/ScAUVasHAMLJHueGZ4gN74dSc9SrcqATyBLZJFiowYZzg7Qn7xfPTtyOnUtRfkMU1uKqn19AbGC4N3stYKYC5S65Hp4YKepRRcAmsamYQkDVIQM07bOmdBE62yt0womAtshgX3ir+ove3o84PvdrmZ5KMPNcF+DpiX+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5456
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	375b3dab-9e6f-4cc0-d8d3-08df2aa53417
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|23010399003|1800799024|376014|35042699022|36860700016|22082099003|18002099003|10067099003|13003099007|11063799006|4143699003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	6muYeFjkSRVBv7dczyV0BuweFdrokcnDe8IlvEDUcTBl6OONEUKRRxrJ3MmzG7DPilM5/dAq9wwi9r1sksWwFl/S6EK6IVxM1aBJtbEWhCHm43kM7FH1CxF1WpTnB/oigQod1G7sbCOPCyq03QEwGfd8hzZ/65L+sCysELGNm2BAd0fhMtPgomExJSMRIviTZydWWeWhNK/uddOyHujhFMV3FKE5XxHUlHpnnlFymYEddxFfWlGjqJZMCeNDgxCOPdzH2FuJbiYGYBK2MWu24fuEyFz5Pd6R3PtR1vDtNwe5IziEoqOU0xdV6xyfu2SQUD9y0d3oEkLs2Gx0D00K0To1CRdr+9IAwbeE79p2NWakjwQcXYTc/llPDF3CaaigxO6ugrIYURttpE2oDkz9A1qLwURRi6PKbLS449juX5Ysu5hm4uM+zXhRGFy2SsQR+utlK/0VUpBwTNXnIpgHcxlUJmTqGjkOvOrGtVdbyShQSQEj5WA/gf9Ud02GJ1H6H+7enctOUTBHluVf+K3nLt/zb5Il0HQwCRHebdt+Yb0p9GxEm0BvgqM0yLZVbWRf3FsGkJUs1srVF08z3n6rxAvlQw5tx2f0r+Zyggifohe5P34cy6C6DQyPAj3zW97FiRgPLuOloS2uN7tE+dsi+Dxq3DBSkJQRVT6kcLGhJhYdxhp+FLcB4+uzV4q52XP5DKXfsYlBgFQT+CJOhBuhJw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(23010399003)(1800799024)(376014)(35042699022)(36860700016)(22082099003)(18002099003)(10067099003)(13003099007)(11063799006)(4143699003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xe9hviLZsel8IAJQbSfbf/3bl9dwI0Xg30nPg8OOkcLwvLqjzj91990OsGKryeGEE9juOyaZ6ALLzVfyBxN+admXfZKHv/yBS+VtUYEb93olA8u9eNLZCUFZFaaqu3yf2ySrNmi0aLbXHtCqJz8+HK+swzza0yQi6abw0zuxH07otIf3Cq8nMWI9AOJWODlVpYnMAaqYUPqL2ejku9yRQdX4XJcVCIu2dt9zPqSP+AYzHCaK66fmXV1OyGKQssy0nTaVPftSFoPVYEYbxL2ooGUWS4TNveNj1GjS+gNXfdEBWNs3fBu36Np16+TrZD7YwnPrh+HcdODA1nYWgBTrRMY1S5GPAG5oUC8bgjEkEvpvY/+cU5bD4BdamCgo3RbF7/CxCxf9sXAjYCUXele/oxIbV6wqgUNFWWb0sHpwUev1qif46erYcB4OHybSgFSE
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:15:46.6670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe51461-a2fc-479b-d09f-08df2aa54785
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9617

On 10/14/26 20:26, Sukadev Bhattiprolu wrote:
>>> Thanks,
>>> Sukadev
>>>
>>> [1]https://lkml.indiana.edu/hypermail/linux/kernel/2404.3/07988.html
>> As you can see in that thread, the maintainers wanted to see results from real-world workloads (which never appeared).
>> And I think that the preemption disabling scheme in that series can be improved (dropped).
> Any recommendations on the design - is the approach in this patch set such as associating a set of queues with arm_smmu_device the preferred ? Or try to adopt to the cmdv interface?

I don't really know what you are asking, so I will make two points:

I'd be inclined to spread the cmdqs over all CPUs (for number of #CPUs > 
#queues) - that v3 just disables ecmdq for this case.

The current implementation handles using the same queue per cmd batch 
(which would deal with preemption issue).
