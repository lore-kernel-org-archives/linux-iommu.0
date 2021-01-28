Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB02C433DB
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 14:53:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D814064DD9
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 14:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D814064DD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 76F322DEC9;
	Thu, 28 Jan 2021 14:53:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 215P2mDhpwLi; Thu, 28 Jan 2021 14:53:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5A8F721503;
	Thu, 28 Jan 2021 14:53:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C6CEC0FA8;
	Thu, 28 Jan 2021 14:53:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E9E6C08A1
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 14:53:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 72DB62DEC9
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 14:53:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UYsJjyyrE6cv for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 14:53:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by silver.osuosl.org (Postfix) with ESMTPS id 9BE7F21503
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 14:53:09 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SEiLwP053378;
 Thu, 28 Jan 2021 14:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=VTqEF9wQpM5XmwHMGtVqGFRmF08LkDpaqNZ9KQ5gF7M=;
 b=eH4qeJk5ieM9fUY5L2sxSbFX0RfN9IqXxSdVsowNy77qA1J8ifSimsOOtZaOvY65Lfnv
 tBuq1OhQLYIPMgBoxjnvmiTERuKUel2sPYQ7bGsK2TtZs5rnjzR+ZKu0RFaQvWFrGC5U
 ljui1qAbgNy2zFsyOmhaObAcwPHzLeClaYZNuz0bigcR4iJIbogtCSl9Nh+GX8TPAD8V
 xVs04iTDsVeoT56f5bFsg0qXMUswriGByOVSTVTF+W3zX+mjkNk/ZGquoCQ3IDD+0LO9
 xQsI3FQn7nIkIibky2kKK+ZqxOHo3ACJdDEjrBPdHQ40aW+Oxy54qeibSp4nE8AKDz5J 4A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 368b7r4h2t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jan 2021 14:53:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SEjtRh183425;
 Thu, 28 Jan 2021 14:53:01 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com
 (mail-bn3nam04lp2051.outbound.protection.outlook.com [104.47.46.51])
 by userp3020.oracle.com with ESMTP id 368wju5ryt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jan 2021 14:53:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkAQr9CTOujjImzQRPu8lEWO01qtNsLUQLDVJ1Ni1YENmA7EGkDutYlCXA0TnSurbVMEo85yKbfrx6pFjV4ge3l2YtNzjcg2rZwa56nFTzIPj7zlC5hml7UfqopaAWle9hXzc5SAbV6r1icJyunHWnxCrP+9VI94WK9hsuBL5lWlUDkWsOrFBX5ogx/QsZueOeX6JsA3FUwxkGKvWmpa0a8rw12ZuwYJKnoP3X6PXApVwfLVkMRWVj4Niyd7vEZdiKlRhOqvsBRHbvmvmJviv6lxYcGkIYHVxqp8V8DNhWYEwjiwz7AkrFrHKFYMMLFiDBGA1X52vFcfBQfzx2h1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTqEF9wQpM5XmwHMGtVqGFRmF08LkDpaqNZ9KQ5gF7M=;
 b=NRZvnuTiitaFAhcZuoI8gkyL063ucaZ+DGlrdjUxEdKYzlkCv+eQafOlOHxAU9LcyjoU0GWE89pD24AUpE8BA7KUmqyWyxEWon9QDv6EiST+acs0hp7LtPa/jHH0bF4nIMZkjjFE7hhblKlOqaimOtV+MpcD6im4MAucCv8AZLrl+5ceimtaK9tfcpVaJQpr4ttmzRBXsVhRcEzPwqEWDHsJYmRH4p/jCdzfPcYu16l8aDU2YjzWMELMcpv76y2xKk4Extwxph5lgFVJhYQxz0PPvipSKcegNXm0+3HagzxUbHHn4tvU6In1rv1l3tOT3mffjGB6nNLaEcYJph1mzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTqEF9wQpM5XmwHMGtVqGFRmF08LkDpaqNZ9KQ5gF7M=;
 b=F0LvtE53IfMUlrU+HyCEWBfXcwJG5jI7UGLLUc9kuf9wFyJ94nfoGOWr9vA8k8X7ROewIBdcgtxR/sWN3HGN1g1bgATPoU4sd8LYEWcnJHyZe6b4eF1RoFxioEDP2C7dN9Mkel0xC+0ogAeo6l2TU5MDropQxNeBKzWYzNoUXSY=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4655.namprd10.prod.outlook.com (2603:10b6:a03:2df::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Thu, 28 Jan
 2021 14:52:58 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3805.017; Thu, 28 Jan 2021
 14:52:58 +0000
From: Chuck Lever <chuck.lever@oracle.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH RFC 0/9] Possible set of VT-d optimizations
Thread-Topic: [PATCH RFC 0/9] Possible set of VT-d optimizations
Thread-Index: AQHW9X3P7zvDZBiDE0+m/+38KuQxRqo9H4uA
Date: Thu, 28 Jan 2021 14:52:58 +0000
Message-ID: <C8B06FC7-F426-4008-8A71-E61895368771@oracle.com>
References: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
 <1c89a1c1-4a2b-841e-c88f-cd08598a6546@arm.com>
