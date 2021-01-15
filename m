Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D95BC433DB
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 13:16:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 024D922583
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 13:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024D922583
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emerson.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A8015870BA;
	Fri, 15 Jan 2021 13:16:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w9A5SRJPvAwA; Fri, 15 Jan 2021 13:15:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5DF5987397;
	Fri, 15 Jan 2021 13:15:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D114C088B;
	Fri, 15 Jan 2021 13:15:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9BD2C013A
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 13:15:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8EE2220397
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 13:15:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wlABY-vFxK7I for <iommu@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 13:15:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com
 [148.163.142.35])
 by silver.osuosl.org (Postfix) with ESMTPS id D91B720022
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 13:15:47 +0000 (UTC)
Received: from pps.filterd (m0144091.ppops.net [127.0.0.1])
 by mx0b-00300601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10FD8igs106040; Fri, 15 Jan 2021 13:15:46 GMT
Received: from nam02-bl2-obe.outbound.protection.outlook.com
 (mail-bl2nam02lp2059.outbound.protection.outlook.com [104.47.38.59])
 by mx0b-00300601.pphosted.com with ESMTP id 3639wb1580-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Jan 2021 13:15:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqn6bhWVc456kaLwTKke6LB8VyqUwg1eDss9QXtzivGvCWH8xJBH/z0xhfLgtxZjPwgnGaePJVLVXxGHkyVdi56Lc/fo0E8dnLUYVNB7u3siqWrA8QQOF8eu5FUFttmn9nWmDJj/1XCQOYN9llY6YJi6zPni/zpgQRiP0l0HA/uwt5MGpDNTLV1oVgUTITdPIOzBkT5YZCJDOhx04emECq9lEHbJ9uShNWRgHIYCHTjP6ZA4sUPlqaHyJxI79POPPNVOn4MLpdOQFtWFYJSd3Ts99zHtV6xZBBYtRrQC1+1XYyhVhjsFmRvQ0RCq29uTfGohbbPA1+ivoJZ5RFY+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVP6HbFoAwb2EnSurfqEX/PHR/5LduQh4amqqfstNmc=;
 b=kVzB3fQgNRWg3lIRrJ8kFGznmKTmAahZDh7PCHcqE3p96bsQjdMhwcpNCozBTzgAC8N+RsOkOq5zu5NTLBs5AJlzKhCUGrfpE20oIv6sPYXWE8lU11YfLq1Q7NUeFGVf63RzGK0XeFnPrABCv6Y+jv+C4cY1+g3MZIqFxyHLwZ4BNPxCC1NtyMofOetSdkFU/mHAgZGrAIIoGEGcNwR3HVCDR4mHaQa8VV836Pu4E0XPXZAP1fA5ncSaa5JrbIUlbUVeDOe1BIo7G0ZIwh9tqw9+9Ul34KvgYdENyyjA25a2HPvocw8g26jxUHmTMd9md2JXYWzxmMV2x40f62uofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emerson.com; dmarc=pass action=none header.from=emerson.com;
 dkim=pass header.d=emerson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emerson.onmicrosoft.com; s=selector2-emerson-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVP6HbFoAwb2EnSurfqEX/PHR/5LduQh4amqqfstNmc=;
 b=iqkWQNC5FQaqI4xgaFSj+yOsT2a5E+D6E7wiCYoGAoxL1JLaI8NzSlV1vAVAtGZWDWQnfr5GiZPKAvVObLWZ70Zj1ErpoMXPrsRkxmxU9rUHsOaIEelczU4OnBDMcIPoCKq2B7mnrjOYnqlOWpjZ7UDBSdEyN0oMX2+wmeBqoAU=
Received: from MWHPR10MB1310.namprd10.prod.outlook.com (2603:10b6:300:21::18)
 by CO1PR10MB4563.namprd10.prod.outlook.com (2603:10b6:303:92::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Fri, 15 Jan
 2021 13:15:45 +0000
Received: from MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::bc5c:45b0:c641:ed30]) by MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::bc5c:45b0:c641:ed30%9]) with mapi id 15.20.3763.011; Fri, 15 Jan 2021
 13:15:45 +0000
