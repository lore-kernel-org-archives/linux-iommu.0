Return-Path: <SRS0=Bvs7=NO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA783C4338F
	for <iommu@archiver.kernel.org>; Mon, 23 Aug 2021 10:47:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C016135F
	for <iommu@archiver.kernel.org>; Mon, 23 Aug 2021 10:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 72C016135F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31DFB60626;
	Mon, 23 Aug 2021 10:47:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PXZfP6q2iw-k; Mon, 23 Aug 2021 10:47:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1CD2E60613;
	Mon, 23 Aug 2021 10:47:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F038CC0010;
	Mon, 23 Aug 2021 10:47:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3818C000E
 for <iommu@lists.linux-foundation.org>; Mon, 23 Aug 2021 10:47:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E17740284
 for <iommu@lists.linux-foundation.org>; Mon, 23 Aug 2021 10:47:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="Ff1PGOk0";
 dkim=pass (2048-bit key) header.d=oracle.com header.b="nwheN9fj";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="crZ2vob1"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OnwA4UdwFhow for <iommu@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 10:47:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4E3B84025C
 for <iommu@lists.linux-foundation.org>; Mon, 23 Aug 2021 10:47:32 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17N8TLpW021813;
 Mon, 23 Aug 2021 10:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=jAWyKnStuSZVwMQ0rpMNgYdTk0O9QO6RQ3WQsvQNriw=;
 b=Ff1PGOk0viaTacyzvJIawxK+IzEWdhwX8KK+M1urxVmYVU62UuS9DZeLIDsR0n/FaEKn
 DE41WSfiRmdBkSANEGEEneE5YTrcVISDO3SM+Epkb9bvZA2n3Fj1FJiLMbZK7pYqsBSt
 4cD55pcp0E6+5GF9rdzyoBn1nY10hRZSCSmKkzzdrno+MUQfPM2Ek728Zfn9qFF4xX8f
 P9wCtMyC9slqHM4jhusjwURZfMdFFzXXrrcvFW48PoVnlDBVkx39r6ZXPOmMoN1qAR+2
 ml/V1GZhxKCekhXaGnEq+yXDvkeqErbSNcTyXoAwSMLTH9b7+aUGMS5dZ4D5mvPTRoF0 Xw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=jAWyKnStuSZVwMQ0rpMNgYdTk0O9QO6RQ3WQsvQNriw=;
 b=nwheN9fjyBiHhLv2tN8RMOlcL4223le/hUsTrVFK8Ehs6OzT+wOigtzSX7wEYuPLAlE6
 HtilE6vTTtptEtXK7dUF3VtJn6/1Rcn972swoTfrwDscSUTRkSwEfGP7wGYNvDgnI/Co
 joF62BHJ1SEdywcDB4Y0HEXFovB/Jf14JCl9FjWsx6GbNDzExpFOKdyWXE2PRTwd6Emv
 TODVLenAmGGttT9HHg/lBt9B0zdUC+jaqSBugiEyh3vKtv3tED+Hau/vnrVSDxI4r1el
 UqSlUKxLZyv247rnGdgxZdb4pCuvNfHMVFw41KYrlAPjIY2b2o+P+iNmcwSLXy1ULhA5 lw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3akwcf93jb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Aug 2021 10:47:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17NAjLQ7074130;
 Mon, 23 Aug 2021 10:47:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by userp3020.oracle.com with ESMTP id 3akb8sfabs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Aug 2021 10:47:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijx+aHHaxJ/fP4TljTLkKq2zbeLuwRqvVO7E4xQQDGyrLeU243w9IgUuSkLfRr/TRYDGTDvo9G9cO0w0yMj3DH0qROJFO/ATBYlUe4K+YJM/AGZM2999q4sqWNF63ZkHY02V5yJgxCxKebHC04Fx/1pMPdOrBOMK7tJ0DAN/lnJiHn5lmYmwXV/psJmpflsWPQDA4nMYFzR+MxOGW9PUoZ0BbgwVCUYM/UWBbPYRS0YYK4mE5WRTEJ2F2G+QO8Pvn0BBRzKAJ8QOqB7cuDnMFUM7kJ0gNpYERYwvDRPF3zCkxYu6fPp9aA942cvIjBNUQPfx1YWdB5OWxwItiLTT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAWyKnStuSZVwMQ0rpMNgYdTk0O9QO6RQ3WQsvQNriw=;
 b=jTzU5SOY9DJDP+7gMKbQ+htuv7VZ6PNCSQTLLkiekzzIinIZpy6nHJmUrMZ97ghW7TgC7HU/54kMO2H5PdEx6+69wqynkH9RzSWipnySu/aGvlJ6OQDdSu9o3h0CHDXCwns06pAPQQ0bYbWv5qp0C3X+ZzCeJGlQI22ZqDrx9AMiptVuSIDh+UlKLYZKLQi53oASezGwfzU4Wxp9HsmQV8JCIBvX2f4XrxICwwRXO/a0n5on5EyvNWqRucbwUpkE2eU4E8B72fhyXhthh27fKVhH8I5cH12XYPXLTuwwa7ZCIgKuvMmINuzvwhr8rwyiuTCVbEJi/tP2cZZNMGM5rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAWyKnStuSZVwMQ0rpMNgYdTk0O9QO6RQ3WQsvQNriw=;
 b=crZ2vob1uOAEgWG+pD6MU9hHk/qTq0mSr/qKDD8HlbnD6SQRWNtywT3q7hkoSIkUvvBp1kk17++AAqIcgq/YYSnVkEdgOuYpzo+Y8tC68UjSCRjb9wcslVsLShRq6viy8MLfoyxrHi/odrLMYvBiRGlxZbqWqm+kKvmbqxT5Sx4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB4356.namprd10.prod.outlook.com (2603:10b6:a03:210::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Mon, 23 Aug
 2021 10:47:23 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c%5]) with mapi id 15.20.4415.023; Mon, 23 Aug 2021
 10:47:23 +0000
