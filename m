Return-Path: <SRS0=l9dJ=DG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2E4C4346E
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 07:20:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34DFA207C4
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 07:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlSt1VWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34DFA207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BED9F204FA;
	Tue, 29 Sep 2020 07:20:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7jttpPUVoyqr; Tue, 29 Sep 2020 07:20:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EAAAE20481;
	Tue, 29 Sep 2020 07:20:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D571AC0890;
	Tue, 29 Sep 2020 07:20:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87427C016F
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 07:20:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 762D086FC7
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 07:20:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mgAHTBXaTRtd for <iommu@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:20:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CDE2486FC5
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 07:20:47 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p4YPMWYaZn/NlSCV+4SJY1EF6+YsEiEQ6nhQ9wb6D5w=;
 b=FlSt1VWgLOvS6RShKYXZjoOvrTtxg1oPwbQf4UgfG0pYsN4NMFXjNK4TrsNeYbxOPHOdAj
 V0UTy/sBAJSgmmX7V7aYb0EIbOdtRcNgHH15AD6R77uDfO/k3+JtQDjY3tz796DYniB9i5
 0oQWzjMG3X4V1CuhxNaiDtyrWZ4ACYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-UoTOZ8xuPUSEUzduIvcDKQ-1; Tue, 29 Sep 2020 03:20:44 -0400
X-MC-Unique: UoTOZ8xuPUSEUzduIvcDKQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A32A9801F9A;
 Tue, 29 Sep 2020 07:20:42 +0000 (UTC)
Received: from [10.36.113.210] (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ADDB378815;
 Tue, 29 Sep 2020 07:20:37 +0000 (UTC)
Subject: Re: [RFC 2/3] iommu: Account for dma_mask and iommu aperture in IOVA
 reserved regions
To: Christoph Hellwig <hch@infradead.org>
References: <20200928195037.22654-1-eric.auger@redhat.com>
 <20200928195037.22654-3-eric.auger@redhat.com>
 <20200929060307.GA6564@infradead.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <35b5ff6b-1c6a-ced0-aeb0-6135b9fa26d5@redhat.com>
Date: Tue, 29 Sep 2020 09:20:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200929060307.GA6564@infradead.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: alex.williamson@redhat.com, jean-philippe.brucker@arm.com,
 dwmw2@infradead.org, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 eric.auger.pro@gmail.com
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

Hi Christoph,

On 9/29/20 8:03 AM, Christoph Hellwig wrote:
> On Mon, Sep 28, 2020 at 09:50:36PM +0200, Eric Auger wrote:
>> VFIO currently exposes the usable IOVA regions through the
>> VFIO_IOMMU_GET_INFO ioctl. However it fails to take into account
>> the dma_mask of the devices within the container. The top limit
>> currently is defined by the iommu aperture.
> 
> Can we take a step back here?  The dma_mask only has a meaning for
> the DMA API, and not the iommu API, it should have no relevance here.
> 
> More importantly if we are using vfio no dma_mask should be set to
> start with.

You will find more context in my reply to Alex.

Thanks

Eric
> 
>> +		if (geo.aperture_end < ULLONG_MAX && geo.aperture_end != geo.aperture_start) {
> 
> Please avoid pointlessly overlong lines.
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
