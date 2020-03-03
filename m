Return-Path: <SRS0=fiLh=4U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF18DC3F2D1
	for <iommu@archiver.kernel.org>; Tue,  3 Mar 2020 16:21:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8F032073D
	for <iommu@archiver.kernel.org>; Tue,  3 Mar 2020 16:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7IPmS+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F032073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 56B6D80A5E;
	Tue,  3 Mar 2020 16:21:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OCmaIJLmuyjx; Tue,  3 Mar 2020 16:21:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4099384D16;
	Tue,  3 Mar 2020 16:21:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2546EC1D89;
	Tue,  3 Mar 2020 16:21:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE393C1AE2
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 16:21:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BB13B20507
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 16:21:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tuIvQC-Jj773 for <iommu@lists.linux-foundation.org>;
 Tue,  3 Mar 2020 16:21:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by silver.osuosl.org (Postfix) with ESMTPS id 8014220502
 for <iommu@lists.linux-foundation.org>; Tue,  3 Mar 2020 16:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583252501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uXLTy0K7QJVZnARt6TsxatW+cz6I9HUr6tGiByFrAEw=;
 b=G7IPmS+j9he7BFMkrIUQ35ZPr0V2owqLAxtW4BkRFXSpklyPhUDuqKbYyEWkYFgWlFS+J+
 3XPlpvielPCqy5t05517H0DVFEgQrPKRcxDuZTvuYoMkLYyUcWWnhB5VrQFp6qA2ipNXXR
 HHh4T2GRegBF4LyLpYVAvENFxzQMIf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-hfMzhCJMMem1uyTrarRfig-1; Tue, 03 Mar 2020 11:21:37 -0500
X-MC-Unique: hfMzhCJMMem1uyTrarRfig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F41A92717;
 Tue,  3 Mar 2020 16:21:35 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2B7B19C7F;
 Tue,  3 Mar 2020 16:21:28 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
To: "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
 <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
 <20200303130155.GA13185@8bytes.org>
 <20200303084753-mutt-send-email-mst@kernel.org>
 <20200303155318.GA3954@8bytes.org>
 <20200303105523-mutt-send-email-mst@kernel.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <9d1ad38f-0335-814f-f0b7-48c5b1b71dcd@redhat.com>
Date: Tue, 3 Mar 2020 17:21:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200303105523-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 linux-pci@vger.kernel.org, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, bhelgaas@google.com,
 robin.murphy@arm.com
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

Hi Michael, Joerg,

On 3/3/20 5:09 PM, Michael S. Tsirkin wrote:
> On Tue, Mar 03, 2020 at 04:53:19PM +0100, Joerg Roedel wrote:
>> On Tue, Mar 03, 2020 at 09:00:05AM -0500, Michael S. Tsirkin wrote:
>>> Not necessarily. E.g. some power systems have neither.
>>> There are also systems looking to bypass ACPI e.g. for boot speed.
>>
>> If there is no firmware layer between the hardware and the OS the
>> necessary information the OS needs to run on the hardware is probably
>> hard-coded into the kernel?
> 
> No. It's coded into the hardware. Which might even be practical
> for bare-metal (e.g. on-board flash), but is very practical
> when the device is part of a hypervisor.
> 
>> In that case the same can be done with
>> virtio-iommu tolopology.
>>
>>> That sentence doesn't really answer the question, does it?
>>
>> To be more elaborate, putting this information into config space is a
>> layering violation. Hardware is never completly self-descriptive
> 
> 
> This "hardware" is actually part of hypervisor so there's no
> reason it can't be completely self-descriptive. It's specified
> by the same entity as the "firmware".

Yes in the QEMU case the machine code would fill this information as it
knows all the devices connected to the iommu. In the same way it would
generate the DT description or the ACPI tables
> 
>> and
>> that is why there is the firmware which provides the information about
>> the hardware to the OS in a generic way.
>>
>>> Frankly with platform specific interfaces like ACPI, virtio-iommu is
>>> much less compelling.  Describing topology as part of the device in a
>>> way that is first, portable, and second, is a good fit for hypervisors,
>>> is to me one of the main reasons virtio-iommu makes sense at all.
>>
>> Virtio-IOMMU makes sense in the first place because it is much faster
>> than emulating one of the hardware IOMMUs.
> 
> I don't see why it would be much faster. The interface isn't that
> different from command queues of VTD.

> 
>> And an ACPI table is also
>> portable to all ACPI platforms, same with device-tree.
>>
>> Regards,
>>
>> 	Joerg
> 
> Making ACPI meet the goals of embedded projects such as kata containers
> would be a gigantic task with huge stability implications.  By
> comparison this 400-line parser is well contained and does the job.  I
> didn't yet see compelling reasons not to merge this, but I'll be
> interested to see some more specific concerns.
> 
> 
Thanks

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