In-Reply-To: <1c89a1c1-4a2b-841e-c88f-cd08598a6546@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e38ddfc-932f-486b-eb46-08d8c39c6706
x-ms-traffictypediagnostic: SJ0PR10MB4655:
x-microsoft-antispam-prvs: <SJ0PR10MB465518AA9CE7C5BCC8D2EDA093BA9@SJ0PR10MB4655.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cCyYkKHY88NGEY3gz6JVRCT/IAPUqu1+pBVxwUena0s7mIEEcrkvrRDsJhtyIzNsRsBI8AfxZ+sd65QnrNd85PsS3vXXj0sa4fxwlKf/HMLb+YD1wBz2M7aCuPBFrSvF6XpRQojOBr67M2EHZ7O2Nm6ENyzhcP10cGSZtP7AAbzJWCqKsp943NCDiASuvgl1jZm9JNMN6D+dOx5ZrhG2jpLnbHsDrEy0gQVp5dvtLcrdwhqJKtbPZ7FV9qmKJCUz6JCVT7OFL+vJQQsqnIqnAqX7EQ4qLa5zKnS8wSvrQvnhDO6dUukj8EmmIsezhOYzsnTpGjbElUJjXxSsAt0pt+B7XtjPtNo+NnVrdNht+G6U+u/GmydbfEaPC4HDF8G6KIGGxujA6fus6ig+O9FR321iDd7N3JeYF45mKytyZvKP71Us5m3QMu4hHBQSF2MJRIPmWnBaq0UPhz52U15QC2YJOunbjGuc0h0nriErv6C8Tfs6txaRt9nC0xI8/+MNTGDRhfOJda+VSLFB9KVnsbZA//RicUkmxfImkU9ZKuWhQahFoWnebjzE8mi5koRwSkLekUfxuP7cpTUSRAMptboE9FLxFZejhrV2iildmczu/uzwJDtFhLArdtBp6MrWNzBoW+etIIUMUdba664SrqDi7JCpPayUN6aAMjST/Vs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4688.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(396003)(39860400002)(376002)(366004)(136003)(83380400001)(66946007)(86362001)(66446008)(64756008)(66556008)(66476007)(33656002)(36756003)(316002)(8936002)(6512007)(26005)(478600001)(71200400001)(6506007)(2906002)(6486002)(54906003)(8676002)(5660300002)(4326008)(44832011)(6916009)(91956017)(186003)(966005)(76116006)(2616005)(53546011)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ZKDdt0ziZHaPT+Ujoh5qyfA/Dchcgfm3Kl5kbUSrymo+pN7b5qTWOB5odiak?=
 =?us-ascii?Q?hphHleGfc4Utv2UzL6M7QLpb/FlV2iBPbZzlsnXT9gfq/yNAQTjqasFkj0u8?=
 =?us-ascii?Q?4gk5MVcM4JTLP2jkfxvaXkhOuYYsgF7tqJXdXTN255Lioqoxya7d2egNPqSV?=
 =?us-ascii?Q?gIdXuJtXWupHPA9HaHhRr9yq6OI96MuO7uz+1smodxrl2lBtcDUNPUW61Y3S?=
 =?us-ascii?Q?j0iVvymgHylgCxkLMR+keTf0jxfW2VqEcGFlz3IH+9AKJkQC4lnrtmCtABRM?=
 =?us-ascii?Q?X08UQcy2lInEYLjRtOxi2hZ/FcbgXGdJx1NiFMkhW2G8ldg+51dUT4iuPe6m?=
 =?us-ascii?Q?lrUkimc0d7SrNi+cI1pqyxuPOm2BNQbcrJZmt/Tndt2SlOCdlsg2w8arhd6V?=
 =?us-ascii?Q?HseTsA6Si7BvV5MgsP2/J1xbn16hjbeaY5sUOkTMfHtKRRTXO/4Xiq3r9VHj?=
 =?us-ascii?Q?ZkyMnU1M0X5xbn3ofgGsYpmIPgl1C45ecD5zX2BQQncXW41dmHKFtJ2lKAw3?=
 =?us-ascii?Q?B5RtdPokVnrK9Hl9VJqz5CFJ/DnaUoYlBHz9ND4x6XfekeZd1Q/Jj02emW8a?=
 =?us-ascii?Q?fwy0kVQhAD2PwZSgUCV0xGdlpOYShDJAET/En6jk4dCNiXF11r+oqmypV0sx?=
 =?us-ascii?Q?lRRf+fe2dDsixC+ZL3oTRlMOl0Hn6sbu7TvU8KfI1JLY5P2mTyFvT7s3Kv15?=
 =?us-ascii?Q?5TYZSIm4aJv6G1IiQjy81BtQecLU/qiq9YN4YkXPQlA9vzwJC1XpUqEWagnC?=
 =?us-ascii?Q?CwkCAwwjptCbWSnaE3n13xUi3suEgMN1CMifbk7Z47msdOYPDm7Dn2WGUjHT?=
 =?us-ascii?Q?AM0PU+oBbZT5zUJ3+0r/Jz2uK7DHto1ZjiXQg0nK/AgsLMD5hIGIKQ097y9v?=
 =?us-ascii?Q?zyiUcr1bo0UHPJ+vF/ncYYXcF3Szs6VuRuyWm8KraT7G8TipRc35mkXumWSE?=
 =?us-ascii?Q?kzhT7ekOTy5YUqXtQtlYeDviu3FYCZKAEhdQQ+rBT7NADSj0tpoeK+VarUMU?=
 =?us-ascii?Q?sfnn/nvC80OIchLXC634aHtYsrXM5yoGPxtrC/aF8Vh7Hlw86cbZOjafiG9h?=
 =?us-ascii?Q?WE6xLH6eXt02EcRo7e2+tcLGH7hQVQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <D6D3BC5EA66D6C468E4CB3486B468B0D@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e38ddfc-932f-486b-eb46-08d8c39c6706
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 14:52:58.2581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dru6q+aGj7nAPtUcW1WKX1K1xbmA2hmMAmIliNTG3x3xWselJ7t8kFubwP7bCRNKWxrRnoXhLL7xJh1F8pbwNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4655
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=956
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280075
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280075
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



