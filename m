Return-Path: <SRS0=fKZg=UI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF1AC468BD
	for <iommu@archiver.kernel.org>; Sun,  9 Jun 2019 13:40:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF9C20868
	for <iommu@archiver.kernel.org>; Sun,  9 Jun 2019 13:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF9C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1E403BDC;
	Sun,  9 Jun 2019 13:40:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EB060B9E
	for <iommu@lists.linux-foundation.org>;
	Sun,  9 Jun 2019 13:40:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7D0B076F
	for <iommu@lists.linux-foundation.org>;
	Sun,  9 Jun 2019 13:40:06 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 Jun 2019 06:40:05 -0700
X-ExtLoop1: 1
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
	by orsmga003.jf.intel.com with ESMTP; 09 Jun 2019 06:40:05 -0700
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
	FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Sun, 9 Jun 2019 06:40:04 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
	FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Sun, 9 Jun 2019 06:40:04 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.137]) by
	SHSMSX103.ccr.corp.intel.com ([169.254.4.120]) with mapi id
	14.03.0415.000; Sun, 9 Jun 2019 21:40:02 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [RFC v3 0/3] vfio_pci: wrap pci device as a mediated device
Thread-Topic: [RFC v3 0/3] vfio_pci: wrap pci device as a mediated device
Thread-Index: AQHU+pmUgYQWOZcgyUar+GqJiI6/NqZ4kV4g///DEoCAGzk18A==
Date: Sun, 9 Jun 2019 13:40:02 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439EDF463@SHSMSX104.ccr.corp.intel.com>
References: <1556021680-2911-1-git-send-email-yi.l.liu@intel.com>
	<A2975661238FB949B60364EF0F2C257439EB884E@SHSMSX104.ccr.corp.intel.com>
	<20190523070311.4f95ca5c@x1.home>
In-Reply-To: <20190523070311.4f95ca5c@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYmM4NWY1NmEtYTk3ZS00MTA0LWIyZDAtNTZlOTgwNTQ1ZDNlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZWxyRmRYd1pubmZWNm5xbUZPQXZLd25GQXV4XC9tMzZwVHhaUDRsYUlqaHhtbFdFRVd2ZEsrMEV5UDU0SG1ZcGIifQ==
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
	"kwankhede@nvidia.com" <kwankhede@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
	"Sun, Yi Y" <yi.y.sun@intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

> From Alex Williamson
> Sent: Thursday, May 23, 2019 9:03 PM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Cc: kwankhede@nvidia.com; Tian, Kevin <kevin.tian@intel.com>;
> baolu.lu@linux.intel.com; Sun, Yi Y <yi.y.sun@intel.com>; joro@8bytes.org; jean-
> philippe.brucker@arm.com; peterx@redhat.com; linux-kernel@vger.kernel.org;
> kvm@vger.kernel.org; yamada.masahiro@socionext.com; iommu@lists.linux-
> foundation.org
> Subject: Re: [RFC v3 0/3] vfio_pci: wrap pci device as a mediated device
> 
> On Thu, 23 May 2019 08:44:57 +0000
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> 
> > Hi Alex,
> >
> > Sorry to disturb you. Do you want to review on this version or review a rebased
> version? :-) If rebase version is better, I can try to do it asap.
> 
> Hi Yi,
> 
> Perhaps you missed my comments on 1/3:
> 
> https://www.spinics.net/lists/kvm/msg187282.html
> 
> In summary, it looks pretty good, but consider a file name more consistent with the
> existing files and prune out the code changes from the code moves so they can be
> reviewed more easily.  Thanks,

Thanks for the remind, Alex. So sorry I made changes in a "disordered".
I've made the changes accordingly. Pls refer to my latest post just now :-)

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
