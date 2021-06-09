Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6FAC4743D
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 02:49:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210986128A
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 02:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210986128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DBD5E40100;
	Wed,  9 Jun 2021 02:49:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cDF-fzo1LLIm; Wed,  9 Jun 2021 02:49:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7AE984013B;
	Wed,  9 Jun 2021 02:49:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 408D1C000E;
	Wed,  9 Jun 2021 02:49:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1EE5C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 02:49:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9C7BD839BD
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 02:49:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mUbMBz61zKiu for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 02:49:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E50A1832D0
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 02:49:39 +0000 (UTC)
IronPort-SDR: dQfUfCvjUM9PKkvAsHcyqUTl/NOv0Oev62abflu+5mIhkxUvU48FV7DpVHmrlyzVN9SoBvRDx/
 UYeK8uZ60Ozg==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="268846855"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; d="scan'208";a="268846855"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2021 19:49:38 -0700
IronPort-SDR: bwDF72YUntEF+0s0hkuNTBJmUjalOXjVI5U0X8DZ4Rl0Bbm+x0n8yhA+Qtw0TGsLwY14N8xB92
 Xkg3HFmPzGzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; d="scan'208";a="552519382"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by fmsmga001.fm.intel.com with ESMTP; 08 Jun 2021 19:49:37 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 8 Jun 2021 19:49:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 8 Jun 2021 19:49:37 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 8 Jun 2021 19:49:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8CfiMhBL/0PoCMW5J59gVUGzxFLCtawBUCrsTnRwriXYM6oWraQ2oDNVaXdP9rcrZrC8I1mOjXiTX+WnOeDCmZg8ct2yTCXd4EMROMxQjhZdcIJMqw+Qbo9E3xrpJkxyGxnv72evynMGvZ9puEFH7oMNTRDAaqEA43/o2vRn4OPE3VdjGThIPtvG4XyNmK7SIdf1TyDiMXVgAzNP5KBliAxcoL5bKx4OsrdPpnYhEMjZfp9jlyKqW2K/fWv4U76WlDnqnJlscbkoSly6yQV0k1SQxCcYawLjQ6TbJ2OmCj8w+2DhgllYUEbtffvgxn1CpF0Q6W0HYzipGdmxopnXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihcFaORYWXAeoZSlN3Hu0gch8jp1E2YYC5imGEzwRmo=;
 b=dyuGciPsxzqK9pFyRJ22lBuuEa0SBNJLa8Q0blEjScWT8fGIBsFuQhAlctvrQCSl0PSBnvE9W+/IOTDzb8Sk6wuJGrjDTS/7285Vwn/y/e9liGQon4QFo8j3lkdE9uLa5ssNnnnY2RDx70aoCDqoTHzEluA2/kIh1fyqorIYmNq2Y1Gp73eP5277FDaxyD/KbuVJ8ccRQY53CErSvLBfDeEjsW1+Z+eSFHctlJjPiZsY62qjLk+lEbSadqGNsnuclhz0tX0M+807A7eXiOMfSoETObDVlWMltg6tmt74htsTjVxfwm4Jsjj5yvtMdS5AK1rMtPSrQY8gGr6Zz7H+VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihcFaORYWXAeoZSlN3Hu0gch8jp1E2YYC5imGEzwRmo=;
 b=eK+fJIXCtRhFjK5RDw0dkcmETI7ATijkxwC6n8ABy6z+W15su+QKoVFvNF8h8DNyDqc7KLV0hNN1D55bLRsk5eW2t7dzT5U2xF1EDWQRvVBTHbT+r5Ebuu7Z3E5Wy65mW3Inb8IqJ17yLWqhg9EDmRG8/kpu1ruRuy5KSSDm030=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB4852.namprd11.prod.outlook.com (2603:10b6:303:9f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Wed, 9 Jun
 2021 02:49:32 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 02:49:32 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: RE: [RFC] /dev/ioasid uAPI proposal
Thread-Topic: [RFC] /dev/ioasid uAPI proposal
Thread-Index: AddSzQ970oLnVHLeQca/ysPD8zMJZwBL2ymAAKTbxpAAKSt7gAAHpf9wAB1YcAAAAm5sgAAA1YgAAADonIAAAEmcgAABzCaAAAHbfwAAAYTsAAAEeLUAAAiRJwAAFF14gAAPozMAAABMSwAAA0bJgAAVeTBAAAlp0QAABjX0AAAAf0IAAABWuQAAAD8IgAAAOC4AAABA0oAAAn0sgAAbQLqAAHzsuQAAHTjUgAALKb+AAAEAJgAACpEpAAAO1BBQ
Date: Wed, 9 Jun 2021 02:49:32 +0000
Message-ID: <MWHPR11MB18861A89FE6620921E7A7CAC8C369@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210604092620.16aaf5db.alex.williamson@redhat.com>
 <815fd392-0870-f410-cbac-859070df1b83@redhat.com>
 <20210604155016.GR1002214@nvidia.com>
 <30e5c597-b31c-56de-c75e-950c91947d8f@redhat.com>
 <20210604160336.GA414156@nvidia.com>
 <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
 <20210604172207.GT1002214@nvidia.com>
 <2d1ad075-bec6-bfb9-ce71-ed873795e973@redhat.com>
 <20210607175926.GJ1002214@nvidia.com>
 <fdb2f38c-da1f-9c12-af44-22df039fcfea@redhat.com>
 <20210608131547.GE1002214@nvidia.com>
 <89d30977-119c-49f3-3bf6-d3f7104e07d8@redhat.com>
 <20210608124700.7b9aa5a6.alex.williamson@redhat.com>
In-Reply-To: <20210608124700.7b9aa5a6.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.143.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93ec3acd-9039-4a98-d9e9-08d92af135d4
x-ms-traffictypediagnostic: CO1PR11MB4852:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB4852C254786279C4AFDF74898C369@CO1PR11MB4852.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xN0ul+nQokFYK5Vqe/S/YuxlmgPNdflU42Dh/EjFsE7tOYqTySF/1o/YqruEOm7tBg3IT0pobnCdgU8QEp32GgF8eNJuqdHW0I3vW30zNFdcLiYkix01LRU8NGFlSpahEdh30D4iyqKkUZh0XFS+mo452gUQ8j6b+lR7Zz3cPIad4k4EX/aupbqxPSspZvzCkPNFUeXjFBCPbHqhQe5K9n9bIxI9ndvGWtY5e6ctWbN3wjVhGPisfO5E2bBBnrMeTBFikxBAJRj6H2y5MjGWcxjmyJfCnD220W8XX8ltucCulmh+KCdahHsL+c6Ik0gv5jY7aKHuOYCyMIljYmajmG1OlHKeMTaHCaQ27B1ETnUvbRN/Z6unpqaEHwcgPKkGCg9V9dDErGzWKtI2Rbzn8hFWEZ31E/xOu6kk9kL3e8iB8912s3ak7RrKGj+a1OsepmBa33Y6r74w/Jw+/dn2IImBQeWPCR6zOAFApl4jzAf7bDlOUobA7mZMgsaFGyc2mEEX3XoMZL+9eDbWDPPfKYl7iecJkzPPaqJJm2s1DTYUGK7p6XPMK/3H04te94Vhnf+n08XOSTqNp+YAF8mV0XljrfSLrwIsEOf6o9d1Zc4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(366004)(346002)(39860400002)(376002)(136003)(66946007)(76116006)(52536014)(7416002)(64756008)(4326008)(86362001)(6506007)(66446008)(53546011)(8676002)(66556008)(66476007)(33656002)(38100700002)(5660300002)(316002)(110136005)(54906003)(122000001)(55016002)(8936002)(9686003)(7696005)(83380400001)(2906002)(478600001)(26005)(71200400001)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4GKFV9QwAG4d8q8o06uI4r95gv7dMnHz5zTMZhxcN5KeqS8pZXYTzYvku7aD?=
 =?us-ascii?Q?l+ppT8tBrE5AKkkFsdUJxqp+ZhTWNK8DLL6eEPo3209seWqmAjQ4LeNkapnM?=
 =?us-ascii?Q?1RZYKCfErsji6QhBZY8PuwgTdqhZNszRm4MieJ9XPyOIHAVQ8gdCRsJRjrbW?=
 =?us-ascii?Q?0Uvu0iF4E0IhYiRk8gs2EnlkSTpMtLkl/Kebkg/jqfggzcEqCpEfuFLK4tUl?=
 =?us-ascii?Q?80YKckuhRBpwaIh+DeezPYc4hFIbDg98sQqH3QsoLQ5MS/u2Us5XTxGKCDMY?=
 =?us-ascii?Q?/B4uvgs3pf0vl8KMhpjVeJrifensxtTQT2hCdhrD5A9hIBluyIUrNZNs+3xj?=
 =?us-ascii?Q?zHYJm2IOonAmBQihcgCkM2Yp8asfEd547qoG3N7KUAE23QlfBrmcdj2L9oJO?=
 =?us-ascii?Q?Yif3Aedydhz5za3peqNBIKTIc+twA51tSmmIsykM3YjuCSw9CC0fq7wP7fAK?=
 =?us-ascii?Q?861k8zI4WoNtHvuji52nQY8JfeW5Nm6eaa9cZrQ50VZ1ww9MB7f5v/JpXwnd?=
 =?us-ascii?Q?xiLBMU4OpSMrFAZzX9r88YT+8mAR6w37tfEjdTPtxvRd7J/n/lNbT/lpRD4V?=
 =?us-ascii?Q?LEF2hUqDECnfr1bJvZE6qFYwfQ+66fr4qOf8EIGi22xjoS5BziZbQ59Qg+op?=
 =?us-ascii?Q?DTpEg47+xBHIDOPsHa0+AnYoFHtYVz+nOdjiTExSQFmpWd3dtRERnmQwvwb0?=
 =?us-ascii?Q?ppawCBUz4To6bEQM370uU/KFuQwZtiuxwd72/RklQcoKUEmhl2r1zO0FTwVP?=
 =?us-ascii?Q?2P9BaF5ifMS2BsJeiBBmSeOFvRcWby6NubFxU0sVFtp+2ZuA7TzHUPKiTxdj?=
 =?us-ascii?Q?4W0SPd3NNMrPYnB4VJkkSfWklq3RudVTy6OLz7Q4ahMWOkKCbW97Tr0QnJzr?=
 =?us-ascii?Q?nIWV8U0crFvIMUIyl2yW9eisIin84HsE/f/VH9eBx2htCNI2HoPAHo1ayy45?=
 =?us-ascii?Q?HX+hEhpLmNWVIqpZVYTFBLUj4fk/vNs3qXThh8M+P7CoTxRUN9lCMSzZ/N6k?=
 =?us-ascii?Q?GCq86p+VqvU2YogT+Eb64YRL2cxxwyIGQ/LxBLm7+7BnmD2YgWODHo4LXbBs?=
 =?us-ascii?Q?Oju6VKLehwQFSRhiq8t7zWIadlxGNjf6eDUfEOi1JMezL7xVYkiTGIoruXXn?=
 =?us-ascii?Q?IGHxK5d2uJoCrmC5YT0k68V7QnBXIWHsk9c+l3Jx1g4wsakFb7ONQOZMXWnx?=
 =?us-ascii?Q?gs+Ikg6zU8iywNC7/Uj1fL7vZy+FX3Tp8kwEa/X05V872JHtnLoUzAQd6c06?=
 =?us-ascii?Q?6Eod/dW3HBfJ94BuAC7HIegpXc1+0JBUdXvd6x1134BlKfCZdM1MCXtnL89r?=
 =?us-ascii?Q?qj3oqB/2nHoDf54BZeYcwSOv?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ec3acd-9039-4a98-d9e9-08d92af135d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 02:49:32.7073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KaoPUsmN3oXvfqoIn7e78KxHj1cjDkaD1R/1Rld4L9bIZHUYT14mVz97gW6QGmUx+rGx0G1x9mrRdNH1vcFiaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4852
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, 
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David
 Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Wednesday, June 9, 2021 2:47 AM
> 
> On Tue, 8 Jun 2021 15:44:26 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> > On 08/06/21 15:15, Jason Gunthorpe wrote:
> > > On Tue, Jun 08, 2021 at 09:56:09AM +0200, Paolo Bonzini wrote:
> > >
> > >>>> Alternatively you can add a KVM_DEV_IOASID_{ADD,DEL} pair of
> ioctls. But it
> > >>>> seems useless complication compared to just using what we have
> now, at least
> > >>>> while VMs only use IOASIDs via VFIO.
> > >>>
> > >>> The simplest is KVM_ENABLE_WBINVD(<fd security proof>) and be
> done
> > >>> with it.
> 
> Even if we were to relax wbinvd access to any device (capable of
> no-snoop or not) in any IOMMU configuration (blocking no-snoop or not),
> I think as soon as we say "proof" is required to gain this access then
> that proof should be ongoing for the life of the access.
> 
> That alone makes this more than a "I want this feature, here's my
> proof", one-shot ioctl.  Like the groupfd enabling a path for KVM to
> ask if that group is non-coherent and holding a group reference to
> prevent the group from being used to authorize multiple KVM instances,
> the ioasidfd proof would need to minimally validate that devices are
> present and provide some reference to enforce that model as ongoing, or
> notifier to indicate an end of that authorization.  I don't think we
> can simplify that out of the equation or we've essentially invalidated
> that the proof is really required.
> 
> > >>
> > >> The simplest one is KVM_DEV_VFIO_GROUP_ADD/DEL, that already
> exists and also
> > >> covers hot-unplug.  The second simplest one is
> KVM_DEV_IOASID_ADD/DEL.
> > >
> > > This isn't the same thing, this is back to trying to have the kernel
> > > set policy for userspace.
> >
> > If you want a userspace policy then there would be three states:
> >
> > * WBINVD enabled because a WBINVD-enabled VFIO device is attached.
> >
> > * WBINVD potentially enabled but no WBINVD-enabled VFIO device
> attached
> >
> > * WBINVD forcefully disabled
> >
> > KVM_DEV_VFIO_GROUP_ADD/DEL can still be used to distinguish the first
> > two.  Due to backwards compatibility, those two describe the default
> > behavior; disabling wbinvd can be done easily with a new sub-ioctl of
> > KVM_ENABLE_CAP and doesn't require any security proof.
> 
> That seems like a good model, use the kvm-vfio device for the default
> behavior and extend an existing KVM ioctl if QEMU still needs a way to
> tell KVM to assume all DMA is coherent, regardless of what the kvm-vfio
> device reports.
> 
> If feels like we should be able to support a backwards compatibility
> mode using the vfio group, but I expect long term we'll want to
> transition the kvm-vfio device from a groupfd to an ioasidfd.
> 
> > The meaning of WBINVD-enabled is "won't return -ENXIO for the wbinvd
> > ioctl", nothing more nothing less.  If all VFIO devices are going to be
> > WBINVD-enabled, then that will reflect on KVM as well, and I won't have
> > anything to object if there's consensus on the device assignment side of
> > things that the wbinvd ioctl won't ever fail.
> 
> If we create the IOMMU vs device coherency matrix:
> 
>             \ Device supports
> IOMMU blocks \   no-snoop
>   no-snoop    \  yes | no  |
> ---------------+-----+-----+
>            yes |  1  |  2  |
> ---------------+-----+-----+
>            no  |  3  |  4  |
> ---------------+-----+-----+
> 
> DMA is always coherent in boxes {1,2,4} (wbinvd emulation is not
> needed).  VFIO will currently always configure the IOMMU for {1,2} when
> the feature is supported.  Boxes {3,4} are where we'll currently
> emulate wbinvd.  The best we could do, not knowing the guest or
> insights into the guest driver would be to only emulate wbinvd for {3}.
> 
> The majority of devices appear to report no-snoop support {1,3}, but
> the claim is that it's mostly unused outside of GPUs, effectively {2,4}.
> I'll speculate that most IOMMUs support enforcing coherency (amd, arm,
> fsl unconditionally, intel conditionally) {1,2}.
> 
> I think that means we're currently operating primarily in Box {1},
> which does not seem to lean towards unconditional wbinvd access with
> device ownership.
> 
> I think we have a desire with IOASID to allow user policy to operate
> certain devices in {3} and I think the argument there is that a
> specific software enforced coherence sync is more efficient on the bus
> than the constant coherence enforcement by the IOMMU.
> 
> I think that the disable mode Jason proposed is essentially just a way
> to move a device from {3} to {4}, ie. the IOASID support or
> configuration does not block no-snoop and the device claims to support
> no-snoop, but doesn't use it.  How we'd determine this to be true for
> a device without a crystal ball of driver development or hardware
> errata that no-snoop transactions are not possible regardless of the
> behavior of the enable bit, I'm not sure.  If we're operating a device
> in {3}, but the device does not generate no-snoop transactions, then
> presumably the guest driver isn't generating wbinvd instructions for us
> to emulate, so where are the wbinvd instructions that this feature
> would prevent being emulated coming from?  Thanks,
> 