> On Jan 28, 2021, at 8:59 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> 
> On 2021-01-27 20:00, Chuck Lever wrote:
>> Hi-
>> This collection of patches seems to get the best throughtput results
>> so far. The NFS WRITE result is fully restored, and the NFS READ
>> result is very close to fully restored.
>> 	Children see throughput for 12 initial writers  = 5008474.03 kB/sec
>> 	Parent sees throughput for 12 initial writers   = 4996927.80 kB/sec
>> 	Min throughput per process                      = 416956.88 kB/sec
>> 	Max throughput per process                      = 417910.22 kB/sec
>> 	Avg throughput per process                      = 417372.84 kB/sec
>> 	Min xfer                                        = 1046272.00 kB
>> 	CPU Utilization: Wall time    2.515    CPU time    1.996    CPU utilization  79.37 %
>> 	Children see throughput for 12 rewriters        = 5020584.59 kB/sec
>> 	Parent sees throughput for 12 rewriters         = 5012539.29 kB/sec
>> 	Min throughput per process                      = 417799.00 kB/sec
>> 	Max throughput per process                      = 419082.22 kB/sec
>> 	Avg throughput per process                      = 418382.05 kB/sec
>> 	Min xfer                                        = 1046528.00 kB
>> 	CPU utilization: Wall time    2.507    CPU time    2.024    CPU utilization  80.73 %
>> 	Children see throughput for 12 readers          = 5805484.25 kB/sec
>> 	Parent sees throughput for 12 readers           = 5799535.68 kB/sec
>> 	Min throughput per process                      = 482888.16 kB/sec
>> 	Max throughput per process                      = 484444.16 kB/sec
>> 	Avg throughput per process                      = 483790.35 kB/sec
>> 	Min xfer                                        = 1045760.00 kB
>> 	CPU utilization: Wall time    2.167    CPU time    1.964    CPU utilization  90.63 %
>> 	Children see throughput for 12 re-readers       = 5812227.16 kB/sec
>> 	Parent sees throughput for 12 re-readers        = 5803793.06 kB/sec
>> 	Min throughput per process                      = 483242.97 kB/sec
>> 	Max throughput per process                      = 485724.41 kB/sec
>> 	Avg throughput per process                      = 484352.26 kB/sec
>> 	Min xfer                                        = 1043456.00 kB
>> 	CPU utilization: Wall time    2.161    CPU time    1.976    CPU utilization  91.45 %
>> I've included a simple-minded implementation of a map_sg op for
>> the Intel IOMMU. This is nothing more than a copy of the loop in
>> __iommu_map_sg() with the call to __iommu_map() replaced with a
>> call to intel_iommu_map().
> 
> ...which is the main reason I continue to strongly dislike patches #4-#9 (#3 definitely seems to makes sense either way, now that #1 and #2 are going to land). If a common operation is worth optimising anywhere, then it deserves optimising everywhere, so we end up with a dozen diverging copies of essentially the same code - particularly when the driver-specific functionality *is* already in the drivers, so what gets duplicated is solely the "generic" parts.