From: "Merger, Edgar [AUTOSOL/MAS/AUGS]" <Edgar.Merger@emerson.com>
To: "jroedel@suse.de" <jroedel@suse.de>
Subject: RE: [EXTERNAL] Re: amdgpu error whenever IOMMU is enabled
Thread-Topic: [EXTERNAL] Re: amdgpu error whenever IOMMU is enabled
Thread-Index: Adaux7yL4OYKNrMETgKrPGK8SdhnWADwCzYAAADVBeAAAgZUAAAHYTJQAAGocXAAKw/AQAABvexwAAFDxYAAJDqaYAANk5QAAAF+N6AAAkOogAAAvS+wAAAsw4AAg9wdYALCm/TQCmzcHAAACl7jMA==
Date: Fri, 15 Jan 2021 13:15:45 +0000
Message-ID: <MWHPR10MB1310AF211C45F867FCD04B2389A70@MWHPR10MB1310.namprd10.prod.outlook.com>
References: <MWHPR10MB1310AA6CDF577A1535600F7089EE0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201105123245.GS22179@suse.de>
 <MWHPR10MB1310C1E8308484E2F7F967E889ED0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201106121850.GT22179@suse.de>
 <MWHPR10MB1310A315F2AB752DC789D4E689ED0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201106140625.GU22179@suse.de>
 <MWHPR10MB131028067DF3AB908DEFC08689ED0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201106143235.GV22179@suse.de>
 <MWHPR10MB1310643A00144144FE37505A89EA0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <MWHPR10MB1310F042A30661D4158520B589FC0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20210115081820.GA25634@suse.de>
