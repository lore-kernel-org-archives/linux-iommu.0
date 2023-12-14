Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2073.outbound.protection.outlook.com [40.107.215.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754A8171A8
	for <iommu@lists.linux.dev>; Thu, 14 Dec 2023 08:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K15a0RTavsqlua2/4kanfD/y9piHbmUokSb64YBbhVyJ6wyRytoApEufheRDj/VjXtfMfg05eHqUsyL2q1xMhpey4/kBJTJcC+q+j64MdjJwt23i+CKOC9q4I9IOAftVkVf79HyGrN9IBy03HL67lMvmN0yBjQP3t6kLJ2gXEV6IX/ibQxccrsjRPT52yr3LMdqhC8SuXdYDzMGjfy9Lozs8ggcZ0Smyt+wh00YnYulAZuzQLhsos4cyQHlSFVueiRxHVl/dLPLYMBIH7PnK0iSGg1+5LzNpAlvAEREftffDX9R7YODRiqCipxOiFpgc+USoA/96Rm+kumNeyuZF6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHc5VSPrWAPulDYslQb+keGbRzaONhpdX6ViJQ8Z2zQ=;
 b=ajQYNPYcDmsKk48M2w1JBcGHHSUaVVQXGKOOqqZd85SB0LHVwWx4+ExEabVOhgPnK4wJ70Y46dsq2jlyYKY3IRnDBOHiHws0orqsY0zTCkMT2YavOOU26zghMuVry/y5Ad/W/FWFRIGofTElqsZMvYMcJNVt6+BGPlY5J/ZnJ2dFlETMuSAu9pMVV7fZjhidyU9J0SZjuJ4Sad864IF42VhRMJDzbL3+/I9gS7LyTw9r67xFV85CrNFbgWgla5hmtm0gtz8zGU1OhtIWK4yd51h2srhcZSufkJ7fF4vxxEWh/flJ64kqZuEVmyb2TM/aMzCGwkrm+o4QDCNURsQkQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TY0PR06MB5259.apcprd06.prod.outlook.com (2603:1096:400:206::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 08:25:48 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::2625:d246:abd7:4a7a]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::2625:d246:abd7:4a7a%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 08:25:48 +0000
From: joakim.zhang@cixtech.com
To: hch@lst.de,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	Joakim Zhang <joakim.zhang@cixtech.com>
Subject: [PATCH V2] dma-mapping: Set dma_mem pointer as NULL after it's freed
Date: Thu, 14 Dec 2023 16:25:26 +0800
Message-Id: <20231214082526.1212264-1-joakim.zhang@cixtech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TY0PR06MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: df46f8e3-2b5e-4adc-653a-08dbfc7e463c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1O7hU6fHisYz5U8C2ukTT/yUW6oOpWmipKURzlAk7K+tzTrMwty9ILrQClLhhrL8XTGvP3DbTxDHDkrvBPiNTNnJqK7Vvooq+k1XWABMhqY5fhLA+Jy1XKuDyq7zCreykn8SHc5wukejQLetsJuFCRoZspl8WHzn73RTR4g9SJSm1fQE8bgs9zGkD6pRQgdjwreoaGswDocaITYA86oXB9KadiRXTpupG3pIZ7TXX9uDfPkIG1Aobhxtna6RC+O3w3lwkWVVc8hfhaEK+QaXY9Um0k2VD3Rd9Zsk7psuIEq+9stYY/Egu5frxJKYtYej5aohv8B2f7j6R4hygImQMd+Fi3R2tJjWVVnF8ObbDqdO8WlhH64gelIwK3I0lBlxEt7tBZo2OPyxB8YkxM5dHRvU1yDTlUJ4y+3eeAyL7/88FwuQVXk5TkZD0Q4HzD+fEXT/FVCyFWkkEtguZqQ9LVaxjsyBsCgFbQcM1wR1fR77Vd1Ik8vzzlGDMpx1lQ1xt6lNzUyJbmAecPNmu349YdWkilVxNQBPLKt2k/WKXQ1kVnakxCNoFvZgve+JGPFlc///aIHFdMHmqZJyDBN5/svUOQ/+MYgi+ON+gq+cWne1FzLrBzkRTl4kf9h0nxVM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39840400004)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(478600001)(6486002)(2906002)(9686003)(6506007)(6512007)(6666004)(52116002)(8676002)(8936002)(5660300002)(4326008)(36756003)(316002)(66476007)(66556008)(66946007)(38350700005)(83380400001)(41300700001)(38100700002)(66574015)(2616005)(107886003)(1076003)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7lkYslOXa5qb1k4ZfV9TMHKnZSUodpT2aH54TVyXk0M3B8kidWECiPNY9uIb?=
 =?us-ascii?Q?S1MqfmizJNVui5J/baEyS1s3yF51WVGXQHwno7P8IchCpYwI0CKXbbTUA8un?=
 =?us-ascii?Q?AR81h6ExTMm1By0BwYBV0fgoxQ7yKKQJeKcNphf2uf7Gd0s7vrfSvwonNst5?=
 =?us-ascii?Q?+lf9Z9HeBC5Lgta12QHg0Rk67k0zhy4vd6Vsn2ed+cc6hm06sQDREBnjqnV8?=
 =?us-ascii?Q?imkoItA1bver5k2naBbhRwTVEuyVXR68AKJlWYQufJCQ8ybZnyA7fxC5stY7?=
 =?us-ascii?Q?1pLVohpL2j3BGqr4BVaZK66Q5wZt55yfzadYiSJnDP0TjuFxlv0Xv9EC0Tx8?=
 =?us-ascii?Q?xRuxhWM92K6kQLoI8mEn4+PTzYoMpMFO2XP35KYTXgkU9M8VBLPF05QVdyJb?=
 =?us-ascii?Q?ii6XduKpIZhNuxSh5PUsrXk3IdYz5MNDpTZnD0cXISXc405Q+3mRfdM882a0?=
 =?us-ascii?Q?eO4PSGt2Wsb9hx4o6aXN7URjRyd+hE4+/7gTWii4kJ2XROY4Mzsohvg3I9uq?=
 =?us-ascii?Q?ICUN7s1Jx/mC8O73CMYYnV/l44MSwbyGI3vPUEihShiA3SGIq1lE4WhCa+ib?=
 =?us-ascii?Q?ohMnOMNuK1r0RILwoDgdqgxX7OPcmis4OotjEdNDx85wHLdu3wGRRw0DqWc7?=
 =?us-ascii?Q?83L72xWcFa81cMKTXnKEGlKsi1VsAXhcTZWWhS9AGKK5fzjWIndeaQatAOCD?=
 =?us-ascii?Q?C1LTS+nYxbSXrRpMWpPlSINe+4BaufXXk/UwMQZaQjgNhPNpr5yX7R+fNJLu?=
 =?us-ascii?Q?LLIAw3TnrGbdCFyW3iih7VWybR83yPDlTTTLqBgEnKX4i6vNuCtgVhnkdkN4?=
 =?us-ascii?Q?6WnnhMsE4HXOTC+xnr8tk8MqJaD9uNcQQ83Lp3id4z3gBH2UzxcXcoDDvdBz?=
 =?us-ascii?Q?uUktslENe76KKWKNjpM5Xkwx2FDsrHGfYgAMEWME2J/L3XAq+bhgai93v2Qv?=
 =?us-ascii?Q?nxeNja1dU/hLJ7WhJAkOo7KHiBmp4/B0bav1ab0XBhvaWoMtUyZSxw2K5N0x?=
 =?us-ascii?Q?Z5DFg1Od430y9jNIPSEvGylUTJr7nc9HLvWTnlAIW6z/ZuqhE3R/VHqpL0M+?=
 =?us-ascii?Q?zr3ylknsa5Panqe7/ctrrVB1rJRUlvtaE/Jv1I3WW3Y8VRGnMbQTXpUnnd7F?=
 =?us-ascii?Q?vPzYpPW3Hah/lrH4xz0xf52CPwmC3o7Mu47qQZGUYdq5LQl1WRZooovLvxFo?=
 =?us-ascii?Q?IAy6ytWU1LWeMz4/AFKRZhKrOcj0OvYFLp8x5gNa/8MLb6ErEDm7kw9n0uJ7?=
 =?us-ascii?Q?PWfabOMOghSuZwNfk1/a60+6JnGjgMGwweP+9MswVaM0Leq/+mItmXdtfdXO?=
 =?us-ascii?Q?/YOqbewDUD6UqvzFxEZ9WWf7bYiETArzfA35GT6P23GAkwCm6ZoZCnqxKhSh?=
 =?us-ascii?Q?I5KuLgzA+1uqZ0Edc6Hia+DcFGG5eM/LVU6oG9HVXO8PlxU9WLcajR6d/Teo?=
 =?us-ascii?Q?meum7o/rsSQPSp0cJ9X4xa4PVpDvnvWnOoicSVzGTAz9eDxGEbtrq6ptHVNC?=
 =?us-ascii?Q?xuPpzMZvgJyu1YiCMFy3aEOVPuAlVDgYikdBhYVQLm78lCw9jsA+doN3/LPv?=
 =?us-ascii?Q?b4W5jSP16xWpxtjrOoy5HxDFS11vlkFmxmBKPiA6CikDqaApf6Zo2/jf6n3p?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df46f8e3-2b5e-4adc-653a-08dbfc7e463c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 08:25:48.0272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITBZyr+rAZFRbFeshYno2iuqfZ1aEA/FoxlffC2L/UjGQ4bv/2HXvXy+ov0Cr0ZIjcPIbPJthBwoQOe9f09SZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5259

From: Joakim Zhang <joakim.zhang@cixtech.com>

Reproduced with below sequence:
dma_declare_coherent_memory()->dma_release_coherent_memory()
->dma_declare_coherent_memory()->"return -EBUSY" error

It will return -EBUSY from the dma_assign_coherent_memory()
in dma_declare_coherent_memory(), the reason is that dev->dma_mem
pointer has not been set to NULL after it's freed.

Fixes: cf65a0f6f6ff ("dma-mapping: move all DMA mapping code to kernel/dma"=
)
Signed-off-by: Joakim Zhang <joakim.zhang@cixtech.com>
---
ChangeLogs:
V1->V2:
        * remove _dma_release_coherent_memory() from
        rmem_dma_device_release()
        * update commit message
---
 kernel/dma/coherent.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index c21abc77c53e..ff5683a57f77 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -132,8 +132,10 @@ int dma_declare_coherent_memory(struct device *dev, ph=
ys_addr_t phys_addr,

 void dma_release_coherent_memory(struct device *dev)
 {
-       if (dev)
+       if (dev) {
                _dma_release_coherent_memory(dev->dma_mem);
+               dev->dma_mem =3D NULL;
+       }
 }

 static void *__dma_alloc_from_coherent(struct device *dev,
--
2.25.1



This email (including its attachments) is intended only for the person or e=
ntity to which it is addressed and may contain information that is privileg=
ed, confidential or otherwise protected from disclosure. Unauthorized use, =
dissemination, distribution or copying of this email or the information her=
ein or taking any action in reliance on the contents of this email or the i=
nformation herein, by anyone other than the intended recipient, or an emplo=
yee or agent responsible for delivering the message to the intended recipie=
nt, is strictly prohibited. If you are not the intended recipient, please d=
o not read, copy, use or disclose any part of this e-mail to others. Please=
 notify the sender immediately and permanently delete this e-mail and any a=
ttachments if you received it in error. Internet communications cannot be g=
uaranteed to be timely, secure, error-free or virus-free. The sender does n=
ot accept liability for any errors or omissions.
