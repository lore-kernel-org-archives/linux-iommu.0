Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C5FC433F5
	for <iommu@archiver.kernel.org>; Sun, 27 Mar 2022 14:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A7E54029B;
	Sun, 27 Mar 2022 14:29:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VO8Q4X7KRtnr; Sun, 27 Mar 2022 14:29:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 42116402AA;
	Sun, 27 Mar 2022 14:29:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19214C001D;
	Sun, 27 Mar 2022 14:29:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9A72C0012
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 14:28:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D8795812FA
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 14:28:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mx17OAvOBcO2 for <iommu@lists.linux-foundation.org>;
 Sun, 27 Mar 2022 14:28:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::625])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 23EAE812F0
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 14:28:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHmG2oc71beAhWRGChYXW5d986hPqikxdD9hLprtElaONU2b6GHbBWdONbK4sQCpVzaWjy27XjIAScAs9eNlehWeBpw3GW1YUnahvbRkurlAj0R0oKNoTfWmE34+DLo+ai6AqL8ymebFITWK4t4DkSlGY7OFh1gCV9OJSEZd5tKsQJBusR+FYuEVi6vtKdfBEn8F28GrTcVSwpViENT/EsxqlrwD8QnOFwhY0KSAlM1yb191o5I+T49cu52HcNUhZlf4K8zfB7GcLE9HlxxaoOKXTUTutAKfH2OrxKhznUsPCi67P5ET1MCcPmaSJmff8Kr2xCpCWXaTl2y3GNjXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1l4HSKElN2Un/BIBx3obbU4nSivzf/BIpJZrPCPBLYE=;
 b=EAjHsnzHnxQYBDLmAzck1mTRP83Dpa9C1Ua4Wss0KdRhJhAbAsg34N3lyB6o3Hhvg3Wb6NQptQVUgx6P3jEaDgRsQgp05xnN3rK12+waeZFExEk+SDO/eqmNLZBGsrs32/fPfJ6QkWKQngENh3sfIv1PYvbGu1kg8bg1r4lwQtzDTLQ/3bfh8+lDT+0hjM5/k/XfjAw/n2gYrARnM3n6tnmRHQrNqNhTmizN1yf10lwE82ccy7lq2TinyQJCxZoJ3+DYjvLiq4Qj6djipEaxypDXNmxQ/vr5gDAzhnffw2u3mxVLw0XyAjq6DSHCAdVAYbR8uNeCsEXhErIM8muQTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l4HSKElN2Un/BIBx3obbU4nSivzf/BIpJZrPCPBLYE=;
 b=moetQALElJfK+lFebhJMugDefvc4CXkPbsDxVwV2QEKk7RQ2KJfwqlLnnrVNUcGPMggvB/OuJiSGXRd/yEtpeDkvJkiy2ftEQc7DYvRobFETgXxT/oeFhN/jGQJxZx7V54gaZHOcUAYbwHGvaJ7TSxRdE0oE7gjGiDQQ9r2GU229SxmqIr3LD2ym/4NCIY6OaqMn6dYVQEW1vzZwWfXIz8cobvaXdYuknawtQjy9ieGLjHax/ijyGpU1gEztv/UEu9OOo1preeBpgG8KtYro1YkG+mHhyKqEH35js2HGjjIUk30D+RzXIa5wR0WBzXNyWzB2rLVYwh4wJQmEgxoL2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH0PR12MB5108.namprd12.prod.outlook.com (2603:10b6:610:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Sun, 27 Mar
 2022 14:28:55 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%6]) with mapi id 15.20.5102.022; Sun, 27 Mar 2022
 14:28:54 +0000
Date: Sun, 27 Mar 2022 11:28:53 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH RFC 08/12] iommufd: IOCTLs for the io_pagetable
Message-ID: <20220327142853.GF1342626@nvidia.com>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <8-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <20220323131038.3b5cb95b.alex.williamson@redhat.com>
 <20220323193439.GS11336@nvidia.com>
 <20220323140446.097fd8cc.alex.williamson@redhat.com>
 <20220323203418.GT11336@nvidia.com>
 <20220323225438.GA1228113@nvidia.com>
 <BN9PR11MB5276EB80AFCC3003955A46248C199@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220324134622.GB1184709@nvidia.com>
 <BN9PR11MB52760D5905410D0907B6260B8C1C9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52760D5905410D0907B6260B8C1C9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0299.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::34) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21542064-1924-43a3-4688-08da0ffe1f1e
