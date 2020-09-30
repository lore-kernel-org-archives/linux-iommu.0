Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D26C4741F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 17:25:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 627D720754
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 17:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 627D720754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0B70B85085;
	Wed, 30 Sep 2020 17:25:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0WnfD46vz2c0; Wed, 30 Sep 2020 17:25:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8A87D85039;
	Wed, 30 Sep 2020 17:25:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E193C0890;
	Wed, 30 Sep 2020 17:25:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83606C016F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 17:25:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 67F63871B0
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 17:25:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 924ZPTTxuH1U for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 17:25:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3BCE88714A
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 17:25:38 +0000 (UTC)
IronPort-SDR: Y5iMKgKEDEKmkzOHPQ5BR8DI8ttoJDNn2iT0RZpXUXnNVf0PFmqT56sVvAhaUpfExSeeaEV7O3
 Iz7w2Qne8VNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="163359228"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; d="scan'208";a="163359228"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2020 10:25:37 -0700
IronPort-SDR: FK7/wIJBisXTMuj6iqUnpiUpF0sHZmEXgWujctvoBj/uFfZp+PCakKD8gDd4Smm5TFBZfQyr6i
 CR1IGgnmqLIQ==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; d="scan'208";a="308240091"
Received: from meghadey-mobl1.amr.corp.intel.com (HELO [10.255.88.197])
 ([10.255.88.197])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2020 10:25:34 -0700
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device MSI
To: Thomas Gleixner <tglx@linutronix.de>, Jason Gunthorpe <jgg@nvidia.com>
References: <20200826111628.794979401@linutronix.de>
 <10b5d933-f104-7699-341a-0afb16640d54@intel.com>
 <87v9fvix5f.fsf@nanos.tec.linutronix.de> <20200930114301.GD816047@nvidia.com>
 <87k0wbi94b.fsf@nanos.tec.linutronix.de>
From: "Dey, Megha" <megha.dey@intel.com>
Message-ID: <e07aa723-12cd-7eb7-392a-642f96b98f79@intel.com>
Date: Wed, 30 Sep 2020 10:25:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <87k0wbi94b.fsf@nanos.tec.linutronix.de>
Content-Language: en-US
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org, xen-devel@lists.xenproject.org,
 ravi.v.shankar@intel.com, Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jon Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Thomas/Jason,

On 9/30/2020 8:20 AM, Thomas Gleixner wrote:
> On Wed, Sep 30 2020 at 08:43, Jason Gunthorpe wrote:
>> On Wed, Sep 30, 2020 at 08:41:48AM +0200, Thomas Gleixner wrote:
>>> On Tue, Sep 29 2020 at 16:03, Megha Dey wrote:
>>>> On 8/26/2020 4:16 AM, Thomas Gleixner wrote:
>>>>> #9	is obviously just for the folks interested in IMS
>>>>>
>>>> I see that the tip tree (as of 9/29) has most of these patches but
>>>> notice that the DEV_MSI related patches
>>>>
>>>> haven't made it. I have tested the tip tree(x86/irq branch) with your
>>>> DEV_MSI infra patches and our IMS patches with the IDXD driver and was
>>> Your IMS patches? Why do you need something special again?

By IMS patches, I meant your IMS driver patch that was updated (as it 
was untested, it had some compile

errors and we removed the IMS_QUEUE parts) :

https://lore.kernel.org/lkml/160021246221.67751.16280230469654363209.stgit@djiang5-desk3.ch.intel.com/

and some iommu related changes required by IMS.

https://lore.kernel.org/lkml/160021246905.67751.1674517279122764758.stgit@djiang5-desk3.ch.intel.com/

The whole patchset can be found here:

https://lore.kernel.org/lkml/f4a085f1-f6de-2539-12fe-c7308d243a4a@intel.com/

It would be great if you could review the IMS patches :)

>>>
>>>> wondering if we should push out those patches as part of our patchset?
>>> As I don't have any hardware to test that, I was waiting for you and
>>> Jason to confirm that this actually works for the two different IMS
>>> implementations.
>> How urgently do you need this? The code looked good from what I
>> understood. It will be a while before we have all the parts to send an
>> actual patch though.
> I personally do not need it at all :) Megha might have different
> thoughts...

I have tested these patches and it works fine (I had to add a couple of 
EXPORT_SYMBOLS).

We were hoping to get IMS in the 5.10 merge window :)

>
>> We might be able to put together a mockup just to prove it
> If that makes Megha's stuff going that would of course be appreciated,
> but we can defer the IMS_QUEUE part for later. It's orthogonal to the
> IMS_ARRAY stuff.

In our patch series, we have removed the IMS_QUEUE stuff and retained 
only the IMS_ARRAY parts

as that was sufficient for us.

>
> Thanks,
>
>          tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