In-Reply-To: <20210115081820.GA25634@suse.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=emerson.com;
x-originating-ip: [194.140.112.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75388896-dee2-4fde-d6bb-08d8b957ab1e
x-ms-traffictypediagnostic: CO1PR10MB4563:
x-microsoft-antispam-prvs: <CO1PR10MB45637E3E6661E6E40A1AB17989A70@CO1PR10MB4563.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:267;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6jL61B1soFqGvEBcnYDCbRaUyfPfQbduo2T2rQTzL/HgC0jMS0HJZdkFyIThWsppDAxxfca2fFfmcRyShOnMkwIF3bokEkeLceEiselJfOXDs68V3WNIvJfVczqLFgENOfXURwmheHz57U40J/Hz5UuARPrl0pOzpETqQSW9/OJKoAg/Lw+Qn6V5begecwujtQsRiaHaoU8DvJV7DSgGgcc687dJwb1ZSdDjDnF1FDM3XWmLyfEOrcbAwDl++lmt3SySHZC7/fvxe2MQHT6loOvCOPSBo8cZJG9tURcDx1TlfyteHXYUp4bOJUy/iGx0BazYhA/6UqalfXz2vBAJgFR5gvhyInQ5ySSsnSk4E3aB+F1bzvW6cA+hhE0OTHsyM9c8FeCKH6WmlSfxze/AJQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR10MB1310.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(346002)(396003)(39860400002)(376002)(366004)(478600001)(6916009)(7696005)(71200400001)(26005)(8676002)(55016002)(9686003)(8936002)(316002)(2906002)(64756008)(53546011)(86362001)(5660300002)(83380400001)(76116006)(33656002)(66476007)(66446008)(66556008)(6506007)(4326008)(186003)(66946007)(4744005)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?qFMC31QlOFKwKwh+QdShTOWl5Oh0FXZ/d8SY7wDhWmHZpJwNYIVoa5p5ySLf?=
 =?us-ascii?Q?GzIRpRooqopTc9hk7BxXOGknL3GryoKXpkhR9A3Bm1Nr8VACcCx3FQMpYfo6?=
 =?us-ascii?Q?MSyK58/KlGsN+emJxmt5ZgjTd0YutDyvBPsDEDYzt12fE0vUAyUXATARP6BX?=
 =?us-ascii?Q?HywfNIn8f725ZDYkVOkOnR4l/mxz9DapTO5gfgU3bVkr/7Ouk+6ZuvtR8kev?=
 =?us-ascii?Q?yCVsyVjSyhsFbdCLNY6utME2cJnc/EZaJptYMy5fXWuM8UcLXk5c57NesjMO?=
 =?us-ascii?Q?lx/+kXBm0k6guR1hKlB02NVeXiuBIFv4K2bvZ2ZZfzEtdCMkX6uCIEQg4Ipz?=
 =?us-ascii?Q?z8AuDBzMSgVI7VtL6Dr5b72an2zTJ1jHxm/+3DitkEB2fQZo8mA+ivcLwCHN?=
 =?us-ascii?Q?5NtrkRebxhAJ+KGZz95F3eIlxFTUkLluzk2O1dptHew1b/Yb/D5hRCCyt7ZR?=
 =?us-ascii?Q?ohRMSssvwI2XnHyWiMFehr46cPaY2yFNkSQxN1QI0Tc79tXv94pwnstk+PWH?=
 =?us-ascii?Q?Rahmctf44Ohe+sKcrg1iZGgp6OWRrW5C83TkfAURvULoiQitPJvauuUDf+n8?=
 =?us-ascii?Q?ZqJCUt4qhLdv9kJWnq0Evqv25xskyRcsvKJfnS6f6hGV5bYNx7q+dpqnbUmZ?=
 =?us-ascii?Q?+iWB+hpC2n+5BzroZo+d5zgTtSRo8P9+lNn2DS3YntQvFumhxGY2MPqcgJmv?=
 =?us-ascii?Q?0E//x1Jmwuwb04VcDW7pUx31cr6UoRHkxKqQbyKFvSWKH8DJxV7hVkGYfw8X?=
 =?us-ascii?Q?PQvyAtLkvFKunv2RzZPAf3nWH5nrk+notvfYMXy8EZx7+2l0T7dT9lixBUWG?=
 =?us-ascii?Q?K8jYnhA6woWgzUmQ+zf8vXpjyXd2PwZL5wsfkoZtm70L/3xn5joLTfIW263u?=
 =?us-ascii?Q?0yjqu3sPeJ7lTwCjacv80X4Qn67MwpL/AIqEMvGSweN4dupxELwr+aw3DGrj?=
 =?us-ascii?Q?iMDR7WN/st0+jkiZGFzR7/GJClVsS0/9Owqzmd5wTvw=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Emerson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1310.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75388896-dee2-4fde-d6bb-08d8b957ab1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2021 13:15:45.5804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb06985d-06ca-4a17-81da-629ab99f6505
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZFnCJPx/McC/e46kDdezwtcOx3Iz17d8YBifNZ4jwUEhoOH0EzVjB3wjewkEriWMiY16THKBo4aprBntQIPZS+ai2NlIS1OlCoNKf9Rqwik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4563
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2021-01-15_07:2021-01-15,
 2021-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101150081
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

Hi Joerg,

Thanks. Hope you are doing well now.

Edgar

-----Original Message-----
From: jroedel@suse.de <jroedel@suse.de> 
Sent: Freitag, 15. Januar 2021 09:18
To: Merger, Edgar [AUTOSOL/MAS/AUGS] <Edgar.Merger@emerson.com>
Cc: iommu@lists.linux-foundation.org
Subject: Re: [EXTERNAL] Re: amdgpu error whenever IOMMU is enabled

Hi Edgar,

On Mon, Nov 23, 2020 at 06:41:18AM +0000, Merger, Edgar [AUTOSOL/MAS/AUGS] wrote:
> Just wanted to follow-up on that topic.
> Is that quirk already put into upstream kernel?

Sorry for the late reply, I had to take an extended sick leave. I will take care of sending this fix upstream next week.

Regards,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
