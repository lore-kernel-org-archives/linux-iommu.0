Return-Path: <SRS0=C8jr=MS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5232AC432BE
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 17:31:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49E260F6B
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 17:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D49E260F6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97369605C0;
	Mon, 26 Jul 2021 17:31:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FipN1PGnh6vF; Mon, 26 Jul 2021 17:31:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 750F2605BD;
	Mon, 26 Jul 2021 17:31:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55F20C001A;
	Mon, 26 Jul 2021 17:31:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AB8BC000E
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 17:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ECA884018D
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 17:31:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="nlj4dqI0";
 dkim=pass (2048-bit key) header.d=oracle.com header.b="RE6d+L7z";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="zhrRWNKB"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EhAIxM6rgF98 for <iommu@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 17:31:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 895FD400CD
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 17:31:12 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 16QHFvjw020261; Mon, 26 Jul 2021 17:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ma2fxOKnXpHEs3U5Kkq5U0lK9WKeBOL0aAljvvdwdUg=;
 b=nlj4dqI0+nxj0VSm3H+C6PuDAD3UbrEzVDA9DUYUROZ5O8VD5DZAN4QDajyqnSyTfyTF
 wqsjzZavEvKyGE+9NU0u9mkIlapVK+FWUGIs6mW9oCf4UhHGZxpjz2g3pU5ShLlfzwV+
 NxvVf7q7AnMkGxZsQ8cKHNoHoDo/CSOo4iOzFH00APPLPdQo5S5ooVk5Xo1Yp1aH69yF
 gMo8YdM06tNMSIK/mVPreAlUlRe7ygVHNtcHx6fnFL+QG3ll73TX1O2NqSfdxf5Ge03J
 voLSKyIcPyRYVIuOwpSwgjRc/L/SNSFjgLwZwKVLGNBa3KbXhZ434iKYlE5yRWRB50/Q Rw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ma2fxOKnXpHEs3U5Kkq5U0lK9WKeBOL0aAljvvdwdUg=;
 b=RE6d+L7zpxC4xizLqp4EWWZ6JA+AMAwT/Hjs+LHFUPXXY8LWcJy+abAZlaqq5uK4Am5q
 xHixtJIfQaY3ir0Cim4fJ0JX+hSOl2HpSIZfN7rDE9RWIyu9pcERGAtrFwHdcDLYvv3u
 +pQzt0zvxd8agfoPk+Z7+ePt08X9qNGsfZV38powSvB7pLTEktYrxs4udVZZ3Z/TaPFk
 0ndw6y8eNwexW84oZRE9OWzbpLMmqupcFxy4vykXdFqq0iHBHOnb2MGMNAf5GuRvTaXM
 sf42SpxFLf1P525GAosXvP3uQJ7+uR0z/VlMN1GZutZBwt/nhWkrQ7dNi0J/eYog46kQ oA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3a1qkqsmqu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jul 2021 17:30:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QHFS9w176799;
 Mon, 26 Jul 2021 17:30:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
 by aserp3020.oracle.com with ESMTP id 3a0n2gdkps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jul 2021 17:30:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/LtSXL0XVysq2WcUVBgbaN0HLDvSjc9C4wqxN8Y8s3Gpl4XS9VhTjYyctTajsj0y4Fpt35bQGhbOtpDV0fmC37sUrnlIdAYY6rVXYCwLCoA5MIdKMHmQjrIOaaRG2hryE48U6k3WHTVT5fuND2WyhZPrOBeOL0VJCyE21Qr8mZSGqARjR6MzPODR9qDoZOxfW+fZxi/fJbq12OILrSHk08JDc8tIH6W9ouh5eHRk5LDGd2Ew4qnjemIVeg3D1HpOeYgjI+qwRTNOImXj7g6wBA9j9SkohHSgbHVIrflRWaUEORbz2nipQympGa+MOpnUdyMJ0DamhdRFq1rtcMYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ma2fxOKnXpHEs3U5Kkq5U0lK9WKeBOL0aAljvvdwdUg=;
 b=YSaAO753OVo1aEqwgWRbLrLugdh+poRPNTw7NhvNHikaHkILvD7jW1sPN30/xxCx/rseVFluYQeEiqH/Yw5Ah3bS1vt2vd/6L6Y7RpttDBDWyGdX/gmVFirzIefLkGITbHvhYCx7u5zYWIPylZn8N4eSJnMGnDaw+ZdKejAeZiUFN0l7K4At/JDkBQEPwDIK6/qi8Z28KMr2f3RP9islgjAujn1FEpsEFoBDiPARYYQZpiqlef+y5ocEfJl9MsLA0hVVnm85f/Kechn9jB0kjeFvuBYu1qDCKXcTuH4WkS0OrzgMdKws5xK2uBI7EjrPILsuPNxJaDcs7KAvphlXVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ma2fxOKnXpHEs3U5Kkq5U0lK9WKeBOL0aAljvvdwdUg=;
 b=zhrRWNKBzimkFbx41QahA1tjgtSy9+LFii9JmAjG2oqa36JHWD3X49luhm3SSFVOfeXmlzi9D1EaLT8mr6opDcttXo/Mcf4OAGSP/vj2J6aWdPM/cBwTZY3a00O4mklrNx+6nmkEynw+ckR/28CEYbkPxoG10kTMtbP5+j+mZbo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BLAPR10MB5011.namprd10.prod.outlook.com (2603:10b6:208:333::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Mon, 26 Jul
 2021 17:30:44 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::f10d:29d2:cb38:ed0]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::f10d:29d2:cb38:ed0%7]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 17:30:44 +0000
