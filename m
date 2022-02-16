Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B1CC433EF
	for <iommu@archiver.kernel.org>; Wed, 16 Feb 2022 06:29:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA60640154;
	Wed, 16 Feb 2022 06:29:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oRjcpVhciZrp; Wed, 16 Feb 2022 06:29:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 500CC4010E;
	Wed, 16 Feb 2022 06:29:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DA21C0011;
	Wed, 16 Feb 2022 06:29:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE496C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 06:29:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C16A3415E2
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 06:29:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WGRm_24cLOXX for <iommu@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 06:29:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5BA09415E0
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 06:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644992976; x=1676528976;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=xhIOhZqbmXasqsL4PSTwgu2wa99Ybi4SJBWDqbME8bE=;
 b=Fk9SGiprp71N6RQgfyQE1RY97fgYWERmGbhQqkMbRTaAX7Hv2XoWqBis
 O684FoS4+I0oIiHNXUAL5xmtekSKp2MFxmeuL70AGhvY8KxyzUATkwQAg
 F1x9zZxWMcICteSY/QVz89tN/bDfiP0Lqi0aqkZKxRvmq+MGXehcr+D9Q
 nQfdU93dDisUL8bWwdL0RtAZhYgRS0bFEbdHR5NtjSgVTimfmgR8klkeK
 Ej+vcSW8MnoQX1bRG54th/ERfwz041G4yZHiTmg0/AllT67R0aDvhxO24
 glZxpkRPquAzaQzENX4YOURZtOPfo+H7y/90OFht9eV9fzNA3V9ieXJoZ Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="249366367"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; d="scan'208";a="249366367"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Feb 2022 22:29:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; d="scan'208";a="681371490"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 15 Feb 2022 22:29:29 -0800
Message-ID: <69f26767-66d6-12df-1754-45ee1932d513@linux.intel.com>
Date: Wed, 16 Feb 2022 14:28:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 3/8] iommu: Extend iommu_at[de]tach_device() for
 multi-device groups
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>
References: <20220106022053.2406748-1-baolu.lu@linux.intel.com>
 <20220106022053.2406748-4-baolu.lu@linux.intel.com>
 <Ygo/eCRFnraY01WA@8bytes.org> <20220214130313.GV4160@nvidia.com>
 <Ygppub+Wjq6mQEAX@8bytes.org> <08e90a61-8491-acf1-ab0f-f93f97366d24@arm.com>
 <20220214154626.GF4160@nvidia.com> <YgtrJVI9wGMFdPWk@8bytes.org>
 <20220215134744.GO4160@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220215134744.GO4160@nvidia.com>
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On 2/15/22 9:47 PM, Jason Gunthorpe via iommu wrote:
> On Tue, Feb 15, 2022 at 09:58:13AM +0100, Joerg Roedel wrote:
>> On Mon, Feb 14, 2022 at 11:46:26AM -0400, Jason Gunthorpe wrote:
>>> On Mon, Feb 14, 2022 at 03:18:31PM +0000, Robin Murphy wrote:
>>>
>>>> Arguably, iommu_attach_device() could be renamed something like
>>>> iommu_attach_group_for_dev(), since that's effectively the semantic that all
>>>> the existing API users want anyway (even VFIO at the high level - the group
>>>> is the means for the user to assign their GPU/NIC/whatever device to their
>>>> process, not the end in itself). That's just a lot more churn.
>>>
>>> Right
>>
>> Okay, good point. I can live with an iommu_attach_group_for_dev()
>> interface, it is still better than making iommu_attach_device() silently
>> operate on whole groups.
> 
> I think this is what Lu's series currently does, it just doesn't do
> the rename churn as Robin noted. Lu, why not add a note like Robin
> explained to the kdoc so it is clear this api impacts the whole group?

I feel that the debate here is not about API name, but how should
iommu_attach/detach_device() be implemented and used.

It seems everyone agrees that for device assignment (where the I/O
address is owned by the user-space application), the iommu_group-based
APIs should always be used. Otherwise, the isolation and protection are
not guaranteed.

For kernel DMA (where the I/O address space is owned by the kernel
drivers), the device driver oriented interface should meet below
expectations:

  - the concept of iommu_group should be transparent to the device
    drivers;
  - but internally, iommu core only allows a single domain to attach to
    a group.

If the device driver uses default domain, the above expectations are
naturally met. But when the driver wants to attach its own domain, the
problem arises.

This series tries to use the DMA ownership mechanism to solve this. The
devices drivers explicitly declare that

  - I know that the device I am driving shares the iommu_group with
    others;
  - Other device drivers with the same awareness can only be bound to the
    devices in the shared group;
  - We can sync with each other so that only a shared domain could be
    attached to the devices in the group.

Another proposal (as suggested by Joerg) is to introduce the concept of
"sub-group". An iommu group could have one or multiple sub-groups with
non-aliased devices sitting in different sub-groups and use different
domains.

Above are what I get so far. If there's any misunderstanding, please
help to correct.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