Date: Mon, 23 Aug 2021 06:47:19 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 0/2] Don't fail device probing due to
 of_dma_set_restricted_buffer()
Message-ID: <YSN8tz6zb65V9+an@localhost.localdomain>
References: <20210816132618.11707-1-will@kernel.org>
Content-Disposition: inline
In-Reply-To: <20210816132618.11707-1-will@kernel.org>
X-ClientProxiedBy: BL1PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::18) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (130.44.160.152) by
 BL1PR13CA0163.namprd13.prod.outlook.com (2603:10b6:208:2bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend
 Transport; Mon, 23 Aug 2021 10:47:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14330f43-1219-4cf0-1c49-08d9662363ad
X-MS-TrafficTypeDiagnostic: BY5PR10MB4356:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4356E58045461331691A064289C49@BY5PR10MB4356.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AlLtrbgEyZa13jbUMESbBX0x8V+x4B4lGyWWR7dQRvw70gBnAyT3aB9KSin27Ydb7yfwa9QPfrNWaqQUB0X0D5nrwX1TfeBnK0FZsTMw9HteMznmVsXnVS9fnCbCQa7HkDzYWRk8qFgtj8I/GHYVrS92+1kvMyAq+Jz1KNaW169CaSLwConBHcEA0IDo6hvVNwWzhHfhC2hFJLnr4VBvRbLc7ELTMPqGatHAmRB7cbuau9xqeuhbfMTRZHifitB3cfYy3qq6kijbWxLSbUuzpP4MKvCzE2/j9watIT1BjskwBp26/+LvuP7orh5Ze2zEt3D4lNz6o/KGBK75O0u2/fHAZVzO3whVz8wDERsLyJgelvwKwM7eAjoWcmaTy+T88aFqI4mhsoGYdgcnL4TI1fDRDFgiWdYSaDsVebT9raLZUSjkHNZxCRQeSC8dNgVGSvZdfi6dWe9TEoTXr20cEL5ExDrHgB636olp/DV5/FaExLSCWP4Qh7VlWTaHO7hnaPcndjzWwCsXj/+kgVO/E5euKRswKBspX8k0DNnKc2jYXWR+HqlLic7FSCqEnHyovUYfsyUEO5F3ugNZ4V+3LjBCvQxGnJE5ULP/wPJLBP/8yOEuRD2yaJI/uf69dd+aNynTBofntPCfI9NKN5hMgsPQc3iKIq/tXAKM+MhvwFk9On0pVyeCY55OMpmJImgvs4e3vflp3XCksoIWG/6nsoXBi7jcb9cewVgi8s8S9JxwIQ0ojRHtQwF64Iyy7SNzIiAocTz6fXkhq2KXzGFwKgQ+ij7+fkn+9hhnEd6pyQHMT6qxGjgOtMT87lvsPnyI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2999.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(136003)(366004)(346002)(376002)(396003)(4326008)(186003)(55016002)(26005)(9686003)(54906003)(38350700002)(38100700002)(2906002)(8676002)(5660300002)(6666004)(8936002)(66556008)(66946007)(6916009)(66476007)(956004)(6506007)(7696005)(52116002)(86362001)(478600001)(966005)(316002)(83380400001)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7aYVAahHMUdMOL5tFXYGegLa9WSwFkNtmo1Ry3+ayrlyoSHhXpHZfmHdZIyy?=
 =?us-ascii?Q?p+nsWQ+tQDvwJndhseAbV9szoQjoOiBdWpSV5sJoLAKPW4/e2XMM2Dl8KtHk?=
 =?us-ascii?Q?CDO3c5qF9V1nHvzAx64gObhkHX/4VTwBWpNsGac1Xmw6BzWaxgT0xky8P2wZ?=
 =?us-ascii?Q?E2BH4t6hisn3zxSCyaNEHSazD31SB4xgZ2I7JOHjvK0OFXfHnZd7y8C0p9u6?=
 =?us-ascii?Q?P7NM5Xvc4zoeLM8uXutPitTtYN/g5+FVHALTEqhfjTFWviP18MHBpXGYPA54?=
 =?us-ascii?Q?K6PR6EZHsd6HK8ANrYwuNIPxOqeg4f7O+RsyA2h8Z7ClA9hGo+fHnPIx0XxN?=
 =?us-ascii?Q?rLg3SEiwVswECHbEePuFiqgfwUvZ3SIRt3RWoukNhdhRt7DjUhauGTNZ6ipE?=
 =?us-ascii?Q?8axBvU5D1NWhHpaZipUAUj9r951uTusYDnAFloWR0oVTq1eFtayggxHL/5mR?=
 =?us-ascii?Q?WLMuPSY1wte6hWENkteLicqKYfl3qebPxRtfGM0ByS14VblMRx0CRY0jYWy/?=
 =?us-ascii?Q?n8SE17FLB4PfAuUBHzA+ngQr94pzaapMYZBm/pKdhaN4bdAE6HOOjOKzgRq1?=
 =?us-ascii?Q?MnmFcg8IBJkAW/mtnpFAZLqN9WjpK3UOCvyGBNuTJmBnzJvDFd7zqYRH5ACS?=
 =?us-ascii?Q?lqxdMu6GCN9wHPkb/Mn5fOuNs4yPOHI9eNfWZkaEBQet4lCjXmhN6YGExZig?=
 =?us-ascii?Q?Psy1q93MyfRIL5NNRqiooMVkjEMtYhXGNCN16z1ny7LxYeaARNrkKntX7Txb?=
 =?us-ascii?Q?cKw/eEcw3YYBI3hg4JyXaGVGgZhGglR3fnTJ/rQifHvqaEYUCLWAJLfMj+mQ?=
 =?us-ascii?Q?dWzcIVl5u6wpq6NMEgmJHAwZV8eEvoUIvRzT2iIx5p97g/Uca797r2WZW4bW?=
 =?us-ascii?Q?J021m6HUvzP9W6nJWemoi6Rpdbyo0PXaRxzu/lnKZBvKvzeNydcjcBRek+Gm?=
 =?us-ascii?Q?r8rGXrVrJyXLsptiLTxms8iG/eCqVZhQxjXFzZQkVFuPRVTjRlGTG7Hp5pHS?=
 =?us-ascii?Q?FijAAYVJWXnknXbcNxuxhrEOIxIFrMNSI+WoY05oC15JnKBAE2/8tNZUOiAc?=
 =?us-ascii?Q?sah1n9vI5oywntw8zTt/WEA/AU7YLDrEW3j6g72xeQIP9flFq0ubmzdtrSY3?=
 =?us-ascii?Q?GqyrcyHonDf/LOdhNrr27NVSobgprMIIbxP9jytmW5SmvQb4jyr36ZrSZYwf?=
 =?us-ascii?Q?3Ab1WxLouMP87ZKzUhcCoFPr+NOpv63KuWl+TFGZlnqMAi7GAJrnaHwxfuoS?=
 =?us-ascii?Q?lDVyrHvaS32VU5ZkMJke977OZJtwBB6hGxRrv7LVbWkaJKjT8QHRNvI58iYj?=
 =?us-ascii?Q?NAdcWQGVGRfqvMLe4/FS+hBD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14330f43-1219-4cf0-1c49-08d9662363ad
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 10:47:23.2983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XU3oH0KW12Jx8/1zIMPCS+8P5YpbBGCmTlb6cdx4GP8ENdxTlfTNhAFQxvlSNpVRV3/KyrU6Rn09r/Iq/CSBXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4356
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10084
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108230071
X-Proofpoint-GUID: 8FcG56PY2XdXcLFpiKhYNGe2zjq73Xl-
X-Proofpoint-ORIG-GUID: 8FcG56PY2XdXcLFpiKhYNGe2zjq73Xl-
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Claire Chang <tientzu@chromium.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Aug 16, 2021 at 02:26:15PM +0100, Will Deacon wrote:
> Hi all,
> 
> This is v2 of the patch I previously posted here:
> 
>   https://lore.kernel.org/r/20210805094736.902-1-will@kernel.org
> 
> Changes since v1 are:
> 
>   * Move of_dma_set_restricted_buffer() into of/device.c (Rob)
>   * Use IS_ENABLED() instead of 'static inline' stub (Rob)
> 
> This applies on Konrad's devel/for-linus-5.15 branch in swiotlb.git

It should show up later today.

Thanks!
> 
> Cheers,
> 
> Will
> 
> Cc: Claire Chang <tientzu@chromium.org>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> 
> --->8
> 
> Will Deacon (2):
>   of: Move of_dma_set_restricted_buffer() into device.c
>   of: restricted dma: Don't fail device probe on rmem init failure
> 
>  drivers/of/address.c    | 33 ---------------------------------
>  drivers/of/device.c     | 39 ++++++++++++++++++++++++++++++++++++++-
>  drivers/of/of_private.h |  7 -------
>  3 files changed, 38 insertions(+), 41 deletions(-)
> 
> -- 
> 2.33.0.rc1.237.g0d66db33f3-goog
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
