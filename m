Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23C1C2D0A3
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 05:51:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C6220867
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 05:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emerson.onmicrosoft.com header.i=@emerson.onmicrosoft.com header.b="suZ4fnNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C6220867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emerson.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 322BA8672F;
	Fri,  6 Nov 2020 05:51:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SHEKn6eBXS-b; Fri,  6 Nov 2020 05:51:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 87148866E5;
	Fri,  6 Nov 2020 05:51:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66C49C088B;
	Fri,  6 Nov 2020 05:51:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0B95C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 05:51:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5FCCA20398
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 05:51:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LJJ50mXsOLEO for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 05:51:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com
 [148.163.146.64])
 by silver.osuosl.org (Postfix) with ESMTPS id 0115720353
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 05:51:20 +0000 (UTC)
Received: from pps.filterd (m0142705.ppops.net [127.0.0.1])
 by mx0b-00300601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A65o1xA109860; Fri, 6 Nov 2020 05:51:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
 by mx0b-00300601.pphosted.com with ESMTP id 34n0b7g65t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2020 05:51:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRB2WS3rpZ1Fh3KZZeLQ5i1Yb2Vjmk9yuPiaQ1XXrWI8zb0HJWljVRLJl494oOqHyb/odJhboo1ACSR4/nxkz1DgwWxGXE1uJXb1ROZY37jX7IxW67zFAu/UfnbKeSKYHhcCtqANiEbBfkw2OoYIFBbXARFkcJzf1NleQR2dCZsFZ45R5xonFOo2GFjG1mEEnRdUBAmjtgOpbUPNgEBd9wKNg/dFuj7mUXJ1V3Oqii+LiQFc37/vGb4KIPpS1sN7jQO1kxmKKbD45i7z1154dL8iIOthM+gSg3I/d0w0GUB2i5PrD6DYxzyUJppsm2IikIlabLeccmbOtoDYXiaaSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWJtj/KyXdDj/OFFzNExYP3nTbBldSgApSNHoWxotQI=;
 b=Wc22PHSfgrogiu6DSws38zrOBZkEsEt5pHn/ayY1M8frggAiRfRbO0jLEwmv/Zb9As7GF3ussjIxabY3GFkS34AQVE0xcEoCJy+nwChsPS7bDgV6OZI81g8kwNeDb0cpiURASnjra/9PwKugRIzE5O+9nCuigzvSebkhofexAmFY3FToZQY1rqLIiJZEve1jJwk+La+8M3rQeMdzqM343D4T8douph1OC/QHE0i7oCLlCQ5+n85DsPZEVIULWJVMBeaMjZhin+XTfOsggkwBo5EPJQN+apSIEE8dD19q/YtGKeQKZg13dcM8/xxm/CyFO40/MP7a9kx8aYqYeJYkxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emerson.com; dmarc=pass action=none header.from=emerson.com;
 dkim=pass header.d=emerson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emerson.onmicrosoft.com; s=selector2-emerson-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWJtj/KyXdDj/OFFzNExYP3nTbBldSgApSNHoWxotQI=;
 b=suZ4fnNnT6x6qbzc9T8tJBgGy2MP2mYV5e47sbDbCNoslhFOngRIN6vP2phWJFoUpD54SbOAvW+nw0ZUppsc6ER9STkyBmuo7rT5mERV55xVWMfofQTd2ggMxsBWXnso3HAIFzEs9c4YITm98uTZzWjW+AwGTgy+DGWWqG7iC2M=
Received: from MWHPR10MB1310.namprd10.prod.outlook.com (2603:10b6:300:21::18)
 by CO1PR10MB4787.namprd10.prod.outlook.com (2603:10b6:303:94::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 05:51:18 +0000
Received: from MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e]) by MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e%12]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 05:51:18 +0000
From: "Merger, Edgar [AUTOSOL/MAS/AUGS]" <Edgar.Merger@emerson.com>
To: "jroedel@suse.de" <jroedel@suse.de>
Subject: RE: [EXTERNAL] Re: amdgpu error whenever IOMMU is enabled
Thread-Topic: [EXTERNAL] Re: amdgpu error whenever IOMMU is enabled
Thread-Index: Adaux7yL4OYKNrMETgKrPGK8SdhnWADwCzYAAADVBeAAAgZUAAAHYTJQAAGocXAAKw/AQAABvexwAAFDxYAAJDqaYA==
Date: Fri, 6 Nov 2020 05:51:18 +0000
Message-ID: <MWHPR10MB1310C1E8308484E2F7F967E889ED0@MWHPR10MB1310.namprd10.prod.outlook.com>
References: <MWHPR10MB1310CDB6829DDCF5EA84A14689150@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201104085306.GQ22179@suse.de>
 <MWHPR10MB13109574BDA0F1D8219A225C89EF0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201104101454.GR22179@suse.de>
 <MWHPR10MB13108FAFDAD3D33132B6593489EF0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <MWHPR10MB13106AFEA3B68E666DD9CA6089EF0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <MWHPR10MB13107C8A602FD7EE065F4E3D89EE0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <MWHPR10MB1310AA6CDF577A1535600F7089EE0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201105123245.GS22179@suse.de>
