Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD13AC47094
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 05:51:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E8146124C
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 05:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8146124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29FC060908;
	Thu, 10 Jun 2021 05:51:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d8UCkKQA2Ik1; Thu, 10 Jun 2021 05:51:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 119BA60871;
	Thu, 10 Jun 2021 05:51:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF574C000E;
	Thu, 10 Jun 2021 05:51:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20F12C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 05:51:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC2FA40569
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 05:51:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FFKtxEPZ8PcT for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 05:51:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 910E140539
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 05:51:47 +0000 (UTC)
IronPort-SDR: I7/Qh42wvwmRxKR00mkxlJjCIKVo+2legSX8TXsZBq/jMB1xy2PPyspjfsmevD+B74LyaXYohA
 /JlZYGAZ14+A==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="226617441"
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="226617441"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 22:51:46 -0700
IronPort-SDR: lYZDBU6hA5oTn4VVKqizzKmtKcBFGSgqLubi9XRIwACO9pQQULnDbe7FgCznj4jwlvIz+SPiUv
 KJREAguEFGjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="552922753"
Received: from allen-box.sh.intel.com (HELO [10.239.159.105])
 ([10.239.159.105])
 by fmsmga001.fm.intel.com with ESMTP; 09 Jun 2021 22:51:41 -0700
Subject: Re: Plan for /dev/ioasid RFC v2
To: Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>
References: <MWHPR11MB188699D0B9C10EB51686C4138C389@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YMCy48Xnt/aphfh3@8bytes.org> <20210609123919.GA1002214@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <14d884a8-13bc-b2ba-7020-94b219e3e2d9@linux.intel.com>
Date: Thu, 10 Jun 2021 13:50:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210609123919.GA1002214@nvidia.com>
Content-Language: en-US
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 6/9/21 8:39 PM, Jason Gunthorpe wrote:
> On Wed, Jun 09, 2021 at 02:24:03PM +0200, Joerg Roedel wrote:
>> On Mon, Jun 07, 2021 at 02:58:18AM +0000, Tian, Kevin wrote:
>>> -   Device-centric (Jason) vs. group-centric (David) uAPI. David is not fully
>>>      convinced yet. Based on discussion v2 will continue to have ioasid uAPI
>>>      being device-centric (but it's fine for vfio to be group-centric). A new
>>>      section will be added to elaborate this part;
>> I would vote for group-centric here. Or do the reasons for which VFIO is
>> group-centric not apply to IOASID? If so, why?
> VFIO being group centric has made it very ugly/difficult to inject
> device driver specific knowledge into the scheme.
> 
> The device driver is the only thing that knows to ask:
>   - I need a SW table for this ioasid because I am like a mdev
>   - I will issue TLPs with PASID
>   - I need a IOASID linked to a PASID
>   - I am a devices that uses ENQCMD and vPASID
>   - etc in future
> 
> The current approach has the group try to guess the device driver
> intention in the vfio type 1 code.
> 
> I want to see this be clean and have the device driver directly tell
> the iommu layer what kind of DMA it plans to do, and thus how it needs
> the IOMMU and IOASID configured.
> 
> This is the source of the ugly symbol_get and the very, very hacky 'if
> you are a mdev*and*  a iommu then you must want a single PASID' stuff
> in type1.
> 
> The group is causing all this mess because the group knows nothing
> about what the device drivers contained in the group actually want.
> 
> Further being group centric eliminates the possibility of working in
> cases like !ACS. How do I use PASID functionality of a device behind a
> !ACS switch if the uAPI forces all IOASID's to be linked to a group,
> not a device?
> 
> Device centric with an report that "all devices in the group must use
> the same IOASID" covers all the new functionality, keep the old, and
> has a better chance to keep going as a uAPI into the future.

The iommu_group can guarantee the isolation among different physical
devices (represented by RIDs). But when it comes to sub-devices (ex. 
mdev or vDPA devices represented by RID + SSID), we have to rely on the
device driver for isolation. The devices which are able to generate sub-
devices should either use their own on-device mechanisms or use the
platform features like Intel Scalable IOV to isolate the sub-devices.

Under above conditions, different sub-device from a same RID device
could be able to use different IOASID. This seems to means that we can't
support mixed mode where, for example, two RIDs share an iommu_group and
one (or both) of them have sub-devices.

AIUI, when we attach a "RID + SSID" to an IOASID, we should require that
the RID doesn't share the iommu_group with any other RID.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
