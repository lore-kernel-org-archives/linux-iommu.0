Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62ECEC433EF
	for <iommu@archiver.kernel.org>; Wed,  9 Mar 2022 12:53:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C10941555;
	Wed,  9 Mar 2022 12:53:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k5D69j_IKr5D; Wed,  9 Mar 2022 12:53:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CEFA640270;
	Wed,  9 Mar 2022 12:53:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E68AC001D;
	Wed,  9 Mar 2022 12:53:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9902AC000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 12:53:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 71E5460804
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 12:53:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="ziEDTjFr";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="Zhygkgr5"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jzxkBWuhcpAg for <iommu@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 12:52:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1B1F1607F6
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 12:52:58 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229BLSBX028053; 
 Wed, 9 Mar 2022 12:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=z4tnHDnlpD0pocU34zdnbJbM7rvA3eBHc+OJXXeoVv0=;
 b=ziEDTjFrPs9wmJ/PpQLmx5gO+XgUFaofrht6Y7Zr0xydTUWlv5DxHkH7w2ijZWWSA20T
 BO69IJxig0cHZJZDUOoFLXapInKiMohBE1TSWWqBhzcgJ65gZS5SyJJxSA+R25vcA0Zx
 Yv1v/pTydSXfJzB9xE16AeEdctEizezAA52DmrQV908pv/gz0vesIiUmOmEKQEvCbkC5
 RTJw7bBdhONVC39uURVW3Sy+odcpxSytA9SRV9pEYn1bYgk03Si99/GGqR8quj4l1gPR
 TiGcqZiX4tJVYVJsgf3QcjtyI9YTmKU0AkEltRAn4hOcTQFV3b0UapnfEgyBWgUWoN3P FQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2j2t9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Mar 2022 12:52:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229CjhhG096375;
 Wed, 9 Mar 2022 12:52:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
 by aserp3030.oracle.com with ESMTP id 3ekwwcst32-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Mar 2022 12:52:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kc32BgwHKKIrNK02G4fWqNbava9Btbaou92zUvV8BRtu+d08OLZAhb1KIJIDCXGRGy24WQbMku0GUa4t7AeEeYw1fIKI94W/ZOEvnHoK90+W2wn8pyidKk0G1R5ikcgJijMw+G35Pb3W4oKaVO/9mnfefJFyHTlZpEgcoMP4BWrGibhif/bBqy/kpZVjpRVUY+RT+eo9DPrnrI+xCGN1xIQFa2yh+HpHe95HWigOzWaPnjms0ca2hQtdQKhU/h27XsTssEuatnkwDRWX9huIoe1AF3vr598dsly/7jncehdnbmXX039PZbg1isT/nQEqh5NU3tDLbLpAAESiIvw4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4tnHDnlpD0pocU34zdnbJbM7rvA3eBHc+OJXXeoVv0=;
 b=BXqNG+A70uGCeFgAi3wjkRJ4AQmwUNgSANRx4Cpf0TnDW+4YObahYEMfW0EHsG6tbyJbQFuGDFUAcytiPsBfgzLtrWMAP0Dmte84lRu4ReWTBSbGm6Y94LYh7oTx9PamXSipJs4sW2MJMirpkP1LxVewGDLFCZUsKB66U7a8U015lCVg8jS7T/OqKxB1OomAF2AcQuYws6/J/y8JpNidxHNihtg86VgxEkEnBIJNZfVt7yEhuWBJZvon5s1Sv+oCLhGL8WFl3LLpTqtLBrrOMkKytTISpZ9dGuRWgwFZVFb+o+objUIpo7SNv7NPC75fVQR5nhOMcAPI5B33+iUkQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4tnHDnlpD0pocU34zdnbJbM7rvA3eBHc+OJXXeoVv0=;
 b=Zhygkgr5WEFDzpoOolYhAdS1nEAoXKiRFx4oc35u9LTKK60kyfDl1X6cnJ7uga5x7lqxgn6pX5a1Af5SydArEP+yX1Z2RUJWNxlp86whVT7s0Joe0NqxAaOtGzdm0oX5rl2AZWTm8Eqfs/CfyZWDFoIlOK5a+8XAjeq3qQMqAiw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR1001MB2155.namprd10.prod.outlook.com
 (2603:10b6:4:2d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Wed, 9 Mar
 2022 12:52:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5038.026; Wed, 9 Mar 2022
 12:52:51 +0000
Date: Wed, 9 Mar 2022 15:52:39 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: suravee.suthikulpanit@amd.com
Subject: [bug report] iommu/amd: Improve amd_iommu_v2_exit()
Message-ID: <20220309125239.GA11530@kili>
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0019.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::6) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d372bbd-c77b-45db-f311-08da01cbb814
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2155:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB21554CDD8AFE03C2158655458E0A9@DM5PR1001MB2155.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HFwOEnv0sYvbIW9LONJvpNfWXPkxIb1d62BrSvh7QAAZ5HQudR7diNy1Pb7FgEC4uKI8g7uBk+nwH2vsVjPHYGP59hit+3pQRfirVOGRVh4rsSmp098gksH8n8JZm1KKOlWk3ztT3zdojzVexzEGjpxzoVFxGvd59DoeCJOCem/T/11nZ4/l6V5hk3DUUzWB0l4bZYJzHOznatKdL71Y04uVb51kzaSmutmmQ6ZcTZx/GnBV971QLviR7RiInQ3yJlsgND5U6yyVePTuKfj+yy4ozwZJC/c/ys2I11YN8Opf95BXv5hSFbcoKFSbl+BnIMD0OeNK3ss5StFq8FaOwDpUpVKrc4DgkyFsVsCzG5wCwftteo2L1ZUJ8vnNMGSP9kFSAxteRYf643HcpiRZnpAGGWsTRm28pUHDRKpeDToyQlP1elg5bv5mj3j2Q+teF65GWBx/r48UIEpDxYJToiDibi51EFd3RAaLS7OEULi8pPg3tYWGiUfOyiskQsjWKF7YCKwuOJQQ1KAP8p6lPCSw9c0P+R0y+YmnUjaXiTulmoO0Glcxe/7NGtlhdeoVMtMBXa2mr/hMmg0ylO5GkTWoV92dsBtWHmkhl1SOsGBOVgBLIg7eCR5t+0VIXyJpNSbQ/uGsHN2nFm4QIqU91a3kaH/C78a/rePcWy/D/bALOdNX0Q28O4YHwBD26LJ03nLBAgPlNO0Tax2o6JvfwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(86362001)(6916009)(8676002)(33656002)(8936002)(316002)(2906002)(33716001)(4326008)(44832011)(38100700002)(66476007)(38350700002)(6512007)(6506007)(9686003)(5660300002)(6666004)(6486002)(83380400001)(1076003)(66946007)(26005)(186003)(508600001)(66556008)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vhqfcmCa6zHMPZVnRRr6ASYQZuq/OKJ7RLlBPz5VXOchooE/a/ybvB0tHU2P?=
 =?us-ascii?Q?sN9Ler12NajT6mK/D4akDXqSgUTWfAKBEONQT6RvQwGeYqMuRoqIek10PdPg?=
 =?us-ascii?Q?fSCOzYosYT/YygzpK8plGPHVvMQwDOVoqciswEQEKZRpbo9BKbCva3kR+7VN?=
 =?us-ascii?Q?IiIkZSCL+PHkh9R1cpdCanma6mIfWSK6/KQbKghCVoDxGTvAe6yosDUHnGnP?=
 =?us-ascii?Q?1Ly4rqSxSEkAVuPRO/TX1/9N6ArUBJkaEzn4u0f+aIzp7nyMEV4xr+H7J14g?=
 =?us-ascii?Q?3sSzGNEGjR8VgI1zw7+NMpMkTzd8WErVDiCIosCGpyC6YjeAuvqpLiGvA53i?=
 =?us-ascii?Q?LsEafrexh+CXluVAUDLChTJtCSp0Z6UoLx2HWao/N0z6M+eRHGE3N/I6BYsO?=
 =?us-ascii?Q?TquHL0xeg2G0DG0ceHG0kZHMfrlTOqagR+Dqyuu1umqqnJ9UoCZJV8hNNi7H?=
 =?us-ascii?Q?HMhwSoXZ+zU2yJRNCXzGvRuYkBlrsHrKZJYTytEYd2IAg3E92n+yBS5x+xu6?=
 =?us-ascii?Q?V5xsPUEx5yz37NXtW7ihR0kal9633I4s36uwXeEDQTo2d4GgrT0nU001yAt/?=
 =?us-ascii?Q?xhCRuU1zL/G2mMdbH5pElCeQt+GYnrKFx3BntKlq1u6olrHTc/bnwYUNrw2Z?=
 =?us-ascii?Q?YHdckHPtGgkbGcj584Bi56W74fpOXkA75LhgQVk1iuXUY74UzMu+2AgMGf8o?=
 =?us-ascii?Q?auCI+oi+s/NDYpJvuYkfHbdgkajS6XJ+QjtnS1ahQ2wwcTMWRy4HAdAU06Qg?=
 =?us-ascii?Q?Cxwo5G0lK+XeyOqXp5IsaP62cIDvsPYksnV3rKDTMRMWQtR/MYB+IRmvbfue?=
 =?us-ascii?Q?5TaExhaJiYdtnr+6BKm0iJnlY8cltXe7iA4pYUasR3MNfPTsZFU1efbgF1TJ?=
 =?us-ascii?Q?MZvtO6gahU1AvaLz4PlkCPbE1SlsOVwhqEAIwEbeBJlQ8G7p9eppM6t/t1ly?=
 =?us-ascii?Q?rxW7SKAP2/2To5vyOrVvCKTFM6kAvGQ1Oemi7KtEhfZPrBLysqvmVbDiOWgD?=
 =?us-ascii?Q?OoBA5hyfDUjXuEjleC3Qkc2s8Ahz5RUdnvtRDMiirW04Lk+wah38V/0QK8NP?=
 =?us-ascii?Q?RAdkXxHY7YXmgE9i0dIPjIGxAI8WAVFaDJA4rtxvTsOHBACTEkJzneyEM8Wu?=
 =?us-ascii?Q?aM0lBYW+0ueWZptp8R91tX47B77/HifD543Y0RTBRVBBbo2AEuRq78ANduM6?=
 =?us-ascii?Q?d5VN7/0c67pMminLEqC8cJjjlColp9an16GAyPkCPrBltiLJ8Y/q2IhUITu/?=
 =?us-ascii?Q?U/PCwEtqfS2ecvzkBZTp8HnLlFG/6lDMmihYXKQazDdiEHEoTqmNs2T97qCV?=
 =?us-ascii?Q?niTuMy8rx5ejRga88qPFbT4lsBaEfGaoP7CMfOFCv38CWWlEJ2r17ugxww4D?=
 =?us-ascii?Q?6DDfrZNf5SX05RpZsiFGIbCi+WuQUbCiJGRi4HQ2gM1CJIPB2wRj/M5lePY3?=
 =?us-ascii?Q?ypNPzlKFS4pV5vqNMkqBdYrA0olMhXb+rm3qVmx2pwR910lfjLJZs3LFAzVc?=
 =?us-ascii?Q?W3k/9MPjHjfTk3KJjMIXZm4Fxl5ESWkD/GnrTo9G6TyXv96qpkSOsIHRWNve?=
 =?us-ascii?Q?6v04yJWROAkfIs9UpZf0zkF4meNwYNlxx9wQ8dTOaP4rLTJQpO3DC5AnWJpl?=
 =?us-ascii?Q?pkgck3n8KkL5hX4jOcRuwX9qg8PmPBI5nJIzVsR33rC8HeDN2ObMb3CdyBIS?=
 =?us-ascii?Q?MW4pEQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d372bbd-c77b-45db-f311-08da01cbb814
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 12:52:51.3152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sID11X+WdAyEfTMr6hgInPYoJih12VDeKgywpoCQ2w1G+XGrj2+VULwir29cHcRpjCHkJKYgOF4apGX2doDLIgSSdw+gbjcKuNCklJn+0So=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2155
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10280
 signatures=690848
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=839
 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090070
