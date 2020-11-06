Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CB6C2D0A3
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 13:03:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5B9A207F7
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 13:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emerson.onmicrosoft.com header.i=@emerson.onmicrosoft.com header.b="F77666r2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B9A207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emerson.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BD9548687B;
	Fri,  6 Nov 2020 13:03:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PA-NlQPMMESg; Fri,  6 Nov 2020 13:03:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C172F863FF;
	Fri,  6 Nov 2020 13:03:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2F67C0893;
	Fri,  6 Nov 2020 13:03:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA684C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 13:03:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9D03A2E118
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 13:03:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LXEc1ydGj4BW for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 13:03:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com
 [148.163.142.35])
 by silver.osuosl.org (Postfix) with ESMTPS id 537662E115
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 13:03:25 +0000 (UTC)
Received: from pps.filterd (m0144092.ppops.net [127.0.0.1])
 by mx0b-00300601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A6CvwWt185803; Fri, 6 Nov 2020 13:03:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
 by mx0b-00300601.pphosted.com with ESMTP id 34n274upty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2020 13:03:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1mSc0nOFb+yOrFEwExoCqMXMurensktqPbiQALjOXVMZG57iCJWqK9p2B/A6EmqeJYPD+B7764P9lGBxcRTwIfDAYlwhbn/6GZWxP9u28Okuk2JG9F7Y+5Pe0yo09JoVgRN2mWc/D/0fzCrmq59OqR/yh+bjTZCSpNIJJZGYWaDaAKk1UMqKiBiNNJ7lWwQq4A2AZR2RmXmtCostZucAmclhf+UvScBjcbZA4BYhzsQ1snMfeXNhABNnOU8wlKaPqORjn+b6WcMZhkJBTPprpbkm5maHfmZxz47Si4Z0nPjZsbI1F5BxmjpwmV0gaY4e6Aqyy4QqL9m2NKlU730uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwvBmWlXnbT7kbiItXnbglIaHQ+wRMnfJfZnMtieMrI=;
 b=JvhnGcm0c2PGgMzGp5RCnAAJjtBCnhmcPW2FY9ftXH/bGHcHffBHtxk4CuC9MRYifYuTBeyl5p4gjDxh0oF4peLLntTgxQHarNiXtF7TpEN9iTfaMUeiXTkq1K221bifL2CiIKvoRbX4Xf9/HSl4dDENaM9OoSbLZVBK7pooTN0+OhoI+LMCYhZ2rgittdXtLq+Nx9uLzD4w1pKya+B/Wzc7xJlT3y88FFPEwyK7s3haYIgoI4v9dK6vKmA95q4KhrLyGsJxOigi19tazAz6JDK4Sk5Hbp+Hm7rk6FrUJYccC55J6Rpnsu9RoWdVqPp2AAg0nXrv8RF1DTVfIS5k3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emerson.com; dmarc=pass action=none header.from=emerson.com;
 dkim=pass header.d=emerson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emerson.onmicrosoft.com; s=selector2-emerson-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwvBmWlXnbT7kbiItXnbglIaHQ+wRMnfJfZnMtieMrI=;
 b=F77666r2jlWkKe3xPf9KgyHoWLv8a+GJeLkqoTuU8BhDzAw0XhR3L+tW4vGeNrw1+ZpRwyca1oUDQAj54wnO2EKHEnTViuxDDSV662ljU2M8zBwcPAr0NrF27c55V5Qt7dc+qNDzsxPJA+SE3zqbR+tPBRaAX/hTckV8PLT1xnQ=
Received: from MWHPR10MB1310.namprd10.prod.outlook.com (10.169.232.146) by
 MWHPR1001MB2141.namprd10.prod.outlook.com (10.174.170.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.30; Fri, 6 Nov 2020 13:03:22 +0000
Received: from MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e]) by MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e%12]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 13:03:22 +0000
From: "Merger, Edgar [AUTOSOL/MAS/AUGS]" <Edgar.Merger@emerson.com>
To: "jroedel@suse.de" <jroedel@suse.de>
Subject: RE: [EXTERNAL] Re: amdgpu error whenever IOMMU is enabled
Thread-Topic: [EXTERNAL] Re: amdgpu error whenever IOMMU is enabled
Thread-Index: Adaux7yL4OYKNrMETgKrPGK8SdhnWADwCzYAAADVBeAAAgZUAAAHYTJQAAGocXAAKw/AQAABvexwAAFDxYAAJDqaYAANk5QAAAF+N6A=
Date: Fri, 6 Nov 2020 13:03:22 +0000
Message-ID: <MWHPR10MB1310A315F2AB752DC789D4E689ED0@MWHPR10MB1310.namprd10.prod.outlook.com>
References: <MWHPR10MB1310CDB6829DDCF5EA84A14689150@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201104085306.GQ22179@suse.de>
 <MWHPR10MB13109574BDA0F1D8219A225C89EF0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201104101454.GR22179@suse.de>
 <MWHPR10MB13108FAFDAD3D33132B6593489EF0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <MWHPR10MB13106AFEA3B68E666DD9CA6089EF0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <MWHPR10MB13107C8A602FD7EE065F4E3D89EE0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <MWHPR10MB1310AA6CDF577A1535600F7089EE0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201105123245.GS22179@suse.de>
 <MWHPR10MB1310C1E8308484E2F7F967E889ED0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201106121850.GT22179@suse.de>
