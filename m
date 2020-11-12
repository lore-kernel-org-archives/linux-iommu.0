Return-Path: <SRS0=2i4G=ES=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBD2C388F7
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 12:55:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 874E021D91
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 12:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VsWoaT5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874E021D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B9AF087789;
	Thu, 12 Nov 2020 12:55:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TkS-9kE7EqoK; Thu, 12 Nov 2020 12:55:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E5C5B87782;
	Thu, 12 Nov 2020 12:55:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7467C0889;
	Thu, 12 Nov 2020 12:55:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C254C016F
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 12:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9529A8708C
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 12:55:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d5jA3r1QIAfL for <iommu@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 12:55:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5D6348703D
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 12:55:54 +0000 (UTC)
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.9]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fad30d30000>; Thu, 12 Nov 2020 20:55:47 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 12:55:36 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS)
 id
 15.0.1473.3 via Frontend Transport; Thu, 12 Nov 2020 12:55:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyIW7IOM0+++D4M++knuxpj7alhdYeaG22sc6dnPQJvngD6iTQvoKuFK3btnmgz2x5yqp2KUXW8gpJDEBdEvtEjNVEU+Zg1UHlyDVRTAXy/CRaAAshslESeA8XtvD9CNUSi5fQw1W/emZlcqGsBZni9eCp7dwc2n18TqXLtRVzzftvL8iAHZnki7/0gMua+yf1LU6I2Vi9Ryc9MtQ3bYLON/ejRZETiohSE8rkOel8ShqC5HGlLy5WVj5K49GrvhTwQ9bnRTURwNdW9PHm+9+Lm3Ds27QwQru7/BDW33MSTzo8ZlWlhMymu3rYrEycSfJsaw8+nCgsb+WHf+Hx7KEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odkGYsTueGG1Oj1E5+/FEqJBoN5zCA2wnbKnOv3SBSE=;
 b=joeixh4hu5ooTwctsGDAchHhtySQy59tD6tksNFsMczPvsiyyWuzacJauPFFKPZyCHv0IzmOqJaVJq3IwPU71DE7W5hi4kyQEyR6pJIxlSE2XuQcPvjQ4yLf3y6AVksI30sPG4CH/p0/c42VC6zzDIaNOS3iyIN7a4GQHtRk45P0ZWoJCF7P/gyZpqD1uxRRmTdun+D7uF0L7uTvzzcjoMqR8cOI8o/r2s2Lw7FgyBfaTwc4uBJ21Wt1CdBu5vAuD3ZVNz5IjO6f4b1uqtB6rxz5Wi0BUV7nwqfmviq43rTvsR0bX8YHYEt8oDBApe84NJk4YnGpc9atCfbvSXNNhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1881.namprd12.prod.outlook.com (2603:10b6:3:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 12:55:33 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 12 Nov 2020
 12:55:33 +0000
Date: Thu, 12 Nov 2020 08:55:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ziyad Atiyyeh <ziyadat@nvidia.com>, 
 Itay Aveksis <itayav@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: REGRESSION: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare
 for device MSI
Message-ID: <20201112125531.GA873287@nvidia.com>
References: <20200826111628.794979401@linutronix.de>
Content-Disposition: inline
In-Reply-To: <20200826111628.794979401@linutronix.de>
X-ClientProxiedBy: MN2PR15CA0022.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 MN2PR15CA0022.namprd15.prod.outlook.com (2603:10b6:208:1b4::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Thu, 12 Nov 2020 12:55:32 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kdC8R-003fG5-Cp; Thu, 12 Nov 2020 08:55:31 -0400
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1605185747; bh=eQ25xNlY3rVx34V0CM4Bnq31qnmUxB4lNkLgF/NTCTU=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
 X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType:X-LD-Processed;
 b=VsWoaT5gF6t9jiuouhEpEGN7Qg7rtC2IuOTe3e6QAc+/J5kvbsUGMZeN9Kt4v340c
 KVbRoCH9TR2N9HqJF4VZ84B6k+51zu6l3inP6l0HJqan+cR7kEEn/+Cqpds/KwjSEr
 BJf+0jPEtmRpSIm1ToZML8tn4g1PO1iVyJXs6pHwlKZwUso5Cn8iCe6LGFBRQ1tEUP
 95Nt8mKzj2PmKuTTS2AowvWwB9kBFIAxLC7TFNHrpa0/KKU1hbM20l9NiG3hCradK7
 hY1uGGNICjBrlcYzyYVoaC3ibvjfkHv7m8xxytVcHuVd6aNpu8YGZow8Vv5rsi+u+9
 YDb6R/lLzsueQ==
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org, Megha Dey <megha.dey@intel.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Jon
 Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gV2VkLCBBdWcgMjYsIDIwMjAgYXQgMDE6MTY6MjhQTSArMDIwMCwgVGhvbWFzIEdsZWl4bmVy
IHdyb3RlOgo+IFRoaXMgaXMgdGhlIHNlY29uZCB2ZXJzaW9uIG9mIHByb3ZpZGluZyBhIGJhc2Ug
dG8gc3VwcG9ydCBkZXZpY2UgTVNJIChub24KPiBQQ0kgYmFzZWQpIGFuZCBvbiB0b3Agb2YgdGhh
dCBzdXBwb3J0IGZvciBJTVMgKEludGVycnVwdCBNZXNzYWdlIFN0b3JtKQo+IGJhc2VkIGRldmlj
ZXMgaW4gYSBoYWxmd2F5cyBhcmNoaXRlY3R1cmUgaW5kZXBlbmRlbnQgd2F5LgoKSGkgVGhvbWFz
LAoKT3VyIHRlc3QgdGVhbSBoYXMgYmVlbiBzdHJ1Z2dsaW5nIHdpdGggYSByZWdyZXNzaW9uIG9u
IGJhcmUgbWV0YWwKU1JJT1YgVkZzIHNpbmNlIC1yYzEgdGhhdCB0aGV5IHdlcmUgYWJsZSB0byBi
aXNlY3QgdG8gdGhpcyBzZXJpZXMKClRoaXMgY29tbWl0IHRlc3RzIGdvb2Q6Cgo1NzEyYzNlZDU0
OWUgKCJNZXJnZSB0YWcgJ2FybXNvYy1maXhlcycgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L3NvYy9zb2MiKQoKVGhpcyBjb21taXQgdGVzdHMgYmFkOgoK
OTgxYWExZDM2NmJmICgiUENJOiBNU0k6IEZpeCBLY29uZmlnIGRlcGVuZGVuY2llcyBmb3IgUENJ
X01TSV9BUkNIX0ZBTExCQUNLUyIpCgpUaGV5IHdlcmUgdW5hYmxlIHRvIGJpc2VjdCBmdXJ0aGVy
IGludG8gdGhlIHNlcmllcyBiZWNhdXNlIHNvbWUgb2YgdGhlCmludGVyaW9yIGNvbW1pdHMgZG9u
J3QgYm9vdCA6KAoKV2hlbiB3ZSB0cnkgdG8gbG9hZCB0aGUgbWx4NSBkcml2ZXIgb24gYSBiYXJl
IG1ldGFsIFZGIGl0IGdldHMgdGhpczoKCltUaHUgT2N0IDIyIDA4OjU0OjUxIDIwMjBdIERNQVI6
IERSSEQ6IGhhbmRsaW5nIGZhdWx0IHN0YXR1cyByZWcgMgpbVGh1IE9jdCAyMiAwODo1NDo1MSAy
MDIwXSBETUFSOiBbSU5UUi1SRU1BUF0gUmVxdWVzdCBkZXZpY2UgWzQyOjAwLjJdIGZhdWx0IGlu
ZGV4IDE2MDAgW2ZhdWx0IHJlYXNvbiAzN10gQmxvY2tlZCBhIGNvbXBhdGliaWxpdHkgZm9ybWF0
IGludGVycnVwdCByZXF1ZXN0CltUaHUgT2N0IDIyIDA4OjU1OjA0IDIwMjBdIG1seDVfY29yZSAw
MDAwOjQyOjAwLjEgZXRoNDogTGluayBkb3duCltUaHUgT2N0IDIyIDA4OjU1OjExIDIwMjBdIG1s
eDVfY29yZSAwMDAwOjQyOjAwLjEgZXRoNDogTGluayB1cApbVGh1IE9jdCAyMiAwODo1NTo1NCAy
MDIwXSBtbHg1X2NvcmUgMDAwMDo0MjowMC4yOiBtbHg1X2NtZF9lcV9yZWNvdmVyOjI2NDoocGlk
IDMzOTApOiBSZWNvdmVyZWQgMSBFUUVzIG9uIGNtZF9lcQpbVGh1IE9jdCAyMiAwODo1NTo1NCAy
MDIwXSBtbHg1X2NvcmUgMDAwMDo0MjowMC4yOiB3YWl0X2Z1bmNfaGFuZGxlX2V4ZWNfdGltZW91
dDoxMDUxOihwaWQgMzM5MCk6IGNtZDA6IENSRUFURV9FUSgww4PClzMwMSkgcmVjb3ZlcmVkIGFm
dGVyIHRpbWVvdXQKW1RodSBPY3QgMjIgMDg6NTU6NTQgMjAyMF0gRE1BUjogRFJIRDogaGFuZGxp
bmcgZmF1bHQgc3RhdHVzIHJlZyAxMDIKW1RodSBPY3QgMjIgMDg6NTU6NTQgMjAyMF0gRE1BUjog
W0lOVFItUkVNQVBdIFJlcXVlc3QgZGV2aWNlIFs0MjowMC4yXSBmYXVsdCBpbmRleCAxNjAwIFtm
YXVsdCByZWFzb24gMzddIEJsb2NrZWQgYSBjb21wYXRpYmlsaXR5IGZvcm1hdCBpbnRlcnJ1cHQg
cmVxdWVzdAoKSWYgeW91IGhhdmUgYW55IGlkZWEgWml5YWQgYW5kIEl0YXkgY2FuIHJ1biBhbnkg
ZGVidWdnaW5nIHlvdSBsaWtlLgoKSSBzdXBwb3NlIGl0IGlzIGJlY2F1c2UgdGhpcyBzZXJpZXMg
aXMgaGFuZGluZyBvdXQgY29tcGF0YWJpbGl0eQphZGRyL2RhdGEgcGFpcnMgd2hpbGUgdGhlIElP
TU1VIGlzIHNldHVwIHRvIG9ubHkgYWNjZXB0IHJlbWFwIG9uZXMKZnJvbSBTUklPViBWRnM/CgpU
aGFua3MsCkphc29uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
