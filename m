Return-Path: <SRS0=3Hz1=2H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBFAC2D0CD
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 16:46:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F20B21D7D
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 16:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oeb/ZN3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F20B21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A119386D6F;
	Tue, 17 Dec 2019 16:46:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cMX3AnE0lLl5; Tue, 17 Dec 2019 16:46:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 74886820D3;
	Tue, 17 Dec 2019 16:46:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59A92C1AE8;
	Tue, 17 Dec 2019 16:46:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EA98C077D
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 16:46:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4C51B86C34
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 16:46:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zWPY2SuQGJqC for <iommu@lists.linux-foundation.org>;
 Tue, 17 Dec 2019 16:46:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6EA9A820D3
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 16:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576601185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aKsNtbLIFJyPIxbIhkuqQwDdLTOvYVf+IcaJaDg+WqE=;
 b=Oeb/ZN3rBkmuzKXHZwq7klgJfPbEideHPVDz0UWz+gH7okkpPN7Cffepr/jmi9ifNQXu14
 4yVyZ38nJeYKUvZoyhZuP/wTxgws2yfvO6QrmgKW+iv0srRdflelPapk6zMOak9lHtUNvh
 bjrtxvuwA2Cpo1tBKN9nQOcyZty5tT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-LUxbjDeDN6Cb23G4hPtXJw-1; Tue, 17 Dec 2019 11:46:23 -0500
X-MC-Unique: LUxbjDeDN6Cb23G4hPtXJw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A25A8005B1;
 Tue, 17 Dec 2019 16:46:19 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 481785D9E1;
 Tue, 17 Dec 2019 16:46:15 +0000 (UTC)
Subject: Re: [PATCH v3 03/13] iommu/arm-smmu-v3: Support platform SSID
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
 <20191209180514.272727-4-jean-philippe@linaro.org>
 <e5b9a017-585a-5425-77bd-be40b86010e6@redhat.com>
 <20191217152108.GB2305883@myrica>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <d3ef7adf-4e9e-6b7f-c4eb-52a8f1eaa16c@redhat.com>
Date: Tue, 17 Dec 2019 17:46:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191217152108.GB2305883@myrica>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, guohanjun@huawei.com,
 will@kernel.org, linux-pci@vger.kernel.org, rjw@rjwysocki.net,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, sudeep.holla@arm.com, bhelgaas@google.com,
 zhangfei.gao@linaro.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

Hi Jean,

On 12/17/19 4:21 PM, Jean-Philippe Brucker wrote:
> Hi Eric,
> 
> On Tue, Dec 17, 2019 at 12:05:18PM +0100, Auger Eric wrote:
>>> +		fwspec = dev_iommu_fwspec_get(dev);
>>> +		if (!err && fwspec)
>>> +			of_property_read_u32(master_np, "pasid-num-bits",
>>> +					     &fwspec->num_pasid_bits);
>>> +	}
>> This patch dedicates to platform devices however I fail to understand,
>> at that stage, how/when do you retrieve/store the same max capability
>> for PCI devices?
> 
> For PCI devices, the max capability is only described by the PCIe PASID
> capability, not by firmware. Patch 13 deals with PCI by setting
> masted->ssid_bits from the PASID capability directly, ignoring
> fwspec->num_pasid_bits.

Get it now. thank you for the explanation.

Eric
> 
>> Besides,
>>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks!
> Jean
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