X-Proofpoint-ORIG-GUID: 18fDRtQOFKyUvK6qssPoR73rMTmuI88o
X-Proofpoint-GUID: 18fDRtQOFKyUvK6qssPoR73rMTmuI88o
Cc: iommu@lists.linux-foundation.org
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

Hello Suravee Suthikulpanit,

The patch d46c04558fdd: "iommu/amd: Improve amd_iommu_v2_exit()" from
Mar 1, 2022, leads to the following Smatch static checker warning:

	drivers/iommu/amd/iommu_v2.c:133 free_device_state()
	warn: sleeping in atomic context

drivers/iommu/amd/iommu_v2.c
   955        static void __exit amd_iommu_v2_exit(void)
   956        {
   957                struct device_state *dev_state, *next;
   958                unsigned long flags;
   959
   960                if (!amd_iommu_v2_supported())
   961                        return;
   962
   963                amd_iommu_unregister_ppr_notifier(&ppr_nb);
   964
   965                flush_workqueue(iommu_wq);
   966
   967                /*
   968                 * The loop below might call flush_workqueue(), so call
   969                 * destroy_workqueue() after it
   970                 */
   971                spin_lock_irqsave(&state_lock, flags);

Holding a spin lock.

   972
   973                list_for_each_entry_safe(dev_state, next, &state_list, list) {
   974                        WARN_ON_ONCE(1);
   975
   976                        put_device_state(dev_state);
   977                        list_del(&dev_state->list);
   978                        free_device_state(dev_state);

Calling a sleeping function (wait_event()).

   979                }
   980
   981                spin_unlock_irqrestore(&state_lock, flags);
   982
   983                destroy_workqueue(iommu_wq);
   984        }

regards,
dan carpenter
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