I'm writing v2 now. Below is what I captured from this discussion.
Please let me know whether it matches your thoughts:

- Keep existing kvm-vfio device with kernel-decided policy in short term, 
  i.e. 'disable' for 1/2 and 'enable' for 3/4. Jason still has different thought
  whether this should be an explicit wbinvd cmd, though;

- Long-term transition to ioasidfd (for non-vfio usage);

- As extension we want to support 'force-enable' (1->3 for performance
  reason) from user but not 'force-disable' (3->4, sounds meaningless 
  since if guest driver doesn't use wbinvd then keeping wbinvd emulation 
  doesn't hurt);

- To support 'force-enable' no need for additional KVM-side contract.
   It just relies on what kvm-vfio device reports, regardless of whether
   an 'enable' policy comes from kernel or user;

- 'force-enable' is supported through /dev/iommu (new name for
  /dev/ioasid);

- Qemu first calls IOMMU_GET_DEV_INFO(device_handle) to acquire 
  the default policy (enable vs. disable) for a device. This is the kernel 
  decision based on device no-snoop and iommu snoop control capability;

- If not specified, an newly-created IOASID follows the kernel policy.
  Alternatively, Qemu could explicitly mark an IOASID as non-coherent
  when IOMMU_ALLOC_IOASID;

- Attaching a non-snoop device which cannot be forced to snoop by 
  iommu to a coherent IOASID gets a failure, because a snoop-format 
  I/O page table causes error on such iommu;
  
- Devices attached to a non-coherent IOASID all use the no-snoop 
  format I/O page table, even when the iommu is capable of forcing 
  snoop;

- After IOASID is properly configured, Qemu then uses kvm-vfio device
  to notify KVM which calls vfio helper function to get coherent attribute
  per vfio_group. Because this attribute is kept in IOASID, we possibly
  need return the attribute to vfio when vfio_attach_ioasid. 

Last unclosed open. Jason, you dislike symbol_get in this contract per
earlier comment. As Alex explained, looks it's more about module
dependency which is orthogonal to how this contract is designed. What
is your opinion now?

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
