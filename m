Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719E0C48BE5
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 15:39:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 128FA613CD
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 15:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128FA613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CF97A404A4;
	Wed, 16 Jun 2021 15:39:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oLapN4EjFhF9; Wed, 16 Jun 2021 15:39:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BEB7640242;
	Wed, 16 Jun 2021 15:39:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9039BC000D;
	Wed, 16 Jun 2021 15:39:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4D8DC000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 15:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BB325403B3
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 15:39:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IC0F3qBG7Nd0 for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 15:39:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9879540242
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 15:39:22 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15GFVgrr000890; Wed, 16 Jun 2021 15:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=9o4zO9/76jPH5jhgzUljYo/DDXq6qELutUc+AEOe64w=;
 b=lgYqKRI9MPy4nW7kNY2WaylETH8CBbHQUO2m6cLQ2Lh/hkDjeDfAATY3PeHYndQpakKB
 K+79nVgf/tzE2YkF6QljrxMZFGBNws2CYzGsJ8JBixwuq8LsZcZ+QVzJ8W5032g0YtRH
 FBwa4zFI/fBZ7ltbjazO4JGrdhSEPxPYyOAtmYEl7Dg6z5dKp5qZuPXInsDVta5Rpe+z
 Et5nwHgbP9VteRFW7CA2lKGHxvKPaxiFSUJ7nH+AjYcBuFkVPEPumzWM+imbHLPu2lSP
 d6MMmnb1zIp25L8v+l+Gj9dALkOSdKLkBA++T6gHh5VJfgcf6yk5oSSXF6qS6dE7+cdT vg== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 397jnqr7r6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Jun 2021 15:39:18 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
 by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15GFYxr4079246;
 Wed, 16 Jun 2021 15:39:17 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
 by userp3030.oracle.com with ESMTP id 396wap0u7v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Jun 2021 15:39:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBJN0eTMw0U99qaOm8CFe0MiCTUETF/LmmFsaNSxyMvZMRNQmyZv/iYmBaW975rseVcHsE9Qwh0UQwWl/5tr8lGaP38z/04qgsd+Kl1CVZBvMWtyTf4Bq6gYGS8nh7pBaW8QgVpeZyDlE+oOQa7Pv9zlp/uW5E5tVo0HK9tD37pCdCjgMQouqaOhFkWXceAOBby+WLucg3u8Vqlbeb1gLt33j/kihXtVSKPRoN0Sw8cPDTfsErYF7wxXEPAiggaiUSj87QXhkab5i3koV7rEiD+dbt8Z/VltUDOKwe9RRY08jpaAtYzlt9DQBYin04yPVtYhwjXLtdblUErgZkzRTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o4zO9/76jPH5jhgzUljYo/DDXq6qELutUc+AEOe64w=;
 b=NnOIjolSG58jDXOfo0uCfTDlONJRkNijR9OFKJgmMUAs+VLGPH97tcO+7PqS20+OOO2i6/AM/ieR08rV2wEo9X4KYsuaI3jEpsVjbrMVp2dyUkTi1W1dX8jMm7GW3z4Z2yh1uSjPmV7GKlOtaEYxnBquw5A0Gh9hlq9NpceUq97LwnNyw7zKUaVDf9R7PV0R1vnIWusR/+xkmgwj2Kec8o9F6KVxp2IEpg8uPxaXx5aQ0l/i6mttbKkICpwjol3oj06Y5orjJj93DMCq2aKuXoLjNhYezkRvUxMv8X5QIIFqaNJ5iq3fKxsm3aI6A6PhXaH9ZbqrqjYuK5//H5hBNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o4zO9/76jPH5jhgzUljYo/DDXq6qELutUc+AEOe64w=;
 b=ZtI4ZxZR1MLhG4gtn/sdI3YMq5LF4Zz26C/dm6Xsl7b4CXcvrm+xafMe6q23t47NXOrp865vcQ8oZ9riXvT1RrHdWG+/KbuAhf0PS53bnbINWkDC0jp3D3O0JM0HgODJO309kXfa4VSc2IWZIg48dA3HjK2UsPiNdow0D/FrS2s=
Authentication-Results: epam.com; dkim=none (message not signed)
 header.d=none;epam.com; dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MN2PR10MB4288.namprd10.prod.outlook.com (2603:10b6:208:1dc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Wed, 16 Jun
 2021 15:39:15 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::78a3:67d:a8ca:93cf]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::78a3:67d:a8ca:93cf%7]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 15:39:15 +0000
Subject: Re: [PATCH 2/2] swiotlb-xen: override common mmap and get_sgtable dma
 ops
To: Christoph Hellwig <hch@lst.de>
References: <855a58e2-1e03-4763-cb56-81367b73762c@oracle.com>
 <20210616114205.38902-1-roman_skakun@epam.com>
 <20210616114205.38902-2-roman_skakun@epam.com>
 <2834cdc0-534c-4f07-1901-e468a7713c1f@oracle.com>
 <20210616142148.GA764@lst.de>
 <83353b34-2abb-9dfc-bed6-21d500abf49f@oracle.com>
 <20210616153519.GA6476@lst.de>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <d4e8c822-3f92-d552-018c-611a44299e28@oracle.com>
