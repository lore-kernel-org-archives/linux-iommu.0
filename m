Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BF0C433B4
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 03:20:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7E561411
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 03:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7E561411
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31B1040F82;
	Thu, 13 May 2021 03:20:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nTCTgUP7Dn1Q; Thu, 13 May 2021 03:20:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id DAA0B40315;
	Thu, 13 May 2021 03:20:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3C9AC000E;
	Thu, 13 May 2021 03:20:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97DA5C0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 03:20:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 859E1844B7
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 03:20:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z32-8p7v92e4 for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 03:20:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B9F3C844B3
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 03:20:21 +0000 (UTC)
IronPort-SDR: fn+cj8hB8kDIP2eb3DkXZSTRBS+CmZ4oJF/gnVjEE/32IVtg/FYFSuMG5yM7IuEFVUBvtITpM3
 /IFtlesXh77w==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="180121577"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="180121577"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2021 20:20:21 -0700
IronPort-SDR: mj7EoWy5caILec4mbk32Dm0KgdMRCgdis+B5aYwjfmce1/m431ZPlq/GAXkQxk0u9LSJU6JlnK
 f6t1SWydDh2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="623090674"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga006.fm.intel.com with ESMTP; 12 May 2021 20:20:14 -0700
Subject: Re: [Resend RFC PATCH V2 10/12] HV/IOMMU: Add Hyper-V dma ops support
To: Tianyu Lan <ltykernel@gmail.com>, Christoph Hellwig <hch@lst.de>,
 konrad.wilk@oracle.com
References: <20210414144945.3460554-1-ltykernel@gmail.com>
 <20210414144945.3460554-11-ltykernel@gmail.com>
 <20210414154729.GD32045@lst.de>
 <a316af73-2c96-f307-6285-593597e05123@gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7cda690b-adb0-1f5f-2048-b52f75c0399f@linux.intel.com>
Date: Thu, 13 May 2021 11:19:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <a316af73-2c96-f307-6285-593597e05123@gmail.com>
Content-Language: en-US
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, linux-mm@kvack.org,
 hpa@zytor.com, kys@microsoft.com, will@kernel.org, sunilmut@microsoft.com,
 linux-arch@vger.kernel.org, wei.liu@kernel.org, sthemmin@microsoft.com,
 linux-scsi@vger.kernel.org, x86@kernel.org, mingo@redhat.com, kuba@kernel.org,
 haiyangz@microsoft.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, arnd@arndb.de, jejb@linux.ibm.com,
 bp@alien8.de, tglx@linutronix.de, akpm@linux-foundation.org,
 martin.petersen@oracle.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, vkuznets@redhat.com, robin.murphy@arm.com,
 davem@davemloft.net
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gNS8xMy8yMSAxMjowMSBBTSwgVGlhbnl1IExhbiB3cm90ZToKPiBIaSBDaHJpc3RvcGggYW5k
IEtvbnJhZDoKPiAgwqDCoMKgwqAgQ3VycmVudCBTd2lvdGxiIGJvdW5jZSBidWZmZXIgdXNlcyBh
IHBvb2wgZm9yIGFsbCBkZXZpY2VzLiBUaGVyZQo+IGlzIGEgaGlnaCBvdmVyaGVhZCB0byBnZXQg
b3IgZnJlZSBib3VuY2UgYnVmZmVyIGR1cmluZyBwZXJmb3JtYW5jZSB0ZXN0Lgo+IFN3aW90bGIg
Y29kZSBub3cgdXNlIGEgZ2xvYmFsIHNwaW4gbG9jayB0byBwcm90ZWN0IGJvdW5jZSBidWZmZXIg
ZGF0YS4KPiBTZXZlcmFsIGRldmljZSBxdWV1ZXMgdHJ5IHRvIGFjcXVpcmUgdGhlIHNwaW4gbG9j
ayBhbmQgdGhpcyBpbnRyb2R1Y2UKPiBhZGRpdGlvbmFsIG92ZXJoZWFkLgo+IAo+IEZvciBwZXJm
b3JtYW5jZSBhbmQgc2VjdXJpdHkgcGVyc3BlY3RpdmUsIGVhY2ggZGV2aWNlcyBzaG91bGQgaGF2
ZSBhCj4gc2VwYXJhdGUgc3dpb3RsYiBib3VuY2UgYnVmZmVyIHBvb2wgYW5kIHNvIHRoaXMgcGFy
dCBuZWVkcyB0byByZXdvcmsuCj4gSSB3YW50IHRvIGNoZWNrIHRoaXMgaXMgcmlnaHQgd2F5IHRv
IHJlc29sdmUgcGVyZm9ybWFuY2UgaXNzdWVzIHdpdGggCj4gc3dpb3RsYiBib3VuY2UgYnVmZmVy
LiBJZiB5b3UgaGF2ZSBzb21lIG90aGVyIHN1Z2dlc3Rpb25zLHdlbGNvbWUuCgpJcyB0aGlzIHdo
YXQgeW91IHdhbnQ/CgpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pb21tdS8yMDIxMDUx
MDA5NTAyNi4zNDc3NDk2LTEtdGllbnR6dUBjaHJvbWl1bS5vcmcvCgpCZXN0IHJlZ2FyZHMsCmJh
b2x1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
