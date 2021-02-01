Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C8AC433E6
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 18:09:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E7A64DDE
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 18:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E7A64DDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F21D985335;
	Mon,  1 Feb 2021 18:09:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zmljlVW2kBvu; Mon,  1 Feb 2021 18:09:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 34141858AF;
	Mon,  1 Feb 2021 18:09:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DB39C0174;
	Mon,  1 Feb 2021 18:09:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77F0FC013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 18:09:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5D04585335
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 18:09:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BPLCTsPL+pKV for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 18:09:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DA2B884AE3
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 18:09:05 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111I05uU121990;
 Mon, 1 Feb 2021 18:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rBMBHWWFkQ8U+qoJvwj7L/LHujnKwHKkQ6uF33IvtXk=;
 b=EEOAGQ5vez36LV1u7xYFzqv92afRDxFq2L3+zpVY4wKPX/5l6M4HGyIYYJau8lK+B0M8
 NYlzbkdif+KOK43HSfL3D6nCK2Xjm12jgMkilUDMKc8qjdEQKojhcWf1JEpuD+qwlqsE
 ab8jbWBeIO7bUEXHQkUw8sOpIRNwW5ZGtWXEOSIx0vILfYGowEd/oPWbiL1YBeXxk3/V
 hJfSW5Zpjxa9MO8F5e+U19PXyn0zzIn0dMXznS684z44W+dSdFFazqO2uXIvWsdp3DIp
 BVO927gw8w3R9PyXF8IQEaG3QSsrpNhQFESOCyg67A28i42BmezrsZ/d55rws6R5Ot7k vQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2130.oracle.com with ESMTP id 36cvyapvw1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Feb 2021 18:08:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111I4sou188175;
 Mon, 1 Feb 2021 18:08:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by aserp3020.oracle.com with ESMTP id 36dhbx0adb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Feb 2021 18:08:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXAPjyVEMftGfIeoXHw/ImZt7Baei9YZikIXNZjbnZzaDPXKvf6i8wJytVsoTjKn3kZkDTEGjQw2L8b7R2TWGjlMLfvau2dqtKR2UbrwCvv3oXsbli/gMJ943PqHhV8pX1/2v09YzhQyvjw5qCxuc/Uts18O0GfXpsNB7pz3ON0JhrFtIPB8iuGOWa2rvZWNUQSFDSibeCHbDtwurfzy4nO4Ti0TrwxTHEPD4Ir/+mHDMcwpTS+CQOoQkAMStOEKaSRxVz9MvQjVYOJcZMjAUa3ICeZNWc16kOYi+bkhMfIniTdTDsjVcOIGIuNqrmGV+QrNy2vQgqoWz9wzRC76pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBMBHWWFkQ8U+qoJvwj7L/LHujnKwHKkQ6uF33IvtXk=;
 b=G8/eheXmA2JKLalrDxocUKj5n4sgBhdjGIIeXbZdBP9YAS4iQm4mt+lcaf8hCpmc7pHEziiCV9pegdAie7/6GzQieNkFtMEGBAQHt49L+T/MHChxx7UsE72me7OZu7MXNcJ8UCKz5VvkMdEkdCEmm//kQz1gi/HmzuxR5BWFAaIIhQKE8Zeq9eNO9UC8N8DQky0eyYK2C8Z+s8/kB0XnPFowMUjg5cF2ENYMS6Gi1H2PXYF8RrWeOLkmiKMHg9I2Tqz6x6fq38ayo4FfeGI6z1oYUXklq9Tga6UbzEPZoU52w/bHRDwbkL/OFTw23RKBjMeAsX4WiYd9bHL2OpYlrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBMBHWWFkQ8U+qoJvwj7L/LHujnKwHKkQ6uF33IvtXk=;
 b=rYSeOEH18PhdtT8MffvimtBEvA+gyyqdA6wCeiZx0cA/qxqztwv3OTVng0bX8pioUXSikH1axrt+t+4KAATEABynj2X84qb48R8k2c6fW4dLiZb6nUKpsQdIzUZLwr/vGG2gBpOnOskjkBoJIWbOdYQrV32vMr04d3V2v4IiVLw=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4527.namprd10.prod.outlook.com (2603:10b6:a03:2d5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Mon, 1 Feb
 2021 18:08:56 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3805.027; Mon, 1 Feb 2021
 18:08:56 +0000
From: Chuck Lever <chuck.lever@oracle.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH RFC 0/9] Possible set of VT-d optimizations
Thread-Topic: [PATCH RFC 0/9] Possible set of VT-d optimizations
Thread-Index: AQHW9X3P7zvDZBiDE0+m/+38KuQxRqo9H4uAgAaAFIA=
Date: Mon, 1 Feb 2021 18:08:56 +0000
Message-ID: <7D8CECE1-3308-4A9F-8300-49E95A3EF24F@oracle.com>
References: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
 <1c89a1c1-4a2b-841e-c88f-cd08598a6546@arm.com>
 <C8B06FC7-F426-4008-8A71-E61895368771@oracle.com>