I don't disagree with that assessment, but I don't immediately see an
alternative API arrangement that would be more successful in the short
term. If 4/9 - 9/9 are not acceptable, then the responsible thing to
do would be to revert:

 - 58a8bb39490d ("iommu/vt-d: Cleanup after converting to dma-iommu ops")
 - c588072bba6b ("iommu/vt-d: Convert intel iommu driver to the iommu ops")

for v5.11, work out the proper API design, and then try the VT-d conversion
again.

IMHO.


> And if there's justification for pushing iommu_map_sg() entirely into drivers, then it's verging on self-contradictory not to do the same for iommu_map() and iommu_unmap(). Some IOMMU drivers - mainly intel-iommu, as it happens - are already implementing hacks around the "one call per page" interface being inherently inefficient, so the logical thing to do here is take a step back and reconsider the fundamental design of the whole map/unmap interface. Implementing hacks on top of hacks to make particular things faster on particular systems that particular people care about is not going to do us any favours in the long run.
> 
> As it stands, I can easily see a weird anti-pattern emerging where people start adding code to fake up scatterlists in random drivers because they see dma_map_sg() performing paradoxically better than dma_map_page().
> 
> Robin.
> 
>> ---
>> Chuck Lever (1):
>>       iommu/vt-d: Introduce map_sg() for Intel IOMMUs
>> Isaac J. Manjarres (5):
>>       iommu/io-pgtable: Introduce map_sg() as a page table op
>>       iommu/io-pgtable-arm: Hook up map_sg()
>>       iommu/io-pgtable-arm-v7s: Hook up map_sg()
>>       iommu: Introduce map_sg() as an IOMMU op for IOMMU drivers
>>       iommu/arm-smmu: Hook up map_sg()
>> Lu Baolu (1):
>>       iommu/vt-d: Add iotlb_sync_map callback
>> Yong Wu (2):
>>       iommu: Move iotlb_sync_map out from __iommu_map
>>       iommu: Add iova and size as parameters in iotlb_sync_map
>>  drivers/iommu/arm/arm-smmu/arm-smmu.c |  19 ++++
>>  drivers/iommu/intel/iommu.c           | 131 ++++++++++++++++++++------
>>  drivers/iommu/io-pgtable-arm-v7s.c    |  90 ++++++++++++++++++
>>  drivers/iommu/io-pgtable-arm.c        |  86 +++++++++++++++++
>>  drivers/iommu/iommu.c                 |  47 +++++++--
>>  drivers/iommu/tegra-gart.c            |   7 +-
>>  include/linux/iommu.h                 |  16 +++-
>>  7 files changed, 353 insertions(+), 43 deletions(-)
>> --
>> Chuck Lever
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu

--
Chuck Lever



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