X-MS-TrafficTypeDiagnostic: CH0PR12MB5108:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB510804CED3000D163D1677E7C21C9@CH0PR12MB5108.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ikTEhCMjlNjuZhcMmt6CODzLt0s5vSL5DIIEAF2OLcuJ1nPJnfgc38ScTuj34pZlA1s3re8uLq9rvEuT4GFHnSdO1YtHfHM3QCpjtMQuN9ZCcw413YfpRJzqZJQuGS2vw3H2oixjxROr5DO1TeaaAK5pcJefmZ7nKbJ6HzW4BfRiEanuEiUpFGa26JweH2Yky+5Tq9v/zL4lwT7o/9dIzo8hzUZYhD8FCSCJ6Znmhm1mSHv0Pw+wNKgFmhgZ/VExfDmtCBnU3T26qjqaS12Ql6CojN9g6n6Q79y1hkigV0LXThLrg2b2uxXwZRFT140ZKmxhGhznOhx6SYs/DG2QZ86FdZMzT6v3pN9glq1GbEnkvA7IwYOkhRValgY7XwtClhrSwxxsrcOlgIKU5PZ2e++wFolQfpon9+2b4PXh58/JVy8cez4s6ORRTQHWutC4sLfEhBv/HBAIPrMPTMgS8hCC+EpdxGdvwRH3m2+DL0pAXIKHJHHJxmRmhRZ9d5lDBS4Kr18pCsAbJYfdELHyTA38UWcqp4GuiYZhYSj0yl1WUmbEuK+tSl6XQKCsexyh7uruIbDtOqTs83rFiqj1c26Y35uDMo8lq4XmJUzr/w5vbDC8CwMlaYV9/HJacqnO2MTUK1/IMuj3dYe5WtLiFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(26005)(1076003)(8936002)(6486002)(2616005)(186003)(6506007)(4326008)(6916009)(38100700002)(508600001)(66476007)(54906003)(66556008)(66946007)(4744005)(5660300002)(8676002)(33656002)(36756003)(86362001)(7416002)(316002)(2906002)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tWJLdSQtEy3akQHYqnqPVbSp6OV6AA1dEE4qarOOgdKed3J4FpvrinIfOL/u?=
 =?us-ascii?Q?tnOVMw6x4kB+qJiu7wpmdTfcRYfeAESplw3LjG/rE3r9YemSKfB2BFO9Y1hg?=
 =?us-ascii?Q?OCW06ewZX4HT83whQAnJQ9WIuL0iBxtBBrGc22tb7fm8vt18iw7WGp+Tt8Tm?=
 =?us-ascii?Q?p5rM5oQvrv8vo/KTNAhdRxyOlyqpVwXVJDoO408KkMA+9j+/1d75aUyt/47W?=
 =?us-ascii?Q?iC3LMLRzp1A3E6P0wLFly3ilavmMhrzW7muyWjbhHozOLeXEYvY6k/i2HdKl?=
 =?us-ascii?Q?34BeDMCUEkzOi2gpGHl8c/MZdK5oCtLbrwjn/s5gb2+vZ45uyAnPCRveWWPx?=
 =?us-ascii?Q?QmakIf/y84o7N7S3uDJ+S7Xch/AuDxEolGijJ8NhvmtMOJFRJYnJitoToXTY?=
 =?us-ascii?Q?2uIT0mwHQIzqZODCPhjf1AVVuouRCzBs+7D1ly+MxY1f2vF51CR08WqNE+bt?=
 =?us-ascii?Q?65yhByObJFWosQKjxCHYxnLs2seJE1bZwHgQpIUtx2UDGVXjW76wkBQY7EFf?=
 =?us-ascii?Q?AmwmY/bpheA3+3VjF5G8zIT01w3Yax2giTKIxmqdHfulWbwA0h0ZUt+8Edb6?=
 =?us-ascii?Q?1CtOkkz2RwtGK/idLX+FrvfRzZkTPFSFhVaMMhbN3ubplPdGowvxtCBuw4Gh?=
 =?us-ascii?Q?8Gphbx+ciL0DlNpygsb3/o8gqhr7URaOk74mUdLTk2O3bC83KyrpeZW1mIiC?=
 =?us-ascii?Q?0H2n7+Os2SDt+L0NEY3+2+JTV8UQTHoIWTWMCsSQqsUIBfhASI/pvjUj/ceV?=
 =?us-ascii?Q?VWunnJm2hVXUwDcqtVq/oTnQKrK7VWCJbmPLqQTmIBGjMdgX68V2E4YkRwqH?=
 =?us-ascii?Q?fgezTs73kyIbOiE/8ZhoXClTcfB+AOPY/fqyf9DYamlJtUHVeHIY3b8a/PFP?=
 =?us-ascii?Q?vPmEBByAQP5aMIlCPQpMLD7XAgvQj3byWI3kaxk6BW0FB/ZzbGOOJYYkVwxa?=
 =?us-ascii?Q?V5BZRGe38DoPQ9NMApEMj+MNwkd9zds7n5J80UN62Yq4n+EMxO0oFyEh8R04?=
 =?us-ascii?Q?RzzT34uB+E0EGx5qiCBWHi3AX6u3bnlYkosYZ0bStvqqGZfzny6vnVqxKWdQ?=
 =?us-ascii?Q?YgoxDW+Uljdbx2tNMX3jdjiLh23cFwILZn3LAS2OHR7F6rrK/Mj8DuAWEy2n?=
 =?us-ascii?Q?XBb3n39fjl+TnsfLV08nZizJiFq7w35HEkXTcln/9OexOSRa5TRfgWSjUtB2?=
 =?us-ascii?Q?SgtUfVTHXIRBB5ZDp/IB2Tlsi34si27GpHO/rBNeI2qpYKlo+V4Jg8ihexKC?=
 =?us-ascii?Q?NVbpc+Ean2oCCzvkttGOVtxdJJ0/naRlfPoBU899rd/+0z5IMEvWJ4Q4tN2G?=
 =?us-ascii?Q?ISQQ3khCG/JaRcx8P7KPuQqcK2Pccb355QRQLw7hTtp7c+7c2Ouf8LhuyFhs?=
 =?us-ascii?Q?yoz0K7G6IsEIyJbmXMg7EHoAop7/pUT+gWJ+RFDjmMjEOim0S12hpafQN1Iz?=
 =?us-ascii?Q?VAjvQcBg6NXH+GDpUDjLs/D6nJyOlcMiwo07SY4hzi6BK7l//50RcWy04STZ?=
 =?us-ascii?Q?jEnQjusTrAcJLsh3TcEbCfBh9RijSe0rQafNTjbSgWD/r8ZKkKjRwgDLw1l/?=
 =?us-ascii?Q?lc4RKSb6GloyXnh7MLj4pWunmNMFvOUF+nsdOck5+UAV0KIhDh52cd6URHdB?=
 =?us-ascii?Q?OD1Sf5ynp/wyO0ZiMQ7Almsoq+pT88xCZmWSks/rigBAvtdwzpSGAWeMCYg+?=
 =?us-ascii?Q?/J8Pk19oxD/E24VkBJOGBRwNzlEIK1XGpkBCNqL5GdYAnsqd6xuEH5VYjZAH?=
 =?us-ascii?Q?XPB3SC51VQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21542064-1924-43a3-4688-08da0ffe1f1e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2022 14:28:54.7502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3NCa183EJy3bQLzBNgQZmaW8SjrvLBCS3G/VpSAiUfikut/HcM6RCUd83wkJTi1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5108
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>, "Xu,
 Terrence" <terrence.xu@intel.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Sun, Mar 27, 2022 at 02:32:23AM +0000, Tian, Kevin wrote:

> > this looks good to me except that the 2nd patch (eab4b381) should be
> > the last one otherwise it affects bisect. and in that case the subject
> > would be simply about removing the capability instead of
> > restoring...

Oh because VFIO won't sent IOMMU_CACHE in this case? Hmm. OK

> > let me find a box to verify it.
> 
> My colleague (Terrence) has the environment and helped verify it.
> 
> He will give his tested-by after you send out the formal series.

Okay, I can send it after the merge window

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