In-Reply-To: <C8B06FC7-F426-4008-8A71-E61895368771@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c34057c-26b9-46b3-456b-08d8c6dc70fd
x-ms-traffictypediagnostic: SJ0PR10MB4527:
x-microsoft-antispam-prvs: <SJ0PR10MB4527AEF65F05F393629B68F393B69@SJ0PR10MB4527.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jCKD8lDWl1WvFZTqey+FcFTmzvoIop3fbgz9oX9PAA5PJQ8XoXKivQMLfPWAjVkzkWT3Wvm1NYmJCBTE7vl2mzNnWz3RIbfo6b71eJgsPIlviQbj7NVfGimo59Y9Gg5NzK8jNaaacr1NKP+v+IamNLYuzxZJJ6Sowf4sbhMHYhlsAwVWoZeakODBVoG+QQ02+RS9V1zdyJJ58TDPOiTDmc1lbdIODS5GmBvLLmYnsp/YfbHEIsRSM8mIPhZUqUPyV8Dys448/3xERS3d5daxVWXZ2TdH7N4AMaznrlN6TA/FwZe96hdW2sqMENKBmQ8xxUhB8VZJhKfL/q03NYAb2SWfAY28TIEIUnWR4rQK6cE46Vu6LUGtVDqVWInC12MO5b7XH6FEoRKyMURgWZk467nrjFvQ7jaZA+8ABqXjx+Rp6lJSEQ6fEO9VZ36pH46jQsTaDSL6hO1bvTFuzqPujkBM1CkeUu6+i0UyvZVLIaK+SVHqnDFrM5sL80hYO/C7NpH77C92KZyoTySNK9XdzajmgdcyG9pV4djcOlloIEZley45LmBWZugtf866GBWmwD5plILGm+mXlN3b6cGbLjlMmXln/3QuChHSJtpwWuTzKkdF1OYKWJnSek7Z+Y46hR7FjZInoxkOEXs9DoZvXFCS7ThPuOSHwOG/FExWh94=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4688.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(376002)(346002)(136003)(39860400002)(396003)(6512007)(83380400001)(478600001)(36756003)(53546011)(6486002)(2906002)(33656002)(8676002)(26005)(6506007)(316002)(86362001)(4326008)(76116006)(44832011)(66946007)(2616005)(91956017)(186003)(5660300002)(66476007)(71200400001)(66556008)(64756008)(966005)(6916009)(8936002)(66446008)(54906003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3ZHniJSHYtc/w/w4rZUG7GdM/crtKCPNZ0g9i3r2ge+AXMAb+Deo+1y7w41C?=
 =?us-ascii?Q?QRmSje7tUfc7OW/rzF+lejjiO4c3d6znQg443z5h4mHcuYKPgVQxueHdmy91?=
 =?us-ascii?Q?X2FA2fSI7wtq7Na/0M8UMxuaPLrPr3QNB4S135fbJmeolBAYKBD8WtILEiwn?=
 =?us-ascii?Q?c9vEZAB93yCGTY0JrHRNOOD3wadPHCz0bhDwsfkZQfpv9b4qDobexXOqWWJH?=
 =?us-ascii?Q?2uKJR316QL4h0sgSD3mqBmhG79frBGSb5348p8DzA2ebGkBr0PkB8astbu3u?=
 =?us-ascii?Q?ga24bdpw29mn9sCvG9xxNfMnaXpLh4d1NLOnF6VHONYNwfBz15un6zr9jaCo?=
 =?us-ascii?Q?XgI30Tan10+PvoPKDWGDHD942Q2dPBkUaQvV8hmLH9thMg45Zmfa5m07FFdW?=
 =?us-ascii?Q?G8Gfot/WhDfJ6iV2zAuY2EreOSxTEfz9Qxyw7mDTpfu3xNaBXB+LwvoayW1i?=
 =?us-ascii?Q?BFlEDPkdRXWiaSNqylJXz9r82qhcrUtbYdm2WXcrZ5u1dag5Amq6vBH0uU0b?=
 =?us-ascii?Q?QhGqd80rT4yKU5ImIlj8HXBpygb3vTnXALq2KGPw1AQMOuSfhgG4vGGZfRNG?=
 =?us-ascii?Q?YU2ST1NLJrvBD0t2+TykpTSXRZUAy2A4fJi5z+gBlsOxXJCD1pMXasUpQIOv?=
 =?us-ascii?Q?N9XSU7YXfeI/UKrzmVbQAmoXv3Twq6pd9XPXBCIuHy27letgD2M76o1W5Dyo?=
 =?us-ascii?Q?qQfO0ITxNVboFv92OrEhI2GHtIGU2vPMwtqaQdghQzDODpq0+p5BFK/F+vwC?=
 =?us-ascii?Q?LDKMXXeypCb6TSVjDlds78BVRF4xSGDX9Oh3UGQ2x8aFbGmhaBAcCganLn9O?=
 =?us-ascii?Q?agV8B0UrmTtzk/ORXHU8j4807jdQ9Jy6BmljagS7LpOSMkIRhw1DidaM2A1u?=
 =?us-ascii?Q?y5vYcsadepuRVfj3oGp78DlShqdVfoETLdh6H25pv8zz9TBoCAlFQyfIBdQI?=
 =?us-ascii?Q?3kbCNVd1yF0OX4QF3f0WWIcVTlaq5L37t4Dd5r2MRO0FnpKhJmUcPg96D66Z?=
 =?us-ascii?Q?q7WkAX/WGBQdHR5glaRE6Kn1d8MgjjqdkS1DglH5QmSE+yVvqDBHKASYQD21?=
 =?us-ascii?Q?ZJwdbdQjLBFHM/h4ZTU+mL/SGedkHw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <9B69208DEDFB584C96006C06F12E86C5@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c34057c-26b9-46b3-456b-08d8c6dc70fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 18:08:56.3138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n007X0ejBnpkDhSEgroO7T2QhYpbeWiUX0GuQymVWnrbCCazSwKiYFmLOAsqdEEYjnJpu8gAnvCg4NWHxwbkAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4527
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010094
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010093
Cc: "isaacm@codeaurora.org" <isaacm@codeaurora.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "will@kernel.org" <will@kernel.org>
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



> On Jan 28, 2021, at 9:52 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
> 
> 
> 
>> On Jan 28, 2021, at 8:59 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>> 
>> On 2021-01-27 20:00, Chuck Lever wrote:
>>> Hi-
>>> This collection of patches seems to get the best throughtput results
>>> so far. The NFS WRITE result is fully restored, and the NFS READ
>>> result is very close to fully restored.
>>> 	Children see throughput for 12 initial writers  = 5008474.03 kB/sec
>>> 	Parent sees throughput for 12 initial writers   = 4996927.80 kB/sec
>>> 	Min throughput per process                      = 416956.88 kB/sec
>>> 	Max throughput per process                      = 417910.22 kB/sec
>>> 	Avg throughput per process                      = 417372.84 kB/sec
>>> 	Min xfer                                        = 1046272.00 kB
>>> 	CPU Utilization: Wall time    2.515    CPU time    1.996    CPU utilization  79.37 %
>>> 	Children see throughput for 12 rewriters        = 5020584.59 kB/sec
>>> 	Parent sees throughput for 12 rewriters         = 5012539.29 kB/sec
>>> 	Min throughput per process                      = 417799.00 kB/sec
>>> 	Max throughput per process                      = 419082.22 kB/sec
>>> 	Avg throughput per process                      = 418382.05 kB/sec
>>> 	Min xfer                                        = 1046528.00 kB
>>> 	CPU utilization: Wall time    2.507    CPU time    2.024    CPU utilization  80.73 %
>>> 	Children see throughput for 12 readers          = 5805484.25 kB/sec
>>> 	Parent sees throughput for 12 readers           = 5799535.68 kB/sec
>>> 	Min throughput per process                      = 482888.16 kB/sec
>>> 	Max throughput per process                      = 484444.16 kB/sec
>>> 	Avg throughput per process                      = 483790.35 kB/sec
>>> 	Min xfer                                        = 1045760.00 kB
>>> 	CPU utilization: Wall time    2.167    CPU time    1.964    CPU utilization  90.63 %
>>> 	Children see throughput for 12 re-readers       = 5812227.16 kB/sec
>>> 	Parent sees throughput for 12 re-readers        = 5803793.06 kB/sec
>>> 	Min throughput per process                      = 483242.97 kB/sec
>>> 	Max throughput per process                      = 485724.41 kB/sec
>>> 	Avg throughput per process                      = 484352.26 kB/sec
>>> 	Min xfer                                        = 1043456.00 kB
>>> 	CPU utilization: Wall time    2.161    CPU time    1.976    CPU utilization  91.45 %
>>> I've included a simple-minded implementation of a map_sg op for
>>> the Intel IOMMU. This is nothing more than a copy of the loop in
>>> __iommu_map_sg() with the call to __iommu_map() replaced with a
>>> call to intel_iommu_map().
>> 
>> ...which is the main reason I continue to strongly dislike patches #4-#9 (#3 definitely seems to makes sense either way, now that #1 and #2 are going to land). If a common operation is worth optimising anywhere, then it deserves optimising everywhere, so we end up with a dozen diverging copies of essentially the same code - particularly when the driver-specific functionality *is* already in the drivers, so what gets duplicated is solely the "generic" parts.
> 
> I don't disagree with that assessment, but I don't immediately see an
> alternative API arrangement that would be more successful in the short
> term. If 4/9 - 9/9 are not acceptable, then the responsible thing to
> do would be to revert:
> 
> - 58a8bb39490d ("iommu/vt-d: Cleanup after converting to dma-iommu ops")
> - c588072bba6b ("iommu/vt-d: Convert intel iommu driver to the iommu ops")
> 
> for v5.11, work out the proper API design, and then try the VT-d conversion
> again.
> 
> IMHO.

Are all y'all waiting for me to post such patches? ;-)


>> And if there's justification for pushing iommu_map_sg() entirely into drivers, then it's verging on self-contradictory not to do the same for iommu_map() and iommu_unmap(). Some IOMMU drivers - mainly intel-iommu, as it happens - are already implementing hacks around the "one call per page" interface being inherently inefficient, so the logical thing to do here is take a step back and reconsider the fundamental design of the whole map/unmap interface. Implementing hacks on top of hacks to make particular things faster on particular systems that particular people care about is not going to do us any favours in the long run.
>> 
>> As it stands, I can easily see a weird anti-pattern emerging where people start adding code to fake up scatterlists in random drivers because they see dma_map_sg() performing paradoxically better than dma_map_page().
>> 
>> Robin.
>> 
>>> ---
>>> Chuck Lever (1):
>>>      iommu/vt-d: Introduce map_sg() for Intel IOMMUs
>>> Isaac J. Manjarres (5):
>>>      iommu/io-pgtable: Introduce map_sg() as a page table op
>>>      iommu/io-pgtable-arm: Hook up map_sg()
>>>      iommu/io-pgtable-arm-v7s: Hook up map_sg()
>>>      iommu: Introduce map_sg() as an IOMMU op for IOMMU drivers
>>>      iommu/arm-smmu: Hook up map_sg()
>>> Lu Baolu (1):
>>>      iommu/vt-d: Add iotlb_sync_map callback
>>> Yong Wu (2):
>>>      iommu: Move iotlb_sync_map out from __iommu_map
>>>      iommu: Add iova and size as parameters in iotlb_sync_map
>>> drivers/iommu/arm/arm-smmu/arm-smmu.c |  19 ++++
>>> drivers/iommu/intel/iommu.c           | 131 ++++++++++++++++++++------
>>> drivers/iommu/io-pgtable-arm-v7s.c    |  90 ++++++++++++++++++
>>> drivers/iommu/io-pgtable-arm.c        |  86 +++++++++++++++++
>>> drivers/iommu/iommu.c                 |  47 +++++++--
>>> drivers/iommu/tegra-gart.c            |   7 +-
>>> include/linux/iommu.h                 |  16 +++-
>>> 7 files changed, 353 insertions(+), 43 deletions(-)
>>> --
>>> Chuck Lever
>>> _______________________________________________
>>> iommu mailing list
>>> iommu@lists.linux-foundation.org
>>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
> --
> Chuck Lever
> 
> 
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

--
Chuck Lever



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