In-Reply-To: <20201105123245.GS22179@suse.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=emerson.com;
x-originating-ip: [194.140.115.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7be44c7a-b268-439b-8011-08d88217fb60
x-ms-traffictypediagnostic: CO1PR10MB4787:
x-microsoft-antispam-prvs: <CO1PR10MB4787E585AEECDDB02DB772B889ED0@CO1PR10MB4787.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rpZ/H4EJb+FhPkXn9rhl275z6IS3tULdsLRbxvx7Lq/mOyeNIJZ23UhEYsXt45LDJeqAoBFZcWAvD1vXmqkEAHaUk5GPlDHtXPdHz++vWGliFTNf5qN9M8Yk7EqtQ8n/PvBzBYknqKkOdbCUMm88KdHi5TRvTgzr+Ypt5wnBAYynikyFdZnW2oY8XZHtejlz9tm4vXNoX+hY19+vMsqp+ZHqEMxqX5WNOKHD08iboQdiF8L9+JXut80vMKAARibLkMUEc0HzGPBNL2rQI8LHf68tI6NuChxnNRqT9cUqLLyRzhgfRH1h8nOmafSKCp+l
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR10MB1310.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(136003)(346002)(39860400002)(376002)(396003)(86362001)(26005)(478600001)(8936002)(4744005)(316002)(8676002)(7696005)(6916009)(5660300002)(71200400001)(53546011)(52536014)(55016002)(33656002)(66446008)(9686003)(66556008)(66946007)(64756008)(76116006)(66476007)(2906002)(83380400001)(6506007)(4326008)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Ctpb2yLazFDJph+R+PHX2haN/NHyxx9EIW0PSUUg8We3hD4UXyM3HXKdFS39zvJeLCxc5bY6NlVJt5lmqYPUSDohLXkmD34HYWwh2K+sbijKspWSEhYgf65YaDjgK/nTzoOfRsoCyC9HTUsQ8HtHANSjljub0nFClgdNC3/nY2lftu/1B3QEEVWzsCEJPvVUOvgyUeviafj9DQPhne9AukOX2jhQJZK110NeaBLfUzC11PL4DXyzqSt7c7qq01cey0WTOkhYyJsKny+csBOUHyRdZqZiGiTSu2FB/cTqgRRZ06crsloq2oFWjg/X8YQuqdTfXgtefr8Xx/FMbULsYG7V6OCVqrUOa07pK8TGQo5tb4JbPIn9JBBvptsx9D2jedOOmpwP6BxH3DwwmoIKwFE2g+hZrfF10xXNzumdQx6QyWCPAXcVq8qvfGgQW1OpZ6v18jue+87bcJWFUI/jS1eW+LPKOLYPv4N0R9vllCL5I81yhmwwTbra8B0yqDBCVzg1dRWHexXsVLayI3ecWng+GVCd+VNQMuHER8j93cdF8Ca3crB2XNWIFy90EtjF3HXRHwQwH3fYkqa2CntTiqtIFGteL2rtvwndF9yUPDn/3kxKqnsgKoR7GQrx1uRW1om9bbicqSa7zK2oYeZ4nA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Emerson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1310.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be44c7a-b268-439b-8011-08d88217fb60
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 05:51:18.4879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb06985d-06ca-4a17-81da-629ab99f6505
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CPYszvBD90/66ys9Om+TwijFNaPdCETgmMP9cahIqeidi2ftHo2lbyTBHGPt7Bhb3JuKTo/BiZ1g/EeE1WHnrVMC0r8TG1/4zvObSx7bEIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4787
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-06_01:2020-11-05,
 2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060039
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

With Kernel 5.9.3 kernel-parameter pci=noats the system is running for 19hours now in reboot-test without the error to occur.

Best regards,
Edgar

-----Original Message-----
From: jroedel@suse.de <jroedel@suse.de> 
Sent: Donnerstag, 5. November 2020 13:33
To: Merger, Edgar [AUTOSOL/MAS/AUGS] <Edgar.Merger@emerson.com>
Cc: iommu@lists.linux-foundation.org
Subject: Re: [EXTERNAL] Re: amdgpu error whenever IOMMU is enabled

On Thu, Nov 05, 2020 at 11:58:30AM +0000, Merger, Edgar [AUTOSOL/MAS/AUGS] wrote:
> One remark:
> With kernel-parameter pci=noats in dmesg there is
> 
> [   10.128463] kfd kfd: Error initializing iommuv2

That is expected. IOMMUv2 depends on ATS support.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