In-Reply-To: <20201106121850.GT22179@suse.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=emerson.com;
x-originating-ip: [194.140.115.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 751d3da3-f33a-42f0-5de0-08d882545769
x-ms-traffictypediagnostic: MWHPR1001MB2141:
x-microsoft-antispam-prvs: <MWHPR1001MB21417037986DB260E5B646AB89ED0@MWHPR1001MB2141.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kO8NlCM+/Eh0bWTvB4hhudYpz1YdTU6BjWEyacAa58qvipS2kbTzl9Io5ZQ4OMh4eOJUslN1VF/y2eTTa4kfhhXN+mshwJYcz5gFRYrh73ev7BJjKDUZbdVFcfnD4psN+Ww8/YHoIrPGMchAn3j+TsY2MgqldtadZmCu9pTX8MdWQJiE9jW4Xc4sqD4FKkw6PH7m10r9QO5vtdo9gl5n7NySGbI3ksGy1TJcj1IaJCc12YhY0dNtL4ms2tXwfBqXTuC/6dfWnz8ZpzLSvdN3IcolvibaZFStTull6zXg8A3JdNbAROifsB/zBJkm+xU0utdFZq+Wp1WJNK30UBuKxQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR10MB1310.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(136003)(366004)(346002)(39860400002)(376002)(6506007)(86362001)(64756008)(66556008)(26005)(76116006)(66446008)(66616009)(66946007)(4326008)(71200400001)(7696005)(33656002)(52536014)(99936003)(4744005)(478600001)(6916009)(83380400001)(5660300002)(53546011)(9686003)(8676002)(186003)(55016002)(316002)(2906002)(66476007)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 9HWo3gO7p39jfeobZGMpf5cJDLUyfsb/n/XvIZvz7CBb8BYlRjlYCfU3VeZYzuDIkPwtOKVdIwFWXDp4XWiJSx4li2Euz4zjooZjvkjWN6OafxDYVtDZoq4g6EjiClnwvAIr/1TLqEpOUCDPEq4bl6g0NNq8Vg0X4Drn84HKHDlBB+ZjU7Rprkxi+WWg8/WJh6bKeI7adaNVExmwqgkK7tp+hSg1z19WWDWBJBj4NC1fY5WJ2KOSK617B5urWaGYQXqEVYcQDR9CwhGl7g5NiPg0dS1NJSoGEa5HHcXm2+43jPTuIo9+rZmuZRjQyvL8yN4KQ01tuGW+xHw7hki/SD3cO3EFAoSlDgp0AmEBnG47bQqll/8Yg561VH4bQ39FqtACHbBO0isVzK1RQELsUJIlYX+G9V8ZO+oefg3dSZ5+lWxYrTgzvQNczUeXickSpLdSTQqgjcF3PH0Hi25wE2IvY/OsZY8qFDqb2kQNnPP+16SLAcGWVAbrdRy4vQyEIjhjVfiZSh7LIJ+Muc1HYt5cDxL20/NZosYYfcFvOlmollbYM0ZgP8OVS/m7vR6k7FkIRKy74feARZwu35UYz0qJqMrocKfWzc9Gb5rSDGEpM9XKiQb5MdJzOoQY1OEuxmfHxqEA4LCppJkHFPl/Lg==
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
 boundary="_002_MWHPR10MB1310A315F2AB752DC789D4E689ED0MWHPR10MB1310namp_"
MIME-Version: 1.0
X-OriginatorOrg: Emerson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1310.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751d3da3-f33a-42f0-5de0-08d882545769
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 13:03:22.6882 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb06985d-06ca-4a17-81da-629ab99f6505
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dyQv8BUY2JCyTLPOldBlxnBJvc5WUdXQbg/M1HGO785DAdJtvcTstOZOBm37AjbMe9p5NBlnfyuqvBNJWYa1L79A0snS2hEo3FnWYeau0LQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2141
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-06_04:2020-11-05,
 2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011060091
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--_002_MWHPR10MB1310A315F2AB752DC789D4E689ED0MWHPR10MB1310namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> Thanks. So I guess the GPU needs a quirk to disable ATS on it. Can you pl=
ease send me the output of lspci -n -s "0b:00.0" (Given that 0b:00.0 ais yo=
ur GPU)?

Thank you. I do think that this is the GPU. Would you please elaborate on w=
hat that quirk would be?

-----Original Message-----
From: jroedel@suse.de <jroedel@suse.de>=20
Sent: Freitag, 6. November 2020 13:19
To: Merger, Edgar [AUTOSOL/MAS/AUGS] <Edgar.Merger@emerson.com>
Cc: iommu@lists.linux-foundation.org
Subject: Re: [EXTERNAL] Re: amdgpu error whenever IOMMU is enabled

On Fri, Nov 06, 2020 at 05:51:18AM +0000, Merger, Edgar [AUTOSOL/MAS/AUGS] =
wrote:
> With Kernel 5.9.3 kernel-parameter pci=3Dnoats the system is running for=
=20
> 19hours now in reboot-test without the error to occur.

Thanks. So I guess the GPU needs a quirk to disable ATS on it. Can you plea=
se send me the output of lspci -n -s "0b:00.0" (Given that 0b:00.0 ais your=
 GPU)?

Thanks,

	Joerg

--_002_MWHPR10MB1310A315F2AB752DC789D4E689ED0MWHPR10MB1310namp_
Content-Type: text/plain; name="lspci-n-s_0b_00_0.txt"
Content-Description: lspci-n-s_0b_00_0.txt
Content-Disposition: attachment; filename="lspci-n-s_0b_00_0.txt"; size=33;
	creation-date="Fri, 06 Nov 2020 12:49:35 GMT";
	modification-date="Fri, 06 Nov 2020 12:49:35 GMT"
Content-Transfer-Encoding: base64

MGI6MDAuMCAwMzAwOiAxMDAyOjE1ZDggKHJldiBjZikK

--_002_MWHPR10MB1310A315F2AB752DC789D4E689ED0MWHPR10MB1310namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--_002_MWHPR10MB1310A315F2AB752DC789D4E689ED0MWHPR10MB1310namp_--