Date: Wed, 16 Jun 2021 11:39:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210616153519.GA6476@lst.de>
Content-Language: en-US
X-Originating-IP: [160.34.88.136]
X-ClientProxiedBy: SA9PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:806:6e::23) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.74.102.136] (160.34.88.136) by
 SA9PR11CA0018.namprd11.prod.outlook.com (2603:10b6:806:6e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Wed, 16 Jun 2021 15:39:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e8f31f4-5250-47c7-72c5-08d930dce567
X-MS-TrafficTypeDiagnostic: MN2PR10MB4288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB4288A68D4DCCA1623DEE0A078A0F9@MN2PR10MB4288.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0UL7UXMMgLuE6DoiuUnfADfQhdLKp/OHK9PL2ed4eTI9RLPXu+rnsKMvUJlm2fFswTnDXVqXJTPlKCrTPNoa1koZXYWHPh6ugeqeQAwc4uS6P66gBmxBk9m3PBsOBc/O0yHSry4ql8PXePej88tPUVlQtECskpa02NGtmkDzKKt0We9DuvzPKBmrMjgMVaKatHaiXgdbCs1T9bPcftthwi0rLN9+5iqggZe34tsDgWsrXRW3WZsAb+9D2t+L5hgb3MR/QCyLOmzmI/so8m4eycaPCuiUaekdH8GVsUIGIXR5hAfESIlMK07WhxFSs3jPdo8ekXKOAjclG6BOwO/Wa0OndGqP2EboMrj0btndkDdCuPcXYPVeFCawQBL4OljFxJRcMYpPQd62NkHidPF+eUXA01GR+50t5T91Sv4NjfGMKEovFcvrsFLCWII+4eEffl05j7wtyLknoB4T9VyG9+11K2g0snUHuKRQBXqyoWX+A+YwDgCPaOVmqXFxsL2n3CuLy0+ZFNwpJyubLQ3smv5xegS3ytgyjf3SPaOXepP7m7DKFYZEQLR59ZncxEFYXoAiMfCEclTsCZZdLmNZiDU5lUv/ZeZ26vupBWK23vtSA1vuWAuHvorOJ7bGwxkjhGwkqSZxoVjpi/9T6w7MqZQd1gJFfc/r7J+1kWV2CNEpDgdEwSHWcdaI3fhszxR9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5009.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(39860400002)(376002)(346002)(366004)(136003)(66556008)(66476007)(66946007)(7416002)(956004)(38100700002)(2616005)(6916009)(53546011)(54906003)(5660300002)(6666004)(44832011)(8676002)(4744005)(4326008)(26005)(16526019)(86362001)(186003)(8936002)(316002)(36756003)(2906002)(31686004)(478600001)(31696002)(6486002)(16576012)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nkl2dTgwUnhqcjY4SEFSNFk2VFUvTFo0UkJ1UFJJVkhKTUFXU3ZtdUVSNURC?=
 =?utf-8?B?U1hwUk1NcnZZOG5DMlBvK2dhenpseFBYY1ZWdjBNQ25yb3p2c0VnWjVjcUMr?=
 =?utf-8?B?MjFKS3BtdU9DakJ0ZmdxZXFleUJ2Y0hLT0VpYWFKT3Fna2JhK1JYU2ZNRkhS?=
 =?utf-8?B?UkJRY0UweEpQRTdCT2lKVmpqSDhWbndVSXVIcDdzS1J5SE9XOU5QRWRtcW9J?=
 =?utf-8?B?LzVDa1dMcmdaYjBkUTl5NDlaeDZObS9SMVY3Znl2VGMrT245TG5GWnRCVnhs?=
 =?utf-8?B?ZXhoTUZpY010SEw4TThTZFNGbEtER1QyM0FSSng1Ny9HNWR3UXkzSTV5bzhS?=
 =?utf-8?B?czJEUWZaeEJ4bWNSR2Vyby84TWN3WFBJZDZ2QWRCVGppQzQyUWdoQ2h0d0ZS?=
 =?utf-8?B?TU43R3RKeTU2M0hVVHVRbDhYMGhFS1NDaWRhS2FPOTRNbC82VGhnTjhlVzBu?=
 =?utf-8?B?bVoxczg5VzBDL1VCbW4wdGVhUU4vaGI2MThNTXlzd3QyWU5GU1k3Z3I5b1dB?=
 =?utf-8?B?V2ZsWGR5U3g5anJDSXBscVhPaWxhbFhxQmF3QXVXODE3NUl4UERTQlkyYlhZ?=
 =?utf-8?B?Y1c0dEQ3Z2JwSFJUTCtvQTV0RG1CTXhobkhNU3hGOUxhVUlncXdZY0M2TUZW?=
 =?utf-8?B?ZnVnVzNxaHh5M2JWNHR2bU16Zlk4bVlMWmtibXQrSjdVRkNPeGE3aXNoSXlW?=
 =?utf-8?B?Sys4S2w2SGtsOGFJRXRGR3FwdFQ2RHVCeUY2RTV0bEZ0NUZaeFMyWGloRENE?=
 =?utf-8?B?ZDh6ZHVYanJ5QW5mRzRzOGdNamVNdm54MERyYmk4NWVxbldoNTYvR2RWZnlX?=
 =?utf-8?B?UWZtKzd3bE1pUHQyU3hHNWtIa0cxTXpnVXlCUE5hVWZqSjZGVlB2elp0RWdh?=
 =?utf-8?B?bXRLZTFhV1Y0Z2JjS1Azek9CNDhuNDJ5UkVlL2tpR0ZmT1VwSFN0bHcrNXVz?=
 =?utf-8?B?MlB1Z1pwdlRvVVZPWWJ1ODBkTFVCNWE5aEhjNEtxeVA0Y2xtN0dqWmtNb1Vy?=
 =?utf-8?B?L2ZUMjI1aTk0eVVhdG1Mam0wOXM0QUZmcTRwcTdTekVnaS83Ri85aWYxRG12?=
 =?utf-8?B?WjJvd0JsaTZXcExEYjBzdjZvTlBxVkNPZVNlNFRnOHh2dWlHbkF5ZUVlZDhM?=
 =?utf-8?B?K3E0d29CdTZlZEsvNitCTWVzYU1wc1IreGN2VVUvaUFYK283ckYvdjJwNGJU?=
 =?utf-8?B?MVg0RzRERTZKaW1KVGRvMWV0UEFZK2V1bkJnWHROaEllOTM0NExHdWhkK3A0?=
 =?utf-8?B?OXc2MmlHZklQd3laM1lHSzFXOE5HUTVuc3p1QVIreFRZdzdHcC92OHpVTjll?=
 =?utf-8?B?cXVRNHZua01sU2ZlQnNYcS93RkNod1RvWnFMRTFDcDRBd1VSQkYyVEhlVWRI?=
 =?utf-8?B?WmswcVdaMUNHU2lBNVpCZTZ0bk5BOEpjOFo0UnNndGtsOStmejRscy8xbWxZ?=
 =?utf-8?B?ZGdPdDd1OUwzQTRzWXpYUmVSUVNpUS9jTFc2MnBFUEN2QzQ2RmNSWllBR2FD?=
 =?utf-8?B?c09idEt2MTBJNU5Cbko2VDVvdExnSVBTeUs4aFZSZUNRdVdwbzZkZ3JoTWN4?=
 =?utf-8?B?R2lsSEZTcXlDUjVTdGI4SzFwUy9vODhCRGZtdlpReFB5Zm1rdzNXcDNRWFZN?=
 =?utf-8?B?NHBYYTBBK09jZ1dsMW14amVFT2ZsYytJWUt4dXk3Wk4zTjUvNE44aGI4TlE3?=
 =?utf-8?B?MktrOHpBSWh0aVppckY0aXFCdE1DRGo2bjBuNklYL3NVZDlqNU9mdDBmaFVN?=
 =?utf-8?Q?FeaCpjFqICWItRg11+Kq79sBQTi7tPQBowjFqzF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8f31f4-5250-47c7-72c5-08d930dce567
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 15:39:15.1267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZeGRt4qcV4Kmmp09CJ4TuWSOOBYt6SRkKrTekZXPfkq/lHraD1a0QZoLKMYnIf6pyLGCAfIAOptWqZCfafWCYlURdIeTSPUlYYnmdHbsSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4288
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160089
X-Proofpoint-GUID: XLkRvkGr5dscz3vWtyy9po6ZAzrd3rO9
X-Proofpoint-ORIG-GUID: XLkRvkGr5dscz3vWtyy9po6ZAzrd3rO9
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Roman Skakun <rm.skakun@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 linux-kernel@vger.kernel.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 iommu@lists.linux-foundation.org, Andrii Anisov <andrii_anisov@epam.com>,
 Roman Skakun <roman_skakun@epam.com>, xen-devel@lists.xenproject.org,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>
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


On 6/16/21 11:35 AM, Christoph Hellwig wrote:
> On Wed, Jun 16, 2021 at 11:33:50AM -0400, Boris Ostrovsky wrote:
>> Isn't the expectation of virt_to_page() that it only works on non-vmalloc'd addresses? (This is not a rhetorical question, I actually don't know).
> Yes.  Thus is why I'd suggest to just do the vmalloc_to_page or
> virt_to_page dance in ops_helpers.c and just continue using that.


Ah, OK, so something along the lines of what I suggested. (I thought by "helpers" you meant virt_to_page()).


-boris

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