Subject: Re: [GIT PULL] dma-mapping fix for Linux 5.14
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>
References: <YPz+qQ6dbZVDbMwu@infradead.org>
 <CAHk-=wi2OMmUkZFdQ0=uYmGeC3sv3eYw-p1=d51pJS-XVKaM2A@mail.gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <957943ce-c50e-1560-6f1b-aea0a1c9a114@oracle.com>
Date: Mon, 26 Jul 2021 13:30:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <CAHk-=wi2OMmUkZFdQ0=uYmGeC3sv3eYw-p1=d51pJS-XVKaM2A@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: SJ0PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::11) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.74.97.124] (160.34.89.124) by
 SJ0PR13CA0036.namprd13.prod.outlook.com (2603:10b6:a03:2c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.14 via Frontend
 Transport; Mon, 26 Jul 2021 17:30:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd4825b9-6e2c-4662-9ef6-08d9505b191a
X-MS-TrafficTypeDiagnostic: BLAPR10MB5011:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5011BB367E81B1ABA0A777778AE89@BLAPR10MB5011.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fo+vrdDXpBBhEBHZuqjA6kPje4O/bHC8BrD43WoFYwyj2tYFEifDaMhzkYsiCwmEoOI9DFvG3/h/+EBjp52fhyaardGoNETh8k5c1DZxnm9/hQSj1LFJyngwyxUsBedFkcffp9uDff9gYPYcQ2ZLin7ecSMLU6PLYtq22icff/gUWIZ6e3JYBW0Ja28eVTPNRku+nfAMz+pmzEe6fOZ/wjl49uxr4QZO5PSiTUEg93HsOPjViO9MKjKcX7WimyImJ7wPvVOwK98++ZcQS/mlzpeBttfJ1cKDyt/v1cFJnErAvkEP3MMydLBSw5zmw66XCsWPs+QovuSiRszOOcI67V/2hPCwGOMslatap4tMR+ymsDr8ctbWcK5HljLhl7HJAqTPb3Y5yfYCuPUyPYWBUkc3AXD4ne4k7QgbmrmalXUrCtnJ1etvaVKdLiddiIOW3BFiyaF4jC9EsC/fbCj/IyJc68meNTHn+Ztx1XD+0iqrw84TYRsJNI8p/GlI1ZFImLuhHI2wQFLbzDc6/jITwvkTRbZDHNea/OisbCcsNtuCBYgipQYsaO3qIvR8ITz1A2/FOKFbB+ecjzcLLab/5Ff7l0hnT+qAdFJRfzkD3lKPV+TSURWXfHQ/v8GrAsGolHOcIX+TJWaWC+UOVIRUtBq57C9t3l65C/vpg37RrWSpWfMnZaKmWcrbXoMFpNVKbzHsz29M3NhW30VTrNnsf+HPBvUhRNge71NhGbWMELH9fGrao/VKJ3BeQ5DgkvTnqva/WfiTezgo/l0tnbTsPf80c4NmOoc+04HJEzaRakDn6lrKZVefgdhbETFOUQR1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5009.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(110136005)(44832011)(4744005)(38100700002)(16576012)(6666004)(6486002)(966005)(8936002)(5660300002)(956004)(53546011)(186003)(66476007)(316002)(2616005)(54906003)(66946007)(66556008)(8676002)(86362001)(26005)(508600001)(31686004)(36756003)(2906002)(31696002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmhuL0FXdk1wSEE1K0NBUG5Hb3E3d2VtMFN3SjJDeTBsVWZvQXE1ejZmT084?=
 =?utf-8?B?VGhZZmxHRUZpV0gzVytiais1VW5Pa3huTlQrdjlhZ0lxTHZXZytpQWxaRWtV?=
 =?utf-8?B?TzRBekhNdDVBa2tJMVBaVGhRa21VbXNEVmdVY08vOHZSUjRpVjVhL0RCOERj?=
 =?utf-8?B?MGZEYUFSQk9tS2haNUxreUxPTFNrNlJOZFY4NEVXMW8wbExscnN3SHdjUm9m?=
 =?utf-8?B?VkptcU1aNDR3WFVaUDJWc0I3cWY2bWk5WWIyMXl1cUpHTkxIdmo1REFGandv?=
 =?utf-8?B?clYzVEpMc2lvTmdwN2ZYRXA5UXFCcjN4bXRrQ3ZjbmNnbm1PbzZVSXBra1R6?=
 =?utf-8?B?b1ZOOFNQUW1CTWdka3dxMVhiYUgrcnJlcm5GVWs4SldubkZJNlRiSnRibW1a?=
 =?utf-8?B?SXA2L0V6TFZDZEJCVi9mZVBUM1hxQ3VwZ1krMGVwZzlTdzlWR1cyd2ZBeDd2?=
 =?utf-8?B?U0hSZlVHNGMxRlRSWEJSenNKaTl4ZzI3Tk8zWEQvZnkxMVBZaDNxaEo4Qmdo?=
 =?utf-8?B?OHQ1bkRGekRCTkFSR1FsMkIzUG85NFNoTjkreklaM1FYVjc0aUVMS0NhNnVP?=
 =?utf-8?B?SFVrTDMwY1VvNTFwZ2Z1VnBkeW4rRlBWZG1leVJreUdPNWxQQkpmcEQyTEl2?=
 =?utf-8?B?TFk0ejVITFhYZEVaU1BLSEF0UkpwVHVoVVBvbEhtYytLTnN6cVNUUm1OL3B2?=
 =?utf-8?B?cURYMEkybTgrRk9NYm03UUJOc0piUWNSNmJzTmsrUWZGWjNnaFl1d3lUNmo1?=
 =?utf-8?B?bEtLR3c5OWRMWmM2STlrWFlBK0JKbW5CM09HelkxOHZ0QmRmTE1VbFhiSTZF?=
 =?utf-8?B?eE12WXVKbXlQVkNJWUNDY0xjM3N0aEp1aUFBUmpnMVRvK1dOdmpnU3NxMWN2?=
 =?utf-8?B?d0p3Njc3dlExb0sxWDFsRjRiZzczQS9WNnlTb0thbjdnSVIzeHpCZ0RRaHVK?=
 =?utf-8?B?c0VJTFp6RS9WU1c5VlAwbnlWRmU1Um1lNHVpNDR3bURwbGVXcHdwQzFIY1g3?=
 =?utf-8?B?SHNEVkJPSUhPbGNMT1g2NDVibi9mV2pHd21MRmVnWnVoQ2h1anRLSyt2U2Z1?=
 =?utf-8?B?WDRaSFZRN3JiaUNTOW1JUnJVSG1iVythSzV4Q3ZMTEhOYXRKcHN0UzB1MElM?=
 =?utf-8?B?SEJYeXJIdW85YWFQbEhheUk5dlBwODBReTFkNmpzbXRqb0Ntc1pMRFRENUto?=
 =?utf-8?B?anhhbHhETnJPOS9CRFhiY3IrbjQzayt2N2h3bmpKNW9PbE1RblJTaGpCclhi?=
 =?utf-8?B?bGpCVStzcndydWZpeTM5K01OT0Vya2NuMW5XdlF3OW52OTA5SmFmdytSM0J1?=
 =?utf-8?B?QzRUUkxwRjJoQVE5WDRyOVBpQU8zNTVqZWdoWlV5eW9DNzA0cDF3Mnd4K3ZZ?=
 =?utf-8?B?d1RuL1hoTkRsdER1QVIzYVFvSzVQRUZGd2NOcE8xTTc2TzF6WmNSR0x4UTZF?=
 =?utf-8?B?UkkxaDJ4MzNBTjYwUmc4TGhoY25nRlhkWndZN1ZqNWVYZVp4ajRsT29ldmVz?=
 =?utf-8?B?aHE3QlpnWEYxV0xtNzc1ZDM0S2pZUy84SDl3azdQdGRUb3oxM055d0VwaUI2?=
 =?utf-8?B?bUVaSlFJTjgyRmpOMXZoZlM5YUtmTHNmRG5QSzNLdU9GS2JhKzN1cmVIUWVl?=
 =?utf-8?B?UEZFRk12OHZ6OE1ZTTJXZDltRmM3bnNsUGNsQTZ3RldUR3VobVpGWWdwaE5k?=
 =?utf-8?B?VE54VW1IbzIrZjl2T1d6MXZrd1VJNWZ6aVd0MTNyODFNQitqK2ZaaEpVQWF6?=
 =?utf-8?Q?vxLlnxpI7QZRODkRCYdaCmOiBmEYmdhRXynWMNA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4825b9-6e2c-4662-9ef6-08d9505b191a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 17:30:44.3843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFMnLhCQZriXxcyWR1G+6/Z7feQkigk4xcuVgR9XABuN7TRKRvnqptltXhguteEYv4B9WC7qBKuMXBQDx2OKo7//hF3qPtxB3SyO13zMIUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5011
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260101
X-Proofpoint-GUID: tn5FoM9xMTTCjY-fvcxlyaHnee_3D7ws
X-Proofpoint-ORIG-GUID: tn5FoM9xMTTCjY-fvcxlyaHnee_3D7ws
Cc: iommu <iommu@lists.linux-foundation.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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


On 7/25/21 12:50 PM, Linus Torvalds wrote:
> On Sat, Jul 24, 2021 at 11:03 PM Christoph Hellwig <hch@infradead.org> wrote:
>
>>   - handle vmalloc addresses in dma_common_{mmap,get_sgtable}
>>     (Roman Skakun)
> I've pulled this, but my reaction is that we've tried to avoid this in
> the past. Why is Xen using vmalloc'ed addresses and passing those in
> to the dma mapping routines?
>
> It *smells* to me like a Xen-swiotlb bug, and it would have been
> better to try to fix it there. Was that just too painful?


Stefano will probably know better but this appears to have something to do with how Pi (and possibly more ARM systems?) manage DMA memory: https://lore.kernel.org/xen-devel/CADz_WD5Ln7Pe1WAFp73d2Mz9wxspzTE3WgAJusp5S8LX4=83Bw@mail.gmail.com/.




-boris



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
